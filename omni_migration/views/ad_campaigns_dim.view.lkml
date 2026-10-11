view: ad_campaigns_dim {
  sql_table_name: `ra-development.analytics.ad_campaigns_dim` ;;

  dimension: ad_campaign_id {
    sql: ${TABLE}.ad_campaign_id ;;
  }

  dimension: ad_campaign_name {
    sql: ${TABLE}.ad_campaign_name ;;
  }

  dimension: ad_campaign_pk {
    primary_key: yes
    sql: ${TABLE}.ad_campaign_pk ;;
  }

  dimension: ad_campaign_status {
    sql: ${TABLE}.ad_campaign_status ;;
  }

  dimension: ad_network {
    sql: ${TABLE}.ad_network ;;
  }

  dimension: campaign_buying_type {
    sql: ${TABLE}.campaign_buying_type ;;
  }

  dimension: utm_campaign {
    sql: ${TABLE}.utm_campaign ;;
  }

  dimension: utm_medium {
    sql: ${TABLE}.utm_medium ;;
  }

  dimension: utm_source {
    sql: ${TABLE}.utm_source ;;
  }

  dimension_group: ad_campaign_end {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.ad_campaign_end_date ;;
  }

  dimension_group: ad_campaign_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.ad_campaign_start_date ;;
  }

  measure: count {
    type: count
    drill_fields: [ad_campaigns_dim.ad_campaign_name]
  }
}
