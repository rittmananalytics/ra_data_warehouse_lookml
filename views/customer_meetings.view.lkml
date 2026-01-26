view: customer_meetings {
  derived_table: {
    sql: select * from ra-development.analytics.meeting_contact_contributions_fact ;;
  }

  measure: total_contributions {
    hidden: yes
    type: count_distinct
  sql: ${meeting_contribution_pk} ;;
  }

  measure: total_meetings {
    group_label: "  Meeting Details"

    type: count_distinct
    sql: ${recording_url} ;;
  }

  dimension: meeting_contribution_pk {
    primary_key: yes
    hidden: yes

    type: string
    sql: ${TABLE}.meeting_contribution_pk ;;
  }

  dimension: person_fk {
    hidden: no
    type: string
    sql: ${TABLE}.person_fk ;;
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
    label: "    Meeting Attendee"
    hidden: no
    type: string
    sql: ${TABLE}.contact_name ;;
  }

  dimension: meeting_title {
    group_label: "  Meeting Details"
    type: string
    sql: ${TABLE}.meeting_title ;;
  }

  dimension_group: meeting_start {
    group_label: "  Meeting Details"

    type: time
    timeframes: [time,date,week,month,month_num,quarter,year]
    sql: ${TABLE}.meeting_start_ts ;;
  }

  dimension: meeting_summary {
    group_label: "  Meeting Details"

    type: string
    sql: ${TABLE}.meeting_summary ;;
  }

  dimension: meeting_contribution {
    group_label: " Meeting Contributions"

    type: string
    sql: ${TABLE}.meeting_contribution ;;
  }

  dimension: contribution_sentiment_category {
    group_label: " Meeting Contributions"

    type: string
    sql: trim(${TABLE}.contribution_sentiment_category) ;;
  }

  dimension: contribution_sentiment_score {
    hidden: yes

    type: number
    sql: case when ${contribution_sentiment_category} in ('UNENGAGED', 'CONCERNED') then -1
              when ${contribution_sentiment_category} = 'POSITIVE' then 1
              else 0 end;;
  }

  dimension: meeting_engagement_level {
    hidden: yes

    type: number
    sql: ${TABLE}.meeting_engagement_level ;;
  }

  measure: avg_meeting_engagement_level {
    group_label: " Meeting Contributions"

    type: average
    sql: ${meeting_engagement_level} ;;
  }

  measure: average_contribution_sentiment_score {
    group_label: " Meeting Contributions"

    type: average
    value_format_name: decimal_1
    sql: ${contribution_sentiment_score} ;;
  }

}
