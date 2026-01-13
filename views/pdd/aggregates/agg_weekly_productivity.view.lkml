# =============================================================================
# AGG_WEEKLY_PRODUCTIVITY - Weekly Productivity Summary
# Grain: One row per week
# Source: ra-development.pdd_analytics.weekly_productivity_summary_agg
# =============================================================================

view: agg_weekly_productivity {
  sql_table_name: `ra-development.pdd_analytics.weekly_productivity_summary_agg` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: pk {
    primary_key: yes
    type: date
    sql: ${TABLE}.week_start_date ;;
    hidden: yes
    description: "Primary key - week start date"
  }

  dimension_group: week_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.week_start_date ;;
    label: "Week Start"
    description: "Week start date (Monday)"
  }

  # =============================================================================
  # WEEK DIMENSIONS
  # =============================================================================

  dimension: year_week {
    type: string
    sql: ${TABLE}.year_week ;;
    label: "Year-Week"
    description: "Year-Week (YYYY-W01)"
  }

  # =============================================================================
  # PRODUCTIVITY DIMENSIONS
  # =============================================================================

  dimension: total_productive_hours {
    type: number
    sql: ${TABLE}.total_productive_hours ;;
    label: "Total Productive Hours"
    value_format_name: decimal_1
    description: "Total productive hours"
  }

  dimension: avg_daily_productive_hours {
    type: number
    sql: ${TABLE}.avg_daily_productive_hours ;;
    label: "Avg Daily Productive Hours"
    value_format_name: decimal_1
    description: "Average daily productive hours"
  }

  dimension: total_distracting_hours {
    type: number
    sql: ${TABLE}.total_distracting_hours ;;
    label: "Total Distracting Hours"
    value_format_name: decimal_1
    description: "Total distracting hours"
  }

  dimension: avg_focus_ratio {
    type: number
    sql: ${TABLE}.avg_focus_ratio ;;
    label: "Avg Focus Ratio"
    value_format_name: percent_1
    description: "Average focus ratio"
  }

  dimension: deep_work_blocks {
    type: number
    sql: ${TABLE}.deep_work_blocks ;;
    label: "Deep Work Blocks"
    value_format_name: decimal_0
    description: "Total deep work blocks"
  }

  dimension: days_tracked {
    type: number
    sql: ${TABLE}.days_tracked ;;
    label: "Days Tracked"
    value_format_name: decimal_0
    description: "Number of days with data"
  }

  # =============================================================================
  # COMPARISON DIMENSIONS
  # =============================================================================

  dimension: productive_hours_wow_change {
    type: number
    sql: ${TABLE}.productive_hours_wow_change ;;
    label: "Productive Hours WoW Change"
    value_format_name: decimal_1
    group_label: "Comparisons"
    description: "Week-over-week change in productive hours"
  }

  dimension: focus_ratio_wow_change {
    type: number
    sql: ${TABLE}.focus_ratio_wow_change ;;
    label: "Focus Ratio WoW Change"
    value_format_name: percent_1
    group_label: "Comparisons"
    description: "Week-over-week change in focus ratio"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Week Count"
    drill_fields: [week_start_date, year_week, total_productive_hours, avg_focus_ratio]
  }

  measure: sum_productive_hours {
    type: sum
    sql: ${total_productive_hours} ;;
    label: "Total Productive Hours"
    value_format_name: decimal_1
  }

  measure: avg_weekly_productive_hours {
    type: average
    sql: ${total_productive_hours} ;;
    label: "Avg Weekly Productive Hours"
    value_format_name: decimal_1
  }

  measure: avg_focus_ratio_measure {
    type: average
    sql: ${avg_focus_ratio} ;;
    label: "Avg Focus Ratio"
    value_format_name: percent_1
  }

  measure: total_deep_work_blocks {
    type: sum
    sql: ${deep_work_blocks} ;;
    label: "Total Deep Work Blocks"
    value_format_name: decimal_0
  }
}
