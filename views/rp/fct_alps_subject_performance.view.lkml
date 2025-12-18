# ALPS Subject Performance Fact
# ALPS provider benchmarking at subject level
# Grain: One row per subject per academic year

view: fct_alps_subject_performance {
  sql_table_name: `ra-warehouse-dev.analytics.fct_alps_subject_performance` ;;
  drill_fields: [alps_subject_name, alps_qualification_type, alps_band, national_benchmark_grade]

  # Primary Key
  dimension: alps_subject_performance_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.alps_subject_performance_key ;;
    hidden: yes
  }

  # Foreign Keys
  dimension: academic_year_key {
    type: number
    sql: ${TABLE}.academic_year_key ;;
    hidden: yes
  }

  dimension: offering_key {
    type: number
    sql: ${TABLE}.offering_key ;;
    hidden: yes
  }

  # ALPS Identifiers
  dimension: alps_subject_name {
    type: string
    sql: ${TABLE}.alps_subject_name ;;
    label: "ALPS Subject"
    description: "Subject name from ALPS report"
  }

  dimension: alps_qualification_type {
    type: string
    sql: ${TABLE}.alps_qualification_type ;;
    label: "Qualification Type"
    description: "Qualification type (A-Level, BTEC)"
  }

  # Subject Mapping
  dimension: subject_mapping_status {
    type: string
    sql: ${TABLE}.subject_mapping_status ;;
    label: "Mapping Status"
    description: "Subject mapping status (Matched, Unmapped)"
  }

  dimension: mapping_confidence_pct {
    type: number
    sql: ${TABLE}.mapping_confidence_pct ;;
    label: "Mapping Confidence %"
    description: "Mapping confidence score (0-100)"
    value_format_name: decimal_1
  }

  # ALPS Benchmarking Metrics (as dimensions for filtering)
  dimension: alps_band {
    type: number
    sql: ${TABLE}.alps_band ;;
    label: "ALPS Band"
    description: "ALPS band (1-9, 1=best)"
  }

  dimension: alps_band_tier {
    type: tier
    tiers: [1, 3, 5, 7, 9]
    style: integer
    sql: ${alps_band} ;;
    label: "ALPS Band Tier"
    description: "ALPS band grouped into tiers"
  }

  dimension: alps_score_dim {
    type: number
    sql: ${TABLE}.alps_score ;;
    label: "ALPS Score"
    description: "ALPS score"
    hidden: yes
  }

  dimension: value_added_score_dim {
    type: number
    sql: ${TABLE}.value_added_score ;;
    label: "Value Added Score"
    description: "Value-added score"
    hidden: yes
  }

  dimension: national_benchmark_grade {
    type: string
    sql: ${TABLE}.national_benchmark_grade ;;
    label: "National Benchmark Grade"
    description: "National benchmark grade"
  }

  # Report Metadata
  dimension_group: alps_report {
    type: time
    timeframes: [date, month, year]
    sql: ${TABLE}.alps_report_date ;;
    label: "ALPS Report"
    description: "Date of ALPS report"
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
    drill_fields: [alps_subject_name, alps_qualification_type, alps_band, national_benchmark_grade]
  }

  measure: total_cohort_count {
    type: sum
    sql: ${TABLE}.cohort_count ;;
    label: "Total Cohort"
    description: "Total number of students across subjects"
  }

  measure: average_cohort_size {
    type: average
    sql: ${TABLE}.cohort_count ;;
    label: "Avg Cohort Size"
    description: "Average cohort size per subject"
    value_format_name: decimal_0
  }

  measure: average_gcse_on_entry {
    type: average
    sql: ${TABLE}.average_gcse_on_entry ;;
    label: "Avg GCSE on Entry"
    description: "Average GCSE score on entry"
    value_format_name: decimal_2
  }

  measure: average_alps_band {
    type: average
    sql: ${alps_band} ;;
    label: "Avg ALPS Band"
    description: "Average ALPS band (lower is better)"
    value_format_name: decimal_1
  }

  measure: average_alps_score {
    type: average
    sql: ${alps_score_dim} ;;
    label: "Avg ALPS Score"
    description: "Average ALPS score"
    value_format_name: decimal_2
  }

  measure: average_value_added {
    type: average
    sql: ${value_added_score_dim} ;;
    label: "Avg Value Added"
    description: "Average value-added score"
    value_format_name: decimal_2
  }

  measure: average_pass_rate {
    type: average
    sql: ${TABLE}.pass_rate_pct ;;
    label: "Avg Pass Rate %"
    description: "Average pass rate percentage"
    value_format_name: decimal_1
  }

  measure: average_high_grades {
    type: average
    sql: ${TABLE}.high_grades_pct ;;
    label: "Avg High Grades %"
    description: "Average high grades percentage"
    value_format_name: decimal_1
  }

  # Subject counts by ALPS band
  measure: count_band_1_2 {
    type: count
    filters: [alps_band: "1, 2"]
    label: "Band 1-2 (Outstanding)"
    description: "Subjects in ALPS band 1-2"
    group_label: "ALPS Band Counts"
  }

  measure: count_band_3_4 {
    type: count
    filters: [alps_band: "3, 4"]
    label: "Band 3-4 (Excellent)"
    description: "Subjects in ALPS band 3-4"
    group_label: "ALPS Band Counts"
  }

  measure: count_band_5_6 {
    type: count
    filters: [alps_band: "5, 6"]
    label: "Band 5-6 (Satisfactory)"
    description: "Subjects in ALPS band 5-6"
    group_label: "ALPS Band Counts"
  }

  measure: count_band_7_9 {
    type: count
    filters: [alps_band: "7, 8, 9"]
    label: "Band 7-9 (Requires Improvement)"
    description: "Subjects in ALPS band 7-9"
    group_label: "ALPS Band Counts"
  }

  measure: count_matched_subjects {
    type: count
    filters: [subject_mapping_status: "Matched"]
    label: "Matched Subjects"
    description: "Count of subjects matched to internal offerings"
  }

  measure: count_unmapped_subjects {
    type: count
    filters: [subject_mapping_status: "Unmapped"]
    label: "Unmapped Subjects"
    description: "Count of subjects not matched to internal offerings"
  }

  # =====================================================================
  # ADDITIONAL ALPS MEASURES
  # =====================================================================

  # Combined band count for 5+
  measure: count_band_5_plus {
    type: count
    filters: [alps_band: "5, 6, 7, 8, 9"]
    label: "Band 5+ (Below Average)"
    description: "Subjects in ALPS band 5 or higher (requiring improvement)"
    group_label: "ALPS Band Counts"
  }

  # Weighted average ALPS score (by cohort size)
  measure: weighted_avg_alps_score {
    type: number
    sql: SAFE_DIVIDE(SUM(${TABLE}.alps_score * ${TABLE}.cohort_count), SUM(${TABLE}.cohort_count)) ;;
    label: "Weighted Avg ALPS Score"
    description: "ALPS score weighted by cohort size"
    value_format_name: decimal_2
  }

  # Weighted average ALPS band (by cohort size)
  measure: weighted_avg_alps_band {
    type: number
    sql: SAFE_DIVIDE(SUM(${TABLE}.alps_band * ${TABLE}.cohort_count), SUM(${TABLE}.cohort_count)) ;;
    label: "Weighted Avg ALPS Band"
    description: "ALPS band weighted by cohort size (lower is better)"
    value_format_name: decimal_1
  }

  # College ALPS Band (rounded weighted average)
  measure: college_alps_band {
    type: number
    sql: ROUND(${weighted_avg_alps_band}) ;;
    label: "College ALPS Band"
    description: "Overall college ALPS band (rounded weighted average)"
    value_format_name: decimal_0
  }

  # Subject-level pass rate (for comparison)
  dimension: pass_rate_pct_dim {
    type: number
    sql: ${TABLE}.pass_rate_pct ;;
    label: "Pass Rate %"
    description: "Subject pass rate percentage"
    value_format_name: decimal_1
  }

  dimension: high_grades_pct_dim {
    type: number
    sql: ${TABLE}.high_grades_pct ;;
    label: "High Grades %"
    description: "Subject high grades percentage"
    value_format_name: decimal_1
  }

  dimension: cohort_count_dim {
    type: number
    sql: ${TABLE}.cohort_count ;;
    label: "Cohort"
    description: "Subject cohort size"
  }

  # ALPS Band Description
  dimension: alps_band_description {
    type: string
    sql: CASE ${alps_band}
      WHEN 1 THEN 'Exceptional (Top 5%)'
      WHEN 2 THEN 'Very Strong (Top 25%)'
      WHEN 3 THEN 'Strong'
      WHEN 4 THEN 'Average'
      WHEN 5 THEN 'Below Average'
      WHEN 6 THEN 'Well Below Average'
      WHEN 7 THEN 'Significantly Below'
      WHEN 8 THEN 'Significantly Below'
      WHEN 9 THEN 'Significantly Below'
      ELSE 'Unknown'
    END ;;
    label: "ALPS Band Description"
    description: "Descriptive label for ALPS band"
  }

  # Count subjects by status
  measure: count_subjects_improving {
    type: count
    # This would need prior year data to calculate
    label: "Subjects Improving"
    description: "Count of subjects with improving ALPS band (requires YoY data)"
    group_label: "ALPS Trend"
  }
}
