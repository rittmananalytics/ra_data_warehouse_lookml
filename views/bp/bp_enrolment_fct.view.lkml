view: bp_enrolment_fct {
  sql_table_name: `ra-development.bp_analytics_bp_analytics.enrolment_fct` ;;

  # Primary Key
  dimension: enrolment_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.enrolment_pk ;;
    hidden: yes
  }

  # Foreign Keys
  dimension: student_fk {
    type: string
    sql: ${TABLE}.student_fk ;;
    hidden: yes
  }

  dimension: offering_fk {
    type: string
    sql: ${TABLE}.offering_fk ;;
    hidden: yes
  }

  dimension: academic_year_fk {
    type: string
    sql: ${TABLE}.academic_year_fk ;;
    hidden: yes
  }

  dimension: college_level_fk {
    type: string
    sql: ${TABLE}.college_level_fk ;;
    hidden: yes
  }

  dimension: completion_status_fk {
    type: string
    sql: ${TABLE}.completion_status_fk ;;
    hidden: yes
  }

  dimension: prior_attainment_fk {
    type: string
    sql: ${TABLE}.prior_attainment_fk ;;
    hidden: yes
  }

  # IDs
  dimension: enrolment_id {
    type: number
    sql: ${TABLE}.enrolment_id ;;
    label: "Enrolment ID"
  }

  dimension: completion_status_id {
    type: number
    sql: ${TABLE}.completion_status_id ;;
    hidden: yes
  }

  # Timestamps
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_ts ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.updated_ts ;;
  }

  # Student Demographics
  dimension: polar_quintile {
    type: string
    sql: ${TABLE}.polar_quintile ;;
    label: "POLAR Quintile"
    description: "Participation of Local Areas quintile - measure of disadvantage"
  }

  dimension: average_gcse_score {
    type: number
    sql: ${TABLE}.average_gcse_score ;;
    label: "Average GCSE Score"
    value_format_name: decimal_2
  }

  dimension: average_gcse_band {
    type: string
    sql: ${TABLE}.average_gcse_band ;;
    label: "Average GCSE Band"
  }

  # Student Support Indicators (Yes/No)
  dimension: has_vulnerable_bursary {
    type: yesno
    sql: ${TABLE}.has_vulnerable_bursary = 1 ;;
    label: "Has Vulnerable Bursary"
  }

  dimension: has_pupil_premium {
    type: yesno
    sql: ${TABLE}.has_pupil_premium = 1 ;;
    label: "Has Pupil Premium"
  }

  dimension: has_free_college_meals {
    type: yesno
    sql: ${TABLE}.has_free_college_meals = 1 ;;
    label: "Has Free College Meals"
  }

  dimension: has_student_support_fund {
    type: yesno
    sql: ${TABLE}.has_student_support_fund = 1 ;;
    label: "Has Student Support Fund"
  }

  dimension: is_pp_or_fcm {
    type: yesno
    sql: ${TABLE}.is_pp_or_fcm = 1 ;;
    label: "Pupil Premium or FCM"
    description: "Student has either Pupil Premium or Free College Meals"
  }

  # Student Characteristics
  dimension: is_male {
    type: yesno
    sql: ${TABLE}.is_male = 1 ;;
    label: "Is Male"
  }

  dimension: is_female {
    type: yesno
    sql: ${TABLE}.is_female = 1 ;;
    label: "Is Female"
  }

  dimension: is_ed {
    type: yesno
    sql: ${TABLE}.is_ed = 1 ;;
    label: "Educationally Disadvantaged"
    description: "Student is educationally disadvantaged"
  }

  dimension: is_in_care {
    type: yesno
    sql: ${TABLE}.is_in_care = 1 ;;
    label: "In Care"
    description: "Student is in care or care leaver"
  }

  dimension: is_young_carer {
    type: yesno
    sql: ${TABLE}.is_young_carer = 1 ;;
    label: "Young Carer"
  }

  dimension: is_service_family {
    type: yesno
    sql: ${TABLE}.is_service_family = 1 ;;
    label: "Service Family"
    description: "Student is from a service (military) family"
  }

  dimension: is_esol {
    type: yesno
    sql: ${TABLE}.is_esol = 1 ;;
    label: "ESOL Student"
    description: "English for Speakers of Other Languages"
  }

  dimension: is_southampton_school {
    type: yesno
    sql: ${TABLE}.is_southampton_school = 1 ;;
    label: "From Southampton School"
  }

  # Special Educational Needs
  dimension: has_sen {
    type: yesno
    sql: ${TABLE}.has_sen = 1 ;;
    label: "Has SEN"
    description: "Student has Special Educational Needs"
  }

  dimension: has_access_arrangements {
    type: yesno
    sql: ${TABLE}.has_access_arrangements = 1 ;;
    label: "Has Access Arrangements"
    description: "Student has exam access arrangements"
  }

  dimension: is_sen_or_aa {
    type: yesno
    sql: ${TABLE}.is_sen_or_aa = 1 ;;
    label: "SEN or Access Arrangements"
    description: "Student has SEN or Access Arrangements"
  }

  dimension: is_access_plus {
    type: yesno
    sql: ${TABLE}.is_access_plus = 1 ;;
    label: "Access Plus"
  }

  dimension: has_mental_health {
    type: yesno
    sql: ${TABLE}.has_mental_health = 1 ;;
    label: "Has Mental Health Need"
  }

  # Grade Outcomes
  dimension: final_grade {
    type: string
    sql: ${TABLE}.final_grade ;;
    label: "Final Grade"
  }

  dimension: grade_points {
    type: number
    sql: ${TABLE}.grade_points ;;
    label: "Grade Points"
  }

  dimension: is_grade_a_star {
    type: yesno
    sql: ${TABLE}.is_grade_a_star ;;
    label: "Grade A*"
  }

  dimension: is_grade_a_star_to_a {
    type: yesno
    sql: ${TABLE}.is_grade_a_star_to_a ;;
    label: "Grade A* to A"
  }

  dimension: is_grade_a_star_to_b {
    type: yesno
    sql: ${TABLE}.is_grade_a_star_to_b ;;
    label: "Grade A* to B"
  }

  dimension: is_grade_a_star_to_c {
    type: yesno
    sql: ${TABLE}.is_grade_a_star_to_c ;;
    label: "Grade A* to C"
  }

  dimension: is_grade_a_star_to_e {
    type: yesno
    sql: ${TABLE}.is_grade_a_star_to_e ;;
    label: "Grade A* to E (Pass)"
  }

  dimension: is_grade_a {
    type: yesno
    sql: ${TABLE}.is_grade_a ;;
    label: "Grade A"
  }

  dimension: is_grade_b {
    type: yesno
    sql: ${TABLE}.is_grade_b ;;
    label: "Grade B"
  }

  dimension: is_grade_c {
    type: yesno
    sql: ${TABLE}.is_grade_c ;;
    label: "Grade C"
  }

  dimension: is_grade_d {
    type: yesno
    sql: ${TABLE}.is_grade_d ;;
    label: "Grade D"
  }

  dimension: is_grade_e {
    type: yesno
    sql: ${TABLE}.is_grade_e ;;
    label: "Grade E"
  }

  dimension: is_grade_u {
    type: yesno
    sql: ${TABLE}.is_grade_u ;;
    label: "Grade U (Unclassified)"
  }

  dimension: is_grade_x {
    type: yesno
    sql: ${TABLE}.is_grade_x ;;
    label: "Grade X (No Result)"
  }

  dimension: completion_status {
    type: string
    sql: ${TABLE}.completion_status ;;
    label: "Completion Status"
  }

  # Counts for aggregation
  dimension: cohort_count {
    type: number
    sql: ${TABLE}.cohort_count ;;
    hidden: yes
  }

  dimension: completer_count {
    type: number
    sql: ${TABLE}.completer_count ;;
    hidden: yes
  }

  # Measures
  measure: total_enrolments {
    type: count_distinct
    sql: ${enrolment_pk} ;;
    label: "Total Enrolments"
    drill_fields: [enrolment_id, final_grade, completion_status]
  }

  measure: total_cohort {
    type: sum
    sql: ${cohort_count} ;;
    label: "Total Cohort"
    description: "Sum of cohort count"
  }

  measure: total_completers {
    type: sum
    sql: ${completer_count} ;;
    label: "Total Completers"
    description: "Students who completed their course"
  }

  measure: completion_rate {
    type: number
    sql: SAFE_DIVIDE(${total_completers}, ${total_cohort}) ;;
    label: "Completion Rate"
    value_format_name: percent_2
  }

  measure: average_grade_points {
    type: average
    sql: ${grade_points} ;;
    label: "Average Grade Points"
    value_format_name: decimal_2
  }

  measure: average_gcse_score_measure {
    type: average
    sql: ${average_gcse_score} ;;
    label: "Average GCSE Score"
    value_format_name: decimal_2
  }

  # Student Support Measures
  measure: count_vulnerable_bursary {
    type: count
    filters: [has_vulnerable_bursary: "yes"]
    label: "Students with Vulnerable Bursary"
  }

  measure: count_pupil_premium {
    type: count
    filters: [has_pupil_premium: "yes"]
    label: "Students with Pupil Premium"
  }

  measure: count_free_college_meals {
    type: count
    filters: [has_free_college_meals: "yes"]
    label: "Students with Free College Meals"
  }

  measure: count_pp_or_fcm {
    type: count
    filters: [is_pp_or_fcm: "yes"]
    label: "Students with PP or FCM"
  }

  measure: percent_pp_or_fcm {
    type: number
    sql: SAFE_DIVIDE(${count_pp_or_fcm}, ${total_enrolments}) ;;
    label: "% PP or FCM"
    value_format_name: percent_1
  }

  # Gender Measures
  measure: count_male {
    type: count
    filters: [is_male: "yes"]
    label: "Male Students"
  }

  measure: count_female {
    type: count
    filters: [is_female: "yes"]
    label: "Female Students"
  }

  measure: percent_male {
    type: number
    sql: SAFE_DIVIDE(${count_male}, ${total_enrolments}) ;;
    label: "% Male"
    value_format_name: percent_1
  }

  measure: percent_female {
    type: number
    sql: SAFE_DIVIDE(${count_female}, ${total_enrolments}) ;;
    label: "% Female"
    value_format_name: percent_1
  }

  # SEN Measures
  measure: count_sen {
    type: count
    filters: [has_sen: "yes"]
    label: "Students with SEN"
  }

  measure: count_access_arrangements {
    type: count
    filters: [has_access_arrangements: "yes"]
    label: "Students with Access Arrangements"
  }

  measure: count_sen_or_aa {
    type: count
    filters: [is_sen_or_aa: "yes"]
    label: "Students with SEN or AA"
  }

  measure: percent_sen_or_aa {
    type: number
    sql: SAFE_DIVIDE(${count_sen_or_aa}, ${total_enrolments}) ;;
    label: "% SEN or AA"
    value_format_name: percent_1
  }

  # Disadvantage Measures
  measure: count_educationally_disadvantaged {
    type: count
    filters: [is_ed: "yes"]
    label: "Educationally Disadvantaged Students"
  }

  measure: percent_educationally_disadvantaged {
    type: number
    sql: SAFE_DIVIDE(${count_educationally_disadvantaged}, ${total_enrolments}) ;;
    label: "% Educationally Disadvantaged"
    value_format_name: percent_1
  }

  # Grade Performance Measures
  measure: count_grade_a_star_to_c {
    type: count
    filters: [is_grade_a_star_to_c: "yes"]
    label: "High Grades (A*-C)"
  }

  measure: percent_high_grades {
    type: number
    sql: SAFE_DIVIDE(${count_grade_a_star_to_c}, ${total_enrolments}) ;;
    label: "% High Grades (A*-C)"
    value_format_name: percent_1
  }

  measure: count_pass_grades {
    type: count
    filters: [is_grade_a_star_to_e: "yes"]
    label: "Pass Grades (A*-E)"
  }

  measure: pass_rate {
    type: number
    sql: SAFE_DIVIDE(${count_pass_grades}, ${total_enrolments}) ;;
    label: "Pass Rate"
    value_format_name: percent_1
  }
}
