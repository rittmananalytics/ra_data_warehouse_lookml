# Equity Gap Fact
# Demographic equity gaps from JEDI reports
# Grain: One row per demographic comparison per academic year

view: fct_equity_gap {
  sql_table_name: `ra-warehouse-dev.analytics.fct_equity_gap` ;;
  drill_fields: [dimension_name, student_group, comparison_group, gap_grade_points_dim, gap_trend]

  # Primary Key
  dimension: equity_gap_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.equity_gap_key ;;
    hidden: yes
  }

  # Foreign Keys
  dimension: academic_year_key {
    type: number
    sql: ${TABLE}.academic_year_key ;;
    hidden: yes
  }

  # Source Identifier
  dimension: report_type {
    type: string
    sql: ${TABLE}.report_type ;;
    label: "Report Type"
    description: "Report type (JEDI)"
  }

  dimension: dimension_name {
    type: string
    sql: ${TABLE}.dimension_name ;;
    label: "Equity Dimension"
    description: "Dimension (Gender, Disadvantage, Ethnicity, SEND)"
  }

  # Group Comparison
  dimension: student_group {
    type: string
    sql: ${TABLE}.student_group ;;
    label: "Student Group"
    description: "Student group being analysed"
  }

  dimension: comparison_group {
    type: string
    sql: ${TABLE}.comparison_group ;;
    label: "Comparison Group"
    description: "Reference comparison group"
  }

  # Group Identification
  dimension: group_pair {
    type: string
    sql: CONCAT(${student_group}, ' vs ', ${comparison_group}) ;;
    label: "Group Comparison"
    description: "Student group compared to reference group"
  }

  # Cohort Metrics
  dimension: student_count_dim {
    type: number
    sql: ${TABLE}.student_count ;;
    label: "Student Group Count"
    hidden: yes
  }

  dimension: comparison_count_dim {
    type: number
    sql: ${TABLE}.comparison_count ;;
    label: "Comparison Group Count"
    hidden: yes
  }

  # Performance Metrics (as dimensions for filtering)
  dimension: student_avg_grade_points_dim {
    type: number
    sql: ${TABLE}.student_avg_grade_points ;;
    hidden: yes
  }

  dimension: comparison_avg_grade_points_dim {
    type: number
    sql: ${TABLE}.comparison_avg_grade_points ;;
    hidden: yes
  }

  # Gap Analysis
  dimension: gap_grade_points_dim {
    type: number
    sql: ${TABLE}.gap_grade_points ;;
    label: "Grade Point Gap"
    description: "Gap in grade points (negative = underperformance)"
  }

  dimension: gap_significance {
    type: string
    sql: ${TABLE}.gap_significance ;;
    label: "Gap Significance"
    description: "Statistical significance of gap"
  }

  dimension: performance_band {
    type: string
    sql: ${TABLE}.performance_band ;;
    label: "Performance Band"
    description: "Performance band classification"
  }

  # Trend Indicators
  dimension: prior_year_gap_dim {
    type: number
    sql: ${TABLE}.prior_year_gap ;;
    hidden: yes
  }

  dimension: gap_change_yoy_dim {
    type: number
    sql: ${TABLE}.gap_change_yoy ;;
    hidden: yes
  }

  dimension: gap_trend {
    type: string
    sql: ${TABLE}.gap_trend ;;
    label: "Gap Trend"
    description: "Gap trend (Narrowing, Stable, Widening)"
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
    drill_fields: [dimension_name, student_group, comparison_group, gap_grade_points_dim, gap_trend]
  }

  # Cohort Measures
  measure: total_student_count {
    type: sum
    sql: ${student_count_dim} ;;
    label: "Total Student Group Count"
    description: "Total students in analysed groups"
  }

  measure: total_comparison_count {
    type: sum
    sql: ${comparison_count_dim} ;;
    label: "Total Comparison Count"
    description: "Total students in comparison groups"
  }

  # Performance Measures
  measure: avg_student_grade_points {
    type: average
    sql: ${student_avg_grade_points_dim} ;;
    label: "Avg Student Grade Points"
    description: "Average grade points for student groups"
    value_format_name: decimal_2
  }

  measure: avg_comparison_grade_points {
    type: average
    sql: ${comparison_avg_grade_points_dim} ;;
    label: "Avg Comparison Grade Points"
    description: "Average grade points for comparison groups"
    value_format_name: decimal_2
  }

  # Gap Measures
  measure: avg_gap_grade_points {
    type: average
    sql: ${gap_grade_points_dim} ;;
    label: "Avg Grade Point Gap"
    description: "Average gap in grade points"
    value_format_name: decimal_2
  }

  measure: max_gap_grade_points {
    type: max
    sql: ABS(${gap_grade_points_dim}) ;;
    label: "Max Absolute Gap"
    description: "Maximum absolute gap in grade points"
    value_format_name: decimal_2
  }

  measure: min_gap_grade_points {
    type: min
    sql: ${gap_grade_points_dim} ;;
    label: "Min Gap"
    description: "Minimum gap (most negative)"
    value_format_name: decimal_2
  }

  measure: avg_yoy_gap_change {
    type: average
    sql: ${gap_change_yoy_dim} ;;
    label: "Avg YoY Gap Change"
    description: "Average year-over-year change in gap"
    value_format_name: decimal_2
  }

  # Gap counts by dimension
  measure: count_gender_gaps {
    type: count
    filters: [dimension_name: "Gender"]
    label: "Gender Gaps"
    description: "Count of gender gap comparisons"
    group_label: "Gap Counts by Dimension"
  }

  measure: count_disadvantage_gaps {
    type: count
    filters: [dimension_name: "Disadvantage"]
    label: "Disadvantage Gaps"
    description: "Count of disadvantage gap comparisons"
    group_label: "Gap Counts by Dimension"
  }

  measure: count_ethnicity_gaps {
    type: count
    filters: [dimension_name: "Ethnicity"]
    label: "Ethnicity Gaps"
    description: "Count of ethnicity gap comparisons"
    group_label: "Gap Counts by Dimension"
  }

  measure: count_send_gaps {
    type: count
    filters: [dimension_name: "SEND"]
    label: "SEND Gaps"
    description: "Count of SEND gap comparisons"
    group_label: "Gap Counts by Dimension"
  }

  # Gap counts by trend
  measure: count_narrowing {
    type: count
    filters: [gap_trend: "Narrowing"]
    label: "Narrowing Gaps"
    description: "Count of narrowing gaps"
    group_label: "Gap Trend Counts"
  }

  measure: count_stable {
    type: count
    filters: [gap_trend: "Stable"]
    label: "Stable Gaps"
    description: "Count of stable gaps"
    group_label: "Gap Trend Counts"
  }

  measure: count_widening {
    type: count
    filters: [gap_trend: "Widening"]
    label: "Widening Gaps"
    description: "Count of widening gaps"
    group_label: "Gap Trend Counts"
  }
}
