view: bp_course_summary_by_year_agg {
  sql_table_name: `ra-development.bp_analytics_bp_analytics.course_summary_by_year_agg` ;;

  # Foreign Keys
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

  # IDs
  dimension: academic_year_id {
    type: string
    sql: ${TABLE}.academic_year_id ;;
    label: "Academic Year ID"
  }

  dimension: qual_id {
    type: string
    sql: ${TABLE}.qual_id ;;
    label: "Qualification ID"
  }

  # Course Details
  dimension: offering_code {
    type: string
    sql: ${TABLE}.offering_code ;;
    label: "Offering Code"
  }

  dimension: offering_name {
    type: string
    sql: ${TABLE}.offering_name ;;
    label: "Offering Name"
  }

  dimension: learning_aim_title {
    type: string
    sql: ${TABLE}.learning_aim_title ;;
    label: "Learning Aim Title"
  }

  dimension: college_level_name {
    type: string
    sql: ${TABLE}.college_level_name ;;
    label: "College Level"
  }

  # Cohort Metrics
  dimension: total_cohort {
    type: number
    sql: ${TABLE}.total_cohort ;;
    label: "Total Cohort"
  }

  dimension: total_completers {
    type: number
    sql: ${TABLE}.total_completers ;;
    label: "Total Completers"
  }

  dimension: completion_rate {
    type: number
    sql: ${TABLE}.completion_rate ;;
    label: "Completion Rate"
    value_format_name: percent_2
  }

  dimension: pass_count {
    type: number
    sql: ${TABLE}.pass_count ;;
    label: "Pass Count"
  }

  dimension: pass_rate {
    type: number
    sql: ${TABLE}.pass_rate ;;
    label: "Pass Rate"
    value_format_name: percent_2
  }

  # Grade Counts
  dimension: grade_a_star_count {
    type: number
    sql: ${TABLE}.grade_a_star_count ;;
    label: "Grade A* Count"
  }

  dimension: grade_a_count {
    type: number
    sql: ${TABLE}.grade_a_count ;;
    label: "Grade A Count"
  }

  dimension: grade_b_count {
    type: number
    sql: ${TABLE}.grade_b_count ;;
    label: "Grade B Count"
  }

  dimension: grade_c_count {
    type: number
    sql: ${TABLE}.grade_c_count ;;
    label: "Grade C Count"
  }

  dimension: grade_d_count {
    type: number
    sql: ${TABLE}.grade_d_count ;;
    label: "Grade D Count"
  }

  dimension: grade_e_count {
    type: number
    sql: ${TABLE}.grade_e_count ;;
    label: "Grade E Count"
  }

  dimension: grade_u_count {
    type: number
    sql: ${TABLE}.grade_u_count ;;
    label: "Grade U Count"
  }

  dimension: high_grades_count {
    type: number
    sql: ${TABLE}.high_grades_count ;;
    label: "High Grades Count (A*-C)"
  }

  dimension: high_grades_percent {
    type: number
    sql: ${TABLE}.high_grades_percent ;;
    label: "High Grades %"
    value_format_name: percent_2
  }

  # Performance Metrics
  dimension: avg_grade_points {
    type: number
    sql: ${TABLE}.avg_grade_points ;;
    label: "Average Grade Points"
    value_format_name: decimal_2
  }

  dimension: avg_gcse_score {
    type: number
    sql: ${TABLE}.avg_gcse_score ;;
    label: "Average GCSE Score"
    value_format_name: decimal_2
  }

  # Demographics
  dimension: male_count {
    type: number
    sql: ${TABLE}.male_count ;;
    label: "Male Count"
  }

  dimension: female_count {
    type: number
    sql: ${TABLE}.female_count ;;
    label: "Female Count"
  }

  dimension: pp_fcm_count {
    type: number
    sql: ${TABLE}.pp_fcm_count ;;
    label: "PP/FCM Count"
    description: "Pupil Premium or Free College Meals"
  }

  dimension: ed_count {
    type: number
    sql: ${TABLE}.ed_count ;;
    label: "Educationally Disadvantaged Count"
  }

  dimension: sen_aa_count {
    type: number
    sql: ${TABLE}.sen_aa_count ;;
    label: "SEN/AA Count"
    description: "Special Educational Needs or Access Arrangements"
  }

  dimension: access_plus_count {
    type: number
    sql: ${TABLE}.access_plus_count ;;
    label: "Access Plus Count"
  }

  # Prior Attainment
  dimension: pa_low_count {
    type: number
    sql: ${TABLE}.pa_low_count ;;
    label: "Low Prior Attainment Count"
  }

  dimension: pa_mid_count {
    type: number
    sql: ${TABLE}.pa_mid_count ;;
    label: "Mid Prior Attainment Count"
  }

  dimension: pa_high_count {
    type: number
    sql: ${TABLE}.pa_high_count ;;
    label: "High Prior Attainment Count"
  }

  dimension: pa_na_count {
    type: number
    sql: ${TABLE}.pa_na_count ;;
    label: "Prior Attainment N/A Count"
  }

  # Timestamps
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_ts ;;
  }

  # Measures
  measure: total_courses {
    type: count
    label: "Total Courses"
    drill_fields: [offering_name, college_level_name, total_cohort, completion_rate, pass_rate]
  }

  measure: sum_total_cohort {
    type: sum
    sql: ${total_cohort} ;;
    label: "Total Students"
  }

  measure: sum_total_completers {
    type: sum
    sql: ${total_completers} ;;
    label: "Total Completers"
  }

  measure: sum_pass_count {
    type: sum
    sql: ${pass_count} ;;
    label: "Total Passes"
  }

  measure: average_completion_rate {
    type: average
    sql: ${completion_rate} ;;
    label: "Average Completion Rate"
    value_format_name: percent_2
  }

  measure: average_pass_rate {
    type: average
    sql: ${pass_rate} ;;
    label: "Average Pass Rate"
    value_format_name: percent_2
  }

  measure: average_high_grades_percent {
    type: average
    sql: ${high_grades_percent} ;;
    label: "Average High Grades %"
    value_format_name: percent_2
  }

  measure: sum_high_grades_count {
    type: sum
    sql: ${high_grades_count} ;;
    label: "Total High Grades (A*-C)"
  }

  measure: sum_male_count {
    type: sum
    sql: ${male_count} ;;
    label: "Total Male Students"
  }

  measure: sum_female_count {
    type: sum
    sql: ${female_count} ;;
    label: "Total Female Students"
  }

  measure: sum_pp_fcm_count {
    type: sum
    sql: ${pp_fcm_count} ;;
    label: "Total PP/FCM Students"
  }

  measure: sum_sen_aa_count {
    type: sum
    sql: ${sen_aa_count} ;;
    label: "Total SEN/AA Students"
  }

  measure: overall_completion_rate {
    type: number
    sql: SAFE_DIVIDE(${sum_total_completers}, ${sum_total_cohort}) ;;
    label: "Overall Completion Rate"
    value_format_name: percent_2
  }

  measure: overall_pass_rate {
    type: number
    sql: SAFE_DIVIDE(${sum_pass_count}, ${sum_total_cohort}) ;;
    label: "Overall Pass Rate"
    value_format_name: percent_2
  }

  measure: overall_high_grades_percent {
    type: number
    sql: SAFE_DIVIDE(${sum_high_grades_count}, ${sum_total_cohort}) ;;
    label: "Overall High Grades %"
    value_format_name: percent_2
  }
}
