# =============================================================================
# FCT_DAILY_HEALTH_METRICS - Daily Health Measurements
# Grain: One row per day (from Withings)
# Source: markr-data-lake.mark_dw_warehouse.fct_daily_health_metrics
# =============================================================================

view: fct_daily_health_metrics {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.fct_daily_health_metrics` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: health_metrics_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.health_metrics_pk ;;
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

  # =============================================================================
  # WEIGHT DIMENSIONS
  # =============================================================================

  dimension: weight_kg {
    type: number
    sql: ${TABLE}.weight_kg ;;
    label: "Weight (kg)"
    value_format_name: decimal_1
    group_label: "Weight"
    description: "Weight in kilograms"
  }

  dimension: weight_7d_ma {
    type: number
    sql: ${TABLE}.weight_7d_ma ;;
    label: "Weight 7-Day MA"
    value_format_name: decimal_1
    group_label: "Weight"
    description: "7-day moving average weight"
  }

  dimension: weight_30d_ma {
    type: number
    sql: ${TABLE}.weight_30d_ma ;;
    label: "Weight 30-Day MA"
    value_format_name: decimal_1
    group_label: "Weight"
    description: "30-day moving average weight"
  }

  dimension: weight_change_90d {
    type: number
    sql: ${TABLE}.weight_change_90d ;;
    label: "Weight Change (90d)"
    value_format_name: decimal_1
    group_label: "Weight"
    description: "Weight change vs 90 days ago"
  }

  # =============================================================================
  # BODY COMPOSITION DIMENSIONS
  # =============================================================================

  dimension: body_fat_pct {
    type: number
    sql: ${TABLE}.body_fat_pct ;;
    label: "Body Fat %"
    value_format_name: decimal_1
    group_label: "Body Composition"
    description: "Body fat percentage"
  }

  dimension: muscle_pct {
    type: number
    sql: ${TABLE}.muscle_pct ;;
    label: "Muscle %"
    value_format_name: decimal_1
    group_label: "Body Composition"
    description: "Muscle mass percentage"
  }

  dimension: bmi {
    type: number
    sql: ${TABLE}.bmi ;;
    label: "BMI"
    value_format_name: decimal_1
    group_label: "Body Composition"
    description: "Body Mass Index"
  }

  # =============================================================================
  # BLOOD PRESSURE DIMENSIONS
  # =============================================================================

  dimension: bp_systolic {
    type: number
    sql: ${TABLE}.bp_systolic ;;
    label: "Systolic BP"
    value_format_name: decimal_0
    group_label: "Blood Pressure"
    description: "Systolic blood pressure (mmHg)"
  }

  dimension: bp_diastolic {
    type: number
    sql: ${TABLE}.bp_diastolic ;;
    label: "Diastolic BP"
    value_format_name: decimal_0
    group_label: "Blood Pressure"
    description: "Diastolic blood pressure (mmHg)"
  }

  dimension: bp_status {
    type: string
    sql: ${TABLE}.bp_status ;;
    label: "BP Status"
    group_label: "Blood Pressure"
    description: "Normal, Elevated, High"
  }

  # =============================================================================
  # SLEEP DIMENSIONS
  # =============================================================================

  dimension: sleep_deep_minutes {
    type: number
    sql: ${TABLE}.sleep_deep_minutes ;;
    label: "Deep Sleep (min)"
    value_format_name: decimal_0
    group_label: "Sleep"
    description: "Deep sleep duration (minutes)"
  }

  dimension: sleep_rem_minutes {
    type: number
    sql: ${TABLE}.sleep_rem_minutes ;;
    label: "REM Sleep (min)"
    value_format_name: decimal_0
    group_label: "Sleep"
    description: "REM sleep duration (minutes)"
  }

  dimension: sleep_light_minutes {
    type: number
    sql: ${TABLE}.sleep_light_minutes ;;
    label: "Light Sleep (min)"
    value_format_name: decimal_0
    group_label: "Sleep"
    description: "Light sleep duration (minutes)"
  }

  dimension: sleep_total_minutes {
    type: number
    sql: ${TABLE}.sleep_total_minutes ;;
    label: "Total Sleep (min)"
    value_format_name: decimal_0
    group_label: "Sleep"
    description: "Total sleep duration (minutes)"
  }

  dimension: sleep_total_hours {
    type: number
    sql: ${TABLE}.sleep_total_minutes / 60.0 ;;
    label: "Total Sleep (hours)"
    value_format_name: decimal_1
    group_label: "Sleep"
    description: "Total sleep duration (hours)"
  }

  # =============================================================================
  # MEASURES - WEIGHT
  # =============================================================================

  measure: count {
    type: count
    label: "Day Count"
    drill_fields: [dim_date.full_date, weight_kg, body_fat_pct, sleep_total_hours]
  }

  measure: current_weight {
    type: max
    sql: ${weight_kg} ;;
    label: "Current Weight (kg)"
    value_format_name: decimal_1
    description: "Most recent weight measurement"
  }

  measure: avg_weight {
    type: average
    sql: ${weight_kg} ;;
    label: "Average Weight (kg)"
    value_format_name: decimal_1
  }

  measure: min_weight {
    type: min
    sql: ${weight_kg} ;;
    label: "Min Weight (kg)"
    value_format_name: decimal_1
  }

  measure: max_weight {
    type: max
    sql: ${weight_kg} ;;
    label: "Max Weight (kg)"
    value_format_name: decimal_1
  }

  measure: current_weight_7d_ma {
    type: max
    sql: ${weight_7d_ma} ;;
    label: "Current 7-Day MA Weight"
    value_format_name: decimal_1
    description: "Latest 7-day moving average weight"
  }

  # =============================================================================
  # MEASURES - BODY COMPOSITION
  # =============================================================================

  measure: avg_body_fat_pct {
    type: average
    sql: ${body_fat_pct} ;;
    label: "Avg Body Fat %"
    value_format_name: decimal_1
  }

  measure: avg_muscle_pct {
    type: average
    sql: ${muscle_pct} ;;
    label: "Avg Muscle %"
    value_format_name: decimal_1
  }

  measure: avg_bmi {
    type: average
    sql: ${bmi} ;;
    label: "Avg BMI"
    value_format_name: decimal_1
  }

  # =============================================================================
  # MEASURES - BLOOD PRESSURE
  # =============================================================================

  measure: avg_bp_systolic {
    type: average
    sql: ${bp_systolic} ;;
    label: "Avg Systolic BP"
    value_format_name: decimal_0
  }

  measure: avg_bp_diastolic {
    type: average
    sql: ${bp_diastolic} ;;
    label: "Avg Diastolic BP"
    value_format_name: decimal_0
  }

  # =============================================================================
  # MEASURES - SLEEP
  # =============================================================================

  measure: avg_sleep_hours {
    type: average
    sql: ${sleep_total_hours} ;;
    label: "Avg Sleep (hours)"
    value_format_name: decimal_1
  }

  measure: avg_deep_sleep_minutes {
    type: average
    sql: ${sleep_deep_minutes} ;;
    label: "Avg Deep Sleep (min)"
    value_format_name: decimal_0
  }

  measure: avg_rem_sleep_minutes {
    type: average
    sql: ${sleep_rem_minutes} ;;
    label: "Avg REM Sleep (min)"
    value_format_name: decimal_0
  }

  measure: avg_light_sleep_minutes {
    type: average
    sql: ${sleep_light_minutes} ;;
    label: "Avg Light Sleep (min)"
    value_format_name: decimal_0
  }

  measure: total_sleep_hours {
    type: sum
    sql: ${sleep_total_hours} ;;
    label: "Total Sleep (hours)"
    value_format_name: decimal_1
  }

  measure: deep_sleep_ratio {
    type: number
    sql: SAFE_DIVIDE(SUM(${sleep_deep_minutes}), SUM(${sleep_total_minutes})) ;;
    label: "Deep Sleep Ratio"
    value_format_name: percent_1
    description: "Percentage of sleep that is deep sleep"
  }
}
