view: revenue_and_forecast {
  sql_table_name: `ra-development.analytics_seed.revenue_and_forecast` ;;

  dimension: actual_net_margin {
    type: number
    value_format_name: percent_2
    sql: ${forecast_net_profit} ;;
  }

  dimension: booked_and_forecast_revenue {
    type: number
    value_format_name: gbp_0
    sql: ${TABLE}.booked_and_forecast ;;
  }

  dimension: booked_revenue {
    type: number
    value_format_name: gbp_0
    sql: ${TABLE}.booked ;;
  }

  dimension: delivery_costs {
    type: number
    value_format_name: gbp_0
    sql: ${TABLE}.delivery_costs ;;
  }

  dimension: dividends {
    type: number
    value_format_name: gbp_0
    sql: ${TABLE}.dividends ;;
  }

  dimension: forecast_net_profit {
    type: number
    value_format_name: gbp_0
    sql: safe_cast(replace(${TABLE}.forecast_net_profit,",","") as decimal) ;;
  }

  dimension: forecast_revenue {
    type: number
    value_format_name: gbp_0
    sql: ${TABLE}.forecast ;;
  }

  dimension: forecast_taxation {
    type: number
    value_format_name: gbp_0
    sql: ${TABLE}.taxation ;;
  }

  dimension: overheads {
    type: number
    value_format_name: gbp_0
    sql: ${TABLE}.overheads ;;
  }

  dimension: target_net_margin {
    type: number
    value_format_name: percent_2
    sql: ${target_net_profit}/${target_revenue} ;;
  }

  dimension: target_net_profit {
    type: number
    value_format_name: percent_1
    sql: ${TABLE}.target_net_profit ;;
  }

  dimension: target_revenue {
    type: number
    value_format_name: gbp_0
    sql: ${TABLE}.target ;;
  }

  dimension_group: period {
    type: time
    timeframes: [raw, date, month, quarter, year]
    sql: timestamp(month) ;;
  }

  measure: total_booked_and_forecast_revenue {
    type: number
    label: "Forecast Revenue"
    description: "Booked plus forecast revenue (Looker tile 2533 table calculation forecast_revenue)"
    value_format_name: gbp_0
    sql: coalesce(${total_booked_revenue},0) + coalesce(${total_forecast_revenue},0) ;;
  }

  measure: total_booked_revenue {
    type: sum
    label: "Sum of Booked Revenue"
    value_format_name: gbp_0
    sql: ${booked_revenue} ;;
  }

  measure: total_forecast_net_profit {
    type: sum
    label: "Sum of Forecast Net Profit"
    value_format_name: gbp_0
    sql: ${forecast_net_profit} ;;
  }

  measure: total_forecast_revenue {
    type: sum
    label: "Sum of Forecast Revenue"
    value_format_name: gbp_0
    sql: ${forecast_revenue} ;;
  }

  measure: total_target_revenue {
    type: sum
    label: "Sum of Target Revenue"
    value_format_name: gbp_0
    sql: ${target_revenue} ;;
  }
}
