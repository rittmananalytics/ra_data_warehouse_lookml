view: companies_dim {
  sql_table_name: `analytics.companies_dim`
    ;;

  dimension: all_company_addresses {
    hidden: yes
    sql: ${TABLE}.all_company_addresses ;;
  }

  dimension: all_company_ids {
    hidden: yes
    type: string
    sql: ${TABLE}.all_company_ids ;;
  }

  dimension: company_created {
    type: date

    sql: date(${TABLE}.company_created_date) ;;
  }

  dimension: company_currency_code {
    hidden: yes
    type: string
    sql: ${TABLE}.company_currency_code ;;
  }

  dimension: company_description {
    type: string
    sql: ${TABLE}.company_description ;;
  }

  dimension: company_enrichment_alexa_global_rank {
    hidden: yes

    type: number
    sql: ${TABLE}.company_enrichment_alexaGlobalRank ;;
  }

  dimension: company_enrichment_alexa_us_rank {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_alexaUsRank ;;
  }

  dimension: company_enrichment_all_contact_emails {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_all_contact_emails ;;
  }

  dimension: company_enrichment_all_contact_phones {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_all_contact_phones ;;
  }

  dimension: company_enrichment_all_tags {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_all_tags ;;
  }

  dimension: company_enrichment_all_technologies {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_all_technologies ;;
  }

  dimension: company_enrichment_all_technology_categories {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_all_technology_categories ;;
  }

  dimension: company_enrichment_all_website_domains {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_all_website_domains ;;
  }

  dimension: company_enrichment_city {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_city ;;
  }

  dimension: company_enrichment_company_stock_ticker {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_company_stock_ticker ;;
  }

  dimension: company_enrichment_company_type {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_company_type ;;
  }

  dimension: company_enrichment_country {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_country ;;
  }

  dimension: company_enrichment_country_code {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_country_code ;;
  }

  dimension: company_enrichment_crunchbase_user_name {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_crunchbase_user_name ;;
  }

  dimension: company_enrichment_description {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_description ;;
  }

  dimension: company_enrichment_employees_rang {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_employeesRang ;;
  }

  dimension: company_enrichment_estimated_annual_revenue {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_estimated_annual_revenue ;;
  }

  dimension: company_enrichment_facebook_total_likes {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_facebook_total_likes ;;
  }

  dimension: company_enrichment_facebook_user_name {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_facebook_user_name ;;
  }

  dimension: company_enrichment_fiscal_year_end {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_fiscal_year_end ;;
  }

  dimension: company_enrichment_founded_year {
    hidden: yes

    type: number
    sql: ${TABLE}.company_enrichment_founded_year ;;
  }

  dimension: company_enrichment_geo_lat {
    hidden: yes

    type: number
    sql: ${TABLE}.company_enrichment_geo_lat ;;
  }

  dimension: company_enrichment_geo_long {
        hidden: yes

    type: number
    sql: ${TABLE}.company_enrichment_geo_long ;;
  }

  dimension: company_enrichment_id {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_id ;;
  }

  dimension: company_enrichment_industry {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_industry ;;
  }

  dimension: company_enrichment_industry_group {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_industry_group ;;
  }

  dimension: company_enrichment_industry_sector {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_industry_sector ;;
  }

  dimension: company_enrichment_is_email_provider {
    hidden: yes

    type: yesno
    sql: ${TABLE}.company_enrichment_is_email_provider ;;
  }

  dimension_group: company_enrichment_last_modified {
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
    sql: ${TABLE}.company_enrichment_last_modified_at ;;
  }

  dimension: company_enrichment_legal_name {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_legalName ;;
  }

  dimension: company_enrichment_linkedin_user_name {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_linkedin_user_name ;;
  }

  dimension: company_enrichment_location {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_location ;;
  }

  dimension: company_enrichment_logo_url {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_logo_url ;;
  }

  dimension: company_enrichment_market_capitalisation {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_market_capitalisation ;;
  }

  dimension: company_enrichment_naics_code {
    hidden: yes

    type: number
    sql: ${TABLE}.company_enrichment_NAICS_code ;;
  }

  dimension: company_enrichment_name {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_name ;;
  }

  dimension: company_enrichment_parent_website_domain {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_parent_website_domain ;;
  }

  dimension: company_enrichment_phone {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_phone ;;
  }

  dimension: company_enrichment_postal_code {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_postal_code ;;
  }

  dimension: company_enrichment_sic_code {
    hidden: yes

    type: number
    sql: ${TABLE}.company_enrichment_SIC_code ;;
  }

  dimension: company_enrichment_state {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_state ;;
  }

  dimension: company_enrichment_state_code {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_state_code ;;
  }

  dimension: company_enrichment_street_name {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_street_name ;;
  }

  dimension: company_enrichment_street_number {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_street_number ;;
  }

  dimension: company_enrichment_sub_industry {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_sub_industry ;;
  }

  dimension: company_enrichment_sub_premise {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_sub_premise ;;
  }

  dimension: company_enrichment_time_zone {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_time_zone ;;
  }

  dimension: company_enrichment_total_annual_revenue {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_total_annual_revenue ;;
  }

  dimension: company_enrichment_total_employees {
    hidden: yes

    type: number
    sql: ${TABLE}.company_enrichment_total_employees ;;
  }

  dimension: company_enrichment_total_funding_raised {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_total_funding_raised ;;
  }

  dimension: company_enrichment_twitter_bio {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_twitter_bio ;;
  }

  dimension: company_enrichment_twitter_followers {
    hidden: yes

    type: number
    sql: ${TABLE}.company_enrichment_twitter_followers ;;
  }

  dimension: company_enrichment_twitter_following {
    hidden: yes

    type: number
    sql: ${TABLE}.company_enrichment_twitter_following ;;
  }

  dimension: company_enrichment_twitter_id {
    hidden: yes

    type: number
    sql: ${TABLE}.company_enrichment_twitter_id ;;
  }

  dimension: company_enrichment_twitter_location {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_twitter_location ;;
  }

  dimension: company_enrichment_twitter_user_name {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_twitter_user_name ;;
  }

  dimension: company_enrichment_twitter_website_url {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_twitter_website_url ;;
  }

  dimension: company_enrichment_ultimate_parent_website_domain {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_ultimate_parent_website_domain ;;
  }

  dimension: company_enrichment_us_ein {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_usEIN ;;
  }

  dimension: company_enrichment_utc_offset {
    hidden: yes

    type: number
    sql: ${TABLE}.company_enrichment_utc_offset ;;
  }

  dimension: company_enrichment_website_domain {
    hidden: yes

    type: string
    sql: ${TABLE}.company_enrichment_website_domain ;;
  }

  dimension: company_finance_status {
    hidden: yes

    type: string
    sql: ${TABLE}.company_finance_status ;;
  }

  dimension: company_industry {
    hidden: no

    type: string
    sql: ${TABLE}.company_industry ;;
  }

  dimension_group: company_last_modified {
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
    sql: ${TABLE}.company_last_modified_date ;;
  }

  dimension: company_linkedin_bio {
    hidden: no

    type: string
    sql: ${TABLE}.company_linkedin_bio ;;
  }

  dimension: company_linkedin_company_page {
    hidden: no

    type: string
    sql: ${TABLE}.company_linkedin_company_page ;;
  }

  dimension: company_name {
    type: string
    sql: case when ${TABLE}.company_name = 'indexlabs.co.uk' then 'Football Index' else ${TABLE}.company_name end;;
  }

  dimension: company_phone {
    hidden: yes

    type: string
    sql: ${TABLE}.company_phone ;;
  }

  dimension: company_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension: company_twitterhandle {
    hidden: no

    type: string
    sql: ${TABLE}.company_twitterhandle ;;
  }

  dimension: company_website {
    hidden: no

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
  measure: count {
    type: count
  }
}
