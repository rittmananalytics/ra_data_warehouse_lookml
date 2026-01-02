# =============================================================================
# AGG_MONTHLY_SPENDING_TOTAL - Monthly Total Spending
# Grain: One row per month
# Source: markr-data-lake.mark_dw_warehouse.agg_monthly_spending_total
# =============================================================================

view: agg_monthly_spending_total {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.agg_monthly_spending_total` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: year_month {
    primary_key: yes
    type: string
    sql: ${TABLE}.year_month ;;
    label: "Year-Month"
    description: "Year-Month (YYYY-MM)"
  }

  # =============================================================================
  # SPENDING DIMENSIONS
  # =============================================================================

  dimension: total_spending_gbp {
    type: number
    sql: ${TABLE}.total_spending_gbp ;;
    label: "Total Spending"
    value_format_name: gbp
    group_label: "Spending"
    description: "Total spending in GBP"
  }

  dimension: amazon_spending_gbp {
    type: number
    sql: ${TABLE}.amazon_spending_gbp ;;
    label: "Amazon Spending"
    value_format_name: gbp
    group_label: "Spending"
    description: "Amazon spending in GBP"
  }

  dimension: uber_spending_gbp {
    type: number
    sql: ${TABLE}.uber_spending_gbp ;;
    label: "Uber Spending"
    value_format_name: gbp
    group_label: "Spending"
    description: "Uber spending in GBP"
  }

  dimension: subscription_spending_gbp {
    type: number
    sql: ${TABLE}.subscription_spending_gbp ;;
    label: "Subscription Spending"
    value_format_name: gbp
    group_label: "Spending"
    description: "Subscription spending in GBP"
  }

  dimension: transaction_count {
    type: number
    sql: ${TABLE}.transaction_count ;;
    label: "Transaction Count"
    value_format_name: decimal_0
    description: "Total transactions"
  }

  dimension: spending_6m_avg {
    type: number
    sql: ${TABLE}.spending_6m_avg ;;
    label: "6-Month Avg Spending"
    value_format_name: gbp
    description: "6-month rolling average spending"
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
    label: "Month Count"
    drill_fields: [year_month, total_spending_gbp, amazon_spending_gbp, uber_spending_gbp]
  }

  measure: sum_total_spending {
    type: sum
    sql: ${total_spending_gbp} ;;
    label: "Total Spending"
    value_format_name: gbp
  }

  measure: avg_monthly_spending {
    type: average
    sql: ${total_spending_gbp} ;;
    label: "Avg Monthly Spending"
    value_format_name: gbp
  }

  measure: sum_amazon_spending {
    type: sum
    sql: ${amazon_spending_gbp} ;;
    label: "Total Amazon Spending"
    value_format_name: gbp
  }

  measure: sum_uber_spending {
    type: sum
    sql: ${uber_spending_gbp} ;;
    label: "Total Uber Spending"
    value_format_name: gbp
  }

  measure: sum_subscription_spending {
    type: sum
    sql: ${subscription_spending_gbp} ;;
    label: "Total Subscription Spending"
    value_format_name: gbp
  }

  measure: sum_transactions {
    type: sum
    sql: ${transaction_count} ;;
    label: "Total Transactions"
    value_format_name: decimal_0
  }
}
