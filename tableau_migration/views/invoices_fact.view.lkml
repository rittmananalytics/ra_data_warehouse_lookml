view: invoices_fact {
  sql_table_name: `ra-development.analytics.invoices_fact` ;;

  dimension: all_invoice_ids {
    type: string
    label: "All Invoice Ids"
    sql: ${TABLE}.all_invoice_ids ;;
  }

  dimension: company_fk {
    type: string
    label: "Company Fk (Invoices Fact)"
    sql: ${TABLE}.company_fk ;;
  }

  dimension: company_id {
    type: string
    label: "Company Id (Invoices Fact)"
    sql: ${TABLE}.company_id ;;
  }

  dimension_group: expected_payment_at_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Expected Payment At Ts"
    sql: ${TABLE}.expected_payment_at_ts ;;
  }

  dimension_group: first_invoice_month {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "First Invoice Month"
    sql: ${TABLE}.first_invoice_month ;;
  }

  dimension_group: first_invoice_quarter {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "First Invoice Quarter"
    sql: ${TABLE}.first_invoice_quarter ;;
  }

  dimension_group: invoice_created_at_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Invoice Created At Ts"
    sql: ${TABLE}.invoice_created_at_ts ;;
  }

  dimension: invoice_creator_users_id {
    type: string
    label: "Invoice Creator Users Id"
    sql: ${TABLE}.invoice_creator_users_id ;;
  }

  dimension: invoice_currency {
    type: string
    label: "Invoice Currency"
    sql: ${TABLE}.invoice_currency ;;
  }

  dimension: invoice_currency_rate {
    type: number
    label: "Invoice Currency Rate"
    hidden: yes
    sql: ${TABLE}.invoice_currency_rate ;;
  }

  dimension_group: invoice_due_at_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Invoice Due At Ts"
    sql: ${TABLE}.invoice_due_at_ts ;;
  }

  dimension_group: invoice_issue_at_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Invoice Issue At Ts"
    sql: ${TABLE}.invoice_issue_at_ts ;;
  }

  dimension: invoice_local_total_billed_amount {
    type: number
    label: "Invoice Local Total Billed Amount"
    hidden: yes
    sql: ${TABLE}.invoice_local_total_billed_amount ;;
  }

  dimension: invoice_local_total_due_amount {
    type: number
    label: "Invoice Local Total Due Amount"
    hidden: yes
    sql: ${TABLE}.invoice_local_total_due_amount ;;
  }

  dimension: invoice_local_total_expenses_amount {
    type: number
    label: "Invoice Local Total Expenses Amount"
    hidden: yes
    sql: ${TABLE}.invoice_local_total_expenses_amount ;;
  }

  dimension: invoice_local_total_licence_referral_fee_amount {
    type: number
    label: "Invoice Local Total Licence Referral Fee Amount"
    hidden: yes
    sql: ${TABLE}.invoice_local_total_licence_referral_fee_amount ;;
  }

  dimension: invoice_local_total_revenue_amount {
    type: number
    label: "Invoice Local Total Revenue Amount"
    hidden: yes
    sql: ${TABLE}.invoice_local_total_revenue_amount ;;
  }

  dimension: invoice_local_total_services_amount {
    type: number
    label: "Invoice Local Total Services Amount"
    hidden: yes
    sql: ${TABLE}.invoice_local_total_services_amount ;;
  }

  dimension: invoice_local_total_support_amount {
    type: number
    label: "Invoice Local Total Support Amount"
    hidden: yes
    sql: ${TABLE}.invoice_local_total_support_amount ;;
  }

  dimension: invoice_local_total_tax_amount {
    type: number
    label: "Invoice Local Total Tax Amount"
    hidden: yes
    sql: ${TABLE}.invoice_local_total_tax_amount ;;
  }

  dimension: invoice_months_before_now {
    type: number
    label: "Invoice Months Before Now"
    hidden: yes
    sql: ${TABLE}.invoice_months_before_now ;;
  }

  dimension: invoice_number {
    type: string
    label: "Invoice Number"
    sql: ${TABLE}.invoice_number ;;
  }

  dimension_group: invoice_paid_at_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Invoice Paid At Ts"
    sql: ${TABLE}.invoice_paid_at_ts ;;
  }

  dimension: invoice_payment_term {
    type: string
    label: "Invoice Payment Term"
    sql: ${TABLE}.invoice_payment_term ;;
  }

  dimension_group: invoice_period_end_at_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Invoice Period End At Ts"
    sql: ${TABLE}.invoice_period_end_at_ts ;;
  }

  dimension_group: invoice_period_start_at_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Invoice Period Start At Ts"
    sql: ${TABLE}.invoice_period_start_at_ts ;;
  }

  dimension: invoice_pk {
    primary_key: yes
    type: string
    label: "Invoice Pk"
    sql: ${TABLE}.invoice_pk ;;
  }

  dimension_group: invoice_sent_at_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Invoice Sent At Ts"
    sql: ${TABLE}.invoice_sent_at_ts ;;
  }

  dimension: invoice_seq {
    type: number
    label: "Invoice Seq"
    hidden: yes
    sql: ${TABLE}.invoice_seq ;;
  }

  dimension: invoice_status {
    type: string
    label: "Invoice Status"
    sql: ${TABLE}.invoice_status ;;
  }

  dimension: invoice_subject {
    type: string
    label: "Invoice Subject"
    sql: ${TABLE}.invoice_subject ;;
  }

  dimension: invoice_tax_rate_pct {
    type: string
    label: "Invoice Tax Rate Pct"
    sql: ${TABLE}.invoice_tax_rate_pct ;;
  }

  dimension: invoice_total_days_overdue {
    type: number
    label: "Invoice Total Days Overdue"
    hidden: yes
    sql: ${TABLE}.invoice_total_days_overdue ;;
  }

  dimension: invoice_total_days_to_pay {
    type: number
    label: "Invoice Total Days To Pay"
    hidden: yes
    sql: ${TABLE}.invoice_total_days_to_pay ;;
  }

  dimension: invoice_total_days_variance_on_payment_terms {
    type: number
    label: "Invoice Total Days Variance On Payment Terms"
    hidden: yes
    sql: ${TABLE}.invoice_total_days_variance_on_payment_terms ;;
  }

  dimension: invoice_type {
    type: string
    label: "Invoice Type"
    sql: ${TABLE}.invoice_type ;;
  }

  dimension_group: last_invoice_month {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Last Invoice Month"
    sql: ${TABLE}.last_invoice_month ;;
  }

  dimension: months_before_last_invoice {
    type: number
    label: "Months Before Last Invoice"
    hidden: yes
    sql: ${TABLE}.months_before_last_invoice ;;
  }

  dimension: months_since_first_invoice {
    type: number
    label: "Months Since First Invoice"
    hidden: yes
    sql: ${TABLE}.months_since_first_invoice ;;
  }

  dimension: project_id {
    type: string
    label: "Project Id"
    sql: ${TABLE}.project_id ;;
  }

  dimension: quarters_since_first_invoice {
    type: number
    label: "Quarters Since First Invoice"
    hidden: yes
    sql: ${TABLE}.quarters_since_first_invoice ;;
  }

  dimension: timesheet_project_fk {
    type: string
    label: "Timesheet Project Fk"
    sql: ${TABLE}.timesheet_project_fk ;;
  }

  dimension: total_gbp_amount {
    type: number
    label: "Total Gbp Amount"
    hidden: yes
    sql: ${TABLE}.total_gbp_amount ;;
  }

  dimension: total_local_amount {
    type: number
    label: "Total Local Amount"
    hidden: yes
    sql: ${TABLE}.total_local_amount ;;
  }

  measure: total_invoice_currency_rate {
    type: sum
    label: "Invoice Currency Rate"
    sql: ${invoice_currency_rate} ;;
  }

  measure: total_invoice_local_total_billed_amount {
    type: sum
    label: "Invoice Local Total Billed Amount"
    sql: ${invoice_local_total_billed_amount} ;;
  }

  measure: total_invoice_local_total_due_amount {
    type: sum
    label: "Invoice Local Total Due Amount"
    sql: ${invoice_local_total_due_amount} ;;
  }

  measure: total_invoice_local_total_expenses_amount {
    type: sum
    label: "Invoice Local Total Expenses Amount"
    sql: ${invoice_local_total_expenses_amount} ;;
  }

  measure: total_invoice_local_total_licence_referral_fee_amount {
    type: sum
    label: "Invoice Local Total Licence Referral Fee Amount"
    sql: ${invoice_local_total_licence_referral_fee_amount} ;;
  }

  measure: total_invoice_local_total_revenue_amount {
    type: sum
    label: "Invoice Local Total Revenue Amount"
    sql: ${invoice_local_total_revenue_amount} ;;
  }

  measure: total_invoice_local_total_services_amount {
    type: sum
    label: "Invoice Local Total Services Amount"
    sql: ${invoice_local_total_services_amount} ;;
  }

  measure: total_invoice_local_total_support_amount {
    type: sum
    label: "Invoice Local Total Support Amount"
    sql: ${invoice_local_total_support_amount} ;;
  }

  measure: total_invoice_local_total_tax_amount {
    type: sum
    label: "Invoice Local Total Tax Amount"
    sql: ${invoice_local_total_tax_amount} ;;
  }

  measure: total_invoice_months_before_now {
    type: sum
    label: "Invoice Months Before Now"
    sql: ${invoice_months_before_now} ;;
  }

  measure: total_invoice_seq {
    type: sum
    label: "Invoice Seq"
    sql: ${invoice_seq} ;;
  }

  measure: total_invoice_total_days_overdue {
    type: sum
    label: "Invoice Total Days Overdue"
    sql: ${invoice_total_days_overdue} ;;
  }

  measure: total_invoice_total_days_to_pay {
    type: sum
    label: "Invoice Total Days To Pay"
    sql: ${invoice_total_days_to_pay} ;;
  }

  measure: total_invoice_total_days_variance_on_payment_terms {
    type: sum
    label: "Invoice Total Days Variance On Payment Terms"
    sql: ${invoice_total_days_variance_on_payment_terms} ;;
  }

  measure: total_months_before_last_invoice {
    type: sum
    label: "Months Before Last Invoice"
    sql: ${months_before_last_invoice} ;;
  }

  measure: total_months_since_first_invoice {
    type: sum
    label: "Months Since First Invoice"
    sql: ${months_since_first_invoice} ;;
  }

  measure: total_quarters_since_first_invoice {
    type: sum
    label: "Quarters Since First Invoice"
    sql: ${quarters_since_first_invoice} ;;
  }

  measure: total_total_gbp_amount {
    type: sum
    label: "Total Gbp Amount"
    sql: ${total_gbp_amount} ;;
  }

  measure: total_total_local_amount {
    type: sum
    label: "Total Local Amount"
    sql: ${total_local_amount} ;;
  }
}
