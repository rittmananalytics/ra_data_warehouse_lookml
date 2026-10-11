view: monzo_bank_transactions_enriched {
  sql_table_name: `ra-development.analytics_seed.monzo_bank_transactions_enriched` ;;
  label: "Bank Transactions"

  dimension: account_code {
    type: string
    sql: ${TABLE}.account_code ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: balance {
    type: number
    sql: ${TABLE}.balance ;;
  }

  dimension: bank_transaction_id {
    type: string
    sql: ${TABLE}.bank_transaction_id ;;
  }

  dimension: bank_trx_description {
    type: string
    sql: ${TABLE}.bank_trx_description ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.Currency ;;
  }

  dimension: local_amount {
    type: number
    sql: ${TABLE}.Local_amount ;;
  }

  dimension: local_currency {
    type: string
    sql: ${TABLE}.Local_currency ;;
  }

  dimension: payer_payee_address {
    type: string
    sql: ${TABLE}.payer_payee_address ;;
  }

  dimension: payer_payee_category {
    type: string
    sql: ${TABLE}.payer_payee_category ;;
  }

  dimension: payer_payee_name {
    type: string
    sql: ${TABLE}.payer_payee_name ;;
  }

  dimension: receipt {
    type: string
    sql: ${TABLE}.Receipt ;;
  }

  dimension: time {
    sql: Time ;;
  }

  dimension: transaction_id {
    type: string
    sql: ${TABLE}.Transaction_ID ;;
  }

  dimension: trx_seq {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.trx_seq ;;
  }

  dimension: xero_description {
    type: string
    sql: ${TABLE}.xero_description ;;
  }

  dimension_group: transaction_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year, day_of_month, month_num]
    datatype: date
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
