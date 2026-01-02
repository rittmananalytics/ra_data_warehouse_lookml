# =============================================================================
# FCT_DAILY_HEALTH_METRICS - Daily Health Measurements
# Grain: One row per health metric measurement
# Source: ra-development.pdd_analytics.health_metrics_fct
# =============================================================================

view: fct_daily_health_metrics {
  sql_table_name: `ra-development.pdd_analytics.health_metrics_fct` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: health_metric_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.health_metric_id ;;
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

  dimension: time_key {
    type: number
    sql: ${TABLE}.time_key ;;
    hidden: yes
    description: "Foreign key to time_dim"
  }

  dimension: metric_type_key {
    type: string
    sql: ${TABLE}.metric_type_key ;;
    hidden: yes
    description: "Foreign key to health_metric_type_dim"
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

  dimension_group: metric {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.metric_date ;;
    label: "Metric"
    description: "Metric date"
  }

  dimension_group: recorded {
    type: time
    timeframes: [raw, time, date, hour_of_day]
    datatype: timestamp
    sql: ${TABLE}.recorded_at ;;
    label: "Recorded"
    description: "When measurement was recorded"
  }

  # =============================================================================
  # METRIC DIMENSIONS
  # =============================================================================

  dimension: source_system {
    type: string
    sql: ${TABLE}.source_system ;;
    label: "Source"
    description: "Data source (Apple Health, Withings, etc.)"
  }

  dimension: metric_type {
    type: string
    sql: ${TABLE}.metric_type ;;
    label: "Metric Type"
    description: "Type of health metric"
  }

  dimension: metric_category {
    type: string
    sql: ${TABLE}.metric_category ;;
    label: "Metric Category"
    description: "Category of health metric"
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.unit ;;
    label: "Unit"
    description: "Measurement unit"
  }

  # =============================================================================
  # VALUE DIMENSIONS
  # =============================================================================

  dimension: metric_value {
    type: number
    sql: ${TABLE}.metric_value ;;
    label: "Metric Value"
    value_format_name: decimal_2
    description: "Measured value"
  }

  dimension: metric_value_7d_avg {
    type: number
    sql: ${TABLE}.metric_value_7d_avg ;;
    label: "7-Day Avg"
    value_format_name: decimal_2
    description: "7-day moving average"
  }

  dimension: metric_value_30d_avg {
    type: number
    sql: ${TABLE}.metric_value_30d_avg ;;
    label: "30-Day Avg"
    value_format_name: decimal_2
    description: "30-day moving average"
  }

  dimension: metric_value_prev_day {
    type: number
    sql: ${TABLE}.metric_value_prev_day ;;
    label: "Previous Day"
    value_format_name: decimal_2
    description: "Previous day value"
  }

  dimension: metric_value_prev_week {
    type: number
    sql: ${TABLE}.metric_value_prev_week ;;
    label: "Previous Week"
    value_format_name: decimal_2
    description: "Previous week value"
  }

  # =============================================================================
  # CHANGE DIMENSIONS
  # =============================================================================

  dimension: dod_change {
    type: number
    sql: ${TABLE}.dod_change ;;
    label: "Day-over-Day Change"
    value_format_name: decimal_2
    group_label: "Changes"
    description: "Change from previous day"
  }

  dimension: dod_change_pct {
    type: number
    sql: ${TABLE}.dod_change_pct ;;
    label: "Day-over-Day Change %"
    value_format_name: percent_1
    group_label: "Changes"
    description: "Percent change from previous day"
  }

  dimension: wow_change {
    type: number
    sql: ${TABLE}.wow_change ;;
    label: "Week-over-Week Change"
    value_format_name: decimal_2
    group_label: "Changes"
    description: "Change from previous week"
  }

  dimension: wow_change_pct {
    type: number
    sql: ${TABLE}.wow_change_pct ;;
    label: "Week-over-Week Change %"
    value_format_name: percent_1
    group_label: "Changes"
    description: "Percent change from previous week"
  }

  dimension: deviation_from_avg_pct {
    type: number
    sql: ${TABLE}.deviation_from_avg_pct ;;
    label: "Deviation from Avg %"
    value_format_name: percent_1
    group_label: "Changes"
    description: "Deviation from average"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Measurement Count"
    drill_fields: [metric_date, metric_type, metric_value]
  }

  measure: avg_metric_value {
    type: average
    sql: ${metric_value} ;;
    label: "Avg Value"
    value_format_name: decimal_2
  }

  measure: sum_metric_value {
    type: sum
    sql: ${metric_value} ;;
    label: "Total Value"
    value_format_name: decimal_0
  }

  measure: min_metric_value {
    type: min
    sql: ${metric_value} ;;
    label: "Min Value"
    value_format_name: decimal_2
  }

  measure: max_metric_value {
    type: max
    sql: ${metric_value} ;;
    label: "Max Value"
    value_format_name: decimal_2
  }

  measure: latest_metric_value {
    type: max
    sql: ${metric_value} ;;
    label: "Latest Value"
    value_format_name: decimal_2
    description: "Most recent value"
  }
}
