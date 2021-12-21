view: project_metrics {
  derived_table: {
    sql: with stats as (SELECT
          companies_dim.company_pk  AS company_pk,
          project_timesheet_projects.project_code  AS project_code,
              project_timesheets.timesheet_billing_date  AS timesheet_billing_month,
          case when companies_dim.company_name = 'indexlabs.co.uk' then 'Football Index' else companies_dim.company_name end AS company_name,
          project_timesheet_projects.project_name  AS project_name,
          ROUND(COALESCE(CAST( ( SUM(DISTINCT (CAST(ROUND(COALESCE( case
                    when  project_timesheet_projects.project_fee_amount   = 7000 and ( case when companies_dim.company_name = 'indexlabs.co.uk' then 'Football Index' else companies_dim.company_name end ) like '%Ageras%' then 6000
                    when  project_timesheet_projects.project_fee_amount   = 7000 and ( case when companies_dim.company_name = 'indexlabs.co.uk' then 'Football Index' else companies_dim.company_name end ) not like '%Ageras%' then 5000
                    when  project_timesheet_projects.project_fee_amount   = 5500 then 4000
                    when  project_timesheet_projects.project_fee_amount   = 5800 then 5000
                    when  project_timesheet_projects.project_fee_amount   = 13620 then 9900
                    when  project_timesheet_projects.project_fee_amount   = 9625 then 7000
                    when  project_timesheet_projects.project_fee_amount   = 8250 then 7000
                    when  project_timesheet_projects.project_code   like '%THR%' or  project_timesheet_projects.project_code   like "%REV%" then  project_timesheet_projects.project_fee_amount   * .75
                    else  project_timesheet_projects.project_fee_amount   end ,0)*(1/1000*1.0), 9) AS NUMERIC) + (cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheet_projects.timesheet_project_pk   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheet_projects.timesheet_project_pk   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001 )) - SUM(DISTINCT (cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheet_projects.timesheet_project_pk   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheet_projects.timesheet_project_pk   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001) )  / (1/1000*1.0) AS FLOAT64), 0), 6) AS total_project_fee_amount,
          COUNT(DISTINCT project_timesheet_projects.timesheet_project_pk ) AS count_timesheet_projects,
          COUNT(DISTINCT project_timesheet_users.contact_pk ) AS count_contacts,
          ROUND(COALESCE(CAST( ( SUM(DISTINCT (CAST(ROUND(COALESCE( project_timesheets.timesheet_hours_billed * coalesce(case when project_timesheets.timesheet_billable_hourly_cost_amount > 60 then 32 else project_timesheets.timesheet_billable_hourly_cost_amount end,25)  ,0)*(1/1000*1.0), 9) AS NUMERIC) + (cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheets.timesheet_pk   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheets.timesheet_pk   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001 )) - SUM(DISTINCT (cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheets.timesheet_pk   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheets.timesheet_pk   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001) )  / (1/1000*1.0) AS FLOAT64), 0), 6) AS total_timesheet_cost_amount,
          ROUND(COALESCE(CAST( ( SUM(DISTINCT (CAST(ROUND(COALESCE( project_timesheets.timesheet_hours_billed  ,0)*(1/1000*1.0), 9) AS NUMERIC) + (cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheets.timesheet_pk   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheets.timesheet_pk   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001 )) - SUM(DISTINCT (cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheets.timesheet_pk   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheets.timesheet_pk   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001) )  / (1/1000*1.0) AS FLOAT64), 0), 6) AS total_timesheet_hours_billed,
          ROUND(COALESCE(CAST( ( SUM(DISTINCT (CAST(ROUND(COALESCE( project_timesheet_projects.project_budget_amount  ,0)*(1/1000*1.0), 9) AS NUMERIC) + (cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheet_projects.timesheet_project_pk   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheet_projects.timesheet_project_pk   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001 )) - SUM(DISTINCT (cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheet_projects.timesheet_project_pk   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheet_projects.timesheet_project_pk   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001) )  / (1/1000*1.0) AS FLOAT64), 0), 6) AS project_hours_budget
      FROM `analytics.companies_dim` AS companies_dim
      LEFT JOIN `analytics.timesheet_projects_dim`
           AS projects_delivered ON companies_dim.company_pk = projects_delivered.company_pk
      LEFT JOIN `analytics.timesheets_fact`
           AS project_timesheets ON projects_delivered.timesheet_project_pk = project_timesheets.timesheet_project_pk
      LEFT JOIN `analytics.timesheet_projects_dim`
           AS project_timesheet_projects ON project_timesheets.timesheet_project_pk = project_timesheet_projects.timesheet_project_pk
      LEFT JOIN contacts_dim AS project_timesheet_users ON project_timesheets.contact_pk  = project_timesheet_users.contact_pk
      where (project_timesheet_projects.project_fee_amount ) > 0
      GROUP BY
          1,
          2,
          3,
          4,
          5)
      select *,
            row_number() over (partition by company_pk) as project_seq,
            (total_project_fee_amount - total_timesheet_cost_amount)/total_project_fee_amount as project_margin_pct,
            safe_divide(total_timesheet_hours_billed,project_hours_budget) as project_hours_billed_pct

      from stats
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: company_pk {
    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension: project_code {
    type: string
    sql: ${TABLE}.project_code ;;
  }

  dimension_group: timesheet_billing {
    type: time
    timeframes: [year,month,month_num,quarter_of_year,quarter]
    sql: ${TABLE}.timesheet_billing_month ;;
  }

  dimension: company_name {
    type: string
    sql: ${TABLE}.company_name ;;
  }

  dimension: project_name {
    type: string
    sql: ${TABLE}.project_name ;;
  }

  dimension: total_project_fee_amount {
    type: number
    sql: ${TABLE}.total_project_fee_amount ;;
  }

  dimension: count_timesheet_projects {
    type: number
    sql: ${TABLE}.count_timesheet_projects ;;
  }

  dimension: count_contacts {
    type: number
    sql: ${TABLE}.count_contacts ;;
  }

  dimension: total_timesheet_cost_amount {
    type: number
    sql: ${TABLE}.total_timesheet_cost_amount ;;
  }

  dimension: total_timesheet_hours_billed {
    type: number
    sql: ${TABLE}.total_timesheet_hours_billed ;;
  }

  dimension: project_hours_budget {
    type: number
    sql: ${TABLE}.project_hours_budget ;;
  }

  dimension: project_seq {
    type: number
    sql: ${TABLE}.project_seq ;;
  }

  dimension: project_margin_pct {
    type: number
    sql: ${TABLE}.project_margin_pct ;;
  }

  dimension: project_hours_billed_pct {
    type: number
    sql: ${TABLE}.project_hours_billed_pct ;;
  }

  set: detail {
    fields: [
      company_pk,
      project_code,
      timesheet_billing_month,
      company_name,
      project_name,
      total_project_fee_amount,
      count_timesheet_projects,
      count_contacts,
      total_timesheet_cost_amount,
      total_timesheet_hours_billed,
      project_hours_budget,
      project_seq,
      project_margin_pct,
      project_hours_billed_pct
    ]
  }
}
