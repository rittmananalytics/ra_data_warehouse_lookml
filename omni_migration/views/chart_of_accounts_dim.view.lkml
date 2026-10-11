view: chart_of_accounts_dim {
  sql_table_name: `ra-development.analytics.chart_of_accounts_dim` ;;

  dimension: account_bank_account_number {
    type: string
    hidden: yes
    sql: ${TABLE}.account_bank_account_number ;;
  }

  dimension: account_bank_account_type {
    type: string
    group_label: "Account Details"
    sql: ${TABLE}.account_bank_account_type ;;
  }

  dimension: account_class {
    type: string
    group_label: "Account Details"
    sql: ${TABLE}.account_class ;;
  }

  dimension: account_code {
    type: string
    label: "Account Code"
    group_label: "Account Details"
    sql: ${TABLE}.account_code ;;
    order_by_field: account_report_order
  }

  dimension: account_currency_code {
    type: string
    group_label: "Account Details"
    sql: ${TABLE}.account_currency_code ;;
  }

  dimension: account_description {
    type: string
    label: "Account Description"
    group_label: "Account Details"
    sql: ${TABLE}.account_description ;;
  }

  dimension: account_enable_payments_to_account {
    type: yesno
    hidden: yes
    sql: ${TABLE}.account_enable_payments_to_account ;;
  }

  dimension: account_id {
    type: string
    group_label: "Account Details"
    sql: ${TABLE}.account_id ;;
    order_by_field: account_report_order
  }

  dimension: account_is_system_account {
    type: string
    group_label: "Account Details"
    sql: ${TABLE}.account_is_system_account ;;
  }

  dimension: account_name {
    type: string
    label: "Account Name"
    group_label: "Account Details"
    sql: ${TABLE}.account_name ;;
    order_by_field: account_report_order
  }

  dimension: account_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.account_id ;;
  }

  dimension: account_report_category {
    type: string
    group_label: "Reporting"
    sql: ${TABLE}.account_report_category ;;
    order_by_field: account_report_category_order
  }

  dimension: account_report_category_order {
    type: number
    group_label: "Reporting"
    hidden: yes
    sql: ${TABLE}.account_report_category_order ;;
  }

  dimension: account_report_group {
    type: string
    group_label: "Reporting"
    sql: ${TABLE}.account_report_group ;;
  }

  dimension: account_report_order {
    type: number
    group_label: "Reporting"
    sql: ${TABLE}.account_report_order ;;
  }

  dimension: account_report_sub_category {
    type: string
    group_label: "Reporting"
    sql: ${TABLE}.account_report_sub_category ;;
    order_by_field: account_report_sub_category_order
  }

  dimension: account_report_sub_category_order {
    type: number
    group_label: "Reporting"
    hidden: yes
    sql: ${account_report_sub_category} ;;
  }

  dimension: account_reporting_code {
    type: string
    group_label: "Reporting"
    sql: ${TABLE}.account_reporting_code ;;
  }

  dimension: account_reporting_code_name {
    type: string
    group_label: "Reporting"
    sql: ${TABLE}.account_reporting_code_name ;;
  }

  dimension: account_show_in_expense_claims {
    type: yesno
    group_label: "Account Details"
    sql: ${TABLE}.account_show_in_expense_claims ;;
  }

  dimension: account_status {
    type: string
    group_label: "Account Settings"
    sql: ${TABLE}.account_status ;;
  }

  dimension: account_tax_type {
    type: string
    group_label: "Account Details"
    sql: ${TABLE}.account_tax_type ;;
  }

  dimension: account_type {
    type: string
    group_label: "Account Details"
    sql: ${TABLE}.account_type ;;
  }
}
