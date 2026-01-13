# Offering Type Dimension
# Types of educational offerings (A-Level, BTEC, etc.)

view: dim_offering_type {
  sql_table_name: `ra-warehouse-dev.analytics.dim_offering_type` ;;
  drill_fields: [offering_type_name, offering_type_category]

  # Primary Key
  dimension: offering_type_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.offering_type_key ;;
    hidden: yes
  }

  # Natural Key
  dimension: offering_type_id {
    type: number
    sql: ${TABLE}.offering_type_id ;;
    label: "Offering Type ID"
    hidden: yes
  }

  # Attributes
  dimension: offering_type_name {
    type: string
    sql: ${TABLE}.offering_type_name ;;
    label: "Offering Type"
    description: "Name of offering type (e.g., 'A-Level', 'BTEC')"
  }

  dimension: offering_type_category {
    type: string
    sql: ${TABLE}.offering_type_category ;;
    label: "Category"
    description: "Category grouping (e.g., 'Academic', 'Vocational')"
  }

  dimension: qualification_level {
    type: string
    sql: ${TABLE}.qualification_level ;;
    label: "Qualification Level"
    description: "Qualification level (e.g., 'Level 3')"
  }

  dimension: grading_scale {
    type: string
    sql: ${TABLE}.grading_scale ;;
    label: "Grading Scale"
    description: "Grading scale used (e.g., 'A*-E', 'D*-P')"
  }

  dimension: is_academic {
    type: yesno
    sql: ${TABLE}.is_academic ;;
    label: "Is Academic"
    description: "Flag indicating academic qualification"
  }

  dimension: is_vocational {
    type: yesno
    sql: ${TABLE}.is_vocational ;;
    label: "Is Vocational"
    description: "Flag indicating vocational qualification"
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
    drill_fields: [offering_type_name, offering_type_category, qualification_level]
  }
}
