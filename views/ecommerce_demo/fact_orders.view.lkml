view: fact_orders {
  sql_table_name: `ra-development.analytics_ecommerce_ecommerce.fact_orders` ;;

  # Primary Key
  dimension: order_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.order_key ;;
    description: "Order surrogate key"
  }

  # Foreign Keys
  dimension: customer_key {
    type: number
    sql: ${TABLE}.customer_key ;;
    description: "Customer surrogate key"
    hidden: yes
  }

  dimension: channel_key {
    type: number
    sql: ${TABLE}.channel_key ;;
    description: "Channel surrogate key"
    hidden: yes
  }

  dimension: order_date_key {
    type: number
    sql: ${TABLE}.order_date_key ;;
    description: "Order date key"
    hidden: yes
  }

  dimension: processed_date_key {
    type: number
    sql: ${TABLE}.processed_date_key ;;
    description: "Processed date key"
    hidden: yes
  }

  dimension: cancelled_date_key {
    type: number
    sql: ${TABLE}.cancelled_date_key ;;
    description: "Cancelled date key"
    hidden: yes
  }

  # Natural Key
  dimension: order_id {
    type: string
    sql: ${TABLE}.order_id ;;
    description: "Order business key"
  }

  # Order Identifiers
  dimension: order_name {
    type: string
    sql: ${TABLE}.order_name ;;
    description: "Order name/number"
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
    description: "Customer ID"
  }

  dimension: customer_email {
    type: string
    sql: ${TABLE}.customer_email ;;
    description: "Customer email"
  }

  # Dates and Timestamps
  dimension_group: order_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.order_created_at ;;
    description: "Order creation timestamp"
  }

  dimension_group: order_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.order_updated_at ;;
    description: "Order update timestamp"
  }

  dimension_group: order_processed {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.order_processed_at ;;
    description: "Order processed timestamp"
  }

  dimension_group: order_cancelled {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.order_cancelled_at ;;
    description: "Order cancelled timestamp"
  }

  # Status Fields
  dimension: financial_status {
    type: string
    sql: ${TABLE}.financial_status ;;
    description: "Financial status (paid, pending, refunded, etc.)"
  }

  dimension: fulfillment_status {
    type: string
    sql: ${TABLE}.fulfillment_status ;;
    description: "Fulfillment status"
  }

  # Financial Metrics
  dimension: order_total_price {
    type: number
    sql: ${TABLE}.order_total_price ;;
    description: "Total order price"
    value_format_name: usd
  }

  dimension: subtotal_price {
    type: number
    sql: ${TABLE}.subtotal_price ;;
    description: "Subtotal price"
    value_format_name: usd
  }

  dimension: total_tax {
    type: number
    sql: ${TABLE}.total_tax ;;
    description: "Total tax amount"
    value_format_name: usd
  }

  dimension: total_discounts {
    type: number
    sql: ${TABLE}.total_discounts ;;
    description: "Total discounts"
    value_format_name: usd
  }

  dimension: shipping_cost {
    type: number
    sql: ${TABLE}.shipping_cost ;;
    description: "Shipping cost"
    value_format_name: usd
  }

  dimension: order_adjustment_amount {
    type: number
    sql: ${TABLE}.order_adjustment_amount ;;
    description: "Order adjustment amount"
    value_format_name: usd
  }

  dimension: refund_subtotal {
    type: number
    sql: ${TABLE}.refund_subtotal ;;
    description: "Refund subtotal"
    value_format_name: usd
  }

  dimension: refund_tax {
    type: number
    sql: ${TABLE}.refund_tax ;;
    description: "Refund tax"
    value_format_name: usd
  }

  # Calculated Metrics
  dimension: calculated_order_total {
    type: number
    sql: ${TABLE}.calculated_order_total ;;
    description: "Calculated order total"
    value_format_name: usd
  }

  dimension: total_line_discounts {
    type: number
    sql: ${TABLE}.total_line_discounts ;;
    description: "Total line item discounts"
    value_format_name: usd
  }

  dimension: total_discount_amount {
    type: number
    sql: ${TABLE}.total_discount_amount ;;
    description: "Total discount amount"
    value_format_name: usd
  }

  # Order Composition
  dimension: line_item_count {
    type: number
    sql: ${TABLE}.line_item_count ;;
    description: "Number of line items"
  }

  dimension: unique_product_count {
    type: number
    sql: ${TABLE}.unique_product_count ;;
    description: "Number of unique products"
  }

  dimension: total_quantity {
    type: number
    sql: ${TABLE}.total_quantity ;;
    description: "Total quantity ordered"
  }

  dimension: avg_line_price {
    type: number
    sql: ${TABLE}.avg_line_price ;;
    description: "Average line item price"
    value_format_name: usd
  }

  dimension: max_line_price {
    type: number
    sql: ${TABLE}.max_line_price ;;
    description: "Maximum line item price"
    value_format_name: usd
  }

  dimension: min_line_price {
    type: number
    sql: ${TABLE}.min_line_price ;;
    description: "Minimum line item price"
    value_format_name: usd
  }

  # Order Source Information
  dimension: source_name {
    type: string
    sql: ${TABLE}.source_name ;;
    description: "Order source name"
  }

  dimension: referring_site {
    type: string
    sql: ${TABLE}.referring_site ;;
    description: "Referring site"
  }

  dimension: landing_page {
    type: string
    sql: ${TABLE}.landing_page ;;
    description: "Landing page URL"
  }

  # Classification Fields
  dimension: has_discount {
    type: yesno
    sql: ${TABLE}.has_discount ;;
    description: "Order has discount"
  }

  dimension: has_refund {
    type: yesno
    sql: ${TABLE}.has_refund ;;
    description: "Order has refund"
  }

  dimension: order_type {
    type: string
    sql: ${TABLE}.order_type ;;
    description: "Order type classification"
  }

  dimension: discount_category {
    type: string
    sql: ${TABLE}.discount_category ;;
    description: "Discount category"
  }

  dimension: order_size_category {
    type: string
    sql: ${TABLE}.order_size_category ;;
    description: "Order size category"
  }

  dimension: is_first_order {
    type: yesno
    sql: ${TABLE}.is_first_order ;;
    description: "Is customer's first order"
  }

  dimension: days_since_previous_order {
    type: number
    sql: ${TABLE}.days_since_previous_order ;;
    description: "Days since customer's previous order"
  }

  dimension: is_cancelled {
    type: yesno
    sql: ${TABLE}.is_cancelled ;;
    description: "Order is cancelled"
  }

  # Measures
  measure: count {
    type: count
    description: "Number of orders"
    drill_fields: [order_detail*]
  }

  measure: total_revenue {
    type: sum
    sql: ${calculated_order_total} ;;
    description: "Total revenue"
    value_format_name: usd
  }

  measure: average_order_value {
    type: average
    sql: ${calculated_order_total} ;;
    description: "Average order value"
    value_format_name: usd
  }

  measure: total_items_ordered {
    type: sum
    sql: ${total_quantity} ;;
    description: "Total items ordered"
  }

  measure: average_items_per_order {
    type: average
    sql: ${total_quantity} ;;
    description: "Average items per order"
    value_format_name: decimal_1
  }

  measure: total_discount_given {
    type: sum
    sql: ${total_discount_amount} ;;
    description: "Total discounts given"
    value_format_name: usd
  }

  measure: discount_rate {
    type: number
    sql: ${total_discount_given} / NULLIF(${total_revenue} + ${total_discount_given}, 0) ;;
    description: "Discount rate"
    value_format_name: percent_2
  }

  measure: cancellation_rate {
    type: number
    sql: COUNT(CASE WHEN ${is_cancelled} THEN 1 END) / NULLIF(${count}, 0) ;;
    description: "Order cancellation rate"
    value_format_name: percent_2
  }

  measure: refund_rate {
    type: number
    sql: COUNT(CASE WHEN ${has_refund} THEN 1 END) / NULLIF(${count}, 0) ;;
    description: "Order refund rate"
    value_format_name: percent_2
  }

  measure: orders_with_discount {
    type: count
    filters: [has_discount: "yes"]
    description: "Number of orders with discounts"
  }

  measure: first_time_orders {
    type: count
    filters: [is_first_order: "yes"]
    description: "Number of first-time orders"
  }

  measure: first_time_order_rate {
    type: number
    sql: ${first_time_orders} / NULLIF(${count}, 0) ;;
    description: "First-time order rate"
    value_format_name: percent_2
  }

  # Drill fields
  set: order_detail {
    fields: [
      order_id,
      order_name,
      customer_email,
      order_created_date,
      calculated_order_total,
      total_quantity,
      financial_status,
      fulfillment_status
    ]
  }
}
