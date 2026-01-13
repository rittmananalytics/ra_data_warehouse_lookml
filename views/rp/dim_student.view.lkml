# Student Dimension
# Student master data with demographics

view: dim_student {
  sql_table_name: `ra-warehouse-dev.analytics.dim_student` ;;
  drill_fields: [student_id, full_name, gender, ethnicity]

  # Primary Key
  dimension: student_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.student_key ;;
    hidden: yes
  }

  # Natural Key
  dimension: student_id {
    type: number
    sql: ${TABLE}.student_id ;;
    label: "Student ID"
    description: "ProSolution StudentID"
  }

  # Identifiers
  dimension: uln {
    type: string
    sql: ${TABLE}.uln ;;
    label: "ULN"
    description: "Unique Learner Number"
  }

  # Demographics
  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
    label: "First Name"
    group_label: "Personal Details"
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
    label: "Last Name"
    group_label: "Personal Details"
  }

  dimension: full_name {
    type: string
    sql: ${TABLE}.full_name ;;
    label: "Full Name"
    description: "Student full name"
    group_label: "Personal Details"
  }

  dimension_group: date_of_birth {
    type: time
    timeframes: [date, month, year]
    sql: ${TABLE}.date_of_birth ;;
    label: "Date of Birth"
    group_label: "Personal Details"
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
    label: "Gender"
    description: "Student gender (Male/Female)"
    group_label: "Demographics"
  }

  dimension: ethnicity {
    type: string
    sql: ${TABLE}.ethnicity ;;
    label: "Ethnicity"
    description: "Ethnicity description"
    group_label: "Demographics"
  }

  # Status
  dimension: is_active {
    type: yesno
    sql: ${TABLE}.is_active ;;
    label: "Is Active"
    description: "Active student flag"
  }

  # Dates
  dimension_group: first_enrolment {
    type: time
    timeframes: [date, month, year]
    sql: ${TABLE}.first_enrolment_date ;;
    label: "First Enrolment"
    description: "Date of first enrolment at college"
  }

  # SCD Type 2
  dimension_group: valid_from {
    type: time
    timeframes: [date]
    sql: ${TABLE}.valid_from_date ;;
    hidden: yes
  }

  dimension_group: valid_to {
    type: time
    timeframes: [date]
    sql: ${TABLE}.valid_to_date ;;
    hidden: yes
  }

  dimension: is_current {
    type: yesno
    sql: ${TABLE}.is_current ;;
    label: "Is Current Version"
    description: "Flag indicating current version of student record"
    hidden: yes
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
    drill_fields: [student_id, full_name, gender, ethnicity]
  }

  measure: count_distinct_students {
    type: count_distinct
    sql: ${student_id} ;;
    label: "Distinct Students"
    description: "Count of distinct students"
  }

  measure: count_male {
    type: count
    filters: [gender: "Male"]
    label: "Male Students"
  }

  measure: count_female {
    type: count
    filters: [gender: "Female"]
    label: "Female Students"
  }
}
