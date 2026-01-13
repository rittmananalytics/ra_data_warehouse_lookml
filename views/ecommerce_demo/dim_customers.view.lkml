view: dim_customers {
  sql_table_name: `ra-development.analytics_ecommerce_ecommerce.dim_customers` ;;

  # Primary Key
  dimension: customer_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.customer_key ;;
    description: "Customer surrogate key"
  }

  # Business Key
  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
    description: "Original customer business key"
  }

  # Customer Attributes
  dimension: customer_email {
    type: string
    sql: ${TABLE}.customer_email ;;
    description: "Customer email address"
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
    description: "Customer first name"
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
    description: "Customer last name"
  }

  dimension: full_name {
    type: string
    sql: ${TABLE}.full_name ;;
    description: "Customer full name"
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
    description: "Customer phone number"
  }

  # Address Information
  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    description: "City"
  }

  dimension: state_province {
    type: string
    sql: ${TABLE}.state_province ;;
    description: "State or province"
  }

  dimension: state_province_code {
    type: string
    sql: ${TABLE}.state_province_code ;;
    description: "State or province code"
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
    description: "Country"
  }

  dimension: country_code {
    type: string
    sql: ${TABLE}.country_code ;;
    description: "Country code"
  }

  dimension: postal_code {
    type: string
    sql: ${TABLE}.postal_code ;;
    description: "Postal/ZIP code"
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
    description: "Geographic region"
  }

  # Customer Status
  dimension: customer_state {
    type: string
    sql: ${TABLE}.customer_state ;;
    description: "Customer account state"
  }

  dimension: accepts_marketing {
    type: yesno
    sql: ${TABLE}.accepts_marketing ;;
    description: "Customer accepts marketing communications"
  }

  # Customer Lifetime Metrics
  dimension: shopify_lifetime_value {
    type: number
    sql: ${TABLE}.shopify_lifetime_value ;;
    description: "Lifetime value from Shopify"
    value_format_name: usd
  }

  dimension: shopify_order_count {
    type: number
    sql: ${TABLE}.shopify_order_count ;;
    description: "Order count from Shopify"
  }

  dimension: calculated_lifetime_value {
    type: number
    sql: ${TABLE}.calculated_lifetime_value ;;
    description: "Calculated lifetime value"
    value_format_name: usd
  }

  dimension: calculated_order_count {
    type: number
    sql: ${TABLE}.calculated_order_count ;;
    description: "Calculated order count"
  }

  dimension: avg_order_value {
    type: number
    sql: ${TABLE}.avg_order_value ;;
    description: "Average order value"
    value_format_name: usd
  }

  # Customer Date Dimensions
  dimension_group: first_order {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.first_order_date ;;
    description: "Date of first order"
  }

  dimension_group: last_order {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.last_order_date ;;
    description: "Date of last order"
  }

  dimension: days_since_first_order {
    type: number
    sql: ${TABLE}.days_since_first_order ;;
    description: "Days since first order"
  }

  dimension: days_since_last_order {
    type: number
    sql: ${TABLE}.days_since_last_order ;;
    description: "Days since last order"
  }

  # Customer Segmentation
  dimension: customer_segment {
    type: string
    sql: ${TABLE}.customer_segment ;;
    description: "Customer segment"
  }

  dimension: customer_lifecycle_stage {
    type: string
    sql: ${TABLE}.customer_lifecycle_stage ;;
    description: "Customer lifecycle stage"
  }

  dimension: customer_value_tier {
    type: string
    sql: ${TABLE}.customer_value_tier ;;
    description: "Customer value tier based on LTV"
  }

  dimension: recency_segment {
    type: string
    sql: ${TABLE}.recency_segment ;;
    description: "Customer recency segment"
  }

  dimension: aov_segment {
    type: string
    sql: ${TABLE}.aov_segment ;;
    description: "Average order value segment"
  }

  # Data Quality Flags
  dimension: has_email {
    type: yesno
    sql: ${TABLE}.has_email ;;
    description: "Customer has email address"
  }

  dimension: has_phone {
    type: yesno
    sql: ${TABLE}.has_phone ;;
    description: "Customer has phone number"
  }

  dimension: has_address {
    type: yesno
    sql: ${TABLE}.has_address ;;
    description: "Customer has address"
  }

  dimension: has_full_name {
    type: yesno
    sql: ${TABLE}.has_full_name ;;
    description: "Customer has full name"
  }

  # SCD Type 2 Fields
  dimension_group: effective_from {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: timestamp
    sql: ${TABLE}.effective_from ;;
    description: "Effective from date for SCD Type 2"
  }

  dimension_group: effective_to {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: timestamp
    sql: ${TABLE}.effective_to ;;
    description: "Effective to date for SCD Type 2"
  }

  dimension: is_current {
    type: yesno
    sql: ${TABLE}.is_current ;;
    description: "Current version indicator"
  }

  dimension_group: customer_created {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: timestamp
    sql: ${TABLE}.customer_created_at ;;
    description: "Customer creation date"
  }

  dimension_group: customer_updated {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: timestamp
    sql: ${TABLE}.customer_updated_at ;;
    description: "Customer last update date"
  }

  dimension_group: warehouse_updated {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: timestamp
    sql: ${TABLE}.warehouse_updated_at ;;
    description: "Warehouse update timestamp"
  }

  # Measures
  measure: count {
    type: count

  }

  measure: count_current {
    type: count
    filters: [is_current: "yes"]
    description: "Count of current customer records"
  }

  measure: count_accepts_marketing {
    type: count
    filters: [accepts_marketing: "yes", is_current: "yes"]
    description: "Count of customers accepting marketing"
  }

  measure: average_lifetime_value {
    type: average
    sql: ${calculated_lifetime_value} ;;
    value_format_name: usd
    description: "Average customer lifetime value"
  }

  measure: total_lifetime_value {
    type: sum
    sql: ${calculated_lifetime_value} ;;
    value_format_name: usd
    description: "Total customer lifetime value"
  }

  measure: average_orders_per_customer {
    type: average
    sql: ${calculated_order_count} ;;
    value_format_name: decimal_1
    description: "Average orders per customer"
  }

  measure: average_aov {
    type: average
    sql: ${avg_order_value} ;;
    value_format_name: usd
    description: "Average AOV across customers"
  }

  measure: marketing_opt_in_rate {
    type: number
    sql: COUNT(CASE WHEN ${accepts_marketing} AND ${is_current} THEN 1 END) / NULLIF(${count_current}, 0) ;;
    value_format_name: percent_1
    description: "Percentage of customers accepting marketing"
  }
}
