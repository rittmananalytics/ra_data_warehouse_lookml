# The name of this view in Looker is "General Ledger Fact"
view: general_ledger_fact {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics.general_ledger_fact`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Account Class" in Explore.

  dimension: account_class {
    type: string
    hidden: yes
    sql: ${TABLE}.account_class ;;
  }

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



  dimension: account_name {
    hidden: yes

    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: account_report_category {
    hidden: yes

    type: string
    sql: ${TABLE}.account_report_category ;;
  }

  dimension: account_report_group {
    hidden: yes

    type: string
    sql: ${TABLE}.account_report_group ;;
  }

  dimension: account_report_order {
    hidden: yes

    type: number
    sql: ${TABLE}.account_report_order ;;
  }

  dimension: account_report_sub_category {
    hidden: yes

    type: string
    sql: ${TABLE}.account_report_sub_category ;;
  }

  dimension: account_type {
    hidden: yes

    type: string
    sql: ${TABLE}.account_type ;;
  }

  dimension: bank_transaction_id {
    hidden: yes

    type: string
    sql: ${TABLE}.bank_transaction_id ;;
  }

  dimension: bank_transfer_id {
    hidden: yes

    type: string
    sql: ${TABLE}.bank_transfer_id ;;
  }



  dimension: description {
    type: string
    sql: replace(replace(replace(replace(rtrim(ltrim(initcap(
    ${TABLE}.description)))," Subscription","")," Platform",""),"Hrms Software","Humaans Software"),"Cloud Ngxwwn           Dublin        Irl","Google Cloud") ;;
  }

  dimension: gross_amount {
    hidden: yes

    type: string
    sql: ${TABLE}.gross_amount ;;
  }

  dimension: invoice_id {
    hidden: yes

    type: string
    sql: ${TABLE}.invoice_id ;;
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
      month_num,
      fiscal_year,
      fiscal_quarter_of_year,
      fiscal_quarter,
      fiscal_month_num,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.journal_date ;;
  }

  dimension: journal_id {
    hidden: no

    type: string
    sql: ${TABLE}.journal_id ;;
  }

  dimension: journal_line_id {
    hidden: yes

    type: string
    sql: ${TABLE}.journal_line_id ;;
  }

  dimension: journal_number {
    hidden: yes

    type: number
    sql: ${TABLE}.journal_number ;;
  }

  dimension: journal_pk {
    hidden: no
    primary_key: yes
    type: string
    sql: ${TABLE}.journal_pk ;;
  }

  dimension: manual_journal_id {
    hidden: yes

    type: string
    sql: ${TABLE}.manual_journal_id ;;
  }

  dimension: journal_net_amount {
    type: number
    sql: ${TABLE}.net_amount ;;
  }

  measure: net_amount {
    type: sum
    sql: coalesce(${TABLE}.net_amount * -1,0);;
    value_format_name: gbp_0
  }

  dimension: payment_id {
    hidden: yes

    type: string
    sql: ${TABLE}.payment_id ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }

  dimension: source_id {
    hidden: no

    type: string
    sql: ${TABLE}.source_id ;;
  }

  dimension: source_type {
    hidden: no

    type: string
    sql: ${TABLE}.source_type ;;
  }

  measure: tax_amount {
    type: sum
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



  # These sum and average measures are hidden by default.
  # If you want them to show up in your explore, remove hidden: yes.


}
