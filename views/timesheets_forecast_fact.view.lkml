# The name of this view in Looker is "Timesheets Forecast Fact"
view: timesheets_forecast_fact {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics.timesheets_forecast_fact`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Contact Pk" in Explore.

  dimension: contact_pk {
    type: string
    sql: ${TABLE}.contact_fk ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: forecast_day_ts {
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
    sql: ${TABLE}.forecast_day_ts ;;
  }

  dimension: forecast_days {
    type: number
    sql: ${TABLE}.forecast_days ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_forecast_days {
    type: sum
    sql: ${forecast_days} ;;
  }

  measure: total_forecast_hours {
    type: sum
    sql: ${forecast_days}*8;;

  }

  dimension_group: forecast_start_ts {
    type: time
    timeframes: [date]
    sql: ${TABLE}.forecast_start_ts ;;
  }

  dimension_group: forecast_end_ts {
    type: time
    timeframes: [date]
    sql: ${TABLE}.forecast_end_ts ;;
  }



  dimension: timesheet_forecast_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.timesheet_forecast_pk ;;
  }

  dimension: timesheet_project_pk {
    type: string
    sql: ${TABLE}.timesheet_project_fk ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
