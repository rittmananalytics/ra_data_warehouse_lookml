view: order_items_fact {
  sql_table_name: `ra-development.rob_training.wh_order_items_fact`
    ;;

  dimension: order_item_pk {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.order_item_pk ;;
  }

  dimension: freight_value {
    type: number
    sql: ${TABLE}.freight_value ;;
  }

  dimension: order_id {
    type: string
    sql: ${TABLE}.order_id ;;
  }

  dimension: order_item_id {
    type: number
    sql: ${TABLE}.order_item_id ;;
  }

  measure: revenue {
    type: sum
    value_format_name: real_formatting
    sql: ${TABLE}.price ;;
  }

  measure: returning_revenue {
    type: sum
    value_format_name: real_formatting
    sql: ${TABLE}.price ;;
    filters: [orders_fact.existing_customer: "yes"]
  }

  dimension: price {
    type: number
    value_format_name: real_formatting
    sql: round(${TABLE}.price) ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
  }

  dimension: seller_id {
    type: string
    sql: ${TABLE}.seller_id ;;
  }

  dimension_group: shipping_limit {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.shipping_limit_date ;;
  }

  measure: count_of_order_items {
    type: count
    drill_fields: []
  }

}
