view: general_ledger_fact {
  sql_table_name: `ra-development.analytics.general_ledger_fact` ;;

  dimension: account_class {
    hidden: yes
    sql: ${TABLE}.account_class ;;
  }

  dimension: account_code {
    hidden: yes
    sql: ${TABLE}.account_code ;;
  }

  dimension: account_id {
    hidden: yes
    sql: ${TABLE}.account_id ;;
  }

  dimension: account_name {
    hidden: yes
    sql: ${TABLE}.account_name ;;
  }

  dimension: account_report_category {
    hidden: yes
    sql: ${TABLE}.account_report_category ;;
  }

  dimension: account_report_group {
    hidden: yes
    sql: ${TABLE}.account_report_group ;;
  }

  dimension: account_report_order {
    hidden: yes
    sql: ${TABLE}.account_report_order ;;
  }

  dimension: account_report_sub_category {
    hidden: yes
    sql: ${TABLE}.account_report_sub_category ;;
  }

  dimension: account_type {
    hidden: yes
    sql: ${TABLE}.account_type ;;
  }

  dimension: bank_transaction_id {
    hidden: yes
    sql: ${TABLE}.bank_transaction_id ;;
  }

  dimension: bank_transfer_id {
    hidden: yes
    sql: ${TABLE}.bank_transfer_id ;;
  }

  dimension: description {
    sql: replace(replace(replace(replace(rtrim(ltrim(initcap(
    ${TABLE}.description)))," Subscription","")," Platform",""),"Hrms Software","Humaans Software"),"Cloud Ngxwwn           Dublin        Irl","Google Cloud") ;;
  }

  dimension: gross_amount {
    hidden: yes
    sql: ${TABLE}.gross_amount ;;
  }

  dimension: invoice_id {
    hidden: yes
    sql: ${TABLE}.invoice_id ;;
  }

  dimension: journal_id {
    sql: ${TABLE}.journal_id ;;
  }

  dimension: journal_line_id {
    hidden: yes
    sql: ${TABLE}.journal_line_id ;;
  }

  dimension: journal_net_amount {
    sql: ${TABLE}.net_amount ;;
  }

  dimension: journal_number {
    hidden: yes
    sql: ${TABLE}.journal_number ;;
  }

  dimension: journal_pk {
    primary_key: yes
    sql: ${TABLE}.journal_pk ;;
  }

  dimension: manual_journal_id {
    hidden: yes
    sql: ${TABLE}.manual_journal_id ;;
  }

  dimension: payment_id {
    hidden: yes
    sql: ${TABLE}.payment_id ;;
  }

  dimension: reference {
    sql: ${TABLE}.reference ;;
  }

  dimension: source_id {
    sql: ${TABLE}.source_id ;;
  }

  dimension: source_type {
    sql: ${TABLE}.source_type ;;
  }

  dimension: tax_name {
    sql: ${TABLE}.tax_name ;;
  }

  dimension: tax_type {
    sql: ${TABLE}.tax_type ;;
  }

  dimension_group: journal {
    type: time
    timeframes: [raw, date, week, month, quarter, year, month_num]
    convert_tz: no
    sql: ${TABLE}.journal_date ;;
  }

  measure: net_amount {
    type: sum
    value_format_name: gbp_0
    sql: coalesce(${TABLE}.net_amount * -1,0) ;;
  }

  measure: tax_amount {
    type: sum
    sql: ${TABLE}.tax_amount ;;
  }
}
