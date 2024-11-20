view: deals_fact {
  sql_table_name: `{{ _user_attributes['dataset'] }}.deals_fact`;;
  view_label: "Sales Pipeline"


 dimension: company_pk {
    type: string
    hidden: yes
    sql: ${TABLE}.company_fk ;;
    description: "The primary key for the company associated with a deal"
  }

  dimension: deal_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.deal_amount ;;
    description: "The amount associated with a deal"
  }

  measure: total_deal_amount {
    value_format_name: decimal_2
    label: "Total Deal Amount Local"
    type: sum
    hidden: yes
    sql: ${TABLE}.deal_amount ;;
    description: "Total sum of all deal amounts"
  }







  dimension_group: deal_closed {
    group_label: "           {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Dates"

    label: "Deal Closed"
    type: time
    timeframes: [date,week,week_of_year,month_num,month, quarter,year]
    sql: ${TABLE}.deal_closed_ts;;
    description: "Time group for when deals were closed"
  }



  dimension: deal_closed_lost_reason {
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"
    label: "Deal Lost Reason"
    type: string
    sql: ${TABLE}.deal_closed_lost_reason ;;
    description: "Reason for why a deal was closed and lost"
  }

  dimension_group: deal_created {
    group_label: "           {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Dates"
    label: "Deal Created"
    type: time
    timeframes: [
      date,
      week,
      month,


      quarter,
      year
    ]
    sql: ${TABLE}.deal_created_ts ;;
    description: "Time group for when deals were created"
  }

  dimension: deal_description {
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"
    label: "              Deal Description"
    type: string
    sql: ${TABLE}.deal_description ;;
    description: "Description of the deal"
  }




dimension: deal_id {
  description: "The unique identifier for the deal in Hubspot."
  group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"

  hidden: no
  type: number
  value_format_name: id
  sql: ${TABLE}.deal_id ;;
}

dimension: deal_is_deleted {
  description: "Indicates whether the deal was deleted."
  group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"
  label: "Is Deal Deleted"
  type: yesno
  sql: ${TABLE}.deal_is_deleted ;;
}

  dimension_group: deal_last_modified {
    description: "The time the deal was last modified."
    type: time
    hidden: yes
    timeframes: [
      time
    ]
    sql: ${TABLE}.deal_last_modified_ts ;;
  }

  dimension: deal_name {
    description: "The name of the deal."
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"
    label: "                Deal Name"
    type: string
    sql: ${TABLE}.deal_name ;;
  }

  dimension: deal_owner_id {
    description: "The unique identifier for the owner of the deal."
    hidden: yes
    type: string
    sql: ${TABLE}.deal_owner_id ;;
  }

  dimension: deal_pipeline_id {
    description: "The unique identifier for the pipeline the deal is in."
    hidden: yes
    type: string
    sql: ${TABLE}.deal_pipeline_id ;;
  }

  dimension: deal_pipeline_stage_id {
    description: "The unique identifier for the stage of the pipeline the deal is in."
    hidden: yes
    type: string
    sql: ${TABLE}.deal_pipeline_stage_id ;;
  }

  dimension_group: deal_pipeline_stage {
    description: "The time the deal reached a particular stage in the pipeline."
    group_label: "           {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Dates"
    label: "            Deal Pipeline Stage"
    type: time
    timeframes: [date,month,week,year]
    sql: ${TABLE}.deal_pipeline_stage_ts ;;
  }

  dimension: deal_pk {
    description: "The primary key for the deal."
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.deal_pk ;;
  }

  measure: count_deals {
    description: "The total number of deals."
    label: "               Total Deals"
    type: count_distinct
    sql: ${TABLE}.deal_pk ;;
  }

  measure: count_oppportunity_deals {
    description: "The total number of opportunity deals (deals in a stage with a display order less than 8)."
    label: "              Total Open Deals"
    type: count_distinct
    sql: case when ${TABLE}.deal_pipeline_stage_id not in ('closedlost','1031924','1031923') then ${TABLE}.deal_pk end;;
  }



  measure: count_closed_won_deals {
    description: "The total number of deals in the 'closed won' stage."
    label: "            Total Won Deals"
    type: count_distinct
    sql: case when ${TABLE}.deal_pipeline_stage_id in ('1031924','1031923') then ${TABLE}.deal_pk end;;
  }

  measure: total_closed_lost_deals {
    label: "          Total Lost Deals"
    type: count_distinct
    sql: case when ${TABLE}.deal_pipeline_stage_id = 'closedlost'  then  ${TABLE}.deal_pk end;;
    description: "Count of deals where the deal stage is closed-lost"
  }

  measure: total_deal_amount_gbp_converted  {
    label: "        Total Deal Amount GBP"
    value_format_name: gbp
    type: sum
    sql:  CASE
         when ${TABLE}.deal_currency_code = 'USD' then ${TABLE}.deal_amount * .78
         when ${TABLE}.deal_currency_code = 'CAD' then ${TABLE}.deal_amount * .59
         when ${TABLE}.deal_currency_code = 'EUR' then ${TABLE}.deal_amount * 0.87
         else ${TABLE}.deal_amount end ;;
    description: "Total sum of deal amounts converted to GBP based on the deal currency code"
  }



  measure: total_open_deal_amount_gbp {
    label: "        Total Open Deal Amount GBP"
    value_format_name: gbp
    type: sum
    sql:  case when ${TABLE}.deal_pipeline_stage_id not in ('1031924','1031923','closedlost') then
            CASE
             when ${TABLE}.deal_currency_code = 'USD' then ${TABLE}.deal_amount * .78
             when ${TABLE}.deal_currency_code = 'CAD' then ${TABLE}.deal_amount * .59
             when ${TABLE}.deal_currency_code = 'EUR' then ${TABLE}.deal_amount * 0.87
              else ${TABLE}.deal_amount end
          else 0 end;;
    description: "Total sum of open deal amounts converted to GBP"
  }


  measure: total_closed_won_deal_amount {
    label: "Total Closed Won Deal Amount Local"

    value_format_name: decimal_0
    type: sum
    sql: case when ${TABLE}.pipeline_stage_closed_won   then  ${TABLE}.deal_amount end;;
    description: "Total sum of deal amounts where the deal stage is closed-won"
  }



  measure: total_closed_won_deal_amount_gbp {
    label: "    Total Won Deal Amount GBP"

    value_format_name: gbp_0
    type: sum
    sql: case when ${TABLE}.deal_pipeline_stage_id in ('1031924','1031923') then
            CASE
             when ${TABLE}.deal_currency_code = 'USD' then ${TABLE}.deal_amount * .78
             when ${TABLE}.deal_currency_code = 'CAD' then ${TABLE}.deal_amount * .59
             when ${TABLE}.deal_currency_code = 'EUR' then ${TABLE}.deal_amount * 0.87
              else ${TABLE}.deal_amount end
          else 0 end;;
    description: "Total sum of deal amounts where the deal stage is closed-won"
  }

  measure: total_closed_lost_deal_amount {
    label: "    Total Lost Deal Amount Local"
    hidden: yes
    value_format_name: decimal_2
    type: sum
    sql: case when ${TABLE}.deal_pipeline_stage_id = 'closedlost'  then  ${TABLE}.deal_amount end;;
    description: "Total sum of deal amounts where the deal stage is closed-lost"
  }

  measure: total_closed_lost_deal_amount_gbp {
    label: "  Total Lost Deal Amount GBP"

    value_format_name: gbp_0
    type: sum
    sql: case when ${TABLE}.deal_pipeline_stage_id in ('closedlost') then
            CASE
             when ${TABLE}.deal_currency_code = 'USD' then ${TABLE}.deal_amount * .78
             when ${TABLE}.deal_currency_code = 'CAD' then ${TABLE}.deal_amount * .59
             when ${TABLE}.deal_currency_code = 'EUR' then ${TABLE}.deal_amount * 0.87
              else ${TABLE}.deal_amount end
          else 0 end;;
    description: "Total sum of deal amounts where the deal stage is closed-lost"
  }

  dimension: deal_type {
    description: "The type of the deal, 'Existing Business' if not specified."
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"
    label: "            Deal Type"
    sql: case when ${TABLE}.deal_type is null then 'Existing Business' else ${TABLE}.deal_type end ;;
  }

  dimension_group: delivery_schedule_ts {
    group_label: "           {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Dates"
    label: "Delivery Scheduled"
    type: time
    timeframes: [
      date,
      week,
      month
           ]
    sql: coalesce(${TABLE}.delivery_schedule_ts,${TABLE}.delivery_start_date_ts) ;;
  }



  dimension: partner_deal_contact_name {
    label: "            Partner Deal Contact Name"
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Funding"
    type: string
    sql: ${TABLE}.partner_deal_contact_name ;;
  }

  dimension: funding_partner_name {
    label: "           Funding Partner"
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Funding"
    type: string
    sql: ${TABLE}.funding_partner_name ;;
  }

  dimension: partner_funding_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.partner_funding_amount ;;
  }

  dimension: deal_jumpstart_type {
    label: "              Jumpstart Type"
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Funding"
    type: string
    sql: ${TABLE}.deal_jumpstart_type ;;
  }

  dimension: partner_funding_scheme {
    label: "          Partner Funding Scheme"
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Funding"
    type: string
    sql: ${TABLE}.partner_funding_scheme ;;
  }

  dimension: buyer_confirmed_budget_available {
    label: "      Has Buyer Confirmed Budget Available"
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"
    type: string
    sql: ${TABLE}.buyer_confirmed_budget_available ;;
  }

  dimension: spend_agreed_with_buyer {
    label: "      Is Spend Agreed with Buyer"
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"
    type: string
    sql: ${TABLE}.spend_agreed_with_buyer ;;
  }



  dimension: forecasted_duration_months {
    hidden: yes
    type: number
    sql: ${TABLE}.forecasted_duration_months ;;
  }

  dimension: forecasted_monthly_hours {
    hidden: yes
    type: number
    sql: ${TABLE}.forecasted_monthly_hours ;;
  }

  measure: total_forecasted_monthly_hours {
    label: "Total Forecasted Delivery Hours"
    type: sum
    sql: ${forecasted_duration_months}*${forecasted_monthly_hours} ;;
  }









  dimension: deal_stage_display_order {
    description: "The order in which the deal stage is displayed in the pipeline."
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"
    hidden: yes
    type: number
    sql: ${TABLE}.deal_stage_display_order ;;
  }

  dimension: deal_stage_probability {
    description: "The probability associated with the stage of the deal in the pipeline."
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"
    hidden: yes
    type: number
    sql: ${TABLE}.deal_stage_probability ;;
  }

  dimension: deal_stage_closed_won {
    description: "Indicates if the deal stage is considered 'closed won'."
    label: "Is Won Deal"
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"
    type: yesno
    sql: ${TABLE}.deal_pipeline_stage_id in ('1031924','1031923')  ;;
  }

  dimension: days_to_close_won {
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"
    label: "Days to Close Won Deal"
    type: number
    sql: case when ${TABLE}.deal_pipeline_stage_id in ('1031924','1031923') then date_diff(date(${TABLE}.deal_closed_ts),date(${TABLE}.deal_created_ts),DAY) end ;;
  }

  measure: avg_days_to_close_won {
    label: "Avg Days Required to Close Deal"
    hidden: no
    type: average
    value_format_name: decimal_0
    sql: ${days_to_close_won} ;;
  }

  dimension: deal_stage_closed_lost {
    description: "Indicates if the deal stage is considered 'closed lost'."
    label: "Is Lost Deal"
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"
    type: yesno
    sql: ${TABLE}.deal_pipeline_stage_id = 'closedlost' ;;
  }



  dimension: owner_email {
    group_label: "           {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Source"

    type: string
    sql: ${TABLE}.owner_email ;;
  }

  dimension: owner_full_name {
    group_label: "           {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Source"

    type: string
    sql: ${TABLE}.owner_full_name ;;
  }

  dimension: pipeline_display_order {
    hidden: yes
    type: number
    sql: ${TABLE}.pipeline_display_order ;;
  }

  dimension: pipeline_label {
    group_label: "           {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Pipeline"
    order_by_field: pipeline_display_order
    hidden: yes
    type: string
    sql: ${TABLE}.pipeline_label ;;
  }

  dimension: pipeline_stage_close_probability_pct {
    hidden: yes

    type: number
    sql: ${TABLE}.pipeline_stage_close_probability_pct ;;
  }

  measure: total_weighted_opportunity_deal_amount {
    label: "Total Weighted Open Deal Amount Local"
    hidden: yes
    type: sum
    value_format_name: gbp
    sql: case when ${TABLE}.deal_pipeline_stage_id not in ('closedlost','1031924','1031923') then ${TABLE}.deal_amount * ${TABLE}.pipeline_stage_close_probability_pct else 0 end ;;
  }

  measure: total_weighted_open_deal_amount_gbp {
    label: "Total Weighted Open Deal Amount GBP"
    type: sum
    value_format_name: gbp
    sql: case when ${TABLE}.deal_pipeline_stage_id not in ('1031924','1031923','closedlost') then
            CASE
             when ${TABLE}.deal_currency_code = 'USD' then (${TABLE}.deal_amount * .78) * ${TABLE}.pipeline_stage_close_probability_pct
             when ${TABLE}.deal_currency_code = 'CAD' then (${TABLE}.deal_amount * .59) * ${TABLE}.pipeline_stage_close_probability_pct
             when ${TABLE}.deal_currency_code = 'EUR' then (${TABLE}.deal_amount * 0.87) * ${TABLE}.pipeline_stage_close_probability_pct
              else ${TABLE}.deal_amount * ${TABLE}.pipeline_stage_close_probability_pct end
          else 0 end;;

  }






  dimension: pipeline_stage_closed_won {
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"
    label: "Is Closed Won"
    type: yesno
    sql: ${TABLE}.pipeline_stage_closed_won ;;
  }

  dimension: pipeline_stage_display_order {
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"

    hidden: no
    type: number
    sql: ${TABLE}.pipeline_stage_display_order ;;
  }

  dimension: pipeline_stage_label {
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"
    type: string
    label: "  Deal Pipeline Stage"

    order_by_field: pipeline_stage_display_order

    sql: ${TABLE}.pipeline_stage_label ;;
  }



  dimension: number_of_sprints {
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"
    label: "          Deal Number of Sprints"
    type: number
    sql: ${TABLE}.deal_number_of_sprints ;;
  }

  dimension: deal_components {
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"
    hidden: yes
    type: string
    sql: ${TABLE}.deal_components ;;
  }

  dimension: services {
    group_label: "          {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Components"
    hidden: yes

    type: yesno
    sql: ${TABLE}.is_services_deal ;;
  }

  dimension: managed_services {
    group_label: "          {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Components"
    hidden: yes

    type: yesno
    sql: ${TABLE}.is_managed_services_deal ;;
  }

  dimension: license_referral {
    group_label: "          {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Components"
    hidden: yes

    type: yesno
    sql: ${TABLE}.is_license_referral_deal ;;
  }

  dimension: training {
    group_label: "          {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Components"
    hidden: yes

    type: yesno
    sql: ${TABLE}.is_training_deal ;;
  }


  dimension: pricing_model {
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"
    type: string
    label: " Deal Pricing Model"

    sql: ${TABLE}.deal_pricing_model ;;
  }

  dimension: partner_referral {
    group_label: "           {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Source"
    label: "Deal Referring Partner"
    type: string
    sql: ${TABLE}.deal_partner_referral ;;
  }

  dimension: sprint_type {
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"
    label: "  Deal Sprint Type"
    type: string
    sql: ${TABLE}.deal_sprint_type ;;
  }





  dimension: products_in_solution {
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"
    hidden: yes

    type: string
    sql: ${TABLE}.deal_products_in_solution ;;
  }





  dimension: deal_currency_code {
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"
    description: "This is the purpose the field"
    type: string
    sql: ${TABLE}.deal_currency_code ;;
  }

  dimension: deal_source {
    group_label: "           {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Source"
    hidden: no

    type: string
    sql: ${TABLE}.deal_source ;;
  }



  dimension: deal_end_ts {
    type: date_time
    hidden: yes
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"

    sql: ${TABLE}.deal_end_ts ;;
  }

  dimension_group: dt_entered_3_sow_drafted {
    group_label: "           {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Dates"

    label: "Deal SoW Drafted"
    type: time
    timeframes: [date]
    sql: ${TABLE}.dt_entered_3_sow_drafted ;;
  }

  dimension_group: dt_entered_5_customer_agreed_sow {
    group_label: "           {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Dates"

    label: "Deal SoW Agreed"
    type: time
    timeframes: [date]
    sql: ${TABLE}.dt_entered_5_customer_agreed_sow ;;
  }

  dimension_group: dt_entered_7_sow_customer_docusigned {
    group_label: "           {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Dates"

    label: "Deal SoW Signed"
    type: time
    timeframes: [date]
    sql: ${TABLE}.dt_entered_7_sow_customer_docusigned ;;
  }

  dimension: deal_sales_email_last_replied {
    hidden: yes
    group_label: "           {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Dates"

    type: date_time
    sql: ${TABLE}.deal_sales_email_last_replied ;;
  }

  dimension: deal_last_meeting_booked_date {
    group_label: "           {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Dates"

    type: date_time

    sql: ${TABLE}.deal_last_meeting_booked_date ;;
  }

  dimension: manual_forecast_category {
    group_label: "        {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}} Forecast"
    hidden: yes
    type: string
    sql: ${TABLE}.manual_forecast_category ;;
  }

  dimension: forecast_probability {
    group_label: "   {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}} Forecast"
    hidden: yes
    type: number
    sql: ${TABLE}.forecast_probability ;;
  }



  dimension: predicted_amount {
    group_label: "   {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}} Forecast"
    hidden: yes
    type: string
    sql: ${TABLE}.predicted_amount ;;
  }

  dimension: days_in_pipeline {
    group_label: "            {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"

    type: number
    sql: ${TABLE}.days_in_pipeline ;;
  }


}
