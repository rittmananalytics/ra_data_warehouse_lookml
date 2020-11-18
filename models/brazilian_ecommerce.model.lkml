connection: "ra_dw_prod"

# include all the views
include: "/views/**/*.view"

named_value_format: real_formatting {
  value_format: "\"R\"$#,###.00"
  strict_value_format: yes
}

explore: orders_fact {
  label: "Orders"
  view_label: "Orders"

  join: customers_dim {
    view_label: "Customers"
    sql_on: ${orders_fact.customer_id} = ${customers_dim.customer_id};;
    type: left_outer
    relationship: many_to_one #write the relations!
  }

  join: order_review_fact {
    view_label: "Reviews" # do labels!
    sql_on: ${orders_fact.order_id} = ${order_review_fact.order_id};;
    type: left_outer
    relationship: many_to_one #write the relations!
  }

  join: order_payments_fact {
    view_label: "Payments" # do labels!
    sql_on: ${orders_fact.order_id} = ${order_payments_fact.order_id};;
    type: left_outer
    relationship: one_to_many #write the relations!
  }

  join: order_items_fact {
    view_label: "Orders"
    sql_on: ${orders_fact.order_id} = ${order_items_fact.order_id} ;;
    type: left_outer
    relationship: one_to_many #write the relations!
  }

  join: products_dim {
    view_label: "Products"
    sql_on: ${order_items_fact.product_id} = ${products_dim.product_id} ;;
    type: full_outer
    relationship: many_to_one #write the relations!
  }

  join: product_name_translation_dim {
    view_label: "Products"
    sql_on: ${products_dim.product_category_name} = ${product_name_translation_dim.product_category_name} ;;
    type: left_outer
    relationship: many_to_one #write the relations!
  }

  join: sellers_dim {
    view_label: "Sellers"
    sql_on: ${order_items_fact.seller_id} = ${sellers_dim.seller_id} ;;
    type: full_outer
    relationship: many_to_one
  }

  join: geolocation_fact {
    view_label: "Sellers"
    sql_on: ${sellers_dim.seller_zip_code_prefix} = ${geolocation_fact.geolocation_zip_code_prefix} ;;
    type: left_outer
    relationship: many_to_one
  }

}
