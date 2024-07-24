# The name of this view in Looker is "Performance Narrative Fact"
view: performance_narrative_fact {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics.performance_narrative_fact` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: analysis_month {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.analysis_month ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Delivery Summary" in Explore.

  dimension: delivery_summary {
    type: string
    sql: ${TABLE}.delivery_summary ;;
  }

  dimension: finance_summary {
    type: string
    sql: ${TABLE}.finance_summary ;;
  }

  dimension: overall_summary {
    type: string
    sql: ${TABLE}.overall_summary ;;
    html:<div style="white-space:pre">{{value}}</div>;;
  }

  dimension: sales_marketing_summary {
    type: string
    sql: ${TABLE}.sales_marketing_summary ;;
  }
  measure: count {
    type: count
  }
}
