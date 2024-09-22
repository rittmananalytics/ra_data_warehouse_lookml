  view: project_engagements {
    derived_table: {
      sql: WITH
  projects AS (
  SELECT
    company_name,
    project_delivery_start_ts,
    timesheet_project_pk,
    company_fk,
    project_name,
    project_code,
    project_delivery_end_ts,
    project_is_billable,
    project_is_active,
    total_project_fee_recognized_revenue,
    total_recognized_revenue_per_working_day,
    total_business_days,
    project_hourly_rate,
    project_is_fixed_fee,
    project_fee_amount
  FROM
    `ra-development.analytics.timesheet_projects_dim` p
  LEFT JOIN
    `ra-development.analytics.companies_dim` c
  ON
    p.company_fk = c.company_pk
  WHERE
    project_is_billable),
  project_invoicing AS (
  SELECT
    timesheet_project_fk,
    SUM(total_gbp_amount) AS total_project_billed_amount_gbp
  FROM
    `ra-development.analytics.invoices_fact`
  WHERE
    invoice_status NOT IN ('Voided',
      'Void')
  GROUP BY
    1 ),
  project_timesheets AS (
  SELECT
    timesheet_project_fk,
    SUM(timesheet_hours_billed) total_timesheet_hours_billed
  FROM
    `ra-development.analytics.timesheets_fact`
  WHERE
    timesheet_is_billable
  GROUP BY
    1 ),
  projects_by_engagement AS (
  SELECT
    p.company_name,
    CASE
    -- Case for strings with two dashes, return the first two parts with the dash
      WHEN REGEXP_CONTAINS(project_code, r'^[A-Za-z]+-[A-Za-z0-9]+-\d+$') THEN REGEXP_EXTRACT(project_code, r'^([A-Za-z]+-[A-Za-z0-9]+)-\d+$')
    -- Case for strings with no dashes but alphanumeric, return the alphanumeric part
      WHEN REGEXP_CONTAINS(project_code, r'^\d*[A-Za-z]+\d+$') THEN REGEXP_EXTRACT(project_code, r'^(\d*[A-Za-z]+)\d+$')
      WHEN REGEXP_CONTAINS(project_code, r'^[A-Za-z]+\d+[a-z]$') THEN REGEXP_EXTRACT(project_code, r'^([A-Za-z]+)\d+[a-z]$')
    -- Default case, return NULL if it doesn't match any pattern
      ELSE project_code
  END
    AS engagement_code,
    p.* EXCEPT (company_name,
      total_project_fee_recognized_revenue,
      total_recognized_revenue_per_working_day),
    COALESCE(total_project_fee_recognized_revenue,total_project_billed_amount_gbp,project_hourly_rate*total_timesheet_hours_billed) AS total_project_fee_recognized_revenue,
    COALESCE(total_recognized_revenue_per_working_day,SAFE_DIVIDE(total_project_billed_amount_gbp,total_business_days),SAFE_DIVIDE(project_hourly_rate*total_timesheet_hours_billed,total_business_days)) AS total_recognized_revenue_per_working_day
  FROM
    projects p
  LEFT JOIN
    project_invoicing i
  ON
    p.timesheet_project_pk = i.timesheet_project_fk
  LEFT JOIN
    project_timesheets t
  ON
    p.timesheet_project_pk = t.timesheet_project_fk
  WHERE
    p.project_code != 'PROVISIONAL'
    AND NOT (TIMESTAMP(project_delivery_end_ts) < CURRENT_TIMESTAMP
      AND total_timesheet_hours_billed IS NULL)
    AND company_name != 'Rittman Analytics Internal'),
  date_series AS (
  SELECT
    timesheet_project_pk,
    DATE_TRUNC(date, MONTH) AS month_start,
    DATE_TRUNC(date, MONTH) + INTERVAL 1 MONTH - INTERVAL 1 DAY AS month_end,
  FROM
    projects_by_engagement,
    UNNEST(GENERATE_DATE_ARRAY( DATE(project_delivery_start_ts), DATE(project_delivery_end_ts), INTERVAL 1 DAY )) AS date
  GROUP BY
    1,
    2,
    3 ),
  monthly_business_days AS (
  SELECT
    d.timesheet_project_pk,
    engagement_code,
    d.month_start,
    d.month_end,
    p.project_name,
    p.company_name,
    p.project_delivery_start_ts,
    p.project_delivery_end_ts,
    p.total_recognized_revenue_per_working_day,
    COUNT(DISTINCT
    IF
      (EXTRACT(DAYOFWEEK
        FROM
          date) NOT IN (1,
          7)
        AND date >= DATE(p.project_delivery_start_ts)
        AND date <= DATE(p.project_delivery_end_ts), date, NULL)) AS business_days_in_month
  FROM
    date_series d
  JOIN
    projects_by_engagement p
  ON
    d.timesheet_project_pk = p.timesheet_project_pk
  LEFT JOIN
    UNNEST(GENERATE_DATE_ARRAY(DATE(d.month_start), DATE(d.month_end), INTERVAL 1 DAY)) AS date
  GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9 ),
  projects_by_engagement_monthly AS (
  SELECT
    company_name,
    timesheet_project_pk,
    project_name,
    engagement_code,
    month_start,
    project_delivery_start_ts,
    project_delivery_end_ts,
    business_days_in_month,
    total_recognized_revenue_per_working_day,
    ROUND(business_days_in_month * total_recognized_revenue_per_working_day, 2) AS monthly_recognized_revenue
  FROM
    monthly_business_days),
engagement_monthly_revenue as (
SELECT
  company_name,
  engagement_code,
  month_start,
  sum(monthly_recognized_revenue) as monthly_recognized_revenue
FROM
  projects_by_engagement_monthly
GROUP BY 1,2,3
  )
  SELECT
  company_name,
  engagement_code,
  month_start,
    SUM(monthly_recognized_revenue) OVER (PARTITION BY engagement_code)-COALESCE(SUM(monthly_recognized_revenue) OVER (PARTITION BY engagement_code ORDER BY month_start ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING ),0) AS total_engagement_revenue_remaining
  FROM
  engagement_monthly_revenue;;
    }



    dimension_group: booking {
      type: time
      timeframes: [month,month_num,year]
      datatype: date
      sql: ${TABLE}.month_start ;;
    }

    dimension: company_name {
      type: string
      sql: ${TABLE}.company_name ;;
    }



    dimension: engagement_code {
      type: string
      sql: ${TABLE}.engagement_code ;;
    }

    dimension: pk {
      type: string
      primary_key: yes
      sql: ${engagement_code},${booking_month} ;;
    }

    dimension: total_engagement_revenue_remaining {
      type: number
      sql: ${TABLE}.total_engagement_revenue_remaining ;;
    }

    measure: booked_revenue {
      type: sum
      value_format_name: gbp_0
      sql: ${total_engagement_revenue_remaining} ;;
    }

    set: detail {
      fields: [
        booking_month,
        company_name,
        engagement_code,
        total_engagement_revenue_remaining
      ]
    }
  }
