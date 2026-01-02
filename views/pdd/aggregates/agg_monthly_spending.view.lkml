# =============================================================================
# AGG_MONTHLY_SPENDING - Monthly Spending Summary
# Grain: One row per month
# Source: ra-development.pdd_analytics.monthly_spending_summary_agg
# =============================================================================

view: agg_monthly_spending {
  sql_table_name: `ra-development.pdd_analytics.monthly_spending_summary_agg` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: month_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.month_key ;;
    hidden: yes
    description: "Primary key (YYYYMM format)"
  }

  # =============================================================================
  # DATE DIMENSIONS
  # =============================================================================

  dimension_group: month_start {
    type: time
    timeframes: [raw, date, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.month_start_date ;;
    label: "Month"
    description: "Month start date"
  }

  dimension: month_number {
    type: number
    sql: ${TABLE}.month_number ;;
    label: "Month Number"
    description: "Month (1-12)"
  }

  dimension: year_number {
    type: number
    sql: ${TABLE}.year_number ;;
    label: "Year"
    description: "Year"
  }

  dimension: year_month {
    type: string
    sql: ${TABLE}.year_month ;;
    label: "Year-Month"
    description: "YYYY-MM format"
  }

  dimension: month_name_year {
    type: string
    sql: ${TABLE}.month_name_year ;;
    label: "Month Name"
    description: "Month name and year"
  }

  # =============================================================================
  # TOTAL DIMENSIONS
  # =============================================================================

  dimension: total_spending {
    type: number
    sql: ${TABLE}.total_spending ;;
    label: "Total Spending"
    value_format_name: gbp
    description: "Total spending for month"
  }

  dimension: total_income {
    type: number
    sql: ${TABLE}.total_income ;;
    label: "Total Income"
    value_format_name: gbp
    description: "Total income for month"
  }

  dimension: net_flow {
    type: number
    sql: ${TABLE}.net_flow ;;
    label: "Net Flow"
    value_format_name: gbp
    description: "Income minus spending"
  }

  dimension: avg_daily_spending {
    type: number
    sql: ${TABLE}.avg_daily_spending ;;
    label: "Avg Daily Spending"
    value_format_name: gbp
    description: "Average daily spending"
  }

  dimension: savings_rate_pct {
    type: number
    sql: ${TABLE}.savings_rate_pct ;;
    label: "Savings Rate %"
    value_format_name: decimal_1
    description: "Savings as % of income"
  }

  # =============================================================================
  # CATEGORY DIMENSIONS
  # =============================================================================

  dimension: food_drink_spending {
    type: number
    sql: ${TABLE}.food_drink_spending ;;
    label: "Food & Drink"
    value_format_name: gbp
    group_label: "Category Spending"
    description: "Food & drink spending"
  }

  dimension: transport_spending {
    type: number
    sql: ${TABLE}.transport_spending ;;
    label: "Transport"
    value_format_name: gbp
    group_label: "Category Spending"
    description: "Transport spending"
  }

  dimension: shopping_spending {
    type: number
    sql: ${TABLE}.shopping_spending ;;
    label: "Shopping"
    value_format_name: gbp
    group_label: "Category Spending"
    description: "Shopping spending"
  }

  dimension: entertainment_spending {
    type: number
    sql: ${TABLE}.entertainment_spending ;;
    label: "Entertainment"
    value_format_name: gbp
    group_label: "Category Spending"
    description: "Entertainment spending"
  }

  dimension: bills_spending {
    type: number
    sql: ${TABLE}.bills_spending ;;
    label: "Bills"
    value_format_name: gbp
    group_label: "Category Spending"
    description: "Bills & utilities spending"
  }

  dimension: housing_spending {
    type: number
    sql: ${TABLE}.housing_spending ;;
    label: "Housing"
    value_format_name: gbp
    group_label: "Category Spending"
    description: "Housing spending"
  }

  dimension: health_spending {
    type: number
    sql: ${TABLE}.health_spending ;;
    label: "Health"
    value_format_name: gbp
    group_label: "Category Spending"
    description: "Health & fitness spending"
  }

  # =============================================================================
  # ESSENTIAL VS DISCRETIONARY
  # =============================================================================

  dimension: essential_spending {
    type: number
    sql: ${TABLE}.essential_spending ;;
    label: "Essential Spending"
    value_format_name: gbp
    group_label: "Spending Type"
    description: "Essential spending"
  }

  dimension: discretionary_spending {
    type: number
    sql: ${TABLE}.discretionary_spending ;;
    label: "Discretionary Spending"
    value_format_name: gbp
    group_label: "Spending Type"
    description: "Discretionary spending"
  }

  dimension: essential_pct {
    type: number
    sql: ${TABLE}.essential_pct ;;
    label: "Essential %"
    value_format_name: decimal_1
    group_label: "Spending Type"
    description: "Essential as % of total"
  }

  dimension: discretionary_pct {
    type: number
    sql: ${TABLE}.discretionary_pct ;;
    label: "Discretionary %"
    value_format_name: decimal_1
    group_label: "Spending Type"
    description: "Discretionary as % of total"
  }

  # =============================================================================
  # COMPARISON DIMENSIONS
  # =============================================================================

  dimension: prev_month_spending {
    type: number
    sql: ${TABLE}.prev_month_spending ;;
    label: "Previous Month"
    value_format_name: gbp
    group_label: "Comparisons"
    description: "Previous month spending"
  }

  dimension: mom_spending_change {
    type: number
    sql: ${TABLE}.mom_spending_change ;;
    label: "MoM Change"
    value_format_name: gbp
    group_label: "Comparisons"
    description: "Month-over-month change"
  }

  dimension: mom_spending_change_pct {
    type: number
    sql: ${TABLE}.mom_spending_change_pct ;;
    label: "MoM % Change"
    value_format_name: decimal_1
    group_label: "Comparisons"
    description: "Month-over-month % change"
  }

  # =============================================================================
  # TRANSACTION STATS
  # =============================================================================

  dimension: transaction_count {
    type: number
    sql: ${TABLE}.transaction_count ;;
    label: "Transaction Count"
    value_format_name: decimal_0
    description: "Total transactions"
  }

  dimension: purchase_count {
    type: number
    sql: ${TABLE}.purchase_count ;;
    label: "Purchase Count"
    value_format_name: decimal_0
    description: "Total purchases"
  }

  dimension: avg_transaction_amount {
    type: number
    sql: ${TABLE}.avg_transaction_amount ;;
    label: "Avg Transaction"
    value_format_name: gbp
    description: "Average transaction amount"
  }

  dimension: days_with_data {
    type: number
    sql: ${TABLE}.days_with_data ;;
    label: "Days Tracked"
    value_format_name: decimal_0
    description: "Days with transaction data"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Month Count"
    drill_fields: [year_month, total_spending, total_income, net_flow]
  }

  measure: sum_spending {
    type: sum
    sql: ${total_spending} ;;
    label: "Total Spending"
    value_format_name: gbp
  }

  measure: sum_income {
    type: sum
    sql: ${total_income} ;;
    label: "Total Income"
    value_format_name: gbp
  }

  measure: avg_monthly_spending {
    type: average
    sql: ${total_spending} ;;
    label: "Avg Monthly Spending"
    value_format_name: gbp
  }

  measure: sum_transactions {
    type: sum
    sql: ${transaction_count} ;;
    label: "Total Transactions"
    value_format_name: decimal_0
  }
}
