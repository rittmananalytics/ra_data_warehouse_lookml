# College Performance Fact
# College-level performance from Six Dimensions reports
# Grain: One row per report type per academic year

view: fct_college_performance {
  sql_table_name: `ra-warehouse-dev.analytics.fct_college_performance` ;;
  drill_fields: [report_type, report_name]

  # Primary Key
  dimension: college_performance_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.college_performance_key ;;
    hidden: yes
  }

  # Foreign Keys
  dimension: academic_year_key {
    type: number
    sql: ${TABLE}.academic_year_key ;;
    hidden: yes
  }

  # Source Identifiers
  dimension: report_type {
    type: string
    sql: ${TABLE}.report_type ;;
    label: "Report Type"
    description: "Report type (VA, Sixth Sense)"
  }

  dimension: report_name {
    type: string
    sql: ${TABLE}.report_name ;;
    label: "Report Name"
    description: "Full report name"
  }

  # Report Date
  dimension_group: report {
    type: time
    timeframes: [date, month, year]
    sql: ${TABLE}.report_date ;;
    label: "Report"
    description: "Date of report"
  }

  # Cohort (as dimension for filtering)
  dimension: cohort_count_dim {
    type: number
    sql: ${TABLE}.total_cohort_count ;;
    label: "Cohort Count"
    description: "Total student cohort"
    hidden: yes
  }

  # Performance Metrics (as dimensions for filtering)
  dimension: pass_rate_dim {
    type: number
    sql: ${TABLE}.avg_pass_rate_pct ;;
    label: "Pass Rate %"
    hidden: yes
  }

  dimension: high_grades_dim {
    type: number
    sql: ${TABLE}.avg_high_grades_pct ;;
    label: "High Grades %"
    hidden: yes
  }

  dimension: completion_rate_dim {
    type: number
    sql: ${TABLE}.avg_completion_rate_pct ;;
    label: "Completion Rate %"
    hidden: yes
  }

  dimension: retention_rate_dim {
    type: number
    sql: ${TABLE}.avg_retention_rate_pct ;;
    label: "Retention Rate %"
    hidden: yes
  }

  dimension: achievement_rate_dim {
    type: number
    sql: ${TABLE}.avg_achievement_rate_pct ;;
    label: "Achievement Rate %"
    hidden: yes
  }

  dimension: attendance_rate_dim {
    type: number
    sql: ${TABLE}.avg_attendance_rate_pct ;;
    label: "Attendance Rate %"
    hidden: yes
  }

  dimension: value_added_dim {
    type: number
    sql: ${TABLE}.avg_value_added_score ;;
    label: "Value Added Score"
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
    drill_fields: [report_type, report_name]
  }

  measure: total_cohort_count {
    type: sum
    sql: ${TABLE}.total_cohort_count ;;
    label: "Total Cohort"
    description: "Total student cohort"
  }

  # Performance Metrics (Sixth Sense)
  measure: avg_pass_rate {
    type: average
    sql: ${pass_rate_dim} ;;
    label: "Avg Pass Rate %"
    description: "Average pass rate"
    value_format_name: decimal_1
    group_label: "Sixth Sense Metrics"
  }

  measure: avg_high_grades {
    type: average
    sql: ${high_grades_dim} ;;
    label: "Avg High Grades %"
    description: "Average high grade rate"
    value_format_name: decimal_1
    group_label: "Sixth Sense Metrics"
  }

  measure: avg_completion_rate {
    type: average
    sql: ${completion_rate_dim} ;;
    label: "Avg Completion Rate %"
    description: "Average completion rate"
    value_format_name: decimal_1
    group_label: "Sixth Sense Metrics"
  }

  measure: avg_retention_rate {
    type: average
    sql: ${retention_rate_dim} ;;
    label: "Avg Retention Rate %"
    description: "Average retention rate"
    value_format_name: decimal_1
    group_label: "Sixth Sense Metrics"
  }

  measure: avg_achievement_rate {
    type: average
    sql: ${achievement_rate_dim} ;;
    label: "Avg Achievement Rate %"
    description: "Average achievement rate"
    value_format_name: decimal_1
    group_label: "Sixth Sense Metrics"
  }

  measure: avg_attendance_rate {
    type: average
    sql: ${attendance_rate_dim} ;;
    label: "Avg Attendance Rate %"
    description: "Average attendance rate"
    value_format_name: decimal_1
    group_label: "Sixth Sense Metrics"
  }

  # Value-Added Metrics
  measure: avg_value_added_score {
    type: average
    sql: ${value_added_dim} ;;
    label: "Avg Value Added Score"
    description: "Average VA score"
    value_format_name: decimal_2
    group_label: "Value Added Metrics"
  }

  measure: avg_confidence_lower {
    type: average
    sql: ${TABLE}.avg_confidence_lower ;;
    label: "Avg Confidence Lower"
    description: "Average VA confidence lower bound"
    value_format_name: decimal_2
    group_label: "Value Added Metrics"
  }

  measure: avg_confidence_upper {
    type: average
    sql: ${TABLE}.avg_confidence_upper ;;
    label: "Avg Confidence Upper"
    description: "Average VA confidence upper bound"
    value_format_name: decimal_2
    group_label: "Value Added Metrics"
  }
}
