view: fathom_meetings {
    derived_table: {
      sql: select * from `ra-secure.meeting_transcripts.fathom_transcripts` ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: recording_url {

      type: string
      sql: ${TABLE}.recording_url ;;
    }

    dimension: pk {
      type: string
      sql: concat(${recording_url},${meeting_raw}) ;;
      primary_key: yes
      hidden: yes
    }

    dimension: recording_share_url {
      hidden: yes
      type: string
      sql: ${TABLE}.recording_share_url ;;
    }

    dimension: recording_duration_in_minutes {
      label: "Meeting Duration Mins"

      type: number
      sql: ${TABLE}.recording_duration_in_minutes ;;
    }

    dimension_group: meeting {
      type: time
      timeframes: [raw,time,date,week,month,quarter,year, day_of_week]
      sql: ${TABLE}.meeting_scheduled_start_time ;;
    }

    dimension_group: meeting_scheduled_end_time {
      hidden: yes
      type: time
      sql: ${TABLE}.meeting_scheduled_end_time ;;
    }

    dimension: meeting_scheduled_duration_in_minutes {
      label: "Meeting Scheduled Duration Mins"
      type: number
      sql: ${TABLE}.meeting_scheduled_duration_in_minutes ;;
    }



    dimension: meeting_title {
      type: string
      sql: ${TABLE}.meeting_title ;;
    }

    dimension: meeting_has_external_invitees {
      type: yesno
      sql: ${TABLE}.meeting_has_external_invitees ;;
    }

    dimension: meeting_external_domain_names {
      type: string
      sql: ${TABLE}.meeting_external_domain_names ;;
    }

    dimension: meeting_invitee_names {
      type: string
      sql: ${TABLE}.meeting_invitee_names ;;
    }

    dimension: meeting_invitee_emails {
      type: string
      sql: ${TABLE}.meeting_invitee_emails ;;
    }

    dimension: meeting_invitee_is_external {
      type: yesno
      sql: ${TABLE}.meeting_invitee_is_external ;;
    }

    dimension: fathom_user_name {
      label: "Meeting Host"
      type: string
      sql: ${TABLE}.fathom_user_name ;;
    }

    dimension: fathom_user_email {
      label: "Meeting Host Email"
      type: string
      sql: ${TABLE}.fathom_user_email ;;
    }

    dimension: fathom_user_team {
      label: "Fathon Team"
      type: string
      sql: ${TABLE}.fathom_user_team ;;
    }

    dimension: meeting_transcript {
      hidden: no
      type: string
      sql: ${TABLE}.transcript_plaintext ;;
    }

    dimension: meeting_sentiment {
      type: string
      sql: ${TABLE}.meeting_sentiment ;;
    }

    dimension: meeting_summary {
      type: string
      sql: ${TABLE}.meeting_summary ;;
    }

    dimension: meeting_type {
      type: string
      sql: ${TABLE}.meeting_type ;;
    }

    dimension: meeting_controls_review {
      type: string
      sql: ${TABLE}.meeting_controls_review ;;
    }

    dimension: meeting_sales_revenue_opportunities {
      type: string
      sql: ${TABLE}.meeting_sales_revenue_opportunities ;;
    }

    dimension: meeting_critique {
      type: string
      sql: ${TABLE}.meeting_critique ;;
    }

    dimension: meeting_is_moderation_flagged {
      label: "Is Flagged for Moderation"
      type: yesno
      sql: ${TABLE}.meeting_is_moderation_flagged ;;
    }

    dimension: meeting_is_hate_harrassment_flagged {
      label: "Is Flagged for Harrassment"

      type: yesno
      sql: ${TABLE}.meeting_is_hate_harrassment_flagged ;;
    }

    dimension: meeting_is_sexual_flagged {
      label: "Is Flagged for Sexual Comments"

      type: yesno
      sql: ${TABLE}.meeting_is_sexual_flagged ;;
    }

    dimension: meeting_sentiment_details {
      type: string
      sql: ${TABLE}.meeting_sentiment_details ;;
    }

    dimension: needs_parsing {
      hidden: yes
      type: yesno
      sql: ${TABLE}.needs_parsing ;;
    }

    dimension_group: updated_at {
      hidden: yes

      type: time
      sql: ${TABLE}.updated_at ;;
    }

    measure: avg_meeting_length_mins {
      value_format_name: decimal_1
      type: average
      sql: ${recording_duration_in_minutes} ;;
    }

  measure: total_meeting_length_mins {
    value_format_name: decimal_1

    type: sum
    sql: ${recording_duration_in_minutes} ;;
  }

  measure: total_meetings {
    type: count_distinct
    sql: ${pk} ;;
  }

  measure: total_moderation_flagged_meetings {
    type: count_distinct
    sql: ${pk} ;;
    filters: [meeting_is_moderation_flagged: "Yes"]
  }

  measure: total_client_meetings {
    type: count_distinct
    sql: ${pk} ;;
    filters: [meeting_type: "CLIENT_MEETING"]
  }

  measure: total_scheduled_internal_meetings {
    type: count_distinct
    sql: ${pk} ;;
    filters: [meeting_type: "SCHEDULED INTERNAL MEETING"]
  }

  measure: total_adhoc_internal_meetings {
    type: count_distinct
    sql: ${pk} ;;
    filters: [meeting_type: "AD-HOC INTERNAL MEETING"]
  }


  measure: avg_meeting_sentiment {
    description: "Average of meeting sentiment scores where positive=1, negative=-1 and neutral=0"
    type: average
    value_format_name: decimal_1
    sql: case when ${meeting_sentiment} = 'positive' then 1 when ${meeting_sentiment} = 'negative' then -1 else 0 end ;;
  }

    set: detail {
      fields: [
        recording_url,
        recording_share_url,
        recording_duration_in_minutes,
        meeting_scheduled_end_time_time,
        meeting_scheduled_duration_in_minutes,
        meeting_title,
        meeting_has_external_invitees,
        meeting_external_domain_names,
        meeting_invitee_names,
        meeting_invitee_emails,
        meeting_invitee_is_external,
        fathom_user_name,
        fathom_user_email,
        fathom_user_team,
        meeting_sentiment,
        meeting_summary,
        meeting_type,
        meeting_controls_review,
        meeting_sales_revenue_opportunities,
        meeting_critique,
        meeting_is_moderation_flagged,
        meeting_is_hate_harrassment_flagged,
        meeting_is_sexual_flagged,
        meeting_sentiment_details,
        needs_parsing,
        updated_at_time
      ]
    }
  }
