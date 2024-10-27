view: companies_dim {
  sql_table_name: `{{ _user_attributes['dataset'] }}.companies_dim` ;;

  dimension_group: company_created {
    group_label: "           Company Details"
    label: "Company Created"
    hidden: yes
    description: "The creation date of the company record."
    timeframes: [date, month, quarter, year]
    type: time
    sql: ${TABLE}.company_created_date ;;
  }

  dimension: company_currency_code {
    hidden: yes
    type: string
    description: "The currency code associated with the company."
    sql: ${TABLE}.company_currency_code ;;
  }

  dimension: company_description {
    group_label: "           Company Details"
    label: "Company Description"
    description: "Company Bio, sourced from LinkedIn via Hubspot"
    type: string
    sql: ${TABLE}.company_description ;;
  }

  dimension: all_company_addresses {
    hidden: yes
    description: "All addresses associated with the company."
    sql: ${TABLE}.all_company_addresses ;;
  }

  dimension: company_finance_status {
    hidden: yes
    type: string
    description: "The financial status of the company."
    sql: ${TABLE}.company_finance_status ;;
  }

  dimension: company_industry {
    hidden: no
    group_label: "           Company Details"
    label: "Company Industry"
    description: "The industry in which the company operates."
    type: string
    sql: ${TABLE}.company_industry ;;
  }

  dimension_group: company_last_modified {
    hidden: yes
    description: "The date and time when the company record was last modified."
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.company_last_modified_date ;;
  }

  dimension: company_linkedin_company_page {
    hidden: yes
    group_label: "           Company Details"
    label: "Company LinkedIn Page"
    description: "The LinkedIn page URL of the company."
    type: string
    sql: ${TABLE}.company_linkedin_company_page ;;
  }

  dimension: company_name {
    group_label: "           Company Details"
    label: "    Company Name"
    description: "The name of the company."
    type: string
    sql: ${TABLE}.company_name ;;
  }

  dimension: company_phone {
    hidden: yes
    description: "The phone number of the company."
    type: string
    sql: ${TABLE}.company_phone ;;
  }

  dimension: company_pk {
    group_label: "           Company Details"
    hidden: yes
    primary_key: yes
    description: "The primary key of the company record."
    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension: company_twitterhandle {
    group_label: "           Company Details"
    label: "Company Twitter Handle"
    hidden: no
    description: "The Twitter handle of the company."
    type: string
    sql: ${TABLE}.company_twitterhandle ;;
  }

  dimension: company_website {
    group_label: "           Company Details"
    label: "Company Website"
    hidden: no
    description: "The website URL of the company."
    type: string
    sql: ${TABLE}.company_website ;;
  }

  measure: count {
    hidden: yes
    type: count
    description: "The total count of records."
    drill_fields: [detail*]
  }

  measure: total_clients {
    type: count_distinct
    description: "The total number of distinct clients."
    sql: ${company_pk} ;;
    drill_fields: [detail*]
  }

  dimension: hubspot_company_id {
    hidden: no
    description: "The HubSpot company ID."
    sql: (SELECT max(hubspot_company_id) FROM UNNEST(all_company_ids) AS hubspot_company_id WHERE hubspot_company_id like '%hubspot%') ;;
  }

  dimension: all_company_ids {
    hidden: yes
    description: "All IDs associated with the company."
    sql: (SELECT string_agg(company_id) FROM UNNEST(all_company_ids) AS company_id) ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [

      company_name
    ]
  }
}

view: companies_dim__all_company_ids {
  dimension: companies_dim__all_company_ids {
    type: string
    hidden: yes
    description: "All company IDs in the companies dimension."
    sql: ${TABLE}.companies_dim__all_company_ids ;;
  }
}

view: companies_dim__all_company_addresses {
  dimension: company_address {
    group_label: "Company Addresses"
    type: string
    description: "The primary address of the company."
    sql: ${TABLE}.company_address ;;
  }

  dimension: company_address2 {
    group_label: "Company Addresses"
    type: string
    description: "The secondary address of the company."
    sql: ${TABLE}.company_address2 ;;
  }

  dimension: company_city {
    group_label: "Company Addresses"
    type: string
    description: "The city where the company is located."
    sql: ${TABLE}.company_city ;;
  }

  dimension: company_country {
    group_label: "Company Addresses"
    map_layer_name: countries
    type: string
    description: "The country where the company is located."
    sql: ${TABLE}.company_country ;;
  }

  dimension: company_state {
    group_label: "Company Addresses"
    type: string
    description: "The state or province where the company is located."
    sql: ${TABLE}.company_state ;;
  }

  dimension: company_zip {
    group_label: "Company Addresses"
    type: zipcode
    description: "The ZIP or postal code of the company."
    sql: ${TABLE}.company_zip ;;
  }
}
