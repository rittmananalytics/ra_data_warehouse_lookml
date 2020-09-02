view: timesheets_rpt {
  sql_table_name: `analytics.timesheets_rpt`
    ;;

  dimension: company_description {
    type: string
    sql: ${TABLE}.company_description ;;
  }

  dimension: company_name {
    type: string
    sql: ${TABLE}.company_name ;;
  }

  dimension: company_pk {
    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension: consultant {
    hidden: yes
    sql: ${TABLE}.consultant ;;
  }

  dimension: consulting_cost_budget_variance_gbp {
    type: number
    sql: ${TABLE}.consulting_cost_budget_variance_gbp ;;
  }

  dimension: effective_hourly_rate_gbp {
    type: number
    sql: ${TABLE}.effective_hourly_rate_gbp ;;
  }

  dimension: exchange_rate {
    type: number
    sql: ${TABLE}.exchange_rate ;;
  }

  dimension: project_budget_amount {
    type: number
    sql: ${TABLE}.project_budget_amount ;;
  }

  dimension: project_budget_by {
    type: string
    sql: ${TABLE}.project_budget_by ;;
  }

  dimension: project_code {
    type: string
    sql: ${TABLE}.project_code ;;
  }

  dimension: project_delivery_start_ts {
    type: string
    sql: ${TABLE}.project_delivery_start_ts ;;
  }

  dimension: project_duration_weeks {
    type: number
    sql: ${TABLE}.project_duration_weeks ;;
  }

  dimension: project_fee_amount_gbp {
    type: number
    sql: ${TABLE}.project_fee_amount_gbp ;;
  }

  dimension: project_hours_vs_budget {
    type: number
    sql: ${TABLE}.project_hours_vs_budget ;;
  }

  dimension: project_is_active {
    type: yesno
    sql: ${TABLE}.project_is_active ;;
  }

  dimension: project_is_fixed_fee {
    type: yesno
    sql: ${TABLE}.project_is_fixed_fee ;;
  }

  dimension: project_margin {
    type: number
    sql: ${TABLE}.project_margin ;;
  }

  dimension: project_name {
    type: string
    sql: ${TABLE}.project_name ;;
  }

  dimension: timesheet_project_pk {
    type: string
    sql: ${TABLE}.timesheet_project_pk ;;
  }

  dimension: total_consultant_cost_gbp {
    type: number
    sql: ${TABLE}.total_consultant_cost_gbp ;;
  }

  dimension: total_hours_billed {
    type: number
    sql: ${TABLE}.total_hours_billed ;;
  }

  dimension: total_project_margin_gbp {
    type: number
    sql: ${TABLE}.total_project_margin_gbp ;;
  }

  dimension: total_revenue {
    type: number
    sql: ${TABLE}.total_revenue ;;
  }

  measure: count {
    type: count
    drill_fields: [project_name, company_name]
  }
}

view: timesheets_rpt__consultant {
  dimension: consultant_contribution_gbp {
    type: number
    sql: ${TABLE}.consultant_contribution_gbp ;;
  }

  dimension: consultant_cost_gbp {
    type: number
    sql: ${TABLE}.consultant_cost_gbp ;;
  }

  dimension: consultant_hours_billed {
    type: number
    sql: ${TABLE}.consultant_hours_billed ;;
  }

  dimension: consultant_margin_pct {
    type: number
    sql: ${TABLE}.consultant_margin_pct ;;
  }

  dimension: consultant_share_hours_billed_pct {
    type: number
    sql: ${TABLE}.consultant_share_hours_billed_pct ;;
  }

  dimension: consultant_share_total_revenue_gbp {
    type: number
    sql: ${TABLE}.consultant_share_total_revenue_gbp ;;
  }

  dimension: task_name {
    type: string
    sql: ${TABLE}.task_name ;;
  }

  dimension_group: timesheet_billing_week {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.timesheet_billing_week ;;
  }

  dimension: user_is_contractor {
    type: yesno
    sql: ${TABLE}.user_is_contractor ;;
  }

  dimension: user_name {
    type: string
    sql: ${TABLE}.user_name ;;
  }
}
