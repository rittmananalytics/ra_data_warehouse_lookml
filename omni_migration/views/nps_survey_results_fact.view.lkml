view: nps_survey_results_fact {
  sql_table_name: `ra-development.analytics.nps_survey_results_fact` ;;

  dimension: company_fk {
    hidden: yes
    sql: ${TABLE}.company_fk ;;
  }

  dimension: contact_email {
    hidden: yes
    sql: ${TABLE}.contact_email ;;
  }

  dimension: contact_fk {
    hidden: yes
    sql: ${TABLE}.contact_fk ;;
  }

  dimension: contact_name {
    sql: ${TABLE}.contact_name ;;
  }

  dimension: nps_score {
    sql: ${TABLE}.nps_score ;;
  }

  dimension: nps_sentiment {
    sql: ${TABLE}.nps_sentiment ;;
  }

  dimension: nps_survey_feedback {
    sql: ${TABLE}.nps_survey_feedback ;;
  }

  dimension: nps_survey_results_pk {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.nps_survey_results_pk ;;
  }

  dimension_group: nps_survey_ts {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.nps_survey_ts ;;
  }

  measure: average_nps_score {
    type: average
    sql: ${nps_score} ;;
  }

  measure: count {
    type: count
    drill_fields: [nps_survey_results_fact.contact_name]
  }

  measure: nps_target {
    type: max
    label: "NPS Target"
    description: "Constant target of 10 (Looker tile 3045 table calculation target)"
    value_format_name: decimal_0
    sql: 10 ;;
  }
}
