view: timesheet_projects_dim {
  sql_table_name: `ra-development.analytics.timesheet_projects_dim` ;;

  dimension: company_fk {
    hidden: yes
    sql: ${TABLE}.company_fk ;;
  }

  dimension: deal_id {
    group_label: "Project Details"
    value_format_name: id
    sql: safe_cast(split(split(${project_code},'-')[safe_offset(1)],'-')[safe_offset(0)] as int64) ;;
  }

  dimension: is_discovery_sprint {
    type: yesno
    group_label: "Project Details"
    sql: ${project_name} like '%Discovery%' ;;
  }

  dimension: is_jumpstart_sprint {
    type: yesno
    group_label: "Project Details"
    sql: ${project_name} like '%Jumpstart%' or ${project_name} like '%Quickstart%' ;;
  }

  dimension: is_project_active {
    group_label: "Project Details"
    hidden: yes
    sql: case when timestamp_add(timestamp(${TABLE}.project_delivery_end_ts),interval 30 day) > ${TABLE}.current_timestamp then true else false end ;;
  }

  dimension: project_budget_amount {
    group_label: "Project Commercials"
    sql: ${TABLE}.project_budget_amount ;;
  }

  dimension: project_budget_by {
    group_label: "Project Commercials"
    hidden: yes
    sql: ${TABLE}.project_budget_by ;;
  }

  dimension: project_code {
    label: "Project Code"
    group_label: "Project Details"
    sql: ${TABLE}.project_code ;;
  }

  dimension: project_cost_budget {
    group_label: "Project Commercials"
    hidden: yes
    sql: ${TABLE}.project_cost_budget ;;
  }

  dimension: project_fee_amount {
    type: number
    group_label: "Project Commercials"
    value_format_name: gbp_0
    sql: ${TABLE}.project_fee_amount ;;
  }

  dimension: project_fee_amount_pro_rata {
    group_label: "Project Commercials"
    hidden: yes
    sql: ${TABLE}.total_project_fee_recognized_revenue ;;
  }

  dimension: project_hourly_rate {
    group_label: "Project Commercials"
    sql: ${TABLE}.project_hourly_rate ;;
  }

  dimension: project_is_active {
    group_label: "Project Details"
    hidden: yes
    sql: ${TABLE}.project_is_active ;;
  }

  dimension: project_is_billable {
    group_label: "Project Commercials"
    hidden: yes
    sql: ${TABLE}.project_is_billable ;;
  }

  dimension: project_is_expenses_included_in_cost_budget {
    group_label: "Project Commercials"
    hidden: yes
    sql: ${TABLE}.project_is_expenses_included_in_cost_budget ;;
  }

  dimension: project_is_fixed_fee {
    group_label: "Project Commercials"
    sql: ${TABLE}.project_is_fixed_fee ;;
  }

  dimension: project_name {
    label: "Project Name"
    group_label: "Project Details"
    sql: ${TABLE}.project_name ;;
  }

  dimension: project_over_budget_notification_pct {
    group_label: "Project Commercials"
    hidden: yes
    sql: ${TABLE}.project_over_budget_notification_pct ;;
  }

  dimension: timesheet_project_id {
    group_label: "Project Details"
    hidden: yes
    sql: ${TABLE}.timesheet_project_id ;;
  }

  dimension: timesheet_project_pk {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.timesheet_project_pk ;;
  }

  dimension: total_business_days_pct_elapsed {
    type: number
    group_label: "Project Commercials"
    hidden: yes
    value_format_name: percent_0
    sql: 1- ${TABLE}.total_business_days_pct_left ;;
  }

  dimension_group: last_billable_timesheet {
    type: time
    timeframes: [raw, date]
    group_label: "Project Details"
    sql: ${TABLE}.last_billable_timesheet_date ;;
  }

  dimension_group: project_delivery_end_ts {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    label: "Project End"
    group_label: "Project Details"
    sql: timestamp(${TABLE}.project_delivery_end_ts) ;;
  }

  dimension_group: project_delivery_start_ts {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    label: "Project Start"
    group_label: "Project Details"
    sql: timestamp(${TABLE}.project_delivery_start_ts) ;;
  }

  measure: count_discovery_projects {
    type: count_distinct
    label: "Total Discovery Sprints"
    sql: ${timesheet_project_pk} ;;
    filters: [is_discovery_sprint: "Yes"]
  }

  measure: count_implementation_projects {
    type: count_distinct
    label: "Total Implementation Sprints"
    sql: ${timesheet_project_pk} ;;
    filters: [is_discovery_sprint: "No", is_jumpstart_sprint: "No"]
  }

  measure: count_jumpstart_projects {
    type: count_distinct
    label: "Total Jumpstart Sprints"
    sql: ${timesheet_project_pk} ;;
    filters: [is_jumpstart_sprint: "Yes"]
  }

  measure: count_timesheet_projects {
    type: count_distinct
    label: "Total Sprints"
    drill_fields: [timesheet_projects_dim.project_name]
    sql: ${timesheet_project_pk} ;;
  }

  measure: project_fte_budget {
    type: sum
    group_label: "Project Commercials"
    hidden: yes
    sql: ${project_budget_amount} / (35*4) ;;
  }

  measure: project_hours_budget {
    type: sum
    group_label: "Project Commercials"
    sql: ${project_budget_amount} ;;
  }

  measure: total_project_fee_amount {
    type: sum
    label: "Total Project Fee Amount GBP"
    group_label: "Project Commercials"
    sql: ${project_fee_amount} ;;
  }
}
