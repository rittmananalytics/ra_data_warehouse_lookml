connection: "ra_dw_prod"

# Include all view files
include: "/views/*.view.lkml"

# =====================================================================
# DATA GROUPS - For caching and scheduling
# =====================================================================

datagroup: daily_refresh {
  sql_trigger: SELECT MAX(loaded_at) FROM `ra-warehouse-dev.analytics.fct_enrolment` ;;
  max_cache_age: "24 hours"
}

datagroup: weekly_refresh {
  sql_trigger: SELECT CURRENT_DATE() ;;
  max_cache_age: "168 hours"
}

persist_with: daily_refresh

# =====================================================================
# EXPLORE 1: Enrolment Performance
# Primary explore for course performance and equity analysis
# Stage 1 deliverable
# =====================================================================

explore: fct_enrolment {
  label: "Enrolment Performance"
  description: "Student enrolment data with grades, demographics, and prior attainment for performance and equity analysis"
  group_label: "Performance Analytics"

  # Academic Year dimension
  join: dim_academic_year {
    type: left_outer
    sql_on: ${fct_enrolment.academic_year_key} = ${dim_academic_year.academic_year_key} ;;
    relationship: many_to_one
  }

  # Offering Type dimension
  join: dim_offering_type {
    type: left_outer
    sql_on: ${fct_enrolment.offering_type_key} = ${dim_offering_type.offering_type_key} ;;
    relationship: many_to_one
  }

  # Course Header dimension
  join: dim_course_header {
    type: left_outer
    sql_on: ${fct_enrolment.course_header_key} = ${dim_course_header.course_header_key} ;;
    relationship: many_to_one
  }

  # Offering dimension
  join: dim_offering {
    type: left_outer
    sql_on: ${fct_enrolment.offering_key} = ${dim_offering.offering_key} ;;
    relationship: many_to_one
  }

  # Student dimension
  join: dim_student {
    type: left_outer
    sql_on: ${fct_enrolment.student_key} = ${dim_student.student_key} ;;
    relationship: many_to_one
  }

  # Student Detail dimension (for extended demographics)
  join: dim_student_detail {
    type: left_outer
    sql_on: ${fct_enrolment.student_detail_key} = ${dim_student_detail.student_detail_key} ;;
    relationship: many_to_one
  }

  # Prior Attainment dimension
  join: dim_prior_attainment {
    type: left_outer
    sql_on: ${fct_enrolment.prior_attainment_key} = ${dim_prior_attainment.prior_attainment_key} ;;
    relationship: many_to_one
  }

  # Grade dimension
  join: dim_grade {
    type: left_outer
    sql_on: ${fct_enrolment.grade_key} = ${dim_grade.grade_key} ;;
    relationship: many_to_one
  }

  # Default query settings
  query: default_performance {
    dimensions: [dim_academic_year.academic_year_name, dim_offering.offering_name]
    measures: [fct_enrolment.cohort_count, fct_enrolment.high_grade_pct, fct_enrolment.pass_rate_pct]
    filters: [dim_academic_year.is_current_year: "Yes"]
    label: "Current Year Performance by Subject"
  }

  query: equity_overview {
    dimensions: [fct_enrolment.gender, fct_enrolment.is_disadvantaged]
    measures: [fct_enrolment.cohort_count, fct_enrolment.high_grade_pct]
    filters: [dim_academic_year.is_current_year: "Yes"]
    label: "Equity Overview - Gender & Disadvantage"
  }
}

# =====================================================================
# EXPLORE 2: ALPS Subject Performance
# ALPS benchmarking at subject level
# Stage 2 deliverable
# =====================================================================

explore: fct_alps_subject_performance {
  label: "ALPS Subject Performance"
  description: "ALPS benchmarking data at subject level with value-added scores and bands"
  group_label: "Benchmarking"

  # Academic Year dimension
  join: dim_academic_year {
    type: left_outer
    sql_on: ${fct_alps_subject_performance.academic_year_key} = ${dim_academic_year.academic_year_key} ;;
    relationship: many_to_one
  }

  # Offering dimension (for mapping to internal subjects)
  join: dim_offering {
    type: left_outer
    sql_on: ${fct_alps_subject_performance.offering_key} = ${dim_offering.offering_key} ;;
    relationship: many_to_one
  }

  query: alps_overview {
    dimensions: [alps_subject_name, alps_qualification_type]
    measures: [total_cohort_count, average_alps_band, average_value_added]
    filters: [dim_academic_year.is_current_year: "Yes"]
    label: "ALPS Performance Overview"
  }
}

# =====================================================================
# EXPLORE 3: College Performance
# College-level metrics from Six Dimensions
# Stage 3 deliverable
# =====================================================================

explore: fct_college_performance {
  label: "College Performance"
  description: "College-level performance metrics from Six Dimensions reports"
  group_label: "Benchmarking"

  # Academic Year dimension
  join: dim_academic_year {
    type: left_outer
    sql_on: ${fct_college_performance.academic_year_key} = ${dim_academic_year.academic_year_key} ;;
    relationship: many_to_one
  }

  query: college_trends {
    dimensions: [dim_academic_year.academic_year_name, report_type]
    measures: [avg_pass_rate, avg_high_grades, avg_value_added_score]
    label: "College Performance Trends"
  }
}

# =====================================================================
# EXPLORE 4: Subject Benchmark
# Subject-level benchmarking from Six Dimensions
# Stage 3 deliverable
# =====================================================================

explore: fct_subject_benchmark {
  label: "Subject Benchmarking"
  description: "Subject-level performance benchmarking from Six Dimensions reports"
  group_label: "Benchmarking"

  # Academic Year dimension
  join: dim_academic_year {
    type: left_outer
    sql_on: ${fct_subject_benchmark.academic_year_key} = ${dim_academic_year.academic_year_key} ;;
    relationship: many_to_one
  }

  # Offering dimension (for mapping to internal subjects)
  join: dim_offering {
    type: left_outer
    sql_on: ${fct_subject_benchmark.offering_key} = ${dim_offering.offering_key} ;;
    relationship: many_to_one
  }

  query: subject_va_overview {
    dimensions: [six_dimensions_subject_name, qualification_type]
    measures: [total_cohort_count, avg_value_added_score, avg_pass_rate]
    filters: [dim_academic_year.is_current_year: "Yes", report_type: "VA"]
    label: "Subject Value-Added Overview"
  }

  query: subject_trajectory {
    dimensions: [six_dimensions_subject_name, performance_trajectory]
    measures: [count]
    filters: [dim_academic_year.is_current_year: "Yes"]
    label: "Subject Performance Trajectories"
  }
}

# =====================================================================
# EXPLORE 5: Equity Gap Analysis
# JEDI equity gap analysis
# Stage 3 deliverable
# =====================================================================

explore: fct_equity_gap {
  label: "Equity Gap Analysis"
  description: "Demographic equity gap analysis from JEDI reports"
  group_label: "Equity & Diversity"

  # Academic Year dimension
  join: dim_academic_year {
    type: left_outer
    sql_on: ${fct_equity_gap.academic_year_key} = ${dim_academic_year.academic_year_key} ;;
    relationship: many_to_one
  }

  query: gap_overview {
    dimensions: [dimension_name, student_group, comparison_group]
    measures: [avg_gap_grade_points, total_student_count]
    filters: [dim_academic_year.is_current_year: "Yes"]
    label: "Current Year Equity Gaps"
  }

  query: gap_trends {
    dimensions: [dim_academic_year.academic_year_name, dimension_name]
    measures: [avg_gap_grade_points]
    pivots: [dimension_name]
    label: "Equity Gap Trends Over Time"
  }
}

# =====================================================================
# EXPLORE 6: Student Demographics
# Student-focused demographic analysis
# Stage 1 deliverable
# =====================================================================

explore: dim_student {
  label: "Student Demographics"
  description: "Student master data with core demographics"
  group_label: "Student Data"

  # Student Detail for extended demographics
  join: dim_student_detail {
    type: left_outer
    sql_on: ${dim_student.student_id} = ${dim_student_detail.student_id} ;;
    relationship: one_to_many
  }

  query: demographic_breakdown {
    dimensions: [gender, ethnicity]
    measures: [count_distinct_students]
    label: "Student Demographic Breakdown"
  }
}

# =====================================================================
# EXPLORE 7: Prior Attainment Analysis
# Prior attainment and GCSE score analysis
# Stage 2 deliverable
# =====================================================================

explore: dim_prior_attainment {
  label: "Prior Attainment"
  description: "Student prior attainment data including GCSE scores and banding"
  group_label: "Student Data"

  # Academic Year for context
  join: dim_academic_year {
    type: left_outer
    sql_on: ${dim_prior_attainment.academic_year_id} = ${dim_academic_year.academic_year_id} ;;
    relationship: many_to_one
  }

  query: prior_attainment_distribution {
    dimensions: [prior_attainment_band]
    measures: [count, average_gcse]
    label: "Prior Attainment Distribution"
  }
}

# =====================================================================
# EXPLORE 8: Grade Reference
# Grade reference data for lookups
# =====================================================================

explore: dim_grade {
  label: "Grade Reference"
  description: "Grade reference data with UCAS points and classification flags"
  group_label: "Reference Data"
  hidden: yes
}

# =====================================================================
# EXPLORE 9: Offering Reference
# Course and offering reference
# =====================================================================

explore: dim_offering {
  label: "Course Offerings"
  description: "Course offering reference with external system mappings"
  group_label: "Reference Data"

  # Course Header
  join: dim_course_header {
    type: left_outer
    sql_on: ${dim_offering.course_header_id} = ${dim_course_header.course_header_id} ;;
    relationship: many_to_one
  }

  # Offering Type
  join: dim_offering_type {
    type: left_outer
    sql_on: ${dim_offering.offering_type_id} = ${dim_offering_type.offering_type_id} ;;
    relationship: many_to_one
  }

  # Academic Year
  join: dim_academic_year {
    type: left_outer
    sql_on: ${dim_offering.academic_year_id} = ${dim_academic_year.academic_year_id} ;;
    relationship: many_to_one
  }
}

# =====================================================================
# ACCESS GRANTS - Role-based access control
# =====================================================================

# access_grant: can_view_student_pii {
#   user_attribute: department
#   allowed_values: ["Senior Leadership", "Student Services", "Registry"]
# }
#
# access_grant: can_view_sensitive_demographics {
#   user_attribute: role
#   allowed_values: ["admin", "data_analyst", "safeguarding"]
# }

# =====================================================================
# NAMED VALUE FORMATS
# =====================================================================

# These are defined at view level but can be referenced in derived tables

# =====================================================================
# DERIVED TABLES FOR YEAR-OVER-YEAR COMPARISONS
# =====================================================================

# Prior Year Performance - Aggregated metrics by offering for YoY comparison
view: prior_year_performance {
  derived_table: {
    sql:
      SELECT
        e.offering_key,
        e.academic_year_id,
        ay.academic_year_name,
        COUNT(*) as cohort_count,
        SUM(e.is_pass) as pass_count,
        SUM(e.is_high_grade) as high_grade_count,
        SAFE_DIVIDE(SUM(e.is_pass), COUNT(*)) * 100 as pass_rate_pct,
        SAFE_DIVIDE(SUM(e.is_high_grade), COUNT(*)) * 100 as high_grade_pct,
        AVG(CASE WHEN e.average_gcse_score > 0 THEN e.average_gcse_score END) as avg_gcse_score,
        AVG(g.grade_points) as avg_grade_points
      FROM `ra-warehouse-dev.analytics.fct_enrolment` e
      LEFT JOIN `ra-warehouse-dev.analytics.dim_academic_year` ay
        ON e.academic_year_key = ay.academic_year_key
      LEFT JOIN `ra-warehouse-dev.analytics.dim_grade` g
        ON e.grade_key = g.grade_key
      WHERE ay.is_current_year = FALSE
        AND ay.years_from_current = -1
      GROUP BY 1, 2, 3
    ;;
    persist_for: "24 hours"
  }

  dimension: offering_key {
    type: number
    sql: ${TABLE}.offering_key ;;
    primary_key: yes
    hidden: yes
  }

  dimension: academic_year_id {
    type: string
    sql: ${TABLE}.academic_year_id ;;
    label: "Prior Academic Year"
  }

  dimension: academic_year_name {
    type: string
    sql: ${TABLE}.academic_year_name ;;
    label: "Prior Year Name"
  }

  measure: prior_cohort_count {
    type: sum
    sql: ${TABLE}.cohort_count ;;
    label: "Prior Year Cohort"
  }

  measure: prior_pass_rate_pct {
    type: average
    sql: ${TABLE}.pass_rate_pct ;;
    label: "Prior Year Pass Rate %"
    value_format_name: decimal_1
  }

  measure: prior_high_grade_pct {
    type: average
    sql: ${TABLE}.high_grade_pct ;;
    label: "Prior Year High Grade %"
    value_format_name: decimal_1
  }

  measure: prior_avg_gcse_score {
    type: average
    sql: ${TABLE}.avg_gcse_score ;;
    label: "Prior Year Avg GCSE"
    value_format_name: decimal_2
  }

  measure: prior_avg_grade_points {
    type: average
    sql: ${TABLE}.avg_grade_points ;;
    label: "Prior Year Avg Grade Points"
    value_format_name: decimal_2
  }
}

# College-Level Prior Year Performance
view: prior_year_college_performance {
  derived_table: {
    sql:
      SELECT
        e.academic_year_id,
        ay.academic_year_name,
        COUNT(*) as cohort_count,
        SUM(e.is_pass) as pass_count,
        SUM(e.is_high_grade) as high_grade_count,
        SUM(CASE WHEN e.is_completed THEN 1 ELSE 0 END) as completed_count,
        SAFE_DIVIDE(SUM(e.is_pass), COUNT(*)) * 100 as pass_rate_pct,
        SAFE_DIVIDE(SUM(e.is_high_grade), COUNT(*)) * 100 as high_grade_pct,
        SAFE_DIVIDE(SUM(CASE WHEN e.is_completed THEN 1 ELSE 0 END), COUNT(*)) * 100 as completion_rate_pct,
        AVG(CASE WHEN e.average_gcse_score > 0 THEN e.average_gcse_score END) as avg_gcse_score,
        AVG(g.grade_points) as avg_grade_points
      FROM `ra-warehouse-dev.analytics.fct_enrolment` e
      LEFT JOIN `ra-warehouse-dev.analytics.dim_academic_year` ay
        ON e.academic_year_key = ay.academic_year_key
      LEFT JOIN `ra-warehouse-dev.analytics.dim_grade` g
        ON e.grade_key = g.grade_key
      WHERE ay.is_current_year = FALSE
        AND ay.years_from_current = -1
      GROUP BY 1, 2
    ;;
    persist_for: "24 hours"
  }

  dimension: academic_year_id {
    type: string
    sql: ${TABLE}.academic_year_id ;;
    primary_key: yes
    label: "Prior Academic Year"
  }

  measure: prior_total_cohort {
    type: sum
    sql: ${TABLE}.cohort_count ;;
    label: "Prior Year Total Cohort"
  }

  measure: prior_college_pass_rate {
    type: number
    sql: MAX(${TABLE}.pass_rate_pct) ;;
    label: "Prior Year College Pass Rate %"
    value_format_name: decimal_1
  }

  measure: prior_college_high_grade {
    type: number
    sql: MAX(${TABLE}.high_grade_pct) ;;
    label: "Prior Year College High Grade %"
    value_format_name: decimal_1
  }

  measure: prior_college_completion_rate {
    type: number
    sql: MAX(${TABLE}.completion_rate_pct) ;;
    label: "Prior Year Completion Rate %"
    value_format_name: decimal_1
  }

  measure: prior_college_avg_gcse {
    type: number
    sql: MAX(${TABLE}.avg_gcse_score) ;;
    label: "Prior Year Avg GCSE Entry"
    value_format_name: decimal_2
  }

  measure: prior_college_avg_grade_points {
    type: number
    sql: MAX(${TABLE}.avg_grade_points) ;;
    label: "Prior Year Avg Grade Points"
    value_format_name: decimal_2
  }
}

# Subject-Level Gender Gap by Offering
view: subject_gender_gap {
  derived_table: {
    sql:
      SELECT
        e.offering_key,
        o.offering_name,
        e.academic_year_id,
        COUNT(CASE WHEN e.gender = 'Female' THEN 1 END) as female_count,
        COUNT(CASE WHEN e.gender = 'Male' THEN 1 END) as male_count,
        SUM(CASE WHEN e.gender = 'Female' THEN e.is_pass ELSE 0 END) as female_pass_count,
        SUM(CASE WHEN e.gender = 'Male' THEN e.is_pass ELSE 0 END) as male_pass_count,
        SUM(CASE WHEN e.gender = 'Female' THEN e.is_high_grade ELSE 0 END) as female_high_grade_count,
        SUM(CASE WHEN e.gender = 'Male' THEN e.is_high_grade ELSE 0 END) as male_high_grade_count,
        SAFE_DIVIDE(SUM(CASE WHEN e.gender = 'Female' THEN e.is_pass ELSE 0 END),
                    NULLIF(COUNT(CASE WHEN e.gender = 'Female' THEN 1 END), 0)) * 100 as female_pass_rate,
        SAFE_DIVIDE(SUM(CASE WHEN e.gender = 'Male' THEN e.is_pass ELSE 0 END),
                    NULLIF(COUNT(CASE WHEN e.gender = 'Male' THEN 1 END), 0)) * 100 as male_pass_rate,
        SAFE_DIVIDE(SUM(CASE WHEN e.gender = 'Female' THEN e.is_high_grade ELSE 0 END),
                    NULLIF(COUNT(CASE WHEN e.gender = 'Female' THEN 1 END), 0)) * 100 as female_high_grade_rate,
        SAFE_DIVIDE(SUM(CASE WHEN e.gender = 'Male' THEN e.is_high_grade ELSE 0 END),
                    NULLIF(COUNT(CASE WHEN e.gender = 'Male' THEN 1 END), 0)) * 100 as male_high_grade_rate
      FROM `ra-warehouse-dev.analytics.fct_enrolment` e
      LEFT JOIN `ra-warehouse-dev.analytics.dim_offering` o
        ON e.offering_key = o.offering_key
      GROUP BY 1, 2, 3
    ;;
    persist_for: "24 hours"
  }

  dimension: offering_key {
    type: number
    sql: ${TABLE}.offering_key ;;
    hidden: yes
  }

  dimension: offering_name {
    type: string
    sql: ${TABLE}.offering_name ;;
    label: "Subject"
  }

  dimension: academic_year_id {
    type: string
    sql: ${TABLE}.academic_year_id ;;
    label: "Academic Year"
  }

  dimension: pk {
    type: string
    sql: CONCAT(${offering_key}, '-', ${academic_year_id}) ;;
    primary_key: yes
    hidden: yes
  }

  measure: subject_female_count {
    type: sum
    sql: ${TABLE}.female_count ;;
    label: "Female Count"
  }

  measure: subject_male_count {
    type: sum
    sql: ${TABLE}.male_count ;;
    label: "Male Count"
  }

  measure: subject_female_pass_rate {
    type: average
    sql: ${TABLE}.female_pass_rate ;;
    label: "Female Pass Rate %"
    value_format_name: decimal_1
  }

  measure: subject_male_pass_rate {
    type: average
    sql: ${TABLE}.male_pass_rate ;;
    label: "Male Pass Rate %"
    value_format_name: decimal_1
  }

  measure: subject_female_high_grade_rate {
    type: average
    sql: ${TABLE}.female_high_grade_rate ;;
    label: "Female High Grade %"
    value_format_name: decimal_1
  }

  measure: subject_male_high_grade_rate {
    type: average
    sql: ${TABLE}.male_high_grade_rate ;;
    label: "Male High Grade %"
    value_format_name: decimal_1
  }

  measure: subject_gender_gap_pass {
    type: number
    sql: ${subject_female_pass_rate} - ${subject_male_pass_rate} ;;
    label: "Gender Gap (Pass) pp"
    description: "Female pass rate minus male pass rate by subject"
    value_format_name: decimal_1
  }

  measure: subject_gender_gap_high_grade {
    type: number
    sql: ${subject_female_high_grade_rate} - ${subject_male_high_grade_rate} ;;
    label: "Gender Gap (High Grade) pp"
    description: "Female high grade rate minus male high grade rate by subject"
    value_format_name: decimal_1
  }

  measure: count_subjects_with_large_gap {
    type: count_distinct
    sql: CASE WHEN ABS(${TABLE}.female_pass_rate - ${TABLE}.male_pass_rate) > 5 THEN ${offering_key} END ;;
    label: "Subjects with Gap >5pp"
    description: "Count of subjects with gender gap exceeding 5 percentage points"
  }
}

# =====================================================================
# EXPLORE 10: Year-over-Year Performance Analysis
# Combines current and prior year data
# =====================================================================

explore: fct_enrolment_yoy {
  from: fct_enrolment
  label: "Performance - Year over Year"
  description: "Current year performance with prior year comparison"
  group_label: "Performance Analytics"

  join: dim_academic_year {
    type: left_outer
    sql_on: ${fct_enrolment_yoy.academic_year_key} = ${dim_academic_year.academic_year_key} ;;
    relationship: many_to_one
  }

  join: dim_offering {
    type: left_outer
    sql_on: ${fct_enrolment_yoy.offering_key} = ${dim_offering.offering_key} ;;
    relationship: many_to_one
  }

  join: dim_offering_type {
    type: left_outer
    sql_on: ${fct_enrolment_yoy.offering_type_key} = ${dim_offering_type.offering_type_key} ;;
    relationship: many_to_one
  }

  join: dim_grade {
    type: left_outer
    sql_on: ${fct_enrolment_yoy.grade_key} = ${dim_grade.grade_key} ;;
    relationship: many_to_one
  }

  join: prior_year_performance {
    type: left_outer
    sql_on: ${fct_enrolment_yoy.offering_key} = ${prior_year_performance.offering_key} ;;
    relationship: many_to_one
  }

  join: prior_year_college_performance {
    type: cross
    relationship: many_to_one
  }
}

# =====================================================================
# EXPLORE 11: Subject Gender Gap Analysis
# Subject-level gender gap analysis
# =====================================================================

explore: subject_gender_gap {
  label: "Subject Gender Gap Analysis"
  description: "Gender gap analysis at subject level"
  group_label: "Equity & Diversity"

  join: dim_academic_year {
    type: left_outer
    sql_on: ${subject_gender_gap.academic_year_id} = ${dim_academic_year.academic_year_id} ;;
    relationship: many_to_one
  }

  join: dim_offering {
    type: left_outer
    sql_on: ${subject_gender_gap.offering_key} = ${dim_offering.offering_key} ;;
    relationship: many_to_one
  }
}
