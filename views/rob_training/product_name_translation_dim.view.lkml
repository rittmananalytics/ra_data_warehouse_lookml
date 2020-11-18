view: product_name_translation_dim {
  sql_table_name: `ra-development.rob_training.wh_product_name_translation_dim`
    ;;
  label: "Products"

  dimension: product_category_name {
    type: string
    sql: ${TABLE}.product_category_name ;;
  }

  dimension: product_category_name_english {
    type: string
    sql: ${TABLE}.product_category_name_english ;;
  }

  dimension: product_category_name_english_pivot {
    type: string
    sql: ${TABLE}.product_category_name_english ;;
  }
}
