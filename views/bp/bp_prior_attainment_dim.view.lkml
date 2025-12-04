view: bp_prior_attainment_dim {
  sql_table_name: `ra-development.bp_analytics_bp_analytics.prior_attainment_dim` ;;

  # Primary Key
  dimension: prior_attainment_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.prior_attainment_pk ;;
    hidden: yes
  }

  # Foreign Keys
  dimension: student_fk {
    type: string
    sql: ${TABLE}.student_fk ;;
    hidden: yes
  }

  # GCSE Scores
  dimension: average_gcse_score {
    type: number
    sql: ${TABLE}.average_gcse_score ;;
    label: "Average GCSE Score"
    value_format_name: decimal_2
  }

  dimension: maths_gcse {
    type: number
    sql: ${TABLE}.maths_gcse ;;
    label: "Maths GCSE"
    value_format_name: decimal_1
  }

  dimension: english_gcse {
    type: number
    sql: ${TABLE}.english_gcse ;;
    label: "English GCSE"
    value_format_name: decimal_1
  }

  dimension: has_gcse_score {
    type: yesno
    sql: ${TABLE}.has_gcse_score ;;
    label: "Has GCSE Score"
  }

  # Prior Attainment Band
  dimension: prior_attainment_band {
    type: string
    sql: ${TABLE}.prior_attainment_band ;;
    label: "Prior Attainment Band"
  }

  dimension: is_low_prior_attainment {
    type: yesno
    sql: ${TABLE}.is_low_prior_attainment ;;
    label: "Low Prior Attainment"
  }

  dimension: is_mid_prior_attainment {
    type: yesno
    sql: ${TABLE}.is_mid_prior_attainment ;;
    label: "Mid Prior Attainment"
  }

  dimension: is_high_prior_attainment {
    type: yesno
    sql: ${TABLE}.is_high_prior_attainment ;;
    label: "High Prior Attainment"
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

  # Measures
  measure: total_records {
    type: count
    label: "Total Prior Attainment Records"
  }

  measure: average_gcse_score_measure {
    type: average
    sql: ${average_gcse_score} ;;
    label: "Average GCSE Score"
    value_format_name: decimal_2
  }

  measure: average_maths_gcse {
    type: average
    sql: ${maths_gcse} ;;
    label: "Average Maths GCSE"
    value_format_name: decimal_2
  }

  measure: average_english_gcse {
    type: average
    sql: ${english_gcse} ;;
    label: "Average English GCSE"
    value_format_name: decimal_2
  }

  measure: count_low_attainment {
    type: count
    filters: [is_low_prior_attainment: "yes"]
    label: "Low Prior Attainment"
  }

  measure: count_mid_attainment {
    type: count
    filters: [is_mid_prior_attainment: "yes"]
    label: "Mid Prior Attainment"
  }

  measure: count_high_attainment {
    type: count
    filters: [is_high_prior_attainment: "yes"]
    label: "High Prior Attainment"
  }

  measure: percent_low_attainment {
    type: number
    sql: SAFE_DIVIDE(${count_low_attainment}, ${total_records}) ;;
    label: "% Low Prior Attainment"
    value_format_name: percent_1
  }

  measure: percent_high_attainment {
    type: number
    sql: SAFE_DIVIDE(${count_high_attainment}, ${total_records}) ;;
    label: "% High Prior Attainment"
    value_format_name: percent_1
  }
}
