view: deals_fact {
  sql_table_name: `ra-development.analytics.deals_fact` ;;

  dimension: buyer_confirmed_budget_available {
    type: string
    label: "Buyer Confirmed Budget Available"
    sql: ${TABLE}.buyer_confirmed_budget_available ;;
  }

  dimension: company_fk {
    type: string
    label: "Company Fk"
    sql: ${TABLE}.company_fk ;;
  }

  dimension: company_id {
    type: string
    label: "Company Id"
    sql: ${TABLE}.company_id ;;
  }

  dimension: created_by_user_id {
    type: number
    label: "Created By User Id"
    hidden: yes
    sql: ${TABLE}.created_by_user_id ;;
  }

  dimension: dbt_source_relation {
    type: string
    label: "_Dbt Source Relation"
    sql: ${TABLE}._dbt_source_relation ;;
  }

  dimension: deal_amount {
    type: number
    label: "Deal Amount"
    hidden: yes
    sql: ${TABLE}.deal_amount ;;
  }

  dimension: deal_annual_contract_amount {
    type: number
    label: "Deal Annual Contract Amount"
    hidden: yes
    sql: ${TABLE}.deal_annual_contract_amount ;;
  }

  dimension: deal_annual_recurring_revenue_amount {
    type: number
    label: "Deal Annual Recurring Revenue Amount"
    hidden: yes
    sql: ${TABLE}.deal_annual_recurring_revenue_amount ;;
  }

  dimension: deal_assigned_consultant {
    type: string
    label: "Deal Assigned Consultant"
    sql: ${TABLE}.deal_assigned_consultant ;;
  }

  dimension: deal_closed_amount_value {
    type: number
    label: "Deal Closed Amount Value"
    hidden: yes
    sql: ${TABLE}.deal_closed_amount_value ;;
  }

  dimension: deal_closed_lost_reason {
    type: string
    label: "Deal Closed Lost Reason"
    sql: ${TABLE}.deal_closed_lost_reason ;;
  }

  dimension_group: deal_closed_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Deal Closed Ts"
    sql: ${TABLE}.deal_closed_ts ;;
  }

  dimension: deal_components {
    type: string
    label: "Deal Components"
    sql: ${TABLE}.deal_components ;;
  }

  dimension_group: deal_created_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Deal Created Ts"
    sql: ${TABLE}.deal_created_ts ;;
  }

  dimension: deal_currency_code {
    type: string
    label: "Deal Currency Code"
    sql: ${TABLE}.deal_currency_code ;;
  }

  dimension: deal_days_to_close {
    type: number
    label: "Deal Days To Close"
    hidden: yes
    sql: ${TABLE}.deal_days_to_close ;;
  }

  dimension: deal_description {
    type: string
    label: "Deal Description"
    sql: ${TABLE}.deal_description ;;
  }

  dimension_group: deal_end_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Deal End Ts"
    sql: ${TABLE}.deal_end_ts ;;
  }

  dimension: deal_gross_amount_calculated {
    type: number
    label: "Deal_Gross_Amount__Calculated"
    hidden: yes
    sql: ${TABLE}.deal_gross_amount__calculated ;;
  }

  dimension: deal_harvest_project_id {
    type: string
    label: "Deal Harvest Project Id"
    sql: ${TABLE}.deal_harvest_project_id ;;
  }

  dimension: deal_id {
    type: number
    label: "Deal Id"
    hidden: yes
    sql: ${TABLE}.deal_id ;;
  }

  dimension: deal_is_deleted {
    type: yesno
    label: "Deal Is Deleted"
    sql: ${TABLE}.deal_is_deleted ;;
  }

  dimension: deal_jira_project_code {
    type: string
    label: "Deal Jira Project Code"
    sql: ${TABLE}.deal_jira_project_code ;;
  }

  dimension: deal_jumpstart_type {
    type: string
    label: "Deal Jumpstart Type"
    sql: ${TABLE}.deal_jumpstart_type ;;
  }

  dimension_group: deal_last_meeting_booked_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Deal Last Meeting Booked Date"
    sql: ${TABLE}.deal_last_meeting_booked_date ;;
  }

  dimension_group: deal_last_modified_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Deal Last Modified Ts"
    sql: ${TABLE}.deal_last_modified_ts ;;
  }

  dimension: deal_license_referral_harvest_project_code {
    type: string
    label: "Deal License Referral Harvest Project Code"
    sql: ${TABLE}.deal_license_referral_harvest_project_code ;;
  }

  dimension: deal_name {
    type: string
    label: "Deal Name"
    sql: ${TABLE}.deal_name ;;
  }

  dimension: deal_number_of_sprints {
    type: number
    label: "Deal Number Of Sprints"
    hidden: yes
    sql: ${TABLE}.deal_number_of_sprints ;;
  }

  dimension: deal_owner_id {
    type: string
    label: "Deal Owner Id"
    sql: ${TABLE}.deal_owner_id ;;
  }

  dimension: deal_partner_referral {
    type: string
    label: "Deal Partner Referral"
    sql: ${TABLE}.deal_partner_referral ;;
  }

  dimension: deal_pipeline_id {
    type: string
    label: "Deal Pipeline Id"
    sql: ${TABLE}.deal_pipeline_id ;;
  }

  dimension: deal_pipeline_stage_id {
    type: string
    label: "Deal Pipeline Stage Id"
    sql: ${TABLE}.deal_pipeline_stage_id ;;
  }

  dimension_group: deal_pipeline_stage_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Deal Pipeline Stage Ts"
    sql: ${TABLE}.deal_pipeline_stage_ts ;;
  }

  dimension: deal_pk {
    primary_key: yes
    type: string
    label: "Deal Pk"
    sql: ${TABLE}.deal_pk ;;
  }

  dimension: deal_pricing_model {
    type: string
    label: "Deal Pricing Model"
    sql: ${TABLE}.deal_pricing_model ;;
  }

  dimension: deal_products_in_solution {
    type: string
    label: "Deal Products In Solution"
    sql: ${TABLE}.deal_products_in_solution ;;
  }

  dimension_group: deal_sales_email_last_replied {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Deal Sales Email Last Replied"
    sql: ${TABLE}.deal_sales_email_last_replied ;;
  }

  dimension: deal_source {
    type: string
    label: "Deal Source"
    sql: ${TABLE}.deal_source ;;
  }

  dimension: deal_sprint_type {
    type: string
    label: "Deal Sprint Type"
    sql: ${TABLE}.deal_sprint_type ;;
  }

  dimension: deal_stage_probability_pct {
    type: number
    label: "Deal Stage Probability Pct"
    hidden: yes
    sql: ${TABLE}.deal_stage_probability_pct ;;
  }

  dimension: deal_tax_amount_calculated {
    type: number
    label: "Deal_Tax_Amount__Calculated"
    hidden: yes
    sql: ${TABLE}.deal_tax_amount__calculated ;;
  }

  dimension: deal_total_contract_amount {
    type: number
    label: "Deal Total Contract Amount"
    hidden: yes
    sql: ${TABLE}.deal_total_contract_amount ;;
  }

  dimension: deal_type {
    type: string
    label: "Deal Type"
    sql: ${TABLE}.deal_type ;;
  }

  dimension_group: delivery_schedule_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Delivery Schedule Ts"
    sql: ${TABLE}.delivery_schedule_ts ;;
  }

  dimension_group: delivery_start_date_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Delivery Start Date Ts"
    sql: ${TABLE}.delivery_start_date_ts ;;
  }

  dimension_group: dt_entered_1_initial_enquiry {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Dt Entered 1 Initial Enquiry"
    sql: ${TABLE}.dt_entered_1_initial_enquiry ;;
  }

  dimension_group: dt_entered_2_project_scoping {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Dt Entered 2 Project Scoping"
    sql: ${TABLE}.dt_entered_2_project_scoping ;;
  }

  dimension_group: dt_entered_3_sow_drafted {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Dt Entered 3 Sow Drafted"
    sql: ${TABLE}.dt_entered_3_sow_drafted ;;
  }

  dimension_group: dt_entered_4_partner_funding_agreed {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Dt Entered 4 Partner Funding Agreed"
    sql: ${TABLE}.dt_entered_4_partner_funding_agreed ;;
  }

  dimension_group: dt_entered_5_customer_agreed_sow {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Dt Entered 5 Customer Agreed Sow"
    sql: ${TABLE}.dt_entered_5_customer_agreed_sow ;;
  }

  dimension_group: dt_entered_6_partner_funding_signoff {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Dt Entered 6 Partner Funding Signoff"
    sql: ${TABLE}.dt_entered_6_partner_funding_signoff ;;
  }

  dimension_group: dt_entered_7_sow_customer_docusigned {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Dt Entered 7 Sow Customer Docusigned"
    sql: ${TABLE}.dt_entered_7_sow_customer_docusigned ;;
  }

  dimension_group: dt_entered_8_in_delivery {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Dt Entered 8 In Delivery"
    sql: ${TABLE}.dt_entered_8_in_delivery ;;
  }

  dimension: forecast_probability {
    type: number
    label: "Forecast Probability"
    hidden: yes
    sql: ${TABLE}.forecast_probability ;;
  }

  dimension: forecasted_duration_months {
    type: number
    label: "Forecasted Duration Months"
    hidden: yes
    sql: ${TABLE}.forecasted_duration_months ;;
  }

  dimension: forecasted_monthly_hours {
    type: number
    label: "Forecasted Monthly Hours"
    hidden: yes
    sql: ${TABLE}.forecasted_monthly_hours ;;
  }

  dimension: funding_partner_name {
    type: string
    label: "Funding Partner Name"
    sql: ${TABLE}.funding_partner_name ;;
  }

  dimension: hs_analytics_source {
    type: string
    label: "Hs Analytics Source"
    sql: ${TABLE}.hs_analytics_source ;;
  }

  dimension: hs_analytics_source_data_1 {
    type: string
    label: "Hs Analytics Source Data 1"
    sql: ${TABLE}.hs_analytics_source_data_1 ;;
  }

  dimension: hs_analytics_source_data_2 {
    type: string
    label: "Hs Analytics Source Data 2"
    sql: ${TABLE}.hs_analytics_source_data_2 ;;
  }

  dimension: hs_closed_amount_in_home_currency {
    type: number
    label: "Hs Closed Amount In Home Currency"
    hidden: yes
    sql: ${TABLE}.hs_closed_amount_in_home_currency ;;
  }

  dimension: hubspot_team_id {
    type: string
    label: "Hubspot Team Id"
    sql: ${TABLE}.hubspot_team_id ;;
  }

  dimension: is_dbt_skill_requirement {
    type: yesno
    label: "Is Dbt Skill Requirement"
    sql: ${TABLE}.is_dbt_skill_requirement ;;
  }

  dimension: is_fivetran_skill_requirement {
    type: yesno
    label: "Is Fivetran Skill Requirement"
    sql: ${TABLE}.is_fivetran_skill_requirement ;;
  }

  dimension: is_gcp_skill_requirement {
    type: yesno
    label: "Is Gcp Skill Requirement"
    sql: ${TABLE}.is_gcp_skill_requirement ;;
  }

  dimension: is_license_referral_deal {
    type: yesno
    label: "Is License Referral Deal"
    sql: ${TABLE}.is_license_referral_deal ;;
  }

  dimension: is_looker_skill_requirement {
    type: yesno
    label: "Is Looker Skill Requirement"
    sql: ${TABLE}.is_looker_skill_requirement ;;
  }

  dimension: is_managed_services_deal {
    type: yesno
    label: "Is Managed Services Deal"
    sql: ${TABLE}.is_managed_services_deal ;;
  }

  dimension: is_qubit_skill_requirement {
    type: yesno
    label: "Is Qubit Skill Requirement"
    sql: ${TABLE}.is_qubit_skill_requirement ;;
  }

  dimension: is_segment_skill_requirement {
    type: yesno
    label: "Is Segment Skill Requirement"
    sql: ${TABLE}.is_segment_skill_requirement ;;
  }

  dimension: is_services_deal {
    type: yesno
    label: "Is Services Deal"
    sql: ${TABLE}.is_services_deal ;;
  }

  dimension: is_snowflake_skill_requirement {
    type: yesno
    label: "Is Snowflake Skill Requirement"
    sql: ${TABLE}.is_snowflake_skill_requirement ;;
  }

  dimension: is_stitch_skill_requirement {
    type: yesno
    label: "Is Stitch Skill Requirement"
    sql: ${TABLE}.is_stitch_skill_requirement ;;
  }

  dimension: is_training_deal {
    type: yesno
    label: "Is Training Deal"
    sql: ${TABLE}.is_training_deal ;;
  }

  dimension: manual_forecast_category {
    type: string
    label: "Manual Forecast Category"
    sql: ${TABLE}.manual_forecast_category ;;
  }

  dimension: merged_object_ids {
    type: string
    label: "Merged Object Ids"
    sql: ${TABLE}.merged_object_ids ;;
  }

  dimension: owner_email {
    type: string
    label: "Owner Email"
    sql: ${TABLE}.owner_email ;;
  }

  dimension: owner_full_name {
    type: string
    label: "Owner Full Name"
    sql: ${TABLE}.owner_full_name ;;
  }

  dimension: partner_deal_contact_name {
    type: string
    label: "Partner Deal Contact Name"
    sql: ${TABLE}.partner_deal_contact_name ;;
  }

  dimension: partner_deal_signoff_authority_contact_name {
    type: string
    label: "Partner Deal Signoff Authority Contact Name"
    sql: ${TABLE}.partner_deal_signoff_authority_contact_name ;;
  }

  dimension: partner_funding_amount {
    type: number
    label: "Partner Funding Amount"
    hidden: yes
    sql: ${TABLE}.partner_funding_amount ;;
  }

  dimension: partner_funding_net_amount_calculated {
    type: number
    label: "Partner_Funding_Net_Amount__Calculated"
    hidden: yes
    sql: ${TABLE}.partner_funding_net_amount__calculated ;;
  }

  dimension: partner_funding_scheme {
    type: string
    label: "Partner Funding Scheme"
    sql: ${TABLE}.partner_funding_scheme ;;
  }

  dimension: partner_funding_tax_amount {
    type: number
    label: "Partner Funding Tax Amount"
    hidden: yes
    sql: ${TABLE}.partner_funding_tax_amount ;;
  }

  dimension: pipeline_display_order {
    type: number
    label: "Pipeline Display Order"
    hidden: yes
    sql: ${TABLE}.pipeline_display_order ;;
  }

  dimension: pipeline_label {
    type: string
    label: "Pipeline Label"
    sql: ${TABLE}.pipeline_label ;;
  }

  dimension: pipeline_stage_close_probability_pct {
    type: number
    label: "Pipeline Stage Close Probability Pct"
    hidden: yes
    sql: ${TABLE}.pipeline_stage_close_probability_pct ;;
  }

  dimension: pipeline_stage_closed_won {
    type: yesno
    label: "Pipeline Stage Closed Won"
    sql: ${TABLE}.pipeline_stage_closed_won ;;
  }

  dimension: pipeline_stage_display_order {
    type: number
    label: "Pipeline Stage Display Order"
    hidden: yes
    sql: ${TABLE}.pipeline_stage_display_order ;;
  }

  dimension: pipeline_stage_label {
    type: string
    label: "Pipeline Stage Label"
    sql: ${TABLE}.pipeline_stage_label ;;
  }

  dimension: predicted_amount {
    type: string
    label: "Predicted Amount"
    sql: ${TABLE}.predicted_amount ;;
  }

  dimension: projected_home_currency_amount {
    type: number
    label: "Projected Home Currency Amount"
    hidden: yes
    sql: ${TABLE}.projected_home_currency_amount ;;
  }

  dimension: projected_local_currency_amount {
    type: number
    label: "Projected Local Currency Amount"
    hidden: yes
    sql: ${TABLE}.projected_local_currency_amount ;;
  }

  dimension: spend_agreed_with_buyer {
    type: string
    label: "Spend Agreed With Buyer"
    sql: ${TABLE}.spend_agreed_with_buyer ;;
  }

  dimension: sprint_length_in_weeks {
    type: string
    label: "Sprint Length In Weeks"
    sql: ${TABLE}.sprint_length_in_weeks ;;
  }

  measure: total_created_by_user_id {
    type: sum
    label: "Created By User Id"
    sql: ${created_by_user_id} ;;
  }

  measure: total_deal_amount {
    type: sum
    label: "Deal Amount"
    sql: ${deal_amount} ;;
  }

  measure: total_deal_annual_contract_amount {
    type: sum
    label: "Deal Annual Contract Amount"
    sql: ${deal_annual_contract_amount} ;;
  }

  measure: total_deal_annual_recurring_revenue_amount {
    type: sum
    label: "Deal Annual Recurring Revenue Amount"
    sql: ${deal_annual_recurring_revenue_amount} ;;
  }

  measure: total_deal_closed_amount_value {
    type: sum
    label: "Deal Closed Amount Value"
    sql: ${deal_closed_amount_value} ;;
  }

  measure: total_deal_days_to_close {
    type: sum
    label: "Deal Days To Close"
    sql: ${deal_days_to_close} ;;
  }

  measure: total_deal_gross_amount_calculated {
    type: sum
    label: "Deal_Gross_Amount__Calculated"
    sql: ${deal_gross_amount_calculated} ;;
  }

  measure: total_deal_id {
    type: sum
    label: "Deal Id"
    sql: ${deal_id} ;;
  }

  measure: total_deal_number_of_sprints {
    type: sum
    label: "Deal Number Of Sprints"
    sql: ${deal_number_of_sprints} ;;
  }

  measure: total_deal_stage_probability_pct {
    type: sum
    label: "Deal Stage Probability Pct"
    sql: ${deal_stage_probability_pct} ;;
  }

  measure: total_deal_tax_amount_calculated {
    type: sum
    label: "Deal_Tax_Amount__Calculated"
    sql: ${deal_tax_amount_calculated} ;;
  }

  measure: total_deal_total_contract_amount {
    type: sum
    label: "Deal Total Contract Amount"
    sql: ${deal_total_contract_amount} ;;
  }

  measure: total_forecast_probability {
    type: sum
    label: "Forecast Probability"
    sql: ${forecast_probability} ;;
  }

  measure: total_forecasted_duration_months {
    type: sum
    label: "Forecasted Duration Months"
    sql: ${forecasted_duration_months} ;;
  }

  measure: total_forecasted_monthly_hours {
    type: sum
    label: "Forecasted Monthly Hours"
    sql: ${forecasted_monthly_hours} ;;
  }

  measure: total_hs_closed_amount_in_home_currency {
    type: sum
    label: "Hs Closed Amount In Home Currency"
    sql: ${hs_closed_amount_in_home_currency} ;;
  }

  measure: total_partner_funding_amount {
    type: sum
    label: "Partner Funding Amount"
    sql: ${partner_funding_amount} ;;
  }

  measure: total_partner_funding_net_amount_calculated {
    type: sum
    label: "Partner_Funding_Net_Amount__Calculated"
    sql: ${partner_funding_net_amount_calculated} ;;
  }

  measure: total_partner_funding_tax_amount {
    type: sum
    label: "Partner Funding Tax Amount"
    sql: ${partner_funding_tax_amount} ;;
  }

  measure: total_pipeline_display_order {
    type: sum
    label: "Pipeline Display Order"
    sql: ${pipeline_display_order} ;;
  }

  measure: total_pipeline_stage_close_probability_pct {
    type: sum
    label: "Pipeline Stage Close Probability Pct"
    sql: ${pipeline_stage_close_probability_pct} ;;
  }

  measure: total_pipeline_stage_display_order {
    type: sum
    label: "Pipeline Stage Display Order"
    sql: ${pipeline_stage_display_order} ;;
  }

  measure: total_projected_home_currency_amount {
    type: sum
    label: "Projected Home Currency Amount"
    sql: ${projected_home_currency_amount} ;;
  }

  measure: total_projected_local_currency_amount {
    type: sum
    label: "Projected Local Currency Amount"
    sql: ${projected_local_currency_amount} ;;
  }
}
