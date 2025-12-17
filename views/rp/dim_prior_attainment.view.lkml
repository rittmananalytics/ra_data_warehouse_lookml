# Prior Attainment Dimension
# GCSE scores and prior attainment banding for value-added analysis

view: dim_prior_attainment {
  sql_table_name: `ra-warehouse-dev.analytics.dim_prior_attainment` ;;
  drill_fields: [student_id, average_gcse_score, prior_attainment_band]

  # Primary Key
  dimension: prior_attainment_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.prior_attainment_key ;;
    hidden: yes
  }

  # Natural Keys
  dimension: average_gcse_id {
    type: number
    sql: ${TABLE}.average_gcse_id ;;
    hidden: yes
  }

  dimension: student_id {
    type: number
    sql: ${TABLE}.student_id ;;
    label: "Student ID"
    hidden: yes
  }

  dimension: academic_year_id {
    type: string
    sql: ${TABLE}.academic_year_id ;;
    label: "Academic Year"
    hidden: yes
  }

  # GCSE Score Metrics
  dimension: average_gcse_score {
    type: number
    sql: ${TABLE}.average_gcse_score ;;
    label: "Average GCSE Score"
    description: "Average GCSE point score"
    value_format_name: decimal_2
  }

  # Prior Attainment Banding (ALPS-style)
  # Low: < 4.77, Mid: 4.77 - 6.09, High: > 6.09
  dimension: prior_attainment_band {
    type: string
    sql: ${TABLE}.prior_attainment_band ;;
    label: "Prior Attainment Band"
    description: "Prior attainment band: Low (<4.77), Mid (4.77-6.09), High (>6.09)"
    order_by_field: prior_attainment_band_code
  }

  dimension: prior_attainment_band_code {
    type: number
    sql: ${TABLE}.prior_attainment_band_code ;;
    label: "Band Code"
    description: "Numeric band code: 0=N/A, 1=Low, 2=Mid, 3=High"
    hidden: yes
  }

  # Band Thresholds
  dimension: low_threshold {
    type: number
    sql: ${TABLE}.low_threshold ;;
    label: "Low Band Threshold"
    description: "Upper boundary for Low band (default 4.77)"
    hidden: yes
  }

  dimension: high_threshold {
    type: number
    sql: ${TABLE}.high_threshold ;;
    label: "High Band Threshold"
    description: "Lower boundary for High band (default 6.09)"
    hidden: yes
  }

  # Additional GCSE Metrics
  dimension: gcse_english_grade {
    type: number
    sql: ${TABLE}.gcse_english_grade ;;
    label: "GCSE English Grade"
    description: "GCSE English grade (numeric)"
    group_label: "Individual Subjects"
  }

  dimension: gcse_maths_grade {
    type: number
    sql: ${TABLE}.gcse_maths_grade ;;
    label: "GCSE Maths Grade"
    description: "GCSE Maths grade (numeric)"
    group_label: "Individual Subjects"
  }

  dimension: gcse_count {
    type: number
    sql: ${TABLE}.gcse_count ;;
    label: "GCSE Count"
    description: "Number of GCSEs taken"
  }

  # Derived dimension for GCSE score tiers
  dimension: gcse_score_tier {
    type: tier
    tiers: [3, 4, 5, 6, 7, 8]
    style: relational
    sql: ${average_gcse_score} ;;
    label: "GCSE Score Tier"
    description: "GCSE score grouped into tiers"
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
    drill_fields: [student_id, average_gcse_score, prior_attainment_band]
  }

  measure: average_gcse {
    type: average
    sql: CASE WHEN ${average_gcse_score} > 0 THEN ${average_gcse_score} ELSE NULL END ;;
    label: "Avg GCSE Score"
    description: "Average GCSE score (excluding zeros/nulls)"
    value_format_name: decimal_2
  }

  measure: median_gcse {
    type: median
    sql: CASE WHEN ${average_gcse_score} > 0 THEN ${average_gcse_score} ELSE NULL END ;;
    label: "Median GCSE Score"
    value_format_name: decimal_2
  }

  measure: count_low_prior {
    type: count
    filters: [prior_attainment_band: "Low"]
    label: "Low Prior Attainment"
    description: "Count of students with low prior attainment (<4.77)"
  }

  measure: count_mid_prior {
    type: count
    filters: [prior_attainment_band: "Mid"]
    label: "Mid Prior Attainment"
    description: "Count of students with mid prior attainment (4.77-6.09)"
  }

  measure: count_high_prior {
    type: count
    filters: [prior_attainment_band: "High"]
    label: "High Prior Attainment"
    description: "Count of students with high prior attainment (>6.09)"
  }

  measure: count_no_prior {
    type: count
    filters: [prior_attainment_band: "N/A"]
    label: "No Prior Attainment Data"
    description: "Count of students with no prior attainment data"
  }
}
