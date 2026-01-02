# =============================================================================
# AGG_CROSS_DOMAIN_CORRELATIONS - Cross-Domain Correlations
# Pre-computed correlations between life domains
# Grain: One row (overall summary)
# Source: ra-development.pdd_analytics.cross_domain_correlation_agg
# =============================================================================

view: agg_cross_domain_correlations {
  sql_table_name: `ra-development.pdd_analytics.cross_domain_correlation_agg` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: time_period {
    primary_key: yes
    type: string
    sql: ${TABLE}.time_period ;;
    label: "Time Period"
    description: "Analysis time period (Overall)"
  }

  # =============================================================================
  # HEALTH-SPENDING CORRELATIONS
  # =============================================================================

  dimension: steps_vs_spending_corr {
    type: number
    sql: ${TABLE}.steps_vs_spending_corr ;;
    label: "Steps vs Spending"
    value_format_name: decimal_4
    group_label: "Health-Spending"
    description: "Correlation: steps vs spending"
  }

  dimension: steps_vs_spending_strength {
    type: string
    sql: ${TABLE}.steps_vs_spending_strength ;;
    label: "Steps vs Spending Strength"
    group_label: "Health-Spending"
    description: "Correlation strength (Strong, Moderate, Weak)"
  }

  dimension: exercise_vs_spending_corr {
    type: number
    sql: ${TABLE}.exercise_vs_spending_corr ;;
    label: "Exercise vs Spending"
    value_format_name: decimal_4
    group_label: "Health-Spending"
    description: "Correlation: exercise vs spending"
  }

  dimension: sleep_vs_discretionary_corr {
    type: number
    sql: ${TABLE}.sleep_vs_discretionary_corr ;;
    label: "Sleep vs Discretionary"
    value_format_name: decimal_4
    group_label: "Health-Spending"
    description: "Correlation: sleep vs discretionary spending"
  }

  dimension: workouts_vs_food_corr {
    type: number
    sql: ${TABLE}.workouts_vs_food_corr ;;
    label: "Workouts vs Food"
    value_format_name: decimal_4
    group_label: "Health-Spending"
    description: "Correlation: workouts vs food spending"
  }

  # =============================================================================
  # HEALTH-PRODUCTIVITY CORRELATIONS
  # =============================================================================

  dimension: sleep_vs_productivity_corr {
    type: number
    sql: ${TABLE}.sleep_vs_productivity_corr ;;
    label: "Sleep vs Productivity"
    value_format_name: decimal_4
    group_label: "Health-Productivity"
    description: "Correlation: sleep vs productivity"
  }

  dimension: sleep_vs_productivity_strength {
    type: string
    sql: ${TABLE}.sleep_vs_productivity_strength ;;
    label: "Sleep vs Productivity Strength"
    group_label: "Health-Productivity"
    description: "Correlation strength"
  }

  dimension: exercise_vs_productivity_corr {
    type: number
    sql: ${TABLE}.exercise_vs_productivity_corr ;;
    label: "Exercise vs Productivity"
    value_format_name: decimal_4
    group_label: "Health-Productivity"
    description: "Correlation: exercise vs productivity"
  }

  dimension: steps_vs_screen_time_corr {
    type: number
    sql: ${TABLE}.steps_vs_screen_time_corr ;;
    label: "Steps vs Screen Time"
    value_format_name: decimal_4
    group_label: "Health-Productivity"
    description: "Correlation: steps vs screen time"
  }

  # =============================================================================
  # SPENDING-PRODUCTIVITY CORRELATIONS
  # =============================================================================

  dimension: spending_vs_screen_time_corr {
    type: number
    sql: ${TABLE}.spending_vs_screen_time_corr ;;
    label: "Spending vs Screen Time"
    value_format_name: decimal_4
    group_label: "Spending-Productivity"
    description: "Correlation: spending vs screen time"
  }

  dimension: entertainment_vs_discretionary_corr {
    type: number
    sql: ${TABLE}.entertainment_vs_discretionary_corr ;;
    label: "Entertainment vs Discretionary"
    value_format_name: decimal_4
    group_label: "Spending-Productivity"
    description: "Correlation: entertainment time vs discretionary spending"
  }

  # =============================================================================
  # METADATA
  # =============================================================================

  dimension: sample_size {
    type: number
    sql: ${TABLE}.sample_size ;;
    label: "Sample Size"
    value_format_name: decimal_0
    description: "Number of days in analysis"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Row Count"
    drill_fields: [time_period, sleep_vs_productivity_corr, steps_vs_spending_corr]
  }

  measure: avg_sleep_productivity_corr {
    type: average
    sql: ${sleep_vs_productivity_corr} ;;
    label: "Avg Sleep-Productivity Correlation"
    value_format_name: decimal_4
  }
}
