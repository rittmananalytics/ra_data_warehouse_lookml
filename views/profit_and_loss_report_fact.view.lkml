# The name of this view in Looker is "Profit and Loss Report Fact"
view: profit_and_loss_report_fact {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics.profit_and_loss_report_fact`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Account Class" in Explore.

  dimension: account_class {
    hidden: no
    type: string
    sql: ${TABLE}.account_class ;;
  }

  dimension: account_code {
    hidden: no

    type: string
    sql: ${TABLE}.account_code ;;
  }

  dimension: account_id {
    type: string
    sql: ${TABLE}.account_id ;;
  }

  dimension: account_name {
    hidden: no
    order_by_field: account_report_order
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: account_report_category {
    hidden: no
    order_by_field: account_report_category_order
    type: string
    description: "Top-level P&L account grouping; Revenue, Cost of Delivery, Overheads, Dividends and Retained Earnings"
    sql: ${TABLE}.account_report_category ;;
  }

  dimension: account_report_group {
    hidden: no
    order_by_field: account_report_order
    description: "Second-level P&L account grouping, drill-down from Account Report Category"
    type: string
    sql: ${TABLE}.account_report_group ;;
  }

  dimension: account_report_order {
    hidden: yes
    description: "Used for sorting account names in the P&L report"

    type: number
    sql: ${TABLE}.account_report_order ;;
  }




  dimension: account_report_category_order {
    description: "Used for sorting Account Report Categories in the P&L report"
    hidden: yes
    type: number
    sql: ${TABLE}.account_report_category_order ;;
  }



  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: period {
    type: time
    timeframes: [
      raw,
      month,
      month_num,
      quarter,
      year,
      fiscal_month_num,
      fiscal_quarter_of_year,
      fiscal_quarter,
      fiscal_year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_month ;;
  }

  measure: amount {
    label: "Retained Earnings"
    description: "Profit after all costs including taxation and dividends"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.net_amount  ;;
  }

  measure: revenue {
    type: sum
    description: "Sales revenue from consulting projects and other services"
    value_format_name: gbp
    sql: ${TABLE}.net_amount  ;;
    filters: [account_report_category: "Revenue"]
  }

  measure: cost_of_delivery {
    description: "Direct costs e.g. consultants wages, delivery software etc incurred in delivering consulting projects and other services"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.net_amount  ;;
    filters: [account_report_category: "Cost of Delivery"]
  }

  measure: overheads {
    type: sum
    description: "Fixed costs incurred in running the business, e.g. back-office, sales commission, legal and accountancy costs that are not directly linked to delivering specific consulting projects and other services"

    value_format_name: gbp
    sql: ${TABLE}.net_amount  ;;
    filters: [account_report_category: "Overheads"]
  }

  measure: taxation {
    description: "Corporation tax levied on net profits before payment of dividends"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.net_amount  ;;
    filters: [account_report_category: "Taxation"]
  }

  measure: dividends {
    type: sum
    description: "Payments to shareholders made from post-taxation net profit"
    value_format_name: gbp
    sql: ${TABLE}.net_amount  ;;
    filters: [account_report_category: "Dividends"]
  }

  measure: budget {
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.net_budget_amount ;;
  }

  measure: budget_variance {
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.net_budget_variance ;;
  }



  dimension: profit_and_loss_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.profit_and_loss_pk ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are count, sum, and average
  # measures for numeric dimensions, but you can also add measures of many different types.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.



  # These sum and average measures are hidden by default.
  # If you want them to show up in your explore, remove hidden: yes.


}
