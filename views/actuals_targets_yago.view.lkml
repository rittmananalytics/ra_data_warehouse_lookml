view: actuals_targets_yago {
  derived_table: {
    sql: with monthly_targets as (
      select 900 as target, '2021-01-01' as target_month
      union all
      select 900 as target, '2021-02-01' as target_month
      union all
      select 900 as target, '2021-03-01' as target_month
      union all
      select 900 as target, '2021-04-01' as target_month
      union all
      select 900 as target, '2021-05-01' as target_month
      union all
      select 900 as target, '2021-06-01' as target_month
      union all
      select 900 as target, '2021-07-01' as target_month
      union all
      select 900 as target, '2021-08-01' as target_month
      union all
      select 900 as target, '2021-09-01' as target_month
      union all
      select 900 as target, '2021-01-10' as target_month
      union all
      select 900 as target, '2021-01-11' as target_month
      union all
      select 900 as target, '2021-01-12' as target_month
      union all
      select 600 as target, '2020-01-01' as target_month
      union all
      select 600 as target, '2020-02-01' as target_month
      union all
      select 600 as target, '2020-03-01' as target_month
      union all
      select 600 as target, '2020-04-01' as target_month
      union all
      select 600 as target, '2020-05-01' as target_month
      union all
      select 600 as target, '2020-06-01' as target_month
      union all
      select 600 as target, '2020-07-01' as target_month
      union all
      select 600 as target, '2020-08-01' as target_month
      union all
      select 600 as target, '2020-09-01' as target_month
      union all
      select 600 as target, '2020-01-10' as target_month
      union all
      select 600 as target, '2020-01-11' as target_month
      union all
      select 600 as target, '2020-01-12' as target_month),
        calendar_table as (
        select
          calendar_date
        from
          unnest(generate_date_array('2020-01-01', '2021-12-31', interval 1 day)) as calendar_date
      ),
      daily_targets as (
        select
          ct.calendar_date,
          round(s.target / extract(day from last_day(ct.calendar_date))) as daily_target
        from
          monthly_targets as s
        cross join
          calendar_table as ct
        where
          format_date('%Y-%m', date(ct.calendar_date)) = format_date('%Y-%m', date(s.target_month))
      ),
      daily_actuals as (
      SELECT
          (DATE(project_timesheets.timesheet_billing_date )) AS calendar_date,
          COALESCE(SUM(project_timesheets.timesheet_hours_billed ), 0) AS daily_actual
      FROM `analytics.companies_dim` AS companies_dim
      LEFT JOIN `analytics.timesheet_projects_dim`
           AS projects_delivered ON companies_dim.company_pk = projects_delivered.company_pk
      LEFT JOIN `analytics.timesheets_fact`
           AS project_timesheets ON projects_delivered.timesheet_project_pk = project_timesheets.timesheet_project_pk
      GROUP BY
          1
      )
      select t.calendar_date,
             t.daily_target,
             a.daily_actual,
             ty.daily_target as daily_target_yago,
             ay.daily_actual as daily_actual_yago,
             tm.daily_target as daily_target_mago,
             am.daily_actual as daily_actual_mago
      from daily_targets t
      join daily_actuals a
      on t.calendar_date = a.calendar_date
      join daily_targets ty
      on t.calendar_date = date_sub(ty.calendar_date,interval 1 year)
      join daily_actuals ay
      on t.calendar_date = date_sub(ay.calendar_date,interval 1 year)
      join daily_targets tm
      on t.calendar_date = date_sub(tm.calendar_date,interval 1 month)
      join daily_actuals am
      on t.calendar_date = date_sub(am.calendar_date,interval 1 month)
      order by 1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: calendar_date {
    primary_key: yes
    type: date
    datatype: date
    sql: ${TABLE}.calendar_date ;;
  }

  dimension: daily_target {
    type: number
    sql: ${TABLE}.daily_target ;;
  }

  dimension: daily_actual {
    type: number
    sql: ${TABLE}.daily_actual ;;
  }

  dimension: daily_target_yago {
    type: number
    sql: ${TABLE}.daily_target_yago ;;
  }

  dimension: daily_actual_yago {
    type: number
    sql: ${TABLE}.daily_actual_yago ;;
  }

  dimension: daily_target_mago {
    type: number
    sql: ${TABLE}.daily_target_mago ;;
  }

  dimension: daily_actual_mago {
    type: number
    sql: ${TABLE}.daily_actual_mago ;;
  }

  set: detail {
    fields: [
      calendar_date,
      daily_target,
      daily_actual,
      daily_target_yago,
      daily_actual_yago,
      daily_target_mago,
      daily_actual_mago
    ]
  }
}
