view: project_billing_history {
    derived_table: {
      sql: WITH projects AS (
          SELECT
              timesheet_project_pk,
              project_name,
              DATE(project_delivery_start_ts) AS project_start_date,
              DATE(project_delivery_end_ts) AS project_end_date,
              total_business_days,
              total_recognized_revenue_per_working_day,
              total_business_days * total_recognized_revenue_per_working_day AS total_project_revenue,
              DATE_DIFF(DATE(project_delivery_end_ts), DATE(project_delivery_start_ts), DAY) + 1 AS total_project_duration_days
          FROM `ra-development.analytics.timesheet_projects_dim`
      ),
      date_spine AS (
          SELECT
              DATE_TRUNC(month_date, MONTH) AS month_date
          FROM UNNEST(GENERATE_DATE_ARRAY('2018-01-01', '2024-12-31', INTERVAL 1 MONTH)) AS month_date
      ),
      project_months AS (
          SELECT
              p.*,
              d.month_date,
              -- Calculate the number of days elapsed from the project start date up to the end of the previous month
              LEAST(
                  GREATEST(
                      DATE_DIFF(DATE_SUB(d.month_date, INTERVAL 1 DAY), p.project_start_date, DAY) + 1,
                      0
                  ),
                  p.total_project_duration_days
              ) AS days_elapsed
          FROM projects p
          CROSS JOIN date_spine d
          WHERE p.project_start_date <= d.month_date
      ),
      project_revenues_step1 AS (
          SELECT
              pm.*,
              -- Calculate business days elapsed up to the current month
              (pm.total_business_days * pm.days_elapsed) / pm.total_project_duration_days AS business_days_elapsed
          FROM project_months pm
      ),
      project_revenues AS (
          SELECT
              prs1.*,
              -- Calculate revenue recognized up to the current month
              (prs1.total_recognized_revenue_per_working_day * prs1.business_days_elapsed) AS revenue_recognized,
              -- Calculate remaining unbilled revenue
              prs1.total_project_revenue - (prs1.total_recognized_revenue_per_working_day * prs1.business_days_elapsed) AS remaining_unbilled_revenue
          FROM project_revenues_step1 prs1
      ),
      filtered_project_revenues AS (
          SELECT
              month_date,
              project_name,
              remaining_unbilled_revenue
          FROM project_revenues
          WHERE remaining_unbilled_revenue > 0
      )
      SELECT
          month_date,
          project_name,
          remaining_unbilled_revenue
      FROM filtered_project_revenues
      ORDER BY month_date, project_name ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: month_date {
      type: date
      datatype: date
      sql: ${TABLE}.month_date ;;
    }

    dimension: project_name {
      type: string
      sql: ${TABLE}.project_name ;;
    }

    dimension: remaining_unbilled_revenue {
      type: number
      sql: ${TABLE}.remaining_unbilled_revenue ;;
    }

    set: detail {
      fields: [
        month_date,
        project_name,
        remaining_unbilled_revenue
      ]
    }
  }
