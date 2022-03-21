view: officevibe {
  derived_table: {
    sql: SELECT
        `Date` as survey_ts,
        safe_cast(Engagement as float64) as engagement,
        safe_cast(Participation____ as float64) as participation,
        safe_cast(eNPS as float64) as enps,
        safe_cast(Recognition as float64) as recognition,
        safe_cast(Ambassadorship as float64) as ambassadorship,
        safe_cast(Feedback as float64) as feedback,
        safe_cast(Relationship_with_Peers as float64) as relationship_with_peers,
        safe_cast(Relationship_with_Manager as float64) as relationship_with_manager,
        safe_cast(Satisfaction as float64) as satisfaction,
        safe_cast(Alignment as float64) as alignment,
        safe_cast(Happiness as float64) as happiness,
        safe_cast(Wellness as float64) as wellness,
        safe_cast(Personal_Growth as float64) as personal_growth,
        safe_cast(Recognition___Recognition_Quality as float64) as recognition_quality,
        safe_cast(Recognition___Recognition_Frequency as float64) as recognition_frequency,
        safe_cast(Ambassadorship___Championing as float64) as ambassadorship_championing,
        safe_cast(Ambassadorship___Pride as float64) as ambassadorship_pride,
        safe_cast(Feedback___Feedback_Quality as float64) as feedback_quality,
        safe_cast(Feedback___Feedback_Frequency as float64) as feedback_frequency,
        safe_cast(Feedback___Suggestions_for_the_Organization as float64) as feedback_suggestions,
        safe_cast(Relationship_with_Peers___Collaboration_between_Peers as float64) as relationship_collaboration_between_peers,
        safe_cast(Relationship_with_Peers___Trust_between_Peers as float64) as relationship_trust_between_peers,
        safe_cast(Relationship_with_Peers___Communication_between_Peers as float64) as relationship_communication_between_peers,
        safe_cast(Relationship_with_Manager___Collaboration_with_Manager as float64) as relatiohip_with_manager,
        safe_cast(Relationship_with_Manager___Trust_with_Manager as float64) as relationship_trust_with_manager,
        safe_cast(Relationship_with_Manager___Communication_with_Manager as float64) as relationship_communication_with_manager,
        safe_cast(Satisfaction___Fairness as float64) as satisfaction_fairness,
        safe_cast(Satisfaction___Role_within_Organization as float64) as satisfaction_role_within_organization,
        safe_cast(Satisfaction___Work_environment as float64) as satisfaction_work_environment,
        safe_cast(Alignment___Values as float64) as alignment_values,
        safe_cast(Alignment___Vision___Mission as float64) as alignment_vision,
        safe_cast(Alignment___Ethics___Social_Responsibility as float64) as alignment_ethics,
        safe_cast(Happiness___Happiness_at_Work as float64) as happiness_at_work,
        safe_cast(Happiness___Work_Life_Balance as float64) as happiness_work_life_balance,
        safe_cast(Wellness___Stress as float64) as wellness_stress,
        safe_cast(Wellness___Personal_Health as float64) as wellness_personal_health,
        safe_cast(Personal_Growth___Autonomy as float64) as personal_growth_autonomy,
        safe_cast(Personal_Growth___Mastery as float64) as personal_growth_mastery,
        safe_cast(Personal_Growth___Purpose as float64) as personal_growth_purpose
      FROM
        `ra-development.analytics_seed.officevibe`
      LIMIT
        1000
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: survey_ts {
    type: date
    datatype: date
    sql: ${TABLE}.survey_ts ;;
  }

  dimension: engagement {
    type: number
    sql: ${TABLE}.engagement ;;
  }

  dimension: participation {
    type: number
    sql: ${TABLE}.participation ;;
  }

  dimension: enps {
    type: number
    sql: ${TABLE}.enps ;;
  }

  dimension: recognition {
    type: number
    sql: ${TABLE}.recognition ;;
  }

  dimension: ambassadorship {
    type: number
    sql: ${TABLE}.ambassadorship ;;
  }

  dimension: feedback {
    type: number
    sql: ${TABLE}.feedback ;;
  }

  dimension: relationship_with_peers {
    type: number
    sql: ${TABLE}.relationship_with_peers ;;
  }

  dimension: relationship_with_manager {
    type: number
    sql: ${TABLE}.relationship_with_manager ;;
  }

  dimension: satisfaction {
    type: number
    sql: ${TABLE}.satisfaction ;;
  }

  dimension: alignment {
    type: number
    sql: ${TABLE}.alignment ;;
  }

  dimension: happiness {
    type: number
    sql: ${TABLE}.happiness ;;
  }

  dimension: wellness {
    type: number
    sql: ${TABLE}.wellness ;;
  }

  dimension: personal_growth {
    type: number
    sql: ${TABLE}.personal_growth ;;
  }

  dimension: recognition_quality {
    type: number
    sql: ${TABLE}.recognition_quality ;;
  }

  dimension: recognition_frequency {
    type: number
    sql: ${TABLE}.recognition_frequency ;;
  }

  dimension: ambassadorship_championing {
    type: number
    sql: ${TABLE}.ambassadorship_championing ;;
  }

  dimension: ambassadorship_pride {
    type: number
    sql: ${TABLE}.ambassadorship_pride ;;
  }

  dimension: feedback_quality {
    type: number
    sql: ${TABLE}.feedback_quality ;;
  }

  dimension: feedback_frequency {
    type: number
    sql: ${TABLE}.feedback_frequency ;;
  }

  dimension: feedback_suggestions {
    type: number
    sql: ${TABLE}.feedback_suggestions ;;
  }

  dimension: relationship_collaboration_between_peers {
    type: number
    sql: ${TABLE}.relationship_collaboration_between_peers ;;
  }

  dimension: relationship_trust_between_peers {
    type: number
    sql: ${TABLE}.relationship_trust_between_peers ;;
  }

  dimension: relationship_communication_between_peers {
    type: number
    sql: ${TABLE}.relationship_communication_between_peers ;;
  }

  dimension: relatiohip_with_manager {
    type: number
    sql: ${TABLE}.relatiohip_with_manager ;;
  }

  dimension: relationship_trust_with_manager {
    type: number
    sql: ${TABLE}.relationship_trust_with_manager ;;
  }

  dimension: relationship_communication_with_manager {
    type: number
    sql: ${TABLE}.relationship_communication_with_manager ;;
  }

  dimension: satisfaction_fairness {
    type: number
    sql: ${TABLE}.satisfaction_fairness ;;
  }

  dimension: satisfaction_role_within_organization {
    type: number
    sql: ${TABLE}.satisfaction_role_within_organization ;;
  }

  dimension: satisfaction_work_environment {
    type: number
    sql: ${TABLE}.satisfaction_work_environment ;;
  }

  dimension: alignment_values {
    type: number
    sql: ${TABLE}.alignment_values ;;
  }

  dimension: alignment_vision {
    type: number
    sql: ${TABLE}.alignment_vision ;;
  }

  dimension: alignment_ethics {
    type: number
    sql: ${TABLE}.alignment_ethics ;;
  }

  dimension: happiness_at_work {
    type: number
    sql: ${TABLE}.happiness_at_work ;;
  }

  dimension: happiness_work_life_balance {
    type: number
    sql: ${TABLE}.happiness_work_life_balance ;;
  }

  dimension: wellness_stress {
    type: number
    sql: ${TABLE}.wellness_stress ;;
  }

  dimension: wellness_personal_health {
    type: number
    sql: ${TABLE}.wellness_personal_health ;;
  }

  dimension: personal_growth_autonomy {
    type: number
    sql: ${TABLE}.personal_growth_autonomy ;;
  }

  dimension: personal_growth_mastery {
    type: number
    sql: ${TABLE}.personal_growth_mastery ;;
  }

  dimension: personal_growth_purpose {
    type: number
    sql: ${TABLE}.personal_growth_purpose ;;
  }

  set: detail {
    fields: [
      survey_ts,
      engagement,
      participation,
      enps,
      recognition,
      ambassadorship,
      feedback,
      relationship_with_peers,
      relationship_with_manager,
      satisfaction,
      alignment,
      happiness,
      wellness,
      personal_growth,
      recognition_quality,
      recognition_frequency,
      ambassadorship_championing,
      ambassadorship_pride,
      feedback_quality,
      feedback_frequency,
      feedback_suggestions,
      relationship_collaboration_between_peers,
      relationship_trust_between_peers,
      relationship_communication_between_peers,
      relatiohip_with_manager,
      relationship_trust_with_manager,
      relationship_communication_with_manager,
      satisfaction_fairness,
      satisfaction_role_within_organization,
      satisfaction_work_environment,
      alignment_values,
      alignment_vision,
      alignment_ethics,
      happiness_at_work,
      happiness_work_life_balance,
      wellness_stress,
      wellness_personal_health,
      personal_growth_autonomy,
      personal_growth_mastery,
      personal_growth_purpose
    ]
  }
}
