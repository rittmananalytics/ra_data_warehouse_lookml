# =============================================================================
# DIM_TIME_OF_DAY - Time of Day Dimension
# For hourly and time-of-day pattern analysis
# Source: ra-development.pdd_analytics.time_dim
# =============================================================================

view: dim_time_of_day {
  sql_table_name: `ra-development.pdd_analytics.time_dim` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: time_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.time_key ;;
    hidden: yes
    description: "Surrogate key (HHMM format, e.g., 1430)"
  }

  # =============================================================================
  # TIME DIMENSIONS
  # =============================================================================

  dimension: hour_of_day {
    type: number
    sql: ${TABLE}.hour_of_day ;;
    label: "Hour (24h)"
    description: "Hour (0-23)"
  }

  dimension: minute_of_hour {
    type: number
    sql: ${TABLE}.minute_of_hour ;;
    label: "Minute"
    description: "Minute (0-59)"
  }

  dimension: minute_of_day {
    type: number
    sql: ${TABLE}.minute_of_day ;;
    label: "Minute of Day"
    description: "Minute of day (0-1439)"
  }

  dimension: time_of_day {
    type: string
    sql: ${TABLE}.time_of_day ;;
    label: "Time (HH:MM)"
    description: "Formatted time (HH:MM)"
  }

  dimension: time_of_day_full {
    type: string
    sql: ${TABLE}.time_of_day_full ;;
    label: "Time (HH:MM:SS)"
    description: "Formatted time (HH:MM:SS)"
  }

  dimension: hour_12 {
    type: number
    sql: ${TABLE}.hour_12 ;;
    label: "Hour (12h)"
    description: "Hour in 12-hour format (1-12)"
  }

  dimension: am_pm {
    type: string
    sql: ${TABLE}.am_pm ;;
    label: "AM/PM"
    description: "AM or PM"
  }

  dimension: period_of_day {
    type: string
    sql: ${TABLE}.period_of_day ;;
    label: "Period of Day"
    description: "Morning, Afternoon, Evening, Night"
  }

  dimension: hour_band {
    type: string
    sql: ${TABLE}.hour_band ;;
    label: "Hour Band"
    description: "Detailed hour band (e.g., Morning (06-08))"
  }

  # =============================================================================
  # TIME FLAGS
  # =============================================================================

  dimension: is_work_hours {
    type: yesno
    sql: ${TABLE}.is_work_hours ;;
    label: "Work Hours"
    description: "TRUE if 9:00-17:00"
  }

  dimension: is_waking_hours {
    type: yesno
    sql: ${TABLE}.is_waking_hours ;;
    label: "Waking Hours"
    description: "TRUE if 6:00-22:00"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Time Slot Count"
  }
}
