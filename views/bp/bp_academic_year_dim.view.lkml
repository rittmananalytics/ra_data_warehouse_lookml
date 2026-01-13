view: bp_academic_year_dim {
  sql_table_name: `ra-development.bp_analytics_bp_analytics.academic_year_dim` ;;

  # Primary Key
  dimension: academic_year_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.academic_year_pk ;;
    hidden: yes
  }

  # IDs
  dimension: academic_year_id {
    type: string
    sql: ${TABLE}.academic_year_id ;;
    label: "Academic Year ID"
  }

  dimension: academic_year_name {
    type: string
    sql: ${TABLE}.academic_year_name ;;
    label: "Academic Year"
  }

  # Years
  dimension: start_year {
    type: number
    sql: ${TABLE}.start_year ;;
    label: "Start Year"
  }

  dimension: end_year {
    type: number
    sql: ${TABLE}.end_year ;;
    label: "End Year"
  }

  # Dates
  dimension_group: year_start {
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: ${TABLE}.year_start_date ;;
  }

  dimension_group: year_end {
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: ${TABLE}.year_end_date ;;
  }

  # Timestamps
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_ts ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.updated_ts ;;
  }

  # Flags
  dimension: is_current_year {
    type: yesno
    sql: ${TABLE}.is_current_year ;;
    label: "Is Current Year"
  }

  # Measures
  measure: total_academic_years {
    type: count
    label: "Total Academic Years"
    drill_fields: [academic_year_name, year_start_date, year_end_date]
  }

  measure: count_current_year {
    type: count
    filters: [is_current_year: "yes"]
    label: "Current Academic Year"
  }
}
