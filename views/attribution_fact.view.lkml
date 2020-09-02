view: attribution_fact {
  sql_table_name: `analytics.attribution_fact`
    ;;

  dimension: account_opening_session {
    type: yesno
    sql: ${TABLE}.account_opening_session ;;
  }

  dimension: blended_user_id {
    type: string
    sql: ${TABLE}.blended_user_id ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: conversion_session {
    type: yesno
    sql: ${TABLE}.conversion_session ;;
  }

  dimension_group: converted_ts {
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
    sql: ${TABLE}.converted_ts ;;
  }

  dimension: count_conversions {
    type: number
    sql: ${TABLE}.count_conversions ;;
  }

  dimension_group: created_account_ts {
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
    sql: ${TABLE}.created_account_ts ;;
  }

  dimension: even_click_attrib_conversions {
    type: number
    sql: ${TABLE}.even_click_attrib_conversions ;;
  }

  dimension: even_click_attrib_pct {
    type: number
    sql: ${TABLE}.even_click_attrib_pct ;;
  }

  dimension: event {
    type: number
    sql: ${TABLE}.event ;;
  }

  dimension: events {
    type: number
    sql: ${TABLE}.events ;;
  }

  dimension: first_click_attrib_conversions {
    type: number
    sql: ${TABLE}.first_click_attrib_conversions ;;
  }

  dimension: first_click_attrib_pct {
    type: number
    sql: ${TABLE}.first_click_attrib_pct ;;
  }

  dimension: last_click_attrib_conversions {
    type: number
    sql: ${TABLE}.last_click_attrib_conversions ;;
  }

  dimension: last_click_attrib_pct {
    type: number
    sql: ${TABLE}.LAST_click_attrib_pct ;;
  }

  dimension: referrer_domain {
    type: string
    sql: ${TABLE}.referrer_domain ;;
  }

  dimension: referrer_host {
    type: string
    sql: ${TABLE}.referrer_host ;;
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

  dimension: session_seq {
    type: number
    sql: ${TABLE}.session_seq ;;
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

  dimension: time_decay_attrib_conversions {
    type: number
    sql: ${TABLE}.time_decay_attrib_conversions ;;
  }

  dimension: time_decay_attrib_pct {
    type: number
    sql: ${TABLE}.time_decay_attrib_pct ;;
  }

  dimension: trialing_session {
    type: yesno
    sql: ${TABLE}.trialing_session ;;
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

  measure: count {
    type: count
    drill_fields: []
  }
}
