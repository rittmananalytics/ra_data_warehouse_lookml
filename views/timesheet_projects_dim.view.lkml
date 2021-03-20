view: timesheet_projects_dim {
  sql_table_name: `{{ _user_attributes['dataset'] }}.timesheet_projects_dim`
    ;;
  view_label: "  Timesheets"
  dimension: company_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension: project_budget_amount {
    group_label: "Project Commercials"
    type: number
    sql: ${TABLE}.project_budget_amount ;;
  }

  dimension: project_budget_by {
    group_label: "Project Commercials"

    type: string
    sql: ${TABLE}.project_budget_by ;;
  }

  dimension: project_code {
    group_label: "   Project Details"

    type: string
    sql: ${TABLE}.project_code ;;
  }

  dimension: project_cost_budget {
    group_label: "Project Commercials"

    type: number
    sql: ${TABLE}.project_cost_budget ;;
  }

  dimension_group: project_delivery_end_ts {
    group_label: "   Project Details"

    type: time
    timeframes: [date,week,month]
    sql: timestamp(${TABLE}.project_delivery_end_ts) ;;
  }

  dimension_group : project_delivery_start_ts {
    group_label: "   Project Details"

    type: time
    timeframes: [date,week,month]
    sql: timestamp(${TABLE}.project_delivery_start_ts) ;;
  }

  dimension: project_fee_amount {
    group_label: "Project Commercials"

    type: number
    sql: ${TABLE}.project_fee_amount ;;
  }

  dimension: project_hourly_rate {
    group_label: "Project Commercials"

    type: number
    sql: ${TABLE}.project_hourly_rate ;;
  }

  dimension: project_is_active {
    group_label: "   Project Details"

    type: yesno
    sql: ${TABLE}.project_is_active ;;
  }

  dimension: project_is_billable {
    group_label: "Project Commercials"

    type: yesno
    sql: ${TABLE}.project_is_billable ;;
  }

  dimension: project_is_expenses_included_in_cost_budget {
    group_label: "Project Commercials"

    type: yesno
    sql: ${TABLE}.project_is_expenses_included_in_cost_budget ;;
  }

  dimension: project_is_fixed_fee {
    group_label: "Project Commercials"

    type: yesno
    sql: ${TABLE}.project_is_fixed_fee ;;
  }

  dimension: project_name {
    group_label: "   Project Details"

    type: string
    sql: ${TABLE}.project_name ;;
  }

  dimension: project_over_budget_notification_pct {
    group_label: "Project Commercials"

    type: number
    sql: ${TABLE}.project_over_budget_notification_pct ;;
  }

  dimension: timesheet_project_id {
    hidden: yes
    type: string
    sql: ${TABLE}.timesheet_project_id ;;
  }

  dimension: timesheet_project_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.timesheet_project_pk ;;
  }

  measure: count_timesheet_projects {
    type: count_distinct
    sql:  ${TABLE}.timesheet_project_pk ;;
    drill_fields: [project_name]
  }
}