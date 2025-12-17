# Academic Year Dimension
# Supports 6-year trend analysis with current/prior year indicators

view: dim_academic_year {
  sql_table_name: `ra-warehouse-dev.analytics.dim_academic_year` ;;
  drill_fields: [academic_year_id, academic_year_name]

  # Primary Key
  dimension: academic_year_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.academic_year_key ;;
    hidden: yes
  }

  # Natural Key
  dimension: academic_year_id {
    type: string
    sql: ${TABLE}.academic_year_id ;;
    label: "Academic Year ID"
    description: "Academic year identifier (e.g., '23/24')"
    order_by_field: calendar_year_start
  }

  # Attributes
  dimension: academic_year_name {
    type: string
    sql: ${TABLE}.academic_year_name ;;
    label: "Academic Year"
    description: "Full academic year name (e.g., '2023/2024')"
    order_by_field: calendar_year_start
  }

  dimension_group: academic_year_start {
    type: time
    timeframes: [date, month, year]
    sql: ${TABLE}.academic_year_start_date ;;
    label: "Academic Year Start"
    description: "First day of academic year (Sept 1)"
  }

  dimension_group: academic_year_end {
    type: time
    timeframes: [date, month, year]
    sql: ${TABLE}.academic_year_end_date ;;
    label: "Academic Year End"
    description: "Last day of academic year (Aug 31)"
  }

  dimension: calendar_year_start {
    type: number
    sql: ${TABLE}.calendar_year_start ;;
    label: "Start Year"
    description: "Calendar year when academic year begins"
  }

  dimension: calendar_year_end {
    type: number
    sql: ${TABLE}.calendar_year_end ;;
    label: "End Year"
    description: "Calendar year when academic year ends"
  }

  dimension: is_current_year {
    type: yesno
    sql: ${TABLE}.is_current_year ;;
    label: "Is Current Year"
    description: "Flag indicating if this is the current academic year"
  }

  dimension: years_from_current {
    type: number
    sql: ${TABLE}.years_from_current ;;
    label: "Years from Current"
    description: "Number of years from current year (0=current, 1=prior year, etc.)"
  }

  # Derived dimensions for filtering
  dimension: year_category {
    type: string
    sql: CASE
      WHEN ${years_from_current} = 0 THEN 'Current Year'
      WHEN ${years_from_current} = 1 THEN 'Prior Year'
      WHEN ${years_from_current} <= 3 THEN 'Recent (2-3 Years)'
      ELSE 'Historical (4+ Years)'
    END ;;
    label: "Year Category"
    description: "Categorization of academic years for trend analysis"
  }

  # Metadata
  dimension: record_source {
    type: string
    sql: ${TABLE}.record_source ;;
    hidden: yes
  }

  dimension_group: loaded_at {
    type: time
    timeframes: [raw, time, date]
    sql: ${TABLE}.loaded_at ;;
    hidden: yes
  }

  # Measures
  measure: count {
    type: count
    drill_fields: [academic_year_id, academic_year_name]
  }

  measure: count_years {
    type: count_distinct
    sql: ${academic_year_id} ;;
    label: "Number of Academic Years"
    description: "Count of distinct academic years in selection"
  }
}
