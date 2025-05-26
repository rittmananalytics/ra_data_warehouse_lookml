view: web_sessions_fact {
  sql_table_name: `{{ _user_attributes['dataset'] }}.web_sessions_fact`
    ;;



  parameter: time_range {
    type: string
    allowed_value: {
      label: "Last 7 Days"
      value: "7"
    }
    allowed_value: {
      label: "Last 30 Days"
      value: "30"
    }
    allowed_value: {
      label: "Last 90 Days"
      value: "90"
    }
    allowed_value: {
      label: "Last 180 days"
      value: "180"
    }
    allowed_value: {
      label: "Last 365 days"
      value: "365"
    }

    }

  dimension: blended_user_id {
    group_label: "  Audience"

    hidden: no
    type: string
    sql: ${TABLE}.blended_user_id ;;
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
    sql: timestamp_diff(${session_start_ts_raw},${page_first_published.page_first_session_start_ts_raw},DAY)  ;;
  }

  dimension: referrer_days_since_post_tier {
    type: tier
    group_label: "    Acquisition"
    tiers: [1,2,3,4,5,6,7,14,28,90,180,365,730]
    sql: ${referrer_days_since_post} ;;
    style: interval

  }

  dimension: events {
    group_label: "Behavior"
    label: "Session Events"
    type: number
    sql: ${TABLE}.events ;;
  }

  measure: count_of_events {
    type: sum #?
    sql: ${events} ;;
  }

  dimension: first_page_title {
    label: "Entrance Page Title"
    group_label: "Behavior"
    type: string
    sql: ${TABLE}.first_page_title ;;
  }

  dimension: first_page_category {
    label: "Entrance Page Category"

    group_label: "Behavior"
    type: string
    sql:
              case when ${TABLE}.first_page_url like '%blog%' or ${TABLE}.first_page_url like '%rittmananalytics.com/202%' or  ${TABLE}.first_page_title like '%Videos — Rittman Analytics%' then '01: Blog'
                  when ${TABLE}.first_page_url like '%drilltodetail%' or ${TABLE}.first_page_url like '%podcast%' then '01: Podcast'
                  when ${TABLE}.first_page_url = '/' or ${TABLE}.first_page_url like '%home-index%' or ${TABLE}.first_page_title like '%Scale your Analytics — Rittman Analytics%' then '01: Home Page'
                  when ${TABLE}.first_page_url like '%/services/%' or ${TABLE}.first_page_url like '%/offers/%' or ${TABLE}.first_page_title like '%Project Discovery — Rittman Analytics%' or ${TABLE}.first_page_title like '%Looker GenAI — Rittman Analytics%' or ${TABLE}.first_page_title like '%Looker Jumpstart — Rittman Analytics%' or ${TABLE}.first_page_title like '%Generative AI — Rittman Analytics%' then '04: Service'
                  when ${TABLE}.first_page_url like '%/about/%' or ${TABLE}.first_page_url like '%/contact%' or ${TABLE}.first_page_url like '%/faqs/%' or ${TABLE}.first_page_url like '%scv-contact-us-form%' then '08: Contact'
                  when ${TABLE}.first_page_url like '%sidebar%' then 'Misc'
                  when ${TABLE}.first_page_url like '%/assistant%' then '06: Assistant'
                  when ${TABLE}.first_page_url like '%/pricing%' or ${TABLE}.first_page_url like '%/engagement-model%' or ${TABLE}.first_page_url like '%/how-we-work%' then '12: Commercials'
                  when ${TABLE}.first_page_url like '%scv-thank-you%' or ${TABLE}.first_page_url like '%/modern-data-stack-thank-you%' then '08: Goal Achieved'
                  when ${TABLE}.first_page_url like '%causal-analytics%' or ${TABLE}.first_page_url like '/scv-download-hubspot-form' then '02: Landing Page'
                  when ${TABLE}.first_page_url like '%causal-analytics-video%' or ${TABLE}.first_page_url like '%download-10-ways-your-modern-data-stack-can-fail%' or ${TABLE}.first_page_url like '%download-page%' then '04: Gated Content'
                  when ${TABLE}.first_page_url like '%industries%' or ${TABLE}.first_page_url like '%about%' or ${TABLE}.first_page_url like '%partners%' or ${TABLE}.first_page_title like '%Data Analytics Project Checklist — Rittman Analytics%' then '02: Marketing'
                  when ${TABLE}.first_page_url like '%case-studies%' then '03: Case Study'
                  when ${TABLE}.first_page_url like '%calendly%' then '06: Conversion'
              end
         ;;
  }

  dimension: first_page_url {
    label: "Entrance Page URL"
    group_label: "Behavior"
    type: string
    sql: rtrim(${TABLE}.first_page_url,"/") ;;
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
    sql: rtrim(${TABLE}.first_page_url_path,"/") ;;
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

  dimension: last_page_title {
    group_label: "Behavior"
    label: "Exit Page Title"

    type: string
    sql: ${TABLE}.last_page_title ;;
  }

  dimension: last_page_url {
    group_label: "Behavior"
    label: "Exit Page URL"


    type: string
    sql: rtrim(${TABLE}.last_page_url,"/") ;;
  }

  dimension: last_page_category {
    label: "Exit Page Category"

    group_label: "Behavior"
    type: string
    sql:
              case when ${TABLE}.last_page_url like '%blog%' or ${TABLE}.last_page_url like '%rittmananalytics.com/202%' then '01: Blog'
                  when ${TABLE}.last_page_url like '%drilltodetail%' or ${TABLE}.last_page_url like '%podcast%' then '01: Podcast'
                  when ${TABLE}.last_page_url = '/' or ${TABLE}.last_page_url like '%home-index%' then '01: Home Page'
                  when ${TABLE}.last_page_url like '%/services/%' or ${TABLE}.last_page_url like '%/offers/%' then '04: Service'
                  when ${TABLE}.last_page_url like '%/about/%' or ${TABLE}.last_page_url like '%/contact%' or ${TABLE}.last_page_url like '%/faqs/%' or ${TABLE}.last_page_url like '%scv-contact-us-form%' then '08: Contact'
                  when ${TABLE}.last_page_url like '%sidebar%' then 'Misc'
                  when ${TABLE}.last_page_url like '%/assistant%' then '06: Assistant'
                  when ${TABLE}.last_page_url like '%/pricing%' or ${TABLE}.last_page_url like '%/engagement-model%' or ${TABLE}.last_page_url like '%/how-we-work%' then '12: Commercials'
                  when ${TABLE}.last_page_url like '%scv-thank-you%' or ${TABLE}.last_page_url like '%/modern-data-stack-thank-you%' then '08: Goal Achieved'
                  when ${TABLE}.last_page_url like '%causal-analytics%' or ${TABLE}.last_page_url like '/scv-download-hubspot-form' then '02: Landing Page'
                  when ${TABLE}.last_page_url like '%causal-analytics-video%' or ${TABLE}.last_page_url like '%download-10-ways-your-modern-data-stack-can-fail%' or ${TABLE}.last_page_url like '%download-page%' then '04: Gated Content'
                  when ${TABLE}.last_page_url like '%industries%' or ${TABLE}.last_page_url like '%about%' or ${TABLE}.last_page_url like '%partners%'then '02: Marketing'
                  when ${TABLE}.last_page_url like '%case-studies%' then '03: Case Study'
                  when ${TABLE}.last_page_url like '%calendly%' then '06: Conversion'
              end
         ;;
  }


  dimension: last_page_url_host {
    label: "Exit Page URL Host"

    group_label: "Behavior"
    type: string
    sql: ${TABLE}.last_page_url_host ;;
  }

  dimension: last_page_url_path {
    label: "Exit Page URL Path"

    group_label: "Behavior"
    type: string
    sql: rtrim(${TABLE}.last_page_url_path,"/") ;;
  }

  dimension: mins_between_sessions {
    group_label: "Behavior"
    type: number
    sql: ${TABLE}.mins_between_sessions ;;
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



  measure: total_session_duration_in_s {
    description: "The time spanned from the beginning to the end of a session in Seconds."
    type: average
    label: "Avg Session Duration (mins)"
    value_format: "mm:ss"
    sql: timestamp_diff(${TABLE}.session_end_ts,${TABLE}.session_start_ts,MINUTE) ;;
  }

  measure: total_sessions {
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
    sql: SAFE_DIVIDE(COUNT(DISTINCT(case when ${is_bounced_session} = TRUE then ${web_sessions_pk} end)),${total_sessions})  ;;
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





  dimension: web_sessions_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.web_sessions_pk ;;
  }

  dimension: is_converted_user {
    group_label: "Behavior"

    type: yesno
    sql: ${TABLE}.is_converting_blended_user_id ;;
  }

  dimension: is_converting_session {
    group_label: "Behavior"

    type: yesno
    sql: ${TABLE}.is_conversion_session ;;
  }

  dimension: channel {
    group_label: " Acquisition"
    type: string
    sql: case when ${session_utm_source} in ('linkedin','facebook') and ${session_utm_medium} = 'paid' then 'Paid Social'
              when (${session_utm_source} = 'linkedin' or ${referrer_host} like '%linkedin%') and ${session_utm_medium} != 'paid' then 'Organic Social'
              when ${TABLE}.channel = 'Social' then 'Organic Social'
              when ${TABLE}.channel in ('facebook','linkedin') and ${session_utm_medium} = 'social' then 'Organic Social'
              when ${session_utm_medium} = 'social' and ${TABLE}.channel = 'Direct' then 'Organic Social'
              when ${session_utm_source} = 'substack' and ${session_utm_medium} != 'email' then 'Organic Social'
              when ${session_utm_source} like 'pocket_%' then 'Referral'
              when (${referrer_host} like '%rittmananalytics.com%' and ${referrer_host} not like '%blog.rittmananalytics.com%') or ${referrer_host} like 'calendly.com' then 'Direct'
              when ${referrer_host} like '%medium.com%' or ${referrer_host} like '%blog.rittmananalytics.com%'  then 'Organic Social'
              else ${TABLE}.channel end;;
  }

  dimension: channel_category {
    group_label: " Acquisition"
    type: string
    sql: case when ${channel} in ('Paid Social','Paid Search') then 'Paid'
              when ${channel} in ('Organic Social','Organic Video','Organic Search','Email','Referral') then 'Organic'
              else ${channel} end;;
  }















  dimension: session_utm_campaign {
    group_label: " Acquisition"

    type: string
    label: "Session UTM Campaign"
    sql: lower(${TABLE}.utm_campaign) ;;
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
    sql: lower(${TABLE}.utm_medium) ;;
  }

  dimension: session_utm_source {
    group_label: " Acquisition"

    label: "Session UTM Source"

    type: string
    sql: replace(replace(lower(${TABLE}.utm_source),'/',''),'.com','') ;;
  }

  dimension: session_utm_term {
    group_label: " Acquisition"

    type: string
    sql: ${TABLE}.utm_term ;;
  }




}
