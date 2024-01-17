view: invoices_fact {
  sql_table_name: `{{ _user_attributes['dataset'] }}.invoices_fact`
    ;;



  dimension: company_id {
    hidden: yes
    type: string
    sql: ${TABLE}.company_id ;;
  }

  dimension: company_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.company_fk ;;
  }



  dimension_group: first_invoice {
    type: time
    timeframes: [
      raw,
      month,
      quarter,
      year,
      quarter_of_year,
      fiscal_month_num,
      fiscal_quarter_of_year,
      fiscal_year,
      fiscal_quarter
    ]
    sql: ${TABLE}.first_invoice_month ;;
  }

  dimension_group: last_invoice {
    hidden: yes

    type: time
    timeframes: [
      raw,
      month,
      quarter,
      year,
      quarter_of_year
    ]
    sql: ${TABLE}.last_invoice_month ;;
  }



  dimension_group: invoice {
    label: "      Invoice"
    hidden: yes
    type: time
    timeframes: [
      date,
      year,
      month_num,
      quarter_of_year,
      week,
      month,
       fiscal_month_num,
      fiscal_quarter_of_year,
      fiscal_year,
      fiscal_quarter,
      quarter
    ]
    sql: ${TABLE}.invoice_sent_at_ts ;;
  }

  dimension: invoice_sent_at_ts {
    hidden: yes
    type: date
    sql: ${TABLE}.invoice_sent_at_ts ;;
  }

  measure: customer_total_active_months {
    group_label: "RFM"
    hidden: yes

    type: count_distinct
    sql: ${invoice_issued_month} ;;
  }

  dimension: invoice_creator_users_id {
    hidden: yes
    type: string
    sql: ${TABLE}.invoice_creator_users_id ;;
  }

  dimension: invoice_currency {
    group_label: "        Invoice Details"
    type: string
    sql: ${TABLE}.invoice_currency ;;
  }

  dimension_group: invoice_due {
    group_label: "        Invoice Details"
    hidden: no

    type: time
    timeframes: [
      date,
      month,
      year,
      quarter
    ]
    sql: ${TABLE}.invoice_due_at_ts ;;
  }

  dimension_group: invoice_payment {
    group_label: "        Invoice Details"
    description: "Either the date that payment is expected OR the date that payment has been received - note that if expected payment date is populated that should supercede payment date for unpaid invoices"
    type: time
    hidden: yes

    timeframes: [
      date
    ]
    sql: CASE
          WHEN timestamp(${payments_fact.payment_date}) is not null then timestamp(${payments_fact.payment_date})
          WHEN ${TABLE}.expected_payment_at_ts < current_timestamp AND ${TABLE}.invoice_due_at_ts < current_timestamp THEN current_timestamp
          WHEN ${TABLE}.expected_payment_at_ts IS NULL THEN ${TABLE}.invoice_due_at_ts
          ELSE ${TABLE}.expected_payment_at_ts
        END;;
      }

  dimension_group: invoice_issued {
    hidden: no
    label: "Revenue"
    group_label: "Revenue Dates"
    type: time
    timeframes: [
      date,
      month,
      month_num,
      quarter,
      year,
      week,
      fiscal_month_num,
      fiscal_quarter,
      fiscal_quarter_of_year,
      fiscal_year
    ]
    sql: ${TABLE}.invoice_issue_at_ts ;;
  }

  dimension_group: expected_payment {
    group_label: "        Invoice Details"
    label: "Payment Due"

    hidden: no
    type: time
    timeframes: [
      date,
      month
    ]
    sql: ${TABLE}.expected_payment_at_ts ;;
  }

  #dimension: invoice_local_total_billed_amount {
  #  hidden: yes
  #  type: number
  #  sql: ${TABLE}.invoice_local_total_billed_amount ;;
  #}

  #dimension: invoice_local_total_due_amount {
  #  hidden: yes
   # type: number
  #  sql: ${TABLE}.invoice_local_total_due_amount ;;
  #}

  #dimension: invoice_local_total_expenses_amount {
  #  hidden: yes
  #  type: number
  #  sql: ${TABLE}.invoice_local_total_expenses_amount ;;
  #}

  #dimension: invoice_local_total_licence_referral_fee_amount {
   # hidden: yes
  #  type: number
  #  sql: ${TABLE}.invoice_local_total_licence_referral_fee_amount ;;
  #}





  measure: invoice_gbp_revenue_amount {
    hidden: yes
    value_format_name: gbp
    type: sum
    sql: case when lower(${TABLE}.invoice_status) in ('open','paid') then
          case when ${TABLE}.invoice_currency = 'USD' then ${TABLE}.invoice_local_total_revenue_amount * 0.73
                when ${TABLE}.invoice_currency = 'CAD' then ${TABLE}.invoice_local_total_revenue_amount * 0.57
                when ${TABLE}.invoice_currency = 'EUR' then ${TABLE}.invoice_local_total_revenue_amount * 0.85
                else ${TABLE}.invoice_local_total_revenue_amount   end
          end;;
  }

  #dimension: invoice_local_total_services_amount {
  #  hidden: yes
  #  type: number
  #  sql: ${TABLE}.invoice_local_total_services_amount ;;
  #}

  #measure: invoice_local_services_amoun {
  #  hidden: yes
  #  type: sum
  #  sql: ${TABLE}.invoice_local_total_services_amount ;;
  #}

  #dimension: invoice_local_total_support_amount {
  #  hidden: yes
  #  type: number
  #  sql: ${TABLE}.invoice_local_total_support_amount ;;
  #}

















  dimension: invoice_number {
    group_label: "        Invoice Details"
    hidden: yes

    type: string
    sql: ${TABLE}.invoice_number ;;
  }

  dimension_group: invoice_paid {
    group_label: "        Invoice Details"
    hidden: yes

    type: time
    timeframes: [
      date
    ]
    sql: ${TABLE}.invoice_paid_at_ts ;;
  }

  dimension: invoice_payment_term {
    group_label: "        Invoice Details"
    hidden: yes

    type: string
    sql: ${TABLE}.invoice_payment_term ;;
  }

  dimension_group: invoice_period_end_at_ts {
    hidden: yes

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
    hidden: yes

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
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.invoice_pk ;;
  }

  dimension_group: invoice_sent_at_ts {
    hidden: yes
    label: "Invoice"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      fiscal_month_num,
      fiscal_quarter,
      fiscal_quarter_of_year,
      fiscal_year
    ]
    sql: ${TABLE}.invoice_sent_at_ts ;;
  }

  dimension: invoice_seq {
    group_label: "        Invoice Details"

    type: number
    sql: ${TABLE}.invoice_seq ;;
  }

  dimension: invoice_status {
    group_label: "        Invoice Details"

    type: string
    sql: ${TABLE}.invoice_status ;;
  }

  dimension: invoice_subject {
    group_label: "        Invoice Details"

    type: string
    sql: ${TABLE}.invoice_subject ;;
  }

  dimension: invoice_tax_rate_pct {
    group_label: "        Invoice Details"
    hidden: yes
    type: number
    sql: ${TABLE}.invoice_tax_rate_pct ;;
  }

  dimension: invoice_total_days_overdue {
    hidden: yes

    type: number
    sql: ${TABLE}.invoice_total_days_overdue ;;
  }

  dimension: invoice_total_days_to_pay {
    hidden: yes

    type: number
    sql: ${TABLE}.invoice_total_days_to_pay ;;
  }

  dimension: invoice_total_days_variance_on_payment_terms {
    hidden: yes

    type: number
    sql: ${TABLE}.invoice_total_days_variance_on_payment_terms ;;
  }

  dimension: invoice_type {
    group_label: "        Invoice Details"

    type: string
    sql: ${TABLE}.invoice_type ;;
  }

  dimension: months_since_first_invoice {
    group_label: "        Invoice Details"
    hidden: no

    type: number
    sql: ${TABLE}.months_since_first_invoice ;;
  }

  dimension: months_before_last_invoice {
    group_label: "        Invoice Details"
    hidden: yes

    type: number
    sql: ${TABLE}.months_before_last_invoice ;;
  }

  dimension: is_invoice_in_clients_last_12m {
    group_label: "        Invoice Details"
    hidden: yes

    type: yesno
    sql: ${months_before_last_invoice} < 12 ;;
  }







  measure: invoice_months_recency {
    group_label: "RFM"
    hidden: yes

    type: max
    sql: ${TABLE}.invoice_months_before_now ;;
    filters: [is_invoice_in_clients_last_12m: "Yes"]
  }

  dimension: invoice_months_before_now {
    group_label: "      Invoice Details"
    hidden: yes

    type: number
    sql: ${TABLE}.invoice_months_before_now ;;
  }

  measure: min_invoice_months_before_now {
    group_label: "RFM"
    hidden: yes

    type: min
    sql: ${invoice_months_before_now} ;;
  }

  measure: total_invoice_gbp_amount_in_clients_last_12m {
    value_format_name: gbp
    group_label: "RFM"
    hidden: yes

    type: sum
    sql: case when ${TABLE}.invoice_currency = 'USD' then ${TABLE}.invoice_local_total_revenue_amount * 0.75
    when ${TABLE}.invoice_currency = 'CAD' then ${TABLE}.invoice_local_total_revenue_amount * 0.58
    when ${TABLE}.invoice_currency = 'EUR' then ${TABLE}.invoice_local_total_revenue_amount * 0.90
    else ${TABLE}.invoice_local_total_revenue_amount  end;;
    filters: [is_invoice_in_clients_last_12m: "Yes"]
  }



  measure: total_months_customer {
    group_label: "RFM"
    hidden: yes

    type: max
    sql: ${months_since_first_invoice} ;;
  }

  dimension: project_id {
    hidden: yes

    type: string
    sql: ${TABLE}.project_id ;;
  }

  dimension: quarters_since_first_invoice {
    group_label: "      Invoice Details"
    hidden: yes

    type: number
    sql: ${TABLE}.quarters_since_first_invoice ;;
  }

  dimension: timesheet_project_fk {
    hidden: yes

    type: string
    sql: ${TABLE}.timesheet_project_fk ;;
  }

  dimension: total_local_amount {
    hidden: yes

    type: number
    sql: ${TABLE}.total_local_amount ;;
  }

  dimension: invoice_local_total_revenue_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.invoice_local_total_revenue_amount ;;
  }


  dimension: invoice_gbp_amount {
    hidden: yes
    type: number
    value_format_name: gbp_0
    sql: case when ${TABLE}.total_gbp_amount is null then ${TABLE}.total_local_amount / ${exchange_rates.currency_rate} else ${TABLE}.total_gbp_amount end;;
  }

  dimension: invoice_local_total_tax_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.total_local_amount * (safe_cast(${TABLE}.invoice_tax_rate_pct as float64) / 100) ;;
  }

  dimension: invoice_currency_rate {
    hidden: yes

    type: number
    sql: case when ${TABLE}.invoice_currency_rate is null or ${TABLE}.invoice_currency_rate = 0 then ${exchange_rates.currency_rate} else ${TABLE}.invoice_currency_rate end ;;
  }


  dimension: invoice_gbp_tax_amount {
    hidden: yes
    type: number
    value_format_name: gbp
    sql: ${invoice_gbp_amount} * (safe_cast(${TABLE}.invoice_tax_rate_pct as float64) / 100) ;;

  }

  dimension: invoice_gbp_net_amount {
    hidden: yes
    type: number
    sql: ${invoice_gbp_amount} ;;
  }








  measure: total_gross_amount_local {
    group_label: "Reporting"

    hidden: yes
    type: sum
    sql: ${TABLE}.total_local_amount ;;
  }

  measure: total_tax_local {
    group_label: "Reporting"

    hidden: yes
    type: sum
    sql: ${invoice_local_total_tax_amount};;
  }

  measure: total_net_amount_local {
    group_label: "Reporting"

    hidden: yes
    type: sum
    sql: ${total_local_amount} - coalesce(${invoice_local_total_tax_amount},0);;
  }

  measure: total_gross_amount_gbp {
    group_label: "Reporting"

    hidden: yes
    type: sum
    value_format_name: gbp_0
    sql: ${invoice_gbp_amount} ;;
  }

  measure: total_tax_gbp {
    group_label: "Reporting"
    hidden: yes
    type: sum
    value_format_name: gbp_0
    sql: ${invoice_gbp_tax_amount} ;;
  }

  measure: total_net_amount_gbp {
    label: "Total Revenue GBP"

    hidden: no
    type: sum
    value_format_name: gbp_0
    sql: ${invoice_gbp_amount} - coalesce(${invoice_gbp_tax_amount},0);;
  }

  measure: total_invoiced_net_amount_gbp {
    label: "Total Invoiced Revenue GBP"
    type: sum
    value_format_name: gbp_0
    sql: ${invoice_gbp_amount} - coalesce(${invoice_gbp_tax_amount},0);;
    filters: [invoice_status : "Paid, Open"]
  }

  measure: total_uninvoiced_net_amount_gbp {
    label: "Total Uninvoiced Revenue GBP"
    type: sum
    value_format_name: gbp_0
    sql: ${invoice_gbp_amount} - coalesce(${invoice_gbp_tax_amount},0);;
    filters: [invoice_status : "Draft"]
  }

  measure: count_invoices {
    hidden: yes

    type: count_distinct
    sql: ${TABLE}.invoice_pk ;;

  }

  measure: total_invoice_count_in_clients_last_12m {
    hidden: yes
    type: count_distinct
    sql: ${TABLE}.invoice_pk ;;
    filters: [is_invoice_in_clients_last_12m: "Yes"]
  }
}
