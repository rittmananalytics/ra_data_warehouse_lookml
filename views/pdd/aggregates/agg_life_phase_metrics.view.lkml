# =============================================================================
# AGG_LIFE_PHASE_METRICS - Life Phase Comparison
# Aggregate metrics by life phase for pandemic comparison
# Grain: One row per life phase
# Source: ra-development.pdd_analytics.life_phase_comparison_agg
# =============================================================================

view: agg_life_phase_metrics {
  sql_table_name: `ra-development.pdd_analytics.life_phase_comparison_agg` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: life_phase {
    primary_key: yes
    type: string
    sql: ${TABLE}.life_phase ;;
    label: "Life Phase"
    description: "Pre-Pandemic, During Pandemic, Post-Pandemic"
  }

  # =============================================================================
  # HEALTH METRICS
  # =============================================================================

  dimension: avg_daily_steps {
    type: number
    sql: ${TABLE}.avg_daily_steps ;;
    label: "Avg Daily Steps"
    value_format_name: decimal_0
    group_label: "Health"
    description: "Average daily steps"
  }

  dimension: avg_daily_exercise_minutes {
    type: number
    sql: ${TABLE}.avg_daily_exercise_minutes ;;
    label: "Avg Daily Exercise (min)"
    value_format_name: decimal_1
    group_label: "Health"
    description: "Average daily exercise"
  }

  dimension: avg_daily_sleep_hours {
    type: number
    sql: ${TABLE}.avg_daily_sleep_hours ;;
    label: "Avg Sleep (hours)"
    value_format_name: decimal_1
    group_label: "Health"
    description: "Average daily sleep"
  }

  dimension: avg_weight_kg {
    type: number
    sql: ${TABLE}.avg_weight_kg ;;
    label: "Avg Weight (kg)"
    value_format_name: decimal_1
    group_label: "Health"
    description: "Average weight"
  }

  dimension: avg_heart_rate {
    type: number
    sql: ${TABLE}.avg_heart_rate ;;
    label: "Avg Heart Rate"
    value_format_name: decimal_1
    group_label: "Health"
    description: "Average heart rate"
  }

  dimension: avg_daily_workouts {
    type: number
    sql: ${TABLE}.avg_daily_workouts ;;
    label: "Avg Daily Workouts"
    value_format_name: decimal_2
    group_label: "Health"
    description: "Average workouts per day"
  }

  # =============================================================================
  # SPENDING METRICS
  # =============================================================================

  dimension: avg_daily_spending {
    type: number
    sql: ${TABLE}.avg_daily_spending ;;
    label: "Avg Daily Spending"
    value_format_name: gbp
    group_label: "Spending"
    description: "Average daily spending"
  }

  dimension: avg_daily_food_spending {
    type: number
    sql: ${TABLE}.avg_daily_food_spending ;;
    label: "Avg Daily Food"
    value_format_name: gbp
    group_label: "Spending"
    description: "Average daily food spending"
  }

  dimension: avg_daily_transport_spending {
    type: number
    sql: ${TABLE}.avg_daily_transport_spending ;;
    label: "Avg Daily Transport"
    value_format_name: gbp
    group_label: "Spending"
    description: "Average daily transport spending"
  }

  dimension: avg_daily_entertainment_spending {
    type: number
    sql: ${TABLE}.avg_daily_entertainment_spending ;;
    label: "Avg Daily Entertainment"
    value_format_name: gbp
    group_label: "Spending"
    description: "Average daily entertainment spending"
  }

  dimension: avg_daily_discretionary {
    type: number
    sql: ${TABLE}.avg_daily_discretionary ;;
    label: "Avg Daily Discretionary"
    value_format_name: gbp
    group_label: "Spending"
    description: "Average daily discretionary spending"
  }

  dimension: essential_spending_pct {
    type: number
    sql: ${TABLE}.essential_spending_pct ;;
    label: "Essential Spending %"
    value_format_name: decimal_1
    group_label: "Spending"
    description: "Essential as % of total"
  }

  # =============================================================================
  # PRODUCTIVITY METRICS
  # =============================================================================

  dimension: avg_daily_screen_minutes {
    type: number
    sql: ${TABLE}.avg_daily_screen_minutes ;;
    label: "Avg Screen Time (min)"
    value_format_name: decimal_0
    group_label: "Productivity"
    description: "Average daily screen time"
  }

  dimension: avg_daily_screen_hours {
    type: number
    sql: ${TABLE}.avg_daily_screen_hours ;;
    label: "Avg Screen Time (hours)"
    value_format_name: decimal_1
    group_label: "Productivity"
    description: "Average daily screen hours"
  }

  dimension: avg_productivity_score {
    type: number
    sql: ${TABLE}.avg_productivity_score ;;
    label: "Avg Productivity Score"
    value_format_name: decimal_3
    group_label: "Productivity"
    description: "Average productivity score"
  }

  dimension: avg_work_minutes {
    type: number
    sql: ${TABLE}.avg_work_minutes ;;
    label: "Avg Work Time (min)"
    value_format_name: decimal_0
    group_label: "Productivity"
    description: "Average daily work time"
  }

  dimension: avg_leisure_minutes {
    type: number
    sql: ${TABLE}.avg_leisure_minutes ;;
    label: "Avg Leisure Time (min)"
    value_format_name: decimal_0
    group_label: "Productivity"
    description: "Average daily leisure time"
  }

  dimension: work_screen_time_pct {
    type: number
    sql: ${TABLE}.work_screen_time_pct ;;
    label: "Work Screen %"
    value_format_name: decimal_1
    group_label: "Productivity"
    description: "Work as % of screen time"
  }

  # =============================================================================
  # DATA COVERAGE
  # =============================================================================

  dimension: health_days {
    type: number
    sql: ${TABLE}.health_days ;;
    label: "Health Days"
    value_format_name: decimal_0
    group_label: "Coverage"
    description: "Days with health data"
  }

  dimension: spending_days {
    type: number
    sql: ${TABLE}.spending_days ;;
    label: "Spending Days"
    value_format_name: decimal_0
    group_label: "Coverage"
    description: "Days with spending data"
  }

  dimension: productivity_days {
    type: number
    sql: ${TABLE}.productivity_days ;;
    label: "Productivity Days"
    value_format_name: decimal_0
    group_label: "Coverage"
    description: "Days with productivity data"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Phase Count"
    drill_fields: [life_phase, avg_daily_steps, avg_daily_spending, avg_productivity_score]
  }

  measure: avg_steps_measure {
    type: average
    sql: ${avg_daily_steps} ;;
    label: "Avg Daily Steps"
    value_format_name: decimal_0
  }

  measure: avg_spending_measure {
    type: average
    sql: ${avg_daily_spending} ;;
    label: "Avg Daily Spending"
    value_format_name: gbp
  }

  measure: avg_productivity_measure {
    type: average
    sql: ${avg_productivity_score} ;;
    label: "Avg Productivity Score"
    value_format_name: decimal_3
  }
}
