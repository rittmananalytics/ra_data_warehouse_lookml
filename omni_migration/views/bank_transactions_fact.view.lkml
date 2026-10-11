view: bank_transactions_fact {
  sql_table_name: `ra-development.analytics.bank_transactions_fact` ;;

  dimension: account_code {
    type: string
    hidden: yes
    sql: ${TABLE}.account_code ;;
  }

  dimension: account_id {
    type: string
    hidden: yes
    sql: ${TABLE}.account_id ;;
  }

  dimension: bank_account_id {
    type: string
    sql: ${TABLE}.bank_account_id ;;
  }

  dimension: bank_transaction_id {
    type: string
    sql: ${TABLE}.bank_transaction_id ;;
  }

  dimension: bank_transaction_pk {
    primary_key: yes
    type: string
    hidden: yes
    sql: concat(${TABLE}.bank_transaction_id,${line_item_id}) ;;
  }

  dimension: contact_id {
    type: string
    hidden: yes
    sql: ${TABLE}.contact_id ;;
  }

  dimension: currency_code {
    type: string
    sql: ${TABLE}.currency_code ;;
  }

  dimension: currency_rate {
    type: number
    sql: ${TABLE}.currency_rate ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: is_reconciled {
    type: yesno
    sql: ${TABLE}.is_reconciled ;;
  }

  dimension: item_code {
    type: string
    sql: ${TABLE}.item_code ;;
  }

  dimension: line_amount_types {
    type: string
    sql: ${TABLE}.line_amount_types ;;
  }

  dimension: line_item_id {
    type: string
    sql: ${TABLE}.line_item_id ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: tax_type {
    type: string
    sql: ${TABLE}.tax_type ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: unit_amount {
    type: number
    sql: ${TABLE}.unit_amount ;;
  }

  dimension_group: transaction_ts {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.transaction_ts ;;
  }

  dimension_group: updated_date_utc {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.updated_date_utc ;;
  }

  measure: line_amount {
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.line_amount ;;
  }

  measure: sub_total {
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.sub_total ;;
  }

  measure: tax_amount {
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.tax_amount ;;
  }

  measure: total {
    type: sum
    value_format_name: gbp
    sql: case when ${type} = 'SPEND' then ${TABLE}.total*-1 else ${TABLE}.total end ;;
  }

  measure: total_tax {
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.total_tax ;;
  }
}
