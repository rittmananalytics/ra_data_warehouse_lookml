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
    timeframes: [date,week,month,week_of_year,month_num,quarter,quarter_of_year,day_of_week,day_of_month,day_of_week_index]
    sql: timestamp(${TABLE}.project_delivery_end_ts) ;;
  }

  dimension_group: project_revenue_expected_ts {
    group_label: "   Project Details"

    type: time
    timeframes: [date,week,month]
    sql: case when ${projects_invoiced.invoice_due_date} is null then timestamp_add(timestamp(${TABLE}.project_delivery_end_ts),interval 30 day) else timestamp(${projects_invoiced.invoice_due_date}) end ;;
  }

  dimension: is_project_active {
    group_label: "   Project Details"
    type: yesno
    sql: case when timestamp_add(timestamp(${TABLE}.project_delivery_end_ts),interval 30 day) > current_timestamp then true else false end ;;
  }

  dimension_group : project_delivery_start_ts {
    group_label: "   Project Details"

    type: time
    timeframes: [date,week,month,week_of_year,month_num,quarter,quarter_of_year,day_of_week,day_of_month,day_of_week_index]
    sql: timestamp(${TABLE}.project_delivery_start_ts) ;;
  }

  dimension: project_fee_amount {
    group_label: "Project Commercials"

    type: number
    sql: ${TABLE}.project_fee_amount ;;
  }

  measure: total_project_fee_amount {
    group_label: "Project Commercials"

    type: sum_distinct
    sql: case when ${project_fee_amount} = 7000 then 5000
              when ${project_fee_amount} = 5500 then 4000
              when ${project_fee_amount} = 5800 then 5000
              when ${project_fee_amount} = 13620 then 9900
              when ${project_fee_amount} = 9625 then 7000
              else ${project_fee_amount} end;;
  }

  dimension: project_fee_amount_pro_rata {
    group_label: "Project Commercials"

    type: number
    sql: ${TABLE}.total_project_fee_recognized_revenue ;;
  }

  measure: total_project_fee_amount_pro_rata {
    group_label: "Project Commercials"
    type: sum_distinct
    sql:${project_fee_amount_pro_rata} ;;
  }

  measure: total_project_fee_amount_pro_rata_gbp {
    group_label: "Project Commercials"
    type: sum_distinct
    sql: case when ${project_fee_amount} = 7000 then ${project_fee_amount_pro_rata} * .75
              when ${project_fee_amount} = 5500 then ${project_fee_amount_pro_rata} * .75
              when ${project_fee_amount} = 5800 then ${project_fee_amount_pro_rata} * .90
              when ${project_fee_amount} = 13620 then ${project_fee_amount_pro_rata} * .75
              when ${project_fee_amount} = 9625 then ${project_fee_amount_pro_rata} * .75
              else ${project_fee_amount_pro_rata} end;;
  }

  dimension: total_business_days_pct_elapsed {
    group_label: "Project Commercials"
    type: number
    value_format_name: percent_0
    sql: 1- ${TABLE}.total_business_days_pct_left ;;
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
