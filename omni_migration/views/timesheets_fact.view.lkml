view: timesheets_fact {
  derived_table: {
    sql: SELECT t.*, k.task_name
      FROM `ra-development.analytics.timesheets_fact` t
      LEFT JOIN `ra-development.analytics.timesheet_tasks_dim` k ON t.timesheet_task_fk = k.timesheet_task_pk ;;
  }

  dimension: company_fk {
    hidden: yes
    sql: ${TABLE}.company_fk ;;
  }

  dimension: contact_pk {
    sql: ${TABLE}.contact_fk ;;
  }

  dimension: task_category {
    label: "Category"
    group_label: "Timesheet Details"
    description: "Sickness, Annual Leave, Company Meetings / Admin (30 named tasks) or Client Work (Looker custom dimension on dashboard 389 tile 3693)"
    sql: CASE WHEN ${TABLE}.task_name IN ('Sickness') THEN 'Sickness' WHEN ${TABLE}.task_name IN ('Annual Leave') THEN 'Annual Leave' WHEN ${TABLE}.task_name IN ('Admin', 'Ad-hoc Customer Support', 'Client Account Calls', 'Cloud Cortex POC project', 'Company Standups and All-Hands', 'Conference Attendance', 'Contract Writing & Negotiation', 'Customer Strategy/Tactics', 'Customer Success', 'Customer, Project & Supplier Management', 'Existing Customer Re-Activation', 'Finance & Accounting', 'G&A', 'GCP Professional Data Engineer', 'General Sales/Presales', 'Internal Analytics and Insights', 'Internal Metrics Development', 'License Referral Fee', 'Management / Exec Meetings', 'Marketing', 'Measurement', 'Non-Billable Onboarding Time', 'Non-Billable Project Assistance and Client Liaison', 'Non-Billable R&D Time', 'Non-Billable Support', 'Non-Billable Team Support & Management', 'Non-Billable Time', 'Office Management', 'Offsite Non-Billable Staff Training') THEN 'Company Meetings / Admin' ELSE 'Client Work' END ;;
  }

  dimension: task_name {
    label: "Task Name"
    group_label: "Timesheet Details"
    sql: ${TABLE}.task_name ;;
  }

  dimension: timesheet_billable_hourly_cost_amount_gbp {
    group_label: "Timesheet Details"
    sql: case when ${TABLE}.contact_fk = 'caed405b1af8b8e1d223c47b554b3191' then 45 else ${TABLE}.timesheet_billable_hourly_cost_amount end ;;
  }

  dimension: timesheet_billable_hourly_rate_amount_gbp {
    group_label: "Timesheet Details"
    sql: ${TABLE}.timesheet_billable_hourly_rate_amount ;;
  }

  dimension: timesheet_has_been_billed {
    group_label: "Timesheet Details"
    hidden: yes
    sql: ${TABLE}.timesheet_has_been_billed ;;
  }

  dimension: timesheet_has_been_locked {
    group_label: "Timesheet Details"
    hidden: yes
    sql: ${TABLE}.timesheet_has_been_locked ;;
  }

  dimension: timesheet_hours_billed {
    type: number
    group_label: "Timesheet Details"
    hidden: yes
    value_format_name: decimal_1
    sql: coalesce(${TABLE}.timesheet_hours_billed,0) ;;
  }

  dimension: timesheet_invoice_id {
    hidden: yes
    sql: ${TABLE}.timesheet_invoice_id ;;
  }

  dimension: timesheet_is_billable {
    type: yesno
    group_label: "Timesheet Details"
    hidden: yes
    sql: ${TABLE}.timesheet_is_billable ;;
  }

  dimension: timesheet_notes {
    hidden: yes
    sql: ${TABLE}.timesheet_notes ;;
  }

  dimension: timesheet_pk {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.timesheet_pk ;;
  }

  dimension: timesheet_project_fk {
    hidden: yes
    sql: ${TABLE}.timesheet_project_fk ;;
  }

  dimension: timesheet_task_fk {
    hidden: yes
    sql: ${TABLE}.timesheet_task_fk ;;
  }

  dimension: timesheet_total_amount_billed {
    hidden: yes
    sql: ${TABLE}.timesheet_total_amount_billed ;;
  }

  dimension_group: first_client_timesheet {
    type: time
    timeframes: [raw, date, month]
    group_label: "Timesheet Details"
    hidden: yes
    sql: ${TABLE}.first_company_timesheet_billing_date ;;
  }

  dimension_group: last_client_timesheet {
    type: time
    timeframes: [raw, date, month]
    group_label: "Timesheet Details"
    hidden: yes
    sql: ${TABLE}.last_company_timesheet_billing_date ;;
  }

  dimension_group: timesheet_billing {
    type: time
    timeframes: [raw, date, week, month, quarter, year, day_of_week, day_of_week_index, day_of_month, day_of_year, month_num]
    group_label: "Timesheet Details"
    sql: ${TABLE}.timesheet_billing_date ;;
  }

  measure: avg_timesheet_billable_hourly_cost_amount_gbp {
    type: average
    group_label: "Timesheets"
    value_format_name: gbp
    sql: ${timesheet_billable_hourly_cost_amount_gbp} ;;
  }

  measure: avg_timesheet_billable_hours_billed {
    type: average
    label: "Average Billable Hours"
    group_label: "Timesheets"
    value_format_name: decimal_0
    sql: coalesce(${timesheet_hours_billed},0) ;;
    filters: [timesheet_is_billable: "Yes"]
  }

  measure: avg_timesheet_hours_billed {
    type: average
    label: "Average Hours"
    group_label: "Timesheets"
    value_format_name: decimal_0
    sql: coalesce(${timesheet_hours_billed},0) ;;
  }

  measure: avg_timesheet_nonbillable_hours_billed {
    type: average
    label: "Average Non-Billable Hours"
    group_label: "Timesheets"
    value_format_name: decimal_0
    sql: coalesce(${timesheet_hours_billed},0) ;;
    filters: [timesheet_is_billable: "No"]
  }

  measure: total_available_hours {
    type: number
    label: "Total Available Hours"
    group_label: "Timesheets"
    description: "Hours on tasks other than Sickness and Annual Leave (Looker custom measure on dashboard 389)"
    value_format_name: decimal_0
    sql: SUM(CASE WHEN ${TABLE}.task_name NOT IN ('Sickness', 'Annual Leave') OR ${TABLE}.task_name IS NULL THEN coalesce(${TABLE}.timesheet_hours_billed, 0) ELSE 0 END) ;;
  }

  measure: total_sickness_hours {
    type: number
    label: "Total Sickness Hours"
    group_label: "Timesheets"
    value_format_name: decimal_0
    sql: SUM(CASE WHEN ${TABLE}.task_name = 'Sickness' THEN coalesce(${TABLE}.timesheet_hours_billed, 0) ELSE 0 END) ;;
  }

  measure: total_timesheet_amount_billed {
    type: sum
    group_label: "Timesheets"
    hidden: yes
    sql: coalesce(${timesheet_total_amount_billed},0) ;;
  }

  measure: total_timesheet_billable_hours_billed {
    type: sum
    label: "Total Billable Hours"
    group_label: "Timesheets"
    value_format_name: decimal_0
    sql: coalesce(${timesheet_hours_billed},0) ;;
    filters: [timesheet_is_billable: "Yes"]
  }

  measure: total_timesheet_cost_amount_gbp {
    type: sum
    label: "Total Timesheet Hours Cost"
    group_label: "Timesheets"
    value_format_name: gbp_0
    sql: coalesce(${timesheet_hours_billed} * (case when ${TABLE}.contact_fk = 'caed405b1af8b8e1d223c47b554b3191' then 45 else ${TABLE}.timesheet_billable_hourly_cost_amount end),0) ;;
  }

  measure: total_timesheet_hours_billed {
    type: sum
    label: "Total Hours"
    group_label: "Timesheets"
    value_format_name: decimal_0
    sql: coalesce(${timesheet_hours_billed},0) ;;
  }

  measure: total_timesheet_nonbillable_hours_billed {
    type: sum
    label: "Total Non-Billable Hours"
    group_label: "Timesheets"
    value_format_name: decimal_0
    sql: coalesce(${timesheet_hours_billed},0) ;;
    filters: [timesheet_is_billable: "No"]
  }

  measure: utilisation_pct {
    type: number
    label: "Util %"
    description: "Billable hours as a share of all hours (Looker tiles 2681 and 2682 table calculation util)"
    value_format_name: percent_1
    sql: safe_divide(${total_timesheet_billable_hours_billed}, ${total_timesheet_billable_hours_billed} + ${total_timesheet_nonbillable_hours_billed}) ;;
  }
}
