view: payments_fact {
  sql_table_name: `ra-development.analytics.payments_fact` ;;

  dimension: account_id {
    hidden: yes
    sql: ${TABLE}.account_id ;;
  }

  dimension: company_id {
    hidden: yes
    sql: ${TABLE}.company_id ;;
  }

  dimension: currency_code {
    hidden: yes
    sql: ${TABLE}.currency_code ;;
  }

  dimension: invoice_id {
    hidden: yes
    sql: ${TABLE}.invoice_id ;;
  }

  dimension: invoice_number {
    hidden: yes
    sql: ${TABLE}.invoice_number ;;
  }

  dimension: invoice_type {
    hidden: yes
    sql: ${TABLE}.invoice_type ;;
  }

  dimension: payment_amount {
    hidden: yes
    sql: safe_cast(${TABLE}.payment_amount as float64) ;;
  }

  dimension: payment_bank_amount {
    hidden: yes
    sql: safe_cast(${TABLE}.payment_bank_amount as float64) ;;
  }

  dimension: payment_code {
    hidden: yes
    sql: ${TABLE}.payment_code ;;
  }

  dimension: payment_currency_rate {
    hidden: yes
    sql: ${TABLE}.payment_currency_rate ;;
  }

  dimension: payment_id {
    hidden: yes
    sql: ${TABLE}.payment_id ;;
  }

  dimension: payment_invoice_fk {
    hidden: yes
    sql: ${TABLE}.payment_invoice_fk ;;
  }

  dimension: payment_is_discounted {
    hidden: yes
    sql: ${TABLE}.payment_is_discounted ;;
  }

  dimension: payment_is_reconciled {
    hidden: yes
    sql: ${TABLE}.payment_is_reconciled ;;
  }

  dimension: payment_pk {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.payment_pk ;;
  }

  dimension: payment_reference {
    hidden: yes
    sql: ${TABLE}.payment_reference ;;
  }

  dimension: payment_status {
    hidden: yes
    sql: ${TABLE}.payment_status ;;
  }

  dimension: payment_type {
    hidden: yes
    sql: ${TABLE}.payment_type ;;
  }

  dimension: source {
    hidden: yes
    sql: ${TABLE}.source ;;
  }

  dimension_group: payment {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    hidden: yes
    sql: ${TABLE}.payment_date ;;
  }

  measure: count {
    type: count
    hidden: yes
  }

  measure: total_payment_amount {
    type: sum
    label: "Payment Amount GBP"
    value_format_name: gbp
    sql: ${payment_amount} ;;
  }
}
