# =============================================================================
# FCT_DAILY_ACTIVITY - Daily Activity Summaries
# Grain: One row per day (from Apple Health)
# Source: markr-data-lake.mark_dw_warehouse.fct_daily_activity
# =============================================================================

view: fct_daily_activity {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.fct_daily_activity` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: daily_activity_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.daily_activity_pk ;;
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
  # ACTIVITY DIMENSIONS
  # =============================================================================

  dimension: active_minutes {
    type: number
    sql: ${TABLE}.active_minutes ;;
    label: "Active Minutes"
    value_format_name: decimal_0
    description: "Active minutes"
  }

  dimension: active_calories {
    type: number
    sql: ${TABLE}.active_calories ;;
    label: "Active Calories"
    value_format_name: decimal_0
    description: "Active calories burned"
  }

  dimension: total_calories {
    type: number
    sql: ${TABLE}.total_calories ;;
    label: "Total Calories"
    value_format_name: decimal_0
    description: "Total calories burned"
  }

  dimension: steps {
    type: number
    sql: ${TABLE}.steps ;;
    label: "Steps"
    value_format_name: decimal_0
    description: "Step count"
  }

  dimension: stand_hours {
    type: number
    sql: ${TABLE}.stand_hours ;;
    label: "Stand Hours"
    value_format_name: decimal_0
    description: "Stand hours"
  }

  dimension: exercise_minutes {
    type: number
    sql: ${TABLE}.exercise_minutes ;;
    label: "Exercise Minutes"
    value_format_name: decimal_0
    description: "Exercise minutes"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Day Count"
    drill_fields: [dim_date.full_date, active_minutes, steps, active_calories]
  }

  measure: total_active_minutes {
    type: sum
    sql: ${active_minutes} ;;
    label: "Total Active Minutes"
    value_format_name: decimal_0
  }

  measure: avg_active_minutes {
    type: average
    sql: ${active_minutes} ;;
    label: "Avg Active Minutes"
    value_format_name: decimal_0
  }

  measure: total_steps {
    type: sum
    sql: ${steps} ;;
    label: "Total Steps"
    value_format_name: decimal_0
  }

  measure: avg_steps {
    type: average
    sql: ${steps} ;;
    label: "Avg Daily Steps"
    value_format_name: decimal_0
  }

  measure: total_active_calories {
    type: sum
    sql: ${active_calories} ;;
    label: "Total Active Calories"
    value_format_name: decimal_0
  }

  measure: avg_active_calories {
    type: average
    sql: ${active_calories} ;;
    label: "Avg Active Calories"
    value_format_name: decimal_0
  }

  measure: total_exercise_minutes {
    type: sum
    sql: ${exercise_minutes} ;;
    label: "Total Exercise Minutes"
    value_format_name: decimal_0
  }

  measure: avg_exercise_minutes {
    type: average
    sql: ${exercise_minutes} ;;
    label: "Avg Exercise Minutes"
    value_format_name: decimal_0
  }

  measure: avg_stand_hours {
    type: average
    sql: ${stand_hours} ;;
    label: "Avg Stand Hours"
    value_format_name: decimal_0
  }
}
