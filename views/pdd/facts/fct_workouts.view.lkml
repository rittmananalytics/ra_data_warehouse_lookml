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

  dimension: workout_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.workout_id ;;
    hidden: yes
    description: "Primary key"
  }

  # =============================================================================
  # FOREIGN KEYS
  # =============================================================================

  dimension: date_key {
    type: number
    sql: ${TABLE}.date_key ;;
    hidden: yes
    description: "Foreign key to date_dim"
  }

  dimension: start_time_key {
    type: number
    sql: ${TABLE}.start_time_key ;;
    hidden: yes
    description: "Foreign key to time_dim"
  }

  dimension: workout_type_key {
    type: string
    sql: ${TABLE}.workout_type_key ;;
    hidden: yes
    description: "Foreign key to workout_type_dim"
  }

  dimension: device_key {
    type: string
    sql: ${TABLE}.device_key ;;
    hidden: yes
    description: "Foreign key to device_dim"
  }

  # =============================================================================
  # TIMESTAMP DIMENSIONS
  # =============================================================================

  dimension_group: workout {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.workout_date ;;
    label: "Workout"
    description: "Workout date"
  }

  dimension_group: started {
    type: time
    timeframes: [raw, time, date, hour_of_day]
    datatype: timestamp
    sql: ${TABLE}.started_at ;;
    label: "Started"
    description: "Workout start timestamp"
  }

  dimension_group: ended {
    type: time
    timeframes: [raw, time, date, hour_of_day]
    datatype: timestamp
    sql: ${TABLE}.ended_at ;;
    label: "Ended"
    description: "Workout end timestamp"
  }

  # =============================================================================
  # WORKOUT DIMENSIONS
  # =============================================================================

  dimension: source_system {
    type: string
    sql: ${TABLE}.source_system ;;
    label: "Source"
    description: "Apple Health, Strava"
  }

  dimension: workout_type {
    type: string
    sql: ${TABLE}.workout_type ;;
    label: "Workout Type"
    description: "Type of workout"
  }

  dimension: workout_category {
    type: string
    sql: ${TABLE}.workout_category ;;
    label: "Category"
    description: "Cardio, Strength, etc."
  }

  dimension: intensity_level {
    type: string
    sql: ${TABLE}.intensity_level ;;
    label: "Intensity"
    description: "high, medium, low"
  }

  dimension: duration_minutes {
    type: number
    sql: ${TABLE}.duration_minutes ;;
    label: "Duration (min)"
    value_format_name: decimal_0
    description: "Duration in minutes"
  }

  dimension: total_energy_burned {
    type: number
    sql: ${TABLE}.total_energy_burned ;;
    label: "Calories"
    value_format_name: decimal_0
    description: "Total energy/calories burned"
  }

  dimension: distance {
    type: number
    sql: ${TABLE}.distance ;;
    label: "Distance (km)"
    value_format_name: decimal_2
    description: "Distance in kilometers"
  }

  # =============================================================================
  # WORKOUT FLAGS
  # =============================================================================

  dimension: is_cardio {
    type: yesno
    sql: ${TABLE}.is_cardio ;;
    label: "Is Cardio"
    description: "TRUE if cardio workout"
  }

  dimension: is_strength {
    type: yesno
    sql: ${TABLE}.is_strength ;;
    label: "Is Strength"
    description: "TRUE if strength workout"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Workout Count"
    drill_fields: [workout_date, workout_type, duration_minutes, distance]
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
    sql: ${distance} ;;
    label: "Total Distance (km)"
    value_format_name: decimal_1
  }

  measure: avg_distance_km {
    type: average
    sql: ${distance} ;;
    label: "Avg Distance (km)"
    value_format_name: decimal_1
  }

  measure: total_calories {
    type: sum
    sql: ${total_energy_burned} ;;
    label: "Total Calories"
    value_format_name: decimal_0
  }

  measure: avg_calories {
    type: average
    sql: ${total_energy_burned} ;;
    label: "Avg Calories"
    value_format_name: decimal_0
  }

  measure: cardio_workouts {
    type: count
    filters: [is_cardio: "yes"]
    label: "Cardio Workouts"
  }

  measure: strength_workouts {
    type: count
    filters: [is_strength: "yes"]
    label: "Strength Workouts"
  }

  measure: max_distance {
    type: max
    sql: ${distance} ;;
    label: "Longest Workout (km)"
    value_format_name: decimal_1
    description: "Longest single workout distance"
  }
}
