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

  measure: total_clients {

    type: count_distinct
    sql: ${company_pk} ;;
    filters: [is_ideal_customer_ranked: "Yes"]
    drill_fields: [detail*]
  }

  # ---- Ideal Customer Columns

  parameter: ideal_customer_x_slicer {
    type: unquoted
    group_label: "     Ideal Customer"
    allowed_value: {label: "Ideal Customer Group" value: "ideal_customer_group"}
    allowed_value: {label: "Ideal Customer Ranking" value: "ideal_customer_ranking"}
    allowed_value: {label: "Ideal Customer Buyer Role" value: "original_buyer_role"}
    allowed_value: {label: "Ideal Customer Buyer Department" value: "original_buyer_department"}
    allowed_value: {label: "Ideal Customer Lead Pathway" value: "original_lead_pathway"}
    allowed_value: {label: "Ideal Customer Lead Customer Source" value: "original_lead_customer_source"}
    allowed_value: {label: "Ideal Customer Client Size" value: "company_size"}
    allowed_value: {label: "Ideal Customer Client Vertical" value: "ideal_customer_vertical"}
    allowed_value: {label: "Ideal Customer Original Buyer Challenge" value: "original_buyer_challenge"}
    allowed_value: {label: "Ideal Customer Original Buyer Requirement" value: "original_buyer_requirement"}
    allowed_value: {label: "Ideal Customer Original Appeal of RA to Buyer" value: "original_appeal_of_ra_to_buyer"}
    allowed_value: {label: "Ideal Customer Total Months Billed" value: "ideal_customer_months_billed"}
    allowed_value: {label: "Ideal Customer Original Buyer Data Maturity" value: "original_buyer_data_maturity"}
    allowed_value: {label: "Ideal Customer Original Org Data Maturity" value: "original_org_data_maturity"}
    allowed_value: {label: "Ideal Customer Cohort" value: "ideal_customer_cohort"}
    allowed_value: {label: "Ideal Customer Churned Year" value: "ideal_customer_churned_year"}
    allowed_value: {label: "Ideal Customer Original Market" value: "original_market"}
    allowed_value: {label: "Ideal Customer Original Service" value: "original_service"}
    allowed_value: {label: "Ideal Customer Fee Structure" value: "original_fee_structure"}
    allowed_value: {label: "Ideal Customer Original BI Tool" value: "original_bi_tool"}
    allowed_value: {label: "Ideal Customer Original Lead Technology" value: "original_lead_technology"}
    allowed_value: {label: "Ideal Customer Original Database" value: "original_database"}
    allowed_value: {label: "Ideal Customer Original RA Lead" value: "original_ra_lead"}
    allowed_value: {label: "Ideal Customer Original Size of RA Team" value: "original_size_of_ra_team"}
    allowed_value: {label: "Ideal Customer Loyalty Score" value: "ideal_customer_loyalty_score"}
    allowed_value: {label: "Ideal Customer IP Reusability Score" value: "ideal_customer_ip_score"}
    allowed_value: {label: "Ideal Customer Revenue Score" value: "ideal_customer_revenue_score"}
    allowed_value: {label: "Ideal Customer Satisfaction Score" value: "ideal_customer_satisfaction_score"}
    allowed_value: {label: "Ideal Customer Total Score" value: "ideal_customer_total_score"}
    default_value: "ideal_customer_group"
    }

  parameter: ideal_customer_y_slicer {
    type: unquoted

    group_label: "     Ideal Customer"
    allowed_value: {label: "Ideal Customer Group" value: "ideal_customer_group"}
    allowed_value: {label: "Ideal Customer Ranking" value: "ideal_customer_ranking"}
    allowed_value: {label: "Ideal Customer Buyer Role" value: "original_buyer_role"}
    allowed_value: {label: "Ideal Customer Buyer Department" value: "original_buyer_department"}
    allowed_value: {label: "Ideal Customer Lead Pathway" value: "original_lead_pathway"}
    allowed_value: {label: "Ideal Customer Lead Customer Source" value: "original_lead_customer_source"}
    allowed_value: {label: "Ideal Customer Client Size" value: "company_size"}
    allowed_value: {label: "Ideal Customer Client Vertical" value: "ideal_customer_vertical"}
    allowed_value: {label: "Ideal Customer Original Buyer Challenge" value: "original_buyer_challenge"}
    allowed_value: {label: "Ideal Customer Original Buyer Requirement" value: "original_buyer_requirement"}
    allowed_value: {label: "Ideal Customer Original Appeal of RA to Buyer" value: "original_appeal_of_ra_to_buyer"}
    allowed_value: {label: "Ideal Customer Total Months Billed" value: "ideal_customer_months_billed"}
    allowed_value: {label: "Ideal Customer Original Buyer Data Maturity" value: "original_buyer_data_maturity"}
    allowed_value: {label: "Ideal Customer Original Org Data Maturity" value: "original_org_data_maturity"}
    allowed_value: {label: "Ideal Customer Cohort" value: "ideal_customer_cohort"}
    allowed_value: {label: "Ideal Customer Churned Year" value: "ideal_customer_churned_year"}
    allowed_value: {label: "Ideal Customer Original Market" value: "original_market"}
    allowed_value: {label: "Ideal Customer Original Service" value: "original_service"}
    allowed_value: {label: "Ideal Customer Fee Structure" value: "original_fee_structure"}
    allowed_value: {label: "Ideal Customer Original BI Tool" value: "original_bi_tool"}
    allowed_value: {label: "Ideal Customer Original Lead Technology" value: "original_lead_technology"}
    allowed_value: {label: "Ideal Customer Original Database" value: "original_database"}
    allowed_value: {label: "Ideal Customer Original RA Lead" value: "original_ra_lead"}
    allowed_value: {label: "Ideal Customer Original Size of RA Team" value: "original_size_of_ra_team"}
    allowed_value: {label: "Ideal Customer Loyalty Score" value: "ideal_customer_loyalty_score"}
    allowed_value: {label: "Ideal Customer IP Reusability Score" value: "ideal_customer_ip_score"}
    allowed_value: {label: "Ideal Customer Revenue Score" value: "ideal_customer_revenue_score"}
    allowed_value: {label: "Ideal Customer Satisfaction Score" value: "ideal_customer_satisfaction_score"}
    allowed_value: {label: "Ideal Customer Total Score" value: "ideal_customer_total_score"}
    default_value: "original_buyer_role"
  }

  parameter: ideal_customer_analysis_measure {
    type: unquoted
    allowed_value: {label: "Total Clients" value: "total_clients"}
    allowed_value: {label: "Avg Lifetime Value" value: "avg_ltv"}
    allowed_value: {label: "Avg Lifetime Profit" value: "avg_ltp"}
    allowed_value: {label: "Avg Hourly Rate" value: "avg_hourly_rate"}
    allowed_value: {label: "Avg NPS Score" value: "avg_nps_score"}
    default_value: "total_clients"
  }


  dimension: ideal_customer_x_group {
    group_label: "     Ideal Customer"

    label_from_parameter: ideal_customer_x_slicer
    type: string
    sql: ${TABLE}.{% parameter ideal_customer_x_slicer %} ;;
  }

  dimension: is_ideal_customer_ranked{
    group_label: "     Ideal Customer"
    type: yesno
    sql: ${TABLE}.ideal_customer_group is not null ;;
  }

  measure: ideal_customer_measure {
    group_label: "     Ideal Customer"
    label_from_parameter: ideal_customer_analysis_measure
    type: number
    sql:
      {% if ideal_customer_analysis_measure._parameter_value == "total_clients" %} ${companies_dim.total_clients}
      {% elsif ideal_customer_analysis_measure._parameter_value == "avg_ltv" %} round(${projects_invoiced.total_invoiced_net_amount_gbp}/${companies_dim.total_clients})
      {% elsif ideal_customer_analysis_measure._parameter_value == "avg_ltp" %} round(((${projects_invoiced.total_invoiced_net_amount_gbp})-(${project_timesheets.total_timesheet_cost_amount_gbp}+${timesheet_project_costs_fact.total_cost_gbp}))/${companies_dim.total_clients})
      {% elsif ideal_customer_analysis_measure._parameter_value == "avg_nps_score" %} ${nps_survey_results_fact.nps_score}
      {% elsif ideal_customer_analysis_measure._parameter_value == "avg_hourly_rate" %} round(${projects_invoiced.total_invoiced_net_amount_gbp}/${project_timesheets.total_timesheet_hours_billed},2)
      {% endif %};;
    }





  dimension: ideal_customer_y_group {
    group_label: "     Ideal Customer"

    label_from_parameter: ideal_customer_y_slicer
    type: string
    sql: ${TABLE}.{% parameter ideal_customer_y_slicer %} ;;
  }

  dimension: ideal_customer_group {
    order_by_field: ideal_customer_group_natural_key
    group_label: "     Ideal Customer"
    type: string
    sql: ${TABLE}.ideal_customer_group ;;
  }

  dimension: ideal_customer_group_natural_key {
    hidden: no
    type: number
    sql: ${TABLE}.ideal_customer_group_natural_key ;;
  }

  measure: ideal_customer_ranking {
    group_label: "     Ideal Customer"

    type: average
    value_format_name: decimal_2

    sql: ${TABLE}.ideal_customer_ranking ;;
  }

  dimension: original_buyer_role {
    group_label: "     Ideal Customer"

    type: string
    sql: ${TABLE}.original_buyer_role ;;
  }

  dimension: original_buyer_department {
    group_label: "     Ideal Customer"

    type: string
    sql: ${TABLE}.original_buyer_department ;;
  }

  dimension: original_lead_pathway {
    group_label: "     Ideal Customer"

    type: string
    sql: ${TABLE}.original_lead_pathway ;;
  }

  dimension: original_lead_customer_source {
    group_label: "     Ideal Customer"

    type: string
    sql: ${TABLE}.original_lead_customer_source ;;
  }

  dimension: company_size {
    group_label: "     Ideal Customer"

    type: string
    sql: ${TABLE}.company_size ;;
  }

  dimension: ideal_customer_vertical {
    group_label: "     Ideal Customer"

    type: string
    sql: ${TABLE}.ideal_customer_vertical ;;
  }

  dimension: original_buyer_requirement {
    group_label: "     Ideal Customer"

    type: string
    sql: ${TABLE}.original_buyer_requirement ;;
  }

  dimension: original_buyer_challenge {
    group_label: "     Ideal Customer"

    type: string
    sql: ${TABLE}.original_buyer_challenge ;;
  }

  dimension: original_appeal_of_ra_to_buyer {
    group_label: "     Ideal Customer"

    type: string
    sql: ${TABLE}.original_appeal_of_ra_to_buyer ;;
  }

  dimension: original_buyer_data_maturity {
    group_label: "     Ideal Customer"

    type: string
    sql: ${TABLE}.original_buyer_data_maturity ;;
  }

  dimension: original_org_data_maturity {
    group_label: "     Ideal Customer"

    type: string
    sql: ${TABLE}.original_org_data_maturity ;;
  }

  dimension: ideal_customer_cohort {
    group_label: "     Ideal Customer"

    type: string
    sql: ${TABLE}.ideal_customer_cohort ;;
  }

  dimension: ideal_customer_churned_year {
    group_label: "     Ideal Customer"

    type: string
    sql: ${TABLE}.ideal_customer_churned_year ;;
  }

  dimension: ideal_customer_months_billed {
    group_label: "     Ideal Customer"

    type: number
    sql: ${TABLE}.ideal_customer_months_billed ;;
  }

  dimension: ideal_customer_churn_reason {
    group_label: "     Ideal Customer"

    type: string
    sql: ${TABLE}.ideal_customer_churn_reason ;;
  }

  dimension: ideal_customer_testimonial_url {
    group_label: "     Ideal Customer"
    hidden: yes
    type: string
    sql: ${TABLE}.ideal_customer_testimonial_url ;;
  }

  dimension: original_market {
    group_label: "     Ideal Customer"

    type: string
    sql: ${TABLE}.original_market ;;
  }

  dimension: original_service {
    group_label: "     Ideal Customer"

    type: string
    sql: ${TABLE}.original_service ;;
  }

  dimension: original_work_delivered {
    group_label: "     Ideal Customer"

    type: string
    sql: ${TABLE}.original_work_delivered ;;
  }

  dimension: original_fee_structure {
    group_label: "     Ideal Customer"

    type: string
    sql: ${TABLE}.original_fee_structure ;;
  }

  dimension: original_lead_technology {
    group_label: "     Ideal Customer"

    type: string
    sql: ${TABLE}.original_lead_technology ;;
  }

  dimension: original_database {
    group_label: "     Ideal Customer"

    type: string
    sql: ${TABLE}.original_database ;;
  }

  dimension: original_bi_tool {
    group_label: "     Ideal Customer"

    type: string
    sql: ${TABLE}.original_bi_tool ;;
  }

  dimension: original_is_data_analyst_available {
    group_label: "     Ideal Customer"

    type: string
    sql: ${TABLE}.original_is_data_analyst_available ;;
  }

  dimension: original_expectations_alignment {
    group_label: "     Ideal Customer"

    type: yesno
    sql: ${TABLE}.original_expectations_alignment = "Y" ;;
  }

  dimension: original_is_handover_planned {
    group_label: "     Ideal Customer"

    type: yesno
    sql: ${TABLE}.original_is_handover_planned = "Y" ;;
  }

  dimension: original_license_referral {
    group_label: "     Ideal Customer"

    type: yesno
    sql: ${TABLE}.original_is_license_referral = "Y";;
  }

  dimension: original_ra_lead {
    group_label: "     Ideal Customer"

    type: string
    sql: ${TABLE}.original_ra_lead ;;
  }

  dimension: orignal_delivery_team {
    group_label: "     Ideal Customer"

    type: string
    sql: ${TABLE}.oriignal_delivery_team ;;
  }

  measure: original_size_of_ra_team {
    group_label: "     Ideal Customer"

    type: average
    value_format_name: decimal_2

    sql: ${TABLE}.original_size_of_ra_team ;;
  }

  measure: ideal_customer_loyalty_score {
    group_label: "     Ideal Customer"

    type: average
    value_format_name: decimal_2

    sql: ${TABLE}.ideal_customer_loyalty_score ;;
  }

  measure: ideal_customer_revenue_score {
    group_label: "     Ideal Customer"

    type: average
    value_format_name: decimal_2

    sql: ${TABLE}.ideal_customer_revenue_score ;;
  }

  measure: ideal_customer_satisfaction_score {
    group_label: "     Ideal Customer"

    type: average
    value_format_name: decimal_2

    sql: ${TABLE}.ideal_customer_satisfaction_score ;;
  }

  measure: ideal_customer_ip_score {
    group_label: "     Ideal Customer"

    type: average
    value_format_name: decimal_2

    sql: ${TABLE}.ideal_customer_ip_score ;;
  }

  measure: ideal_customer_total_score {
    group_label: "     Ideal Customer"

    type: average
    value_format_name: decimal_2
    sql: ${TABLE}.ideal_customer_total_score ;;
  }

  dimension: hubspot_company_id {
    hidden: yes
    sql: (SELECT max(hubspot_company_id) FROM UNNEST(all_company_ids) AS hubspot_company_id WHERE hubspot_company_id like '%hubspot%') ;;
  }

  dimension: all_company_ids {
    hidden: yes

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
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Companies Dim All Company Ids" in Explore.

  dimension: companies_dim__all_company_ids {
    type: string
    hidden: yes
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
