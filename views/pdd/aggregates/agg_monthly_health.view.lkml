# =============================================================================
# AGG_MONTHLY_HEALTH - Monthly Health Summary
# Grain: One row per month
# Source: markr-data-lake.mark_dw_warehouse.agg_monthly_health
# =============================================================================

view: agg_monthly_health {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.agg_monthly_health` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: year_month {
    primary_key: yes
    type: string
    sql: ${TABLE}.year_month ;;
    label: "Year-Month"
    description: "Year-Month"
  }

  # =============================================================================
  # WEIGHT DIMENSIONS
  # =============================================================================

  dimension: avg_weight_kg {
    type: number
    sql: ${TABLE}.avg_weight_kg ;;
    label: "Avg Weight (kg)"
    value_format_name: decimal_1
    group_label: "Weight"
    description: "Average weight"
  }

  dimension: min_weight_kg {
    type: number
    sql: ${TABLE}.min_weight_kg ;;
    label: "Min Weight (kg)"
    value_format_name: decimal_1
    group_label: "Weight"
    description: "Minimum weight"
  }

  dimension: max_weight_kg {
    type: number
    sql: ${TABLE}.max_weight_kg ;;
    label: "Max Weight (kg)"
    value_format_name: decimal_1
    group_label: "Weight"
    description: "Maximum weight"
  }

  dimension: weight_change {
    type: number
    sql: ${TABLE}.weight_change ;;
    label: "Weight Change"
    value_format_name: decimal_1
    group_label: "Weight"
    description: "Weight change from previous month"
  }

  # =============================================================================
  # BODY COMPOSITION DIMENSIONS
  # =============================================================================

  dimension: avg_body_fat_pct {
    type: number
    sql: ${TABLE}.avg_body_fat_pct ;;
    label: "Avg Body Fat %"
    value_format_name: decimal_1
    group_label: "Body Composition"
    description: "Average body fat %"
  }

  dimension: avg_muscle_pct {
    type: number
    sql: ${TABLE}.avg_muscle_pct ;;
    label: "Avg Muscle %"
    value_format_name: decimal_1
    group_label: "Body Composition"
    description: "Average muscle %"
  }

  # =============================================================================
  # SLEEP DIMENSIONS
  # =============================================================================

  dimension: avg_sleep_hours {
    type: number
    sql: ${TABLE}.avg_sleep_hours ;;
    label: "Avg Sleep (hours)"
    value_format_name: decimal_1
    group_label: "Sleep"
    description: "Average sleep hours"
  }

  dimension: avg_deep_sleep_pct {
    type: number
    sql: ${TABLE}.avg_deep_sleep_pct ;;
    label: "Avg Deep Sleep %"
    value_format_name: percent_1
    group_label: "Sleep"
    description: "Average deep sleep %"
  }

  # =============================================================================
  # BLOOD PRESSURE DIMENSIONS
  # =============================================================================

  dimension: avg_bp_systolic {
    type: number
    sql: ${TABLE}.avg_bp_systolic ;;
    label: "Avg Systolic BP"
    value_format_name: decimal_0
    group_label: "Blood Pressure"
    description: "Average systolic BP"
  }

  dimension: avg_bp_diastolic {
    type: number
    sql: ${TABLE}.avg_bp_diastolic ;;
    label: "Avg Diastolic BP"
    value_format_name: decimal_0
    group_label: "Blood Pressure"
    description: "Average diastolic BP"
  }

  # =============================================================================
  # ACTIVITY DIMENSIONS
  # =============================================================================

  dimension: avg_active_minutes {
    type: number
    sql: ${TABLE}.avg_active_minutes ;;
    label: "Avg Active Minutes"
    value_format_name: decimal_0
    group_label: "Activity"
    description: "Average daily active minutes"
  }

  dimension: total_workouts {
    type: number
    sql: ${TABLE}.total_workouts ;;
    label: "Total Workouts"
    value_format_name: decimal_0
    group_label: "Activity"
    description: "Total workout count"
  }

  dimension: total_cycling_km {
    type: number
    sql: ${TABLE}.total_cycling_km ;;
    label: "Total Cycling (km)"
    value_format_name: decimal_1
    group_label: "Activity"
    description: "Total cycling distance"
  }

  dimension: total_calories_burned {
    type: number
    sql: ${TABLE}.total_calories_burned ;;
    label: "Total Calories Burned"
    value_format_name: decimal_0
    group_label: "Activity"
    description: "Total calories burned in workouts"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Month Count"
    drill_fields: [year_month, avg_weight_kg, avg_sleep_hours, total_workouts]
  }

  measure: avg_weight_measure {
    type: average
    sql: ${avg_weight_kg} ;;
    label: "Avg Weight (kg)"
    value_format_name: decimal_1
  }

  measure: avg_sleep_measure {
    type: average
    sql: ${avg_sleep_hours} ;;
    label: "Avg Sleep (hours)"
    value_format_name: decimal_1
  }

  measure: sum_workouts {
    type: sum
    sql: ${total_workouts} ;;
    label: "Total Workouts"
    value_format_name: decimal_0
  }

  measure: sum_cycling_km {
    type: sum
    sql: ${total_cycling_km} ;;
    label: "Total Cycling (km)"
    value_format_name: decimal_1
  }

  measure: sum_calories_burned {
    type: sum
    sql: ${total_calories_burned} ;;
    label: "Total Calories Burned"
    value_format_name: decimal_0
  }
}
