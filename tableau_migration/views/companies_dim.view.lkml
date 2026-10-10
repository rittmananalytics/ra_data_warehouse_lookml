view: companies_dim {
  sql_table_name: `ra-development.analytics.companies_dim` ;;

  dimension: all_anonymous_ids {
    type: string
    label: "All Anonymous Ids"
    sql: ${TABLE}.all_anonymous_ids ;;
  }

  dimension: all_company_addresses_company_address {
    type: string
    label: "All Company Addresses.Company Address"
    sql: ${TABLE}.`all_company_addresses.company_address` ;;
  }

  dimension: all_company_addresses_company_address2 {
    type: string
    label: "All Company Addresses.Company Address2"
    sql: ${TABLE}.`all_company_addresses.company_address2` ;;
  }

  dimension: all_company_addresses_company_city {
    type: string
    label: "All Company Addresses.Company City"
    sql: ${TABLE}.`all_company_addresses.company_city` ;;
  }

  dimension: all_company_addresses_company_country {
    type: string
    label: "All Company Addresses.Company Country"
    sql: ${TABLE}.`all_company_addresses.company_country` ;;
  }

  dimension: all_company_addresses_company_state {
    type: string
    label: "All Company Addresses.Company State"
    sql: ${TABLE}.`all_company_addresses.company_state` ;;
  }

  dimension: all_company_addresses_company_zip {
    type: string
    label: "All Company Addresses.Company Zip"
    sql: ${TABLE}.`all_company_addresses.company_zip` ;;
  }

  dimension: all_company_ids {
    type: string
    label: "All Company Ids"
    sql: ${TABLE}.all_company_ids ;;
  }

  dimension_group: company_created_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Company Created Date"
    sql: ${TABLE}.company_created_date ;;
  }

  dimension: company_currency_code {
    type: string
    label: "Company Currency Code"
    sql: ${TABLE}.company_currency_code ;;
  }

  dimension: company_description {
    type: string
    label: "Company Description"
    sql: ${TABLE}.company_description ;;
  }

  dimension: company_finance_status {
    type: string
    label: "Company Finance Status"
    sql: ${TABLE}.company_finance_status ;;
  }

  dimension: company_industry {
    type: string
    label: "Company Industry"
    sql: ${TABLE}.company_industry ;;
  }

  dimension_group: company_last_modified_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Company Last Modified Date"
    sql: ${TABLE}.company_last_modified_date ;;
  }

  dimension: company_lifecycle_stage {
    type: string
    label: "Company Lifecycle Stage"
    sql: ${TABLE}.company_lifecycle_stage ;;
  }

  dimension_group: company_lifecycle_stage_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Company Lifecycle Stage Ts"
    sql: ${TABLE}.company_lifecycle_stage_ts ;;
  }

  dimension: company_linkedin_bio {
    type: string
    label: "Company Linkedin Bio"
    sql: ${TABLE}.company_linkedin_bio ;;
  }

  dimension: company_linkedin_company_page {
    type: string
    label: "Company Linkedin Company Page"
    sql: ${TABLE}.company_linkedin_company_page ;;
  }

  dimension: company_name {
    type: string
    label: "Company Name"
    sql: ${TABLE}.company_name ;;
  }

  dimension: company_phone {
    type: string
    label: "Company Phone"
    sql: ${TABLE}.company_phone ;;
  }

  dimension: company_pk {
    primary_key: yes
    type: string
    label: "Company Pk"
    sql: ${TABLE}.company_pk ;;
  }

  dimension: company_twitterhandle {
    type: string
    label: "Company Twitterhandle"
    sql: ${TABLE}.company_twitterhandle ;;
  }

  dimension: company_website {
    type: string
    label: "Company Website"
    sql: ${TABLE}.company_website ;;
  }

  dimension: is_partner {
    type: yesno
    label: "Is Partner"
    sql: ${TABLE}.is_partner ;;
  }

  dimension: is_partner_overlap_account {
    type: yesno
    label: "Is Partner Overlap Account"
    sql: ${TABLE}.is_partner_overlap_account ;;
  }
}
