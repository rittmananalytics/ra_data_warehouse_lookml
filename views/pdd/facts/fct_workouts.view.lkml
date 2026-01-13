# =============================================================================
# FCT_WORKOUTS - Workout Events
# Grain: One row per workout (from Apple Health + Strava)
# Source: ra-development.pdd_analytics.workouts_fct
# =============================================================================

view: fct_workouts {
  sql_table_name: `ra-development.pdd_analytics.workouts_fct` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: workout_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.workout_pk ;;
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

  dimension: workout_type_fk {
    type: string
    sql: ${TABLE}.workout_type_fk ;;
    hidden: yes
    description: "Foreign key to dim_workout_type"
  }

  # =============================================================================
  # TIMESTAMP DIMENSIONS
  # =============================================================================

  dimension_group: workout_start {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year, hour_of_day]
    datatype: timestamp
    sql: ${TABLE}.workout_start_ts ;;
    label: "Workout Start"
    description: "Workout start timestamp"
  }

  dimension_group: workout_end {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year, hour_of_day]
    datatype: timestamp
    sql: ${TABLE}.workout_end_ts ;;
    label: "Workout End"
    description: "Workout end timestamp"
  }

  # =============================================================================
  # WORKOUT DIMENSIONS
  # =============================================================================

  dimension: workout_name {
    type: string
    sql: ${TABLE}.workout_name ;;
    label: "Workout Name"
    description: "Workout name/title"
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
    label: "Source"
    description: "Apple Health, Strava"
  }

  dimension: duration_minutes {
    type: number
    sql: ${TABLE}.duration_minutes ;;
    label: "Duration (min)"
    value_format_name: decimal_0
    description: "Duration in minutes"
  }

  dimension: distance_km {
    type: number
    sql: ${TABLE}.distance_km ;;
    label: "Distance (km)"
    value_format_name: decimal_2
    description: "Distance in kilometers"
  }

  dimension: distance_meters {
    type: number
    sql: ${TABLE}.distance_meters ;;
    label: "Distance (m)"
    value_format_name: decimal_0
    hidden: yes
    description: "Distance in meters"
  }

  dimension: speed_km_h {
    type: number
    sql: ${TABLE}.speed_km_h ;;
    label: "Speed (km/h)"
    value_format_name: decimal_1
    description: "Average speed km/h"
  }

  dimension: calories_burned {
    type: number
    sql: ${TABLE}.calories_burned ;;
    label: "Calories"
    value_format_name: decimal_0
    description: "Calories burned"
  }

  dimension: avg_heart_rate {
    type: number
    sql: ${TABLE}.avg_heart_rate ;;
    label: "Avg Heart Rate"
    value_format_name: decimal_0
    description: "Average heart rate (bpm)"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Workout Count"
    drill_fields: [workout_start_date, workout_name, duration_minutes, distance_km, calories_burned]
  }

  measure: total_duration_minutes {
    type: sum
    sql: ${duration_minutes} ;;
    label: "Total Duration (min)"
    value_format_name: decimal_0
  }

  measure: total_duration_hours {
    type: sum
    sql: ${duration_minutes} / 60.0 ;;
    label: "Total Duration (hours)"
    value_format_name: decimal_1
  }

  measure: avg_duration_minutes {
    type: average
    sql: ${duration_minutes} ;;
    label: "Avg Duration (min)"
    value_format_name: decimal_0
  }

  measure: total_distance_km {
    type: sum
    sql: ${distance_km} ;;
    label: "Total Distance (km)"
    value_format_name: decimal_1
  }

  measure: avg_distance_km {
    type: average
    sql: ${distance_km} ;;
    label: "Avg Distance (km)"
    value_format_name: decimal_1
  }

  measure: total_calories {
    type: sum
    sql: ${calories_burned} ;;
    label: "Total Calories"
    value_format_name: decimal_0
  }

  measure: avg_calories {
    type: average
    sql: ${calories_burned} ;;
    label: "Avg Calories"
    value_format_name: decimal_0
  }

  measure: avg_speed_km_h {
    type: average
    sql: ${speed_km_h} ;;
    label: "Avg Speed (km/h)"
    value_format_name: decimal_1
  }

  measure: avg_heart_rate_measure {
    type: average
    sql: ${avg_heart_rate} ;;
    label: "Avg Heart Rate"
    value_format_name: decimal_0
  }

  measure: max_distance_km {
    type: max
    sql: ${distance_km} ;;
    label: "Longest Workout (km)"
    value_format_name: decimal_1
    description: "Longest single workout distance"
  }
}
