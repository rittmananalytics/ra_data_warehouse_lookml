view: ad_campaigns_dim {
  sql_table_name: `{{ _user_attributes['dataset'] }}.ad_campaigns_dim`
    ;;

  dimension_group: ad_campaign_end {
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
    sql: ${TABLE}.ad_campaign_end_date ;;
  }

  dimension: ad_campaign_id {
    type: string
    sql: ${TABLE}.ad_campaign_id ;;
  }

  dimension: ad_campaign_name {
    type: string
    sql: ${TABLE}.ad_campaign_name ;;
  }

  dimension: ad_campaign_pk {
    type: string
    sql: ${TABLE}.ad_campaign_pk ;;
  }

  dimension_group: ad_campaign_start {
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
    sql: ${TABLE}.ad_campaign_start_date ;;
  }

  dimension: ad_campaign_status {
    type: string
    sql: ${TABLE}.ad_campaign_status ;;
  }

  dimension: ad_network {
    type: string
    sql: ${TABLE}.ad_network ;;
  }

  dimension: campaign_buying_type {
    type: string
    sql: ${TABLE}.campaign_buying_type ;;
  }

  dimension: utm_campaign {
    type: string
    sql: ${TABLE}.utm_campaign ;;
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
    drill_fields: [ad_campaign_name]
  }
}