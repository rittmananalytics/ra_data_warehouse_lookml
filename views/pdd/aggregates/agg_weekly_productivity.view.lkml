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

  dimension: week_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.week_key ;;
    hidden: yes
    description: "Primary key (YYYYMMDD format)"
  }

  # =============================================================================
  # DATE DIMENSIONS
  # =============================================================================

  dimension_group: week_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.week_start_date ;;
    label: "Week Start"
    description: "Week start date (Monday)"
  }

  dimension: week_number {
    type: number
    sql: ${TABLE}.week_number ;;
    label: "Week Number"
    description: "ISO week number"
  }

  dimension: year_number {
    type: number
    sql: ${TABLE}.year_number ;;
    label: "Year"
    description: "Year"
  }

  dimension: year_week {
    type: string
    sql: ${TABLE}.year_week ;;
    label: "Year-Week"
    description: "YYYY-Www format"
  }

  # =============================================================================
  # SCREEN TIME DIMENSIONS
  # =============================================================================

  dimension: total_screen_time {
    type: number
    sql: ${TABLE}.total_screen_time ;;
    label: "Total Screen Time (min)"
    value_format_name: decimal_0
    group_label: "Screen Time"
    description: "Total screen time in minutes"
  }

  dimension: total_screen_hours {
    type: number
    sql: ${TABLE}.total_screen_hours ;;
    label: "Total Screen Time (hours)"
    value_format_name: decimal_1
    group_label: "Screen Time"
    description: "Total screen time in hours"
  }

  dimension: avg_daily_screen_time {
    type: number
    sql: ${TABLE}.avg_daily_screen_time ;;
    label: "Avg Daily Screen Time (min)"
    value_format_name: decimal_0
    group_label: "Screen Time"
    description: "Average daily screen time"
  }

  dimension: avg_daily_screen_hours {
    type: number
    sql: ${TABLE}.avg_daily_screen_hours ;;
    label: "Avg Daily Screen Time (hours)"
    value_format_name: decimal_1
    group_label: "Screen Time"
    description: "Average daily screen hours"
  }

  # =============================================================================
  # CATEGORY DIMENSIONS
  # =============================================================================

  dimension: dev_minutes {
    type: number
    sql: ${TABLE}.dev_minutes ;;
    label: "Development (min)"
    value_format_name: decimal_0
    group_label: "By Category"
    description: "Development time"
  }

  dimension: comm_minutes {
    type: number
    sql: ${TABLE}.comm_minutes ;;
    label: "Communication (min)"
    value_format_name: decimal_0
    group_label: "By Category"
    description: "Communication time"
  }

  dimension: writing_minutes {
    type: number
    sql: ${TABLE}.writing_minutes ;;
    label: "Writing (min)"
    value_format_name: decimal_0
    group_label: "By Category"
    description: "Writing time"
  }

  dimension: analysis_minutes {
    type: number
    sql: ${TABLE}.analysis_minutes ;;
    label: "Analysis (min)"
    value_format_name: decimal_0
    group_label: "By Category"
    description: "Analysis time"
  }

  dimension: entertainment_minutes {
    type: number
    sql: ${TABLE}.entertainment_minutes ;;
    label: "Entertainment (min)"
    value_format_name: decimal_0
    group_label: "By Category"
    description: "Entertainment time"
  }

  dimension: social_media_minutes {
    type: number
    sql: ${TABLE}.social_media_minutes ;;
    label: "Social Media (min)"
    value_format_name: decimal_0
    group_label: "By Category"
    description: "Social media time"
  }

  # =============================================================================
  # CATEGORY PERCENTAGES
  # =============================================================================

  dimension: dev_pct {
    type: number
    sql: ${TABLE}.dev_pct ;;
    label: "Development %"
    value_format_name: decimal_1
    group_label: "Category %"
    description: "Development as % of total"
  }

  dimension: comm_pct {
    type: number
    sql: ${TABLE}.comm_pct ;;
    label: "Communication %"
    value_format_name: decimal_1
    group_label: "Category %"
    description: "Communication as % of total"
  }

  dimension: entertainment_pct {
    type: number
    sql: ${TABLE}.entertainment_pct ;;
    label: "Entertainment %"
    value_format_name: decimal_1
    group_label: "Category %"
    description: "Entertainment as % of total"
  }

  # =============================================================================
  # WORK VS LEISURE
  # =============================================================================

  dimension: work_minutes {
    type: number
    sql: ${TABLE}.work_minutes ;;
    label: "Work Time (min)"
    value_format_name: decimal_0
    group_label: "Work/Leisure"
    description: "Work-related time"
  }

  dimension: leisure_minutes {
    type: number
    sql: ${TABLE}.leisure_minutes ;;
    label: "Leisure Time (min)"
    value_format_name: decimal_0
    group_label: "Work/Leisure"
    description: "Leisure time"
  }

  dimension: work_pct {
    type: number
    sql: ${TABLE}.work_pct ;;
    label: "Work %"
    value_format_name: decimal_1
    group_label: "Work/Leisure"
    description: "Work as % of total"
  }

  dimension: leisure_pct {
    type: number
    sql: ${TABLE}.leisure_pct ;;
    label: "Leisure %"
    value_format_name: decimal_1
    group_label: "Work/Leisure"
    description: "Leisure as % of total"
  }

  # =============================================================================
  # PRODUCTIVITY DIMENSIONS
  # =============================================================================

  dimension: avg_daily_productivity_score {
    type: number
    sql: ${TABLE}.avg_daily_productivity_score ;;
    label: "Avg Productivity Score"
    value_format_name: decimal_2
    group_label: "Productivity"
    description: "Average daily productivity score"
  }

  dimension: productive_minutes {
    type: number
    sql: ${TABLE}.productive_minutes ;;
    label: "Productive Time (min)"
    value_format_name: decimal_0
    group_label: "Productivity"
    description: "Time on productive activities"
  }

  dimension: distracted_minutes {
    type: number
    sql: ${TABLE}.distracted_minutes ;;
    label: "Distracted Time (min)"
    value_format_name: decimal_0
    group_label: "Productivity"
    description: "Time on distracting activities"
  }

  dimension: productive_pct {
    type: number
    sql: ${TABLE}.productive_pct ;;
    label: "Productive %"
    value_format_name: decimal_1
    group_label: "Productivity"
    description: "Productive as % of total"
  }

  # =============================================================================
  # STATS
  # =============================================================================

  dimension: avg_daily_apps_used {
    type: number
    sql: ${TABLE}.avg_daily_apps_used ;;
    label: "Avg Daily Apps"
    value_format_name: decimal_1
    description: "Average unique apps per day"
  }

  dimension: days_with_data {
    type: number
    sql: ${TABLE}.days_with_data ;;
    label: "Days Tracked"
    value_format_name: decimal_0
    description: "Days with productivity data"
  }

  dimension: weekdays_tracked {
    type: number
    sql: ${TABLE}.weekdays_tracked ;;
    label: "Weekdays Tracked"
    value_format_name: decimal_0
    description: "Weekdays tracked"
  }

  dimension: weekend_days_tracked {
    type: number
    sql: ${TABLE}.weekend_days_tracked ;;
    label: "Weekend Days Tracked"
    value_format_name: decimal_0
    description: "Weekend days tracked"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Week Count"
    drill_fields: [week_start_date, year_week, total_screen_hours, avg_daily_productivity_score]
  }

  measure: sum_screen_time {
    type: sum
    sql: ${total_screen_time} ;;
    label: "Total Screen Time (min)"
    value_format_name: decimal_0
  }

  measure: avg_weekly_screen_hours {
    type: average
    sql: ${total_screen_hours} ;;
    label: "Avg Weekly Screen Time (hours)"
    value_format_name: decimal_1
  }

  measure: avg_productivity_score_measure {
    type: average
    sql: ${avg_daily_productivity_score} ;;
    label: "Avg Productivity Score"
    value_format_name: decimal_2
  }

  measure: sum_productive_minutes {
    type: sum
    sql: ${productive_minutes} ;;
    label: "Total Productive Time (min)"
    value_format_name: decimal_0
  }

  measure: sum_distracted_minutes {
    type: sum
    sql: ${distracted_minutes} ;;
    label: "Total Distracted Time (min)"
    value_format_name: decimal_0
  }
}
