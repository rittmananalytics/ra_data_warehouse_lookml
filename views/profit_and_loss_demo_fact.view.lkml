view: profit_and_loss_demo_fact {

  derived_table: {
    sql:
      SELECT
        profit_and_loss_pk,
        account_id,
        account_class,
        account_code,
        account_name,
        account_report_category,
        account_report_category_order,
        account_report_group,
        account_report_order,
        date_month,
        ROUND(net_amount * 1.35 / 100) * 100 AS net_amount
      FROM `ra-development.analytics.profit_and_loss_report_fact`
    ;;
  }

  dimension: profit_and_loss_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.profit_and_loss_pk ;;
  }

  dimension: account_id {
    hidden: yes
    type: string
    sql: ${TABLE}.account_id ;;
  }

  dimension: account_report_category {
    hidden: yes
    type: string
    sql: ${TABLE}.account_report_category ;;
  }

  dimension: account_report_category_order {
    hidden: yes
    type: number
    sql: ${TABLE}.account_report_category_order ;;
  }

  dimension: account_report_order {
    hidden: yes
    type: number
    sql: ${TABLE}.account_report_order ;;
  }

  dimension_group: period {
    type: time
    timeframes: [raw, month, month_num, quarter, year, fiscal_month_num, fiscal_quarter_of_year, fiscal_quarter, fiscal_year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_month ;;
  }

  dimension: amount_base {
    hidden: yes
    type: number
    sql: ${TABLE}.net_amount ;;
  }

  measure: revenue {
    group_label: "P&L Actuals"
    type: sum
    value_format_name: gbp
    sql: ${amount_base} ;;
    filters: [account_report_category: "Revenue"]
  }

  measure: cost_of_delivery {
    group_label: "P&L Actuals"
    type: sum
    value_format_name: gbp
    sql: ${amount_base} ;;
    filters: [account_report_category: "Cost of Delivery"]
  }

  measure: overheads {
    group_label: "P&L Actuals"
    type: sum
    value_format_name: gbp
    sql: ${amount_base} ;;
    filters: [account_report_category: "Overheads"]
  }

  measure: retained_earnings {
    group_label: "P&L Actuals"
    type: sum
    value_format_name: gbp
    sql: ${amount_base} ;;
  }

  measure: revenue_prior_month {
    group_label: "P&L Actuals Prior Month"
    type: period_over_period
    label: "Revenue Prior Month"
    based_on: revenue
    based_on_time: period_month
    period: month
    value_format_name: gbp
    sql: ${amount_base} ;;
  }

  measure: cost_of_delivery_prior_month {
    group_label: "P&L Actuals Prior Month"
    type: period_over_period
    label: "Cost of Delivery Prior Month"
    based_on: cost_of_delivery
    based_on_time: period_month
    period: month
    value_format_name: gbp
    sql: ${amount_base} ;;
  }

  measure: overheads_prior_month {
    group_label: "P&L Actuals Prior Month"
    type: period_over_period
    label: "Overheads Prior Month"
    based_on: overheads
    based_on_time: period_month
    period: month
    value_format_name: gbp
    sql: ${amount_base} ;;
  }

  measure: retained_earnings_prior_month {
    group_label: "P&L Actuals Prior Month"
    type: period_over_period
    label: "Retained Earnings Prior Month"
    based_on: retained_earnings
    based_on_time: period_month
    period: month
    value_format_name: gbp
    sql: ${amount_base} ;;
  }

  measure: revenue_prior_year {
    group_label: "P&L Actuals Prior Year"
    type: period_over_period
    label: "Revenue Prior Year"
    based_on: revenue
    based_on_time: period_month
    period: year
    value_format_name: gbp
    sql: ${amount_base} ;;
  }
}
