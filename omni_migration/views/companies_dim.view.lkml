view: companies_dim {
  sql_table_name: `ra-development.analytics.companies_dim` ;;

  dimension: all_company_addresses {
    description: "All addresses associated with the company."
    hidden: yes
    sql: ${TABLE}.all_company_addresses ;;
  }

  dimension: all_company_ids {
    description: "All IDs associated with the company."
    hidden: yes
    sql: (SELECT string_agg(company_id) FROM UNNEST(all_company_ids) AS company_id) ;;
  }

  dimension: company_currency_code {
    type: string
    description: "The currency code associated with the company."
    hidden: yes
    sql: ${TABLE}.company_currency_code ;;
  }

  dimension: company_description {
    type: string
    label: "Company Description"
    group_label: "Company Details"
    description: "Company Bio, sourced from LinkedIn via Hubspot"
    sql: ${TABLE}.company_description ;;
  }

  dimension: company_finance_status {
    type: string
    description: "The financial status of the company."
    hidden: yes
    sql: ${TABLE}.company_finance_status ;;
  }

  dimension: company_industry {
    type: string
    label: "Company Industry"
    group_label: "Company Details"
    description: "The industry in which the company operates."
    sql: ${TABLE}.company_industry ;;
  }

  dimension: company_linkedin_company_page {
    type: string
    label: "Company LinkedIn Page"
    group_label: "Company Details"
    description: "The LinkedIn page URL of the company."
    hidden: yes
    sql: ${TABLE}.company_linkedin_company_page ;;
  }

  dimension: company_name {
    type: string
    label: "Company Name"
    group_label: "Company Details"
    description: "The name of the company."
    sql: ${TABLE}.company_name ;;
  }

  dimension: company_phone {
    type: string
    description: "The phone number of the company."
    hidden: yes
    sql: ${TABLE}.company_phone ;;
  }

  dimension: company_pk {
    primary_key: yes
    type: string
    group_label: "Company Details"
    description: "The primary key of the company record."
    hidden: yes
    sql: ${TABLE}.company_pk ;;
  }

  dimension: company_twitterhandle {
    type: string
    label: "Company Twitter Handle"
    group_label: "Company Details"
    description: "The Twitter handle of the company."
    sql: ${TABLE}.company_twitterhandle ;;
  }

  dimension: company_website {
    type: string
    label: "Company Website"
    group_label: "Company Details"
    description: "The website URL of the company."
    sql: ${TABLE}.company_website ;;
  }

  dimension: hubspot_company_id {
    description: "The HubSpot company ID."
    hidden: yes
    sql: (SELECT max(hubspot_company_id) FROM UNNEST(all_company_ids) AS hubspot_company_id WHERE hubspot_company_id like '%hubspot%') ;;
  }

  dimension_group: company_created {
    type: time
    timeframes: [raw, date, month, quarter, year]
    label: "Company Created"
    group_label: "Company Details"
    description: "The creation date of the company record."
    hidden: yes
    sql: ${TABLE}.company_created_date ;;
  }

  dimension_group: company_last_modified {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    description: "The date and time when the company record was last modified."
    hidden: yes
    sql: ${TABLE}.company_last_modified_date ;;
  }

  measure: count {
    type: count
    description: "The total count of records."
    hidden: yes
    drill_fields: [companies_dim.company_name]
  }

  measure: total_clients {
    type: count_distinct
    description: "The total number of distinct clients."
    drill_fields: [companies_dim.company_name]
    sql: ${company_pk} ;;
  }
}
