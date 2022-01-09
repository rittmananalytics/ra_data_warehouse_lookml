view: companies_dim {
  sql_table_name: `{{ _user_attributes['dataset'] }}.companies_dim`;;

  dimension_group: company_created {
    group_label: "     Company"

    timeframes: [date,month,quarter]
    type: time
    sql: ${TABLE}.company_created_date ;;
  }

  dimension: appeal_of_ra_to_sponsor {
    group_label: "Ideal Customer Attributes"
    type: string
    sql: ${TABLE}.Appeal_of_RA_to_Sponsor ;;
  }

  dimension: analytics_maturity {
    group_label: "Ideal Customer Attributes"

    type: string
    sql: initcap(${TABLE}.Client_Maturity) ;;
  }



  dimension: customer_satisfaction {
    group_label: "Ideal Customer Attributes"

    type: number
    sql: ${TABLE}.Customer_Satisfaction ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.


  measure: average_customer_satisfaction {
    group_label: "Ideal Customer Attributes"
    value_format_name: decimal_1

    type: average
    sql: ${customer_satisfaction} ;;
  }

  dimension: data_analyst_on_staff {
    group_label: "Ideal Customer Attributes"

    type: yesno
    sql: ${TABLE}.Data_Analyst_on_staff="Y" ;;
  }

  dimension: department {
    group_label: "Ideal Customer Attributes"

    type: string
    sql: ${TABLE}.Department ;;
  }

  dimension: expectations_alignment {
    group_label: "Ideal Customer Attributes"

    type: string
    sql: ${TABLE}.Expectations_Alignment ;;
  }

  dimension: account_growth_potential {
    group_label: "Ideal Customer Attributes"

    type: number
    sql: ${TABLE}.Growth_Potential ;;
  }

  measure: average_account_growth_potential {
    group_label: "Ideal Customer Attributes"
    value_format_name: decimal_1

    type: average
    sql: ${account_growth_potential} ;;
  }

  dimension: ip_reusability {
    group_label: "Ideal Customer Attributes"

    type: number
    sql: ${TABLE}.IP_Reusability ;;
  }

  measure: average_ip_reusability {
    group_label: "Ideal Customer Attributes"
    value_format_name: decimal_1

    type: average
    sql: ${ip_reusability} ;;
  }

  dimension: lead_technology {
    group_label: "Ideal Customer Attributes"

    type: string
    sql: ${TABLE}.Lead_Technology ;;
  }

  dimension: market {
    group_label: "Ideal Customer Attributes"

    type: string
    sql: ${TABLE}.Market ;;
  }

  dimension: marketing_channel {
    group_label: "Ideal Customer Attributes"

    type: string
    sql: ${TABLE}.Marketing_Channel ;;
  }

  dimension: plan_to_hand_over {
    group_label: "Ideal Customer Attributes"

    type: yesno
    sql: ${TABLE}.Plan_to_Hand_over="Y" ;;
  }

  dimension: profitability {
    group_label: "Ideal Customer Attributes"

    type: number
    sql: ${TABLE}.Profitability ;;
  }

  measure: average_profitability {
    group_label: "Ideal Customer Attributes"
    value_format_name: decimal_1

    type: average
    sql: ${profitability} ;;
  }

  dimension: ra_lead {
    group_label: "Ideal Customer Attributes"

    type: string
    sql: ${TABLE}.RA_Lead ;;
  }

  dimension: ra_satisfaction {
    group_label: "Ideal Customer Attributes"

    type: number
    sql: ${TABLE}.RA_Satisfaction ;;
  }

  measure: average_ra_satisfaction {
    group_label: "Ideal Customer Attributes"
    value_format_name: decimal_1

    type: average
    sql: ${ra_satisfaction} ;;
  }

  dimension: rank {
    group_label: "Ideal Customer Attributes"
    type: number
    sql: ${TABLE}.Rank ;;
  }

  dimension: segment_order {
    hidden: yes
    type: number
    sql: case when ${TABLE}.Segment = 'Platinum' then 1
              when ${TABLE}.Segment = 'Gold' then 2
              when ${TABLE}.Segment = 'Silver' then 3
              when ${TABLE}.Segment = 'Bronze' then 4
              end;;
  }

  dimension: referenceability {
    group_label: "Ideal Customer Attributes"

    type: number
    sql: ${TABLE}.Referenceability ;;
  }

  measure: average_referenceability {
    group_label: "Ideal Customer Attributes"
    value_format_name: decimal_1

    type: average
    sql: ${referenceability} ;;
  }

  dimension: ideal_customer_score {
    group_label: "Ideal Customer Attributes"

    type: number
    sql: ${TABLE}.Score ;;
  }

  measure: average_ideal_customer_score {
    group_label: "Ideal Customer Attributes"
    value_format_name: decimal_1

    type: average
    sql: ${ideal_customer_score} ;;
  }

  dimension: segment {
    group_label: "Ideal Customer Attributes"
    order_by_field: segment_order

    type: string
    sql: ${TABLE}.segment ;;
  }

  dimension: service {
    group_label: "Ideal Customer Attributes"

    type: string
    sql: ${TABLE}.Service ;;
  }

  dimension: size {
    group_label: "Ideal Customer Attributes"

    type: string
    sql: ${TABLE}.Size ;;
  }

  dimension: size_of_ra_team {
    group_label: "Ideal Customer Attributes"

    type: number
    sql: ${TABLE}.Size_of_RA_Team ;;
  }

  dimension: status {
    group_label: "Ideal Customer Attributes"

    type: string
    sql: ${TABLE}.Status ;;
  }

  dimension: verticals {
    group_label: "Ideal Customer Attributes"

    type: string
    sql: ${TABLE}.Verticals ;;
  }


  dimension: company_currency_code {
    hidden: yes
    type: string
    sql: ${TABLE}.company_currency_code ;;
  }

  dimension: company_description {
    group_label: "     Company"

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
    group_label: "     Company"

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
    group_label: "     Company"

    type: string
    sql: ${TABLE}.company_linkedin_bio ;;
  }

  dimension: company_linkedin_company_page {
    hidden: no
    group_label: "     Company"

    type: string
    sql: ${TABLE}.company_linkedin_company_page ;;
  }

  dimension: company_name {
    group_label: "     Company"

    label: "Company"
    type: string
    sql: case when ${TABLE}.company_name = 'indexlabs.co.uk' then 'Football Index' else ${TABLE}.company_name end;;
}





  dimension: company_phone {
    hidden: yes

    type: string
    sql: ${TABLE}.company_phone ;;
  }

  dimension: company_pk {
    hidden: no
    primary_key: yes
    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension: company_twitterhandle {
    group_label: "     Company"

    hidden: no

    type: string
    sql: ${TABLE}.company_twitterhandle ;;
  }

  dimension: company_website {
    group_label: "     Company"

    hidden: no

    type: string
    sql: ${TABLE}.company_website ;;
  }

  measure: count {
    group_label: "     Company"

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
