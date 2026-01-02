# =============================================================================
# FCT_TRANSACTIONS - Financial Transactions
# Grain: One row per transaction (from Monzo + First Direct + Amazon + Uber)
# Source: markr-data-lake.mark_dw_warehouse.fct_transactions
# =============================================================================

view: fct_transactions {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.fct_transactions` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: transaction_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.transaction_pk ;;
    hidden: yes
    description: "Primary key"
  }

  # =============================================================================
  # FOREIGN KEYS
  # =============================================================================

  dimension: date_fk {
    type: number
    sql: ${TABLE}.date_fk ;;
    hidden: yes
    description: "Foreign key to dim_date"
  }

  dimension: merchant_fk {
    type: string
    sql: ${TABLE}.merchant_fk ;;
    hidden: yes
    description: "Foreign key to dim_merchant"
  }

  dimension: category_fk {
    type: string
    sql: ${TABLE}.category_fk ;;
    hidden: yes
    description: "Foreign key to dim_spending_category"
  }

  dimension: account_fk {
    type: string
    sql: ${TABLE}.account_fk ;;
    hidden: yes
    description: "Foreign key to dim_bank_account"
  }

  # =============================================================================
  # TIMESTAMP DIMENSIONS
  # =============================================================================

  dimension_group: transaction {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year, day_of_week]
    datatype: timestamp
    sql: ${TABLE}.transaction_ts ;;
    label: "Transaction"
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

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
    label: "Description"
    description: "Transaction description"
  }

  dimension: amount_gbp {
    type: number
    sql: ${TABLE}.amount_gbp ;;
    label: "Amount"
    value_format_name: gbp
    description: "Amount in GBP (negative = spending)"
  }

  dimension: amount_absolute {
    type: number
    sql: ${TABLE}.amount_absolute ;;
    label: "Amount (Absolute)"
    value_format_name: gbp
    description: "Absolute amount (always positive)"
  }

  dimension: balance_after {
    type: number
    sql: ${TABLE}.balance_after ;;
    label: "Balance After"
    value_format_name: gbp
    description: "Account balance after transaction"
  }

  # =============================================================================
  # TRANSACTION FLAGS
  # =============================================================================

  dimension: is_spending {
    type: yesno
    sql: ${TABLE}.is_spending ;;
    label: "Is Spending"
    description: "TRUE if outgoing transaction"
  }

  dimension: is_income {
    type: yesno
    sql: ${TABLE}.is_income ;;
    label: "Is Income"
    description: "TRUE if incoming transaction"
  }

  dimension: is_subscription {
    type: yesno
    sql: ${TABLE}.is_subscription ;;
    label: "Is Subscription"
    description: "TRUE if recurring subscription"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Transaction Count"
    drill_fields: [transaction_date, dim_merchant.merchant_name, description, amount_gbp]
  }

  measure: total_spending {
    type: sum
    sql: ${amount_absolute} ;;
    filters: [is_spending: "yes"]
    label: "Total Spending"
    value_format_name: gbp
  }

  measure: total_income {
    type: sum
    sql: ${amount_absolute} ;;
    filters: [is_income: "yes"]
    label: "Total Income"
    value_format_name: gbp
  }

  measure: net_amount {
    type: sum
    sql: ${amount_gbp} ;;
    label: "Net Amount"
    value_format_name: gbp
    description: "Income minus spending"
  }

  measure: avg_transaction {
    type: average
    sql: ${amount_absolute} ;;
    label: "Avg Transaction"
    value_format_name: gbp
  }

  measure: avg_spending {
    type: average
    sql: ${amount_absolute} ;;
    filters: [is_spending: "yes"]
    label: "Avg Spending"
    value_format_name: gbp
  }

  measure: subscription_spending {
    type: sum
    sql: ${amount_absolute} ;;
    filters: [is_subscription: "yes"]
    label: "Subscription Spending"
    value_format_name: gbp
  }

  measure: amazon_spending {
    type: sum
    sql: ${amount_absolute} ;;
    filters: [source_system: "Amazon"]
    label: "Amazon Spending"
    value_format_name: gbp
  }

  measure: uber_spending {
    type: sum
    sql: ${amount_absolute} ;;
    filters: [source_system: "Uber"]
    label: "Uber Spending"
    value_format_name: gbp
  }

  measure: spending_transaction_count {
    type: count
    filters: [is_spending: "yes"]
    label: "Spending Count"
  }

  measure: current_balance {
    type: max
    sql: ${balance_after} ;;
    label: "Current Balance"
    value_format_name: gbp
    description: "Most recent balance"
  }
}
