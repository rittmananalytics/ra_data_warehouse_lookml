view: bp_student_dim {
  sql_table_name: `ra-development.bp_analytics_bp_analytics.student_dim` ;;

  # Primary Key
  dimension: student_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.student_pk ;;
    hidden: yes
  }

  # IDs
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

  dimension: student_ref_no {
    type: string
    sql: ${TABLE}.student_ref_no ;;
    label: "Student Reference Number"
  }

  dimension: unique_learner_no {
    type: string
    sql: ${TABLE}.unique_learner_no ;;
    label: "Unique Learner Number (ULN)"
  }

  # Foreign Keys
  dimension: academic_year_fk {
    type: string
    sql: ${TABLE}.academic_year_fk ;;
    hidden: yes
  }

  # Personal Details
  dimension: first_forename {
    type: string
    sql: ${TABLE}.first_forename ;;
    label: "First Name"
  }

  dimension: surname {
    type: string
    sql: ${TABLE}.surname ;;
    label: "Surname"
  }

  dimension: full_name {
    type: string
    sql: CONCAT(${first_forename}, ' ', ${surname}) ;;
    label: "Full Name"
  }

  dimension: sex {
    type: string
    sql: ${TABLE}.sex ;;
    label: "Gender"
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

  # Validity Period
  dimension_group: valid_from {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.valid_from ;;
  }

  dimension_group: valid_to {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.valid_to ;;
  }

  dimension: is_current {
    type: yesno
    sql: ${TABLE}.is_current ;;
    label: "Is Current Record"
  }

  # Academic Details
  dimension: academic_year_id {
    type: string
    sql: ${TABLE}.academic_year_id ;;
    label: "Academic Year ID"
  }

  dimension: first_enrolment_year {
    type: string
    sql: ${TABLE}.first_enrolment_year ;;
    label: "First Enrolment Year"
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

  # Demographics
  dimension: ethnic_group_id {
    type: string
    sql: ${TABLE}.ethnic_group_id ;;
    hidden: yes
  }

  dimension: ethnic_group {
    type: string
    sql: ${TABLE}.ethnic_group ;;
    label: "Ethnic Group"
  }

  dimension: is_ethnically_diverse {
    type: yesno
    sql: ${TABLE}.is_ethnically_diverse ;;
    label: "Ethnically Diverse"
  }

  dimension: polar_quintile {
    type: string
    sql: ${TABLE}.polar_quintile ;;
    label: "POLAR Quintile"
    description: "Participation of Local Areas quintile"
  }

  # School Information
  dimension: school_id {
    type: number
    sql: ${TABLE}.school_id ;;
    hidden: yes
  }

  dimension: school_name {
    type: string
    sql: ${TABLE}.school_name ;;
    label: "Previous School"
  }

  dimension: is_southampton_school {
    type: yesno
    sql: ${TABLE}.is_southampton_school ;;
    label: "From Southampton School"
  }

  # Support and Disadvantage Indicators
  dimension: has_bursary {
    type: yesno
    sql: ${TABLE}.has_bursary ;;
    label: "Has Bursary"
  }

  dimension: has_vulnerable_bursary {
    type: yesno
    sql: ${TABLE}.has_vulnerable_bursary ;;
    label: "Has Vulnerable Bursary"
  }

  dimension: has_pupil_premium {
    type: yesno
    sql: ${TABLE}.has_pupil_premium ;;
    label: "Has Pupil Premium"
  }

  dimension: has_free_college_meals {
    type: yesno
    sql: ${TABLE}.has_free_college_meals ;;
    label: "Has Free College Meals"
  }

  dimension: is_pupil_premium_or_fcm {
    type: yesno
    sql: ${TABLE}.is_pupil_premium_or_fcm ;;
    label: "Pupil Premium or FCM"
  }

  dimension: has_student_support_fund {
    type: yesno
    sql: ${TABLE}.has_student_support_fund ;;
    label: "Has Student Support Fund"
  }

  # Special Educational Needs
  dimension: has_sen {
    type: yesno
    sql: ${TABLE}.has_sen ;;
    label: "Has SEN"
    description: "Special Educational Needs"
  }

  dimension: has_access_arrangements {
    type: yesno
    sql: ${TABLE}.has_access_arrangements ;;
    label: "Has Access Arrangements"
  }

  dimension: is_sen_plus_aa {
    type: yesno
    sql: ${TABLE}.is_sen_plus_aa ;;
    label: "SEN Plus Access Arrangements"
  }

  dimension: is_access_plus {
    type: yesno
    sql: ${TABLE}.is_access_plus ;;
    label: "Access Plus"
  }

  dimension: has_learning_difficulty {
    type: yesno
    sql: ${TABLE}.has_learning_difficulty ;;
    label: "Has Learning Difficulty"
  }

  dimension: has_health_problem {
    type: yesno
    sql: ${TABLE}.has_health_problem ;;
    label: "Has Health Problem"
  }

  dimension: has_mental_health_condition {
    type: yesno
    sql: ${TABLE}.has_mental_health_condition ;;
    label: "Has Mental Health Condition"
  }

  # Family and Background
  dimension: is_in_care_or_leaver {
    type: yesno
    sql: ${TABLE}.is_in_care_or_leaver ;;
    label: "In Care or Leaver"
  }

  dimension: is_service_family {
    type: yesno
    sql: ${TABLE}.is_service_family ;;
    label: "Service Family"
  }

  dimension: has_parents_attended_university {
    type: yesno
    sql: ${TABLE}.has_parents_attended_university ;;
    label: "Parents Attended University"
  }

  # Language
  dimension: is_first_language_not_english {
    type: yesno
    sql: ${TABLE}.is_first_language_not_english ;;
    label: "First Language Not English"
  }

  dimension: is_educationally_disadvantaged {
    type: yesno
    sql: ${TABLE}.is_educationally_disadvantaged ;;
    label: "Educationally Disadvantaged"
  }

  # Staff Assignment
  dimension: spa_staff_id {
    type: number
    sql: ${TABLE}.spa_staff_id ;;
    label: "SPA Staff ID"
  }

  # Measures
  measure: total_students {
    type: count
    label: "Total Students"
    drill_fields: [student_ref_no, full_name, sex, ethnic_group, school_name]
  }

  measure: count_current_students {
    type: count
    filters: [is_current: "yes"]
    label: "Current Students"
  }

  measure: count_ethnically_diverse {
    type: count
    filters: [is_ethnically_diverse: "yes"]
    label: "Ethnically Diverse Students"
  }

  measure: count_with_sen {
    type: count
    filters: [has_sen: "yes"]
    label: "Students with SEN"
  }

  measure: count_pupil_premium {
    type: count
    filters: [has_pupil_premium: "yes"]
    label: "Students with Pupil Premium"
  }

  measure: average_gcse_score_measure {
    type: average
    sql: ${average_gcse_score} ;;
    label: "Average GCSE Score"
    value_format_name: decimal_2
  }
}
