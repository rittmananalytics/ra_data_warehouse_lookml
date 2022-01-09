view: invoices_fact {
  sql_table_name: `{{ _user_attributes['dataset'] }}.invoices_fact`
    ;;



  dimension: company_id {
    hidden: yes
    type: string
    sql: ${TABLE}.company_id ;;
  }

  dimension: company_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.company_pk ;;
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

  measure: customer_total_active_months {
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

    type: time
    timeframes: [
      date
    ]
    sql: ${TABLE}.invoice_due_at_ts ;;
  }

  dimension_group: invoice_issued {
    hidden: yes

    type: time
    timeframes: [
      date,
      month
    ]
    sql: ${TABLE}.invoice_issue_at_ts ;;
  }

  dimension: invoice_local_total_billed_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.invoice_local_total_billed_amount ;;
  }

  dimension: invoice_local_total_due_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.invoice_local_total_due_amount ;;
  }

  dimension: invoice_local_total_expenses_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.invoice_local_total_expenses_amount ;;
  }

  dimension: invoice_local_total_licence_referral_fee_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.invoice_local_total_licence_referral_fee_amount ;;
  }

  dimension: invoice_local_total_revenue_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.invoice_local_total_revenue_amount ;;
  }

  measure: invoice_local_revenue_amount {
    hidden: no
    type: sum
    sql: ${TABLE}.invoice_local_total_revenue_amount ;;
  }

  measure: invoice_gbp_revenue_amount {
    hidden: no
    value_format_name: gbp
    type: sum
    sql: case when lower(${TABLE}.invoice_status) in ('open','paid') then
          case when ${TABLE}.invoice_currency = 'USD' then ${TABLE}.invoice_local_total_revenue_amount * 0.73
                when ${TABLE}.invoice_currency = 'CAD' then ${TABLE}.invoice_local_total_revenue_amount * 0.57
                when ${TABLE}.invoice_currency = 'EUR' then ${TABLE}.invoice_local_total_revenue_amount * 0.85
                else ${TABLE}.invoice_local_total_revenue_amount   end
          end;;
  }

  dimension: invoice_local_total_services_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.invoice_local_total_services_amount ;;
  }

  measure: invoice_local_services_amoun {
    hidden: yes
    type: sum
    sql: ${TABLE}.invoice_local_total_services_amount ;;
  }

  dimension: invoice_local_total_support_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.invoice_local_total_support_amount ;;
  }

  dimension: invoice_local_total_tax_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.invoice_local_total_tax_amount ;;
  }

  dimension: invoice_number {
    group_label: "        Invoice Details"

    type: string
    sql: ${TABLE}.invoice_number ;;
  }

  dimension_group: invoice_paid {
    group_label: "        Invoice Details"

    type: time
    timeframes: [
      date
    ]
    sql: ${TABLE}.invoice_paid_at_ts ;;
  }

  dimension: invoice_payment_term {
    group_label: "        Invoice Details"

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

    type: string
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
    hidden: yes

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
    type: min
    sql: ${invoice_months_before_now} ;;
  }

  measure: total_invoice_gbp_amount_in_clients_last_12m {
    value_format_name: gbp
    type: sum
    sql: case when ${TABLE}.invoice_currency = 'USD' then ${TABLE}.invoice_local_total_revenue_amount * 0.75
    when ${TABLE}.invoice_currency = 'CAD' then ${TABLE}.invoice_local_total_revenue_amount * 0.58
    when ${TABLE}.invoice_currency = 'EUR' then ${TABLE}.invoice_local_total_revenue_amount * 0.90
    else ${TABLE}.invoice_local_total_revenue_amount  end;;
    filters: [is_invoice_in_clients_last_12m: "Yes"]
  }



  measure: total_months_customer {
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

  dimension: timesheet_project_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.timesheet_project_pk ;;
  }

  dimension: total_local_amount {
    hidden: yes

    type: number
    sql: ${TABLE}.total_local_amount ;;
  }

  measure: count_invoices {
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
