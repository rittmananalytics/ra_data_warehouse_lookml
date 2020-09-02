view: invoices_fact {
  sql_table_name: `analytics.invoices_fact`
    ;;

  dimension: all_invoice_ids {
    type: string
    sql: ${TABLE}.all_invoice_ids ;;
  }

  dimension: company_id {
    type: string
    sql: ${TABLE}.company_id ;;
  }

  dimension: company_pk {
    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension: creator_users_pk {
    type: string
    sql: ${TABLE}.creator_users_pk ;;
  }

  dimension_group: first_invoice_month {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.first_invoice_month ;;
  }

  dimension_group: first_invoice_quarter {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.first_invoice_quarter ;;
  }

  dimension_group: invoice_created_at_ts {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.invoice_created_at_ts ;;
  }

  dimension: invoice_creator_users_id {
    type: string
    sql: ${TABLE}.invoice_creator_users_id ;;
  }

  dimension: invoice_currency {
    type: string
    sql: ${TABLE}.invoice_currency ;;
  }

  dimension_group: invoice_due_at_ts {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.invoice_due_at_ts ;;
  }

  dimension_group: invoice_issue_at_ts {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.invoice_issue_at_ts ;;
  }

  dimension: invoice_local_total_billed_amount {
    type: number
    sql: ${TABLE}.invoice_local_total_billed_amount ;;
  }

  dimension: invoice_local_total_due_amount {
    type: number
    sql: ${TABLE}.invoice_local_total_due_amount ;;
  }

  dimension: invoice_local_total_expenses_amount {
    type: number
    sql: ${TABLE}.invoice_local_total_expenses_amount ;;
  }

  dimension: invoice_local_total_licence_referral_fee_amount {
    type: number
    sql: ${TABLE}.invoice_local_total_licence_referral_fee_amount ;;
  }

  dimension: invoice_local_total_revenue_amount {
    type: number
    sql: ${TABLE}.invoice_local_total_revenue_amount ;;
  }

  dimension: invoice_local_total_services_amount {
    type: number
    sql: ${TABLE}.invoice_local_total_services_amount ;;
  }

  dimension: invoice_local_total_support_amount {
    type: number
    sql: ${TABLE}.invoice_local_total_support_amount ;;
  }

  dimension: invoice_local_total_tax_amount {
    type: number
    sql: ${TABLE}.invoice_local_total_tax_amount ;;
  }

  dimension: invoice_number {
    type: string
    sql: ${TABLE}.invoice_number ;;
  }

  dimension_group: invoice_paid_at_ts {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.invoice_paid_at_ts ;;
  }

  dimension: invoice_payment_term {
    type: string
    sql: ${TABLE}.invoice_payment_term ;;
  }

  dimension_group: invoice_period_end_at_ts {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.invoice_period_end_at_ts ;;
  }

  dimension_group: invoice_period_start_at_ts {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.invoice_period_start_at_ts ;;
  }

  dimension: invoice_pk {
    type: string
    sql: ${TABLE}.invoice_pk ;;
  }

  dimension_group: invoice_sent_at_ts {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.invoice_sent_at_ts ;;
  }

  dimension: invoice_seq {
    type: number
    sql: ${TABLE}.invoice_seq ;;
  }

  dimension: invoice_status {
    type: string
    sql: ${TABLE}.invoice_status ;;
  }

  dimension: invoice_subject {
    type: string
    sql: ${TABLE}.invoice_subject ;;
  }

  dimension: invoice_tax_rate_pct {
    type: string
    sql: ${TABLE}.invoice_tax_rate_pct ;;
  }

  dimension: invoice_total_days_overdue {
    type: number
    sql: ${TABLE}.invoice_total_days_overdue ;;
  }

  dimension: invoice_total_days_to_pay {
    type: number
    sql: ${TABLE}.invoice_total_days_to_pay ;;
  }

  dimension: invoice_total_days_variance_on_payment_terms {
    type: number
    sql: ${TABLE}.invoice_total_days_variance_on_payment_terms ;;
  }

  dimension: invoice_type {
    type: string
    sql: ${TABLE}.invoice_type ;;
  }

  dimension: months_since_first_invoice {
    type: number
    sql: ${TABLE}.months_since_first_invoice ;;
  }

  dimension: project_id {
    type: string
    sql: ${TABLE}.project_id ;;
  }

  dimension: quarters_since_first_invoice {
    type: number
    sql: ${TABLE}.quarters_since_first_invoice ;;
  }

  dimension: timesheet_project_pk {
    type: string
    sql: ${TABLE}.timesheet_project_pk ;;
  }

  dimension: total_local_amount {
    type: number
    sql: ${TABLE}.total_local_amount ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
