view: hr_survey_results_fact {
  derived_table: {
    sql: SELECT * FROM `ra-development.analytics.hr_survey_results_fact`
      ;;
  }



  dimension: survey_pk {
    type: string
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.survey_pk ;;
  }



  dimension_group: survey_ts {
    label: "Survey"
    type: time
    timeframes: [week,month,quarter,year]
    datatype: timestamp
    sql: timestamp(${TABLE}.survey_ts) ;;
  }

  dimension: engagement_score {
    hidden: yes
    type: number
    sql: ${TABLE}.engagement_score ;;
  }

  dimension: overall_participation_score {
    hidden: yes

    type: number
    sql: ${TABLE}.overall_participation_score ;;
  }

  dimension: e_nps {
    hidden: yes

    type: number
    sql: ${TABLE}.e_nps ;;
  }

  dimension: overall_recognition_score {
    hidden: yes

    type: number
    sql: ${TABLE}.overall_recognition_score ;;
  }

  dimension: overall_ambassadorship_score {
    hidden: yes

    type: number
    sql: ${TABLE}.overall_ambassadorship_score ;;
  }

  dimension: overall_feedback_score {
    hidden: yes

    type: number
    sql: ${TABLE}.overall_feedback_score ;;
  }

  dimension: relationship_with_peers_score {
    hidden: yes

    type: number
    sql: ${TABLE}.relationship_with_peers_score ;;
  }

  dimension: relationship_with_manager_score {
    hidden: yes

    type: number
    sql: ${TABLE}.relationship_with_manager_score ;;
  }

  dimension: overall_satisfaction_score {
    hidden: yes

    type: number
    sql: ${TABLE}.overall_satisfaction_score ;;
  }

  dimension: overall_alignment_score {
    hidden: yes

    type: number
    sql: ${TABLE}.overall_alignment_score ;;
  }

  dimension: overall_happiness_score {
    hidden: yes

    type: number
    sql: ${TABLE}.overall_happiness_score ;;
  }

  dimension: overall_wellness_score {
    hidden: yes

    type: number
    sql: ${TABLE}.overall_wellness_score ;;
  }

  dimension: overall_personal_growth_score {
    hidden: yes

    type: number
    sql: ${TABLE}.overall_personal_growth_score ;;
  }

  measure: avg_engagement_score {
    hidden: no
    value_format_name: decimal_2

    type: average
    sql: ${TABLE}.engagement_score ;;
  }

  measure: avg_participation_score {
    hidden: no
    value_format_name: decimal_2

    type: average
    sql: ${TABLE}.overall_participation_score ;;
  }

  measure: avg_e_nps {
    hidden: no
    value_format_name: decimal_2

    type: average
    sql: ${TABLE}.e_nps ;;
  }

  measure: avg_recognition_score {
    hidden: no
    value_format_name: decimal_2

    type: average
    sql: ${TABLE}.overall_recognition_score ;;
  }

  measure: avg_ambassadorship_score {
    hidden: no
    value_format_name: decimal_2

    type: average
    sql: ${TABLE}.overall_ambassadorship_score ;;
  }

  measure: avg_feedback_score {
    hidden: no
    value_format_name: decimal_2

    type: average
    sql: ${TABLE}.overall_feedback_score ;;
  }

  measure: avg_relationship_with_peers_score {
    hidden: no
    value_format_name: decimal_2

    type: average
    sql: ${TABLE}.relationship_with_peers_score ;;
  }

  measure: avg_relationship_with_manager_score {
    hidden: no
    value_format_name: decimal_2

    type: average
    sql: ${TABLE}.relationship_with_manager_score ;;
  }

  measure: avg_satisfaction_score {
    hidden: no
    value_format_name: decimal_2

    type: average
    sql: ${TABLE}.overall_satisfaction_score ;;
  }

  measure: avg_alignment_score {
    hidden: no
    value_format_name: decimal_2

    type: average
    sql: ${TABLE}.overall_alignment_score ;;
  }

  measure: avg_happiness_score {
    hidden: no
    value_format_name: decimal_2

    type: number
    sql: ${TABLE}.overall_happiness_score ;;
  }

  measure: avg_wellness_score {
    hidden: no
    value_format_name: decimal_2

    type: average
    sql: ${TABLE}.overall_wellness_score ;;
  }

  measure: avg_personal_growth_score {
    hidden: no
    value_format_name: decimal_2
    type: average
    sql: ${TABLE}.overall_personal_growth_score ;;
  }



  set: detail {
    fields: [
      survey_pk,
      engagement_score,
      overall_participation_score,
      e_nps,
      overall_recognition_score,
      overall_ambassadorship_score,
      overall_feedback_score,
      relationship_with_peers_score,
      relationship_with_manager_score,
      overall_satisfaction_score,
      overall_alignment_score,
      overall_happiness_score,
      overall_wellness_score,
      overall_personal_growth_score
    ]
  }
}
