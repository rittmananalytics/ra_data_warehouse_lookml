view: timesheets_fact {
  sql_table_name: `{{ _user_attributes['dataset'] }}.timesheets_fact`
    ;;

  dimension: company_fk {
    hidden: yes

    type: string
    sql: ${TABLE}.company_fk ;;
  }

  dimension: timesheet_billable_hourly_cost_amount_gbp {
    group_label: "    Timesheet Details"
    hidden: yes

    type: number
    sql: ${TABLE}.timesheet_billable_hourly_cost_amount;;
  }

  measure: avg_timesheet_billable_hourly_cost_amount_gbp {
    hidden: yes

    type: average
    value_format_name: gbp
    sql: ${timesheet_billable_hourly_cost_amount_gbp} ;;


  }


  dimension: timesheet_billable_hourly_rate_amount_gbp {
    group_label: "    Timesheet Details"
    hidden: yes

    type: number
    sql: ${TABLE}.timesheet_billable_hourly_rate_amount ;;
  }



  dimension_group: timesheet_billing {
    group_label: "    Timesheet Details"

    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      week_of_year,
      day_of_week,
      day_of_month,
      day_of_year,
      day_of_week_index,
      month,
      month_num,
      quarter,
      fiscal_month_num,
      fiscal_quarter_of_year,
      fiscal_year,
      fiscal_quarter,
      year
    ]
    sql: ${TABLE}.timesheet_billing_date ;;
  }

  measure: last_timesheet_billing_date {
    group_label: "    Timesheet Details"
    hidden: yes

    type: date
    sql: max(${timesheet_billing_raw}) ;;
    convert_tz: no
  }

  dimension: timesheet_has_been_billed {
    group_label: "    Timesheet Details"
    hidden: yes

    type: yesno
    sql: ${TABLE}.timesheet_has_been_billed ;;
  }

  dimension_group: first_client_timesheet {
    group_label: "    Timesheet Details"
    hidden: yes

    type: time
    timeframes: [
      month
    ]
    sql: ${TABLE}.first_company_timesheet_billing_date ;;
  }

  dimension_group: last_client_timesheet  {
    group_label: "    Timesheet Details"
    hidden: yes

    type: time
    timeframes: [
      month
    ]
    sql: ${TABLE}.last_company_timesheet_billing_date ;;
  }

  dimension: timesheet_has_been_locked {
    group_label: "    Timesheet Details"
    hidden: yes

    type: yesno
    sql: ${TABLE}.timesheet_has_been_locked ;;
  }

  dimension: timesheet_hours_billed {
    group_label: "    Timesheet Details"
    value_format_name: decimal_1
    hidden: yes
    type: number
    sql: coalesce(${TABLE}.timesheet_hours_billed,0) ;;
  }

  measure: total_timesheet_hours_billed {
    value_format_name: decimal_0
    label: "Total Hours"
    type: sum
    sql: coalesce(${TABLE}.timesheet_hours_billed,0) ;;
  }



  measure: total_timesheet_billable_hours_billed {
    value_format_name: decimal_0
    label: "Total Billable Hours"

    type: sum
    sql: coalesce(${TABLE}.timesheet_hours_billed,0) ;;
    filters: [timesheet_is_billable: "Yes"]
  }

  measure: total_timesheet_nonbillable_hours_billed {
    value_format_name: decimal_0
    label: "Total Non-Billable Hours"


    type: sum
    sql: coalesce(${TABLE}.timesheet_hours_billed,0) ;;
    filters: [timesheet_is_billable: "No"]
  }



  dimension: timesheet_invoice_id {
    hidden: yes

    type: number
    sql: ${TABLE}.timesheet_invoice_id ;;
  }

  dimension: timesheet_is_billable {
    group_label: "    Timesheet Details"
    hidden: yes

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

  dimension: timesheet_project_fk {
    hidden: yes

    type: string
    sql: ${TABLE}.timesheet_project_fk ;;
  }

  dimension: timesheet_task_fk {
    hidden: yes

    type: string
    sql: ${TABLE}.timesheet_task_fk ;;
  }

  dimension: timesheet_total_amount_billed {
    type: number
    hidden: yes
    sql: ${TABLE}.timesheet_total_amount_billed ;;
  }

  measure: total_timesheet_amount_billed {
    hidden: yes
    type: sum
    sql: coalesce(${TABLE}.timesheet_total_amount_billed,0) ;;
  }

  measure: total_timesheet_cost_amount_gbp {
    label: "Total Timesheet Hours Cost"

    type: sum
    value_format_name: gbp_0
    sql: coalesce(${TABLE}.timesheet_hours_billed * ${TABLE}.timesheet_billable_hourly_cost_amount,0) ;;
  }

  dimension: contact_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_fk ;;
  }


}
