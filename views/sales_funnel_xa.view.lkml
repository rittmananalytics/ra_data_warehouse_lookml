# The name of this view in Looker is "Sales Funnel Xa"
view: sales_funnel_xa {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics.sales_funnel_xa`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Campaign" in Explore.

  dimension: campaign {
    hidden: yes

    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension: pk {
    type: string
    primary_key: yes
    hidden: yes
    sql: concat(${company_pk},${sales_funnel_interaction_seq}) ;;
  }

  dimension: company_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension: contact_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.contact_pk ;;
  }

  dimension: content {
    hidden: yes
    type: string
    sql: ${TABLE}.content ;;
  }

  dimension: conversion_interaction_seq {
    hidden: yes
    type: number
    sql: ${TABLE}.conversion_interaction_seq ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.



  dimension: days_to_conversion {
    hidden: yes

    type: number
    sql: ${TABLE}.days_to_conversion ;;
  }

  measure: avg_days_to_conversion {

    type: average
    sql: ${TABLE}.days_to_conversion ;;
  }

  dimension: device {
    hidden: yes
    type: string
    sql: ${TABLE}.device ;;
  }

  dimension: event_details {
    label: "       Funnel Event"
    type: string
    sql: ${TABLE}.event_details ;;
  }

  dimension: event_id {
    hidden: yes
    type: string
    sql: ${TABLE}.event_id ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: event_ts {
    label: "Funnel Event"
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
    label: "      Funnel Event Type"
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: event_value {
    hidden: yes
    type: number
    sql: ${TABLE}.event_value ;;
  }

  dimension: funnel_stage {
    type: number
    hidden: yes
    sql: ${TABLE}.funnel_stage ;;
  }

  dimension: funnel_stage_name {
    type: string
    label: "        Funnel Stage Name"
    sql: ${TABLE}.funnel_stage_name ;;
    order_by_field: funnel_stage
  }

  dimension_group: funnel_stage_enter_ts {
    label: "Funnel Stage Entrance"
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
    sql: ${TABLE}.funnel_stage_enter_ts ;;
  }

  dimension: has_converted {
    type: yesno
    sql: ${TABLE}.has_converted ;;
  }

  dimension: hours_from_last_interaction {
    hidden: yes
    type: number
    sql: ${TABLE}.hours_from_last_interaction ;;
  }

  measure: avg_hours_from_last_interaction {
    type: average
    sql: ${TABLE}.hours_from_last_interaction ;;
  }

  dimension: hours_to_next_interaction {
    hidden: yes

    type: number
    sql: ${TABLE}.hours_to_next_interaction ;;
  }

  dimension: is_first_conversion {
    type: yesno
    sql: ${TABLE}.is_first_conversion ;;
  }

  dimension: is_pre_conversion_interaction {
    hidden: yes

    type: yesno
    sql: ${TABLE}.is_pre_conversion_interaction ;;
  }

  dimension: keyword {
    hidden: yes

    type: string
    sql: ${TABLE}.keyword ;;
  }

  dimension: medium {
    hidden: yes

    type: string
    sql: ${TABLE}.medium ;;
  }

  dimension: referrer_host {
    hidden: yes

    type: string
    sql: ${TABLE}.referrer_host ;;
  }

  dimension: sales_funnel_interaction_seq {
    label: "    Funnel Stage Sequence"
    type: number
    sql: ${TABLE}.sales_funnel_interaction_seq ;;
  }

  dimension: sales_interaction_seq {
    label: "     Funnel Sequence"

    type: number
    sql: ${TABLE}.sales_interaction_seq ;;
  }

  dimension: search_term {
    hidden: yes

    type: string
    sql: ${TABLE}.search_term ;;
  }

  dimension: source {
    hidden: yes

    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: user_id {
    hidden: yes

    type: string
    sql: ${TABLE}.user_id ;;
  }

  measure: count_interactions {
    type: count
    drill_fields: []
  }


  measure: count_conversions {
    type: count_distinct
    sql: case when ${has_converted} then ${TABLE}.company_pk end;;
    drill_fields: []
  }

  measure: count_prospects {
    type: count_distinct
    sql: ${company_pk};;
    drill_fields: []
  }




}
