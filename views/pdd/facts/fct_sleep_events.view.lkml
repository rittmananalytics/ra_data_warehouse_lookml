# =============================================================================
# FCT_SLEEP_EVENTS - Sleep Episodes
# Grain: One row per sleep episode (from Apple Health)
# Source: markr-data-lake.mark_dw_warehouse.fct_sleep_events
# =============================================================================

view: fct_sleep_events {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.fct_sleep_events` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: sleep_event_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.sleep_event_pk ;;
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
  # TIMESTAMP DIMENSIONS
  # =============================================================================

  dimension_group: sleep_start {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year, hour_of_day]
    datatype: timestamp
    sql: ${TABLE}.sleep_start_ts ;;
    label: "Sleep Start"
    description: "Sleep start timestamp"
  }

  dimension_group: sleep_end {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year, hour_of_day]
    datatype: timestamp
    sql: ${TABLE}.sleep_end_ts ;;
    label: "Sleep End"
    description: "Sleep end timestamp"
  }

  # =============================================================================
  # SLEEP DIMENSIONS
  # =============================================================================

  dimension: event_subtype {
    type: string
    sql: ${TABLE}.event_subtype ;;
    label: "Sleep Type"
    description: "asleep, in_bed"
  }

  dimension: duration_minutes {
    type: number
    sql: ${TABLE}.duration_minutes ;;
    label: "Duration (min)"
    value_format_name: decimal_0
    description: "Duration in minutes"
  }

  dimension: duration_hours {
    type: number
    sql: ${TABLE}.duration_hours ;;
    label: "Duration (hours)"
    value_format_name: decimal_1
    description: "Duration in hours"
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
    label: "Source"
    description: "Data source"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Sleep Event Count"
    drill_fields: [sleep_start_date, event_subtype, duration_hours, source]
  }

  measure: total_sleep_hours {
    type: sum
    sql: ${duration_hours} ;;
    label: "Total Sleep (hours)"
    value_format_name: decimal_1
  }

  measure: avg_sleep_hours {
    type: average
    sql: ${duration_hours} ;;
    label: "Avg Sleep (hours)"
    value_format_name: decimal_1
  }

  measure: total_sleep_minutes {
    type: sum
    sql: ${duration_minutes} ;;
    label: "Total Sleep (min)"
    value_format_name: decimal_0
  }

  measure: avg_sleep_minutes {
    type: average
    sql: ${duration_minutes} ;;
    label: "Avg Sleep (min)"
    value_format_name: decimal_0
  }
}
