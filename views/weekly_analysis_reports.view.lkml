# The name of this view in Looker is "Weekly Analysis Reports"
view: weekly_analysis_reports {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics_jds.weekly_analysis_reports` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Analysis" in Explore.

  dimension: analysis {
    type: string
    sql: ${TABLE}.analysis ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension: week {
    type: date
    sql: ${TABLE}.week ;;
    primary_key: yes
  }

  dimension_group: week {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.week ;;
  }

  dimension: weekly_report {
    type: string
    sql: ${TABLE}.weekly_report ;;
  }
  measure: count {
    type: count
  }
}
