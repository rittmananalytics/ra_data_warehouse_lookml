view: bp_offering_dim {
  sql_table_name: `ra-development.bp_analytics_bp_analytics.offering_dim` ;;

  # Primary Key
  dimension: offering_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.offering_pk ;;
    hidden: yes
  }

  # IDs
  dimension: offering_id {
    type: number
    sql: ${TABLE}.offering_id ;;
    label: "Offering ID"
  }

  dimension: offering_code {
    type: string
    sql: ${TABLE}.offering_code ;;
    label: "Offering Code"
  }

  dimension: offering_name {
    type: string
    sql: ${TABLE}.offering_name ;;
    label: "Offering Name"
  }

  # Foreign Keys
  dimension: course_header_fk {
    type: string
    sql: ${TABLE}.course_header_fk ;;
    hidden: yes
  }

  dimension: academic_year_fk {
    type: string
    sql: ${TABLE}.academic_year_fk ;;
    hidden: yes
  }

  dimension: college_level_fk {
    type: string
    sql: ${TABLE}.college_level_fk ;;
    hidden: yes
  }

  # Course Details
  dimension: course_header_code {
    type: string
    sql: ${TABLE}.course_header_code ;;
    label: "Course Header Code"
  }

  dimension: course_header_name {
    type: string
    sql: ${TABLE}.course_header_name ;;
    label: "Course Header Name"
  }

  dimension: college_level_code {
    type: string
    sql: ${TABLE}.college_level_code ;;
    label: "College Level Code"
  }

  dimension: college_level_name {
    type: string
    sql: ${TABLE}.college_level_name ;;
    label: "College Level"
  }

  # Qualification Details
  dimension: qual_id {
    type: string
    sql: ${TABLE}.qual_id ;;
    label: "Qualification ID"
  }

  dimension: has_qual_id {
    type: yesno
    sql: ${TABLE}.has_qual_id ;;
    label: "Has Qualification ID"
  }

  dimension: learning_aim_title {
    type: string
    sql: ${TABLE}.learning_aim_title ;;
    label: "Learning Aim Title"
  }

  dimension: alps_name {
    type: string
    sql: ${TABLE}.alps_name ;;
    label: "ALPS Name"
    description: "A Level Performance System"
  }

  dimension: nvq_level_code {
    type: string
    sql: ${TABLE}.nvq_level_code ;;
    label: "NVQ Level"
  }

  # Dates
  dimension_group: start {
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: ${TABLE}.start_date ;;
  }

  dimension_group: end {
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: ${TABLE}.end_date ;;
  }

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
  dimension: is_current {
    type: yesno
    sql: ${TABLE}.is_current ;;
    label: "Is Current"
  }

  dimension: is_valid_qual {
    type: yesno
    sql: ${TABLE}.is_valid_qual ;;
    label: "Is Valid Qualification"
  }

  dimension: is_enrichment {
    type: yesno
    sql: ${TABLE}.is_enrichment ;;
    label: "Is Enrichment"
  }

  dimension: is_tutor_group {
    type: yesno
    sql: ${TABLE}.is_tutor_group ;;
    label: "Is Tutor Group"
  }

  dimension: is_final_year {
    type: yesno
    sql: ${TABLE}.is_final_year ;;
    label: "Is Final Year"
  }

  dimension: is_internal_code {
    type: yesno
    sql: ${TABLE}.is_internal_code ;;
    label: "Is Internal Code"
  }

  dimension: study_year {
    type: number
    sql: ${TABLE}.study_year ;;
    label: "Study Year"
  }

  # Measures
  measure: total_offerings {
    type: count
    label: "Total Offerings"
    drill_fields: [offering_code, offering_name, college_level_name, start_date, end_date]
  }

  measure: count_current_offerings {
    type: count
    filters: [is_current: "yes"]
    label: "Current Offerings"
  }

  measure: count_valid_qualifications {
    type: count
    filters: [is_valid_qual: "yes"]
    label: "Valid Qualifications"
  }

  measure: count_enrichment_offerings {
    type: count
    filters: [is_enrichment: "yes"]
    label: "Enrichment Offerings"
  }

  measure: count_final_year_offerings {
    type: count
    filters: [is_final_year: "yes"]
    label: "Final Year Offerings"
  }
}
