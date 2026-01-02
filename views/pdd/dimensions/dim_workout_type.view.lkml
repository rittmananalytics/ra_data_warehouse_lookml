# =============================================================================
# DIM_WORKOUT_TYPE - Workout/Activity Types
# For fitness and workout analysis
# Source: ra-development.pdd_analytics.workout_type_dim
# =============================================================================

view: dim_workout_type {
  sql_table_name: `ra-development.pdd_analytics.workout_type_dim` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: workout_type_key {
    primary_key: yes
    type: string
    sql: ${TABLE}.workout_type_key ;;
    hidden: yes
    description: "Primary key (hash of workout type)"
  }

  # =============================================================================
  # WORKOUT TYPE DIMENSIONS
  # =============================================================================

  dimension: workout_type {
    type: string
    sql: ${TABLE}.workout_type ;;
    label: "Workout Type"
    description: "Standardized workout type"
  }

  dimension: workout_category {
    type: string
    sql: ${TABLE}.workout_category ;;
    label: "Category"
    description: "Cardio, Strength, Flexibility, Sports"
  }

  dimension: intensity_level {
    type: string
    sql: ${TABLE}.intensity_level ;;
    label: "Intensity Level"
    description: "high, medium, low"
  }

  dimension: source_workout_type {
    type: string
    sql: ${TABLE}.source_workout_type ;;
    label: "Source Type"
    description: "Original workout type from source"
  }

  # =============================================================================
  # WORKOUT TYPE FLAGS
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

  dimension: is_mixed {
    type: yesno
    sql: ${TABLE}.is_mixed ;;
    label: "Is Mixed"
    description: "TRUE if both cardio and strength"
  }

  dimension: is_high_intensity {
    type: yesno
    sql: ${TABLE}.is_high_intensity ;;
    label: "Is High Intensity"
    description: "TRUE if high intensity"
  }

  dimension: is_medium_intensity {
    type: yesno
    sql: ${TABLE}.is_medium_intensity ;;
    label: "Is Medium Intensity"
    description: "TRUE if medium intensity"
  }

  dimension: is_low_intensity {
    type: yesno
    sql: ${TABLE}.is_low_intensity ;;
    label: "Is Low Intensity"
    description: "TRUE if low intensity"
  }

  dimension: is_cardio_category {
    type: yesno
    sql: ${TABLE}.is_cardio_category ;;
    label: "Is Cardio Category"
    description: "TRUE if Cardio category"
  }

  dimension: is_strength_category {
    type: yesno
    sql: ${TABLE}.is_strength_category ;;
    label: "Is Strength Category"
    description: "TRUE if Strength category"
  }

  dimension: is_flexibility_category {
    type: yesno
    sql: ${TABLE}.is_flexibility_category ;;
    label: "Is Flexibility Category"
    description: "TRUE if Flexibility category"
  }

  dimension: is_sports_category {
    type: yesno
    sql: ${TABLE}.is_sports_category ;;
    label: "Is Sports Category"
    description: "TRUE if Sports category"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Workout Type Count"
    drill_fields: [workout_type, workout_category, intensity_level]
  }
}
