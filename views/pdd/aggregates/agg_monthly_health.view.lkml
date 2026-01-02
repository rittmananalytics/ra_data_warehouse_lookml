# =============================================================================
# AGG_MONTHLY_HEALTH - Monthly Health Summary
# Grain: One row per month
# Source: ra-development.pdd_analytics.monthly_health_summary_agg
# =============================================================================

view: agg_monthly_health {
  sql_table_name: `ra-development.pdd_analytics.monthly_health_summary_agg` ;;

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
    description: "Month name and year (January 2024)"
  }

  # =============================================================================
  # ACTIVITY DIMENSIONS
  # =============================================================================

  dimension: avg_daily_steps {
    type: number
    sql: ${TABLE}.avg_daily_steps ;;
    label: "Avg Daily Steps"
    value_format_name: decimal_0
    group_label: "Activity"
    description: "Average daily steps"
  }

  dimension: total_steps {
    type: number
    sql: ${TABLE}.total_steps ;;
    label: "Total Steps"
    value_format_name: decimal_0
    group_label: "Activity"
    description: "Total steps for month"
  }

  dimension: total_exercise_minutes {
    type: number
    sql: ${TABLE}.total_exercise_minutes ;;
    label: "Total Exercise (min)"
    value_format_name: decimal_0
    group_label: "Activity"
    description: "Total exercise minutes"
  }

  # =============================================================================
  # HEART DIMENSIONS
  # =============================================================================

  dimension: avg_heart_rate {
    type: number
    sql: ${TABLE}.avg_heart_rate ;;
    label: "Avg Heart Rate"
    value_format_name: decimal_0
    group_label: "Heart"
    description: "Average heart rate"
  }

  dimension: avg_resting_heart_rate {
    type: number
    sql: ${TABLE}.avg_resting_heart_rate ;;
    label: "Avg Resting HR"
    value_format_name: decimal_0
    group_label: "Heart"
    description: "Average resting heart rate"
  }

  dimension: avg_hrv {
    type: number
    sql: ${TABLE}.avg_hrv ;;
    label: "Avg HRV"
    value_format_name: decimal_1
    group_label: "Heart"
    description: "Average heart rate variability"
  }

  # =============================================================================
  # BODY DIMENSIONS
  # =============================================================================

  dimension: avg_weight_kg {
    type: number
    sql: ${TABLE}.avg_weight_kg ;;
    label: "Avg Weight (kg)"
    value_format_name: decimal_1
    group_label: "Body"
    description: "Average weight"
  }

  dimension: start_weight_kg {
    type: number
    sql: ${TABLE}.start_weight_kg ;;
    label: "Start Weight (kg)"
    value_format_name: decimal_1
    group_label: "Body"
    description: "Weight at start of month"
  }

  dimension: end_weight_kg {
    type: number
    sql: ${TABLE}.end_weight_kg ;;
    label: "End Weight (kg)"
    value_format_name: decimal_1
    group_label: "Body"
    description: "Weight at end of month"
  }

  dimension: weight_change_kg {
    type: number
    sql: ${TABLE}.weight_change_kg ;;
    label: "Weight Change (kg)"
    value_format_name: decimal_1
    group_label: "Body"
    description: "Weight change during month"
  }

  dimension: avg_body_fat_pct {
    type: number
    sql: ${TABLE}.avg_body_fat_pct ;;
    label: "Avg Body Fat %"
    value_format_name: decimal_1
    group_label: "Body"
    description: "Average body fat percentage"
  }

  # =============================================================================
  # SLEEP DIMENSIONS
  # =============================================================================

  dimension: avg_daily_sleep_hours {
    type: number
    sql: ${TABLE}.avg_daily_sleep_hours ;;
    label: "Avg Sleep (hours)"
    value_format_name: decimal_1
    group_label: "Sleep"
    description: "Average daily sleep hours"
  }

  # =============================================================================
  # WORKOUT DIMENSIONS
  # =============================================================================

  dimension: total_workouts {
    type: number
    sql: ${TABLE}.total_workouts ;;
    label: "Total Workouts"
    value_format_name: decimal_0
    group_label: "Workouts"
    description: "Total workouts for month"
  }

  dimension: total_workout_minutes {
    type: number
    sql: ${TABLE}.total_workout_minutes ;;
    label: "Total Workout Time (min)"
    value_format_name: decimal_0
    group_label: "Workouts"
    description: "Total workout minutes"
  }

  # =============================================================================
  # GOAL DIMENSIONS
  # =============================================================================

  dimension: days_hit_step_goal {
    type: number
    sql: ${TABLE}.days_hit_step_goal ;;
    label: "Days Hit Step Goal"
    value_format_name: decimal_0
    group_label: "Goals"
    description: "Days meeting step goal"
  }

  dimension: days_hit_exercise_goal {
    type: number
    sql: ${TABLE}.days_hit_exercise_goal ;;
    label: "Days Hit Exercise Goal"
    value_format_name: decimal_0
    group_label: "Goals"
    description: "Days meeting exercise goal"
  }

  dimension: days_hit_sleep_goal {
    type: number
    sql: ${TABLE}.days_hit_sleep_goal ;;
    label: "Days Hit Sleep Goal"
    value_format_name: decimal_0
    group_label: "Goals"
    description: "Days meeting sleep goal"
  }

  dimension: days_with_data {
    type: number
    sql: ${TABLE}.days_with_data ;;
    label: "Days Tracked"
    value_format_name: decimal_0
    description: "Number of days with health data"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Month Count"
    drill_fields: [year_month, avg_weight_kg, avg_daily_sleep_hours, total_workouts]
  }

  measure: avg_weight_measure {
    type: average
    sql: ${avg_weight_kg} ;;
    label: "Avg Weight (kg)"
    value_format_name: decimal_1
  }

  measure: avg_sleep_measure {
    type: average
    sql: ${avg_daily_sleep_hours} ;;
    label: "Avg Sleep (hours)"
    value_format_name: decimal_1
  }

  measure: sum_workouts {
    type: sum
    sql: ${total_workouts} ;;
    label: "Total Workouts"
    value_format_name: decimal_0
  }

  measure: sum_steps {
    type: sum
    sql: ${total_steps} ;;
    label: "Total Steps"
    value_format_name: decimal_0
  }

  measure: avg_steps_measure {
    type: average
    sql: ${avg_daily_steps} ;;
    label: "Avg Daily Steps"
    value_format_name: decimal_0
  }
}
