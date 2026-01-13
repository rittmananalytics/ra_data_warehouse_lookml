# =============================================================================
# AGG_MONTHLY_SPENDING - Monthly Spending Summary
# Grain: One row per month per category
# Source: ra-development.pdd_analytics.monthly_spending_summary_agg
# =============================================================================

view: agg_monthly_spending {
  sql_table_name: `ra-development.pdd_analytics.monthly_spending_summary_agg` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: pk {
    primary_key: yes
    type: string
    sql: CONCAT(${TABLE}.year_month, '-', COALESCE(${TABLE}.category_fk, 'unknown')) ;;
    hidden: yes
    description: "Composite primary key"
  }

  # =============================================================================
  # DIMENSIONS
  # =============================================================================

  dimension: year_month {
    type: string
    sql: ${TABLE}.year_month ;;
    label: "Year-Month"
    description: "Year-Month (YYYY-MM)"
  }

  dimension: category_fk {
    type: string
    sql: ${TABLE}.category_fk ;;
    hidden: yes
    description: "Foreign key to dim_spending_category"
  }

  dimension: category_name {
    type: string
    sql: ${TABLE}.category_name ;;
    label: "Category"
    description: "Category name"
  }

  dimension: total_spending_gbp {
    type: number
    sql: ${TABLE}.total_spending_gbp ;;
    label: "Total Spending"
    value_format_name: gbp
    description: "Total spending in GBP"
  }

  dimension: transaction_count {
    type: number
    sql: ${TABLE}.transaction_count ;;
    label: "Transaction Count"
    value_format_name: decimal_0
    description: "Number of transactions"
  }

  dimension: avg_transaction_gbp {
    type: number
    sql: ${TABLE}.avg_transaction_gbp ;;
    label: "Avg Transaction"
    value_format_name: gbp
    description: "Average transaction amount"
  }

  # =============================================================================
  # COMPARISON DIMENSIONS
  # =============================================================================

  dimension: spending_mom_change {
    type: number
    sql: ${TABLE}.spending_mom_change ;;
    label: "MoM Change"
    value_format_name: gbp
    group_label: "Comparisons"
    description: "Month-over-month change"
  }

  dimension: spending_mom_pct_change {
    type: number
    sql: ${TABLE}.spending_mom_pct_change ;;
    label: "MoM % Change"
    value_format_name: percent_1
    group_label: "Comparisons"
    description: "Month-over-month percentage change"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Row Count"
    drill_fields: [year_month, category_name, total_spending_gbp]
  }

  measure: sum_spending {
    type: sum
    sql: ${total_spending_gbp} ;;
    label: "Total Spending"
    value_format_name: gbp
  }

  measure: sum_transactions {
    type: sum
    sql: ${transaction_count} ;;
    label: "Total Transactions"
    value_format_name: decimal_0
  }

  measure: avg_spending_per_category {
    type: average
    sql: ${total_spending_gbp} ;;
    label: "Avg Spending per Category"
    value_format_name: gbp
  }
}
