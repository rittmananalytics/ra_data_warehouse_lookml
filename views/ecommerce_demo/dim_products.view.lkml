view: dim_products {
  sql_table_name: `ra-development.analytics_ecommerce_ecommerce.dim_products` ;;

  # Primary Key
  dimension: product_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.product_key ;;
    description: "Product surrogate key"
  }

  # Business Key
  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
    description: "Original product business key"
  }

  # Product Identification
  dimension: handle {
    type: string
    sql: ${TABLE}.handle ;;
    description: "Product URL handle"
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
    description: "Product title"
  }

  dimension: vendor {
    type: string
    sql: ${TABLE}.vendor ;;
    description: "Product vendor/brand"
  }

  dimension: product_type {
    type: string
    sql: ${TABLE}.product_type ;;
    description: "Product type/category"
  }

  # Product Details
  dimension: body_html {
    type: string
    sql: ${TABLE}.body_html ;;
    description: "Product description HTML"
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    description: "Product status (active, draft, archived)"
  }

  dimension: tags {
    type: string
    sql: ${TABLE}.tags ;;
    description: "Product tags (comma-separated)"
  }

  # Pricing Information
  dimension: price {
    type: number
    sql: ${TABLE}.price ;;
    description: "Product price"
    value_format_name: usd
  }

  dimension: compare_at_price {
    type: number
    sql: ${TABLE}.compare_at_price ;;
    description: "Compare at price (MSRP)"
    value_format_name: usd
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
    description: "Product cost"
    value_format_name: usd
  }

  # Pricing Calculations
  dimension: discount_amount {
    type: number
    sql: ${compare_at_price} - ${price} ;;
    description: "Discount amount"
    value_format_name: usd
  }

  dimension: discount_percentage {
    type: number
    sql: CASE
      WHEN ${compare_at_price} > 0
      THEN ((${compare_at_price} - ${price}) / ${compare_at_price}) * 100
      ELSE 0
    END ;;
    description: "Discount percentage"
    value_format_name: percent_1
  }

  dimension: margin_amount {
    type: number
    sql: ${price} - ${cost} ;;
    description: "Gross margin amount"
    value_format_name: usd
  }

  dimension: margin_percentage {
    type: number
    sql: CASE
      WHEN ${price} > 0
      THEN ((${price} - ${cost}) / ${price}) * 100
      ELSE 0
    END ;;
    description: "Gross margin percentage"
    value_format_name: percent_1
  }

  # Inventory Management
  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
    description: "Stock keeping unit"
  }

  dimension: barcode {
    type: string
    sql: ${TABLE}.barcode ;;
    description: "Product barcode"
  }

  dimension: inventory_quantity {
    type: number
    sql: ${TABLE}.inventory_quantity ;;
    description: "Current inventory quantity"
  }

  dimension: inventory_policy {
    type: string
    sql: ${TABLE}.inventory_policy ;;
    description: "Inventory policy (deny, continue)"
  }

  dimension: fulfillment_service {
    type: string
    sql: ${TABLE}.fulfillment_service ;;
    description: "Fulfillment service"
  }

  dimension: inventory_management {
    type: string
    sql: ${TABLE}.inventory_management ;;
    description: "Inventory management system"
  }

  # Physical Attributes
  dimension: weight {
    type: number
    sql: ${TABLE}.weight ;;
    description: "Product weight"
    value_format_name: decimal_2
  }

  dimension: weight_unit {
    type: string
    sql: ${TABLE}.weight_unit ;;
    description: "Weight unit (grams, pounds, etc.)"
  }

  dimension: requires_shipping {
    type: yesno
    sql: ${TABLE}.requires_shipping ;;
    description: "Product requires shipping"
  }

  dimension: taxable {
    type: yesno
    sql: ${TABLE}.taxable ;;
    description: "Product is taxable"
  }

  # Product Categorization
  dimension: price_tier {
    type: tier
    tiers: [0, 25, 50, 100, 250, 500, 1000]
    style: relational
    sql: ${price} ;;
    description: "Price tier categorization"
  }

  dimension: inventory_status {
    type: string
    sql: CASE
      WHEN ${inventory_quantity} <= 0 THEN 'Out of Stock'
      WHEN ${inventory_quantity} <= 10 THEN 'Low Stock'
      WHEN ${inventory_quantity} <= 50 THEN 'Medium Stock'
      ELSE 'High Stock'
    END ;;
    description: "Inventory status based on quantity"
  }

  dimension: margin_category {
    type: string
    sql: CASE
      WHEN ${margin_percentage} < 20 THEN 'Low Margin'
      WHEN ${margin_percentage} < 40 THEN 'Medium Margin'
      ELSE 'High Margin'
    END ;;
    description: "Margin category"
  }

  # SCD Type 2 Fields
  dimension_group: valid_from {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: timestamp
    sql: ${TABLE}.valid_from ;;
    description: "Valid from date for SCD Type 2"
  }

  dimension_group: valid_to {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: timestamp
    sql: ${TABLE}.valid_to ;;
    description: "Valid to date for SCD Type 2"
  }

  dimension: is_current {
    type: yesno
    sql: ${TABLE}.is_current ;;
    description: "Current version indicator"
  }

  dimension_group: created {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: timestamp
    sql: ${TABLE}.created_at ;;
    description: "Product creation date"
  }

  dimension_group: updated {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: timestamp
    sql: ${TABLE}.updated_at ;;
    description: "Product last update date"
  }

  dimension_group: published {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: timestamp
    sql: ${TABLE}.published_at ;;
    description: "Product publish date"
  }

  # Measures
  measure: count {
    type: count
    drill_fields: [product_id, title, vendor, product_type, price]
  }

  measure: count_current {
    type: count
    filters: [is_current: "yes"]
    description: "Count of current product records"
  }

  measure: count_active {
    type: count
    filters: [status: "active", is_current: "yes"]
    description: "Count of active products"
  }

  measure: average_price {
    type: average
    sql: ${price} ;;
    value_format_name: usd
    description: "Average product price"
  }

  measure: total_inventory_value {
    type: sum
    sql: ${price} * ${inventory_quantity} ;;
    value_format_name: usd
    description: "Total inventory value at current prices"
  }

  measure: average_margin_percentage {
    type: average
    sql: ${margin_percentage} ;;
    value_format_name: percent_1
    description: "Average gross margin percentage"
  }

  measure: total_inventory_quantity {
    type: sum
    sql: ${inventory_quantity} ;;
    description: "Total inventory quantity"
  }

  measure: count_out_of_stock {
    type: count
    filters: [inventory_quantity: "<=0", is_current: "yes"]
    description: "Count of out of stock products"
  }

  measure: count_low_stock {
    type: count
    filters: [inventory_quantity: "<=10", is_current: "yes"]
    description: "Count of low stock products"
  }
}
