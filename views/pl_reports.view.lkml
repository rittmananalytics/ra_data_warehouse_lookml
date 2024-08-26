# The name of this view in Looker is "Pl Reports"
view: pl_reports {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics_finance_demo.pl_reports_filtered` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date_month {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_month ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Report Analysis" in Explore.

  dimension: report_analysis {
    type: string
    sql: ${TABLE}.report_analysis ;;
  }

  dimension_group: report_created_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.report_created_ts ;;
  }

  dimension: report_data {
    type: string
    sql: ${TABLE}.report_data ;;
  }
  measure: count {
    type: count
  }
}
