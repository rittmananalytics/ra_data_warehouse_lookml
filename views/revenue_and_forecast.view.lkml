view: revenue_and_forecast {
  derived_table: {
    sql: SELECT * FROM `ra-development.analytics_seed.revenue_and_forecast`
      ;;
  }



  dimension_group: period {
    timeframes: [month,quarter,year]
    type:time
sql: timestamp(${TABLE}.month) ;;
  }

  dimension: target_revenue {
    value_format_name: gbp_0

    type: number
    sql: ${TABLE}.target ;;
  }

  dimension: booked_revenue {
    value_format_name: gbp_0
    type: number
    sql: ${TABLE}.booked ;;
  }

  dimension: forecast_revenue {
    value_format_name: gbp_0

    type: number
    sql: ${TABLE}.forecast ;;
  }

  dimension: booked_and_forecast_revenue {
    value_format_name: gbp_0

    type: number
    sql: ${TABLE}.booked_and_forecast ;;
  }

  dimension: delivery_costs {
    value_format_name: gbp_0

    type: number
    sql: ${TABLE}.delivery_costs ;;
  }

  dimension: overheads {
    value_format_name: gbp_0

    type: number
    sql: ${TABLE}.overheads ;;
  }

  dimension: dividends {
    value_format_name: gbp_0

    type: number
    sql: ${TABLE}.dividends ;;
  }

  dimension: target_net_profit {
    value_format_name: percent_1

    type: number
    sql: ${TABLE}.target_net_profit ;;
  }

  dimension: forecast_taxation {
    value_format_name: gbp_0
    type: number
    sql: ${TABLE}.taxation ;;
  }

  dimension: forecast_net_profit {
    value_format_name: gbp_0

    type: number
    sql: safe_cast(replace(${TABLE}.forecast_net_profit,",","") as decimal) ;;
  }

  dimension: target_net_margin {

    type: number
    value_format_name: percent_2
    sql: ${target_net_profit}/${target_revenue} ;;
  }

  dimension: actual_net_margin {
    type: number
    value_format_name: percent_2
    sql: ${forecast_net_profit} ;;
  }


}
