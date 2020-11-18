view: web_events_fact {
  sql_table_name: `analytics.web_events_fact`
    ;;










  dimension: customer_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.customer_pk ;;
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
      time,
      date
    ]
    sql: ${TABLE}.event_ts ;;
  }

  dimension: event_type {
    group_label: "Behavior"
    type: string
    sql: ${TABLE}.event_type ;;
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
    sql: case when ${TABLE}.page_url_path like '%blog%' then 'Blog'
              when ${TABLE}.page_url_path like '%drilltodetail%' or ${TABLE}.page_url_path like '%podcast%' then 'Podcast'
              when ${TABLE}.page_url_path = '/' or ${TABLE}.page_url_path like '%home-index%' then 'Home Page'
              else 'Marketing' end;;
  }

  dimension: postal_code {
    group_label: "  Audience"
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
    hidden: no
    type: count_distinct
    sql: ${TABLE}.web_event_pk ;;
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
    hidden: yes
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
    hidden: yes
    type: string
    sql: ${TABLE}.visitor_id ;;
  }

  dimension: web_event_pk {
    group_label: "Behavior"

    hidden: no
    primary_key:  yes
    type: string
    sql: ${TABLE}.web_event_pk ;;
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









}
