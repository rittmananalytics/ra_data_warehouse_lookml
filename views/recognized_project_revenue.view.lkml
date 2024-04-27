view: recognized_project_revenue {

    derived_table: {
      sql: with projects as (SELECT timesheet_project_pk, project_delivery_start_ts, project_delivery_end_ts, project_hourly_rate, project_is_fixed_fee,project_is_billable, total_business_days, total_business_days_burnt, total_business_days_pct_left, project_fee_amount,total_recognized_revenue_per_working_day, total_project_fee_recognized_revenue FROM `ra-development.analytics.timesheet_projects_dim`
              where project_is_billable
              and project_code not like '%GRAVITAS%'
              order by project_delivery_start_ts desc),
              timesheets as (select timesheet_project_fk, timesheet_billing_date,sum(timesheet_hours_billed) as total_hours_billed
                                      from `ra-development.analytics.timesheets_fact`
                                      group by 1,2),
              days as (select *
              from UNNEST(GENERATE_DATE_ARRAY('2015-10-01', current_date(), INTERVAL 1 DAY)) AS day_date
              where extract(dayofweek from day_date) between 2 and 6)
              select day_date,
              case when project_is_fixed_fee then total_recognized_revenue_per_working_day
              else project_hourly_rate * total_hours_billed end as total_recognized_revenue_per_working_day, project_hourly_rate, total_hours_billed, timesheet_project_pk
              from projects p
              join days d on d.day_date between date(p.project_delivery_start_ts) and date(p.project_delivery_end_ts)
              left join timesheets t
              on d.day_date = date(t.timesheet_billing_date)
              and p.timesheet_project_pk = t.timesheet_project_fk;;
    }



    dimension_group: day_date {
      type: time
      timeframes: [date,raw,day_of_month,day_of_year,week,week_of_year,month,month_num,quarter,quarter_of_year,year]
      datatype: date
      sql: date(${TABLE}.day_date) ;;
    }

    dimension: pk {
      type: string
      hidden: yes
      primary_key: yes
      sql: concat(date(${TABLE}.day_date),${timesheet_project_pk}) ;;
    }

    dimension: total_recognized_revenue_per_working_day {
      type: number
      hidden: yes
      sql: ${TABLE}.total_recognized_revenue_per_working_day ;;
    }

    measure: total_hours_billed {
      type: sum
      hidden: yes
      sql: ${TABLE}.total_hours_billed ;;
    }

  dimension: project_hourly_rate {
    type: number
    hidden: yes
    sql: ${TABLE}.project_hourly_rate ;;
  }

    measure: total_recognised_revenue_gbp {
      type: sum
      value_format_name: gbp_0
      sql: ${total_recognized_revenue_per_working_day} ;;
    }

    dimension: timesheet_project_pk {
      type: string
      hidden: yes
      sql: ${TABLE}.timesheet_project_pk ;;
    }


  }
