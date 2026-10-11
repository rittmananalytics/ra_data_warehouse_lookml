view: monzo_bank_transactions_enriched {
  sql_table_name: `ra-development.analytics_seed.monzo_bank_transactions_enriched` ;;
  label: "Bank Transactions"

  dimension: account_code {
    sql: ${TABLE}.account_code ;;
  }

  dimension: account_name {
    sql: ${TABLE}.account_name ;;
  }

  dimension: balance {
    sql: ${TABLE}.balance ;;
  }

  dimension: bank_transaction_id {
    sql: ${TABLE}.bank_transaction_id ;;
  }

  dimension: bank_trx_description {
    sql: ${TABLE}.bank_trx_description ;;
  }

  dimension: currency {
    sql: ${TABLE}.Currency ;;
  }

  dimension: local_amount {
    sql: ${TABLE}.Local_amount ;;
  }

  dimension: local_currency {
    sql: ${TABLE}.Local_currency ;;
  }

  dimension: payer_payee_address {
    sql: ${TABLE}.payer_payee_address ;;
  }

  dimension: payer_payee_category {
    sql: ${TABLE}.payer_payee_category ;;
  }

  dimension: payer_payee_name {
    sql: ${TABLE}.payer_payee_name ;;
  }

  dimension: receipt {
    sql: ${TABLE}.Receipt ;;
  }

  dimension: time {
    sql: Time ;;
  }

  dimension: transaction_id {
    sql: ${TABLE}.Transaction_ID ;;
  }

  dimension: trx_seq {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.trx_seq ;;
  }

  dimension: xero_description {
    sql: ${TABLE}.xero_description ;;
  }

  dimension_group: transaction_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year, day_of_month, month_num]
    convert_tz: no
    label: "Date"
    sql: Date ;;
  }

  measure: amount {
    type: sum
    label: "Amount"
    value_format_name: gbp
    sql: ${TABLE}.amount ;;
  }

  measure: average_of_balance {
    type: average
    label: "Average of Balance"
    description: "Looker custom measure on dashboard 409 tile 3850 (average of balance)"
    value_format_name: gbp_0
    sql: ${balance} ;;
  }

  measure: count {
    type: count
  }

  measure: max_of_balance {
    type: max
    label: "Max of Balance"
    description: "Looker custom measure on dashboard 409 tile 3850 (max of balance)"
    value_format_name: gbp_0
    sql: ${balance} ;;
  }

  measure: min_of_balance {
    type: min
    label: "Min of Balance"
    description: "Looker custom measure on dashboard 409 tile 3850 (min of balance)"
    value_format_name: gbp_0
    sql: ${balance} ;;
  }
}
