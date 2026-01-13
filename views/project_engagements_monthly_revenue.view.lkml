  view: project_engagements {
    sql_table_name: ra-development.analytics.timesheet_project_engagements_monthly_revenue_fact;;




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
      sql: concat(${engagement_code},${booking_month}) ;;
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
