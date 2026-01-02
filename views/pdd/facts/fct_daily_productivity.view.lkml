# =============================================================================
# FCT_DAILY_PRODUCTIVITY - Daily Productivity Summary
# Grain: One row per day (aggregated from RescueTime)
# Source: markr-data-lake.mark_dw_warehouse.fct_daily_productivity
# =============================================================================

view: fct_daily_productivity {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.fct_daily_productivity` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: daily_productivity_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.daily_productivity_pk ;;
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
  # TIME DIMENSIONS
  # =============================================================================

  dimension: total_tracked_hours {
    type: number
    sql: ${TABLE}.total_tracked_hours ;;
    label: "Total Tracked (hours)"
    value_format_name: decimal_1
    group_label: "Time Metrics"
    description: "Total tracked time (hours)"
  }

  dimension: productive_hours {
    type: number
    sql: ${TABLE}.productive_hours ;;
    label: "Productive (hours)"
    value_format_name: decimal_1
    group_label: "Time Metrics"
    description: "Productive time (hours)"
  }

  dimension: neutral_hours {
    type: number
    sql: ${TABLE}.neutral_hours ;;
    label: "Neutral (hours)"
    value_format_name: decimal_1
    group_label: "Time Metrics"
    description: "Neutral time (hours)"
  }

  dimension: distracting_hours {
    type: number
    sql: ${TABLE}.distracting_hours ;;
    label: "Distracting (hours)"
    value_format_name: decimal_1
    group_label: "Time Metrics"
    description: "Distracting time (hours)"
  }

  dimension: communication_hours {
    type: number
    sql: ${TABLE}.communication_hours ;;
    label: "Communication (hours)"
    value_format_name: decimal_1
    group_label: "Time Metrics"
    description: "Time spent on communication apps"
  }

  # =============================================================================
  # PRODUCTIVITY DIMENSIONS
  # =============================================================================

  dimension: focus_ratio {
    type: number
    sql: ${TABLE}.focus_ratio ;;
    label: "Focus Ratio"
    value_format_name: percent_1
    group_label: "Productivity Metrics"
    description: "Productive / Total time ratio"
  }

  dimension: productivity_score {
    type: number
    sql: ${TABLE}.productivity_score ;;
    label: "Productivity Score"
    value_format_name: decimal_1
    group_label: "Productivity Metrics"
    description: "Weighted productivity score"
  }

  # =============================================================================
  # SESSION DIMENSIONS
  # =============================================================================

  dimension: deep_work_blocks {
    type: number
    sql: ${TABLE}.deep_work_blocks ;;
    label: "Deep Work Blocks"
    value_format_name: decimal_0
    group_label: "Sessions"
    description: "Number of 90+ minute focused sessions"
  }

  dimension: focus_sessions {
    type: number
    sql: ${TABLE}.focus_sessions ;;
    label: "Focus Sessions"
    value_format_name: decimal_0
    group_label: "Sessions"
    description: "Number of focused work sessions"
  }

  dimension: fragmented_sessions {
    type: number
    sql: ${TABLE}.fragmented_sessions ;;
    label: "Fragmented Sessions"
    value_format_name: decimal_0
    group_label: "Sessions"
    description: "Number of fragmented sessions"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Day Count"
    drill_fields: [pdd_dim_date.full_date, productive_hours, focus_ratio, deep_work_blocks]
  }

  measure: total_productive_hours {
    type: sum
    sql: ${productive_hours} ;;
    label: "Total Productive Hours"
    value_format_name: decimal_1
  }

  measure: avg_productive_hours {
    type: average
    sql: ${productive_hours} ;;
    label: "Avg Productive Hours"
    value_format_name: decimal_1
  }

  measure: total_distracting_hours {
    type: sum
    sql: ${distracting_hours} ;;
    label: "Total Distracting Hours"
    value_format_name: decimal_1
  }

  measure: avg_distracting_hours {
    type: average
    sql: ${distracting_hours} ;;
    label: "Avg Distracting Hours"
    value_format_name: decimal_1
  }

  measure: avg_focus_ratio {
    type: average
    sql: ${focus_ratio} ;;
    label: "Avg Focus Ratio"
    value_format_name: percent_1
  }

  measure: avg_productivity_score {
    type: average
    sql: ${productivity_score} ;;
    label: "Avg Productivity Score"
    value_format_name: decimal_1
  }

  measure: total_deep_work_blocks {
    type: sum
    sql: ${deep_work_blocks} ;;
    label: "Total Deep Work Blocks"
    value_format_name: decimal_0
  }

  measure: avg_deep_work_blocks {
    type: average
    sql: ${deep_work_blocks} ;;
    label: "Avg Deep Work Blocks"
    value_format_name: decimal_1
  }

  measure: total_communication_hours {
    type: sum
    sql: ${communication_hours} ;;
    label: "Total Communication Hours"
    value_format_name: decimal_1
  }

  measure: avg_communication_hours {
    type: average
    sql: ${communication_hours} ;;
    label: "Avg Communication Hours"
    value_format_name: decimal_1
  }

  measure: total_tracked_hours_measure {
    type: sum
    sql: ${total_tracked_hours} ;;
    label: "Total Tracked Hours"
    value_format_name: decimal_1
  }
}
