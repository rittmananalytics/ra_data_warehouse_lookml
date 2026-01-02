# =============================================================================
# DIM_WORKOUT_TYPE - Workout/Activity Types
# For fitness and workout analysis
# Source: markr-data-lake.mark_dw_warehouse.dim_workout_type
# =============================================================================

view: dim_workout_type {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.dim_workout_type` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: workout_type_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.workout_type_pk ;;
    hidden: yes
    description: "Primary key"
  }

  # =============================================================================
  # WORKOUT TYPE DIMENSIONS
  # =============================================================================

  dimension: workout_type_name {
    type: string
    sql: ${TABLE}.workout_type_name ;;
    label: "Workout Type"
    description: "Workout type: Cycling, Swimming, Running, Walking, etc."
  }

  dimension: workout_category {
    type: string
    sql: ${TABLE}.workout_category ;;
    label: "Category"
    description: "Cardio, Strength, Flexibility, etc."
  }

  dimension: calories_per_minute {
    type: number
    sql: ${TABLE}.calories_per_minute ;;
    label: "Calories/Minute"
    value_format_name: decimal_1
    description: "Average calories burned per minute"
  }

  # =============================================================================
  # WORKOUT TYPE FLAGS
  # =============================================================================

  dimension: is_outdoor {
    type: yesno
    sql: ${TABLE}.is_outdoor ;;
    label: "Is Outdoor"
    description: "TRUE if typically outdoor activity"
  }

  dimension: is_indoor {
    type: yesno
    sql: ${TABLE}.is_indoor ;;
    label: "Is Indoor"
    description: "TRUE if typically indoor activity"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Workout Type Count"
    drill_fields: [workout_type_name, workout_category]
  }
}
