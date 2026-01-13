# The name of this view in Looker is "Profit and Loss Report Account Group"
view: profit_and_loss_report_account_group {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics_finance_demo.profit_and_loss_report_account_group` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Account Category" in Explore.

  dimension: account_category {
    type: string
    sql: ${TABLE}.account_category ;;
  }

  dimension: account_report_group {
    type: string
    sql: ${TABLE}.account_report_group ;;
  }

  dimension: account_report_sub_category {
    type: string
    sql: ${TABLE}.account_report_sub_category ;;
  }

  dimension: account_report_sub_category_order {
    type: number
    sql: ${TABLE}.account_report_sub_category_order ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date_month {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_month ;;
  }

  dimension: net_amount {
    type: number
    sql: ${TABLE}.net_amount ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_net_amount {
    type: sum
    sql: ${net_amount} ;;  }
  measure: average_net_amount {
    type: average
    sql: ${net_amount} ;;  }
  measure: count {
    type: count
  }
}
