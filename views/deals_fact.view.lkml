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
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Measures"
    value_format_name: gbp
    type: sum
    sql: ${TABLE}.deal_amount ;;
    description: "Total sum of all deal amounts"
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
  description: "Total sum of deal amounts converted to GBP based on the deal currency code"
}

  measure: total_oppportunity_deal_amount {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Measures"
    value_format_name: gbp
    type: sum
    sql: case when ${TABLE}.pipeline_stage_display_order <8 then ${TABLE}.deal_amount end;;
    description: "Total sum of opportunity deal amounts where pipeline stage order is less than 8"
  }

  measure: total_closed_won_deal_amount {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Measures"
    value_format_name: gbp
    type: sum
    sql: case when ${TABLE}.pipeline_stage_closed_won   then  ${TABLE}.deal_amount end;;
    description: "Total sum of deal amounts where the deal stage is closed-won"
  }

  measure: total_closed_lost_deal_amount {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Measures"
    value_format_name: gbp
    type: sum
    sql: case when ${TABLE}.pipeline_stage_display_order = 10  then  ${TABLE}.deal_amount end;;
    description: "Total sum of deal amounts where the deal stage is closed-lost"
  }

  measure: total_closed_lost_deals {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Measures"
    type: count_distinct
    sql: case when ${TABLE}.pipeline_stage_display_order = 10  then  ${TABLE}.deal_pk end;;
    description: "Count of deals where the deal stage is closed-lost"
  }

  dimension_group: deal_closed {
    type: time
    timeframes: [date,week,week_of_year,month, month_num, quarter,quarter_of_year,year]
    sql: ${TABLE}.deal_closed_ts;;
    description: "Time group for when deals were closed"
  }



  dimension: deal_closed_lost_reason {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Sales Activity"
    type: string
    sql: ${TABLE}.deal_closed_lost_reason ;;
    description: "Reason for why a deal was closed and lost"
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
    description: "Time group for when deals were created"
  }

  dimension: deal_description {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"
    label: "Deal Description"
    type: string
    sql: ${TABLE}.deal_description ;;
    description: "Description of the deal"
  }




dimension: deal_id {
  description: "The unique identifier for the deal in Hubspot."
  hidden: yes
  type: number
  sql: ${TABLE}.deal_id ;;
}

dimension: deal_is_deleted {
  description: "Indicates whether the deal was deleted."
  group_label: "Details"
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
  group_label: "Details"
  label: "Deal Name"
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
  group_label: "Pipeline"
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
  group_label: "Measures"
  type: count_distinct
  sql: ${TABLE}.deal_pk ;;
}

measure: count_oppportunity_deals {
  description: "The total number of opportunity deals (deals in a stage with a display order less than 8)."
  group_label: "Measures"
  type: count_distinct
  sql: case when ${TABLE}.pipeline_stage_display_order <8 then ${TABLE}.deal_pk end;;
}

measure: count_closed_in_delivery_deals {
  description: "The total number of deals in the 'in delivery' stage (stage display order equals 8)."
  group_label: "Measures"
  type: count_distinct
  sql: case when ${TABLE}.pipeline_stage_display_order =8 then ${TABLE}.deal_pk end;;
}

measure: count_closed_won_deals {
  description: "The total number of deals in the 'closed won' stage."
  group_label: "Measures"
  type: count_distinct
  sql: case when ${TABLE}.pipeline_stage_closed_won then ${TABLE}.deal_pk end;;
}

dimension: deal_type {
  description: "The type of the deal, 'Existing Business' if not specified."
  group_label: "Details"
  label: "Deal Type"
  sql: case when ${TABLE}.deal_type is null then 'Existing Business' else ${TABLE}.deal_type end ;;
}

  dimension: deal_value {
    description: "The monetary value of the deal."
    group_label: "Details"
    type: number
    sql: ${TABLE}.deal_value ;;
  }

  dimension: opportunity_deal_value {
    description: "The monetary value of opportunity deals (deals in a stage with a display order less than 8)."
    group_label: "Details"
    type: number
    sql: case when ${TABLE}.pipeline_stage_display_order <8 then ${TABLE}.deal_value end ;;
  }

  dimension: in_delivery_deal_value {
    description: "The monetary value of deals in the 'in delivery' stage (stage display order equals 8)."
    group_label: "Details"
    type: number
    sql: case when ${TABLE}.pipeline_stage_display_order =8 then ${TABLE}.deal_value end ;;
  }

  dimension: closed_won_deal_value {
    description: "The monetary value of deals in the 'closed won' stage."
    group_label: "Details"
    type: number
    sql: case when ${TABLE}.pipeline_stage_closed_won then ${TABLE}.deal_value end ;;
  }

  measure: total_deal_value {
    description: "The total monetary value of all deals."
    group_label: "Measures"
    type: sum
    sql: ${TABLE}.deal_value ;;
  }

  measure: total_opportunity_deal_value {
    description: "The total monetary value of all opportunity deals (deals in a stage with a display order less than 8)."
    group_label: "Measures"
    type: sum
    sql: case when ${TABLE}.pipeline_stage_display_order <8 then ${TABLE}.deal_value end ;;
  }

  measure: total_in_delivery_deal_value {
    description: "The total monetary value of all deals in the 'in delivery' stage (stage display order equals 8)."
    group_label: "Measures"
    type: sum
    sql: case when ${TABLE}.pipeline_stage_display_order =8 then ${TABLE}.deal_value end ;;
  }

  measure: total_closed_won_deal_value {
    description: "The total monetary value of all deals in the 'closed won' stage."
    group_label: "Measures"
    type: sum
    sql: case when ${TABLE}.pipeline_stage_closed_won then ${TABLE}.deal_value end ;;
  }

  dimension: deal_stage_display_order {
    description: "The order in which the deal stage is displayed in the pipeline."
    group_label: "Details"
    hidden: yes
    type: number
    sql: ${TABLE}.deal_stage_display_order ;;
  }

  dimension: deal_stage_probability {
    description: "The probability associated with the stage of the deal in the pipeline."
    group_label: "Details"
    type: number
    sql: ${TABLE}.deal_stage_probability ;;
  }

  dimension: deal_stage_closed_won {
    description: "Indicates if the deal stage is considered 'closed won'."
    group_label: "Details"
    type: yesno
    sql: ${TABLE}.deal_stage_closed_won ;;
  }

  dimension: deal_stage_closed_lost {
    description: "Indicates if the deal stage is considered 'closed lost'."
    group_label: "Details"
    type: yesno
    sql: ${TABLE}.deal_stage_closed_lost ;;
  }



  dimension: owner_email {
    group_label: "      {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"

    type: string
    sql: ${TABLE}.owner_email ;;
  }

  dimension: owner_full_name {
    group_label: "      {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"

    type: string
    sql: ${TABLE}.owner_full_name ;;
  }

  dimension: pipeline_display_order {
    hidden: yes
    type: number
    sql: ${TABLE}.pipeline_display_order ;;
  }

  dimension: pipeline_label {
    group_label: "      {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Pipeline"
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
    group_label: "      {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Pipeline"
    label: "Is Closed Won"
    type: yesno
    sql: ${TABLE}.pipeline_stage_closed_won ;;
  }

  dimension: pipeline_stage_display_order {
    group_label: "      {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"

    hidden: yes
    type: number
    sql: ${TABLE}.pipeline_stage_display_order ;;
  }

  dimension: pipeline_stage_label {
    group_label: "      {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Pipeline"
    type: string
    label: "  Deal Pipeline Stage"

    order_by_field: pipeline_stage_display_order

    sql: ${TABLE}.pipeline_stage_label ;;
  }



  dimension: number_of_sprints {
    group_label: "      {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"

    type: number
    sql: ${TABLE}.deal_number_of_sprints ;;
  }

  dimension: deal_components {
    group_label: "      {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"
    hidden: yes
    type: string
    sql: ${TABLE}.deal_components ;;
  }

  dimension: services {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Components"


    type: yesno
    sql: ${TABLE}.is_services_deal ;;
  }

  dimension: managed_services {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Components"

    type: yesno
    sql: ${TABLE}.is_managed_services_deal ;;
  }

  dimension: license_referral {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Components"

    type: yesno
    sql: ${TABLE}.is_license_referral_deal ;;
  }

  dimension: training {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Components"
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
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Technologies"

    type: yesno
    sql: ${TABLE}.is_looker_skill_requirement ;;
  }

  measure: count_looker_technology {
    group_label: "Deal Technology Counts"

    type: sum
    sql: case when ${looker} then 1 end ;;
  }

  dimension: segment {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Technologies"

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
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Technologies"

    type: yesno
    sql: ${TABLE}.is_dbt_skill_requirement ;;
  }

  dimension: stitch {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Technologies"

    type: yesno
    sql: ${TABLE}.is_stitch_skill_requirement ;;
  }

  measure: count_gcp_technology {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Technology Counts"

    type: sum
    sql: case when ${gcp} then 1 end ;;
  }

  dimension: gcp {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Technologies"

    type: yesno
    sql: ${TABLE}.is_gcp_skill_requirement ;;
  }

  dimension: snowflake {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Technologies"

    type: yesno
    sql: ${TABLE}.is_snowflake_skill_requirement ;;
  }

  measure: count_snowflake_technology {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Technology Counts"

    type: sum
    sql: case when ${snowflake} then 1 end ;;
  }

  dimension: qubit {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Technologies"

    type: yesno
    sql: ${TABLE}.is_qubit_skill_requirement ;;
  }

  measure: count_qubit_technology {
    group_label: "Deal Technology Counts"

    type: sum
    sql: case when ${qubit} then 1 end ;;
  }

  dimension: fivetran {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Technologies"
    type: yesno
    sql: ${TABLE}.is_fivetran_skill_requirement ;;
  }

  measure: count_fivetran_technology {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Technology Counts"

    type: sum
    sql: case when ${fivetran} then 1 end ;;
  }

  dimension: pricing_model {
    group_label: "      {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"
    type: string
    sql: ${TABLE}.deal_pricing_model ;;
  }

  dimension: partner_referral {
    group_label: "      {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"

    type: string
    sql: ${TABLE}.deal_partner_referral ;;
  }

  dimension: sprint_type {
    group_label: "      {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"

    type: string
    sql: ${TABLE}.deal_sprint_type ;;
  }





  dimension: products_in_solution {
    group_label: "      {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"
    hidden: yes

    type: string
    sql: ${TABLE}.deal_products_in_solution ;;
  }





  dimension: deal_currency_code {
    group_label: "      {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"
    description: "This is the purpose the field"
    type: string
    sql: ${TABLE}.deal_currency_code ;;
  }

  dimension: deal_source {
    group_label: " {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Source"
    hidden: no

    type: string
    sql: ${TABLE}.deal_source ;;
  }



  dimension: deal_end_ts {
     type: date_time
    hidden: yes
    group_label: "      {{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Details"

    sql: ${TABLE}.deal_end_ts ;;
  }

  dimension: deal_sales_email_last_replied {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Sales Activity"
    hidden: yes

    type: date_time
    sql: ${TABLE}.deal_sales_email_last_replied ;;
  }

  dimension: deal_last_meeting_booked_date {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'fact', '' | capitalize}}  Sales Activity"

     type: date_time

    sql: ${TABLE}.deal_last_meeting_booked_date ;;
  }





}
