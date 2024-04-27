view: timesheet_projects_dim {
  sql_table_name: `{{ _user_attributes['dataset'] }}.timesheet_projects_dim`
    ;;
  view_label: "  Timesheets"
  dimension: company_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.company_fk ;;
  }

  dimension: project_budget_amount {
    group_label: "Project Commercials"
    hidden: yes

    type: number
    sql: ${TABLE}.project_budget_amount ;;
  }

  measure: project_hours_budget {
    group_label: "Project Commercials"
    hidden: yes

    type: sum
    sql: ${TABLE}.project_budget_amount ;;
  }

  measure: project_fte_budget {
    group_label: "Project Commercials"
    hidden: yes
    type: sum
    sql: ${TABLE}.project_budget_amount / (35*4);;
  }

  dimension: project_budget_by {
    group_label: "Project Commercials"
    hidden: yes

    type: string
    sql: ${TABLE}.project_budget_by ;;
  }

  dimension: project_code {
    group_label: "        Project Details"
    label: "         Project Code"

    type: string
    sql: ${TABLE}.project_code ;;
  }

  dimension: hubspot_deal_id {
    group_label: "        Project Details"
    hidden: yes

    type: number
    sql: safe_cast(split(split(project_code,'-')[safe_offset(1)],'-')[safe_offset(0)] as int64);;
  }

  dimension: project_cost_budget {
    group_label: "Project Commercials"
    hidden: yes

    type: number
    sql: ${TABLE}.project_cost_budget ;;
  }

  dimension_group: project_delivery_end_ts {
    group_label: "        Project Details"
    hidden: no
    label: "  Project End"
    type: time
    timeframes: [date,week,month,quarter,year]
    sql: timestamp(${TABLE}.project_delivery_end_ts) ;;
  }

  dimension_group: project_revenue_expected_ts {
    group_label: "        Project Details"
    hidden: yes

    type: time
    timeframes: [date,week,month]
    sql: case when ${projects_invoiced.invoice_due_date} is null then timestamp_add(timestamp(${TABLE}.project_delivery_end_ts),interval 30 day) else timestamp(${projects_invoiced.invoice_due_date}) end ;;
  }

  dimension: is_project_active {
    group_label: "        Project Details"
    hidden: yes

    type: yesno
    sql: case when timestamp_add(timestamp(${TABLE}.project_delivery_end_ts),interval 30 day) > current_timestamp then true else false end ;;
  }

  dimension_group : project_delivery_start_ts {
    group_label: "        Project Details"
    label: "    Project Start"

    type: time
    timeframes: [date,week,month,quarter,year]
    sql: timestamp(${TABLE}.project_delivery_start_ts) ;;
  }

  dimension: project_fee_amount {
    group_label: "Project Commercials"
    hidden: no
    value_format_name: gbp_0

    type: number
    sql: ${TABLE}.project_fee_amount ;;
  }



  dimension: project_fee_amount_pro_rata {
    group_label: "Project Commercials"
    hidden: yes

    type: number
    sql: ${TABLE}.total_project_fee_recognized_revenue ;;
  }





  dimension: total_business_days_pct_elapsed {
    group_label: "Project Commercials"
    type: number
    hidden: yes

    value_format_name: percent_0
    sql: 1- ${TABLE}.total_business_days_pct_left ;;
  }

  dimension: project_hourly_rate {
    group_label: "Project Commercials"
    hidden: no

    type: number
    sql: ${TABLE}.project_hourly_rate ;;
  }

  dimension: project_is_active {
    group_label: "        Project Details"
    hidden: yes

    type: yesno
    sql: ${TABLE}.project_is_active ;;
  }

  dimension: project_is_billable {
    group_label: "Project Commercials"
    hidden: yes

    type: yesno
    sql: ${TABLE}.project_is_billable ;;
  }

  dimension: project_is_expenses_included_in_cost_budget {
    group_label: "Project Commercials"
    hidden: yes

    type: yesno
    sql: ${TABLE}.project_is_expenses_included_in_cost_budget ;;
  }

  dimension: project_is_fixed_fee {
    group_label: "Project Commercials"
    hidden: no

    type: yesno
    sql: ${TABLE}.project_is_fixed_fee ;;
  }

  dimension: project_name {
    group_label: "        Project Details"
    label: "            Project Name"
    type: string
    sql: ${TABLE}.project_name ;;
  }

  measure: total_project_fee_amount {
    label: "Total Project Fee Amount GBP"
    type: sum
    sql: ${project_fee_amount} ;;
  }

  dimension: project_over_budget_notification_pct {
    group_label: "Project Commercials"
    hidden: yes

    type: number
    sql: ${TABLE}.project_over_budget_notification_pct ;;
  }

  dimension: timesheet_project_id {
    hidden: yes
    type: string
    sql: ${TABLE}.timesheet_project_id ;;
    group_label: "        Project Details"

  }

  dimension: timesheet_project_pk {

    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.timesheet_project_pk ;;
  }

  measure: count_timesheet_projects {
    hidden: no
    label: "Total Project Deliveries"

    type: count_distinct
    sql:  ${TABLE}.timesheet_project_pk ;;
    drill_fields: [project_name]
  }



}
