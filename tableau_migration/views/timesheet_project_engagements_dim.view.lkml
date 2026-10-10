view: timesheet_project_engagements_dim {
  sql_table_name: `ra-development.analytics.timesheet_project_engagements_dim` ;;

  dimension: company_fk {
    type: string
    label: "Company Fk (Timesheet Project Engagements Dim)"
    sql: ${TABLE}.company_fk ;;
  }

  dimension: deal_amount {
    type: number
    label: "Deal Amount (Timesheet Project Engagements Dim)"
    hidden: yes
    sql: ${TABLE}.deal_amount ;;
  }

  dimension_group: deal_closed_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Deal Closed Ts (Timesheet Project Engagements Dim)"
    sql: ${TABLE}.deal_closed_ts ;;
  }

  dimension_group: deal_created_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Deal Created Ts (Timesheet Project Engagements Dim)"
    sql: ${TABLE}.deal_created_ts ;;
  }

  dimension: deal_days_to_close {
    type: number
    label: "Deal Days To Close (Timesheet Project Engagements Dim)"
    hidden: yes
    sql: ${TABLE}.deal_days_to_close ;;
  }

  dimension: deal_description {
    type: string
    label: "Deal Description (Timesheet Project Engagements Dim)"
    sql: ${TABLE}.deal_description ;;
  }

  dimension: deal_forecasted_duration_months {
    type: number
    label: "Deal Forecasted Duration Months"
    hidden: yes
    sql: ${TABLE}.deal_forecasted_duration_months ;;
  }

  dimension: deal_forecasted_monthly_hours {
    type: number
    label: "Deal Forecasted Monthly Hours"
    hidden: yes
    sql: ${TABLE}.deal_forecasted_monthly_hours ;;
  }

  dimension: deal_hourly_rate {
    type: number
    label: "Deal Hourly Rate"
    hidden: yes
    sql: ${TABLE}.deal_hourly_rate ;;
  }

  dimension: deal_id {
    type: number
    label: "Deal Id (Timesheet Project Engagements Dim)"
    hidden: yes
    sql: ${TABLE}.deal_id ;;
  }

  dimension: deal_name {
    type: string
    label: "Deal Name (Timesheet Project Engagements Dim)"
    sql: ${TABLE}.deal_name ;;
  }

  dimension: deal_partner_referral {
    type: string
    label: "Deal Partner Referral (Timesheet Project Engagements Dim)"
    sql: ${TABLE}.deal_partner_referral ;;
  }

  dimension: deal_source {
    type: string
    label: "Deal Source (Timesheet Project Engagements Dim)"
    sql: ${TABLE}.deal_source ;;
  }

  dimension: deal_type {
    type: string
    label: "Deal Type (Timesheet Project Engagements Dim)"
    sql: ${TABLE}.deal_type ;;
  }

  dimension_group: dt_entered_3_sow_drafted {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Dt Entered 3 Sow Drafted (Timesheet Project Engagements Dim)"
    sql: ${TABLE}.dt_entered_3_sow_drafted ;;
  }

  dimension_group: dt_entered_5_customer_agreed_sow {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Dt Entered 5 Customer Agreed Sow (Timesheet Project Engagements Dim)"
    sql: ${TABLE}.dt_entered_5_customer_agreed_sow ;;
  }

  dimension_group: dt_entered_7_sow_customer_docusigned {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Dt Entered 7 Sow Customer Docusigned (Timesheet Project Engagements Dim)"
    sql: ${TABLE}.dt_entered_7_sow_customer_docusigned ;;
  }

  dimension: engagement_code {
    type: string
    label: "Engagement Code"
    sql: ${TABLE}.engagement_code ;;
  }

  dimension: engagement_end_ts {
    type: string
    label: "Engagement End Ts"
    sql: ${TABLE}.engagement_end_ts ;;
  }

  dimension: engagement_start_ts {
    type: string
    label: "Engagement Start Ts"
    sql: ${TABLE}.engagement_start_ts ;;
  }

  dimension_group: last_billable_timesheet_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Last Billable Timesheet Date"
    sql: ${TABLE}.last_billable_timesheet_date ;;
  }

  dimension: project_engagement_pk {
    type: string
    label: "Project Engagement Pk"
    sql: ${TABLE}.project_engagement_pk ;;
  }

  dimension: projects_project_delivery_end_ts {
    type: string
    label: "Projects.Project Delivery End Ts"
    sql: ${TABLE}.`projects.project_delivery_end_ts` ;;
  }

  dimension: projects_project_delivery_start_ts {
    type: string
    label: "Projects.Project Delivery Start Ts"
    sql: ${TABLE}.`projects.project_delivery_start_ts` ;;
  }

  dimension: projects_project_name {
    type: string
    label: "Projects.Project Name"
    sql: ${TABLE}.`projects.project_name` ;;
  }

  dimension: projects_timesheet_project_pk {
    type: string
    label: "Projects.Timesheet Project Pk"
    sql: ${TABLE}.`projects.timesheet_project_pk` ;;
  }

  measure: total_deal_amount {
    type: sum
    label: "Deal Amount (Timesheet Project Engagements Dim)"
    sql: ${deal_amount} ;;
  }

  measure: total_deal_days_to_close {
    type: sum
    label: "Deal Days To Close (Timesheet Project Engagements Dim)"
    sql: ${deal_days_to_close} ;;
  }

  measure: total_deal_forecasted_duration_months {
    type: sum
    label: "Deal Forecasted Duration Months"
    sql: ${deal_forecasted_duration_months} ;;
  }

  measure: total_deal_forecasted_monthly_hours {
    type: sum
    label: "Deal Forecasted Monthly Hours"
    sql: ${deal_forecasted_monthly_hours} ;;
  }

  measure: total_deal_hourly_rate {
    type: sum
    label: "Deal Hourly Rate"
    sql: ${deal_hourly_rate} ;;
  }

  measure: total_deal_id {
    type: sum
    label: "Deal Id (Timesheet Project Engagements Dim)"
    sql: ${deal_id} ;;
  }
}
