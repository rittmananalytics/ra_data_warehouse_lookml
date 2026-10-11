view: invoices_fact {
  sql_table_name: `ra-development.analytics.invoices_fact` ;;

  dimension: churned {
    group_label: "Invoice Details"
    sql: cast(case when ${TABLE}.last_invoice_month < timestamp(date_sub(${TABLE}.current_date, interval 3 month)) then extract(year from ${TABLE}.last_invoice_month) end as string) ;;
  }

  dimension: company_fk {
    type: string
    hidden: yes
    sql: ${TABLE}.company_fk ;;
  }

  dimension: company_id {
    type: string
    hidden: yes
    sql: ${TABLE}.company_id ;;
  }

  dimension: invoice_currency {
    type: string
    group_label: "Invoice Details"
    sql: ${TABLE}.invoice_currency ;;
  }

  dimension: invoice_currency_rate {
    type: number
    hidden: yes
    sql: case when ${TABLE}.invoice_currency_rate is null or ${TABLE}.invoice_currency_rate = 0 then ${exchange_rates.currency_rate} else ${TABLE}.invoice_currency_rate end ;;
  }

  dimension: invoice_gbp_amount {
    type: number
    value_format_name: gbp_0
    sql: case when ${invoice_currency} = 'GBP' then ${total_local_amount}
    when ${invoice_currency} = 'USD' then ${total_local_amount} * 0.75
    when ${invoice_currency} = 'CAD' then ${total_local_amount} *  0.58
    when ${invoice_currency} = 'EUR' then ${total_local_amount} *  0.90
    end ;;
  }

  dimension: invoice_gbp_net_amount {
    hidden: yes
    sql: ${invoice_gbp_amount} ;;
  }

  dimension: invoice_gbp_tax_amount {
    type: number
    hidden: yes
    value_format_name: gbp
    sql: ${invoice_gbp_amount} * (safe_cast(${invoice_tax_rate_pct} as float64) / 100) ;;
  }

  dimension: invoice_local_total_tax_amount {
    type: number
    hidden: yes
    sql: ${total_local_amount} * (safe_cast(${invoice_tax_rate_pct} as float64) / 100) ;;
  }

  dimension: invoice_months_before_now {
    type: number
    group_label: "Invoice Details"
    hidden: yes
    sql: ${TABLE}.invoice_months_before_now ;;
  }

  dimension: invoice_number {
    type: string
    group_label: "Invoice Details"
    sql: ${TABLE}.invoice_number ;;
  }

  dimension: invoice_payment_term {
    type: string
    group_label: "Invoice Details"
    sql: ${TABLE}.invoice_payment_term ;;
  }

  dimension: invoice_pk {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.invoice_pk ;;
  }

  dimension: invoice_seq {
    type: number
    group_label: "Invoice Details"
    sql: ${TABLE}.invoice_seq ;;
  }

  dimension: invoice_status {
    type: string
    group_label: "Invoice Details"
    sql: ${TABLE}.invoice_status ;;
  }

  dimension: invoice_subject {
    type: string
    group_label: "Invoice Details"
    sql: ${TABLE}.invoice_subject ;;
  }

  dimension: invoice_tax_rate_pct {
    type: string
    group_label: "Invoice Details"
    sql: ${TABLE}.invoice_tax_rate_pct ;;
  }

  dimension: invoice_total_days_overdue {
    type: number
    group_label: "Invoicing"
    hidden: yes
    sql: ${TABLE}.invoice_total_days_overdue ;;
  }

  dimension: invoice_total_days_to_pay {
    type: number
    group_label: "Invoice Details"
    sql: ${TABLE}.invoice_total_days_to_pay ;;
  }

  dimension: invoice_total_days_variance_on_payment_terms {
    type: number
    hidden: yes
    sql: ${TABLE}.invoice_total_days_variance_on_payment_terms ;;
  }

  dimension: invoice_type {
    type: string
    group_label: "Invoice Details"
    sql: ${TABLE}.invoice_type ;;
  }

  dimension: is_invoice_in_clients_last_12m {
    type: yesno
    group_label: "Invoice Details"
    hidden: yes
    sql: ${months_before_last_invoice} < 12 ;;
  }

  dimension: months_before_last_invoice {
    type: number
    group_label: "Invoice Details"
    hidden: yes
    sql: ${TABLE}.months_before_last_invoice ;;
  }

  dimension: months_since_first_invoice {
    type: number
    group_label: "Invoice Details"
    sql: ${TABLE}.months_since_first_invoice ;;
  }

  dimension: project_id {
    type: string
    sql: ${TABLE}.project_id ;;
  }

  dimension: quarters_since_first_invoice {
    type: number
    group_label: "Invoice Details"
    hidden: yes
    sql: ${TABLE}.quarters_since_first_invoice ;;
  }

  dimension: timesheet_project_fk {
    type: string
    hidden: yes
    sql: ${TABLE}.timesheet_project_fk ;;
  }

  dimension: total_local_amount {
    type: number
    hidden: yes
    sql: ${TABLE}.total_local_amount ;;
  }

  dimension_group: churn {
    type: time
    timeframes: [raw, date, month, quarter, year, quarter_of_year]
    sql: ${TABLE}.last_invoice_month ;;
  }

  dimension_group: cohort {
    type: time
    timeframes: [raw, date, month, quarter, year, quarter_of_year]
    sql: ${TABLE}.first_invoice_month ;;
  }

  dimension_group: expected_payment {
    type: time
    timeframes: [raw, date, month]
    label: "Payment Due"
    group_label: "Invoice Details"
    sql: ${TABLE}.expected_payment_at_ts ;;
  }

  dimension_group: invoice_due {
    type: time
    timeframes: [raw, date, month, quarter, year]
    group_label: "Invoice Details"
    sql: ${TABLE}.invoice_due_at_ts ;;
  }

  dimension_group: invoice_issued {
    type: time
    timeframes: [raw, date, month, quarter, year, month_num]
    label: "Invoice"
    group_label: "Invoice Details"
    sql: ${TABLE}.invoice_issue_at_ts ;;
  }

  dimension_group: invoice_paid {
    type: time
    timeframes: [raw, date]
    group_label: "Invoice Details"
    sql: ${TABLE}.invoice_paid_at_ts ;;
  }

  dimension_group: invoice_payment {
    type: time
    timeframes: [raw, date]
    group_label: "Invoice Details"
    description: "Either the date that payment is expected OR the date that payment has been received - note that if expected payment date is populated that should supercede payment date for unpaid invoices"
    sql: CASE
          WHEN timestamp(${payments_fact.payment_date}) is not null then timestamp(${payments_fact.payment_date})
          WHEN ${TABLE}.expected_payment_at_ts < ${TABLE}.current_timestamp AND ${TABLE}.invoice_due_at_ts < ${TABLE}.current_timestamp THEN ${TABLE}.current_timestamp
          WHEN ${TABLE}.expected_payment_at_ts IS NULL THEN ${TABLE}.invoice_due_at_ts
          ELSE ${TABLE}.expected_payment_at_ts
        END ;;
  }

  measure: count_invoices {
    type: count_distinct
    group_label: "Invoicing"
    sql: ${invoice_pk} ;;
  }

  measure: customer_total_active_months {
    type: count_distinct
    group_label: "RFM"
    hidden: yes
    sql: ${invoice_issued_month} ;;
  }

  measure: invoice_months_recency {
    type: max
    group_label: "RFM"
    hidden: yes
    sql: ${invoice_months_before_now} ;;
    filters: [is_invoice_in_clients_last_12m: "Yes"]
  }

  measure: min_invoice_months_before_now {
    type: min
    group_label: "RFM"
    hidden: yes
    sql: ${invoice_months_before_now} ;;
  }

  measure: total_gross_amount_gbp {
    type: sum
    group_label: "Reporting"
    hidden: yes
    value_format_name: gbp_0
    sql: ${invoice_gbp_amount} ;;
  }

  measure: total_invoice_count_in_clients_last_12m {
    type: count_distinct
    hidden: yes
    sql: ${invoice_pk} ;;
    filters: [is_invoice_in_clients_last_12m: "Yes"]
  }

  measure: total_invoice_gbp_amount_in_clients_last_12m {
    type: sum
    group_label: "RFM"
    hidden: yes
    value_format_name: gbp
    sql: case when ${invoice_currency} = 'USD' then ${TABLE}.invoice_local_total_revenue_amount * 0.75
    when ${invoice_currency} = 'CAD' then ${TABLE}.invoice_local_total_revenue_amount * 0.58
    when ${invoice_currency} = 'EUR' then ${TABLE}.invoice_local_total_revenue_amount * 0.90
    else ${TABLE}.invoice_local_total_revenue_amount  end ;;
    filters: [is_invoice_in_clients_last_12m: "Yes"]
  }

  measure: total_invoice_gross_amount_local {
    type: sum
    group_label: "Invoicing"
    sql: ${total_local_amount} ;;
  }

  measure: total_invoice_net_amount_local {
    type: sum
    group_label: "Invoicing"
    sql: ${total_local_amount} - coalesce(${invoice_local_total_tax_amount},0) ;;
  }

  measure: total_invoice_tax_local {
    type: sum
    group_label: "Invoicing"
    sql: ${invoice_local_total_tax_amount} ;;
  }

  measure: total_invoiced_net_amount_gbp {
    type: sum
    label: "Total Invoiced Revenue GBP"
    group_label: "Invoicing"
    value_format_name: gbp_0
    sql: ${invoice_gbp_amount} - coalesce(${invoice_gbp_tax_amount},0) ;;
    filters: [invoice_status: "Paid,Open,Overdue"]
  }

  measure: total_months_customer {
    type: max
    group_label: "RFM"
    hidden: yes
    sql: ${months_since_first_invoice} ;;
  }

  measure: total_net_amount_gbp {
    type: sum
    label: "Total Revenue GBP"
    group_label: "Invoicing"
    value_format_name: gbp_0
    sql: ${invoice_gbp_amount} - coalesce(${invoice_gbp_tax_amount},0) ;;
  }

  measure: total_tax_gbp {
    type: sum
    group_label: "Reporting"
    hidden: yes
    value_format_name: gbp_0
    sql: ${invoice_gbp_tax_amount} ;;
  }

  measure: total_uninvoiced_net_amount_gbp {
    type: sum
    label: "Total Uninvoiced Revenue GBP"
    group_label: "Invoicing"
    value_format_name: gbp_0
    sql: ${invoice_gbp_amount} - coalesce(${invoice_gbp_tax_amount},0) ;;
    filters: [invoice_status: "Draft"]
  }
}
