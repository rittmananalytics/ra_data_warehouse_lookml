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

  # =====================================================================
  # ADDITIONAL VALUE-ADDED MEASURES
  # =====================================================================

  # VA Band derived from score
  dimension: va_band {
    type: string
    sql: CASE
      WHEN ${value_added_score_dim} > 0.5 THEN 'A'
      WHEN ${value_added_score_dim} > 0.25 THEN 'B'
      WHEN ${value_added_score_dim} > -0.25 THEN 'C'
      WHEN ${value_added_score_dim} > -0.5 THEN 'D'
      ELSE 'E'
    END ;;
    label: "VA Band"
    description: "Value-added band (A=Well Above, B=Above, C=At, D=Below, E=Well Below Expected)"
    group_label: "Value Added"
  }

  dimension: va_band_description {
    type: string
    sql: CASE
      WHEN ${value_added_score_dim} > 0.5 THEN 'Well Above Expected'
      WHEN ${value_added_score_dim} > 0.25 THEN 'Above Expected'
      WHEN ${value_added_score_dim} > -0.25 THEN 'At Expected'
      WHEN ${value_added_score_dim} > -0.5 THEN 'Below Expected'
      ELSE 'Well Below Expected'
    END ;;
    label: "VA Band Description"
    description: "Descriptive value-added classification"
    group_label: "Value Added"
  }

  # Visible VA Score dimension
  dimension: value_added_score {
    type: number
    sql: ${TABLE}.value_added_score ;;
    label: "VA Score"
    description: "Value-added score"
    value_format_name: decimal_2
    group_label: "Value Added"
  }

  # VA Percentile (calculated based on ranking)
  # Note: This is a simplified calculation - actual percentile would need window functions
  dimension: va_percentile_tier {
    type: tier
    tiers: [10, 25, 50, 75, 90]
    style: integer
    sql: CASE
      WHEN ${value_added_score_dim} > 0.6 THEN 90
      WHEN ${value_added_score_dim} > 0.4 THEN 75
      WHEN ${value_added_score_dim} > 0.1 THEN 50
      WHEN ${value_added_score_dim} > -0.2 THEN 25
      ELSE 10
    END ;;
    label: "VA Percentile Tier"
    description: "Approximate VA percentile tier"
    group_label: "Value Added"
  }

  # Cohort dimension (visible)
  dimension: cohort_count {
    type: number
    sql: ${TABLE}.cohort_count ;;
    label: "Cohort"
    description: "Subject cohort size"
  }

  # Average GCSE dimension (visible) - renamed to avoid conflict with measure
  dimension: avg_gcse_entry_score {
    type: number
    sql: ${TABLE}.average_gcse_on_entry ;;
    label: "Avg GCSE Entry Score"
    description: "Average GCSE score on entry (dimension for filtering/grouping)"
    value_format_name: decimal_2
  }

  # Count subjects above/below expected
  measure: count_above_expected {
    type: count
    filters: [value_added_score_dim: ">0"]
    label: "Subjects Above Expected"
    description: "Count of subjects with positive VA"
    group_label: "VA Counts"
  }

  measure: count_below_expected {
    type: count
    filters: [value_added_score_dim: "<0"]
    label: "Subjects Below Expected"
    description: "Count of subjects with negative VA"
    group_label: "VA Counts"
  }

  measure: count_at_expected {
    type: count
    filters: [value_added_score_dim: "[-0.1, 0.1]"]
    label: "Subjects At Expected"
    description: "Count of subjects with VA near zero"
    group_label: "VA Counts"
  }

  # Weighted VA score
  measure: weighted_avg_va_score {
    type: number
    sql: SAFE_DIVIDE(SUM(${TABLE}.value_added_score * ${TABLE}.cohort_count), SUM(${TABLE}.cohort_count)) ;;
    label: "Weighted Avg VA Score"
    description: "VA score weighted by cohort size"
    value_format_name: decimal_2
    group_label: "Value Added Metrics"
  }

  # College VA Band (based on weighted average)
  measure: college_va_band {
    type: string
    sql: CASE
      WHEN ${weighted_avg_va_score} > 0.5 THEN 'A'
      WHEN ${weighted_avg_va_score} > 0.25 THEN 'B'
      WHEN ${weighted_avg_va_score} > -0.25 THEN 'C'
      WHEN ${weighted_avg_va_score} > -0.5 THEN 'D'
      ELSE 'E'
    END ;;
    label: "College VA Band"
    description: "Overall college VA band"
    group_label: "Value Added Metrics"
  }

  # Confidence interval measures
  measure: avg_confidence_lower {
    type: average
    sql: ${confidence_interval_lower} ;;
    label: "Avg Confidence Lower"
    description: "Average VA confidence interval lower bound"
    value_format_name: decimal_2
    group_label: "Value Added Metrics"
  }

  measure: avg_confidence_upper {
    type: average
    sql: ${confidence_interval_upper} ;;
    label: "Avg Confidence Upper"
    description: "Average VA confidence interval upper bound"
    value_format_name: decimal_2
    group_label: "Value Added Metrics"
  }

  # Subjects above/below expected as percentage
  measure: pct_subjects_above_expected {
    type: number
    sql: SAFE_DIVIDE(${count_above_expected}, ${count}) * 100 ;;
    label: "% Subjects Above Expected"
    description: "Percentage of subjects with positive VA"
    value_format_name: decimal_1
    group_label: "VA Counts"
  }

  # Top/Bottom performers identification
  measure: max_va_score {
    type: max
    sql: ${value_added_score_dim} ;;
    label: "Max VA Score"
    description: "Highest VA score"
    value_format_name: decimal_2
    group_label: "Value Added Metrics"
  }

  measure: min_va_score {
    type: min
    sql: ${value_added_score_dim} ;;
    label: "Min VA Score"
    description: "Lowest VA score"
    value_format_name: decimal_2
    group_label: "Value Added Metrics"
  }
}
