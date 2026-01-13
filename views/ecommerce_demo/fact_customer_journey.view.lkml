view: fact_customer_journey {
  sql_table_name: `ra-development.analytics_ecommerce_ecommerce.fact_customer_journey` ;;

  # Primary Key
  dimension: journey_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.journey_key ;;
    description: "Customer journey surrogate key"
  }

  # Foreign Keys
  dimension: customer_key {
    type: number
    sql: ${TABLE}.customer_key ;;
    description: "Customer surrogate key"
    hidden: yes
  }

  dimension: order_key {
    type: number
    sql: ${TABLE}.order_key ;;
    description: "Order surrogate key"
    hidden: yes
  }

  dimension: session_key {
    type: number
    sql: ${TABLE}.session_key ;;
    description: "Session surrogate key"
    hidden: yes
  }

  dimension: session_date_key {
    type: number
    sql: ${TABLE}.session_date_key ;;
    description: "Session date key"
    hidden: yes
  }

  dimension: order_date_key {
    type: number
    sql: ${TABLE}.order_date_key ;;
    description: "Order date key"
    hidden: yes
  }

  # Journey Attributes
  dimension: journey_id {
    type: string
    sql: ${TABLE}.journey_id ;;
    description: "Customer journey ID"
  }

  dimension: journey_step {
    type: number
    sql: ${TABLE}.journey_step ;;
    description: "Step number in customer journey"
  }

  dimension: touchpoint_type {
    type: string
    sql: ${TABLE}.touchpoint_type ;;
    description: "Type of touchpoint (e.g., session, order, email)"
  }

  dimension: channel_source {
    type: string
    sql: ${TABLE}.channel_source ;;
    description: "Marketing channel source"
  }

  dimension: channel_medium {
    type: string
    sql: ${TABLE}.channel_medium ;;
    description: "Marketing channel medium"
  }

  dimension: days_since_first_touch {
    type: number
    sql: ${TABLE}.days_since_first_touch ;;
    description: "Days since first customer touchpoint"
  }

  dimension: days_to_next_touch {
    type: number
    sql: ${TABLE}.days_to_next_touch ;;
    description: "Days until next touchpoint"
  }

  dimension: conversion_flag {
    type: yesno
    sql: ${TABLE}.conversion_flag ;;
    description: "Whether this touchpoint led to conversion"
  }

  dimension: revenue_attributed {
    type: number
    sql: ${TABLE}.revenue_attributed ;;
    value_format_name: usd
    description: "Revenue attributed to this touchpoint"
  }

  # Attribution Model Dimensions
  dimension: first_touch_attribution {
    type: number
    sql: ${TABLE}.first_touch_attribution ;;
    value_format_name: percent_1
    description: "First touch attribution weight"
  }

  dimension: last_touch_attribution {
    type: number
    sql: ${TABLE}.last_touch_attribution ;;
    value_format_name: percent_1
    description: "Last touch attribution weight"
  }

  dimension: linear_attribution {
    type: number
    sql: ${TABLE}.linear_attribution ;;
    value_format_name: percent_1
    description: "Linear attribution weight"
  }

  dimension: time_decay_attribution {
    type: number
    sql: ${TABLE}.time_decay_attribution ;;
    value_format_name: percent_1
    description: "Time decay attribution weight"
  }

  # Measures
  measure: journey_count {
    type: count_distinct
    sql: ${journey_id} ;;
    description: "Number of unique customer journeys"
  }

  measure: touchpoint_count {
    type: count
    description: "Total number of touchpoints"
  }

  measure: conversion_count {
    type: count
    filters: [conversion_flag: "yes"]
    description: "Number of converting touchpoints"
  }

  measure: conversion_rate {
    type: number
    sql: ${conversion_count}*1.0 / NULLIF(${touchpoint_count},0) ;;
    value_format_name: percent_2
    description: "Touchpoint conversion rate"
  }

  measure: total_attributed_revenue {
    type: sum
    sql: ${revenue_attributed} ;;
    value_format_name: usd
    description: "Total revenue attributed across touchpoints"
  }

  measure: avg_days_to_conversion {
    type: average
    sql: ${days_since_first_touch} ;;
    filters: [conversion_flag: "yes"]
    value_format_name: decimal_1
    description: "Average days from first touch to conversion"
  }

  measure: avg_touchpoints_per_journey {
    type: number
    sql: ${touchpoint_count}*1.0 / NULLIF(${journey_count},0) ;;
    value_format_name: decimal_1
    description: "Average touchpoints per customer journey"
  }
}
