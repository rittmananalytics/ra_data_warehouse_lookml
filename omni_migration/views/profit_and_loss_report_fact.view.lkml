view: profit_and_loss_report_fact {
  sql_table_name: `ra-development.analytics.profit_and_loss_report_fact` ;;

  dimension: account_class {
    sql: ${TABLE}.account_class ;;
  }

  dimension: account_code {
    sql: ${TABLE}.account_code ;;
  }

  dimension: account_id {
    sql: ${TABLE}.account_id ;;
  }

  dimension: account_name {
    label: "Account"
    sql: ${TABLE}.account_name ;;
    order_by_field: account_report_order
  }

  dimension: account_report_category {
    label: "Account Category"
    description: "Top-level P&L account grouping; Revenue, Cost of Delivery, Overheads, Dividends and Retained Earnings"
    sql: ${TABLE}.account_report_category ;;
    order_by_field: account_report_category_order
  }

  dimension: account_report_category_order {
    description: "Used for sorting Account Report Categories in the P&L report"
    hidden: yes
    sql: ${TABLE}.account_report_category_order ;;
  }

  dimension: account_report_group {
    label: "Account Group"
    description: "Second-level P&L account grouping, drill-down from Account Report Category"
    sql: ${TABLE}.account_report_group ;;
    order_by_field: account_report_order
  }

  dimension: account_report_order {
    description: "Used for sorting account names in the P&L report"
    hidden: yes
    sql: ${TABLE}.account_report_order ;;
  }

  dimension: amount_base {
    sql: ${TABLE}.net_amount ;;
  }

  dimension: budget_base {
    sql: ${TABLE}.net_budget_amount ;;
  }

  dimension: profit_and_loss_pk {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.profit_and_loss_pk ;;
  }

  dimension_group: period {
    type: time
    timeframes: [raw, date, month, quarter, year, month_num]
    convert_tz: no
    sql: ${TABLE}.date_month ;;
  }

  measure: amount {
    type: sum
    group_label: "P&L Base Measures"
    value_format_name: gbp
    sql: ${amount_base} ;;
  }

  measure: amount_abs {
    type: number
    label: "Amount (absolute)"
    group_label: "P&L Ratios"
    description: "abs(amount), Looker calculation on dashboard 409 tile 3845"
    value_format_name: gbp_0
    sql: ABS(${amount}) ;;
  }

  measure: amount_vs_budget_pct {
    type: number
    label: "Amount / Budget %"
    group_label: "P&L Ratios"
    description: "amount over budget (409 tile 3845 first Variance % calculation)"
    value_format_name: percent_1
    sql: SAFE_DIVIDE(${amount}, ${budget}) ;;
  }

  measure: budget {
    type: sum
    group_label: "P&L Base Measures"
    value_format_name: gbp
    sql: ${budget_base} ;;
  }

  measure: budget_abs {
    type: number
    label: "Budget (absolute)"
    group_label: "P&L Ratios"
    value_format_name: gbp_0
    sql: ABS(${budget}) ;;
  }

  measure: cost_of_delivery {
    type: sum
    group_label: "P&L Actuals"
    description: "Direct costs e.g. consultants wages, delivery software etc incurred in delivering consulting projects and other services"
    value_format_name: gbp
    sql: ${amount_base} ;;
    filters: [account_report_category: "Cost of Delivery"]
  }

  measure: cost_of_delivery_budget {
    type: sum
    group_label: "P&L Budget"
    description: "Direct costs budget"
    value_format_name: gbp
    sql: ${budget_base} ;;
    filters: [account_report_category: "Cost of Delivery"]
  }

  measure: cost_of_delivery_budget_pct_of_revenue {
    type: number
    label: "Cost of Delivery Budget %"
    group_label: "P&L Ratios"
    value_format_name: percent_1
    sql: SAFE_DIVIDE(ABS(${cost_of_delivery_budget}), ${revenue_budget}) ;;
  }

  measure: cost_of_delivery_pct_of_revenue {
    type: number
    label: "Cost of Delivery %"
    group_label: "P&L Ratios"
    description: "409 tile 3846"
    value_format_name: percent_1
    sql: SAFE_DIVIDE(ABS(${cost_of_delivery}), ${revenue}) ;;
  }

  measure: dividends {
    type: sum
    group_label: "P&L Actuals"
    description: "Payments to shareholders made from post-taxation net profit"
    value_format_name: gbp
    sql: ${amount_base} ;;
    filters: [account_report_category: "Dividends"]
  }

  measure: dividends_budget {
    type: sum
    group_label: "P&L Budget"
    description: "Dividends budget"
    value_format_name: gbp
    sql: ${budget_base} ;;
    filters: [account_report_category: "Dividends"]
  }

  measure: overheads {
    type: sum
    group_label: "P&L Actuals"
    description: "Fixed costs incurred in running the business, e.g. back-office, sales commission, legal and accountancy costs that are not directly linked to delivering specific consulting projects and other services"
    value_format_name: gbp
    sql: ${amount_base} ;;
    filters: [account_report_category: "Overheads"]
  }

  measure: overheads_budget {
    type: sum
    group_label: "P&L Budget"
    description: "Fixed costs incurred in running the business"
    value_format_name: gbp
    sql: ${budget_base} ;;
    filters: [account_report_category: "Overheads"]
  }

  measure: overheads_budget_pct_of_revenue {
    type: number
    label: "Overheads Budget %"
    group_label: "P&L Ratios"
    value_format_name: percent_1
    sql: SAFE_DIVIDE(ABS(${overheads_budget}), ${revenue_budget}) ;;
  }

  measure: overheads_pct_of_revenue {
    type: number
    label: "Overheads %"
    group_label: "P&L Ratios"
    description: "409 tile 3847"
    value_format_name: percent_1
    sql: SAFE_DIVIDE(ABS(${overheads}), ${revenue}) ;;
  }

  measure: retained_earnings {
    type: sum
    label: "Retained Earnings"
    group_label: "P&L Actuals"
    description: "Retained Earnings"
    value_format_name: gbp
    sql: ${amount_base} ;;
  }

  measure: retained_earnings_budget {
    type: sum
    label: "Retained Earnings Budget"
    group_label: "P&L Budget"
    value_format_name: gbp
    sql: ${budget_base} ;;
  }

  measure: retained_earnings_budget_pct_of_revenue {
    type: number
    label: "Retained Earnings Budget %"
    group_label: "P&L Ratios"
    value_format_name: percent_1
    sql: SAFE_DIVIDE(${retained_earnings_budget}, ${revenue_budget}) ;;
  }

  measure: retained_earnings_pct_of_revenue {
    type: number
    label: "Retained Earnings %"
    group_label: "P&L Ratios"
    description: "(revenue + cost of delivery + overheads + taxation + dividends) / revenue (409 tiles 3849, 3853)"
    value_format_name: percent_1
    sql: SAFE_DIVIDE(${retained_earnings}, ${revenue}) ;;
  }

  measure: revenue {
    type: sum
    group_label: "P&L Actuals"
    description: "Sales revenue from consulting projects and other services"
    value_format_name: gbp
    sql: ${amount_base} ;;
    filters: [account_report_category: "Revenue"]
  }

  measure: revenue_budget {
    type: sum
    group_label: "P&L Budget"
    description: "Sales revenue Budget"
    value_format_name: gbp
    sql: ${budget_base} ;;
    filters: [account_report_category: "Revenue"]
  }

  measure: sales_vs_budget_pct {
    type: number
    label: "Sales vs Target %"
    group_label: "P&L Ratios"
    description: "409 tile 3848"
    value_format_name: percent_1
    sql: SAFE_DIVIDE(ABS(${revenue}), ${revenue_budget}) ;;
  }

  measure: taxation {
    type: sum
    group_label: "P&L Actuals"
    description: "Corporation tax levied on net profits before payment of dividends"
    value_format_name: gbp
    sql: ${amount_base} ;;
    filters: [account_report_category: "Taxation"]
  }

  measure: taxation_budget {
    type: sum
    group_label: "P&L Budget"
    description: "Corporation tax Budget"
    value_format_name: gbp
    sql: ${budget_base} ;;
    filters: [account_report_category: "Taxation"]
  }

  measure: variance {
    type: number
    label: "Variance"
    group_label: "P&L Ratios"
    description: "amount minus budget (409 tile 3845)"
    value_format_name: gbp_0
    sql: ${amount} - ${budget} ;;
  }

  measure: variance_pct {
    type: number
    label: "Variance %"
    group_label: "P&L Ratios"
    value_format_name: percent_1
    sql: SAFE_DIVIDE(ABS(${amount} - ${budget}), ABS(${budget})) ;;
  }
}
