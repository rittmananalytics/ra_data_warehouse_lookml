
# =============================================================================
# DEMO VIEW — Mocked P&L data for client presentations
# Real figures scaled by 1.35x and rounded to nearest £100.
# DO NOT use for internal reporting.
# =============================================================================

view: profit_and_loss_demo_fact {

  sql_table_name: `ra-development.analytics.profit_and_loss_report_fact` ;;

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

  dimension: amount_base {
    hidden: yes
    type: number
    sql: ROUND(${TABLE}.net_amount * 1.35, -2) ;;
  }

  dimension: budget_base {
    hidden: yes
    type: number
    sql: ROUND(${TABLE}.net_budget_amount * 1.35, -2) ;;
  }

  dimension_group: period {
    type: time
    timeframes: [raw, month, month_num, quarter, year,
                 fiscal_month_num, fiscal_quarter_of_year, fiscal_quarter, fiscal_year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_month ;;
  }

  # ── Actuals ──────────────────────────────────────────────────────────────────

  measure: revenue {
    group_label: "P&L Actuals"
    type: sum
    label: "Revenue"
    value_format_name: gbp
    sql: ${amount_base} ;;
    filters: [account_report_category: "Revenue"]
  }

  measure: cost_of_delivery {
    group_label: "P&L Actuals"
    type: sum
    label: "Cost of Delivery"
    value_format_name: gbp
    sql: ${amount_base} ;;
    filters: [account_report_category: "Cost of Delivery"]
  }

  measure: overheads {
    group_label: "P&L Actuals"
    type: sum
    label: "Overheads"
    value_format_name: gbp
    sql: ${amount_base} ;;
    filters: [account_report_category: "Overheads"]
  }

  measure: retained_earnings {
    group_label: "P&L Actuals"
    type: sum
    label: "Retained Earnings"
    value_format_name: gbp
    sql: ${amount_base} ;;
  }

  # ── Prior Month (plain sums — compatible with single value % change vis) ─────

  measure: revenue_prior_month_value {
    group_label: "P&L Prior Month (Value)"
    type: sum
    label: "Revenue — Prior Month (Value)"
    value_format_name: gbp
    sql: CASE WHEN DATE_TRUNC(${TABLE}.date_month, MONTH) = DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL 2 MONTH), MONTH) THEN ROUND(${TABLE}.net_amount * 1.35, -2) END ;;
    filters: [account_report_category: "Revenue"]
  }

  measure: cost_of_delivery_prior_month_value {
    group_label: "P&L Prior Month (Value)"
    }
    }
