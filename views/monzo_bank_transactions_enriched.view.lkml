# The name of this view in Looker is "Monzo Bank Transactions Enriched"
view: monzo_bank_transactions_enriched {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics_seed.monzo_bank_transactions_enriched` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Account Code" in Explore.

  dimension: account_code {
    type: string
    sql: ${TABLE}.account_code ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }



  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: amount {
    value_format_name: gbp
    type: sum
    sql: ${amount} ;;
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
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Date ;;
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
    type: string
    sql: ${TABLE}.Time ;;
  }

  dimension: transaction_id {
    type: string
    sql: ${TABLE}.Transaction_ID ;;
  }

  dimension: trx_seq {
    primary_key: yes
    type: number
    sql: ${TABLE}.trx_seq ;;
  }

  dimension: xero_description {
    type: string
    sql: ${TABLE}.xero_description ;;
  }
  measure: count {
    type: count
    drill_fields: [payer_payee_name, account_name]
  }
}
