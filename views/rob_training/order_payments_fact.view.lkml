view: order_payments_fact {
  sql_table_name: `ra-development.rob_training.wh_order_payment_fact`
    ;;

  dimension: order_payment_id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.order_payment_id ;;
  }

  dimension: order_id {
    type: string
    sql: ${TABLE}.order_id ;;
  }

  dimension: payment_installments {
    type: number
    sql: ${TABLE}.payment_installments ;;
  }

  dimension: payment_sequential {
    type: number
    sql: ${TABLE}.payment_sequential ;;
  }

  dimension: payment_type {
    type: string
    sql: ${TABLE}.payment_type ;;
  }

  dimension: payment_value {
    type: number
    sql: ${TABLE}.payment_value ;;
  }

  measure: count_of_payments {
    type: count
    drill_fields: []
  }
}
