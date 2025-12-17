connection: "ra_dw_prod"

# Include all view files
include: "/views/rp/*.view.lkml"

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
