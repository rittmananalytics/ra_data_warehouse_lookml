# Student Detail Dimension
# Extended student demographic attributes for equity analysis (JEDI)
# Grain: One row per student per academic year

view: dim_student_detail {
  sql_table_name: `ra-warehouse-dev.analytics.dim_student_detail` ;;
  drill_fields: [full_name, gender, ethnicity, prior_attainment_band]

  # Primary Key
  dimension: student_detail_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.student_detail_key ;;
    hidden: yes
  }

  # Natural Keys
  dimension: student_detail_id {
    type: number
    sql: ${TABLE}.student_detail_id ;;
    hidden: yes
  }

  dimension: student_id {
    type: number
    sql: ${TABLE}.student_id ;;
    hidden: yes
  }

  dimension: academic_year_id {
    type: string
    sql: ${TABLE}.academic_year_id ;;
    label: "Academic Year"
    hidden: yes
  }

  # Core Demographics
  dimension: full_name {
    type: string
    sql: ${TABLE}.full_name ;;
    label: "Student Name"
    group_label: "Demographics"
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
    label: "Gender"
    group_label: "Demographics"
  }

  dimension: ethnicity {
    type: string
    sql: ${TABLE}.ethnicity ;;
    label: "Ethnicity"
    group_label: "Demographics"
  }

  # Demographic Flags for Equity Analysis (JEDI)
  dimension: is_free_meals {
    type: yesno
    sql: ${TABLE}.is_free_meals ;;
    label: "Free School Meals (FSM)"
    description: "Free School Meals eligible flag"
    group_label: "Disadvantage Indicators"
  }

  dimension: is_bursary {
    type: yesno
    sql: ${TABLE}.is_bursary ;;
    label: "Bursary Recipient"
    description: "Bursary recipient flag"
    group_label: "Disadvantage Indicators"
  }

  dimension: is_lac {
    type: yesno
    sql: ${TABLE}.is_lac ;;
    label: "Looked After Child (LAC)"
    description: "Looked After Child flag"
    group_label: "Disadvantage Indicators"
  }

  dimension: is_send {
    type: yesno
    sql: ${TABLE}.is_send ;;
    label: "SEND"
    description: "Special Educational Needs and Disabilities flag"
    group_label: "SEND"
  }

  dimension: is_high_needs {
    type: yesno
    sql: ${TABLE}.is_high_needs ;;
    label: "High Needs"
    description: "High needs funding flag"
    group_label: "SEND"
  }

  dimension: is_young_carer {
    type: yesno
    sql: ${TABLE}.is_young_carer ;;
    label: "Young Carer"
    description: "Young carer flag"
    group_label: "Disadvantage Indicators"
  }

  # Derived: Disadvantaged (PP or FCM) - matches original SQL
  dimension: is_disadvantaged {
    type: yesno
    sql: ${TABLE}.is_free_meals OR ${TABLE}.is_bursary ;;
    label: "Disadvantaged (PP or FCM)"
    description: "Pupil Premium or Free School Meals eligible"
    group_label: "Disadvantage Indicators"
  }

  # SEND Details
  dimension: primary_send_type {
    type: string
    sql: ${TABLE}.primary_send_type ;;
    label: "Primary SEND Type"
    group_label: "SEND"
  }

  dimension: secondary_send_type {
    type: string
    sql: ${TABLE}.secondary_send_type ;;
    label: "Secondary SEND Type"
    group_label: "SEND"
  }

  # Geographic Attributes
  dimension: postcode_area {
    type: string
    sql: ${TABLE}.postcode_area ;;
    label: "Postcode Area"
    group_label: "Geography"
  }

  dimension: imd_decile {
    type: number
    sql: ${TABLE}.imd_decile ;;
    label: "IMD Decile"
    description: "Index of Multiple Deprivation decile (1-10, 1=most deprived)"
    group_label: "Geography"
  }

  dimension: imd_quintile {
    type: tier
    tiers: [1, 3, 5, 7, 9]
    style: integer
    sql: ${imd_decile} ;;
    label: "IMD Quintile"
    description: "IMD grouped into quintiles"
    group_label: "Geography"
  }

  dimension: polar4_quintile {
    type: number
    sql: ${TABLE}.polar4_quintile ;;
    label: "POLAR4 Quintile"
    description: "Participation of Local Areas quintile (1-5)"
    group_label: "Geography"
  }

  dimension: tundra_classification {
    type: string
    sql: ${TABLE}.tundra_classification ;;
    label: "TUNDRA Classification"
    group_label: "Geography"
  }

  # Background
  dimension: nationality {
    type: string
    sql: ${TABLE}.nationality ;;
    label: "Nationality"
    group_label: "Background"
  }

  dimension: country_of_birth {
    type: string
    sql: ${TABLE}.country_of_birth ;;
    label: "Country of Birth"
    group_label: "Background"
  }

  dimension: first_language {
    type: string
    sql: ${TABLE}.first_language ;;
    label: "First Language"
    group_label: "Background"
  }

  dimension: religion {
    type: string
    sql: ${TABLE}.religion ;;
    label: "Religion"
    group_label: "Background"
  }

  # Prior Attainment
  dimension: average_gcse_score {
    type: number
    sql: ${TABLE}.average_gcse_score ;;
    label: "Average GCSE Score"
    description: "Average GCSE point score"
    group_label: "Prior Attainment"
    value_format_name: decimal_2
  }

  dimension: prior_attainment_band {
    type: string
    sql: ${TABLE}.prior_attainment_band ;;
    label: "Prior Attainment Band"
    description: "ALPS-style prior attainment band (Low/Mid/High)"
    group_label: "Prior Attainment"
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
    drill_fields: [full_name, gender, ethnicity, is_disadvantaged, is_send]
  }

  measure: count_disadvantaged {
    type: count
    filters: [is_disadvantaged: "yes"]
    label: "Disadvantaged Students"
    description: "Count of students who are Pupil Premium or Free School Meals eligible"
  }

  measure: count_send {
    type: count
    filters: [is_send: "yes"]
    label: "SEND Students"
    description: "Count of students with Special Educational Needs"
  }

  measure: count_lac {
    type: count
    filters: [is_lac: "yes"]
    label: "LAC Students"
    description: "Count of Looked After Children"
  }

  measure: count_young_carer {
    type: count
    filters: [is_young_carer: "yes"]
    label: "Young Carers"
    description: "Count of young carers"
  }

  measure: average_gcse {
    type: average
    sql: ${average_gcse_score} ;;
    label: "Avg GCSE Score"
    description: "Average GCSE point score for cohort"
    value_format_name: decimal_2
  }
}
