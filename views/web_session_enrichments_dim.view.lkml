view: web_session_enrichments_dim {
  view_label: "Session Enrichments"
  sql_table_name: `{{ _user_attributes['dataset'] }}.web_session_enrichments_dim`
    ;;

  dimension: blended_user_id {
    hidden: yes
    type: string
    sql: ${TABLE}.blended_user_id ;;
  }

  dimension: web_sessions_pk {
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.web_sessions_pk ;;
  }

  dimension: company_tags {
    type: string
    sql: ${TABLE}.company_tags ;;
  }

  dimension: enriched_company_category_industry {
    type: string
    sql: ${TABLE}.enriched_company_category_industry ;;
  }

  dimension: enriched_company_category_industry_group {
    type: string
    sql: ${TABLE}.enriched_company_category_industry_group ;;
  }

  dimension: enriched_company_category_sector {
    type: string
    sql: ${TABLE}.enriched_company_category_sector ;;
  }

  dimension: enriched_company_category_sub_industry {
    type: string
    sql: ${TABLE}.enriched_company_category_sub_industry ;;
  }

  dimension: enriched_company_crunchbase_handle {
    type: string
    sql: ${TABLE}.enriched_company_crunchbase_handle ;;
  }

  dimension: enriched_company_description {
    type: string
    sql: ${TABLE}.enriched_company_description ;;
  }

  dimension: enriched_company_domain {
    type: string
    sql: ${TABLE}.enriched_company_domain ;;
  }

  dimension: enriched_company_domain_aliases {
    type: string
    sql: ${TABLE}.enriched_company_domain_aliases ;;
  }

  dimension: enriched_company_geo_city {
    type: string
    sql: ${TABLE}.enriched_company_geo_city ;;
  }

  dimension: enriched_company_geo_country {
    type: string
    sql: ${TABLE}.enriched_company_geo_country ;;
  }

  dimension: enriched_company_geo_country_code {
    type: string
    sql: ${TABLE}.enriched_company_geo_country_code ;;
  }

  dimension: enriched_company_geo_lat {
    type: number
    sql: ${TABLE}.enriched_company_geo_lat ;;
  }

  dimension: enriched_company_geo_lng {
    type: number
    sql: ${TABLE}.enriched_company_geo_lng ;;
  }

  dimension: enriched_company_geo_postal_code {
    type: string
    sql: ${TABLE}.enriched_company_geo_postal_code ;;
  }

  dimension: enriched_company_geo_state {
    type: string
    sql: ${TABLE}.enriched_company_geo_state ;;
  }

  dimension: enriched_company_geo_state_code {
    type: string
    sql: ${TABLE}.enriched_company_geo_state_code ;;
  }

  dimension: enriched_company_geo_street_name {
    type: string
    sql: ${TABLE}.enriched_company_geo_street_name ;;
  }

  dimension: enriched_company_geo_street_number {
    type: string
    sql: ${TABLE}.enriched_company_geo_street_number ;;
  }

  dimension: enriched_company_geo_sub_premise {
    type: string
    sql: ${TABLE}.enriched_company_geo_sub_premise ;;
  }

  dimension: enriched_company_legal_name {
    type: string
    sql: ${TABLE}.enriched_company_legal_name ;;
  }

  dimension: enriched_company_linkedin_handle {
    type: string
    sql: ${TABLE}.enriched_company_linkedin_handle ;;
  }

  dimension: enriched_company_location {
    type: string
    sql: ${TABLE}.enriched_company_location ;;
  }

  dimension: enriched_company_logo {
    type: string
    sql: ${TABLE}.enriched_company_logo ;;
  }

  dimension: enriched_company_metrics_alexa_global_rank {
    type: number
    sql: ${TABLE}.enriched_company_metrics_alexa_global_rank ;;
  }

  dimension: enriched_company_metrics_alexa_us_rank {
    type: number
    sql: ${TABLE}.enriched_company_metrics_alexa_us_rank ;;
  }

  dimension: enriched_company_metrics_annual_revenue {
    type: number
    sql: ${TABLE}.enriched_company_metrics_annual_revenue ;;
  }

  dimension: enriched_company_metrics_employees {
    type: number
    sql: ${TABLE}.enriched_company_metrics_employees ;;
  }

  dimension: enriched_company_metrics_employees_range {
    type: string
    sql: ${TABLE}.enriched_company_metrics_employees_range ;;
  }

  dimension: enriched_company_metrics_estimated_annual_revenue {
    type: string
    sql: ${TABLE}.enriched_company_metrics_estimated_annual_revenue ;;
  }

  dimension: enriched_company_metrics_market_cap {
    type: number
    sql: ${TABLE}.enriched_company_metrics_market_cap ;;
  }

  dimension: enriched_company_metrics_raised {
    type: number
    sql: ${TABLE}.enriched_company_metrics_raised ;;
  }

  dimension: enriched_company_name {
    type: string
    sql: ${TABLE}.enriched_company_name ;;
  }

  dimension: enriched_company_phone {
    type: string
    sql: ${TABLE}.enriched_company_phone ;;
  }

  dimension: enriched_company_site_email_addresses {
    type: string
    sql: ${TABLE}.enriched_company_site_email_addresses ;;
  }

  dimension: enriched_company_site_phone_numbers {
    type: string
    sql: ${TABLE}.enriched_company_site_phone_numbers ;;
  }

  dimension: enriched_company_tech {
    type: string
    sql: ${TABLE}.enriched_company_tech ;;
  }

  dimension: enriched_company_ticker {
    type: string
    sql: ${TABLE}.enriched_company_ticker ;;
  }

  dimension: enriched_company_time_zone {
    type: string
    sql: ${TABLE}.enriched_company_time_zone ;;
  }

  dimension: enriched_company_twitter_followers {
    type: number
    sql: ${TABLE}.enriched_company_twitter_followers ;;
  }

  dimension: enriched_company_twitter_following {
    type: number
    sql: ${TABLE}.enriched_company_twitter_following ;;
  }

  dimension: enriched_company_twitter_handle {
    type: string
    sql: ${TABLE}.enriched_company_twitter_handle ;;
  }

  dimension: enriched_company_type {
    type: string
    sql: ${TABLE}.enriched_company_type ;;
  }

  dimension: enriched_company_utc_offset {
    type: number
    sql: ${TABLE}.enriched_company_utc_offset ;;
  }

  dimension: enriched_fuzzy {
    type: yesno
    sql: ${TABLE}.enriched_fuzzy ;;
  }

  dimension_group: event_ts {
    hidden: yes

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

  dimension: session_id {
    hidden: yes

    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: user_id {
    hidden: yes

    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: visitor_id {
    hidden: yes

    type: string
    sql: ${TABLE}.visitor_id ;;
  }

  measure: count {
    type: count
    drill_fields: [enriched_company_name, enriched_company_legal_name, enriched_company_geo_street_name]
  }
}