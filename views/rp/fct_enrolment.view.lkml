# Enrolment Fact Table
# Student enrolment fact table for internal performance analysis
# Grain: One row per student per offering (student-enrolment)

view: fct_enrolment {
  sql_table_name: `ra-warehouse-dev.analytics.fct_enrolment` ;;
  drill_fields: [detail*]

  set: detail {
    fields: [
      academic_year_id,
      dim_offering.offering_name,
      dim_student.full_name,
      grade,
      completion_status
    ]
  }

  # Primary Key
  dimension: enrolment_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.enrolment_key ;;
    hidden: yes
  }

  # Dimension Foreign Keys (surrogate)
  dimension: academic_year_key {
    type: number
    sql: ${TABLE}.academic_year_key ;;
    hidden: yes
  }

  dimension: offering_type_key {
    type: number
    sql: ${TABLE}.offering_type_key ;;
    hidden: yes
  }

  dimension: course_header_key {
    type: number
    sql: ${TABLE}.course_header_key ;;
    hidden: yes
  }

  dimension: offering_key {
    type: number
    sql: ${TABLE}.offering_key ;;
    hidden: yes
  }

  dimension: student_key {
    type: number
    sql: ${TABLE}.student_key ;;
    hidden: yes
  }

  dimension: student_detail_key {
    type: number
    sql: ${TABLE}.student_detail_key ;;
    hidden: yes
  }

  dimension: prior_attainment_key {
    type: number
    sql: ${TABLE}.prior_attainment_key ;;
    hidden: yes
  }

  dimension: grade_key {
    type: number
    sql: ${TABLE}.grade_key ;;
    hidden: yes
  }

  # Natural/Degenerate Keys
  dimension: academic_year_id {
    type: string
    sql: ${TABLE}.academic_year_id ;;
    label: "Academic Year"
    description: "Academic year (e.g., '23/24')"
  }

  dimension: offering_id {
    type: number
    sql: ${TABLE}.offering_id ;;
    hidden: yes
  }

  dimension: student_id {
    type: number
    sql: ${TABLE}.student_id ;;
    label: "Student ID"
  }

  dimension: student_detail_id {
    type: number
    sql: ${TABLE}.student_detail_id ;;
    hidden: yes
  }

  # For Partitioning
  dimension_group: academic_year_start {
    type: time
    timeframes: [date, month, year]
    sql: ${TABLE}.academic_year_start_date ;;
    hidden: yes
  }

  # Enrolment Status
  dimension: completion_status_id {
    type: number
    sql: ${TABLE}.completion_status_id ;;
    hidden: yes
  }

  dimension: completion_status {
    type: string
    sql: ${TABLE}.completion_status ;;
    label: "Completion Status"
    description: "Enrolment completion status (Completed, Continuing, etc.)"
  }

  dimension: is_completed {
    type: yesno
    sql: ${TABLE}.is_completed ;;
    label: "Is Completed"
    description: "Flag indicating completed enrolment"
  }

  # Grade Dimensions
  dimension: grade {
    type: string
    sql: ${TABLE}.grade ;;
    label: "Grade"
    description: "Achieved grade"
  }

  dimension: target_grade {
    type: string
    sql: ${TABLE}.target_grade ;;
    label: "Target Grade"
  }

  dimension: predicted_grade {
    type: string
    sql: ${TABLE}.predicted_grade ;;
    label: "Predicted Grade"
  }

  # A-Level Grade Flag Dimensions (hidden, used for measures)
  dimension: is_grade_a_star_dim {
    type: number
    sql: ${TABLE}.is_grade_a_star ;;
    hidden: yes
  }

  dimension: is_grade_a_dim {
    type: number
    sql: ${TABLE}.is_grade_a ;;
    hidden: yes
  }

  dimension: is_grade_b_dim {
    type: number
    sql: ${TABLE}.is_grade_b ;;
    hidden: yes
  }

  dimension: is_grade_c_dim {
    type: number
    sql: ${TABLE}.is_grade_c ;;
    hidden: yes
  }

  dimension: is_grade_d_dim {
    type: number
    sql: ${TABLE}.is_grade_d ;;
    hidden: yes
  }

  dimension: is_grade_e_dim {
    type: number
    sql: ${TABLE}.is_grade_e ;;
    hidden: yes
  }

  dimension: is_grade_u_dim {
    type: number
    sql: ${TABLE}.is_grade_u ;;
    hidden: yes
  }

  # BTEC Grade Flag Dimensions (hidden, used for measures)
  dimension: is_grade_distinction_star_dim {
    type: number
    sql: ${TABLE}.is_grade_distinction_star ;;
    hidden: yes
  }

  dimension: is_grade_distinction_dim {
    type: number
    sql: ${TABLE}.is_grade_distinction ;;
    hidden: yes
  }

  dimension: is_grade_merit_dim {
    type: number
    sql: ${TABLE}.is_grade_merit ;;
    hidden: yes
  }

  dimension: is_grade_pass_dim {
    type: number
    sql: ${TABLE}.is_grade_pass ;;
    hidden: yes
  }

  # Cumulative Grade Flag Dimensions (hidden)
  dimension: is_high_grade_dim {
    type: number
    sql: ${TABLE}.is_high_grade ;;
    hidden: yes
  }

  dimension: is_pass_dim {
    type: number
    sql: ${TABLE}.is_pass ;;
    hidden: yes
  }

  # Prior Attainment (denormalized)
  dimension: average_gcse_score {
    type: number
    sql: ${TABLE}.average_gcse_score ;;
    label: "Avg GCSE Score"
    description: "Student's average GCSE point score"
    value_format_name: decimal_2
    group_label: "Prior Attainment"
  }

  dimension: prior_attainment_band {
    type: string
    sql: ${TABLE}.prior_attainment_band ;;
    label: "Prior Attainment Band"
    description: "ALPS-style band (Low/Mid/High)"
    group_label: "Prior Attainment"
  }

  # Demographic Dimensions (denormalized)
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

  dimension: is_send {
    type: yesno
    sql: ${TABLE}.is_send ;;
    label: "SEND"
    description: "Special Educational Needs flag"
    group_label: "Demographics"
  }

  dimension: is_free_meals {
    type: yesno
    sql: ${TABLE}.is_free_meals ;;
    label: "Free School Meals"
    group_label: "Demographics"
  }

  dimension: is_bursary {
    type: yesno
    sql: ${TABLE}.is_bursary ;;
    label: "Bursary Recipient"
    group_label: "Demographics"
  }

  dimension: is_lac {
    type: yesno
    sql: ${TABLE}.is_lac ;;
    label: "Looked After Child"
    group_label: "Demographics"
  }

  dimension: is_young_carer {
    type: yesno
    sql: ${TABLE}.is_young_carer ;;
    label: "Young Carer"
    group_label: "Demographics"
  }

  # Derived: Disadvantaged (PP or FCM)
  dimension: is_disadvantaged {
    type: yesno
    sql: ${TABLE}.is_free_meals OR ${TABLE}.is_bursary ;;
    label: "Disadvantaged (PP/FCM)"
    description: "Pupil Premium or Free School Meals eligible"
    group_label: "Demographics"
  }

  # Attendance
  dimension: attendance_pct {
    type: number
    sql: ${TABLE}.attendance_pct ;;
    label: "Attendance %"
    description: "Attendance percentage"
    value_format_name: decimal_1
  }

  dimension: attendance_band {
    type: string
    sql: CASE
      WHEN ${attendance_pct} >= 95 THEN 'Excellent (95%+)'
      WHEN ${attendance_pct} >= 90 THEN 'Good (90-94%)'
      WHEN ${attendance_pct} >= 80 THEN 'Concern (80-89%)'
      ELSE 'Poor (<80%)'
    END ;;
    label: "Attendance Band"
    description: "Attendance grouped into bands"
  }

  # Counting measure dimension (hidden)
  dimension: enrolment_count_dim {
    type: number
    sql: ${TABLE}.enrolment_count ;;
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

  # =====================================================================
  # MEASURES
  # =====================================================================

  # Cohort Measures
  measure: cohort_count {
    type: sum
    sql: ${enrolment_count_dim} ;;
    label: "Cohort"
    description: "Total number of enrolments"
    drill_fields: [detail*]
  }

  measure: student_count {
    type: count_distinct
    sql: ${student_id} ;;
    label: "Students"
    description: "Distinct student count"
    drill_fields: [detail*]
  }

  # A-Level Grade Counts
  measure: grade_a_star_count {
    type: sum
    sql: ${is_grade_a_star_dim} ;;
    label: "A*"
    description: "Count of A* grades"
    group_label: "A-Level Grades"
    drill_fields: [detail*]
  }

  measure: grade_a_count {
    type: sum
    sql: ${is_grade_a_dim} ;;
    label: "A"
    description: "Count of A grades"
    group_label: "A-Level Grades"
    drill_fields: [detail*]
  }

  measure: grade_b_count {
    type: sum
    sql: ${is_grade_b_dim} ;;
    label: "B"
    description: "Count of B grades"
    group_label: "A-Level Grades"
    drill_fields: [detail*]
  }

  measure: grade_c_count {
    type: sum
    sql: ${is_grade_c_dim} ;;
    label: "C"
    description: "Count of C grades"
    group_label: "A-Level Grades"
    drill_fields: [detail*]
  }

  measure: grade_d_count {
    type: sum
    sql: ${is_grade_d_dim} ;;
    label: "D"
    description: "Count of D grades"
    group_label: "A-Level Grades"
    drill_fields: [detail*]
  }

  measure: grade_e_count {
    type: sum
    sql: ${is_grade_e_dim} ;;
    label: "E"
    description: "Count of E grades"
    group_label: "A-Level Grades"
    drill_fields: [detail*]
  }

  measure: grade_u_count {
    type: sum
    sql: ${is_grade_u_dim} ;;
    label: "U"
    description: "Count of U (Unclassified) grades"
    group_label: "A-Level Grades"
    drill_fields: [detail*]
  }

  # BTEC Grade Counts
  measure: grade_distinction_star_count {
    type: sum
    sql: ${is_grade_distinction_star_dim} ;;
    label: "D*"
    description: "Count of Distinction* grades"
    group_label: "BTEC Grades"
    drill_fields: [detail*]
  }

  measure: grade_distinction_count {
    type: sum
    sql: ${is_grade_distinction_dim} ;;
    label: "D (Distinction)"
    description: "Count of Distinction grades"
    group_label: "BTEC Grades"
    drill_fields: [detail*]
  }

  measure: grade_merit_count {
    type: sum
    sql: ${is_grade_merit_dim} ;;
    label: "M (Merit)"
    description: "Count of Merit grades"
    group_label: "BTEC Grades"
    drill_fields: [detail*]
  }

  measure: grade_pass_count {
    type: sum
    sql: ${is_grade_pass_dim} ;;
    label: "P (Pass)"
    description: "Count of Pass grades"
    group_label: "BTEC Grades"
    drill_fields: [detail*]
  }

  # Cumulative A-Level Grade Counts
  measure: grade_a_star_to_a_count {
    type: number
    sql: ${grade_a_star_count} + ${grade_a_count} ;;
    label: "A*-A"
    description: "Count of A* and A grades"
    group_label: "Cumulative Grades"
  }

  measure: grade_a_star_to_b_count {
    type: number
    sql: ${grade_a_star_count} + ${grade_a_count} + ${grade_b_count} ;;
    label: "A*-B"
    description: "Count of A* to B grades"
    group_label: "Cumulative Grades"
  }

  measure: grade_a_star_to_c_count {
    type: number
    sql: ${grade_a_star_count} + ${grade_a_count} + ${grade_b_count} + ${grade_c_count} ;;
    label: "A*-C"
    description: "Count of A* to C grades"
    group_label: "Cumulative Grades"
  }

  measure: grade_a_star_to_e_count {
    type: number
    sql: ${grade_a_star_count} + ${grade_a_count} + ${grade_b_count} + ${grade_c_count} + ${grade_d_count} + ${grade_e_count} ;;
    label: "A*-E (Pass)"
    description: "Count of A* to E grades (all passes)"
    group_label: "Cumulative Grades"
  }

  # High Grade and Pass Counts
  measure: high_grade_count {
    type: sum
    sql: ${is_high_grade_dim} ;;
    label: "High Grades"
    description: "Count of high grades (A*-B or D*-M)"
    drill_fields: [detail*]
  }

  measure: pass_count {
    type: sum
    sql: ${is_pass_dim} ;;
    label: "Passes"
    description: "Count of pass grades"
    drill_fields: [detail*]
  }

  # Percentage Measures
  measure: high_grade_pct {
    type: number
    sql: SAFE_DIVIDE(${high_grade_count}, ${cohort_count}) * 100 ;;
    label: "High Grade %"
    description: "Percentage of high grades (A*-B or D*-M)"
    value_format_name: decimal_1
  }

  measure: pass_rate_pct {
    type: number
    sql: SAFE_DIVIDE(${pass_count}, ${cohort_count}) * 100 ;;
    label: "Pass Rate %"
    description: "Percentage of pass grades"
    value_format_name: decimal_1
  }

  measure: a_star_to_a_pct {
    type: number
    sql: SAFE_DIVIDE(${grade_a_star_to_a_count}, ${cohort_count}) * 100 ;;
    label: "A*-A %"
    description: "Percentage of A*-A grades"
    group_label: "Grade Percentages"
    value_format_name: decimal_1
  }

  measure: a_star_to_b_pct {
    type: number
    sql: SAFE_DIVIDE(${grade_a_star_to_b_count}, ${cohort_count}) * 100 ;;
    label: "A*-B %"
    description: "Percentage of A*-B grades"
    group_label: "Grade Percentages"
    value_format_name: decimal_1
  }

  measure: a_star_to_c_pct {
    type: number
    sql: SAFE_DIVIDE(${grade_a_star_to_c_count}, ${cohort_count}) * 100 ;;
    label: "A*-C %"
    description: "Percentage of A*-C grades"
    group_label: "Grade Percentages"
    value_format_name: decimal_1
  }

  # Demographic Counts
  measure: male_count {
    type: count
    filters: [gender: "Male"]
    label: "Male"
    description: "Count of male students"
    group_label: "Demographics"
    drill_fields: [detail*]
  }

  measure: female_count {
    type: count
    filters: [gender: "Female"]
    label: "Female"
    description: "Count of female students"
    group_label: "Demographics"
    drill_fields: [detail*]
  }

  measure: disadvantaged_count {
    type: count
    filters: [is_disadvantaged: "yes"]
    label: "Disadvantaged (PP/FCM)"
    description: "Count of disadvantaged students"
    group_label: "Demographics"
    drill_fields: [detail*]
  }

  measure: send_count {
    type: count
    filters: [is_send: "yes"]
    label: "SEND"
    description: "Count of SEND students"
    group_label: "Demographics"
    drill_fields: [detail*]
  }

  # Prior Attainment Counts
  measure: prior_low_count {
    type: count
    filters: [prior_attainment_band: "Low"]
    label: "Low Prior"
    description: "Count of students with low prior attainment"
    group_label: "Prior Attainment"
    drill_fields: [detail*]
  }

  measure: prior_mid_count {
    type: count
    filters: [prior_attainment_band: "Mid"]
    label: "Mid Prior"
    description: "Count of students with mid prior attainment"
    group_label: "Prior Attainment"
    drill_fields: [detail*]
  }

  measure: prior_high_count {
    type: count
    filters: [prior_attainment_band: "High"]
    label: "High Prior"
    description: "Count of students with high prior attainment"
    group_label: "Prior Attainment"
    drill_fields: [detail*]
  }

  measure: prior_na_count {
    type: count
    filters: [prior_attainment_band: "N/A"]
    label: "N/A Prior"
    description: "Count of students with no prior attainment data"
    group_label: "Prior Attainment"
    drill_fields: [detail*]
  }

  # Average GCSE
  measure: avg_gcse_cohort {
    type: average
    sql: CASE WHEN ${average_gcse_score} > 0 THEN ${average_gcse_score} ELSE NULL END ;;
    label: "Avg GCSE (Cohort)"
    description: "Average GCSE score for cohort (excluding zeros/nulls)"
    value_format_name: decimal_2
  }

  # Attendance
  measure: avg_attendance_pct {
    type: average
    sql: ${attendance_pct} ;;
    label: "Avg Attendance %"
    description: "Average attendance percentage"
    value_format_name: decimal_1
  }
}
