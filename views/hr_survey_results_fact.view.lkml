# The name of this view in Looker is "Hr Survey Results Fact"
view: hr_survey_results_fact {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics.hr_survey_results_fact`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Alignment Ethics Score" in Explore.

  dimension: alignment_ethics_score {
    type: number
    sql: ${TABLE}.alignment_ethics_score ;;
  }

  dimension: alignment_values_score {
    type: number
    sql: ${TABLE}.alignment_values_score ;;
  }

  dimension: alignment_vision_score {
    type: number
    sql: ${TABLE}.alignment_vision_score ;;
  }

  dimension: ambassadorship_championing_score {
    type: number
    sql: ${TABLE}.ambassadorship_championing_score ;;
  }

  dimension: ambassadorship_pride_score {
    type: number
    sql: ${TABLE}.ambassadorship_pride_score ;;
  }

  dimension: e_nps {
    type: number
    sql: ${TABLE}.e_nps ;;
  }

  measure: average_e_nps {
    type: average
    sql: ${e_nps} ;;
  }

  dimension: engagement_score {
    type: number
    sql: ${TABLE}.engagement_score ;;
  }

  dimension: feedback_frequency_score {
    type: number
    sql: ${TABLE}.feedback_frequency_score ;;
  }

  dimension: feedback_quality_score {
    type: number
    sql: ${TABLE}.feedback_quality_score ;;
  }

  dimension: feedback_suggestions_score {
    type: number
    sql: ${TABLE}.feedback_suggestions_score ;;
  }

  dimension: happiness_at_work_score {
    type: number
    sql: ${TABLE}.happiness_at_work_score ;;
  }

  dimension: happiness_work_life_balance_score {
    type: number
    sql: ${TABLE}.happiness_work_life_balance_score ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_happiness_work_life_balance_score {
    type: sum
    sql: ${happiness_work_life_balance_score} ;;
  }

  measure: average_happiness_work_life_balance_score {
    type: average
    sql: ${happiness_work_life_balance_score} ;;
  }

  dimension: overall_alignment_score {
    type: number
    sql: ${TABLE}.overall_alignment_score ;;
  }

  dimension: overall_ambassadorship_score {
    type: number
    sql: ${TABLE}.overall_ambassadorship_score ;;
  }

  dimension: overall_feedback_score {
    type: number
    sql: ${TABLE}.overall_feedback_score ;;
  }

  dimension: overall_happiness_score {
    type: number
    sql: ${TABLE}.overall_happiness_score ;;
  }

  dimension: overall_participation_score {
    type: number
    sql: ${TABLE}.overall_participation_score ;;
  }

  dimension: overall_personal_growth_score {
    type: number
    sql: ${TABLE}.overall_personal_growth_score ;;
  }

  dimension: overall_recognition_score {
    type: number
    sql: ${TABLE}.overall_recognition_score ;;
  }

  dimension: overall_satisfaction_score {
    type: number
    sql: ${TABLE}.overall_satisfaction_score ;;
  }

  measure: average_satisfaction_score {
    type: average
    sql: ${overall_satisfaction_score} ;;
  }

  measure: average_happiness_score {
    type: average
    sql: ${overall_happiness_score} ;;
  }

  measure: average_wellness_score {
    type: average
    sql: ${overall_wellness_score} ;;
  }

  measure: average_ambassadorship_score {
    type: average
    sql: ${overall_ambassadorship_score} ;;
  }

  dimension: overall_wellness_score {
    type: number
    sql: ${TABLE}.overall_wellness_score ;;
  }

  dimension: personal_growth_autonomy_score {
    type: number
    sql: ${TABLE}.personal_growth_autonomy_score ;;
  }

  dimension: personal_growth_mastery_score {
    type: number
    sql: ${TABLE}.personal_growth_mastery_score ;;
  }

  dimension: personal_growth_purpose_score {
    type: number
    sql: ${TABLE}.personal_growth_purpose_score ;;
  }

  dimension: recognition_frequency_score {
    type: number
    sql: ${TABLE}.recognition_frequency_score ;;
  }

  dimension: recognition_quality_score {
    type: number
    sql: ${TABLE}.recognition_quality_score ;;
  }

  dimension: relatiohip_with_manager_score {
    type: number
    sql: ${TABLE}.relatiohip_with_manager_score ;;
  }

  dimension: relationship_collaboration_between_peers_score {
    type: number
    sql: ${TABLE}.relationship_collaboration_between_peers_score ;;
  }

  dimension: relationship_communication_between_peers_score {
    type: number
    sql: ${TABLE}.relationship_communication_between_peers_score ;;
  }

  dimension: relationship_communication_with_manager_score {
    type: number
    sql: ${TABLE}.relationship_communication_with_manager_score ;;
  }

  dimension: relationship_trust_between_peers_score {
    type: number
    sql: ${TABLE}.relationship_trust_between_peers_score ;;
  }

  dimension: relationship_trust_with_manager_score {
    type: number
    sql: ${TABLE}.relationship_trust_with_manager_score ;;
  }

  dimension: relationship_with_manager_score {
    type: number
    sql: ${TABLE}.relationship_with_manager_score ;;
  }

  dimension: relationship_with_peers_score {
    type: number
    sql: ${TABLE}.relationship_with_peers_score ;;
  }

  dimension: satisfaction_fairness_score {
    type: number
    sql: ${TABLE}.satisfaction_fairness_score ;;
  }

  dimension: satisfaction_role_within_organization_score {
    type: number
    sql: ${TABLE}.satisfaction_role_within_organization_score ;;
  }

  dimension: satisfaction_work_environment_score {
    type: number
    sql: ${TABLE}.satisfaction_work_environment_score ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: survey_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.survey_pk ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: survey_ts {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.survey_ts ;;
  }

  dimension: wellness_personal_health_score {
    type: number
    sql: ${TABLE}.wellness_personal_health_score ;;
  }

  dimension: wellness_stress_score {
    type: number
    sql: ${TABLE}.wellness_stress_score ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
