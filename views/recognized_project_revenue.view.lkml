view: recognized_project_revenue {

    derived_table: {
      sql: select * from `ra-development.analytics.recognized_revenue_fact;;
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
