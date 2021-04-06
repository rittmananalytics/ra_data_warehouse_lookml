view: products_dim {
  sql_table_name: `ra-development.analytics.products_dim`
    ;;

  dimension: product_id {
    group_label: "Product Details"
    hidden: yes
    type: string
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_name {
    group_label: "Product Details"

    type: string
    sql: ${TABLE}.product_name ;;
  }

  dimension: product_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.product_pk ;;
  }

  dimension: product_sku_id {
    hidden: yes
    type: string
    sql: ${TABLE}.product_sku_id ;;
  }

  dimension: product_sku_name {
    group_label: "Product Details"

    type: string
    sql: ${TABLE}.product_sku_name ;;
  }

  dimension: product_source_id {
    hidden: yes
    type: string
    sql: ${TABLE}.product_source_id ;;
  }

  dimension: product_source_name {
    group_label: "Product Details"
    type: string
    sql: ${TABLE}.product_source_name ;;
  }

  dimension: source {
    group_label: "Product Details"

    type: string
    sql: ${TABLE}.source ;;
  }


}
