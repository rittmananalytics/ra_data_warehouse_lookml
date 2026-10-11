view: project_engagements {
  sql_table_name: `ra-development.analytics.timesheet_project_engagements_monthly_revenue_fact` ;;

  dimension: company_name {
    type: string
    sql: ${TABLE}.company_name ;;
  }

  dimension: engagement_code {
    type: string
    sql: ${TABLE}.engagement_code ;;
  }

  dimension: pk {
    primary_key: yes
    sql: concat(${engagement_code},${booking_month}) ;;
  }

  dimension: total_engagement_revenue_remaining {
    type: number
    sql: ${TABLE}.total_engagement_revenue_remaining ;;
  }

  dimension_group: booking {
    type: time
    timeframes: [raw, date, month, year, month_num]
    datatype: date
    sql: ${TABLE}.month_start ;;
  }

  measure: booked_revenue {
    type: sum
    value_format_name: gbp_0
    sql: ${total_engagement_revenue_remaining} ;;
  }
}
