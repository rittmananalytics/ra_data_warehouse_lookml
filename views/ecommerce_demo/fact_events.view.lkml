view: fact_events {
  sql_table_name: `@{PROJECT_ID}.@{ECOMMERCE_DATASET}.fact_events` ;;
  
  # Primary Key
  dimension: event_sk {
    primary_key: yes
    type: string
    sql: ${TABLE}.event_sk ;;
    description: "Event surrogate key"
  }

  # Foreign Keys
  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
    description: "Session ID from GA4"
  }

  dimension: event_date_key {
    type: number
    sql: ${TABLE}.event_date_key ;;
    description: "Event date key (YYYYMMDD)"
    hidden: yes
  }

  # Event Attributes
  dimension: event_name {
    type: string
    sql: ${TABLE}.event_name ;;
    description: "GA4 event name"
  }

  dimension: event_timestamp {
    type: number
    sql: ${TABLE}.event_timestamp ;;
    description: "Event timestamp"
  }

  dimension: page_location {
    type: string
    sql: ${TABLE}.page_location ;;
    description: "Page URL"
  }

  dimension: page_title {
    type: string
    sql: ${TABLE}.page_title ;;
    description: "Page title"
  }

  # Ecommerce Event Fields
  dimension: item_id {
    type: string
    sql: ${TABLE}.item_id ;;
    description: "Product ID for ecommerce events"
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
    description: "Product name for ecommerce events"
  }

  dimension: item_category {
    type: string
    sql: ${TABLE}.item_category ;;
    description: "Product category for ecommerce events"
  }

  dimension: item_price {
    type: number
    sql: ${TABLE}.item_price ;;
    value_format_name: usd
    description: "Product price for ecommerce events"
  }

  dimension: item_quantity {
    type: number
    sql: ${TABLE}.item_quantity ;;
    description: "Product quantity for ecommerce events"
  }

  # Measures
  measure: event_count {
    type: count
    description: "Total number of events"
  }

  measure: unique_sessions {
    type: count_distinct
    sql: ${session_id} ;;
    description: "Number of unique sessions"
  }

  measure: page_views {
    type: count
    filters: [event_name: "page_view"]
    description: "Total page views"
  }

  measure: add_to_cart_events {
    type: count
    filters: [event_name: "add_to_cart"]
    description: "Add to cart events"
  }

  measure: purchase_events {
    type: count
    filters: [event_name: "purchase"]
    description: "Purchase events"
  }

  measure: total_item_revenue {
    type: sum
    sql: ${item_price} * ${item_quantity} ;;
    value_format_name: usd
    description: "Total revenue from items"
  }
}