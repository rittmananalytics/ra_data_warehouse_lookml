view: simulated_daily_timesheet_billing_target {
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
      final as (
        select
          ct.calendar_date,
          round(s.target / extract(day from last_day(ct.calendar_date))) as daily_target
        from
          monthly_targets as s
        cross join
          calendar_table as ct
        where
          format_date('%Y-%m', date(ct.calendar_date)) = format_date('%Y-%m', date(s.target_month))
      )
      select * from final
       ;;
  }



  dimension_group: calendar_date {
    hidden: yes
    type: time
    timeframes: [date]
    sql: ${TABLE}.calendar_date ;;
  }

  dimension: pk {
    type: date
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.pk ;;

  }

  dimension: daily_target {
    hidden: yes

    type: number
    sql: ${TABLE}.daily_target ;;
  }

  measure: target_timesheet_hours_billed {
    type: sum
    value_format_name: decimal_0
    sql: ${daily_target} ;;
  }


}
