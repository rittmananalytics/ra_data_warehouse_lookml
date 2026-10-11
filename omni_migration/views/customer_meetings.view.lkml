view: customer_meetings {
  sql_table_name: ra-development.analytics.meeting_contact_contributions_fact ;;

  dimension: company_fk {
    type: string
    hidden: yes
    sql: ${TABLE}.company_fk ;;
  }

  dimension: contact_name {
    type: string
    label: "Meeting Attendee"
    sql: ${TABLE}.contact_name ;;
  }

  dimension: contribution_sentiment_category {
    type: string
    group_label: "Meeting Contributions"
    sql: trim(${TABLE}.contribution_sentiment_category) ;;
  }

  dimension: contribution_sentiment_score {
    hidden: yes
    sql: case when ${contribution_sentiment_category} in ('UNENGAGED', 'CONCERNED') then -1
              when ${contribution_sentiment_category} = 'POSITIVE' then 1
              else 0 end ;;
  }

  dimension: meeting_contribution {
    type: string
    group_label: "Meeting Contributions"
    sql: ${TABLE}.meeting_contribution ;;
  }

  dimension: meeting_contribution_pk {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.meeting_contribution_pk ;;
  }

  dimension: meeting_engagement_level {
    type: number
    hidden: yes
    sql: ${TABLE}.meeting_engagement_level ;;
  }

  dimension: meeting_summary {
    type: string
    group_label: "Meeting Details"
    sql: ${TABLE}.meeting_summary ;;
  }

  dimension: meeting_title {
    type: string
    group_label: "Meeting Details"
    sql: ${TABLE}.meeting_title ;;
  }

  dimension: person_fk {
    type: string
    sql: ${TABLE}.person_fk ;;
  }

  dimension: recording_url {
    type: string
    hidden: yes
    sql: ${TABLE}.recording_url ;;
  }

  dimension_group: meeting_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year, month_num]
    group_label: "Meeting Details"
    sql: ${TABLE}.meeting_start_ts ;;
  }

  measure: average_contribution_sentiment_score {
    type: average
    group_label: "Meeting Contributions"
    value_format_name: decimal_1
    sql: ${contribution_sentiment_score} ;;
  }

  measure: avg_meeting_engagement_level {
    type: average
    group_label: "Meeting Contributions"
    sql: ${meeting_engagement_level} ;;
  }

  measure: mood_score {
    type: number
    label: "Mood"
    description: "Average sentiment times average engagement level (Looker tile 3087 table calculation mood)"
    value_format_name: decimal_2
    sql: ${average_contribution_sentiment_score} * ${avg_meeting_engagement_level} ;;
  }

  measure: total_contributions {
    type: count_distinct
    hidden: yes
    sql: ${meeting_contribution_pk} ;;
  }

  measure: total_meetings {
    type: count_distinct
    group_label: "Meeting Details"
    sql: ${recording_url} ;;
  }
}
