view: dim_date {
  sql_table_name: `ra-development.analytics_ecommerce_ecommerce.dim_date` ;;



  # Primary Key
  dimension: date_key {
    primary_key: yes
    type: string
    sql: ${TABLE}.date_key ;;
    description: "Primary key in YYYYMMDD format"
  }

  # Date Dimensions
  dimension_group: calendar {
    type: time
    timeframes: [raw, date, week, month, quarter, year, day_of_week, day_of_month, day_of_year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_actual ;;
    description: "Calendar date for time-based analysis"
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
    description: "Year (YYYY)"
  }

  dimension: quarter {
    type: number
    sql: ${TABLE}.quarter ;;
    description: "Quarter (1-4)"
  }

  dimension: month {
    type: number
    sql: ${TABLE}.month ;;
    description: "Month (1-12)"
  }

  dimension: week {
    type: number
    sql: ${TABLE}.week ;;
    description: "Week of year (1-53)"
  }

  dimension: day_of_year {
    type: number
    sql: ${TABLE}.day_of_year ;;
    description: "Day of year (1-366)"
  }

  dimension: day_of_month {
    type: number
    sql: ${TABLE}.day_of_month ;;
    description: "Day of month (1-31)"
  }

  dimension: day_of_week {
    type: number
    sql: ${TABLE}.day_of_week_number ;;
    description: "Day of week (1-7, Sunday=1)"
  }

  dimension: day_name {
    type: string
    sql: ${TABLE}.day_of_week_name ;;
    description: "Day name (Sunday, Monday, etc.)"
    order_by_field: day_of_week
  }

  dimension: month_name {
    type: string
    sql: ${TABLE}.month_name ;;
    description: "Month name (January, February, etc.)"
    order_by_field: month
  }

  dimension: quarter_name {
    type: string
    sql: ${TABLE}.quarter_name ;;
    description: "Quarter name (Q1, Q2, Q3, Q4)"
    order_by_field: quarter
  }

  # Boolean Flags
  dimension: is_weekend {
    type: yesno
    sql: ${TABLE}.is_weekend ;;
    description: "Weekend indicator"
  }

  dimension: is_holiday {
    type: yesno
    sql: ${TABLE}.is_holiday ;;
    description: "Holiday indicator"
  }

  dimension: holiday_name {
    type: string
    sql: ${TABLE}.holiday_name ;;
    description: "Holiday name if applicable"
  }

  # Fiscal Dimensions
  dimension: fiscal_year {
    type: number
    sql: ${TABLE}.fiscal_year ;;
    description: "Fiscal year"
  }

  dimension: fiscal_quarter {
    type: number
    sql: ${TABLE}.fiscal_quarter ;;
    description: "Fiscal quarter"
  }

  dimension: fiscal_month {
    type: number
    sql: ${TABLE}.fiscal_month ;;
    description: "Fiscal month"
  }

  # Period End Flags
  dimension: is_last_day_of_month {
    type: yesno
    sql: ${TABLE}.is_last_day_of_month ;;
    description: "Last day of month indicator"
  }

  dimension: is_last_day_of_quarter {
    type: yesno
    sql: ${TABLE}.is_last_day_of_quarter ;;
    description: "Last day of quarter indicator"
  }

  dimension: is_last_day_of_year {
    type: yesno
    sql: ${TABLE}.is_last_day_of_year ;;
    description: "Last day of year indicator"
  }

  # Derived Dimensions
  dimension: week_of_month {
    type: number
    sql: CEILING(${day_of_month} / 7.0) ;;
    description: "Week of month (1-5)"
  }

  dimension: is_weekday {
    type: yesno
    sql: NOT ${is_weekend} ;;
    description: "Weekday indicator (Monday-Friday)"
  }

  dimension: season {
    type: string
    sql: CASE
      WHEN ${month} IN (12, 1, 2) THEN 'Winter'
      WHEN ${month} IN (3, 4, 5) THEN 'Spring'
      WHEN ${month} IN (6, 7, 8) THEN 'Summer'
      WHEN ${month} IN (9, 10, 11) THEN 'Fall'
    END ;;
    description: "Season based on month"
  }

  # Measures
  measure: count {
    type: count
    drill_fields: [calendar_date, day_name, month_name]
  }

  measure: count_weekdays {
    type: count
    filters: [is_weekday: "yes"]
    description: "Count of weekdays in selected period"
  }

  measure: count_weekends {
    type: count
    filters: [is_weekend: "yes"]
    description: "Count of weekend days in selected period"
  }

  measure: count_holidays {
    type: count
    filters: [is_holiday: "yes"]
    description: "Count of holidays in selected period"
  }
}
