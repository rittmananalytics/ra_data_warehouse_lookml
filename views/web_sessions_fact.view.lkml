view: web_sessions_fact {
  sql_table_name: `{{ _user_attributes['dataset'] }}.web_sessions_fact`
    ;;

  dimension: blended_user_id {
    group_label: "  Audience"

    hidden: no
    type: string
    sql: ${TABLE}.blended_user_id ;;
  }

  dimension: channel {
    group_label: " Acquisition"
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: ad_campaign_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.ad_campaign_pk ;;
  }

  dimension: customer_pk {
    group_label: "  Audience"

    hidden: no
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

  dimension: referrer {
    group_label: "    Acquisition"

    type: string
    sql: split(${TABLE}.referrer, "?")[SAFE_OFFSET(0)] ;;
  }

  dimension: referrer_source {
    group_label: "    Acquisition"
    type: string
    sql: case when ${referrer} like '%blog.rittmananalytics.com%' or ${referrer} like '%medium.com/mark-rittman%' then 'Medium'
              when ${referrer_host} like '%github%' then 'Github'
              when ${referrer_host} like '%linkedin%' then 'LinkedIn'
              when ${referrer_host} like '%google%' or ${referrer_host} like '%bing%' or  ${referrer_host} like '%yahoo%' or ${referrer_host} like '%yandex%' then 'Organic Search'
              when ${referrer_host} like '%t.co%' or ${referrer_host} like '%twitter%' then 'Twitter'
              when ${first_page_url} like '%rittmananalytics.com/blog%'  then 'Squarespace'
              when ${first_page_url} like '%https://rittmananalytics.com/drilltodetail%'  then 'Podcast'
              else 'Direct'
    end;;
  }

  dimension: referrer_article_stub {
    group_label: "    Acquisition"
    type: string
    sql: case when ${referrer_source} = 'Medium' and ${referrer_host} = 'blog.rittmananalytics.com' then split(${referrer},'/')[safe_offset(3)]
              when ${referrer_source} = 'Medium' and ${referrer_host} = 'medium.com' then split(${referrer},'/')[safe_offset(4)]
              when ${first_page_url} LIKE '%rittmananalytics.com/blog/2%' then SPLIT(first_page_url_path,'/')[safe_OFFSET(5)]
          end ;;

  }

  dimension: referrer_days_since_post {
    group_label: "    Acquisition"
    type: number
    sql: case when ${referrer_article_stub} is not null then timestamp_diff(${session_start_ts_raw},${marketing_content_dim.interaction_posted_ts_raw},DAY) end ;;
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
    group_label: "Behavior"

    type: string
    sql: ${TABLE}.last_page_url ;;
  }

  dimension: last_page_url_host {
    group_label: "Behavior"
    type: string
    sql: ${TABLE}.last_page_url_host ;;
  }

  dimension: last_page_url_path {
    group_label: "Behavior"
    type: string
    sql: ${TABLE}.last_page_url_path ;;
  }

  dimension: mins_between_sessions {
    group_label: "Behavior"
    type: number
    sql: ${TABLE}.mins_between_sessions ;;
  }

  dimension: prev_session_channel {
    group_label: "Behavior"
    type: string
    sql: ${TABLE}.prev_session_channel ;;
  }

  dimension: prev_utm_medium {
    group_label: "Behavior"
    type: string
    sql: ${TABLE}.prev_utm_medium ;;
  }

  dimension: prev_utm_source {
    group_label: "Behavior"
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
    group_label: "Behavior"
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
      hour4,
      day_of_week,
      date,
      day_of_year,
      week,
      month,
      month_num,
      week_of_year,
      year
    ]
    sql: ${TABLE}.session_start_ts ;;
  }

  dimension: session_site {
    group_label: "Behavior"
    type: string
    sql: ${TABLE}.site ;;
  }

  measure: total_duration_in_s {
    description: "The time spanned from the beginning to the end of a session in Seconds."
    type: average
    label: "Avg Session Duration (mins)"
    value_format: "mm:ss"
    sql: timestamp_diff(${TABLE}.session_end_ts,${TABLE}.session_start_ts,MINUTE) ;;
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
    group_label: "  Audience"

    hidden: no
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: user_session_number {
    group_label: "  Audience"
    type: number
    sql: ${TABLE}.user_session_number ;;
  }

  dimension: new_or_returning_user {
    group_label: "  Audience"
    type: string
    sql: case when ${TABLE}.user_session_number = 1 then 'New' else 'Returning' end ;;


  }



  dimension: anonymous_id {
    group_label: "  Audience"

    hidden: no
    type: string
    sql: ${TABLE}.visitor_id ;;
  }

  dimension: web_sessions_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.web_sessions_pk ;;
  }

  dimension: is_converted_user {
    type: yesno
    sql: ${TABLE}.is_converting_blended_user_id ;;
  }

  dimension: is_converting_session {
    type: yesno
    sql: ${TABLE}.is_converting_session ;;
  }

















  dimension: session_utm_campaign {
    group_label: " Acquisition"

    type: string
    label: "Session UTM Campaign"
    sql: ${TABLE}.utm_campaign ;;
  }

  dimension: session_utm_content {
    group_label: " Acquisition"

    label: "Session UTM Content"

    type: string
    sql: ${TABLE}.utm_content ;;
  }

  dimension: session_utm_medium {
    group_label: " Acquisition"

    label: "Session UTM Medium"

    type: string
    sql: ${TABLE}.utm_medium ;;
  }

  dimension: session_utm_source {
    group_label: " Acquisition"

    label: "Session UTM Source"

    type: string
    sql: ${TABLE}.utm_source ;;
  }

  dimension: session_utm_term {
    group_label: " Acquisition"

    type: string
    sql: ${TABLE}.utm_term ;;
  }



  measure: count {
    type: count
    drill_fields: []
  }
}
