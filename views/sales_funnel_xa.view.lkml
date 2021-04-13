view: sales_funnel_xa {
  sql_table_name: `ra-development.analytics.sales_funnel_xa`
    ;;

  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension: company_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.company_pk ;;
  }

  measure: count_organizations {
    type: count_distinct
    sql: ${company_pk} ;;
  }

  measure: count_people {
    type: count_distinct
    sql: ${contact_pk} ;;
  }

  dimension: prospect_pk {
    hidden: yes

    type: string
    sql: coalesce(${contact_pk},${company_pk}) ;;
  }


  measure: count_prospects {
    type: count_distinct
    sql: ${prospect_pk} ;;
  }

  measure: count_trialist_prospects {
    type: count_distinct
    sql: ${prospect_pk} ;;
    filters: [funnel_stage: "4"]
  }

  measure: count_subscribing_prospects {
    type: count_distinct
    sql: ${prospect_pk} ;;
    filters: [funnel_stage: "5"]
  }

  measure: count_renewing_subscriber_prospects {
    type: count_distinct
    sql: ${prospect_pk} ;;
    filters: [funnel_stage: "6"]
  }


  dimension: contact_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_pk ;;
  }

  dimension: content {
    group_label: "Acquisition"

    type: string
    sql: ${TABLE}.content ;;
  }

  dimension: device {
    hidden: yes
    type: string
    sql: ${TABLE}.device ;;
  }

  dimension: event_details {
    label: "Funnel Stage Details"
    type: string
    sql: ${TABLE}.event_details ;;
  }

  dimension: event_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.event_id ;;
  }

  dimension_group: funnel_stage {
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
    label: "Funnel Stage"
    order_by_field: funnel_stage
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: event_value {
    label: "Funnel Stage Revenue"
    type: number
    sql: ${TABLE}.event_value ;;
  }

  dimension: funnel_stage {
    label: "Funnel Stage Number"
    type: number
    sql: ${TABLE}.funnel_stage ;;
  }

  dimension: keyword {
    group_label: "Acquisition"
    type: string
    sql: ${TABLE}.keyword ;;
  }

  dimension: medium {
    group_label: "Acquisition"

    type: string
    sql: ${TABLE}.medium ;;
  }

  dimension: referrer_host {
    group_label: "Acquisition"

    type: string
    sql: ${TABLE}.referrer_host ;;
  }

  dimension: search_term {
    group_label: "Acquisition"

    type: string
    sql: ${TABLE}.search_term ;;
  }

  dimension: source {
    group_label: "Acquisition"

    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
