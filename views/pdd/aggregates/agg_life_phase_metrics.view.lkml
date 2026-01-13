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
  # DATE DIMENSIONS
  # =============================================================================

  dimension_group: phase_start {
    type: time
    timeframes: [raw, date, month, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.phase_start_date ;;
    label: "Phase Start"
    description: "Phase start date"
  }

  dimension_group: phase_end {
    type: time
    timeframes: [raw, date, month, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.phase_end_date ;;
    label: "Phase End"
    description: "Phase end date"
  }

  # =============================================================================
  # PRODUCTIVITY DIMENSIONS
  # =============================================================================

  dimension: avg_productive_hours {
    type: number
    sql: ${TABLE}.avg_productive_hours ;;
    label: "Avg Productive Hours"
    value_format_name: decimal_1
    group_label: "Productivity"
    description: "Average daily productive hours"
  }

  dimension: avg_focus_ratio {
    type: number
    sql: ${TABLE}.avg_focus_ratio ;;
    label: "Avg Focus Ratio"
    value_format_name: percent_1
    group_label: "Productivity"
    description: "Average focus ratio"
  }

  # =============================================================================
  # EXERCISE DIMENSIONS
  # =============================================================================

  dimension: avg_workouts_per_week {
    type: number
    sql: ${TABLE}.avg_workouts_per_week ;;
    label: "Avg Workouts/Week"
    value_format_name: decimal_1
    group_label: "Exercise"
    description: "Average workouts per week"
  }

  dimension: avg_workout_duration {
    type: number
    sql: ${TABLE}.avg_workout_duration ;;
    label: "Avg Workout Duration (min)"
    value_format_name: decimal_0
    group_label: "Exercise"
    description: "Average workout duration (minutes)"
  }

  # =============================================================================
  # SPENDING DIMENSIONS
  # =============================================================================

  dimension: avg_monthly_spend_gbp {
    type: number
    sql: ${TABLE}.avg_monthly_spend_gbp ;;
    label: "Avg Monthly Spend"
    value_format_name: gbp
    group_label: "Spending"
    description: "Average monthly spending"
  }

  # =============================================================================
  # TRAVEL DIMENSIONS
  # =============================================================================

  dimension: avg_travel_days_per_month {
    type: number
    sql: ${TABLE}.avg_travel_days_per_month ;;
    label: "Avg Travel Days/Month"
    value_format_name: decimal_1
    group_label: "Travel"
    description: "Average travel days per month"
  }

  dimension: avg_home_pct {
    type: number
    sql: ${TABLE}.avg_home_pct ;;
    label: "Avg Home %"
    value_format_name: percent_1
    group_label: "Travel"
    description: "Average time at home percentage"
  }

  # =============================================================================
  # HEALTH DIMENSIONS
  # =============================================================================

  dimension: avg_sleep_hours {
    type: number
    sql: ${TABLE}.avg_sleep_hours ;;
    label: "Avg Sleep (hours)"
    value_format_name: decimal_1
    group_label: "Health"
    description: "Average sleep hours"
  }

  dimension: avg_weight_kg {
    type: number
    sql: ${TABLE}.avg_weight_kg ;;
    label: "Avg Weight (kg)"
    value_format_name: decimal_1
    group_label: "Health"
    description: "Average weight"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Phase Count"
    drill_fields: [life_phase, phase_start_date, phase_end_date, avg_productive_hours, avg_monthly_spend_gbp]
  }

  measure: avg_productive_hours_measure {
    type: average
    sql: ${avg_productive_hours} ;;
    label: "Avg Productive Hours"
    value_format_name: decimal_1
  }

  measure: avg_workouts_measure {
    type: average
    sql: ${avg_workouts_per_week} ;;
    label: "Avg Workouts/Week"
    value_format_name: decimal_1
  }

  measure: avg_spend_measure {
    type: average
    sql: ${avg_monthly_spend_gbp} ;;
    label: "Avg Monthly Spend"
    value_format_name: gbp
  }

  measure: avg_travel_days_measure {
    type: average
    sql: ${avg_travel_days_per_month} ;;
    label: "Avg Travel Days/Month"
    value_format_name: decimal_1
  }
}
