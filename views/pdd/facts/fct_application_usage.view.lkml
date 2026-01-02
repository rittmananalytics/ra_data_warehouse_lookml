# =============================================================================
# FCT_APPLICATION_USAGE - Application Usage
# Grain: One row per app usage session (from RescueTime)
# Source: ra-development.pdd_analytics.app_usage_fct
# =============================================================================

view: fct_application_usage {
  sql_table_name: `ra-development.pdd_analytics.app_usage_fct` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: usage_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.usage_id ;;
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

  dimension: application_key {
    type: string
    sql: ${TABLE}.application_key ;;
    hidden: yes
    description: "Foreign key to application_dim"
  }

  dimension: productivity_category_key {
    type: string
    sql: ${TABLE}.productivity_category_key ;;
    hidden: yes
    description: "Foreign key to productivity_category_dim"
  }

  # =============================================================================
  # TIMESTAMP DIMENSIONS
  # =============================================================================

  dimension_group: usage {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.usage_date ;;
    label: "Usage"
    description: "Usage date"
  }

  dimension_group: started {
    type: time
    timeframes: [raw, time, date, hour_of_day]
    datatype: timestamp
    sql: ${TABLE}.started_at ;;
    label: "Started"
    description: "Session start timestamp"
  }

  dimension_group: ended {
    type: time
    timeframes: [raw, time, date, hour_of_day]
    datatype: timestamp
    sql: ${TABLE}.ended_at ;;
    label: "Ended"
    description: "Session end timestamp"
  }

  # =============================================================================
  # USAGE DIMENSIONS
  # =============================================================================

  dimension: source_system {
    type: string
    sql: ${TABLE}.source_system ;;
    label: "Source"
    description: "Data source (RescueTime)"
  }

  dimension: application_name {
    type: string
    sql: ${TABLE}.application_name ;;
    label: "Application"
    description: "Application or website name"
  }

  dimension: context {
    type: string
    sql: ${TABLE}.context ;;
    label: "Context"
    description: "Activity context"
  }

  dimension: project_name {
    type: string
    sql: ${TABLE}.project_name ;;
    label: "Project"
    description: "Project name"
  }

  dimension: time_of_day {
    type: string
    sql: ${TABLE}.time_of_day ;;
    label: "Time of Day"
    description: "Time of day period"
  }

  dimension: productivity_category {
    type: string
    sql: ${TABLE}.productivity_category ;;
    label: "Productivity Category"
    description: "Category of productivity"
  }

  # =============================================================================
  # DURATION DIMENSIONS
  # =============================================================================

  dimension: duration_minutes {
    type: number
    sql: ${TABLE}.duration_minutes ;;
    label: "Duration (min)"
    value_format_name: decimal_1
    description: "Duration in minutes"
  }

  dimension: productivity_score {
    type: number
    sql: ${TABLE}.productivity_score ;;
    label: "Productivity Score"
    value_format_name: decimal_2
    description: "Session productivity score"
  }

  dimension: weighted_productivity {
    type: number
    sql: ${TABLE}.weighted_productivity ;;
    label: "Weighted Productivity"
    value_format_name: decimal_2
    description: "Duration-weighted productivity"
  }

  dimension: daily_app_total_minutes {
    type: number
    sql: ${TABLE}.daily_app_total_minutes ;;
    label: "Daily App Total (min)"
    value_format_name: decimal_1
    description: "Total app time that day"
  }

  dimension: daily_total_minutes {
    type: number
    sql: ${TABLE}.daily_total_minutes ;;
    label: "Daily Total (min)"
    value_format_name: decimal_1
    description: "Total screen time that day"
  }

  dimension: daily_productivity_score {
    type: number
    sql: ${TABLE}.daily_productivity_score ;;
    label: "Daily Productivity Score"
    value_format_name: decimal_2
    description: "Daily productivity score"
  }

  dimension: pct_of_daily_usage {
    type: number
    sql: ${TABLE}.pct_of_daily_usage ;;
    label: "% of Daily Usage"
    value_format_name: decimal_1
    description: "Percentage of daily screen time"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Session Count"
    drill_fields: [application_name, usage_date, duration_minutes]
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
    value_format_name: decimal_1
  }

  measure: avg_productivity_score {
    type: average
    sql: ${productivity_score} ;;
    label: "Avg Productivity Score"
    value_format_name: decimal_2
  }

  measure: total_weighted_productivity {
    type: sum
    sql: ${weighted_productivity} ;;
    label: "Total Weighted Productivity"
    value_format_name: decimal_0
  }
}
