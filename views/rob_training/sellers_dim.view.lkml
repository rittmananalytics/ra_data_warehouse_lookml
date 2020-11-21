view: sellers_dim {
  sql_table_name: `ra-development.rob_training.sellers_dim`
    ;;

  dimension: seller_id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.seller_id ;;
  }

  dimension: seller_city {
    type: string
    sql: ${TABLE}.seller_city ;;
  }

  dimension: seller_state {
    type: string
    sql: ${TABLE}.seller_state ;;
  }

  dimension: seller_zip_code_prefix {
    type: number
    sql: ${TABLE}.seller_zip_code_prefix ;;
  }

  measure: count_of_sellers {
    type: count
    drill_fields: []
  }
}
