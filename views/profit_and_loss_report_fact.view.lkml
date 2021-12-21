# The name of this view in Looker is "Profit and Loss Report Fact"
view: profit_and_loss_report_fact {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics.profit_and_loss_report_fact`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Account Class" in Explore.

  dimension: account_class {
    hidden: no
    type: string
    sql: ${TABLE}.account_class ;;
  }

  dimension: account_code {
    hidden: yes

    type: string
    sql: ${TABLE}.account_code ;;
  }

  dimension: account_id {
    type: string
    sql: ${TABLE}.account_id ;;
  }

  dimension: account_name {
    hidden: no
    order_by_field: account_report_order
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: account_report_category {
    hidden: no

    type: string
    sql: ${TABLE}.account_report_category ;;
  }

  dimension: account_report_group {
    hidden: no

    type: string
    sql: ${TABLE}.account_report_group ;;
  }

  dimension: account_report_order {
    hidden: no

    type: number
    sql: ${TABLE}.account_report_order ;;
  }

  dimension: account_report_sub_category {
    hidden: no

    type: string
    sql: ${TABLE}.account_report_sub_category ;;
  }

  dimension: account_type {
    hidden: no

    type: string
    sql: ${TABLE}.account_type ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: period {
    type: time
    timeframes: [
      raw,
      month,
      month_num,
      year,
      fiscal_month_num,
      fiscal_quarter_of_year,
      fiscal_quarter,
      fiscal_year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_month ;;
  }

  measure: amount {
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.net_amount ;;
  }



  dimension: profit_and_loss_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.profit_and_loss_pk ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are count, sum, and average
  # measures for numeric dimensions, but you can also add measures of many different types.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.



  # These sum and average measures are hidden by default.
  # If you want them to show up in your explore, remove hidden: yes.


}
