view: sow_requests {

   derived_table: {
      sql: select * from analytics.sows_fact ;;
    }

    measure: count {
      type: count_distinct

    }

    dimension: sow_pk {
      hidden: yes
      primary_key: yes
      type: number
      sql: ${TABLE}.sow_pk ;;
    }

    dimension: statement_of_work_number {
      label: "             SoW Number"
      group_label: "       SoW Request"
      type: number
      sql: ${TABLE}.Statement_of_Work_Number ;;
    }

    dimension_group: sow_request_ts {
      group_label: "       SoW Request"
      timeframes: [date,week,month,month_num,quarter,year]
      type: time
      sql: ${TABLE}.sow_request_ts ;;
    }

    dimension: client_name {
      group_label: "       SoW Request"
      label: "            Client Name"

      type: string
      sql: ${TABLE}.Client_Name ;;
    }

    dimension: project_name {
      group_label: "       SoW Request"
      label: "          Project Name"

      type: string
      sql: ${TABLE}.Project_Name ;;
    }

    dimension: contact_name {
      group_label: "       SoW Request"

      type: string
      sql: ${TABLE}.Contact_Name ;;
    }

    dimension: contact_title {
      group_label: "       SoW Request"

      type: string
      sql: ${TABLE}.Contact_Title ;;
    }

    dimension: contact_email {
      group_label: "       SoW Request"

      type: string
      sql: ${TABLE}.Contact_Email ;;
    }

    dimension: contact_phone {
      group_label: "       SoW Request"

      type: string
      sql: ${TABLE}.Contact_Phone ;;
    }

    dimension: client_address {
      group_label: "       SoW Request"

      type: string
      sql: ${TABLE}.Client_Address ;;
    }

    dimension: client_state_country {
      group_label: "       SoW Request"

      type: string
      sql: ${TABLE}.Client_State_Country ;;
    }

    dimension: background_to_project {
      group_label: "       SoW Request"
      label: "        Background"

      type: string
      sql: ${TABLE}.Background_to_project ;;
    }

    dimension: services_to_be_delivered {
      group_label: "       SoW Request"
      label: "      Services Schedule"

      type: string
      sql: ${TABLE}.Services_to_be_Delivered ;;
    }

    dimension: fee_schedule {
      group_label: "       SoW Request"

      type: string
      sql: ${TABLE}.Fee_Schedule ;;
    }

    dimension: total_contract_value {
      group_label: "       SoW Request"

      type: string
      sql: ${TABLE}.Total_Contract_Value ;;
    }

    dimension: invoicing_schedule {
      group_label: "       SoW Request"

      type: string
      sql: ${TABLE}.Invoicing_Schedule ;;
    }

    dimension: cancellation_policy {
      group_label: "       SoW Request"

      type: string
      sql: ${TABLE}.Cancellation_Policy ;;
    }

    dimension: original_lead_enquiry_vertical {
      group_label: "      Original Website Lead"
      label: "     Lead Vertical"
      type: string
      sql: ${TABLE}.original_lead_enquiry_vertical ;;
    }

    dimension: original_lead_enquiry_company_size {
      group_label: "      Original Website Lead"
      label: "    Lead Company Size"

      type: string
      sql: ${TABLE}.original_lead_enquiry_company_size ;;
    }

    dimension: original_lead_enquiry_lead_category {
      group_label: "      Original Website Lead"
      label: "      Lead Category"

      type: string
      sql: ${TABLE}.original_lead_enquiry_lead_category ;;
    }

    dimension_group: original_lead_enquiry_date_time {
      group_label: "      Original Website Lead"
      label: "     Lead"

      type: time
      timeframes: [date]
      sql: TIMESTAMP_PARSE(${TABLE}.original_lead_enquiry_date_time, '%Y-%m-%d %I:%M %p') ;;
    }

    dimension: original_lead_enquiry_details {
      group_label: "      Original Website Lead"
      label: "    Lead Details"

      type: string
      sql: ${TABLE}.original_lead_enquiry_details ;;
    }

    dimension: deal_id {
      group_label: "    Hubspot Deal"

      type: number
      sql: ${TABLE}.deal_id ;;
    }

    dimension: deal_pk {
      group_label: "    Hubspot Deal"
      hidden: yes
      type: string
      sql: ${TABLE}.deal_pk ;;
    }

    dimension: company_fk {
      hidden: yes
      type: string
      sql: ${TABLE}.company_fk ;;
    }

    dimension: deal_name {
      group_label: "    Hubspot Deal"
      label: "          Deal Name"
      type: string
      sql: ${TABLE}.deal_name ;;
    }

    dimension: deal_type {
      group_label: "    Hubspot Deal"
      label: "         Deal Type"

      type: string
      sql: ${TABLE}.deal_type ;;
    }

    dimension_group: deal_created_ts {
      group_label: "    Hubspot Deal"
      label: "        Deal"
      timeframes: [date]
      type: time
      sql: ${TABLE}.deal_created_ts ;;
    }

    dimension: deal_description {
      group_label: "    Hubspot Deal"
      label: "        Deal Details"

      type: string
      sql: ${TABLE}.deal_description ;;
    }


    dimension: deal_currency_code {
      group_label: "    Hubspot Deal"
      label: "      Deal Currency"

      type: string
      sql: ${TABLE}.deal_currency_code ;;
    }

    dimension: deal_source {
      group_label: "    Hubspot Deal"
      label: "    Deal Source"

      type: string
      sql: ${TABLE}.deal_source ;;
    }

    dimension: deal_amount {
      group_label: "    Hubspot Deal"
      hidden: yes
      type: number
      sql: ${TABLE}.deal_amount ;;
    }

    measure: total_deal_amount {
      group_label: "    Hubspot Deal"
      type: sum
      value_format_name: gbp_0
      sql: ${deal_amount} ;;
    }

    dimension: deal_closed_amount_value {
      group_label: "    Hubspot Deal"
      hidden: yes
      type: number
      sql: ${TABLE}.deal_closed_amount_value ;;
    }

  measure: total_deal_closed_amount {
    group_label: "    Hubspot Deal"
    type: sum
    value_format_name: gbp_0
    sql: ${deal_closed_amount_value} ;;
  }

    dimension: hs_closed_amount_in_home_currency {
      group_label: "    Hubspot Deal"
      hidden: yes

      type: number
      sql: ${TABLE}.hs_closed_amount_in_home_currency ;;
    }

    dimension: deal_days_to_close {
      group_label: "    Hubspot Deal"
      hidden: yes

      type: number
      sql: ${TABLE}.deal_days_to_close ;;
    }

  measure: avg_deal_closed_amount {
    group_label: "    Hubspot Deal"
    type: average
    value_format_name: decimal_0
    sql: ${deal_days_to_close} ;;
  }

    dimension: deal_closed_lost_reason {
      group_label: "    Hubspot Deal"

      type: string
      sql: ${TABLE}.deal_closed_lost_reason ;;
    }

    dimension: deal_pricing_model {
      group_label: "    Hubspot Deal"

      type: string
      sql: ${TABLE}.deal_pricing_model ;;
    }

    dimension: deal_partner_referral {
      group_label: "    Hubspot Deal"

      type: string
      sql: ${TABLE}.deal_partner_referral ;;
    }

    dimension: deal_sprint_type {
      group_label: "    Hubspot Deal"

      type: string
      sql: ${TABLE}.deal_sprint_type ;;
    }

    dimension: pipeline_label {
      group_label: "    Hubspot Deal"

      type: string
      sql: ${TABLE}.pipeline_label ;;
    }

    dimension: pipeline_stage_closed_won {
      group_label: "    Hubspot Deal"
      label: "   Is Won Deal?"

      type: yesno
      sql: ${TABLE}.pipeline_stage_closed_won ;;
    }

    dimension_group: sow_start {
      group_label: "  Harvest Projects"
      timeframes: [date]

      type: time
      sql: timestamp(${TABLE}.sow_start_ts) ;;
    }

    dimension_group: sow_end {
      group_label: "  Harvest Projects"
      timeframes: [date]
      type: time
      sql: timestamp(${TABLE}.sow_end_ts) ;;
    }

    dimension: hourly_rate {
      group_label: "  Harvest Projects"
      hidden: yes

      type: number
      sql: ${TABLE}.hourly_rate ;;
    }

    dimension: project_is_fixed_fee {
      group_label: "  Harvest Projects"

      type: yesno
      sql: ${TABLE}.project_is_fixed_fee ;;
    }

    dimension: project_fee_amount {
      group_label: "  Harvest Projects"
      hidden: yes

      type: number
      sql: ${TABLE}.project_fee_amount ;;
    }

    measure: total_project_fee_amount {
      group_label: "  Harvest Projects"
      type: sum
      sql: ${project_fee_amount} ;;

    }

    dimension: project_duration_days {
      group_label: "  Harvest Projects"
      hidden: yes

      type: number
      sql: ${TABLE}.project_duration_days ;;
    }

  measure: total_project_duration_days {
    group_label: "  Harvest Projects"
    type: sum
    sql: ${project_duration_days} ;;
  }

  measure: avg_project_duration_days {
    group_label: "  Harvest Projects"
    type: average
    sql: ${project_duration_days} ;;}

    dimension: hours_billed {
      group_label: "Harvest Timesheets"
      hidden: yes

      type: number
      sql: ${TABLE}.total_hours_billed ;;
    }

  measure: total_hours_billed {
    group_label: "  Harvest Projects"
    type: sum
    sql: ${hours_billed} ;;}

    dimension: hourly_billing_revenue {
      group_label: "Harvest Timesheets"
      hidden: yes

      type: number
      sql: ${TABLE}.total_hourly_billing_revenue ;;
    }

  measure: total_hourly_billing_revenue {
    group_label: "  Harvest Projects"
    type: sum
    sql: ${hourly_billing_revenue} ;;}

    dimension: billing_cost {
      group_label: "Harvest Timesheets"
      hidden: yes

      type: number
      sql: ${TABLE}.total_billing_cost ;;
    }

  measure: total_billing_cost {
    group_label: "  Harvest Projects"
    type: sum
    sql: ${billing_cost} ;;}

    dimension_group: first_project_billing_date {
      group_label: "Harvest Timesheets"
      hidden: yes

      type: time
      sql: ${TABLE}.first_project_billing_date ;;
    }

    dimension_group: last_project_billing_date {
      group_label: "Harvest Timesheets"
      hidden: yes

      type: time
      sql: ${TABLE}.last_project_billing_date ;;
    }

    dimension: billable_hourly_rate_amount {
      group_label: "Harvest Timesheets"
      hidden: yes

      type: number
      sql: ${TABLE}.avg_billable_hourly_rate_amount ;;
    }

  measure: avg_billable_hourly_rate_amount {
    group_label: "  Harvest Projects"
    type: sum
    sql: ${billable_hourly_rate_amount} ;;}

    dimension: timesheet_billable_hourly_cost_amount {
      group_label: "Harvest Timesheets"
      hidden: yes

      type: number
      sql: ${TABLE}.avg_timesheet_billable_hourly_cost_amount ;;
    }

  measure: avg_billable_hourly_cost_amount {
    group_label: "  Harvest Projects"
    type: sum
    sql: ${timesheet_billable_hourly_cost_amount} ;;}





  }
