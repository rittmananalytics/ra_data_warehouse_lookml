view: gcp_billing_fact {
  sql_table_name: `ra-development.analytics.gcp_billing_fact`
    ;;

  dimension: avg_currency_conversion_rate {
    type: number
    hidden: yes
    sql: ${TABLE}.avg_currency_conversion_rate ;;
  }

  dimension: billing_account_id {
    hidden: yes

    type: string
    sql: ${TABLE}.billing_account_id ;;
  }

  dimension: billing_data_country {
    group_label: "GCP Billing"
    type: string
    sql: ${TABLE}.billing_data_country ;;
  }

  dimension: billing_data_location {
    group_label: "GCP Billing"

    type: string
    sql: ${TABLE}.billing_data_location ;;
  }

  dimension_group: billing {
    group_label: "GCP Billing"

    type: time
    timeframes: [month,month_num,quarter,quarter_of_year,year]
    sql: parse_timestamp('%Y%m',${TABLE}.billing_month)  ;;
  }

  dimension: company_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension: currency {
    group_label: "GCP Billing"

    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: description {
    label: "Product"
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: gcp_billing_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.gcp_billing_pk ;;
  }

  dimension: pricing_unit {
    group_label: "GCP Billing"

    type: string
    sql: ${TABLE}.pricing_unit ;;
  }

  dimension: project_id {
    group_label: "GCP Billing"

    type: string
    sql: ${TABLE}.project_id ;;
  }

  dimension: region {
    group_label: "GCP Billing"

    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: service_id {
    hidden: yes

    type: string
    sql: ${TABLE}.service_id ;;
  }

  dimension: total_amount_in_pricing_units {
    hidden: yes

    type: number
    sql: ${TABLE}.total_amount_in_pricing_units ;;
  }

  dimension: cost {
    hidden: yes

    type: number
    sql: ${TABLE}.total_cost ;;
  }

  measure: total_cost {
    group_label: "GCP Billing"


    type: sum
    value_format_name: gbp
    sql: ${TABLE}.total_cost ;;
  }

  dimension: usage_amount {
    hidden: yes

    type: number
    sql: ${TABLE}.total_usage_amount ;;
  }

  measure: total_usage_amount {
    group_label: "GCP Billing"


    type: sum
    sql: ${TABLE}.total_usage_amount ;;
  }

  dimension: unit {
    group_label: "GCP Billing"

    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: zone {
    group_label: "GCP Billing"

    type: string
    sql: ${TABLE}.zone ;;
  }

  measure: count {
    hidden: yes

    type: count
    drill_fields: []
  }
}
