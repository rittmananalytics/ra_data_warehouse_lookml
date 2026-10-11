view: monthly_resource_revenue_forecast_fact {
  sql_table_name: ra-development.analytics.monthly_resource_planning_forecast_fact ;;

  dimension: buyer_confirmed_budget_available {
    type: yesno
    sql: ${TABLE}.buyer_confirmed_budget_available ;;
  }

  dimension: deal_partner_referral {
    type: string
    sql: ${TABLE}.deal_partner_referral ;;
  }

  dimension: deal_source {
    type: string
    sql: ${TABLE}.deal_source ;;
  }

  dimension: engagement_name {
    type: string
    sql: ${TABLE}.engagement_name ;;
  }

  dimension: forecast_hourly_deal_rate {
    type: number
    hidden: yes
    sql: ${TABLE}.forecast_hourly_deal_rate ;;
  }

  dimension: forecast_monthly_deal_revenue_gbp {
    type: number
    hidden: yes
    sql: ${TABLE}.forecast_monthly_deal_revenue_gbp ;;
  }

  dimension: forecast_pk {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.forecast_pk ;;
  }

  dimension: forecast_type {
    type: string
    sql: ${TABLE}.forecast_type ;;
  }

  dimension: forecasted_monthly_hours {
    type: number
    hidden: yes
    sql: ${TABLE}.forecasted_monthly_hours ;;
  }

  dimension: forecasted_sac_fte {
    type: number
    hidden: yes
    sql: ${TABLE}.forecasted_sac_fte ;;
  }

  dimension: forecasted_weighted_monthly_hours {
    type: number
    hidden: yes
    sql: ${TABLE}.forecasted_weighted_monthly_hours ;;
  }

  dimension: forecasted_weighted_sac_fte {
    type: number
    hidden: yes
    sql: ${TABLE}.forecasted_weighted_sac_fte ;;
  }

  dimension: spend_agreed_with_buyer {
    type: yesno
    sql: ${TABLE}.spend_agreed_with_buyer ;;
  }

  dimension_group: forecast {
    type: time
    timeframes: [raw, date, month, quarter, year, month_num]
    sql: timestamp(${TABLE}.forecast_month) ;;
  }

  measure: avg_forecast_hourly_rate {
    type: average
    sql: ${forecast_hourly_deal_rate} ;;
  }

  measure: total_forecast_monthly_hours {
    type: sum
    sql: ${forecasted_monthly_hours} ;;
  }

  measure: total_forecast_revenue_gbp {
    type: sum
    value_format_name: gbp_0
    sql: ${forecast_monthly_deal_revenue_gbp} ;;
  }

  measure: total_forecast_sac_fte {
    type: sum
    value_format_name: decimal_1
    sql: ${forecasted_sac_fte} ;;
  }

  measure: total_forecast_weighted_sac_fte {
    type: sum
    value_format_name: decimal_1
    sql: ${forecasted_weighted_sac_fte} ;;
  }

  measure: total_weighted_forecast_monthly_hours {
    type: sum
    value_format_name: decimal_0
    sql: ${forecasted_weighted_monthly_hours} ;;
  }
}
