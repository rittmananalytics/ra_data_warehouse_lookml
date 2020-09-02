view: contacts_dim {
  sql_table_name: `analytics.contacts_dim`
    ;;

  dimension: all_contact_addresses {
    hidden: yes
    sql: ${TABLE}.all_contact_addresses ;;
  }

  dimension: all_contact_company_ids {
    type: string
    sql: ${TABLE}.all_contact_company_ids ;;
  }

  dimension: all_contact_emails {
    type: string
    sql: ${TABLE}.all_contact_emails ;;
  }

  dimension: all_contact_ids {
    type: string
    sql: ${TABLE}.all_contact_ids ;;
  }

  dimension_group: contact_created {
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
    sql: ${TABLE}.contact_created_date ;;
  }

  dimension: contact_enrichment_bio {
    type: string
    sql: ${TABLE}.contact_enrichment_bio ;;
  }

  dimension: contact_enrichment_city {
    type: string
    sql: ${TABLE}.contact_enrichment_city ;;
  }

  dimension: contact_enrichment_company_name {
    type: string
    sql: ${TABLE}.contact_enrichment_company_name ;;
  }

  dimension: contact_enrichment_country {
    type: string
    sql: ${TABLE}.contact_enrichment_country ;;
  }

  dimension: contact_enrichment_country_code {
    type: string
    sql: ${TABLE}.contact_enrichment_country_code ;;
  }

  dimension_group: contact_enrichment_created {
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
    sql: ${TABLE}.contact_enrichment_created_at ;;
  }

  dimension: contact_enrichment_employment_website_domain {
    type: string
    sql: ${TABLE}.contact_enrichment_employment_website_domain ;;
  }

  dimension: contact_enrichment_facebook_user_name {
    type: string
    sql: ${TABLE}.contact_enrichment_facebook_user_name ;;
  }

  dimension: contact_enrichment_family_name {
    type: string
    sql: ${TABLE}.contact_enrichment_family_name ;;
  }

  dimension: contact_enrichment_full_name {
    type: string
    sql: ${TABLE}.contact_enrichment_full_name ;;
  }

  dimension: contact_enrichment_geo_lat {
    type: number
    sql: ${TABLE}.contact_enrichment_geo_lat ;;
  }

  dimension: contact_enrichment_geo_long {
    type: number
    sql: ${TABLE}.contact_enrichment_geo_long ;;
  }

  dimension: contact_enrichment_github_company_name {
    type: string
    sql: ${TABLE}.contact_enrichment_github_company_name ;;
  }

  dimension: contact_enrichment_github_id {
    type: number
    sql: ${TABLE}.contact_enrichment_github_id ;;
  }

  dimension: contact_enrichment_github_total_followers {
    type: number
    sql: ${TABLE}.contact_enrichment_github_total_followers ;;
  }

  dimension: contact_enrichment_github_total_following {
    type: number
    sql: ${TABLE}.contact_enrichment_github_total_following ;;
  }

  dimension: contact_enrichment_github_user_name {
    type: string
    sql: ${TABLE}.contact_enrichment_github_user_name ;;
  }

  dimension: contact_enrichment_given_name {
    type: string
    sql: ${TABLE}.contact_enrichment_given_name ;;
  }

  dimension_group: contact_enrichment_last_modified {
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
    sql: ${TABLE}.contact_enrichment_last_modified_at ;;
  }

  dimension: contact_enrichment_linkedin_user_name {
    type: string
    sql: ${TABLE}.contact_enrichment_linkedin_user_name ;;
  }

  dimension: contact_enrichment_location {
    type: string
    sql: ${TABLE}.contact_enrichment_location ;;
  }

  dimension: contact_enrichment_role {
    type: string
    sql: ${TABLE}.contact_enrichment_role ;;
  }

  dimension: contact_enrichment_role_seniority {
    type: string
    sql: ${TABLE}.contact_enrichment_role_seniority ;;
  }

  dimension: contact_enrichment_state {
    type: string
    sql: ${TABLE}.contact_enrichment_state ;;
  }

  dimension: contact_enrichment_state_code {
    type: string
    sql: ${TABLE}.contact_enrichment_state_code ;;
  }

  dimension: contact_enrichment_sub_role {
    type: string
    sql: ${TABLE}.contact_enrichment_sub_role ;;
  }

  dimension: contact_enrichment_time_zone {
    type: string
    sql: ${TABLE}.contact_enrichment_time_zone ;;
  }

  dimension: contact_enrichment_title {
    type: string
    sql: ${TABLE}.contact_enrichment_title ;;
  }

  dimension: contact_enrichment_twitter_bio {
    type: string
    sql: ${TABLE}.contact_enrichment_twitter_bio ;;
  }

  dimension: contact_enrichment_twitter_location {
    type: string
    sql: ${TABLE}.contact_enrichment_twitter_location ;;
  }

  dimension: contact_enrichment_twitter_total_favourites {
    type: number
    sql: ${TABLE}.contact_enrichment_twitter_total_favourites ;;
  }

  dimension: contact_enrichment_twitter_total_followers {
    type: number
    sql: ${TABLE}.contact_enrichment_twitter_total_followers ;;
  }

  dimension: contact_enrichment_twitter_total_following {
    type: number
    sql: ${TABLE}.contact_enrichment_twitter_total_following ;;
  }

  dimension: contact_enrichment_twitter_total_posts {
    type: number
    sql: ${TABLE}.contact_enrichment_twitter_total_posts ;;
  }

  dimension: contact_enrichment_twitter_user_id {
    type: number
    sql: ${TABLE}.contact_enrichment_twitter_user_id ;;
  }

  dimension: contact_enrichment_twitter_user_name {
    type: string
    sql: ${TABLE}.contact_enrichment_twitter_user_name ;;
  }

  dimension: contact_enrichment_twitter_website_url {
    type: string
    sql: ${TABLE}.contact_enrichment_twitter_website_url ;;
  }

  dimension: contact_enrichment_utc_offset {
    type: number
    sql: ${TABLE}.contact_enrichment_utc_offset ;;
  }

  dimension: contact_enrichment_website_url {
    type: string
    sql: ${TABLE}.contact_enrichment_website_url ;;
  }

  dimension_group: contact_last_modified {
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
    sql: ${TABLE}.contact_last_modified_date ;;
  }

  dimension: contact_mobile_phone {
    type: string
    sql: ${TABLE}.contact_mobile_phone ;;
  }

  dimension: contact_name {
    type: string
    sql: ${TABLE}.contact_name ;;
  }

  dimension: contact_phone {
    type: string
    sql: ${TABLE}.contact_phone ;;
  }

  dimension: contact_pk {
    type: string
    sql: ${TABLE}.contact_pk ;;
  }

  dimension: job_title {
    type: string
    sql: ${TABLE}.job_title ;;
  }

  dimension_group: max_contact_enrichment_last_modified {
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
    sql: ${TABLE}.max_contact_enrichment_last_modified_at ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      contact_enrichment_github_user_name,
      contact_enrichment_company_name,
      contact_enrichment_family_name,
      contact_enrichment_linkedin_user_name,
      contact_enrichment_given_name,
      contact_enrichment_facebook_user_name,
      contact_enrichment_full_name,
      contact_name,
      contact_enrichment_twitter_user_name,
      contact_enrichment_github_company_name
    ]
  }
}

view: contacts_dim__all_contact_addresses {
  dimension: contact_address {
    type: string
    sql: ${TABLE}.contact_address ;;
  }

  dimension: contact_city {
    type: string
    sql: ${TABLE}.contact_city ;;
  }

  dimension: contact_country {
    type: string
    sql: ${TABLE}.contact_country ;;
  }

  dimension: contact_postcode_zip {
    type: string
    sql: ${TABLE}.contact_postcode_zip ;;
  }

  dimension: contact_state {
    type: string
    sql: ${TABLE}.contact_state ;;
  }
}
