# The name of this view in Looker is "Payments Fact"
view: payments_fact {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics.payments_fact`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Account ID" in Explore.

  dimension: account_id {
    hidden: yes
    type: string
    sql: ${TABLE}.account_id ;;
  }

  dimension: company_id {
    hidden: yes

    type: string
    sql: ${TABLE}.company_id ;;
  }

  dimension: currency_code {
    hidden: yes

    type: string
    sql: ${TABLE}.currency_code ;;
  }

  dimension: invoice_id {
    hidden: yes

    type: string
    sql: ${TABLE}.invoice_id ;;
  }

  dimension: invoice_number {
    hidden: yes

    type: string
    sql: ${TABLE}.invoice_number ;;
  }

  dimension: payment_invoice_fk {
    type: string
    hidden: yes
    sql: ${TABLE}.payment_invoice_fk ;;
  }

  dimension: invoice_type {
    hidden: yes

    type: string
    sql: ${TABLE}.invoice_type ;;
  }

  dimension: payment_amount {
    hidden: yes

    type: number
    sql: safe_cast(${TABLE}.payment_amount as float64);;
  }

  measure: total_payment_amount {
    type: sum
    label: "Payment Amount GBP"
    value_format_name: gbp
    sql: ${TABLE}.payment_amount ;;
  }

  dimension: payment_bank_amount {
    hidden: yes

    type: number
    sql: safe_cast(${TABLE}.payment_bank_amount as float64);;
  }



  dimension: payment_code {
    hidden: yes

    type: string
    sql: ${TABLE}.payment_code ;;
  }

  dimension: payment_currency_rate {
    hidden: yes

    type: string
    sql: ${TABLE}.payment_currency_rate ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: payment {
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
    sql: ${TABLE}.payment_date ;;
  }

  dimension: payment_id {
    hidden: yes

    type: string
    sql: ${TABLE}.payment_id ;;
  }

  dimension: payment_is_discounted {
    hidden: yes

    type: yesno
    sql: ${TABLE}.payment_is_discounted ;;
  }

  dimension: payment_is_reconciled {
    hidden: yes

    type: yesno
    sql: ${TABLE}.payment_is_reconciled ;;
  }

  dimension: payment_pk {
    hidden: yes
    type: string
    primary_key: yes
    sql: ${TABLE}.payment_pk ;;
  }

  dimension: payment_reference {
    hidden: yes

    type: string
    sql: ${TABLE}.payment_reference ;;
  }

  dimension: payment_status {
    hidden: yes

    type: string
    sql: ${TABLE}.payment_status ;;
  }

  dimension: payment_type {
    hidden: yes

    type: string
    sql: ${TABLE}.payment_type ;;
  }

  dimension: source {
    hidden: yes

    type: string
    sql: ${TABLE}.source ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are count, sum, and average
  # measures for numeric dimensions, but you can also add measures of many different types.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: count {
    hidden: yes

    type: count
    drill_fields: []
  }
}

# These sum and average measures are hidden by default.
# If you want them to show up in your explore, remove hidden: yes.
