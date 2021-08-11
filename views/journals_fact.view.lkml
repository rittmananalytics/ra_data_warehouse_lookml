# The name of this view in Looker is "Journals Fact"
view: journals_fact {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics.journals_fact`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Account Code" in Explore.

  dimension: account_code {
    type: string
    sql: ${TABLE}.account_code ;;
  }

  dimension: account_id {
    type: string
    sql: ${TABLE}.account_id ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: account_type {
    type: string
    sql: ${TABLE}.account_type ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: gross_amount {
    type: string
    sql: ${TABLE}.gross_amount ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: journal {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.journal_date ;;
  }

  dimension: journal_id {
    type: string
    sql: ${TABLE}.journal_id ;;
  }

  dimension: journal_line_id {
    type: string
    sql: ${TABLE}.journal_line_id ;;
  }

  dimension: journal_number {
    type: number
    sql: ${TABLE}.journal_number ;;
  }

  dimension: journal_pk {
    type: string
    sql: ${TABLE}.journal_pk ;;
  }

  dimension: net_amount {
    type: string
    sql: ${TABLE}.net_amount ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: source_id {
    type: string
    sql: ${TABLE}.source_id ;;
  }

  dimension: source_type {
    type: string
    sql: ${TABLE}.source_type ;;
  }

  dimension: tax_amount {
    type: string
    sql: ${TABLE}.tax_amount ;;
  }

  dimension: tax_name {
    type: string
    sql: ${TABLE}.tax_name ;;
  }

  dimension: tax_type {
    type: string
    sql: ${TABLE}.tax_type ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are count, sum, and average
  # measures for numeric dimensions, but you can also add measures of many different types.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: count {
    type: count
    drill_fields: [tax_name, account_name]
  }

  # These sum and average measures are hidden by default.
  # If you want them to show up in your explore, remove hidden: yes.

  measure: total_journal_number {
    type: sum
    hidden: yes
    sql: ${journal_number} ;;
  }

  measure: average_journal_number {
    type: average
    hidden: yes
    sql: ${journal_number} ;;
  }
}
