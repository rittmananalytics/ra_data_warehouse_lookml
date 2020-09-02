view: web_sessions_fact {
  sql_table_name: `analytics.web_sessions_fact`
    ;;

  dimension: blended_user_id {
    hidden: yes
    type: string
    sql: ${TABLE}.blended_user_id ;;
  }

  dimension: channel {
    group_label: "Conversions"
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: customer_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.customer_pk ;;
  }

  dimension: device {
    group_label: "  Audience"
    #description: "The type of device used to access the page, e.g Android, Macintosh, windows etc. This usually includes the device model and operating system version."
    type: string
    sql: ${TABLE}.device ;;
  }

  dimension: device_category {
    group_label: "  Audience"
    #description: "A simplified version of Device field without OS/Browser detail. e.g 'iPhone','Android','iPad','Windows' etc"
    type: string
    sql: ${TABLE}.device_category ;;
  }

  dimension: duration_in_s {
    group_label: "Behavior"
    type: number
    sql: ${TABLE}.duration_in_s ;;
  }

  dimension: duration_in_s_tier {
    group_label: "Behavior"
    type: string
    sql: ${TABLE}.duration_in_s_tier ;;
  }

  dimension: events {
    group_label: "Behavior"
    type: number
    sql: ${TABLE}.events ;;
  }

  measure: count_of_events {
    type: sum #?
    sql: ${events} ;;
  }

  dimension: first_page_url {
    label: "Entrance Page Path"
    group_label: "Behavior"
    type: string
    sql: ${TABLE}.first_page_url ;;
  }

  dimension: first_page_url_host {
    hidden: yes
    group_label: "Behavior"
    type: string
    sql: ${TABLE}.first_page_url_host ;;
  }

  dimension: first_page_url_path {
    hidden: yes
    type: string
    sql: ${TABLE}.first_page_url_path ;;
  }

  dimension: gclid {
    hidden: yes
    type: string
    sql: ${TABLE}.gclid ;;
  }

  dimension: is_bounced_session {
    group_label: "Behavior"
    type: yesno
    sql: ${TABLE}.is_bounced_session ;;
  }

  dimension: last_page_url {
    hidden: yes
    type: string
    sql: ${TABLE}.last_page_url ;;
  }

  dimension: last_page_url_host {
    hidden: yes
    type: string
    sql: ${TABLE}.last_page_url_host ;;
  }

  dimension: last_page_url_path {
    hidden: yes
    type: string
    sql: ${TABLE}.last_page_url_path ;;
  }

  dimension: mins_between_sessions {
    hidden: yes
    type: number
    sql: ${TABLE}.mins_between_sessions ;;
  }

  dimension: prev_session_channel {
    hidden: yes
    type: string
    sql: ${TABLE}.prev_session_channel ;;
  }

  dimension: prev_utm_medium {
    hidden: yes
    type: string
    sql: ${TABLE}.prev_utm_medium ;;
  }

  dimension: prev_utm_source {
    hidden: yes
    type: string
    sql: ${TABLE}.prev_utm_source ;;
  }

  dimension: referrer_host {
    group_label: "    Acquisition"
    type: string
    sql: ${TABLE}.referrer_host ;;
  }

  dimension: referrer_medium {
    group_label: "    Acquisition"
    type: string
    sql: ${TABLE}.referrer_medium ;;
  }

  dimension: referrer_source {
    group_label: "    Acquisition"
    type: string
    sql: ${TABLE}.referrer_source ;;
  }

  dimension: search {
    group_label: "    Acquisition"
    type: string
    sql: ${TABLE}.search ;;
  }

  dimension_group: session_end_ts {
    group_label: "Dates"
    label: "Session End"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.session_end_ts ;;
  }

  dimension: session_id {
    hidden: yes
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension_group: session_start_ts {
    group_label: "Dates"
    label: "Session Start"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.session_start_ts ;;
  }

  dimension: session_site {
    hidden: yes
    type: string
    sql: ${TABLE}.site ;;
  }

  measure: total_duration_in_s {
    description: "The time spanned from the beginning to the end of a session in Seconds."
    type: average
    label: "Avg Session Duration (mins)"
    value_format: "mm:ss"
    sql: ${TABLE}.duration_in_s / (60.00*60*24) ;;
  }

  measure: total_web_sessions_pk {
    label: "Total Sessions"
    description: ""
    type: count_distinct
    sql: ${web_sessions_pk} ;;
  }

  measure: bounced_session_rate {
    label: "Bounced Session Rate"
    description: ""
    type: number
    value_format: "0.00%"
    sql: SAFE_DIVIDE(COUNT(DISTINCT(case when ${is_bounced_session} = TRUE then ${web_sessions_pk} end)),${total_web_sessions_pk})  ;;
  }

  dimension: user_id {
    hidden: yes
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: user_session_number {
    group_label: "  Audience"
    type: number
    sql: ${TABLE}.user_session_number ;;
  }

  #dimension: utm_campaign {
  #  label: "Ad Campaign"
  #  group_label: "    Acquisition"
  #  type: string
  #  sql: ${TABLE}.utm_campaign ;;
  #}
#
  #dimension: utm_content {
  #  label: "Ad Content"
  #  group_label: "    Acquisition"
  #  type: string
  #  sql: ${TABLE}.utm_content ;;
  #}
#
  #dimension: utm_medium {
  #  label: "Ad Medium"
  #  group_label: "    Acquisition"
  #  type: string
  #  sql: ${TABLE}.utm_medium ;;
  #}
#
  #dimension: utm_source {
  #  label: "Ad Source"
  #  group_label: "    Acquisition"
  #  type: string
  #  sql: ${TABLE}.utm_source ;;
  #}
#
  #dimension: utm_term {
  #  label: "Ad Keyword"
  #  group_label: "    Acquisition"
  #  type: string
  #  sql: ${TABLE}.utm_term ;;
  #}

  dimension: visitor_id {
    hidden: yes
    type: string
    sql: ${TABLE}.visitor_id ;;
  }

  dimension: web_sessions_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.web_sessions_pk ;;
  }



####DYNAMIC TIMEFRAME ON TIMEFRAME ANALYSIS

## filter determining time range for all "A" measures

  filter: timeframe_a {
    hidden: no
    type: date_time
    label: "Session Start Date"
    description: "Use this filter on Session Start Date to configure timeframe-on-timeframe analysis in conjunction with a ${group_a_yesno} filter. Using this filter creates two timeframe windows, 'current & prior', the latter being of the same duration as the filter but it is the period ending immediately before the filter starts."
    default_value: "7 days"
  }

  ## flag for "A" measures to only include appropriate time range

  dimension: group_a_yesno {
    hidden: no
    label: "Timeframe Selected (Current)"
    type: yesno
    sql: {% condition timeframe_a %} ${session_start_ts_raw} {% endcondition %} ;;
  }

  ## filter determining time range for all "B" measures

  #filter: timeframe_b {
  #  type: date_time
  #}

  ## flag for "B" measures to only include appropriate time range

  dimension: timeframe_duration {
    hidden: yes
    type: number
    sql:
      CASE WHEN {% date_start timeframe_a %} is null then 7
      ELSE TIMESTAMP_DIFF({% date_end timeframe_a %},{% date_start timeframe_a %}, DAY)
      END;;
  }

## flags whether the event is in timeframe B (the timeframe immediately prior to timeframe A of equal length to A.)
## e.g if timeframe A is 8th-10th, then timeframe B would be 6th-8th of the month.
  dimension: group_b_yesno {
    hidden: no
    label: "Timeframe Selected (Prior)"
    type: yesno
    sql:
    CASE WHEN  TIMESTAMP_SUB(IFNULL({% date_start timeframe_a %},CURRENT_TIMESTAMP()),INTERVAL ${timeframe_duration} DAY ) < ${session_start_ts_raw}
    AND
    IFNULL({% date_start timeframe_a %},CURRENT_TIMESTAMP()) > ${session_start_ts_raw}
    THEN TRUE ELSE FALSE END ;;
  }

  # Dimensions to filter whole query for just records within the two periods
  dimension: is_in_time_a_or_b {
    hidden: yes
    label: "Is in any selected timeframe (Current & Prior)"
    group_label: "Time Comparison Filters"
    type: yesno
    sql:
      CASE WHEN ${group_a_yesno} IS TRUE OR ${group_b_yesno} IS TRUE THEN TRUE ELSE FALSE END ;;
  }













  dimension: utm_campaign {
    type: string
    sql: ${TABLE}.utm_campaign ;;
  }

  dimension: utm_content {
    type: string
    sql: ${TABLE}.utm_content ;;
  }

  dimension: utm_medium {
    type: string
    sql: ${TABLE}.utm_medium ;;
  }

  dimension: utm_source {
    type: string
    sql: ${TABLE}.utm_source ;;
  }

  dimension: utm_term {
    type: string
    sql: ${TABLE}.utm_term ;;
  }



  measure: count {
    type: count
    drill_fields: []
  }
}
