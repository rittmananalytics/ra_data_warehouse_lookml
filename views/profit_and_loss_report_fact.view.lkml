view: profit_and_loss_report_fact {

  sql_table_name: `ra-development.analytics.profit_and_loss_report_fact`
    ;;


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
    label: "Account"
    hidden: no
    order_by_field: account_report_order
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: account_report_category {
    label: "Account Category"

    hidden: no
    order_by_field: account_report_category_order
    type: string
    description: "Top-level P&L account grouping; Revenue, Cost of Delivery, Overheads, Dividends and Retained Earnings"
    sql: ${TABLE}.account_report_category ;;
  }

  dimension: account_report_group {
    label: "Account Group"
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
    group_label: "P&L Base Measures"

    type: sum
    value_format_name: gbp
    sql: ${TABLE}.net_amount  ;;
  }

  # Actuals for P&L Report Categories

  measure: revenue {
    group_label: "P&L Actuals"

    type: sum
    description: "Sales revenue from consulting projects and other services"
    value_format_name: gbp
    sql: ${TABLE}.net_amount  ;;
    filters: [account_report_category: "Revenue"]
  }

  measure: cost_of_delivery {
    group_label: "P&L Actuals"

    description: "Direct costs e.g. consultants wages, delivery software etc incurred in delivering consulting projects and other services"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.net_amount  ;;
    filters: [account_report_category: "Cost of Delivery"]
  }

  measure: overheads {
    group_label: "P&L Actuals"

    type: sum
    description: "Fixed costs incurred in running the business, e.g. back-office, sales commission, legal and accountancy costs that are not directly linked to delivering specific consulting projects and other services"

    value_format_name: gbp
    sql: ${TABLE}.net_amount  ;;
    filters: [account_report_category: "Overheads"]
  }

  measure: taxation {
    group_label: "P&L Actuals"

    description: "Corporation tax levied on net profits before payment of dividends"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.net_amount  ;;
    filters: [account_report_category: "Taxation"]
  }

  measure: dividends {
    group_label: "P&L Actuals"

    type: sum
    description: "Payments to shareholders made from post-taxation net profit"
    value_format_name: gbp
    sql: ${TABLE}.net_amount  ;;
    filters: [account_report_category: "Dividends"]
  }

  measure: retained_earnings {
    group_label: "P&L Actuals"

    label: "Retained Earnings"
    description: "Retained Earnings prior month (i.e. previous month)"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.net_amount  ;;
  }

  # Actuals Prior Month for P&L Report Categories

  measure: revenue_prior_month {
    group_label: "P&L Actuals Prior Month"
    type: period_over_period
    label: "Revenue Prior Month"
    description: "Sales Revenue prior month (i.e. previous month)"
    based_on: revenue
    based_on_time: period_month
    period: month
    value_format_name: gbp
    sql: ${TABLE}.net_amount  ;;
  }

  measure: cost_of_delivery_prior_month {
    group_label: "P&L Actuals Prior Month"
    type: period_over_period
    label: "Cost of Delivery Prior Month"
    description: "Cost of Delivery prior month (i.e. previous month)"
    based_on: cost_of_delivery
    based_on_time: period_month
    period: month
    value_format_name: gbp
    sql: ${TABLE}.net_amount  ;;
  }

  measure: overheads_prior_month {
    group_label: "P&L Actuals Prior Month"
    type: period_over_period
    label: "Overheads Prior Month"
    description: "Overheads prior month (i.e. previous month)"
    based_on: overheads
    based_on_time: period_month
    period: month
    value_format_name: gbp
    sql: ${TABLE}.net_amount  ;;
  }

  measure: taxation_prior_month {
    group_label: "P&L Actuals Prior Month"
    type: period_over_period
    label: "Taxation Prior Month"
    description: "Taxation prior month (i.e. previous month)"
    based_on: taxation
    based_on_time: period_month
    period: month
    value_format_name: gbp
    sql: ${TABLE}.net_amount  ;;
  }

  measure:dividends_prior_month {
    group_label: "P&L Actuals"
    type: period_over_period
    label: "Dividends Prior Month"
    description: "Dividends prior month (i.e. previous month)"
    based_on: dividends
    based_on_time: period_month
    period: month
    value_format_name: gbp
    sql: ${TABLE}.net_amount  ;;
  }

  measure: retained_earnings_prior_month {
    group_label: "P&L Actuals Prior Month"
    type: period_over_period
    label: "Retained Earnings Prior Month"
    description: "Profit after all costs including taxation and dividends"
    based_on: retained_earnings
    based_on_time: period_month
    period: month
    value_format_name: gbp
    sql: ${TABLE}.net_amount  ;;
  }

  # Actuals Prior Quarter for P&L Report Categories

  measure: revenue_prior_quarter {
    group_label: "P&L Actuals Prior Quarter"
    type: period_over_period
    label: "Revenue Prior Quarter"
    description: "Sales Revenue prior quarter (i.e. previous quarter)"
    based_on: revenue
    based_on_time: period_quarter
    period: quarter
    value_format_name: gbp
    sql: ${TABLE}.net_amount  ;;
  }

  measure: cost_of_delivery_prior_quarter {
    group_label: "P&L Actuals Prior Quarter"
    type: period_over_period
    label: "Cost of Delivery Prior Quarter"
    description: "Cost of Delivery Prior Quarter (i.e. previous month)"
    based_on: cost_of_delivery
    based_on_time: period_month
    period: quarter
    value_format_name: gbp
    sql: ${TABLE}.net_amount  ;;
  }

  measure: overheads_prior_quarter {
    group_label: "P&L Actuals Prior Quarter"
    type: period_over_period
    label: "Overheads Prior Quarter"
    description: "Overheads Prior Quarter (i.e. previous month)"
    based_on: overheads
    based_on_time: period_month
    period: quarter
    value_format_name: gbp
    sql: ${TABLE}.net_amount  ;;
  }

  measure: taxation_prior_quarter {
    group_label: "P&L Actuals Prior Quarter"
    type: period_over_period
    label: "Taxation Prior Quarter"
    description: "Taxation Prior Quarter (i.e. previous month)"
    based_on: taxation
    based_on_time: period_month
    period: quarter
    value_format_name: gbp
    sql: ${TABLE}.net_amount  ;;
  }

  measure:dividends_prior_quarter {
    group_label: "P&L Actuals"
    type: period_over_period
    label: "Dividends Prior Quarter"
    description: "Dividends Prior Quarter (i.e. previous month)"
    based_on: dividends
    based_on_time: period_month
    period: quarter
    value_format_name: gbp
    sql: ${TABLE}.net_amount  ;;
  }

  measure: retained_earnings_prior_quarter {
    group_label: "P&L Actuals Prior Quarter"
    type: period_over_period
    label: "Retained Earnings Prior Quarter"
    description: "Profit after all costs including taxation and dividends"
    based_on: retained_earnings
    based_on_time: period_month
    period: quarter
    value_format_name: gbp
    sql: ${TABLE}.net_amount  ;;
  }

  # Budgets for P&L Report Categories


  measure: budget {
    group_label: "P&L Base Measures"

    type: sum
    value_format_name: gbp
    sql: ${TABLE}.net_budget_amount ;;
  }

  measure: retained_earnings_budget {
    group_label: "P&L Budget"
    type: sum
    label: "Retained Earnings Budget"
    value_format_name: gbp
    sql: ${TABLE}.net_budget_amount ;;
  }

  measure: revenue_budget {
    group_label: "P&L Budget"

    type: sum
    description: "Sales revenue Budget"
    value_format_name: gbp
    sql: ${TABLE}.net_budget_amount  ;;
    filters: [account_report_category: "Revenue"]
  }

  measure: cost_of_delivery_budget {
    group_label: "P&L Budget"

    description: "Direct costs budget"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.net_budget_amount  ;;
    filters: [account_report_category: "Cost of Delivery"]
  }

  measure: overheads_budget {
    group_label: "P&L Budget"

    type: sum
    description: "Fixed costs incurred in running the business, e.g. back-office, sales commission, legal and accountancy costs that are not directly linked to delivering specific consulting projects and other services"

    value_format_name: gbp
    sql: ${TABLE}.net_budget_amount  ;;
    filters: [account_report_category: "Overheads"]
  }

  measure: taxation_budget {
    group_label: "P&L Budget"

    description: "Corporation tax Budget"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.net_budget_amount  ;;
    filters: [account_report_category: "Taxation"]
  }

  measure: dividends_budget {
    group_label: "P&L Budget"

    type: sum
    description: "Dividends budget"
    value_format_name: gbp
    sql: ${TABLE}.net_budget_amount  ;;
    filters: [account_report_category: "Dividends"]
  }






  dimension: profit_and_loss_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.profit_and_loss_pk ;;
  }




}
