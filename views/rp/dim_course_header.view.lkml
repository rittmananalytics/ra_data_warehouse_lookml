# Course Header Dimension
# Course/programme master data

view: dim_course_header {
  sql_table_name: `ra-warehouse-dev.analytics.dim_course_header` ;;
  drill_fields: [course_code, course_name, subject_area, department]

  # Primary Key
  dimension: course_header_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.course_header_key ;;
    hidden: yes
  }

  # Natural Key
  dimension: course_header_id {
    type: number
    sql: ${TABLE}.course_header_id ;;
    label: "Course Header ID"
    hidden: yes
  }

  # Attributes
  dimension: course_code {
    type: string
    sql: ${TABLE}.course_code ;;
    label: "Course Code"
    description: "Course code (e.g., 'BIOL-A2')"
  }

  dimension: course_name {
    type: string
    sql: ${TABLE}.course_name ;;
    label: "Course Name"
    description: "Full course name"
  }

  dimension: subject_area {
    type: string
    sql: ${TABLE}.subject_area ;;
    label: "Subject Area"
    description: "Subject area grouping"
    drill_fields: [course_name]
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
    label: "Department"
    description: "Academic department"
    drill_fields: [subject_area, course_name]
  }

  dimension: is_active {
    type: yesno
    sql: ${TABLE}.is_active ;;
    label: "Is Active"
    description: "Flag indicating if course is currently offered"
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
    drill_fields: [course_code, course_name, subject_area, department]
  }

  measure: count_active_courses {
    type: count
    filters: [is_active: "yes"]
    label: "Active Courses"
    description: "Count of currently active courses"
  }
}
