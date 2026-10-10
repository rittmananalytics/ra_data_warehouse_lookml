view: timesheet_projects_dim {
  sql_table_name: `ra-development.analytics.timesheet_projects_dim` ;;

  dimension: company_fk {
    type: string
    label: "Company Fk (Timesheet Projects Dim)"
    sql: ${TABLE}.company_fk ;;
  }

  dimension_group: last_billable_timesheet_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Last Billable Timesheet Date (Timesheet Projects Dim)"
    sql: ${TABLE}.last_billable_timesheet_date ;;
  }

  dimension: project_budget_amount {
    type: number
    label: "Project Budget Amount"
    hidden: yes
    sql: ${TABLE}.project_budget_amount ;;
  }

  dimension: project_budget_by {
    type: string
    label: "Project Budget By"
    sql: ${TABLE}.project_budget_by ;;
  }

  dimension: project_code {
    type: string
    label: "Project Code"
    sql: ${TABLE}.project_code ;;
  }

  dimension: project_cost_budget {
    type: number
    label: "Project Cost Budget"
    hidden: yes
    sql: ${TABLE}.project_cost_budget ;;
  }

  dimension: project_delivery_end_ts {
    type: string
    label: "Project Delivery End Ts"
    sql: ${TABLE}.project_delivery_end_ts ;;
  }

  dimension: project_delivery_start_ts {
    type: string
    label: "Project Delivery Start Ts"
    sql: ${TABLE}.project_delivery_start_ts ;;
  }

  dimension: project_duration_days {
    type: number
    label: "Project Duration Days"
    hidden: yes
    sql: ${TABLE}.project_duration_days ;;
  }

  dimension: project_fee_amount {
    type: number
    label: "Project Fee Amount"
    hidden: yes
    sql: ${TABLE}.project_fee_amount ;;
  }

  dimension: project_hourly_rate {
    type: number
    label: "Project Hourly Rate"
    hidden: yes
    sql: ${TABLE}.project_hourly_rate ;;
  }

  dimension: project_is_active {
    type: yesno
    label: "Project Is Active"
    sql: ${TABLE}.project_is_active ;;
  }

  dimension: project_is_billable {
    type: yesno
    label: "Project Is Billable"
    sql: ${TABLE}.project_is_billable ;;
  }

  dimension: project_is_expenses_included_in_cost_budget {
    type: yesno
    label: "Project Is Expenses Included In Cost Budget"
    sql: ${TABLE}.project_is_expenses_included_in_cost_budget ;;
  }

  dimension: project_is_fixed_fee {
    type: yesno
    label: "Project Is Fixed Fee"
    sql: ${TABLE}.project_is_fixed_fee ;;
  }

  dimension: project_name {
    type: string
    label: "Project Name"
    sql: ${TABLE}.project_name ;;
  }

  dimension: project_over_budget_notification_pct {
    type: number
    label: "Project Over Budget Notification Pct"
    hidden: yes
    sql: ${TABLE}.project_over_budget_notification_pct ;;
  }

  dimension: timesheet_project_id {
    type: string
    label: "Timesheet Project Id"
    sql: ${TABLE}.timesheet_project_id ;;
  }

  dimension: timesheet_project_pk {
    primary_key: yes
    type: string
    label: "Timesheet Project Pk"
    sql: ${TABLE}.timesheet_project_pk ;;
  }

  dimension: total_business_days {
    type: number
    label: "Total Business Days"
    hidden: yes
    sql: ${TABLE}.total_business_days ;;
  }

  dimension: total_business_days_burnt {
    type: number
    label: "Total Business Days Burnt"
    hidden: yes
    sql: ${TABLE}.total_business_days_burnt ;;
  }

  dimension: total_business_days_pct_left {
    type: number
    label: "Total Business Days Pct Left"
    hidden: yes
    sql: ${TABLE}.total_business_days_pct_left ;;
  }

  dimension: total_project_fee_recognized_revenue {
    type: number
    label: "Total Project Fee Recognized Revenue"
    hidden: yes
    sql: ${TABLE}.total_project_fee_recognized_revenue ;;
  }

  dimension: total_recognized_revenue_per_working_day {
    type: number
    label: "Total Recognized Revenue Per Working Day"
    hidden: yes
    sql: ${TABLE}.total_recognized_revenue_per_working_day ;;
  }

  measure: total_project_budget_amount {
    type: sum
    label: "Project Budget Amount"
    sql: ${project_budget_amount} ;;
  }

  measure: total_project_cost_budget {
    type: sum
    label: "Project Cost Budget"
    sql: ${project_cost_budget} ;;
  }

  measure: total_project_duration_days {
    type: sum
    label: "Project Duration Days"
    sql: ${project_duration_days} ;;
  }

  measure: total_project_fee_amount {
    type: sum
    label: "Project Fee Amount"
    sql: ${project_fee_amount} ;;
  }

  measure: total_project_hourly_rate {
    type: sum
    label: "Project Hourly Rate"
    sql: ${project_hourly_rate} ;;
  }

  measure: total_project_over_budget_notification_pct {
    type: sum
    label: "Project Over Budget Notification Pct"
    sql: ${project_over_budget_notification_pct} ;;
  }

  measure: total_total_business_days {
    type: sum
    label: "Total Business Days"
    sql: ${total_business_days} ;;
  }

  measure: total_total_business_days_burnt {
    type: sum
    label: "Total Business Days Burnt"
    sql: ${total_business_days_burnt} ;;
  }

  measure: total_total_business_days_pct_left {
    type: sum
    label: "Total Business Days Pct Left"
    sql: ${total_business_days_pct_left} ;;
  }

  measure: total_total_project_fee_recognized_revenue {
    type: sum
    label: "Total Project Fee Recognized Revenue"
    sql: ${total_project_fee_recognized_revenue} ;;
  }

  measure: total_total_recognized_revenue_per_working_day {
    type: sum
    label: "Total Recognized Revenue Per Working Day"
    sql: ${total_recognized_revenue_per_working_day} ;;
  }
}
