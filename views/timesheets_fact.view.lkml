view: timesheets_fact {
  sql_table_name: `{{ _user_attributes['dbt_dataset'] }}.timesheets_fact`
    ;;

  dimension: company_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension: timesheet_billable_hourly_cost_amount {
    group_label: "Timesheet Details"

    type: number
    sql: case when ${TABLE}.timesheet_billable_hourly_cost_amount = 100 then 32 else ${TABLE}.timesheet_billable_hourly_cost_amount end;;
  }

  dimension: timesheet_billable_hourly_rate_amount {
    group_label: "Timesheet Details"

    type: number
    sql: ${TABLE}.timesheet_billable_hourly_rate_amount ;;
  }

  dimension_group: timesheet_billing {
    group_label: "Timesheet Details"

    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      month_num,
      quarter,
      year
    ]
    sql: ${TABLE}.timesheet_billing_date ;;
  }

  dimension: timesheet_has_been_billed {
    group_label: "Timesheet Details"

    type: yesno
    sql: ${TABLE}.timesheet_has_been_billed ;;
  }

  dimension_group: first_client_timesheet {
    group_label: "Timesheet Details"

    type: time
    timeframes: [
      month
    ]
    sql: ${TABLE}.first_company_timesheet_billing_date ;;
  }

  dimension_group: last_client_timesheet  {
    group_label: "Timesheet Details"

    type: time
    timeframes: [
      month
    ]
    sql: ${TABLE}.last_company_timesheet_billing_date ;;
  }

  dimension: timesheet_has_been_locked {
    group_label: "Timesheet Details"

    type: yesno
    sql: ${TABLE}.timesheet_has_been_locked ;;
  }

  dimension: timesheet_hours_billed {
    group_label: "Timesheet Details"

    hidden: no
    type: number
    sql: ${TABLE}.timesheet_hours_billed ;;
  }

  measure: total_timesheet_hours_billed {
    group_label: "Timesheet Details"

    type: sum
    sql: ${TABLE}.timesheet_hours_billed ;;
  }

  dimension: timesheet_invoice_id {
    hidden: yes

    type: number
    sql: ${TABLE}.timesheet_invoice_id ;;
  }

  dimension: timesheet_is_billable {
    group_label: "Timesheet Details"

    type: yesno
    sql: ${TABLE}.timesheet_is_billable ;;
  }

  dimension: timesheet_notes {
    hidden: yes

    type: string
    sql: ${TABLE}.timesheet_notes ;;
  }

  dimension: timesheet_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.timesheet_pk ;;
  }

  dimension: timesheet_project_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.timesheet_project_pk ;;
  }

  dimension: timesheet_task_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.timesheet_task_pk ;;
  }

  dimension: timesheet_total_amount_billed {
    type: number
    hidden: yes
    sql: ${TABLE}.timesheet_total_amount_billed ;;
  }

  measure: total_timesheet_amount_billed {
    hidden: yes
    type: sum
    sql: ${TABLE}.timesheet_total_amount_billed ;;
  }

  measure: total_timesheet_cost_amount {
    group_label: "Timesheet Details"

    type: sum
    sql: ${TABLE}.timesheet_hours_billed * coalesce(case when ${TABLE}.timesheet_billable_hourly_cost_amount > 60 then 32 else ${TABLE}.timesheet_billable_hourly_cost_amount end,25) ;;
  }

  dimension: contact_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_pk ;;
  }


}