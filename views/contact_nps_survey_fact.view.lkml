view: contact_nps_survey_fact {
  sql_table_name: `ra-development.analytics.contact_nps_survey_fact`
    ;;

  dimension: contact_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_pk ;;
  }

  dimension: nps_survey_name {
    group_label: "NPS Scores"
    label: "NPS Survey Name"

    type: string
    sql: ${TABLE}.nps_survey__name ;;
  }

  dimension: nps_survey_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.nps_survey_pk ;;
  }

  dimension: nps_survey_response_content {
    label: "NPS Survey Response Content"
    group_label: "NPS Scores"

    hidden: no
    type: string
    sql: ${TABLE}.nps_survey_response_content ;;
  }

  dimension_group: nps_survey_response_created_at_ts {
    label: "NPS Survey Response"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.nps_survey_response_created_at_ts ;;
  }

  dimension: nps_survey_response_score {
    hidden: yes
    type: number
    sql: ${TABLE}.nps_survey_response_score ;;
  }

  dimension: nps_survey_response_sentiment {
    label: "NPS Survey Response Sentiment"
    group_label: "NPS Scores"

    type: string
    sql: ${TABLE}.nps_survey_response_sentiment ;;
  }

  dimension: nps_survey_type {
    label: "NPS Survey Type"
    group_label: "NPS Scores"

    type: string
    sql: ${TABLE}.nps_survey_type ;;
  }

  dimension: source {
    label: "NPS Survey Source"
    group_label: "NPS Scores"

    type: string
    sql: ${TABLE}.source ;;
  }

  measure: total_responses {
    group_label: "NPS Scores"

    type: count_distinct
    sql: ${TABLE}.nps_survey_pk ;;
  }
  measure: total_respondents {
    group_label: "NPS Scores"

    type: count_distinct
    sql: ${TABLE}.contact_pk ;;
  }

  measure: avg_nps_score {
    label: "Average NPS Score"
    group_label: "NPS Scores"

    type: average
    sql: ${TABLE}.nps_survey_response_score ;;
  }
}
