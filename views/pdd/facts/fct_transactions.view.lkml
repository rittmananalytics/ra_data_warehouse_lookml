# =============================================================================
# FCT_TRANSACTIONS - Financial Transactions
# Grain: One row per transaction (from Monzo + First Direct + Amazon + Uber)
# Source: ra-development.pdd_analytics.transactions_fct
# =============================================================================

view: fct_transactions {
  sql_table_name: `ra-development.pdd_analytics.transactions_fct` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: transaction_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.transaction_id ;;
    hidden: yes
    description: "Primary key"
  }

  # =============================================================================
  # FOREIGN KEYS
  # =============================================================================

  dimension: date_key {
    type: number
    sql: ${TABLE}.date_key ;;
    hidden: yes
    description: "Foreign key to date_dim"
  }

  dimension: time_key {
    type: number
    sql: ${TABLE}.time_key ;;
    hidden: yes
    description: "Foreign key to time_dim"
  }

  dimension: category_key {
    type: string
    sql: ${TABLE}.category_key ;;
    hidden: yes
    description: "Foreign key to spending_category_dim"
  }

  dimension: merchant_key {
    type: string
    sql: ${TABLE}.merchant_key ;;
    hidden: yes
    description: "Foreign key to merchant_dim"
  }

  # =============================================================================
  # TIMESTAMP DIMENSIONS
  # =============================================================================

  dimension_group: transaction {
    type: time
    timeframes: [raw, date, week, month, quarter, year, day_of_week]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.transaction_date ;;
    label: "Transaction"
    description: "Transaction date"
  }

  dimension_group: transaction_at {
    type: time
    timeframes: [raw, time, date, hour_of_day]
    datatype: timestamp
    sql: ${TABLE}.transaction_at ;;
    label: "Transaction Time"
    description: "Transaction timestamp"
  }

  # =============================================================================
  # TRANSACTION DIMENSIONS
  # =============================================================================

  dimension: source_system {
    type: string
    sql: ${TABLE}.source_system ;;
    label: "Source"
    description: "Monzo, First Direct, Amazon, Uber"
  }

  dimension: merchant_name {
    type: string
    sql: ${TABLE}.merchant_name ;;
    label: "Merchant"
    description: "Merchant name"
  }

  dimension: transaction_type {
    type: string
    sql: ${TABLE}.transaction_type ;;
    label: "Type"
    description: "Transaction type"
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
    label: "Currency"
    description: "Transaction currency"
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
    label: "Category"
    description: "Spending category"
  }

  dimension: category_group {
    type: string
    sql: ${TABLE}.category_group ;;
    label: "Category Group"
    description: "High-level category group"
  }

  # =============================================================================
  # AMOUNT DIMENSIONS
  # =============================================================================

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
    label: "Amount"
    value_format_name: gbp
    description: "Amount (negative = spending)"
  }

  dimension: amount_abs {
    type: number
    sql: ${TABLE}.amount_abs ;;
    label: "Amount (Absolute)"
    value_format_name: gbp
    description: "Absolute amount"
  }

  dimension: spend_amount {
    type: number
    sql: ${TABLE}.spend_amount ;;
    label: "Spend Amount"
    value_format_name: gbp
    description: "Spending amount (positive)"
  }

  dimension: income_amount {
    type: number
    sql: ${TABLE}.income_amount ;;
    label: "Income Amount"
    value_format_name: gbp
    description: "Income amount"
  }

  # =============================================================================
  # AGGREGATED DIMENSIONS
  # =============================================================================

  dimension: month_running_total {
    type: number
    sql: ${TABLE}.month_running_total ;;
    label: "Month Running Total"
    value_format_name: gbp
    group_label: "Running Totals"
    description: "Running total for the month"
  }

  dimension: spending_7d {
    type: number
    sql: ${TABLE}.spending_7d ;;
    label: "7-Day Spending"
    value_format_name: gbp
    group_label: "Rolling Totals"
    description: "7-day rolling spend"
  }

  dimension: spending_30d {
    type: number
    sql: ${TABLE}.spending_30d ;;
    label: "30-Day Spending"
    value_format_name: gbp
    group_label: "Rolling Totals"
    description: "30-day rolling spend"
  }

  dimension: transaction_count_7d {
    type: number
    sql: ${TABLE}.transaction_count_7d ;;
    label: "7-Day Transaction Count"
    value_format_name: decimal_0
    group_label: "Rolling Totals"
    description: "7-day transaction count"
  }

  dimension: daily_category_spending {
    type: number
    sql: ${TABLE}.daily_category_spending ;;
    label: "Daily Category Spending"
    value_format_name: gbp
    description: "Daily spending in this category"
  }

  # =============================================================================
  # TRANSACTION FLAGS
  # =============================================================================

  dimension: is_essential {
    type: yesno
    sql: ${TABLE}.is_essential ;;
    label: "Is Essential"
    description: "TRUE if essential spending"
  }

  dimension: is_discretionary {
    type: yesno
    sql: ${TABLE}.is_discretionary ;;
    label: "Is Discretionary"
    description: "TRUE if discretionary spending"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Transaction Count"
    drill_fields: [transaction_date, merchant_name, category, amount]
  }

  measure: total_spending {
    type: sum
    sql: ${spend_amount} ;;
    label: "Total Spending"
    value_format_name: gbp
  }

  measure: total_income {
    type: sum
    sql: ${income_amount} ;;
    label: "Total Income"
    value_format_name: gbp
  }

  measure: net_amount {
    type: sum
    sql: ${amount} ;;
    label: "Net Amount"
    value_format_name: gbp
    description: "Income minus spending"
  }

  measure: avg_transaction {
    type: average
    sql: ${amount_abs} ;;
    label: "Avg Transaction"
    value_format_name: gbp
  }

  measure: avg_spend {
    type: average
    sql: ${spend_amount} ;;
    label: "Avg Spend"
    value_format_name: gbp
  }

  measure: essential_spending {
    type: sum
    sql: ${spend_amount} ;;
    filters: [is_essential: "yes"]
    label: "Essential Spending"
    value_format_name: gbp
  }

  measure: discretionary_spending {
    type: sum
    sql: ${spend_amount} ;;
    filters: [is_discretionary: "yes"]
    label: "Discretionary Spending"
    value_format_name: gbp
  }
}
