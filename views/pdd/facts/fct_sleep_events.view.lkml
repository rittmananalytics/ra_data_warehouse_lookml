# =============================================================================
# FCT_SLEEP_EVENTS - Sleep Episodes
# Grain: One row per sleep session (from Apple Health)
# Source: ra-development.pdd_analytics.sleep_fct
# =============================================================================

view: fct_sleep_events {
  sql_table_name: `ra-development.pdd_analytics.sleep_fct` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: sleep_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.sleep_id ;;
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

  dimension: device_key {
    type: string
    sql: ${TABLE}.device_key ;;
    hidden: yes
    description: "Foreign key to device_dim"
  }

  # =============================================================================
  # TIMESTAMP DIMENSIONS
  # =============================================================================

  dimension_group: sleep {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.sleep_date ;;
    label: "Sleep"
    description: "Sleep date"
  }

  dimension_group: recorded {
    type: time
    timeframes: [raw, time, date, hour_of_day]
    datatype: timestamp
    sql: ${TABLE}.recorded_at ;;
    label: "Recorded"
    description: "When sleep was recorded"
  }

  # =============================================================================
  # SLEEP DIMENSIONS
  # =============================================================================

  dimension: source_system {
    type: string
    sql: ${TABLE}.source_system ;;
    label: "Source"
    description: "Data source"
  }

  dimension: sleep_quality {
    type: string
    sql: ${TABLE}.sleep_quality ;;
    label: "Sleep Quality"
    description: "Optimal, Adequate, Good, Insufficient, Excessive"
  }

  dimension: sleep_minutes {
    type: number
    sql: ${TABLE}.sleep_minutes ;;
    label: "Sleep (min)"
    value_format_name: decimal_0
    description: "Sleep duration in minutes"
  }

  dimension: sleep_hours {
    type: number
    sql: ${TABLE}.sleep_hours ;;
    label: "Sleep (hours)"
    value_format_name: decimal_1
    description: "Sleep duration in hours"
  }

  # =============================================================================
  # TREND DIMENSIONS
  # =============================================================================

  dimension: sleep_prev_day {
    type: number
    sql: ${TABLE}.sleep_prev_day ;;
    label: "Previous Day (min)"
    value_format_name: decimal_0
    group_label: "Trends"
    description: "Previous day sleep"
  }

  dimension: sleep_change_day {
    type: number
    sql: ${TABLE}.sleep_change_day ;;
    label: "Change from Prev Day"
    value_format_name: decimal_0
    group_label: "Trends"
    description: "Change from previous day"
  }

  dimension: sleep_prev_week {
    type: number
    sql: ${TABLE}.sleep_prev_week ;;
    label: "Previous Week (min)"
    value_format_name: decimal_0
    group_label: "Trends"
    description: "Previous week sleep"
  }

  dimension: sleep_change_week {
    type: number
    sql: ${TABLE}.sleep_change_week ;;
    label: "Change from Prev Week"
    value_format_name: decimal_0
    group_label: "Trends"
    description: "Change from previous week"
  }

  dimension: sleep_7d_avg {
    type: number
    sql: ${TABLE}.sleep_7d_avg ;;
    label: "7-Day Avg (min)"
    value_format_name: decimal_0
    group_label: "Trends"
    description: "7-day moving average"
  }

  dimension: sleep_30d_avg {
    type: number
    sql: ${TABLE}.sleep_30d_avg ;;
    label: "30-Day Avg (min)"
    value_format_name: decimal_0
    group_label: "Trends"
    description: "30-day moving average"
  }

  dimension: deviation_from_avg {
    type: number
    sql: ${TABLE}.deviation_from_avg ;;
    label: "Deviation from Avg"
    value_format_name: decimal_0
    group_label: "Trends"
    description: "Deviation from 7-day average"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Sleep Event Count"
    drill_fields: [sleep_date, sleep_quality, sleep_hours]
  }

  measure: total_sleep_hours {
    type: sum
    sql: ${sleep_hours} ;;
    label: "Total Sleep (hours)"
    value_format_name: decimal_1
  }

  measure: avg_sleep_hours {
    type: average
    sql: ${sleep_hours} ;;
    label: "Avg Sleep (hours)"
    value_format_name: decimal_1
  }

  measure: total_sleep_minutes {
    type: sum
    sql: ${sleep_minutes} ;;
    label: "Total Sleep (min)"
    value_format_name: decimal_0
  }

  measure: avg_sleep_minutes {
    type: average
    sql: ${sleep_minutes} ;;
    label: "Avg Sleep (min)"
    value_format_name: decimal_0
  }

  measure: optimal_sleep_days {
    type: count
    filters: [sleep_quality: "Optimal"]
    label: "Optimal Sleep Days"
  }

  measure: insufficient_sleep_days {
    type: count
    filters: [sleep_quality: "Insufficient"]
    label: "Insufficient Sleep Days"
  }
}
