view: companies_dim {
  sql_table_name: `analytics.companies_dim`
    ;;

  dimension: all_company_addresses {
    hidden: yes
    sql: ${TABLE}.all_company_addresses ;;
  }

  dimension: all_company_ids {
    type: string
    sql: ${TABLE}.all_company_ids ;;
  }

  dimension_group: company_created {
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
    sql: ${TABLE}.company_created_date ;;
  }

  dimension: company_currency_code {
    type: string
    sql: ${TABLE}.company_currency_code ;;
  }

  dimension: company_description {
    type: string
    sql: ${TABLE}.company_description ;;
  }

  dimension: company_enrichment_alexa_global_rank {
    type: number
    sql: ${TABLE}.company_enrichment_alexaGlobalRank ;;
  }

  dimension: company_enrichment_alexa_us_rank {
    type: string
    sql: ${TABLE}.company_enrichment_alexaUsRank ;;
  }

  dimension: company_enrichment_all_contact_emails {
    type: string
    sql: ${TABLE}.company_enrichment_all_contact_emails ;;
  }

  dimension: company_enrichment_all_contact_phones {
    type: string
    sql: ${TABLE}.company_enrichment_all_contact_phones ;;
  }

  dimension: company_enrichment_all_tags {
    type: string
    sql: ${TABLE}.company_enrichment_all_tags ;;
  }

  dimension: company_enrichment_all_technologies {
    type: string
    sql: ${TABLE}.company_enrichment_all_technologies ;;
  }

  dimension: company_enrichment_all_technology_categories {
    type: string
    sql: ${TABLE}.company_enrichment_all_technology_categories ;;
  }

  dimension: company_enrichment_all_website_domains {
    type: string
    sql: ${TABLE}.company_enrichment_all_website_domains ;;
  }

  dimension: company_enrichment_city {
    type: string
    sql: ${TABLE}.company_enrichment_city ;;
  }

  dimension: company_enrichment_company_stock_ticker {
    type: string
    sql: ${TABLE}.company_enrichment_company_stock_ticker ;;
  }

  dimension: company_enrichment_company_type {
    type: string
    sql: ${TABLE}.company_enrichment_company_type ;;
  }

  dimension: company_enrichment_country {
    type: string
    sql: ${TABLE}.company_enrichment_country ;;
  }

  dimension: company_enrichment_country_code {
    type: string
    sql: ${TABLE}.company_enrichment_country_code ;;
  }

  dimension: company_enrichment_crunchbase_user_name {
    type: string
    sql: ${TABLE}.company_enrichment_crunchbase_user_name ;;
  }

  dimension: company_enrichment_description {
    type: string
    sql: ${TABLE}.company_enrichment_description ;;
  }

  dimension: company_enrichment_employees_rang {
    type: string
    sql: ${TABLE}.company_enrichment_employeesRang ;;
  }

  dimension: company_enrichment_estimated_annual_revenue {
    type: string
    sql: ${TABLE}.company_enrichment_estimated_annual_revenue ;;
  }

  dimension: company_enrichment_facebook_total_likes {
    type: string
    sql: ${TABLE}.company_enrichment_facebook_total_likes ;;
  }

  dimension: company_enrichment_facebook_user_name {
    type: string
    sql: ${TABLE}.company_enrichment_facebook_user_name ;;
  }

  dimension: company_enrichment_fiscal_year_end {
    type: string
    sql: ${TABLE}.company_enrichment_fiscal_year_end ;;
  }

  dimension: company_enrichment_founded_year {
    type: number
    sql: ${TABLE}.company_enrichment_founded_year ;;
  }

  dimension: company_enrichment_geo_lat {
    type: number
    sql: ${TABLE}.company_enrichment_geo_lat ;;
  }

  dimension: company_enrichment_geo_long {
    type: number
    sql: ${TABLE}.company_enrichment_geo_long ;;
  }

  dimension: company_enrichment_id {
    type: string
    sql: ${TABLE}.company_enrichment_id ;;
  }

  dimension: company_enrichment_industry {
    type: string
    sql: ${TABLE}.company_enrichment_industry ;;
  }

  dimension: company_enrichment_industry_group {
    type: string
    sql: ${TABLE}.company_enrichment_industry_group ;;
  }

  dimension: company_enrichment_industry_sector {
    type: string
    sql: ${TABLE}.company_enrichment_industry_sector ;;
  }

  dimension: company_enrichment_is_email_provider {
    type: yesno
    sql: ${TABLE}.company_enrichment_is_email_provider ;;
  }

  dimension_group: company_enrichment_last_modified {
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
    sql: ${TABLE}.company_enrichment_last_modified_at ;;
  }

  dimension: company_enrichment_legal_name {
    type: string
    sql: ${TABLE}.company_enrichment_legalName ;;
  }

  dimension: company_enrichment_linkedin_user_name {
    type: string
    sql: ${TABLE}.company_enrichment_linkedin_user_name ;;
  }

  dimension: company_enrichment_location {
    type: string
    sql: ${TABLE}.company_enrichment_location ;;
  }

  dimension: company_enrichment_logo_url {
    type: string
    sql: ${TABLE}.company_enrichment_logo_url ;;
  }

  dimension: company_enrichment_market_capitalisation {
    type: string
    sql: ${TABLE}.company_enrichment_market_capitalisation ;;
  }

  dimension: company_enrichment_naics_code {
    type: number
    sql: ${TABLE}.company_enrichment_NAICS_code ;;
  }

  dimension: company_enrichment_name {
    type: string
    sql: ${TABLE}.company_enrichment_name ;;
  }

  dimension: company_enrichment_parent_website_domain {
    type: string
    sql: ${TABLE}.company_enrichment_parent_website_domain ;;
  }

  dimension: company_enrichment_phone {
    type: string
    sql: ${TABLE}.company_enrichment_phone ;;
  }

  dimension: company_enrichment_postal_code {
    type: string
    sql: ${TABLE}.company_enrichment_postal_code ;;
  }

  dimension: company_enrichment_sic_code {
    type: number
    sql: ${TABLE}.company_enrichment_SIC_code ;;
  }

  dimension: company_enrichment_state {
    type: string
    sql: ${TABLE}.company_enrichment_state ;;
  }

  dimension: company_enrichment_state_code {
    type: string
    sql: ${TABLE}.company_enrichment_state_code ;;
  }

  dimension: company_enrichment_street_name {
    type: string
    sql: ${TABLE}.company_enrichment_street_name ;;
  }

  dimension: company_enrichment_street_number {
    type: string
    sql: ${TABLE}.company_enrichment_street_number ;;
  }

  dimension: company_enrichment_sub_industry {
    type: string
    sql: ${TABLE}.company_enrichment_sub_industry ;;
  }

  dimension: company_enrichment_sub_premise {
    type: string
    sql: ${TABLE}.company_enrichment_sub_premise ;;
  }

  dimension: company_enrichment_time_zone {
    type: string
    sql: ${TABLE}.company_enrichment_time_zone ;;
  }

  dimension: company_enrichment_total_annual_revenue {
    type: string
    sql: ${TABLE}.company_enrichment_total_annual_revenue ;;
  }

  dimension: company_enrichment_total_employees {
    type: number
    sql: ${TABLE}.company_enrichment_total_employees ;;
  }

  dimension: company_enrichment_total_funding_raised {
    type: string
    sql: ${TABLE}.company_enrichment_total_funding_raised ;;
  }

  dimension: company_enrichment_twitter_bio {
    type: string
    sql: ${TABLE}.company_enrichment_twitter_bio ;;
  }

  dimension: company_enrichment_twitter_followers {
    type: number
    sql: ${TABLE}.company_enrichment_twitter_followers ;;
  }

  dimension: company_enrichment_twitter_following {
    type: number
    sql: ${TABLE}.company_enrichment_twitter_following ;;
  }

  dimension: company_enrichment_twitter_id {
    type: number
    sql: ${TABLE}.company_enrichment_twitter_id ;;
  }

  dimension: company_enrichment_twitter_location {
    type: string
    sql: ${TABLE}.company_enrichment_twitter_location ;;
  }

  dimension: company_enrichment_twitter_user_name {
    type: string
    sql: ${TABLE}.company_enrichment_twitter_user_name ;;
  }

  dimension: company_enrichment_twitter_website_url {
    type: string
    sql: ${TABLE}.company_enrichment_twitter_website_url ;;
  }

  dimension: company_enrichment_ultimate_parent_website_domain {
    type: string
    sql: ${TABLE}.company_enrichment_ultimate_parent_website_domain ;;
  }

  dimension: company_enrichment_us_ein {
    type: string
    sql: ${TABLE}.company_enrichment_usEIN ;;
  }

  dimension: company_enrichment_utc_offset {
    type: number
    sql: ${TABLE}.company_enrichment_utc_offset ;;
  }

  dimension: company_enrichment_website_domain {
    type: string
    sql: ${TABLE}.company_enrichment_website_domain ;;
  }

  dimension: company_finance_status {
    type: string
    sql: ${TABLE}.company_finance_status ;;
  }

  dimension: company_industry {
    type: string
    sql: ${TABLE}.company_industry ;;
  }

  dimension_group: company_last_modified {
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
    sql: ${TABLE}.company_last_modified_date ;;
  }

  dimension: company_linkedin_bio {
    type: string
    sql: ${TABLE}.company_linkedin_bio ;;
  }

  dimension: company_linkedin_company_page {
    type: string
    sql: ${TABLE}.company_linkedin_company_page ;;
  }

  dimension: company_name {
    type: string
    sql: ${TABLE}.company_name ;;
  }

  dimension: company_phone {
    type: string
    sql: ${TABLE}.company_phone ;;
  }

  dimension: company_pk {
    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension: company_twitterhandle {
    type: string
    sql: ${TABLE}.company_twitterhandle ;;
  }

  dimension: company_website {
    type: string
    sql: ${TABLE}.company_website ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      company_enrichment_legal_name,
      company_enrichment_facebook_user_name,
      company_enrichment_twitter_user_name,
      company_enrichment_crunchbase_user_name,
      company_enrichment_linkedin_user_name,
      company_enrichment_street_name,
      company_name,
      company_enrichment_name
    ]
  }
}

view: companies_dim__all_company_addresses {
  dimension: company_address {
    type: string
    sql: ${TABLE}.company_address ;;
  }

  dimension: company_address2 {
    type: string
    sql: ${TABLE}.company_address2 ;;
  }

  dimension: company_city {
    type: string
    sql: ${TABLE}.company_city ;;
  }

  dimension: company_country {
    type: string
    sql: ${TABLE}.company_country ;;
  }

  dimension: company_state {
    type: string
    sql: ${TABLE}.company_state ;;
  }

  dimension: company_zip {
    type: string
    sql: ${TABLE}.company_zip ;;
  }
}
