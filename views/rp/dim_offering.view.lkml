# Offering Dimension
# Individual course offerings (course + academic year instance)

view: dim_offering {
  sql_table_name: `ra-warehouse-dev.analytics.dim_offering` ;;
  drill_fields: [offering_code, offering_name, academic_year_id]

  # Primary Key
  dimension: offering_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.offering_key ;;
    hidden: yes
  }

  # Natural Key
  dimension: offering_id {
    type: number
    sql: ${TABLE}.offering_id ;;
    label: "Offering ID"
    hidden: yes
  }

  # Attributes
  dimension: offering_code {
    type: string
    sql: ${TABLE}.offering_code ;;
    label: "Offering Code"
    description: "Offering code"
  }

  dimension: offering_name {
    type: string
    sql: ${TABLE}.offering_name ;;
    label: "Offering Name"
    description: "Full offering name"
  }

  dimension: qualification_id {
    type: string
    sql: ${TABLE}.qualification_id ;;
    label: "Qualification ID"
    description: "QualID from ProSolution"
  }

  dimension: study_year {
    type: number
    sql: ${TABLE}.study_year ;;
    label: "Study Year"
    description: "Current year of study within programme (1, 2, etc.)"
  }

  dimension: duration_years {
    type: number
    sql: ${TABLE}.duration_years ;;
    label: "Duration (Years)"
    description: "Total programme duration in years"
  }

  dimension: is_final_year {
    type: yesno
    sql: ${TABLE}.is_final_year ;;
    label: "Is Final Year"
    description: "Flag indicating final year of study"
  }

  # Foreign keys (natural keys)
  dimension: academic_year_id {
    type: string
    sql: ${TABLE}.academic_year_id ;;
    label: "Academic Year"
    description: "Academic year for this offering"
  }

  dimension: offering_type_id {
    type: number
    sql: ${TABLE}.offering_type_id ;;
    hidden: yes
  }

  dimension: course_header_id {
    type: number
    sql: ${TABLE}.course_header_id ;;
    hidden: yes
  }

  # External system mappings for benchmarking
  dimension: dfe_qualification_code {
    type: string
    sql: ${TABLE}.dfe_qualification_code ;;
    label: "DfE Qualification Code"
    description: "DfE qualification code for external benchmarking"
    group_label: "External Mappings"
  }

  dimension: alps_subject_name {
    type: string
    sql: ${TABLE}.alps_subject_name ;;
    label: "ALPS Subject Name"
    description: "ALPS subject name for benchmarking joins"
    group_label: "External Mappings"
  }

  dimension: six_dimensions_subject_name {
    type: string
    sql: ${TABLE}.six_dimensions_subject_name ;;
    label: "Six Dimensions Subject Name"
    description: "Six Dimensions subject name for benchmarking joins"
    group_label: "External Mappings"
  }

  # Derived dimensions
  dimension: offering_display_name {
    type: string
    sql: CONCAT(${offering_code}, ' - ', ${offering_name}) ;;
    label: "Offering (Code - Name)"
    description: "Combined offering code and name for display"
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
    drill_fields: [offering_code, offering_name, academic_year_id]
  }

  measure: count_final_year_offerings {
    type: count
    filters: [is_final_year: "yes"]
    label: "Final Year Offerings"
    description: "Count of final year offerings"
  }
}
