view: recognized_revenue_fact {
  sql_table_name: `ra-development.analytics.recognized_revenue_fact` ;;

  dimension: consultant_delivery_labour_cost_gbp {
    hidden: yes
    sql: ${TABLE}.consultant_delivery_labour_cost_gbp ;;
  }

  dimension: consultant_hours_attributed {
    hidden: yes
    sql: ${TABLE}.consultant_hours_attributed ;;
  }

  dimension: consultant_hours_billed {
    hidden: yes
    sql: ${TABLE}.consultant_hours_billed ;;
  }

  dimension: consultant_recognized_attributed_revenue_gbp {
    hidden: yes
    sql: ${TABLE}.consultant_recognized_attributed_revenue_gbp ;;
  }

  dimension: consultant_recognized_revenue_gbp {
    hidden: yes
    sql: ${TABLE}.consultant_recognized_revenue_gbp ;;
  }

  dimension: contact_fk {
    hidden: yes
    sql: ${TABLE}.contact_fk ;;
  }

  dimension: engagement_month_number {
    sql: ${TABLE}.engagement_month_number ;;
  }

  dimension: expense_cost_gbp {
    hidden: yes
    sql: ${TABLE}.total_expense_cost_gbp ;;
  }

  dimension: hours_attributed {
    hidden: yes
    sql: ${TABLE}.total_hours_attributed ;;
  }

  dimension: hours_billed {
    hidden: yes
    sql: ${TABLE}.total_hours_billed ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: concat(${billing_month_raw},${timesheet_project_pk},${contact_fk}) ;;
  }

  dimension: project_month_key {
    hidden: yes
    sql: concat(${billing_month_raw},${timesheet_project_pk}) ;;
  }

  dimension: project_name {
    hidden: yes
    sql: ${TABLE}.project_name ;;
  }

  dimension: timesheet_project_pk {
    hidden: yes
    sql: ${TABLE}.timesheet_project_pk ;;
  }

  dimension_group: billing_month {
    type: time
    timeframes: [raw, date, month, quarter, year, month_num]
    convert_tz: no
    sql: ${TABLE}.billing_month ;;
  }

  measure: avg_hourly_rate {
    type: number
    label: "Avg Hourly Rate"
    description: "Recognised revenue per hour billed (Looker tile 3082 table calculation avg_hourly_rate)"
    value_format_name: gbp_0
    sql: safe_divide(${total_recognized_revenue_gbp}, ${total_hours_billed}) ;;
  }

  measure: recognized_margin_gbp {
    type: number
    description: "Recognised revenue minus labour cost and spread expenses"
    value_format_name: gbp_0
    sql: coalesce(${total_recognized_revenue_gbp},0) - ${total_delivery_cost_gbp} ;;
  }

  measure: recognized_margin_pct {
    type: number
    label: "Project Margin %"
    description: "Recognised margin over recognised revenue (Looker dashboard 415 tile 3901 calculation project_margin)"
    value_format_name: percent_1
    sql: safe_divide(${recognized_margin_gbp}, ${total_recognized_revenue_gbp}) ;;
  }

  measure: total_delivery_cost_gbp {
    type: number
    description: "Labour cost plus spread expenses"
    value_format_name: gbp_0
    sql: coalesce(${total_delivery_labour_cost_gbp},0) + coalesce(${total_expense_cost_gbp},0) ;;
  }

  measure: total_delivery_labour_cost_gbp {
    type: sum
    description: "Cost of billable hours logged: hours x the Harvest cost rate on each entry. Entries with no cost rate count as zero (contractor-staffed projects are costed through expenses instead)."
    value_format_name: gbp_0
    sql: ${consultant_delivery_labour_cost_gbp} ;;
  }

  measure: total_expense_cost_gbp {
    type: sum_distinct
    description: "Project expenses (billable and non-billable) spread evenly over the working days in the project's delivery window. Counted once per project month regardless of how many consultants worked on the project."
    value_format_name: gbp_0
    sql: ${expense_cost_gbp} ;;
    sql_distinct_key: ${project_month_key} ;;
  }

  measure: total_hours_attributed {
    type: sum
    description: "Total billable hours billed by consultant, modified by their grade modifier"
    value_format_name: decimal_0
    sql: ${consultant_hours_attributed} ;;
  }

  measure: total_hours_billed {
    type: sum
    description: "Total billable hours billed by consultant"
    value_format_name: decimal_0
    sql: ${consultant_hours_billed} ;;
  }

  measure: total_recognized_revenue_attributed_gbp {
    type: sum
    value_format_name: gbp_0
    sql: ${consultant_recognized_attributed_revenue_gbp} ;;
  }

  measure: total_recognized_revenue_gbp {
    type: sum
    value_format_name: gbp_0
    sql: ${consultant_recognized_revenue_gbp} ;;
  }
}
