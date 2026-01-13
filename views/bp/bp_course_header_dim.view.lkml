view: bp_course_header_dim {
  sql_table_name: `ra-development.bp_analytics_bp_analytics.course_header_dim` ;;

  # Primary Key
  dimension: course_header_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.course_header_pk ;;
    hidden: yes
  }

  # IDs
  dimension: course_header_id {
    type: number
    sql: ${TABLE}.course_header_id ;;
    label: "Course Header ID"
  }

  dimension: course_code {
    type: string
    sql: ${TABLE}.course_code ;;
    label: "Course Code"
  }

  dimension: course_name {
    type: string
    sql: ${TABLE}.course_name ;;
    label: "Course Name"
  }

  # Dates
  dimension_group: effective {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.effective_date ;;
  }

  dimension_group: expiry {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.expiry_date ;;
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
  dimension: is_active {
    type: yesno
    sql: ${TABLE}.is_active ;;
    label: "Is Active"
  }

  dimension: is_current {
    type: yesno
    sql: ${TABLE}.is_current ;;
    label: "Is Current"
  }

  # Measures
  measure: total_course_headers {
    type: count
    label: "Total Course Headers"
    drill_fields: [course_code, course_name, effective_date, expiry_date]
  }

  measure: count_active_courses {
    type: count
    filters: [is_active: "yes"]
    label: "Active Courses"
  }

  measure: count_current_courses {
    type: count
    filters: [is_current: "yes"]
    label: "Current Courses"
  }
}
