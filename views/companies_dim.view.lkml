view: companies_dim {
  sql_table_name: `{{ _user_attributes['dataset'] }}.companies_dim`;;

  dimension_group: company_created {
    group_label: "     Companies"
    label: "Company Created"
    hidden: yes

    timeframes: [date,month,quarter,year]
    type: time
    sql: ${TABLE}.company_created_date ;;
  }




















  dimension: company_currency_code {
    hidden: yes
    type: string
    sql: ${TABLE}.company_currency_code ;;
  }

  dimension: company_description {
    group_label: "     Companies"
    label: "     Company Description"
    description: "Company Bio, sourced from LinkedIn via Hubspot"

    type: string
    sql: ${TABLE}.company_description ;;
  }

  dimension: all_company_addresses {
    hidden: yes
    sql: ${TABLE}.all_company_addresses ;;
  }


  dimension: company_finance_status {
    hidden: yes

    type: string
    sql: ${TABLE}.company_finance_status ;;
  }

  dimension: company_industry {
    hidden: no
    group_label: "     Companies"
    label: "    Company Industry"

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



  dimension: company_linkedin_company_page {
    hidden: yes
    group_label: "     Companies"
    label: "   Company LinkedIn Page"


    type: string
    sql: ${TABLE}.company_linkedin_company_page ;;
  }

  dimension: company_name {
    group_label: "     Companies"

    label: "         Company Name"
    type: string
    sql: ${TABLE}.company_name;;
  }





  dimension: company_phone {
    hidden: yes

    type: string
    sql: ${TABLE}.company_phone ;;
  }

  dimension: company_pk {
    group_label: "     Companies"
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension: company_twitterhandle {
    group_label: "     Companies"
    label: "  Company Twitter Handle"

    hidden: no

    type: string
    sql: ${TABLE}.company_twitterhandle ;;
  }

  dimension: company_website {
    group_label: "     Companies"
    label: " Company Website"

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

      company_name
    ]
  }
}

view: companies_dim__all_company_ids {
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Companies Dim All Company Ids" in Explore.

  dimension: companies_dim__all_company_ids {
    type: string
    sql: companies_dim__all_company_ids ;;
  }
}

# The name of this view in Looker is "Companies Dim All Company Addresses"
view: companies_dim__all_company_addresses {
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Company Address" in Explore.

  dimension: company_address {
    group_label: "Company Addresses"
    type: string
    sql: ${TABLE}.company_address ;;
  }

  dimension: company_address2 {
    group_label: "Company Addresses"

    type: string
    sql: ${TABLE}.company_address2 ;;
  }

  dimension: company_city {
    group_label: "Company Addresses"
    type: string
    sql: ${TABLE}.company_city ;;
  }

  dimension: company_country {
    group_label: "Company Addresses"
    map_layer_name: countries
    type: string
    sql: ${TABLE}.company_country ;;
  }

  dimension: company_state {
    group_label: "Company Addresses"

    type: string
    sql: ${TABLE}.company_state ;;
  }

  dimension: company_zip {
    group_label: "Company Addresses"

    type: zipcode
    sql: ${TABLE}.company_zip ;;
  }





}
