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

  # =====================================================================
  # COMPLETION RATE MEASURES
  # =====================================================================

  measure: completed_count {
    type: count
    filters: [is_completed: "yes"]
    label: "Completed"
    description: "Count of completed enrolments"
    group_label: "Completion"
    drill_fields: [detail*]
  }

  measure: completion_rate_pct {
    type: number
    sql: SAFE_DIVIDE(${completed_count}, ${cohort_count}) * 100 ;;
    label: "Completion Rate %"
    description: "Percentage of enrolments completed"
    group_label: "Completion"
    value_format_name: decimal_1
  }

  # =====================================================================
  # GRADE POINTS MEASURES (via dim_grade join)
  # =====================================================================

  measure: avg_grade_points {
    type: average
    sql: ${dim_grade.grade_points} ;;
    label: "Avg Grade Points"
    description: "Average grade points (requires dim_grade join)"
    value_format_name: decimal_2
  }

  measure: total_grade_points {
    type: sum
    sql: ${dim_grade.grade_points} ;;
    label: "Total Grade Points"
    description: "Sum of grade points (requires dim_grade join)"
  }

  measure: avg_ucas_points {
    type: average
    sql: ${dim_grade.ucas_points} ;;
    label: "Avg UCAS Points"
    description: "Average UCAS tariff points (requires dim_grade join)"
    value_format_name: decimal_1
  }

  # =====================================================================
  # A*-E PERCENTAGE (missing from original)
  # =====================================================================

  measure: a_star_to_e_pct {
    type: number
    sql: SAFE_DIVIDE(${grade_a_star_to_e_count}, ${cohort_count}) * 100 ;;
    label: "A*-E % (Pass)"
    description: "Percentage of A*-E grades (all passes)"
    group_label: "Grade Percentages"
    value_format_name: decimal_1
  }

  # =====================================================================
  # GENDER-SPECIFIC MEASURES
  # =====================================================================

  # Female measures
  measure: female_pass_count {
    type: sum
    sql: CASE WHEN ${gender} = 'Female' THEN ${is_pass_dim} ELSE 0 END ;;
    label: "Female Passes"
    description: "Count of female pass grades"
    group_label: "Gender Analysis"
  }

  measure: female_high_grade_count {
    type: sum
    sql: CASE WHEN ${gender} = 'Female' THEN ${is_high_grade_dim} ELSE 0 END ;;
    label: "Female High Grades"
    description: "Count of female high grades"
    group_label: "Gender Analysis"
  }

  measure: female_pass_rate_pct {
    type: number
    sql: SAFE_DIVIDE(${female_pass_count}, ${female_count}) * 100 ;;
    label: "Female Pass Rate %"
    description: "Pass rate for female students"
    group_label: "Gender Analysis"
    value_format_name: decimal_1
  }

  measure: female_high_grade_pct {
    type: number
    sql: SAFE_DIVIDE(${female_high_grade_count}, ${female_count}) * 100 ;;
    label: "Female High Grade %"
    description: "High grade rate for female students"
    group_label: "Gender Analysis"
    value_format_name: decimal_1
  }

  # Male measures
  measure: male_pass_count {
    type: sum
    sql: CASE WHEN ${gender} = 'Male' THEN ${is_pass_dim} ELSE 0 END ;;
    label: "Male Passes"
    description: "Count of male pass grades"
    group_label: "Gender Analysis"
  }

  measure: male_high_grade_count {
    type: sum
    sql: CASE WHEN ${gender} = 'Male' THEN ${is_high_grade_dim} ELSE 0 END ;;
    label: "Male High Grades"
    description: "Count of male high grades"
    group_label: "Gender Analysis"
  }

  measure: male_pass_rate_pct {
    type: number
    sql: SAFE_DIVIDE(${male_pass_count}, ${male_count}) * 100 ;;
    label: "Male Pass Rate %"
    description: "Pass rate for male students"
    group_label: "Gender Analysis"
    value_format_name: decimal_1
  }

  measure: male_high_grade_pct {
    type: number
    sql: SAFE_DIVIDE(${male_high_grade_count}, ${male_count}) * 100 ;;
    label: "Male High Grade %"
    description: "High grade rate for male students"
    group_label: "Gender Analysis"
    value_format_name: decimal_1
  }

  # Gender gap measures
  measure: gender_gap_pass_pp {
    type: number
    sql: ${female_pass_rate_pct} - ${male_pass_rate_pct} ;;
    label: "Gender Gap (Pass) pp"
    description: "Gender gap in pass rate (Female - Male, positive = female outperforming)"
    group_label: "Gender Analysis"
    value_format_name: decimal_1
  }

  measure: gender_gap_high_grade_pp {
    type: number
    sql: ${female_high_grade_pct} - ${male_high_grade_pct} ;;
    label: "Gender Gap (High Grade) pp"
    description: "Gender gap in high grades (Female - Male, positive = female outperforming)"
    group_label: "Gender Analysis"
    value_format_name: decimal_1
  }

  # =====================================================================
  # DISADVANTAGE-SPECIFIC MEASURES
  # =====================================================================

  measure: non_disadvantaged_count {
    type: count
    filters: [is_disadvantaged: "no"]
    label: "Non-Disadvantaged"
    description: "Count of non-disadvantaged students"
    group_label: "Disadvantage Analysis"
  }

  measure: disadvantaged_pass_count {
    type: sum
    sql: CASE WHEN (${TABLE}.is_free_meals OR ${TABLE}.is_bursary) THEN ${is_pass_dim} ELSE 0 END ;;
    label: "Disadvantaged Passes"
    description: "Count of disadvantaged student passes"
    group_label: "Disadvantage Analysis"
  }

  measure: non_disadvantaged_pass_count {
    type: sum
    sql: CASE WHEN NOT (${TABLE}.is_free_meals OR ${TABLE}.is_bursary) THEN ${is_pass_dim} ELSE 0 END ;;
    label: "Non-Disadvantaged Passes"
    description: "Count of non-disadvantaged student passes"
    group_label: "Disadvantage Analysis"
  }

  measure: disadvantaged_pass_rate_pct {
    type: number
    sql: SAFE_DIVIDE(${disadvantaged_pass_count}, ${disadvantaged_count}) * 100 ;;
    label: "Disadvantaged Pass Rate %"
    description: "Pass rate for disadvantaged students"
    group_label: "Disadvantage Analysis"
    value_format_name: decimal_1
  }

  measure: non_disadvantaged_pass_rate_pct {
    type: number
    sql: SAFE_DIVIDE(${non_disadvantaged_pass_count}, ${non_disadvantaged_count}) * 100 ;;
    label: "Non-Disadvantaged Pass Rate %"
    description: "Pass rate for non-disadvantaged students"
    group_label: "Disadvantage Analysis"
    value_format_name: decimal_1
  }

  measure: disadvantaged_high_grade_count {
    type: sum
    sql: CASE WHEN (${TABLE}.is_free_meals OR ${TABLE}.is_bursary) THEN ${is_high_grade_dim} ELSE 0 END ;;
    label: "Disadvantaged High Grades"
    group_label: "Disadvantage Analysis"
  }

  measure: non_disadvantaged_high_grade_count {
    type: sum
    sql: CASE WHEN NOT (${TABLE}.is_free_meals OR ${TABLE}.is_bursary) THEN ${is_high_grade_dim} ELSE 0 END ;;
    label: "Non-Disadvantaged High Grades"
    group_label: "Disadvantage Analysis"
  }

  measure: disadvantaged_high_grade_pct {
    type: number
    sql: SAFE_DIVIDE(${disadvantaged_high_grade_count}, ${disadvantaged_count}) * 100 ;;
    label: "Disadvantaged High Grade %"
    group_label: "Disadvantage Analysis"
    value_format_name: decimal_1
  }

  measure: non_disadvantaged_high_grade_pct {
    type: number
    sql: SAFE_DIVIDE(${non_disadvantaged_high_grade_count}, ${non_disadvantaged_count}) * 100 ;;
    label: "Non-Disadvantaged High Grade %"
    group_label: "Disadvantage Analysis"
    value_format_name: decimal_1
  }

  measure: disadvantage_gap_pass_pp {
    type: number
    sql: ${non_disadvantaged_pass_rate_pct} - ${disadvantaged_pass_rate_pct} ;;
    label: "Disadvantage Gap (Pass) pp"
    description: "Gap in pass rate (Non-PP minus PP, positive = gap exists)"
    group_label: "Disadvantage Analysis"
    value_format_name: decimal_1
  }

  measure: disadvantage_gap_high_grade_pp {
    type: number
    sql: ${non_disadvantaged_high_grade_pct} - ${disadvantaged_high_grade_pct} ;;
    label: "Disadvantage Gap (High Grade) pp"
    description: "Gap in high grade rate (Non-PP minus PP)"
    group_label: "Disadvantage Analysis"
    value_format_name: decimal_1
  }

  # =====================================================================
  # SEND-SPECIFIC MEASURES
  # =====================================================================

  measure: non_send_count {
    type: count
    filters: [is_send: "no"]
    label: "Non-SEND"
    description: "Count of non-SEND students"
    group_label: "SEND Analysis"
  }

  measure: send_pass_count {
    type: sum
    sql: CASE WHEN ${TABLE}.is_send THEN ${is_pass_dim} ELSE 0 END ;;
    label: "SEND Passes"
    group_label: "SEND Analysis"
  }

  measure: non_send_pass_count {
    type: sum
    sql: CASE WHEN NOT ${TABLE}.is_send THEN ${is_pass_dim} ELSE 0 END ;;
    label: "Non-SEND Passes"
    group_label: "SEND Analysis"
  }

  measure: send_pass_rate_pct {
    type: number
    sql: SAFE_DIVIDE(${send_pass_count}, ${send_count}) * 100 ;;
    label: "SEND Pass Rate %"
    group_label: "SEND Analysis"
    value_format_name: decimal_1
  }

  measure: non_send_pass_rate_pct {
    type: number
    sql: SAFE_DIVIDE(${non_send_pass_count}, ${non_send_count}) * 100 ;;
    label: "Non-SEND Pass Rate %"
    group_label: "SEND Analysis"
    value_format_name: decimal_1
  }

  measure: send_high_grade_count {
    type: sum
    sql: CASE WHEN ${TABLE}.is_send THEN ${is_high_grade_dim} ELSE 0 END ;;
    label: "SEND High Grades"
    group_label: "SEND Analysis"
  }

  measure: non_send_high_grade_count {
    type: sum
    sql: CASE WHEN NOT ${TABLE}.is_send THEN ${is_high_grade_dim} ELSE 0 END ;;
    label: "Non-SEND High Grades"
    group_label: "SEND Analysis"
  }

  measure: send_high_grade_pct {
    type: number
    sql: SAFE_DIVIDE(${send_high_grade_count}, ${send_count}) * 100 ;;
    label: "SEND High Grade %"
    group_label: "SEND Analysis"
    value_format_name: decimal_1
  }

  measure: non_send_high_grade_pct {
    type: number
    sql: SAFE_DIVIDE(${non_send_high_grade_count}, ${non_send_count}) * 100 ;;
    label: "Non-SEND High Grade %"
    group_label: "SEND Analysis"
    value_format_name: decimal_1
  }

  measure: send_gap_pass_pp {
    type: number
    sql: ${non_send_pass_rate_pct} - ${send_pass_rate_pct} ;;
    label: "SEND Gap (Pass) pp"
    description: "Gap in pass rate (Non-SEND minus SEND)"
    group_label: "SEND Analysis"
    value_format_name: decimal_1
  }

  measure: send_gap_high_grade_pp {
    type: number
    sql: ${non_send_high_grade_pct} - ${send_high_grade_pct} ;;
    label: "SEND Gap (High Grade) pp"
    group_label: "SEND Analysis"
    value_format_name: decimal_1
  }

  # =====================================================================
  # ETHNICITY GAP MEASURES
  # Note: Ethnicity gap analysis should be done by grouping by ethnicity
  # dimension and comparing pass_rate_pct across groups. The max/min
  # ethnicity gap requires a derived table or table calculation in Looker.
  # =====================================================================

  # These are placeholder dimensions to indicate ethnicity analysis is supported
  # The actual max/min gap calculation should be done via:
  # 1. A Looker table calculation on pass_rate_pct grouped by ethnicity
  # 2. Or a derived table that pre-calculates ethnicity gaps

  # =====================================================================
  # GAP VS OVERALL MEASURES
  # =====================================================================

  measure: gap_vs_overall_pass_pp {
    type: number
    sql: ${pass_rate_pct} - (SELECT SAFE_DIVIDE(SUM(is_pass), COUNT(*)) * 100 FROM ${fct_enrolment.SQL_TABLE_NAME}) ;;
    label: "Gap vs Overall (Pass) pp"
    description: "Current group pass rate minus overall pass rate"
    group_label: "Gap Analysis"
    value_format_name: decimal_1
  }

  measure: gap_vs_overall_high_grade_pp {
    type: number
    sql: ${high_grade_pct} - (SELECT SAFE_DIVIDE(SUM(is_high_grade), COUNT(*)) * 100 FROM ${fct_enrolment.SQL_TABLE_NAME}) ;;
    label: "Gap vs Overall (High Grade) pp"
    description: "Current group high grade rate minus overall rate"
    group_label: "Gap Analysis"
    value_format_name: decimal_1
  }
}
