view: web_events_fact {
  derived_table: {
    sql: select * except(page_title),
              replace(page_title,'—','-') as page_title,
              min(event_ts) over (partition by replace(page_title,'—','-') order by event_ts) as page_title_published_at_ts,
              date_diff(date(event_ts),date(min(event_ts) over (partition by replace(page_title,'—','-') order by event_ts)), month) as months_since_page_title_published_at_ts,
              date_diff(date(event_ts),date(min(event_ts) over (partition by replace(page_title,'—','-') order by event_ts)), day) as days_since_page_title_published_at_ts,
              count(distinct case when event_type = 'Page View' then web_events_pk end) over (partition by replace(page_title,'—','-')) as total_page_views,
              count(distinct blended_user_id) over (partition by replace(page_title,'—','-')) as total_unique_viewers
       from web_events_fact;;
  }


  dimension: device {
    group_label: "  Audience"
    hidden:  yes
    description: "The type of device used to access the page, e.g Android, Macintosh, windows etc. This usually includes the device model and operating system version."
    type: string
    sql: ${TABLE}.device ;;
  }

  dimension: device_category {
    hidden: yes
    group_label: "  Audience"
    description: "A simplified version of Device field without OS/Browser detail. e.g 'iPhone','Android','iPad','Windows' etc"
    type: string
    sql: ${TABLE}.device_category ;;
  }

  dimension: event_details {
    group_label: "Behavior"
    type: string
    sql: ${TABLE}.event_details ;;
  }

  dimension: event_id {
    hidden: yes
    type: string
    sql: ${TABLE}.event_id ;;
  }

  dimension: event_in_session_seq {
    group_label: "Behavior"
    label: "Session Event Num"
    type: number
    sql: ${TABLE}.event_in_session_seq ;;
  }

  dimension: event_number {
    group_label: "Behavior"
    hidden: yes
    type: number
    sql: ${TABLE}.event_seq ;;
  }

  dimension_group: event_ts {
    group_label: "Dates"
    type: time
    timeframes: [
      raw,
      time,
      week,
      month,
      date,
      day_of_week,
      day_of_month,
      hour_of_day,
      hour,
      hour3,
      quarter_of_year,
      quarter,
      year
    ]
    sql: ${TABLE}.event_ts ;;
  }

  dimension: event_type {
    group_label: "Behavior"
    type: string
    sql: ${TABLE}.event_type ;;
  }

  measure: event {
    type: string
    sql: array_agg(${event_type})[safe_offset(0)] ;;
  }

  measure: event_type_details {
    type: string
    sql: array_agg(coalesce(${event_details},"None"))[safe_offset(0)];;
  }



  dimension: map_location {
    group_label: "  Audience"
    type: location
    sql_latitude: ${TABLE}.latitude ;;
    sql_longitude: ${TABLE}.longitude ;;
  }

  dimension: locale_code {
    group_label: "  Audience"
    type: string
    sql: ${TABLE}.locale_code ;;
  }

  dimension: longitude {
    hidden: yes
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: metro_code {
    group_label: "  Audience"
    type: string
    sql: ${TABLE}.metro_code ;;
  }

  dimension: network {
    hidden: yes
    type: string
    sql: ${TABLE}.network ;;
  }



  dimension: page_title {
    group_label: "Behavior"
    type: string
    sql: ${TABLE}.page_title ;;
  }

  dimension_group: page_published {
    group_label: "Behavior"
    type: time
    timeframes: [date,month,quarter,year]
    sql: ${TABLE}.page_title_published_at_ts ;;
  }

  dimension: months_since_page_published {
    group_label: "Behavior"
    type: number
    sql: ${TABLE}.months_since_page_title_published_at_ts ;;
  }

  dimension: page_total_page_views {
    group_label: "Behavior"
    type: number
    sql: ${TABLE}.total_page_views ;;
  }



  dimension: page_total_unique_viewers {
  group_label: "Behavior"
  type: number
  sql: ${TABLE}.total_unique_viewers ;;
  }


  dimension: page_url {
    group_label: "Behavior"
    type: string
    sql: ${TABLE}.page_url ;;
  }

  dimension: page_url_host {
    group_label: "Behavior"
    type: string
    sql: ${TABLE}.page_url_host ;;
  }

  dimension: page_url_path {
    group_label: "Behavior"
    type: string
    sql: ${TABLE}.page_url_path ;;
  }

  dimension: page_category {
    group_label: "Behavior"
    type: string
    sql: ${TABLE}.page_category;;
  }

  dimension: visit_value {
    type: number
    hidden: no
    sql: case when ${is_conversion_event} then 16 else safe_cast(split(${TABLE}.page_category,":")[SAFE_OFFSET(0)] as int64) end;;

  }

  dimension: is_conversion_event {
    type: yesno
    group_label: "Behavior"
    sql: ${TABLE}.event_type = 'Meeting Booked' ;;
  }



  dimension: is_goal_achieved {
    type: yesno
    group_label: "Behavior"
    sql: ${TABLE}.event_type = 'Pressed Button' and (lower(${TABLE}.event_details) like '%#contact%' or ${TABLE}.event_details = '#'  or lower(${TABLE}.event_details) like '%calendly%');;
  }

  measure: total_conversions {
    type: count_distinct
    value_format_name: decimal_0
    sql: ${web_events_pk} ;;
    filters: [is_conversion_event: "Yes"]
  }

  measure: total_goal_achieveds {
    value_format_name: decimal_0
    type: count_distinct
    sql: ${web_events_pk} ;;
    filters: [is_goal_achieved: "Yes"]
  }

  measure: total_session_conversions {
    value_format_name: decimal_0
    type: count_distinct
    sql: ${session_id} ;;
    filters: [is_conversion_event: "Yes"]
  }

  measure: total_user_conversions {
    value_format_name: decimal_0
    type: count_distinct
    sql: ${blended_user_id} ;;
    filters: [is_conversion_event: "Yes"]
  }

  measure: total_session_goal_achieveds {
    value_format_name: decimal_0
    type: count_distinct
    sql: ${session_id} ;;
    filters: [is_goal_achieved: "Yes"]
  }

  measure: total_user_goal_achieveds {
    value_format_name: decimal_0
    type: count_distinct
    sql: ${blended_user_id} ;;
    filters: [is_goal_achieved: "Yes"]
  }

  measure: total_sessions {
    type: count_distinct
    value_format_name: decimal_0
    sql: ${session_id} ;;
  }

  measure: total_visitor_value {
    value_format_name: decimal_0
    type: sum
    sql: ${visit_value};;
  }

  measure: avg_session_value {
    value_format_name: decimal_2

    type: number
    sql: ${total_visitor_value}/${total_sessions} ;;
  }

  dimension: postal_code {
   map_layer_name: us_zipcode_tabulation_areas
    type: string
    sql: ${TABLE}.postal_code ;;
  }



  dimension_group: prev_event_ts {
    group_label: "Dates"
    hidden: yes
    type: time
    timeframes: [
      time,
      month,
      date
    ]
    sql: ${TABLE}.prev_event_ts ;;
  }

  dimension: prev_event_type {
    group_label: "Conversions"
    hidden: yes
    type: string
    sql: ${TABLE}.prev_event_type ;;
  }

  #dimension: referrer_host {
  #  group_label: "    Acquisition"
  #  type: string
  #  sql: ${TABLE}.referrer_host ;;
  #}

  dimension: search {
    group_label: "    Acquisition"
    hidden: yes
    type: string
    sql: ${TABLE}.search ;;
  }

  dimension: session_id {
    hidden: no
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: site {
    group_label: "Behavior"
    type: string
    sql: ${TABLE}.site ;;
  }

  measure: total_blended_user_id {
    label: "Total Unique Users"
    description: "The total number of unique people viewing the site."
    value_format_name: decimal_0
    type: count_distinct
    sql: ${TABLE}.blended_user_id ;;
    drill_fields: [device, blended_user_id, device_category, subscription_fact.channel]
  }

  dimension: blended_user_id {
    hidden: yes
    type: string
    sql: ${TABLE}.blended_user_id ;;
  }



  measure: total_page_views {
    value_format_name: decimal_0
    hidden: no
    type: count_distinct
    sql: case when ${TABLE}.event_type = 'Page View' then ${TABLE}.web_events_pk end;;
  }

  measure: total_marketing_page_views {
    value_format_name: decimal_0
    hidden: no
    type: count_distinct
    sql: case when ${TABLE}.event_type = 'Page View' then ${TABLE}.web_events_pk end ;;
    filters: [page_category: "04: Marketing"]
  }

  measure: total_case_study_page_views {
    value_format_name: decimal_0
    hidden: no
    type: count_distinct
    sql: case when ${TABLE}.event_type = 'Page View' then ${TABLE}.web_events_pk end ;;
    filters: [page_category: "06: Case Study"]
  }

  measure: total_services_page_views {
    value_format_name: decimal_0
    hidden: no
    type: count_distinct
    sql: case when ${TABLE}.event_type = 'Page View' then ${TABLE}.web_events_pk end ;;
    filters: [page_category: "08: Services"]
  }

  measure: total_blog_page_views {
    value_format_name: decimal_0
    hidden: no
    type: count_distinct
    sql: case when ${TABLE}.event_type = 'Page View' then ${TABLE}.web_events_pk end ;;
    filters: [page_category: "02: Social"]
  }

  dimension: time_on_page_secs {
    hidden: yes
    type: number
    sql: ${TABLE}.time_on_page_secs ;;
  }

  dimension: time_zone {
    hidden: yes
    type: string
    sql: ${TABLE}.time_zone ;;
  }

  dimension: user_id {
    hidden: no
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: utm_campaign {
    group_label: "    Acquisition"
    label: "Event UTM Campaign"
    type: string
    sql: ${TABLE}.utm_campaign ;;
  }

  dimension: utm_content {
    group_label: "    Acquisition"
    label: "Event UTM Content"
    type: string
    sql: ${TABLE}.utm_content ;;
  }

  dimension: utm_medium {
    group_label: "    Acquisition"
    label: "Event UTM Medium"
    type: string
    sql: ${TABLE}.utm_medium ;;
  }

  dimension: utm_source {
    group_label: "    Acquisition"
    label: "Event UTM Source"
    type: string
    sql: ${TABLE}.utm_source ;;
  }

  dimension: utm_term {
    group_label: "    Acquisition"
    label: "Event UTM Keyword"
    type: string
    sql: ${TABLE}.utm_term ;;
  }

  dimension: visitor_id {
    label: "Anonymous (Device) ID "
    hidden: no
    type: string
    sql: ${TABLE}.visitor_id ;;
  }

  dimension: web_events_pk {
    group_label: "Behavior"

    hidden: no
    primary_key:  yes
    type: string
    sql: ${TABLE}.web_events_pk ;;
  }

  measure: total_events {
    group_label: "Behavior"
    type: count_distinct
    sql: ${web_events_pk} ;;
  }








  dimension: event_seq {
    group_label: "Behavior"

    type: number
    sql: ${TABLE}.event_seq ;;
  }





  dimension: gclid {
    group_label: "  Audience"

    type: string
    sql: ${TABLE}.gclid ;;
  }

  dimension: ip {
    group_label: "  Audience"

    type: string
    sql: ${TABLE}.ip ;;
  }





  dimension: referrer_host {
    group_label: "    Acquisition"

    type: string
    sql: ${TABLE}.referrer_host ;;
  }

  dimension: referrer {
    group_label: "    Acquisition"

    type: string
    sql: split(${TABLE}.referrer, "?")[SAFE_OFFSET(0)] ;;
  }

  dimension: referrer_source {
    group_label: "    Acquisition"
    type: string
    sql: case when ${referrer} like '%blog.rittmananalytics.com%' or ${referrer} like '%medium.com/mark-rittman%' then 'Medium' end ;;
  }

  dimension: referrer_article_stub {
    group_label: "    Acquisition"
    type: string
    sql: case when ${referrer_source} = 'Medium' and ${referrer_host} = 'blog.rittmananalytics.com' then split(${referrer},'/')[safe_offset(3)]
              when ${referrer_source} = 'Medium' and ${referrer_host} = 'medium.com' then split(${referrer},'/')[safe_offset(4)]
          end ;;

  }



  dimension: event_details_seq_1 {
    group_label: "Event Sequence"
    type: string
    sql: case when event_seq = 1 then event_details end ;;
  }

  dimension: event_details_seq_2 {
    group_label: "Event Sequence"
    type: string
    sql: case when event_seq = 2 then event_details end ;;
  }

  dimension: event_details_seq_3 {
    group_label: "Event Sequence"
    type: string
    sql: case when event_seq = 3 then event_details end ;;
  }

  dimension: event_details_seq_4 {
    group_label: "Event Sequence"
    type: string
    sql: case when event_seq = 4 then event_details end ;;
  }

  dimension: event_details_seq_5 {
    group_label: "Event Sequence"
    type: string
    sql: case when event_seq = 5 then event_details end ;;
  }

  dimension: event_type_seq_1 {
    group_label: "Event Sequence"
    type: string
    sql: case when event_seq = 1 then event_type end ;;
  }

  dimension: event_type_seq_2 {
    group_label: "Event Sequence"
    type: string
    sql: case when event_seq = 2 then event_type end ;;
  }

  dimension: event_type_seq_3 {
    group_label: "Event Sequence"
    type: string
    sql: case when event_seq = 3 then event_type end ;;
  }

  dimension: event_type_seq_4 {
    group_label: "Event Sequence"
    type: string
    sql: case when event_seq = 4 then event_type end ;;
  }

  dimension: event_type_seq_5 {
    group_label: "Event Sequence"
    type: string
    sql: case when event_seq = 5 then event_type end ;;
  }







}
