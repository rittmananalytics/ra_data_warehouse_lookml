view: fact_order_items {
  sql_table_name: `ra-development.analytics_ecommerce_ecommerce.fact_order_items` ;;

# Primary Key
  dimension: order_item_key {
    primary_key: yes
    type: string
    sql: ${TABLE}.order_item_key ;;
    description: "Order item surrogate key"
  }

  # Natural Keys
  dimension: order_line_id {
    type: string
    sql: ${TABLE}.order_line_id ;;
    description: "Order line ID"
  }

  dimension: order_id {
    type: string
    sql: ${TABLE}.order_id ;;
    description: "Order ID"
  }

  # Foreign Keys
  dimension: product_key {
    type: number
    sql: ${TABLE}.product_key ;;
    description: "Product surrogate key"
    hidden: yes
  }

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

  # Product Details
  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
    description: "Product ID"
  }

  dimension: variant_id {
    type: string
    sql: ${TABLE}.variant_id ;;
    description: "Product variant ID"
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
    description: "SKU"
  }

  dimension: product_title {
    type: string
    sql: ${TABLE}.product_title ;;
    description: "Product title"
  }

  dimension: variant_title {
    type: string
    sql: ${TABLE}.variant_title ;;
    description: "Variant title"
  }

  dimension: vendor {
    type: string
    sql: ${TABLE}.vendor ;;
    description: "Product vendor"
  }

  dimension: product_type {
    type: string
    sql: ${TABLE}.product_type ;;
    description: "Product type"
  }

  # Quantities and Amounts
  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
    description: "Quantity ordered"
  }

  dimension: unit_price {
    type: number
    sql: ${TABLE}.unit_price ;;
    description: "Unit price"
    value_format_name: usd
  }

  dimension: line_price {
    type: number
    sql: ${TABLE}.line_price ;;
    description: "Line price (quantity * unit price)"
    value_format_name: usd
  }

  dimension: line_discount {
    type: number
    sql: ${TABLE}.line_discount ;;
    description: "Line discount amount"
    value_format_name: usd
  }

  dimension: line_tax {
    type: number
    sql: ${TABLE}.line_tax ;;
    description: "Line tax amount"
    value_format_name: usd
  }

  dimension: line_total {
    type: number
    sql: ${TABLE}.line_total ;;
    description: "Line total (price - discount + tax)"
    value_format_name: usd
  }

  dimension: line_share_of_order {
    type: number
    sql: ${TABLE}.line_share_of_order ;;
    description: "Line item's share of order subtotal"
    value_format_name: percent_2
  }

  dimension: allocated_shipping {
    type: number
    sql: ${TABLE}.allocated_shipping ;;
    description: "Allocated shipping cost"
    value_format_name: usd
  }

  # NOTE: allocated_order_discount and final_line_total don't exist in BigQuery
  # Using line_total instead which is the actual calculated field

  # Order Information
  dimension: order_name {
    type: string
    sql: ${TABLE}.order_name ;;
    description: "Order name/number"
  }

  dimension: customer_email {
    type: string
    sql: ${TABLE}.customer_email ;;
    description: "Customer email"
  }

  dimension: financial_status {
    type: string
    sql: ${TABLE}.financial_status ;;
    description: "Order financial status"
  }

  dimension: fulfillment_status {
    type: string
    sql: ${TABLE}.fulfillment_status ;;
    description: "Order fulfillment status"
  }

  dimension: source_name {
    type: string
    sql: ${TABLE}.source_name ;;
    description: "Order source"
  }

  # Discount Information
  dimension: discount_code {
    type: string
    sql: ${TABLE}.discount_code ;;
    description: "Discount code applied"
  }

  dimension: discount_type {
    type: string
    sql: ${TABLE}.discount_type ;;
    description: "Discount type"
  }

  dimension: discount_percentage {
    type: number
    sql: ${TABLE}.discount_percentage ;;
    description: "Discount percentage"
    value_format_name: percent_2
  }

  # Calculated Fields
  dimension: discount_rate {
    type: number
    sql: ${TABLE}.discount_rate ;;
    description: "Line discount rate"
    value_format_name: percent_2
  }

  dimension: has_discount {
    type: yesno
    sql: ${TABLE}.has_discount ;;
    description: "Line has discount"
  }

  dimension: is_gift_card {
    type: yesno
    sql: ${TABLE}.is_gift_card ;;
    description: "Product is a gift card"
  }

  dimension: requires_shipping {
    type: yesno
    sql: ${TABLE}.requires_shipping ;;
    description: "Product requires shipping"
  }

  dimension: is_taxable {
    type: yesno
    sql: ${TABLE}.is_taxable ;;
    description: "Product is taxable"
  }

  dimension: is_cancelled {
    type: yesno
    sql: ${TABLE}.is_cancelled ;;
    description: "Order is cancelled"
  }

  dimension: price_bucket {
    type: string
    sql: ${TABLE}.price_bucket ;;
    description: "Unit price bucket"
  }

  dimension: quantity_bucket {
    type: string
    sql: ${TABLE}.quantity_bucket ;;
    description: "Quantity bucket"
  }

  # Date/Time Dimensions
  dimension_group: order_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.order_created_at ;;
    description: "Order creation timestamp"
  }

  dimension_group: processed {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.processed_at ;;
    description: "Order processed timestamp"
  }

  dimension_group: cancelled {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.cancelled_at ;;
    description: "Order cancelled timestamp"
  }

  # Measures
  measure: count {
    type: count
    description: "Number of order items"
    drill_fields: [order_item_detail*]
  }

  measure: count_orders {
    type: count_distinct
    sql: ${order_id} ;;
    description: "Number of unique orders"
  }

  measure: total_quantity {
    type: sum
    sql: ${quantity} ;;
    description: "Total quantity sold"
  }

  measure: total_revenue {
    type: sum
    sql: ${line_total} ;;
    description: "Total revenue"
    value_format_name: usd
  }

  measure: total_product_revenue {
    type: sum
    sql: ${line_price} ;;
    description: "Total product revenue (before discounts)"
    value_format_name: usd
  }

  measure: total_discount {
    type: sum
    sql: ${line_discount} ;;
    description: "Total discounts"
    value_format_name: usd
  }

  measure: total_tax {
    type: sum
    sql: ${line_tax} ;;
    description: "Total tax"
    value_format_name: usd
  }

  measure: total_shipping {
    type: sum
    sql: ${allocated_shipping} ;;
    description: "Total allocated shipping"
    value_format_name: usd
  }

  measure: average_unit_price {
    type: average
    sql: ${unit_price} ;;
    description: "Average unit price"
    value_format_name: usd
  }

  measure: average_quantity_per_line {
    type: average
    sql: ${quantity} ;;
    description: "Average quantity per line"
    value_format_name: decimal_1
  }

  measure: average_line_total {
    type: average
    sql: ${line_total} ;;
    description: "Average line total"
    value_format_name: usd
  }

  measure: discount_rate_overall {
    type: number
    sql: ${total_discount} / NULLIF(${total_product_revenue}, 0) ;;
    description: "Overall discount rate"
    value_format_name: percent_2
  }

  measure: items_with_discount {
    type: count
    filters: [has_discount: "yes"]
    description: "Number of items with discounts"
  }

  measure: gift_card_sales {
    type: sum
    sql: ${line_total} ;;
    filters: [is_gift_card: "yes"]
    description: "Gift card sales"
    value_format_name: usd
  }

  # Sets
  set: order_item_detail {
    fields: [
      order_id,
      order_name,
      product_title,
      variant_title,
      quantity,
      unit_price,
      line_total,
      discount_rate
    ]
  }
}
