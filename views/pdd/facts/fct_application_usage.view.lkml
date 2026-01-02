# =============================================================================
# FCT_APPLICATION_USAGE - Application Usage
# Grain: One row per application per time period (from RescueTime)
# Source: ra-development.pdd_analytics.app_usage_fct
# =============================================================================

view: fct_application_usage {
  sql_table_name: `ra-development.pdd_analytics.app_usage_fct` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: usage_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.usage_pk ;;
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

  dimension: time_fk {
    type: number
    sql: ${TABLE}.time_fk ;;
    hidden: yes
    description: "Foreign key to dim_time_of_day"
  }

  dimension: application_fk {
    type: string
    sql: ${TABLE}.application_fk ;;
    hidden: yes
    description: "Foreign key to dim_application"
  }

  # =============================================================================
  # TIMESTAMP DIMENSIONS
  # =============================================================================

  dimension_group: activity {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year, hour_of_day]
    datatype: timestamp
    sql: ${TABLE}.activity_timestamp ;;
    label: "Activity"
    description: "Activity timestamp"
  }

  # =============================================================================
  # DURATION DIMENSIONS
  # =============================================================================

  dimension: duration_seconds {
    type: number
    sql: ${TABLE}.duration_seconds ;;
    label: "Duration (sec)"
    value_format_name: decimal_0
    hidden: yes
    description: "Duration in seconds"
  }

  dimension: duration_minutes {
    type: number
    sql: ${TABLE}.duration_minutes ;;
    label: "Duration (min)"
    value_format_name: decimal_1
    description: "Duration in minutes"
  }

  dimension: duration_hours {
    type: number
    sql: ${TABLE}.duration_hours ;;
    label: "Duration (hours)"
    value_format_name: decimal_2
    description: "Duration in hours"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Activity Count"
    drill_fields: [dim_application.application_name, activity_date, duration_minutes]
  }

  measure: total_duration_seconds {
    type: sum
    sql: ${duration_seconds} ;;
    label: "Total Duration (sec)"
    value_format_name: decimal_0
    hidden: yes
  }

  measure: total_duration_minutes {
    type: sum
    sql: ${duration_minutes} ;;
    label: "Total Duration (min)"
    value_format_name: decimal_0
  }

  measure: total_duration_hours {
    type: sum
    sql: ${duration_hours} ;;
    label: "Total Duration (hours)"
    value_format_name: decimal_1
  }

  measure: avg_duration_minutes {
    type: average
    sql: ${duration_minutes} ;;
    label: "Avg Duration (min)"
    value_format_name: decimal_1
  }

  measure: pct_of_total_time {
    type: percent_of_total
    sql: ${total_duration_hours} ;;
    label: "% of Total Time"
    value_format_name: percent_1
    description: "Percentage of total tracked time"
  }
}
