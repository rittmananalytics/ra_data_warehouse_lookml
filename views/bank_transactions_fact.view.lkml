# The name of this view in Looker is "Bank Transactions Fact"
view: bank_transactions_fact {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics.bank_transactions_fact`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Account Code" in Explore.

  dimension: account_code {
    hidden: yes
    type: string
    sql: ${TABLE}.account_code ;;
  }

  dimension: account_id {
    hidden: yes

    type: string
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
    hidden: yes
    primary_key: yes
    type: string
    sql: concat(${TABLE}.bank_transaction_pk,${TABLE}.line_item_id) ;;
  }

  dimension: contact_id {
    hidden: yes

    type: string
    sql: ${TABLE}.contact_id ;;
  }

  dimension: currency_code {
    type: string
    sql: ${TABLE}.currency_code ;;
  }

  dimension: currency_rate {
    type: string
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



  measure: line_amount {
    type: sum
    value_format_name: gbp

    sql: ${TABLE}.line_amount ;;
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
    type: string
    sql: ${TABLE}.quantity ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: tax_type {
    type: string
    sql: ${TABLE}.tax_type ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
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

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: transaction_ts {
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
    sql: ${TABLE}.transaction_ts ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: unit_amount {
    type: number
    sql: ${TABLE}.unit_amount ;;
  }

  dimension_group: updated_date_utc {
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
    sql: ${TABLE}.updated_date_utc ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are count, sum, and average
  # measures for numeric dimensions, but you can also add measures of many different types.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.


}

# These sum and average measures are hidden by default.
# If you want them to show up in your explore, remove hidden: yes.
