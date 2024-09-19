view: timesheet_project_monthly_forecast_billing_fact {
    derived_table: {
      sql: WITH projects AS (
    SELECT
        p.timesheet_project_pk,
        c.company_name,
        DATE(p.project_delivery_start_ts) AS project_start_date,
        DATE(p.project_delivery_end_ts) AS project_end_date,
        p.total_business_days,
        p.total_recognized_revenue_per_working_day,
        -- Total project revenue
        p.total_business_days * p.total_recognized_revenue_per_working_day AS total_project_revenue,
        -- Total project duration in days
        DATE_DIFF(DATE(p.project_delivery_end_ts), DATE(p.project_delivery_start_ts), DAY) + 1 AS total_project_duration_days
    FROM `ra-development.analytics.timesheet_projects_dim` p
    LEFT JOIN `ra-development.analytics.companies_dim` c
        ON p.company_fk = c.company_pk
),
date_spine AS (
    SELECT
        DATE_TRUNC(month_date, MONTH) AS month_date
    FROM UNNEST(GENERATE_DATE_ARRAY('2018-01-01', '2024-12-31', INTERVAL 1 MONTH)) AS month_date
),
project_months AS (
    SELECT
        p.timesheet_project_pk,
        p.company_name,
        p.project_start_date,
        p.project_end_date,
        p.total_business_days,
        p.total_recognized_revenue_per_working_day,
        p.total_project_revenue,
        p.total_project_duration_days,
        d.month_date
    FROM projects p
    CROSS JOIN date_spine d
    WHERE p.project_start_date <= d.month_date AND d.month_date <= p.project_end_date
),
project_revenues_step1 AS (
    SELECT
        pm.*,
        -- Calculate days elapsed up to the end of the previous month
        LEAST(
            GREATEST(
                DATE_DIFF(DATE_SUB(pm.month_date, INTERVAL 1 DAY), pm.project_start_date, DAY) + 1,
                0
            ),
            pm.total_project_duration_days
        ) AS days_elapsed
    FROM project_months pm
),
project_revenues_step2 AS (
    SELECT
        prs1.*,
        -- Calculate days remaining from the current month onward
        prs1.total_project_duration_days - prs1.days_elapsed AS days_remaining
    FROM project_revenues_step1 prs1
),
project_revenues AS (
    SELECT
        prs2.*,
        -- Calculate remaining unbilled revenue from the current month onward
        (prs2.total_project_revenue * prs2.days_remaining) / prs2.total_project_duration_days AS remaining_unbilled_revenue
    FROM project_revenues_step2 prs2
),
filtered_project_revenues AS (
    SELECT
        month_date,
        company_name,
        remaining_unbilled_revenue
    FROM project_revenues
    WHERE remaining_unbilled_revenue > 0
)
SELECT
    company_name,
    month_date,
    SUM(remaining_unbilled_revenue) AS total_remaining_unbilled_revenue
FROM filtered_project_revenues
GROUP BY company_name, month_date

 ;;
    }



    dimension_group: forecast {
      timeframes: [month, month_num,year]
      type: time
      datatype: timestamp
      sql: timestamp(${TABLE}.month_date) ;;
    }

    dimension: company_name {
      type: string
      sql: ${TABLE}.company_name ;;
    }

    dimension: remaining_unbilled_revenue {
      type: number
      hidden: yes
      sql: ${TABLE}.remaining_unbilled_revenue ;;
    }

    measure: total_unbilled_revenue {
      type: sum
      value_format_name: gbp_0
      sql: ${remaining_unbilled_revenue} ;;
    }

    dimension: pk {
      type: string
      primary_key: yes
      hidden: yes
      sql: concat(${forecast_month},${company_name});;
    }
  }
