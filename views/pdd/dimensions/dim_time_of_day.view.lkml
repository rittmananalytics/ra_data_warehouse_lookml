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

  dimension: time_of_day_name {
    type: string
    sql: ${TABLE}.time_of_day_name ;;
    label: "Time Period"
    description: "Time period: Morning, Afternoon, Evening, Night"
  }

  # =============================================================================
  # TIME FLAGS
  # =============================================================================

  dimension: is_business_hours {
    type: yesno
    sql: ${TABLE}.is_business_hours ;;
    label: "Business Hours"
    description: "TRUE if 9:00-17:00"
  }

  dimension: is_peak_hours {
    type: yesno
    sql: ${TABLE}.is_peak_hours ;;
    label: "Peak Hours"
    description: "TRUE if 9:00-12:00 or 14:00-17:00"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Time Slot Count"
  }
}
