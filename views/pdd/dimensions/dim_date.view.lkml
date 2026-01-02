# =============================================================================
# DIM_DATE - Master Date Dimension
# Conformed dimension for all time-based analysis
# Source: markr-data-lake.mark_dw_warehouse.dim_date
# =============================================================================

view: dim_date {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.dim_date` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: date_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.date_key ;;
    hidden: yes
    description: "Surrogate key (YYYYMMDD format)"
  }

  # =============================================================================
  # CORE DATE DIMENSIONS
  # =============================================================================

  dimension_group: full {
    type: time
    label: "Date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.full_date ;;
    description: "Full date value"
  }

  # =============================================================================
  # DAY DIMENSIONS
  # =============================================================================

  dimension: day_of_week {
    type: number
    sql: ${TABLE}.day_of_week ;;
    group_label: "Day Details"
    description: "Day of week (1=Sunday, 7=Saturday)"
  }

  dimension: day_of_week_name {
    type: string
    sql: ${TABLE}.day_of_week_name ;;
    group_label: "Day Details"
    label: "Day Name"
    description: "Day name (Monday, Tuesday, etc.)"
    order_by_field: day_of_week
  }

  dimension: day_of_week_short {
    type: string
    sql: ${TABLE}.day_of_week_short ;;
    group_label: "Day Details"
    label: "Day (Short)"
    description: "Short day name (Mon, Tue, etc.)"
    order_by_field: day_of_week
  }

  dimension: day_of_month {
    type: number
    sql: ${TABLE}.day_of_month ;;
    group_label: "Day Details"
    description: "Day of month (1-31)"
  }

  dimension: day_of_year {
    type: number
    sql: ${TABLE}.day_of_year ;;
    group_label: "Day Details"
    description: "Day of year (1-366)"
  }

  # =============================================================================
  # WEEK DIMENSIONS
  # =============================================================================

  dimension: week_of_year {
    type: number
    sql: ${TABLE}.week_of_year ;;
    group_label: "Week Details"
    description: "ISO week number (1-53)"
  }

  dimension_group: week_start {
    type: time
    timeframes: [raw, date]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.week_start_date ;;
    group_label: "Week Details"
    description: "Start date of the week (Monday)"
  }

  dimension_group: week_end {
    type: time
    timeframes: [raw, date]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.week_end_date ;;
    group_label: "Week Details"
    description: "End date of the week (Sunday)"
  }

  dimension: year_week {
    type: string
    sql: ${TABLE}.year_week ;;
    group_label: "Week Details"
    label: "Year-Week"
    description: "Year-Week (YYYY-W01)"
  }

  # =============================================================================
  # MONTH DIMENSIONS
  # =============================================================================

  dimension: month_number {
    type: number
    sql: ${TABLE}.month_number ;;
    group_label: "Month Details"
    description: "Month number (1-12)"
  }

  dimension: month_name {
    type: string
    sql: ${TABLE}.month_name ;;
    group_label: "Month Details"
    description: "Month name (January, February, etc.)"
    order_by_field: month_number
  }

  dimension: month_short {
    type: string
    sql: ${TABLE}.month_short ;;
    group_label: "Month Details"
    label: "Month (Short)"
    description: "Short month name (Jan, Feb, etc.)"
    order_by_field: month_number
  }

  dimension_group: month_start {
    type: time
    timeframes: [raw, date]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.month_start_date ;;
    group_label: "Month Details"
    description: "First day of the month"
  }

  dimension_group: month_end {
    type: time
    timeframes: [raw, date]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.month_end_date ;;
    group_label: "Month Details"
    description: "Last day of the month"
  }

  dimension: year_month {
    type: string
    sql: ${TABLE}.year_month ;;
    group_label: "Month Details"
    label: "Year-Month"
    description: "Year-Month (YYYY-MM)"
  }

  # =============================================================================
  # QUARTER DIMENSIONS
  # =============================================================================

  dimension: quarter_number {
    type: number
    sql: ${TABLE}.quarter_number ;;
    group_label: "Quarter Details"
    description: "Quarter number (1-4)"
  }

  dimension: quarter_name {
    type: string
    sql: ${TABLE}.quarter_name ;;
    group_label: "Quarter Details"
    description: "Quarter name (Q1, Q2, Q3, Q4)"
    order_by_field: quarter_number
  }

  dimension: year_quarter {
    type: string
    sql: ${TABLE}.year_quarter ;;
    group_label: "Quarter Details"
    label: "Year-Quarter"
    description: "Year-Quarter (YYYY-Q1)"
  }

  # =============================================================================
  # YEAR DIMENSIONS
  # =============================================================================

  dimension: year_number {
    type: number
    sql: ${TABLE}.year_number ;;
    group_label: "Year Details"
    label: "Year"
    description: "Year (YYYY)"
  }

  # =============================================================================
  # WEEKEND/WEEKDAY FLAGS
  # =============================================================================

  dimension: is_weekend {
    type: yesno
    sql: ${TABLE}.is_weekend ;;
    group_label: "Day Flags"
    description: "TRUE if Saturday or Sunday"
  }

  dimension: is_weekday {
    type: yesno
    sql: ${TABLE}.is_weekday ;;
    group_label: "Day Flags"
    description: "TRUE if Monday-Friday"
  }

  # =============================================================================
  # CURRENT PERIOD FLAGS
  # =============================================================================

  dimension: is_current_day {
    type: yesno
    sql: ${TABLE}.is_current_day ;;
    group_label: "Current Period"
    description: "TRUE if this is today"
  }

  dimension: is_current_week {
    type: yesno
    sql: ${TABLE}.is_current_week ;;
    group_label: "Current Period"
    description: "TRUE if this week"
  }

  dimension: is_current_month {
    type: yesno
    sql: ${TABLE}.is_current_month ;;
    group_label: "Current Period"
    description: "TRUE if this month"
  }

  dimension: is_current_quarter {
    type: yesno
    sql: ${TABLE}.is_current_quarter ;;
    group_label: "Current Period"
    description: "TRUE if this quarter"
  }

  dimension: is_current_year {
    type: yesno
    sql: ${TABLE}.is_current_year ;;
    group_label: "Current Period"
    description: "TRUE if this year"
  }

  dimension: days_ago {
    type: number
    sql: ${TABLE}.days_ago ;;
    group_label: "Relative Time"
    description: "Number of days ago from today"
  }

  # =============================================================================
  # LIFE PHASE / ANALYSIS DIMENSIONS
  # =============================================================================

  dimension: life_phase {
    type: string
    sql: ${TABLE}.life_phase ;;
    group_label: "Analysis"
    description: "Life phase: Pre-Pandemic, During Pandemic, Post-Pandemic"
  }

  dimension: season {
    type: string
    sql: ${TABLE}.season ;;
    group_label: "Analysis"
    description: "Season: Spring, Summer, Autumn, Winter"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Day Count"
    drill_fields: [full_date, day_of_week_name, month_name, year_number]
  }
}
