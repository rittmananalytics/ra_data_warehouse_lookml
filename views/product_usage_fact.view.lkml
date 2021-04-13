view: product_usage_fact {
  sql_table_name: `ra-development.analytics.product_usage_fact`
    ;;

  dimension: company_id {
    hidden: yes
    type: string
    sql: ${TABLE}.company_id ;;
  }

  dimension: company_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension: contact_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_pk ;;
  }

  dimension: product_account_id {
    group_label: "Product Usage"

    type: string
    sql: ${TABLE}.product_account_id ;;
  }

  dimension: product_currency_conversion_rate {
    group_label: "Product Usage"

    type: number
    sql: ${TABLE}.product_currency_conversion_rate ;;
  }

  dimension: product_id {
    hidden: yes
    type: string
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.product_pk ;;
  }

  dimension: product_project_id {
    group_label: "Product Usage"

    type: string
    sql: ${TABLE}.product_project_id ;;
  }

  dimension: product_sku_id {
    hidden: yes
    type: string
    sql: ${TABLE}.product_sku_id ;;
  }

  dimension: product_usage_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.product_usage_amount ;;
  }

  measure: total_product_usage_amount {
    group_label: "Product Usage"

    type: sum_distinct
    value_format_name: decimal_2
    sql: ${product_usage_cost} ;;
  }
  dimension_group: product_usage_billing_ts {
    group_label: "Product Usage"
    label: "Product Usage"

    type: time
    timeframes: [
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.product_usage_billing_ts ;;
  }

  dimension: product_usage_cost {
    hidden: yes
    type: number
    sql: ${TABLE}.product_usage_cost ;;
  }

  measure: avg_usage_cost {
    group_label: "Product Usage"

    type: average_distinct
    value_format_name: decimal_2
    sql: ${product_usage_cost} ;;
  }

  measure: total_usage_cost {
    group_label: "Product Usage"

    type: sum_distinct
    value_format_name: decimal_2
    sql: ${product_usage_cost} ;;
  }

  dimension: product_usage_country {
    group_label: "Product Usage"

    type: string
    sql: ${TABLE}.product_usage_country ;;
  }

  dimension: product_usage_currency {
    group_label: "Product Usage"

    type: string
    sql: ${TABLE}.product_usage_currency ;;
  }

  dimension_group: product_usage_end_ts {
    hidden: yes
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
    sql: ${TABLE}.product_usage_end_ts ;;
  }

  dimension_group: product_usage_duration {
    group_label: "Product Usage"
    hidden: yes
    type: duration
    timeframes: [second]
    sql_start: ${TABLE}.product_usage_start_ts ;;
    sql_end: ${TABLE}.product_usage_end_ts ;;
  }

  measure: average_duration_secs {
    type: average_distinct
    sql: ${seconds_product_usage_duration} ;;
  }

  dimension: product_usage_error_code {
    group_label: "Product Usage"

    type: string
    sql: ${TABLE}.product_usage_error_code ;;
  }

  dimension: product_usage_error_status {
    group_label: "Product Usage"

    type: string
    sql: ${TABLE}.product_usage_error_status ;;
  }

  dimension: product_usage_job_id {
    group_label: "Product Usage"

    type: string
    sql: ${TABLE}.product_usage_job_id ;;
  }

  dimension: product_usage_location {
    group_label: "Product Usage"

    type: string
    sql: ${TABLE}.product_usage_location ;;
  }

  dimension: product_usage_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.product_usage_pk ;;
  }

  dimension: product_usage_priority {
    group_label: "Product Usage"

    type: string
    sql: ${TABLE}.product_usage_priority ;;
  }

  dimension: product_usage_query_hash {
    group_label: "Product Usage"

    type: string
    sql: ${TABLE}.product_usage_query_hash ;;
  }

  dimension: product_usage_query_text {
    group_label: "Product Usage"

    type: string
    sql: ${TABLE}.product_usage_query_text ;;
  }

  dimension: product_usage_region {
    group_label: "Product Usage"

    type: string
    sql: ${TABLE}.product_usage_region ;;
  }

  dimension: product_usage_row_count {
    hidden: yes
    type: number
    sql: ${TABLE}.product_usage_row_count ;;
  }

  measure: total_row_count {
    group_label: "Product Usage"

    type: sum
    sql: ${product_usage_row_count} ;;
  }

  measure: avg_row_count {
    group_label: "Product Usage"

    type: average
    sql: ${product_usage_row_count} ;;
  }

  dimension_group: product_usage_start_ts {
    group_label: "Product Usage"
    hidden: yes
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
    sql: ${TABLE}.product_usage_start_ts ;;
  }

  measure: count {
    type: count_distinct
  }

  dimension: product_usage_status {
    group_label: "Product Usage"

    type: string
    sql: ${TABLE}.product_usage_status ;;
  }

  dimension: product_usage_unit {
    group_label: "Product Usage"

    type: string
    sql: ${TABLE}.product_usage_unit ;;
  }

  dimension: product_usage_zone {
    group_label: "Product Usage"

    type: string
    sql: ${TABLE}.product_usage_zone ;;
  }

  dimension: source {
    group_label: "Product Usage"

    type: string
    sql: ${TABLE}.source ;;
  }


}
