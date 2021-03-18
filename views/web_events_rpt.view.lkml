view: web_events_rpt {
  sql_table_name: `{{ _user_attributes['dataset'] }}.web_events_rpt`
    ;;

  dimension: blended_user_id {
    type: string
    sql: ${TABLE}.blended_user_id ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: cta_link {
    type: string
    sql: ${TABLE}.cta_link ;;
  }

  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
  }

  dimension: device_category {
    type: string
    sql: ${TABLE}.device_category ;;
  }

  dimension: duration_in_s {
    type: number
    sql: ${TABLE}.duration_in_s ;;
  }

  dimension: duration_in_s_tier {
    type: string
    sql: ${TABLE}.duration_in_s_tier ;;
  }

  dimension: event {
    hidden: yes
    sql: ${TABLE}.event ;;
  }

  dimension: events {
    type: number
    sql: ${TABLE}.events ;;
  }

  dimension: first_page_url {
    type: string
    sql: ${TABLE}.first_page_url ;;
  }

  dimension: first_page_url_host {
    type: string
    sql: ${TABLE}.first_page_url_host ;;
  }

  dimension: first_page_url_path {
    type: string
    sql: ${TABLE}.first_page_url_path ;;
  }

  dimension: gclid {
    type: string
    sql: ${TABLE}.gclid ;;
  }

  dimension: global_session_seq_num {
    type: number
    sql: ${TABLE}.global_session_seq_num ;;
  }

  dimension: is_bounced_session {
    type: yesno
    sql: ${TABLE}.is_bounced_session ;;
  }

  dimension: keyword {
    type: string
    sql: ${TABLE}.keyword ;;
  }

  dimension: last_page_url {
    type: string
    sql: ${TABLE}.last_page_url ;;
  }

  dimension: last_page_url_host {
    type: string
    sql: ${TABLE}.last_page_url_host ;;
  }

  dimension: last_page_url_path {
    type: string
    sql: ${TABLE}.last_page_url_path ;;
  }

  dimension: marketing_campaign {
    type: string
    sql: ${TABLE}.marketing_campaign ;;
  }

  dimension: mins_between_sessions {
    type: number
    sql: ${TABLE}.mins_between_sessions ;;
  }

  dimension: referrer_host {
    type: string
    sql: ${TABLE}.referrer_host ;;
  }

  dimension: referrer_medium {
    type: string
    sql: ${TABLE}.referrer_medium ;;
  }

  dimension: referrer_source {
    type: string
    sql: ${TABLE}.referrer_source ;;
  }

  dimension: search {
    type: string
    sql: ${TABLE}.search ;;
  }

  dimension_group: session_end_ts {
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
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: session_seq_num {
    type: number
    sql: ${TABLE}.session_seq_num ;;
  }

  dimension_group: session_start_ts {
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

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: visitor_id {
    type: string
    sql: ${TABLE}.visitor_id ;;
  }

  dimension: web_sessions_pk {
    type: string
    sql: ${TABLE}.web_sessions_pk ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

view: web_events_rpt__event {
  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: event_details {
    type: string
    sql: ${TABLE}.event_details ;;
  }

  dimension: event_num {
    type: number
    sql: ${TABLE}.event_num ;;
  }

  dimension_group: event_ts {
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
    sql: ${TABLE}.event_ts ;;
  }

  dimension: event_type {
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: lat_long {
    type: string
    sql: ${TABLE}.lat_long ;;
  }

  dimension: page_title {
    type: string
    sql: ${TABLE}.page_title ;;
  }

  dimension: page_url {
    type: string
    sql: ${TABLE}.page_url ;;
  }

  dimension: page_url_host {
    type: string
    sql: ${TABLE}.page_url_host ;;
  }

  dimension: page_url_path {
    type: string
    sql: ${TABLE}.page_url_path ;;
  }

  dimension: page_view_count {
    type: number
    sql: ${TABLE}.page_view_count ;;
  }

  dimension: session_event_num {
    type: number
    sql: ${TABLE}.session_event_num ;;
  }

  dimension: time_on_page_secs {
    type: number
    sql: ${TABLE}.time_on_page_secs ;;
  }
}