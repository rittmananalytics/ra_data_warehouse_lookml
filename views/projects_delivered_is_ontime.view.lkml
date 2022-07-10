view: projects_delivered_is_ontime {
  derived_table: {
    sql: SELECT
          --companies_dim_company_name,
          projects_delivered_timesheet_project_pk,
          --projects_delivered_project_name,
          --projects_delivered_project_delivery_start_ts_date,
          --projects_delivered_project_delivery_end_ts_date,
          --projects_delivered_project_delivery_end_ts_month,
          --projects_invoiced_invoice_date,
              --(DATE(mf0b5f3c7bbfa__project_timesheets_last_timesheet_billing_date)) AS project_timesheets_last_timesheet_billing_date,
          date_diff(date(mf0b5f3c7bbfa__project_timesheets_last_timesheet_billing_date),projects_delivered_project_delivery_end_ts_date,DAY) <= 0 as is_ontime_project
      FROM
          (SELECT
                  projects_delivered.timesheet_project_pk  AS projects_delivered_timesheet_project_pk,
                      (DATE(timestamp(projects_delivered.project_delivery_end_ts) )) AS projects_delivered_project_delivery_end_ts_date,
                      (FORMAT_TIMESTAMP('%Y-%m', timestamp(projects_delivered.project_delivery_end_ts) )) AS projects_delivered_project_delivery_end_ts_month,
                      (DATE(timestamp(projects_delivered.project_delivery_start_ts) )) AS projects_delivered_project_delivery_start_ts_date,
                  projects_delivered.project_name  AS projects_delivered_project_name,
                  case when companies_dim.company_name = 'indexlabs.co.uk' then 'Football Index' else companies_dim.company_name end AS companies_dim_company_name,
                      (DATE(projects_invoiced.invoice_sent_at_ts )) AS projects_invoiced_invoice_date,
                  MAX(project_timesheets.timesheet_billing_date ) AS mf0b5f3c7bbfa__project_timesheets_last_timesheet_billing_date,
                  COUNT(DISTINCT companies_dim.company_pk ) AS companies_dim_count,
                  ROUND(COALESCE(CAST( ( SUM(DISTINCT (CAST(ROUND(COALESCE( coalesce(project_timesheets.timesheet_hours_billed,0)  ,0)*(1/1000*1.0), 9) AS NUMERIC) + (cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheets.timesheet_pk   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheets.timesheet_pk   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001 )) - SUM(DISTINCT (cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheets.timesheet_pk   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheets.timesheet_pk   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001) )  / (1/1000*1.0) AS FLOAT64), 0), 6) AS project_timesheets_total_timesheet_hours_billed
              FROM `analytics.timesheet_projects_dim`
           AS projects_delivered
      LEFT JOIN `analytics.timesheets_fact`
           AS project_timesheets ON projects_delivered.timesheet_project_pk = project_timesheets.timesheet_project_pk
      LEFT JOIN `analytics.companies_dim` AS companies_dim ON projects_delivered.company_pk = companies_dim.company_pk
      LEFT JOIN `analytics.invoices_fact`
           AS projects_invoiced ON projects_delivered.timesheet_project_pk = projects_invoiced.timesheet_project_pk

      GROUP BY
      1,
      2,
      3,
      4,
      5,
      6,
      7
      HAVING project_timesheets_total_timesheet_hours_billed > 0) AS t3
      ;;
  }



  dimension: timesheet_project_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.projects_delivered_timesheet_project_pk ;;
  }

  dimension: is_ontime_project {
    group_label: "   Project Details"

    type: yesno
    sql: ${TABLE}.is_ontime_project ;;
  }

  measure: count_ontime_timesheet_projects {
    type: count_distinct
    sql: ${timesheet_project_pk} ;;
    filters: [is_ontime_project: "Yes"]

  }


}
