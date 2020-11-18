view: customers_dim {
  sql_table_name: `ra-development.rob_training.customers_dim`
    ;;

  dimension: customer_city {
    type: string
    sql: ${TABLE}.customer_city ;;
  }

  dimension: customer_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.customer_id ;;
  }

  dimension: customer_state {
    type: string
    sql: ${TABLE}.customer_state ;;
  }

  dimension: customer_unique_id {
    type: string
    sql: ${TABLE}.customer_unique_id ;;
  }

  dimension: customer_zip_code_prefix {
    type: number
    sql: ${TABLE}.customer_zip_code_prefix ;;
  }

  measure: count_of_customers{
    type: number
    drill_fields: []
    sql:  count(distinct ${customer_unique_id});;
  }

  measure: count_new_customers{
    label: "Number of New Customers"
    description: "This is the count of total users who have a first order present within the selected time window."
    type: count_distinct
    filters: [orders_fact.new_customer: "yes"]
    sql:  ${TABLE}.customer_unique_id ;;
  }

  measure: count_existing_users{
    label: "Number of Existing Customers"
    description: "This is the count of total users who have a first order prior to the start of the selected time window."
    type: count_distinct
    filters: [orders_fact.existing_customer: "yes"]
    sql:  ${TABLE}.customer_unique_id ;;
  }

  measure: count_first_time_users{
    label: "Number of First Time Purchasers"
    description: "This is the count of total users who have placed their first chronological order in the period selected."
    type: count_distinct
    filters: [orders_fact.order_seq_num: "1"]
    sql:  ${TABLE}.customer_unique_id ;;
  }

  measure: percentage_first_time_users{
    label: "Percentage Of Returning Customers"
    description: "This is the count of total users who have placed their first chronological order in the period selected."
    type: number
    value_format: "00.00%"
    sql:  ${count_existing_users} / ${count_of_customers} ;;
  }

}
