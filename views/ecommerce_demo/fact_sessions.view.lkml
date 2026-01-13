view: fact_sessions {
  sql_table_name: `ra-development.analytics_ecommerce_ecommerce.fact_sessions` ;;

  # Primary Key
  dimension: session_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.session_key ;;
    description: "Session surrogate key"
  }

  # Foreign Keys
  dimension: session_date_key {
    type: number
    sql: ${TABLE}.session_date_key ;;
    description: "Session date key"
    hidden: yes
  }

  dimension: channel_key {
    type: number
    sql: ${TABLE}.channel_key ;;
    description: "Channel key for joining to dim_channels"
    hidden: yes
  }

  # Session Identification
  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
    description: "Unique session identifier"
  }

  dimension: user_pseudo_id {
    type: string
    sql: ${TABLE}.user_pseudo_id ;;
    description: "User pseudo ID from GA4"
  }

  # Traffic Source (New fields!)
  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
    description: "Traffic source"
  }

  dimension: traffic_medium {
    type: string
    sql: ${TABLE}.traffic_medium ;;
    description: "Traffic medium"
  }

  dimension: traffic_campaign {
    type: string
    sql: ${TABLE}.traffic_campaign ;;
    description: "Traffic campaign"
  }

  dimension: source_medium {
    type: string
    sql: CONCAT(COALESCE(${traffic_source}, '(direct)'), ' / ', COALESCE(${traffic_medium}, '(none)')) ;;
    description: "Source/Medium combination"
  }

  # Time Dimensions
  dimension_group: session_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.session_date ;;
    description: "Session date"
  }

  dimension: session_start_timestamp {
    type: number
    sql: ${TABLE}.session_start_timestamp ;;
    description: "Session start timestamp (microseconds)"
    hidden: yes
  }

  dimension: session_end_timestamp {
    type: number
    sql: ${TABLE}.session_end_timestamp ;;
    description: "Session end timestamp (microseconds)"
    hidden: yes
  }

  dimension_group: session_start {
    type: time
    timeframes: [raw, time, hour, date, week, month, quarter, year, day_of_week, hour_of_day]
    sql: TIMESTAMP_MICROS(${session_start_timestamp}) ;;
    description: "Session start time"
  }

  dimension_group: session_end {
    type: time
    timeframes: [raw, time, hour, date]
    sql: TIMESTAMP_MICROS(${session_end_timestamp}) ;;
    description: "Session end time"
  }

  # Session Sequence and Duration
  dimension: session_sequence_number {
    type: number
    sql: ${TABLE}.session_sequence_number ;;
    description: "Sequential session number for user"
  }

  dimension: hours_since_previous_session {
    type: number
    sql: ${TABLE}.hours_since_previous_session ;;
    description: "Hours since user's previous session"
    value_format_name: decimal_1
  }

  dimension: session_duration_seconds {
    type: number
    sql: ${TABLE}.session_duration_seconds ;;
    description: "Session duration in seconds"
  }

  dimension: session_duration_minutes {
    type: number
    sql: ${TABLE}.session_duration_minutes ;;
    description: "Session duration in minutes"
    value_format_name: decimal_1
  }

  dimension: session_duration_category {
    type: string
    sql: ${TABLE}.session_duration_category ;;
    description: "Session duration category (Bounce/Short/Medium/Long)"
  }

  # Engagement Metrics
  dimension: page_views {
    type: number
    sql: ${TABLE}.page_views ;;
    description: "Number of page views in session"
  }

  dimension: unique_pages_viewed {
    type: number
    sql: ${TABLE}.unique_pages_viewed ;;
    description: "Number of unique pages viewed"
  }

  dimension: unique_page_locations {
    type: number
    sql: ${TABLE}.unique_page_locations ;;
    description: "Number of unique page locations"
  }

  dimension: items_viewed {
    type: number
    sql: ${TABLE}.items_viewed ;;
    description: "Number of items viewed"
  }

  dimension: unique_items_viewed {
    type: number
    sql: ${TABLE}.unique_items_viewed ;;
    description: "Number of unique items viewed"
  }

  dimension: add_to_cart_events {
    type: number
    sql: ${TABLE}.add_to_cart_events ;;
    description: "Number of add to cart events"
  }

  dimension: unique_items_added_to_cart {
    type: number
    sql: ${TABLE}.unique_items_added_to_cart ;;
    description: "Number of unique items added to cart"
  }

  dimension: begin_checkout_events {
    type: number
    sql: ${TABLE}.begin_checkout_events ;;
    description: "Number of begin checkout events"
  }

  dimension: purchase_events {
    type: number
    sql: ${TABLE}.purchase_events ;;
    description: "Number of purchase events"
  }

  # Revenue
  dimension: session_revenue {
    type: number
    sql: ${TABLE}.session_revenue ;;
    description: "Total revenue from session"
    value_format_name: usd
  }

  dimension: avg_purchase_value {
    type: number
    sql: ${TABLE}.avg_purchase_value ;;
    description: "Average purchase value in session"
    value_format_name: usd
  }

  # Conversion Flags
  dimension: viewed_products {
    type: yesno
    sql: ${TABLE}.viewed_products ;;
    description: "User viewed products"
  }

  dimension: added_to_cart {
    type: yesno
    sql: ${TABLE}.added_to_cart ;;
    description: "User added items to cart"
  }

  dimension: began_checkout {
    type: yesno
    sql: ${TABLE}.began_checkout ;;
    description: "User began checkout"
  }

  dimension: completed_purchase {
    type: yesno
    sql: ${TABLE}.completed_purchase ;;
    description: "User completed purchase"
  }

  # Session Classification
  dimension: session_type {
    type: string
    sql: ${TABLE}.session_type ;;
    description: "Session type classification"
  }

  dimension: avg_time_per_page {
    type: number
    sql: ${TABLE}.avg_time_per_page ;;
    description: "Average time per page (seconds)"
    value_format_name: decimal_1
  }

  dimension: is_multi_page_session {
    type: yesno
    sql: ${TABLE}.is_multi_page_session ;;
    description: "Session has multiple page views"
  }

  dimension: is_bounce {
    type: yesno
    sql: ${TABLE}.is_bounce ;;
    description: "Session is a bounce"
  }

  # Conversion Rates
  dimension: view_to_cart_rate {
    type: number
    sql: ${TABLE}.view_to_cart_rate ;;
    description: "Rate of view to cart conversion"
    value_format_name: percent_1
  }

  dimension: cart_to_checkout_rate {
    type: number
    sql: ${TABLE}.cart_to_checkout_rate ;;
    description: "Rate of cart to checkout conversion"
    value_format_name: percent_1
  }

  dimension: checkout_to_purchase_rate {
    type: number
    sql: ${TABLE}.checkout_to_purchase_rate ;;
    description: "Rate of checkout to purchase conversion"
    value_format_name: percent_1
  }

  dimension: view_to_purchase_rate {
    type: number
    sql: ${TABLE}.view_to_purchase_rate ;;
    description: "Rate of view to purchase conversion"
    value_format_name: percent_1
  }

  # Revenue per Action
  dimension: revenue_per_page_view {
    type: number
    sql: ${TABLE}.revenue_per_page_view ;;
    description: "Revenue per page view"
    value_format_name: usd
  }

  dimension: revenue_per_item_view {
    type: number
    sql: ${TABLE}.revenue_per_item_view ;;
    description: "Revenue per item view"
    value_format_name: usd
  }

  # User Journey
  dimension: visitor_type {
    type: string
    sql: ${TABLE}.visitor_type ;;
    description: "Visitor type (First Visit/Second Visit/etc)"
  }

  dimension: return_pattern {
    type: string
    sql: ${TABLE}.return_pattern ;;
    description: "Return pattern classification"
  }

  dimension: session_time_of_day {
    type: string
    sql: ${TABLE}.session_time_of_day ;;
    description: "Time of day classification"
  }

  dimension: session_day_type {
    type: string
    sql: ${TABLE}.session_day_type ;;
    description: "Day type (Weekend/Weekday)"
  }

  dimension: engagement_score {
    type: number
    sql: ${TABLE}.engagement_score ;;
    description: "Session engagement score (0-100)"
  }

  # Measures
  measure: count {
    type: count
    description: "Number of sessions"
    drill_fields: [session_detail*]
  }

  measure: count_users {
    type: count_distinct
    sql: ${user_pseudo_id} ;;
    description: "Number of unique users"
  }

  measure: total_page_views {
    type: sum
    sql: ${page_views} ;;
    description: "Total page views"
  }

  measure: total_revenue {
    type: sum
    sql: ${session_revenue} ;;
    description: "Total revenue"
    value_format_name: usd
  }

  measure: total_purchases {
    type: sum
    sql: ${purchase_events} ;;
    description: "Total purchases"
  }

  measure: bounce_rate {
    type: number
    sql: COUNT(CASE WHEN ${is_bounce} THEN 1 END) / NULLIF(${count}, 0) ;;
    description: "Bounce rate"
    value_format_name: percent_1
  }

  measure: conversion_rate {
    type: number
    sql: COUNT(CASE WHEN ${completed_purchase} THEN 1 END) / NULLIF(${count}, 0) ;;
    description: "Purchase conversion rate"
    value_format_name: percent_2
  }

  measure: average_session_duration {
    type: average
    sql: ${session_duration_seconds} ;;
    description: "Average session duration (seconds)"
    value_format_name: decimal_1
  }

  measure: average_page_views {
    type: average
    sql: ${page_views} ;;
    description: "Average page views per session"
    value_format_name: decimal_1
  }

  measure: revenue_per_session {
    type: number
    sql: ${total_revenue} / NULLIF(${count}, 0) ;;
    description: "Revenue per session"
    value_format_name: usd
  }

  measure: add_to_cart_rate {
    type: number
    sql: COUNT(CASE WHEN ${added_to_cart} THEN 1 END) / NULLIF(${count}, 0) ;;
    description: "Add to cart rate"
    value_format_name: percent_1
  }

  measure: cart_abandonment_rate {
    type: number
    sql: COUNT(CASE WHEN ${added_to_cart} AND NOT ${completed_purchase} THEN 1 END) /
      NULLIF(COUNT(CASE WHEN ${added_to_cart} THEN 1 END), 0) ;;
    description: "Cart abandonment rate"
    value_format_name: percent_1
  }

  measure: sessions_per_user {
    type: number
    sql: ${count} / NULLIF(${count_users}, 0) ;;
    description: "Average sessions per user"
    value_format_name: decimal_1
  }

  # Drill fields
  set: session_detail {
    fields: [
      session_id,
      user_pseudo_id,
      session_start_time,
      source_medium,
      session_duration_minutes,
      page_views,
      session_revenue,
      session_type
    ]
  }
}
