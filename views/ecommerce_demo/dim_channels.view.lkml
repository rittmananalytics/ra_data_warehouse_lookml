view: dim_channels {
  sql_table_name: `ra-development.analytics_ecommerce_ecommerce.dim_channels_enhanced` ;;

  # Primary Key
  dimension: channel_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.channel_key ;;
    description: "Channel surrogate key"
  }

  # Natural Keys and Identifiers
  dimension: channel_id {
    type: string
    sql: ${TABLE}.channel_id ;;
    description: "Channel business key"
  }

  dimension: channel_source {
    type: string
    sql: ${TABLE}.channel_source ;;
    description: "Traffic source (e.g., google, facebook, email)"
  }

  dimension: channel_medium {
    type: string
    sql: ${TABLE}.channel_medium ;;
    description: "Traffic medium (e.g., cpc, organic, social)"
  }

  dimension: channel_campaign {
    type: string
    sql: ${TABLE}.channel_campaign ;;
    description: "Campaign name"
  }

  dimension: channel_data_source {
    type: string
    sql: ${TABLE}.channel_data_source ;;
    description: "Data source (GA4, Shopify, etc.)"
  }

  dimension: channel_group {
    type: string
    sql: ${TABLE}.channel_group ;;
    description: "Channel grouping"
  }

  dimension: attribution_type {
    type: string
    sql: ${TABLE}.attribution_type ;;
    description: "Attribution type"
  }

  dimension: source_medium {
    type: string
    sql: CONCAT(${channel_source}, ' / ', ${channel_medium}) ;;
    description: "Source/Medium combination"
  }

  # Digital Engagement Metrics
  dimension: unique_users {
    type: number
    sql: ${TABLE}.unique_users ;;
    description: "Unique users from this channel"
  }

  dimension: total_events {
    type: number
    sql: ${TABLE}.total_events ;;
    description: "Total events from this channel"
  }

  dimension: sessions {
    type: number
    sql: ${TABLE}.sessions ;;
    description: "Sessions from this channel"
  }

  dimension: page_view_users {
    type: number
    sql: ${TABLE}.page_view_users ;;
    description: "Users who viewed pages"
  }

  dimension: product_view_users {
    type: number
    sql: ${TABLE}.product_view_users ;;
    description: "Users who viewed products"
  }

  dimension: add_to_cart_users {
    type: number
    sql: ${TABLE}.add_to_cart_users ;;
    description: "Users who added to cart"
  }

  dimension: checkout_users {
    type: number
    sql: ${TABLE}.checkout_users ;;
    description: "Users who began checkout"
  }

  dimension: purchase_users {
    type: number
    sql: ${TABLE}.purchase_users ;;
    description: "Users who made purchases"
  }

  dimension: ga4_purchase_value {
    type: number
    sql: ${TABLE}.ga4_purchase_value ;;
    description: "Purchase value from GA4"
    value_format_name: usd
  }

  dimension: ga4_purchases {
    type: number
    sql: ${TABLE}.ga4_purchases ;;
    description: "Number of purchases from GA4"
  }

  # Commerce Metrics
  dimension: total_orders {
    type: number
    sql: ${TABLE}.total_orders ;;
    description: "Total orders from this channel"
  }

  dimension: unique_customers {
    type: number
    sql: ${TABLE}.unique_customers ;;
    description: "Unique customers from this channel"
  }

  dimension: total_revenue {
    type: number
    sql: ${TABLE}.total_revenue ;;
    description: "Total revenue from this channel"
    value_format_name: usd
  }

  dimension: avg_order_value {
    type: number
    sql: ${TABLE}.avg_order_value ;;
    description: "Average order value"
    value_format_name: usd
  }

  dimension_group: first_order {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.first_order_date ;;
    description: "First order date from this channel"
  }

  dimension_group: last_order {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.last_order_date ;;
    description: "Last order date from this channel"
  }

  # Combined Performance Metrics
  dimension: combined_revenue {
    type: number
    sql: ${TABLE}.combined_revenue ;;
    description: "Combined revenue (GA4 + Shopify)"
    value_format_name: usd
  }

  dimension: combined_transactions {
    type: number
    sql: ${TABLE}.combined_transactions ;;
    description: "Combined transactions"
  }

  # Conversion Funnel Metrics
  dimension: page_view_rate {
    type: number
    sql: ${TABLE}.page_view_rate ;;
    description: "Page view rate"
    value_format_name: percent_2
  }

  dimension: product_view_rate {
    type: number
    sql: ${TABLE}.product_view_rate ;;
    description: "Product view rate"
    value_format_name: percent_2
  }

  dimension: add_to_cart_rate {
    type: number
    sql: ${TABLE}.add_to_cart_rate ;;
    description: "Add to cart rate"
    value_format_name: percent_2
  }

  dimension: checkout_rate {
    type: number
    sql: ${TABLE}.checkout_rate ;;
    description: "Checkout rate"
    value_format_name: percent_2
  }

  dimension: overall_conversion_rate {
    type: number
    sql: ${TABLE}.overall_conversion_rate ;;
    description: "Overall conversion rate"
    value_format_name: percent_2
  }

  dimension: cart_abandonment_rate {
    type: number
    sql: ${TABLE}.cart_abandonment_rate ;;
    description: "Cart abandonment rate"
    value_format_name: percent_2
  }

  # Categorizations
  dimension: is_paid_channel {
    type: yesno
    sql: ${TABLE}.is_paid_channel ;;
    description: "Is paid advertising channel"
  }

  dimension: is_digital_channel {
    type: yesno
    sql: ${TABLE}.is_digital_channel ;;
    description: "Is digital channel"
  }

  dimension: source_category {
    type: string
    sql: ${TABLE}.source_category ;;
    description: "Source category"
  }

  dimension: channel_performance_tier {
    type: string
    sql: ${TABLE}.channel_performance_tier ;;
    description: "Performance tier based on revenue"
  }

  dimension: conversion_performance_tier {
    type: string
    sql: ${TABLE}.conversion_performance_tier ;;
    description: "Conversion performance tier"
  }

  dimension: engagement_level {
    type: string
    sql: ${TABLE}.engagement_level ;;
    description: "Engagement level"
  }

  # Data Quality Flags
  dimension: has_ga4_data {
    type: yesno
    sql: ${TABLE}.has_ga4_data ;;
    description: "Has GA4 data"
  }

  dimension: has_order_data {
    type: yesno
    sql: ${TABLE}.has_order_data ;;
    description: "Has order data"
  }

  dimension: is_active_channel {
    type: yesno
    sql: ${TABLE}.is_active_channel ;;
    description: "Channel is currently active"
  }

  # Timestamps
  dimension_group: warehouse_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.warehouse_updated_at ;;
    description: "Warehouse update timestamp"
  }

  # Measures
  measure: count {
    type: count
    description: "Number of channels"
    drill_fields: [channel_detail*]
  }

  measure: total_channel_revenue {
    type: sum
    sql: ${total_revenue} ;;
    description: "Total revenue across channels"
    value_format_name: usd
  }

  measure: total_channel_orders {
    type: sum
    sql: ${total_orders} ;;
    description: "Total orders across channels"
  }

  measure: total_channel_users {
    type: sum
    sql: ${unique_users} ;;
    description: "Total users across channels"
  }

  measure: average_channel_conversion_rate {
    type: average
    sql: ${overall_conversion_rate} ;;
    description: "Average conversion rate"
    value_format_name: percent_2
  }

  measure: paid_channels {
    type: count
    filters: [is_paid_channel: "yes"]
    description: "Number of paid channels"
  }

  measure: active_channels {
    type: count
    filters: [is_active_channel: "yes"]
    description: "Number of active channels"
  }

  # Sets
  set: channel_detail {
    fields: [
      channel_id,
      source_medium,
      channel_group,
      total_revenue,
      total_orders,
      unique_users,
      overall_conversion_rate,
      is_paid_channel
    ]
  }
}
