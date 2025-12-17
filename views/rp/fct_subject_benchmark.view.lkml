# Subject Benchmark Fact
# Subject-level benchmarking from Six Dimensions reports
# Grain: One row per subject per report type per academic year

view: fct_subject_benchmark {
  sql_table_name: `ra-warehouse-dev.analytics.fct_subject_benchmark` ;;
  drill_fields: [six_dimensions_subject_name, qualification_type, report_type, performance_band]

  # Primary Key
  dimension: subject_benchmark_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.subject_benchmark_key ;;
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

  # Source Identifiers
  dimension: report_type {
    type: string
    sql: ${TABLE}.report_type ;;
    label: "Report Type"
    description: "Report type (VA, Sixth Sense, Vocational)"
  }

  dimension: six_dimensions_subject_name {
    type: string
    sql: ${TABLE}.six_dimensions_subject_name ;;
    label: "Subject Name"
    description: "Subject name from Six Dimensions"
  }

  dimension: qualification_type {
    type: string
    sql: ${TABLE}.qualification_type ;;
    label: "Qualification Type"
    description: "Qualification type"
  }

  # Subject Mapping
  dimension: subject_mapping_status {
    type: string
    sql: ${TABLE}.subject_mapping_status ;;
    label: "Mapping Status"
    description: "Mapping status to internal offerings"
  }

  dimension: mapping_confidence_pct {
    type: number
    sql: ${TABLE}.mapping_confidence_pct ;;
    label: "Mapping Confidence %"
    description: "Mapping confidence score (0-100)"
    value_format_name: decimal_1
  }

  # Cohort
  dimension: cohort_count_dim {
    type: number
    sql: ${TABLE}.cohort_count ;;
    label: "Cohort Count"
    description: "Subject cohort size"
    hidden: yes
  }

  dimension: average_gcse_on_entry_dim {
    type: number
    sql: ${TABLE}.average_gcse_on_entry ;;
    label: "Avg GCSE on Entry"
    hidden: yes
  }

  # Performance Metrics (as dimensions)
  dimension: pass_rate_dim {
    type: number
    sql: ${TABLE}.pass_rate_pct ;;
    hidden: yes
  }

  dimension: high_grades_dim {
    type: number
    sql: ${TABLE}.high_grades_pct ;;
    hidden: yes
  }

  dimension: completion_rate_dim {
    type: number
    sql: ${TABLE}.completion_rate_pct ;;
    hidden: yes
  }

  dimension: achievement_rate_dim {
    type: number
    sql: ${TABLE}.achievement_rate_pct ;;
    hidden: yes
  }

  # Value-Added Metrics (as dimensions)
  dimension: value_added_score_dim {
    type: number
    sql: ${TABLE}.value_added_score ;;
    label: "VA Score"
    hidden: yes
  }

  dimension: residual_score {
    type: number
    sql: ${TABLE}.residual_score ;;
    label: "Residual Score"
    description: "VA residual"
  }

  dimension: expected_grade {
    type: string
    sql: ${TABLE}.expected_grade ;;
    label: "Expected Grade"
    description: "Expected grade based on prior attainment"
  }

  dimension: actual_avg_grade {
    type: string
    sql: ${TABLE}.actual_avg_grade ;;
    label: "Actual Avg Grade"
    description: "Actual average grade achieved"
  }

  dimension: performance_band {
    type: string
    sql: ${TABLE}.performance_band ;;
    label: "Performance Band"
    description: "VA performance band classification"
  }

  dimension: confidence_interval_lower {
    type: number
    sql: ${TABLE}.confidence_interval_lower ;;
    label: "Confidence Lower"
    description: "VA confidence interval lower bound"
  }

  dimension: confidence_interval_upper {
    type: number
    sql: ${TABLE}.confidence_interval_upper ;;
    label: "Confidence Upper"
    description: "VA confidence interval upper bound"
  }

  # Sixth Sense Metrics
  dimension: performance_quartile {
    type: string
    sql: ${TABLE}.performance_quartile ;;
    label: "Performance Quartile"
    description: "Performance quartile ranking"
  }

  # Trend Indicators
  dimension: performance_trajectory {
    type: string
    sql: ${TABLE}.performance_trajectory ;;
    label: "Performance Trajectory"
    description: "Trajectory (Improving, Stable, Declining)"
  }

  dimension: yoy_change_pct_dim {
    type: number
    sql: ${TABLE}.yoy_change_pct ;;
    label: "YoY Change %"
    hidden: yes
  }

  # Report Date
  dimension_group: report {
    type: time
    timeframes: [date, month, year]
    sql: ${TABLE}.report_date ;;
    label: "Report"
    description: "Report date"
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
    drill_fields: [six_dimensions_subject_name, qualification_type, report_type, performance_band]
  }

  measure: total_cohort_count {
    type: sum
    sql: ${TABLE}.cohort_count ;;
    label: "Total Cohort"
    description: "Total students across subjects"
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
    sql: ${average_gcse_on_entry_dim} ;;
    label: "Avg GCSE on Entry"
    description: "Average GCSE score on entry"
    value_format_name: decimal_2
  }

  # Performance Metrics
  measure: avg_pass_rate {
    type: average
    sql: ${pass_rate_dim} ;;
    label: "Avg Pass Rate %"
    description: "Average pass rate"
    value_format_name: decimal_1
    group_label: "Performance Metrics"
  }

  measure: avg_high_grades {
    type: average
    sql: ${high_grades_dim} ;;
    label: "Avg High Grades %"
    description: "Average high grade rate"
    value_format_name: decimal_1
    group_label: "Performance Metrics"
  }

  measure: avg_completion_rate {
    type: average
    sql: ${completion_rate_dim} ;;
    label: "Avg Completion Rate %"
    description: "Average completion rate"
    value_format_name: decimal_1
    group_label: "Performance Metrics"
  }

  measure: avg_achievement_rate {
    type: average
    sql: ${achievement_rate_dim} ;;
    label: "Avg Achievement Rate %"
    description: "Average achievement rate"
    value_format_name: decimal_1
    group_label: "Performance Metrics"
  }

  # Value-Added Metrics
  measure: avg_value_added_score {
    type: average
    sql: ${value_added_score_dim} ;;
    label: "Avg VA Score"
    description: "Average value-added score"
    value_format_name: decimal_2
    group_label: "Value Added Metrics"
  }

  measure: avg_residual_score {
    type: average
    sql: ${residual_score} ;;
    label: "Avg Residual"
    description: "Average VA residual"
    value_format_name: decimal_2
    group_label: "Value Added Metrics"
  }

  measure: avg_yoy_change {
    type: average
    sql: ${yoy_change_pct_dim} ;;
    label: "Avg YoY Change %"
    description: "Average year-over-year change"
    value_format_name: decimal_1
    group_label: "Trend Metrics"
  }

  # Subject counts by performance
  measure: count_improving {
    type: count
    filters: [performance_trajectory: "Improving"]
    label: "Improving Subjects"
    description: "Subjects with improving trajectory"
    group_label: "Trajectory Counts"
  }

  measure: count_stable {
    type: count
    filters: [performance_trajectory: "Stable"]
    label: "Stable Subjects"
    description: "Subjects with stable trajectory"
    group_label: "Trajectory Counts"
  }

  measure: count_declining {
    type: count
    filters: [performance_trajectory: "Declining"]
    label: "Declining Subjects"
    description: "Subjects with declining trajectory"
    group_label: "Trajectory Counts"
  }

  measure: count_matched_subjects {
    type: count
    filters: [subject_mapping_status: "Matched"]
    label: "Matched Subjects"
    description: "Subjects matched to internal offerings"
  }
}
