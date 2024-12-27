view: customer_meetings {
  derived_table: {
    sql: select * from ra-development.analytics.meeting_contact_contributions_fact ;;
  }

  measure: total_contributions {
    type: count_distinct
  sql: ${meeting_contribution_pk} ;;
  }

  measure: total_meetings {
    type: count_distinct
    sql: ${recording_url} ;;
  }

  dimension: meeting_contribution_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.meeting_contribution_pk ;;
  }

  dimension: contact_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_fk ;;
  }

  dimension: company_fk {
    hidden: yes

    type: string
    sql: ${TABLE}.company_fk ;;
  }



  dimension: recording_url {
    hidden: yes

    type: string
    sql: ${TABLE}.recording_url ;;
  }

  dimension: contact_name {
    type: string
    sql: ${TABLE}.contact_name ;;
  }

  dimension: meeting_title {
    type: string
    sql: ${TABLE}.meeting_title ;;
  }

  dimension_group: meeting_start {
    type: time
    timeframes: [time,date,week,month,month_num,quarter,year]
    sql: ${TABLE}.meeting_start_ts ;;
  }

  dimension: meeting_summary {
    type: string
    sql: ${TABLE}.meeting_summary ;;
  }

  dimension: meeting_contribution {
    type: string
    sql: ${TABLE}.meeting_contribution ;;
  }

  dimension: contribution_sentiment_category {
    type: string
    sql: trim(${TABLE}.contribution_sentiment_category) ;;
  }

  dimension: contribution_sentiment_score {
    type: number
    sql: case when ${contribution_sentiment_category} in ('UNENGAGED', 'CONCERNED') then -1
              when ${contribution_sentiment_category} = 'POSITIVE' then 1
              else 0 end;;
  }

  dimension: meeting_engagement_level {
    type: number
    sql: ${TABLE}.meeting_engagement_level ;;
  }

  measure: avg_meeting_engagement_level {
    type: average
    sql: ${meeting_engagement_level} ;;
  }

  measure: average_contribution_sentiment_score {
    type: average
    value_format_name: decimal_1
    sql: ${contribution_sentiment_score} ;;
  }

}
