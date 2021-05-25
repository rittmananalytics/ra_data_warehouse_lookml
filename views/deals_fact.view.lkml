view: deals_fact {
  sql_table_name: `{{ _user_attributes['dataset'] }}.deals_fact`;;
  view_label: "Sales Pipeline"

  dimension: company_pk {
    type: string
    hidden: yes
    sql: ${TABLE}.company_pk ;;
  }

  dimension: deal_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.deal_amount ;;
  }

  measure: total_deal_amount {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Measures"

    value_format_name: gbp

    type: sum
    sql: ${TABLE}.deal_amount ;;
  }

measure: total_deal_amount_gbp_converted  {
  group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Measures"
  label: "Total Deal Amount GBP"
  value_format_name: gbp
  type: sum
  sql:  CASE
         when ${TABLE}.deal_currency_code = 'USD' then ${TABLE}.deal_amount * .75
         when ${TABLE}.deal_currency_code = 'CAD' then ${TABLE}.deal_amount * .58
         when ${TABLE}.deal_currency_code = 'EUR' then ${TABLE}.deal_amount * 0.90
         else ${TABLE}.deal_amount end ;;
}
  measure: total_oppportunity_deal_amount {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Measures"

    value_format_name: gbp

    type: sum
    sql: case when ${TABLE}.pipeline_stage_display_order <8 then ${TABLE}.deal_amount end;;
  }

  measure: total_closed_won_deal_amount {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Measures"

    value_format_name: gbp

    type: sum
    sql: case when ${TABLE}.pipeline_stage_closed_won   then  ${TABLE}.deal_amount end;;
  }



  measure: total_closed_lost_deal_amount {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Measures"

    value_format_name: gbp

    type: sum
    sql: case when ${TABLE}.pipeline_stage_display_order = 10  then  ${TABLE}.deal_amount end;;
  }

  measure: total_closed_lost_deals {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Measures"


    type: count_distinct
    sql: case when ${TABLE}.pipeline_stage_display_order = 10  then  ${TABLE}.deal_pk end;;
  }



  dimension: deal_amount_local_currency {
    hidden: yes

    type: number
    sql: ${TABLE}.deal_amount_local_currency ;;
  }


  dimension_group: deal_closed {
    type: time
    timeframes: [date,week,week_of_year,month, month_num, quarter,quarter_of_year,year]
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Sales Activity"



    sql: case when ${TABLE}.deal_closed_amount_value is not null and ${TABLE}.pipeline_stage_display_order >=8 and ${TABLE}.pipeline_display_order <=9 then ${TABLE}.deal_closed_ts end ;;
  }

  dimension: deal_closed_lost_reason {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Sales Activity"

    type: string
    sql: ${TABLE}.deal_closed_lost_reason ;;
  }

  dimension_group: deal_created {
    type: time
    timeframes: [
      date,
      week,
      month,
      month_num,
      quarter_of_year,
      quarter,
      year
    ]
    sql: ${TABLE}.deal_created_ts ;;
  }

  dimension: deal_description {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Details"

    type: string
    sql: ${TABLE}.deal_description ;;
  }

  dimension: deal_id {
    hidden: yes

    type: number
    sql: ${TABLE}.deal_id ;;
  }

  dimension: deal_is_deleted {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Details"
    type: yesno
    sql: ${TABLE}.deal_is_deleted ;;
  }

  dimension_group: deal_last_modified {
    type: time
    hidden: yes
    timeframes: [
      time
    ]
    sql: ${TABLE}.deal_last_modified_ts ;;
  }

  dimension: deal_name {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Details"

    type: string
    sql: ${TABLE}.deal_name ;;
  }

  dimension: deal_owner_id {
    hidden: yes

    type: string
    sql: ${TABLE}.deal_owner_id ;;
  }

  dimension: deal_pipeline_id {
    hidden: yes

    type: string
    sql: ${TABLE}.deal_pipeline_id ;;
  }

  dimension: deal_pipeline_stage_id {
    hidden: yes

    type: string
    sql: ${TABLE}.deal_pipeline_stage_id ;;
  }

  dimension: deal_pipeline_stage {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Activity"

    type: date_time

    sql: ${TABLE}.deal_pipeline_stage_ts ;;
  }

  dimension: deal_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.deal_pk ;;
  }

  measure: count_deals {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Measures"
    type: count_distinct
    sql: ${TABLE}.deal_pk ;;
  }

  measure: count_oppportunity_deals {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Measures"
    type: count_distinct
    sql: case when ${TABLE}.pipeline_stage_display_order <8 then ${TABLE}.deal_pk end;;
  }

  measure: count_closed_in_delivery_deals {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Measures"
    type: count_distinct
    sql: case when ${TABLE}.pipeline_stage_display_order =8 then ${TABLE}.deal_pk end;;
  }



  measure: count_closed_won_deals {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Measures"
    type: count_distinct
    sql: case when ${TABLE}.pipeline_stage_closed_won  then ${TABLE}.deal_pk end;;
  }

  dimension: deal_type {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Details"
    type: string
    sql: case when ${TABLE}.deal_type is null then 'Existing Business' else ${TABLE}.deal_type end ;;
  }

  dimension: owner_email {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Sales Activity"

    type: string
    sql: ${TABLE}.owner_email ;;
  }

  dimension: owner_full_name {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Sales Activity"

    type: string
    sql: ${TABLE}.owner_full_name ;;
  }

  dimension: pipeline_display_order {
    hidden: yes
    type: number
    sql: ${TABLE}.pipeline_display_order ;;
  }

  dimension: pipeline_label {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Details"
    order_by_field: pipeline_display_order
    type: string
    sql: ${TABLE}.pipeline_label ;;
  }

  dimension: pipeline_stage_close_probability_pct {
    hidden: yes

    type: number
    sql: ${TABLE}.pipeline_stage_close_probability_pct ;;
  }

  dimension: weighted_deal_amount {
    type: number
    hidden: yes

    sql: ${TABLE}.deal_amount * ${TABLE}.pipeline_stage_close_probability_pct  ;;
  }

  measure: total_weighted_deal_amount {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Measures"
    type: sum
    value_format_name: gbp
    sql: ${weighted_deal_amount} ;;
  }

  measure: total_weighted_opportunity_deal_amount {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Measures"
    type: sum
    value_format_name: gbp
    sql: case when ${TABLE}.pipeline_stage_display_order <8 then ${TABLE}.deal_amount * ${TABLE}.pipeline_stage_close_probability_pct  end ;;
  }

  measure: total_closed_in_delivery_deal_amount {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Measures"
    type: sum
    value_format_name: gbp
    sql: case when ${TABLE}.pipeline_stage_display_order =8 then ${TABLE}.deal_amount  end ;;
  }




  dimension: pipeline_stage_closed_won {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Details"

    type: yesno
    sql: ${TABLE}.pipeline_stage_closed_won ;;
  }

  dimension: pipeline_stage_display_order {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Details"

    hidden: no
    type: number
    sql: ${TABLE}.pipeline_stage_display_order ;;
  }

  dimension: pipeline_stage_label {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Details"
    type: string
    order_by_field: pipeline_stage_display_order

    sql: ${TABLE}.pipeline_stage_label ;;
  }

  dimension: harvest_project_id {
    hidden: yes
    type: string
    sql: ${TABLE}.deal_harvest_project_id ;;
  }

  dimension: number_of_sprints {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Details"

    type: number
    sql: ${TABLE}.deal_number_of_sprints ;;
  }

  dimension: deal_components {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Details"

    type: string
    sql: ${TABLE}.deal_components ;;
  }

  dimension: services {
    group_label: "  {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Component Filters"


    type: yesno
    sql: ${TABLE}.is_services_deal ;;
  }

  dimension: managed_services {
    group_label: "  {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Component Filters"

    type: yesno
    sql: ${TABLE}.is_managed_services_deal ;;
  }

  dimension: license_referral {
    group_label: "  {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Component Filters"

    type: yesno
    sql: ${TABLE}.is_license_referral_deal ;;
  }

  dimension: training {
    group_label: "  {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Component Filters"
    type: yesno
    sql: ${TABLE}.is_training_deal ;;
  }

  measure: count_training_deals {
    group_label: "  {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Element Counts"

    type: sum
    sql: case when ${training} then 1 end ;;
  }

  measure: count_license_referral_deals {
    group_label: "  {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Element Counts"

    type: sum
    sql: case when ${license_referral} then 1 end ;;
  }

  measure: count_services_deals {
    group_label: "  {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Element Counts"

    type: sum
    sql: case when ${services} then 1 end ;;
  }

  measure: count_managed_services_deals {
    group_label: "  {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Element Counts"
    type: sum
    sql: case when ${managed_services} then 1 end ;;
  }

  dimension: looker {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Technology Filters"

    type: yesno
    sql: ${TABLE}.is_looker_skill_requirement ;;
  }

  measure: count_looker_technology {
    group_label: "Deal Technology Counts"

    type: sum
    sql: case when ${looker} then 1 end ;;
  }

  dimension: segment {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Technology Filters"

    type: yesno
    sql: ${TABLE}.is_segment_skill_requirement ;;
  }

  measure: count_segment_technology {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Technology Counts"

    type: sum
    sql: case when ${segment} then 1 end ;;
  }

  measure: count_dbt_technology {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Technology Counts"

    type: sum
    sql: case when ${dbt} then 1 end ;;
  }

  dimension: dbt {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Technology Filters"

    type: yesno
    sql: ${TABLE}.is_dbt_skill_requirement ;;
  }

  dimension: stitch {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Technology Filters"

    type: yesno
    sql: ${TABLE}.is_stitch_skill_requirement ;;
  }

  measure: count_gcp_technology {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Technology Counts"

    type: sum
    sql: case when ${gcp} then 1 end ;;
  }

  dimension: gcp {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Technology Filters"

    type: yesno
    sql: ${TABLE}.is_gcp_skill_requirement ;;
  }

  dimension: snowflake {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Technology Filters"

    type: yesno
    sql: ${TABLE}.is_snowflake_skill_requirement ;;
  }

  measure: count_snowflake_technology {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Technology Counts"

    type: sum
    sql: case when ${snowflake} then 1 end ;;
  }

  dimension: qubit {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Technology Filters"

    type: yesno
    sql: ${TABLE}.is_qubit_skill_requirement ;;
  }

  measure: count_qubit_technology {
    group_label: "Deal Technology Counts"

    type: sum
    sql: case when ${qubit} then 1 end ;;
  }

  dimension: fivetran {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Technology Filters"
    type: yesno
    sql: ${TABLE}.is_fivetran_skill_requirement ;;
  }

  measure: count_fivetran_technology {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Technology Counts"

    type: sum
    sql: case when ${fivetran} then 1 end ;;
  }

  dimension: pricing_model {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Details"
    type: string
    sql: ${TABLE}.deal_pricing_model ;;
  }

  dimension: partner_referral {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Details"

    type: string
    sql: ${TABLE}.deal_partner_referral ;;
  }

  dimension: sprint_type {
    group_label: "   {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Project Details"

    type: string
    sql: ${TABLE}.deal_sprint_type ;;
  }

  dimension: license_referral_harvest_project_code {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Details"

    type: string
    sql: ${TABLE}.deal_license_referral_harvest_project_code ;;
  }

  dimension: jira_project_code {
    group_label: "   {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Project Details"

    type: string
    sql: ${TABLE}.deal_jira_project_code ;;
  }

  dimension: assigned_consultant {
    group_label: "   {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Project Details"

    type: string
    sql: ${TABLE}.deal_assigned_consultant ;;
  }

  dimension: products_in_solution {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Details"

    type: string
    sql: ${TABLE}.deal_products_in_solution ;;
  }



  dimension: deal_total_contract_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.deal_total_contract_amount ;;
  }

  measure: total_contract_amount {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Measures"

    value_format_name: gbp
    type: sum
    sql: ${deal_total_contract_amount} ;;

  }

  dimension: deal_annual_contract_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.deal_annual_contract_amount ;;
  }

  measure: total_annual_contract_amount {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Measures"

    value_format_name: gbp
    type: sum
    sql: ${deal_annual_contract_amount} ;;

  }


  dimension: deal_annual_recurring_revenue_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.deal_annual_recurring_revenue_amount ;;
  }

  measure: total_ARR_amount {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Measures"

    value_format_name: gbp
    type: sum
    sql: ${deal_annual_recurring_revenue_amount} ;;

  }

  dimension: deal_currency_code {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Details"

    type: string
    sql: ${TABLE}.deal_currency_code ;;
  }

  dimension: deal_source {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Source"
    hidden: yes

    type: string
    sql: ${TABLE}.deal_source ;;
  }

  dimension: hs_analytics_source {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Source"
    hidden: yes

    type: string
    sql: ${TABLE}.hs_analytics_source ;;
  }

  dimension: hs_analytics_source_data_1 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Source"
    hidden: yes

    type: string
    sql: ${TABLE}.hs_analytics_source_data_1 ;;
  }

  dimension: hs_analytics_source_data_2 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Source"
    hidden: yes

    type: string
    sql: ${TABLE}.hs_analytics_source_data_2 ;;
  }

  dimension: deal_end_ts {
     type: date_time
    group_label: "   {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Project Details"

    sql: ${TABLE}.deal_end_ts ;;
  }

  dimension: deal_sales_email_last_replied {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Sales Activity"

    type: date_time
    sql: ${TABLE}.deal_sales_email_last_replied ;;
  }

  dimension: deal_last_meeting_booked_date {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Sales Activity"

     type: date_time

    sql: ${TABLE}.deal_last_meeting_booked_date ;;
  }

  dimension: delivery_schedule_ts {
    group_label: "   {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Project Details"

     type: date_time
    sql: ${TABLE}.delivery_schedule_ts ;;
  }

  dimension: delivery_start_date_ts {
    group_label: "   {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Project Details"

     type: date_time

    sql: ${TABLE}.delivery_start_date_ts ;;
  }

  dimension_group: date_entered_deal_stage_0 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"
    type: time
    timeframes: [date]
    sql: ${TABLE}.date_entered_deal_stage_0 ;;
  }

  dimension_group: date_exited_deal_stage_0 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: time
    timeframes: [date]
    sql: ${TABLE}.date_exited_deal_stage_0 ;;
  }

  dimension: days_in_deal_stage_0 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: number
    sql: ${TABLE}.days_in_deal_stage_0 ;;
  }

  measure: count_deals_stage_0 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"
    type: count_distinct
    sql: case when ${days_in_deal_stage_0} is not null then ${deal_id} end;;
  }

  measure: count_deals_stage_1 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"
    type: count_distinct
    sql: case when ${days_in_deal_stage_1} is not null then ${deal_id} end;;
  }

  measure: count_deals_stage_2 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"
    type: count_distinct
    sql: case when ${days_in_deal_stage_2} is not null then ${deal_id} end;;
  }

  measure: count_deals_stage_3 {
    group_label: "  Deal Stage Durations"
    type: count_distinct
    sql: case when ${days_in_deal_stage_3} is not null then ${deal_id} end;;
  }

  measure: count_deals_stage_4 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"
    type: count_distinct
    sql: case when ${days_in_deal_stage_4} is not null then ${deal_id} end;;
  }

  measure: count_deals_stage_5 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"
    type: count_distinct
    sql: case when ${days_in_deal_stage_5} is not null then ${deal_id} end;;
  }

  measure: count_deals_stage_6 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"
    type: count_distinct
    sql: case when ${days_in_deal_stage_6} is not null then ${deal_id} end;;
  }

  measure: count_deals_stage_7 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"
    type: count_distinct
    sql: case when ${days_in_deal_stage_7} is not null then ${deal_id} end;;
  }

  measure: count_deals_stage_8 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"
    type: count_distinct
    sql: case when ${days_in_deal_stage_8} is not null then ${deal_id} end;;
  }

  measure: count_deals_stage_9 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"
    type: count_distinct
    sql: case when ${days_in_deal_stage_9} is not null then ${deal_id} end;;
  }

  measure: count_deals_stage_10 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"
    type: count_distinct
    sql: case when ${days_in_deal_stage_10} is not null then ${deal_id} end;;
  }

  dimension_group: date_entered_deal_stage_1 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: time
    timeframes: [date]
    sql: ${TABLE}.date_entered_deal_stage_1 ;;
  }

  dimension_group: date_exited_deal_stage_1 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: time
    timeframes: [date]
    sql: ${TABLE}.date_exited_deal_stage_1 ;;
  }

  dimension: days_in_deal_stage_1 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: number
    sql: ${TABLE}.days_in_deal_stage_1 ;;
  }

  dimension_group: date_entered_deal_stage_2 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: time
    timeframes: [date]
    sql: ${TABLE}.date_entered_deal_stage_2 ;;
  }

  dimension_group: date_exited_deal_stage_2 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: time
    timeframes: [date]
    sql: ${TABLE}.date_exited_deal_stage_2 ;;
  }

  dimension: days_in_deal_stage_2 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: number
    sql: ${TABLE}.days_in_deal_stage_2 ;;
  }

  dimension_group: date_entered_deal_stage_3 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: time
    timeframes: [date]
    sql: ${TABLE}.date_entered_deal_stage_3 ;;
  }

  dimension_group: date_exited_deal_stage_3 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: time
    timeframes: [date]
    sql: ${TABLE}.date_exited_deal_stage_3 ;;
  }

  dimension: days_in_deal_stage_3 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: number
    sql: ${TABLE}.days_in_deal_stage_3 ;;
  }

  dimension_group: date_entered_deal_stage_4 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: time
    timeframes: [date]
    sql: ${TABLE}.date_entered_deal_stage_4 ;;
  }

  dimension_group: date_exited_deal_stage_4 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: time
    timeframes: [date]
    sql: ${TABLE}.date_exited_deal_stage_4 ;;
  }

  dimension: days_in_deal_stage_4 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: number
    sql: ${TABLE}.days_in_deal_stage_4 ;;
  }

  dimension_group: date_entered_deal_stage_5 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: time
    timeframes: [date]
    sql: ${TABLE}.date_entered_deal_stage_5 ;;
  }

  dimension_group: date_exited_deal_stage_5 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: time
    timeframes: [date]
    sql: ${TABLE}.date_exited_deal_stage_5 ;;
  }

  dimension: days_in_deal_stage_5 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: number
    sql: ${TABLE}.days_in_deal_stage_5 ;;
  }

  dimension_group: date_entered_deal_stage_6 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: time
    timeframes: [date]
    sql: ${TABLE}.date_entered_deal_stage_6 ;;
  }

  dimension_group: date_exited_deal_stage_6 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: time
    timeframes: [date]
    sql: ${TABLE}.date_exited_deal_stage_6 ;;
  }

  dimension: days_in_deal_stage_6 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: number
    sql: ${TABLE}.days_in_deal_stage_6 ;;
  }

  dimension_group: date_entered_deal_stage_7 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: time
    timeframes: [date]
    sql: ${TABLE}.date_entered_deal_stage_7 ;;
  }

  dimension_group: date_exited_deal_stage_7 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: time
    timeframes: [date]
    sql: ${TABLE}.date_exited_deal_stage_7 ;;
  }

  dimension: days_in_deal_stage_7 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: number
    sql: ${TABLE}.days_in_deal_stage_7 ;;
  }

  dimension_group: date_entered_deal_stage_8 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: time

    timeframes: [date]
    sql: ${TABLE}.date_entered_deal_stage_8 ;;
  }

  dimension: days_in_deal_stage_8 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: number

    sql: ${TABLE}.days_in_deal_stage_8 ;;
  }

  dimension_group: date_entered_deal_stage_9 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: time
    timeframes: [date]
    sql: ${TABLE}.date_entered_deal_stage_9 ;;
  }

  dimension: days_in_deal_stage_9 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: number
    sql: ${TABLE}.days_in_deal_stage_9 ;;
  }

  dimension_group: date_entered_deal_stage_10 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: time
    timeframes: [date]
    sql: ${TABLE}.date_entered_deal_stage_10 ;;
  }

  dimension: days_in_deal_stage_10 {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: number
    sql: ${TABLE}.days_in_deal_stage_10 ;;
  }

  dimension: manual_forecast_category {
    group_label: "   {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}} Forecast"

    type: string
    sql: ${TABLE}.manual_forecast_category ;;
  }

  dimension: forecast_probability {
    group_label: "   {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}} Forecast"

    type: number
    sql: ${TABLE}.forecast_probability ;;
  }



  dimension: predicted_amount {
    group_label: "   {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}} Forecast"

    type: string
    sql: ${TABLE}.predicted_amount ;;
  }

  dimension: days_in_pipeline {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Stage Durations"

    type: number
    sql: ${TABLE}.days_in_pipeline ;;
  }


}