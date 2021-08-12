# The name of this view in Looker is "Chart of Accounts Dim"
view: chart_of_accounts_dim {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics.chart_of_accounts_dim`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Account Bank Account Number" in Explore.

  dimension: account_bank_account_number {
    hidden: yes
    type: string
    sql: ${TABLE}.account_bank_account_number ;;
  }

  dimension: account_bank_account_type {
    group_label: "Account Details"

    type: string
    sql: ${TABLE}.account_bank_account_type ;;
  }

  dimension: account_class {
    group_label: "Account Details"

    type: string
    sql: ${TABLE}.account_class ;;
  }

  dimension: account_code {
    group_label: "Account Details"
    label: "   Account Code"
    order_by_field: account_report_order

    type: string
    sql: ${TABLE}.account_code ;;
  }

  dimension: account_currency_code {
    group_label: "Account Details"

    type: string
    sql: ${TABLE}.account_currency_code ;;
  }

  dimension: account_description {
    group_label: "Account Details"
    label: "  Account Description"

    type: string
    sql: ${TABLE}.account_description ;;
  }

  dimension: account_enable_payments_to_account {
    hidden: yes
    type: yesno
    sql: ${TABLE}.account_enable_payments_to_account ;;
  }

  dimension: account_id {
    group_label: "Account Details"
    order_by_field: account_report_order

    type: string
    sql: ${TABLE}.account_id ;;
  }

  dimension: account_is_system_account {
    group_label: "Account Details"

    type: string
    sql: ${TABLE}.account_is_system_account ;;
  }

  dimension: account_name {
    group_label: "Account Details"
    label: "    Account Name"
    order_by_field: account_report_order
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: account_pk {
    type: string
    primary_key: yes
    sql: ${TABLE}.account_pk ;;
  }

  dimension: account_report_category {
    group_label: "Reporting"

    type: string
    order_by_field: account_report_category_order
    sql: ${TABLE}.account_report_category ;;
  }

  dimension: account_report_category_order {
    group_label: "Reporting"
    hidden: yes
    type: number
    sql: ${TABLE}.account_report_category_order ;;
  }

  dimension: account_report_group {
    group_label: "Reporting"

    type: string
    sql: ${TABLE}.account_report_group ;;
  }

  dimension: account_report_order {
    group_label: "Reporting"
    type: number
    sql: ${TABLE}.account_report_order ;;
  }

  dimension: account_report_sub_category {
    group_label: "Reporting"
    order_by_field: account_report_sub_category_order
    type: string
    sql: ${TABLE}.account_report_sub_category ;;
  }

  dimension: account_report_sub_category_order {
    group_label: "Reporting"
    hidden: yes
    type: number
    sql: ${TABLE}.account_report_sub_category ;;
  }

  dimension: account_reporting_code {
    group_label: "Reporting"

    type: string
    sql: ${TABLE}.account_reporting_code ;;
  }

  dimension: account_reporting_code_name {
    group_label: "Reporting"

    type: string
    sql: ${TABLE}.account_reporting_code_name ;;
  }

  dimension: account_show_in_expense_claims {
    group_label: "Account Details"

    type: yesno
    sql: ${TABLE}.account_show_in_expense_claims ;;
  }

  dimension: account_status {
    group_label: "Account Settings"

    type: string
    sql: ${TABLE}.account_status ;;
  }

  dimension: account_tax_type {
    group_label: "Account Details"

    type: string
    sql: ${TABLE}.account_tax_type ;;
  }

  dimension: account_type {
    group_label: "Account Details"

    type: string
    sql: ${TABLE}.account_type ;;
  }

  dimension: source {
    group_label: "Account Details"
    hidden: yes
    type: string
    sql: ${TABLE}.source ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are count, sum, and average
  # measures for numeric dimensions, but you can also add measures of many different types.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.



  # These sum and average measures are hidden by default.
  # If you want them to show up in your explore, remove hidden: yes.


}
