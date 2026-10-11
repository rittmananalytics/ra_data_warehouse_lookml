view: bank_transactions_fact {
  sql_table_name: `ra-development.analytics.bank_transactions_fact` ;;

  dimension: account_code {
    hidden: yes
    sql: ${TABLE}.account_code ;;
  }

  dimension: account_id {
    hidden: yes
    sql: ${TABLE}.account_id ;;
  }

  dimension: bank_account_id {
    sql: ${TABLE}.bank_account_id ;;
  }

  dimension: bank_transaction_id {
    sql: ${TABLE}.bank_transaction_id ;;
  }

  dimension: bank_transaction_pk {
    primary_key: yes
    hidden: yes
    sql: concat(${TABLE}.bank_transaction_id,${line_item_id}) ;;
  }

  dimension: contact_id {
    hidden: yes
    sql: ${TABLE}.contact_id ;;
  }

  dimension: currency_code {
    sql: ${TABLE}.currency_code ;;
  }

  dimension: currency_rate {
    sql: ${TABLE}.currency_rate ;;
  }

  dimension: description {
    sql: ${TABLE}.description ;;
  }

  dimension: is_reconciled {
    sql: ${TABLE}.is_reconciled ;;
  }

  dimension: item_code {
    sql: ${TABLE}.item_code ;;
  }

  dimension: line_amount_types {
    sql: ${TABLE}.line_amount_types ;;
  }

  dimension: line_item_id {
    sql: ${TABLE}.line_item_id ;;
  }

  dimension: quantity {
    sql: ${TABLE}.quantity ;;
  }

  dimension: reference {
    sql: ${TABLE}.reference ;;
  }

  dimension: status {
    sql: ${TABLE}.status ;;
  }

  dimension: tax_type {
    sql: ${TABLE}.tax_type ;;
  }

  dimension: type {
    sql: ${TABLE}.type ;;
  }

  dimension: unit_amount {
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
