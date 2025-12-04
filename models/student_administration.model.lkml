connection: "ra_dw_prod"

# include all the views for student administration
include: "/views/bp/*.view.lkml"

datagroup: student_administration_default_datagroup {
  sql_trigger: SELECT MAX(updated_ts) FROM `ra-development.bp_analytics_bp_analytics.enrolment_fct` ;;
  max_cache_age: "4 hours"
}

fiscal_month_offset: +3
week_start_day: monday

explore: student_enrolments {
  label: "Student Enrolments"
  description: "Analysis of student enrolments, performance, demographics, and completion rates"
  view_label: "Enrolments"

  from: bp_enrolment_fct

  join: students {
    from: bp_student_dim
    view_label: "Students"
    sql_on: ${student_enrolments.student_fk} = ${students.student_pk} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: offerings {
    from: bp_offering_dim
    view_label: "Course Offerings"
    sql_on: ${student_enrolments.offering_fk} = ${offerings.offering_pk} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: course_headers {
    from: bp_course_header_dim
    view_label: "Courses"
    sql_on: ${offerings.course_header_fk} = ${course_headers.course_header_pk} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: academic_years {
    from: bp_academic_year_dim
    view_label: "Academic Year"
    sql_on: ${student_enrolments.academic_year_fk} = ${academic_years.academic_year_pk} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: college_levels {
    from: bp_college_level_dim
    view_label: "College Levels"
    sql_on: ${student_enrolments.college_level_fk} = ${college_levels.college_level_pk} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: completion_status {
    from: bp_completion_status_dim
    view_label: "Completion Status"
    sql_on: ${student_enrolments.completion_status_fk} = ${completion_status.completion_status_pk} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: prior_attainment {
    from: bp_prior_attainment_dim
    view_label: "Prior Attainment"
    sql_on: ${student_enrolments.prior_attainment_fk} = ${prior_attainment.prior_attainment_pk} ;;
    type: left_outer
    relationship: many_to_one
  }
}

explore: course_summary_by_year {
  label: "Course Performance Summary"
  description: "Pre-aggregated course performance metrics by academic year"
  view_label: "Course Summary"

  from: bp_course_summary_by_year_agg

  join: academic_years {
    from: bp_academic_year_dim
    view_label: "Academic Year"
    sql_on: ${course_summary_by_year.academic_year_fk} = ${academic_years.academic_year_pk} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: college_levels {
    from: bp_college_level_dim
    view_label: "College Levels"
    sql_on: ${course_summary_by_year.college_level_fk} = ${college_levels.college_level_pk} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: offerings {
    from: bp_offering_dim
    view_label: "Course Offerings"
    sql_on: ${course_summary_by_year.offering_fk} = ${offerings.offering_pk} ;;
    type: left_outer
    relationship: many_to_one
  }
}
