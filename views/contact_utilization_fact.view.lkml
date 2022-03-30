# The name of this view in Looker is "Contact Utilization Fact"
view: contact_utilization_fact {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics.contact_utilization_fact`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Actual Billable Hours" in Explore.

  dimension: actual_billable_hours {
    type: number
    hidden: yes
    sql: ${TABLE}.actual_billable_hours ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.



  measure: average_actual_billable_hours {
    label: "    Average Actual Billable Hours"
    value_format_name: decimal_0

    type: average
    sql: ${actual_billable_hours} ;;
  }

  measure: total_actual_billable_hours {
    label: "    Total Actual Billable Hours"
    value_format_name: decimal_0

    type: sum
    sql: ${actual_billable_hours} ;;
  }

  dimension: actual_story_points {
    hidden: yes

    type: number
    sql: ${TABLE}.actual_story_points ;;
  }


  measure: average_actual_story_points {
    label: "Average Actual Story Points"
    value_format_name: decimal_0

    type: average
    sql: ${actual_story_points} ;;
  }

  measure: total_actual_story_points {
    label: "Total Actual Story Points"
    value_format_name: decimal_0

    type: sum
    sql: ${actual_story_points} ;;
  }




  dimension: contact_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_pk ;;
  }

  dimension: forecast_billable_hours {
    type: number
    hidden: yes
    sql: ${TABLE}.forecast_billable_hours ;;
  }

  measure: average_forecast_billable_hours {
    label: "       Average Forecast Billable Hours"
    type: average
    value_format_name: decimal_2

    sql: ${forecast_billable_hours} ;;
  }

  measure: total_forecast_billable_hours {
    label: "       Total Forecast Billable Hours"
    type: sum
    value_format_name: decimal_2

    sql: ${forecast_billable_hours} ;;
  }


  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: forecast {
    label: "               Forecast"
    type: time
    timeframes: [
      week
    ]
    sql: ${TABLE}.forecast_week ;;
  }

  dimension: hours_per_week {
    hidden: yes
    type: number
    sql: ${TABLE}.hours_per_week ;;
  }

  measure: average_hours_per_week {
    label: "             Average Hours Per Week"
    value_format_name: decimal_0

    type: average
    sql: ${hours_per_week} ;;
  }

  measure: total_hours_per_week {
    label: "             Total Hours Per Week"
    value_format_name: decimal_0

    type: sum
    sql: ${hours_per_week} ;;
  }

  dimension: hr_utilization_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: concat(${TABLE}.contact_pk,${TABLE}.forecast_week) ;;
  }

  dimension: target {
    type: number
    hidden: yes
    sql: ${TABLE}.target ;;
  }

  measure: average_target {
    label: "                 Average Target"
    value_format_name: percent_0

    type: average
    sql: ${target} ;;
  }


  dimension: target_billable_capacity {
    type: number
    hidden: yes
    sql: ${TABLE}.target_billable_capacity ;;
  }

  measure: average_target_billable_capacity {
    label: "         Average Target Billable Capacity"
    value_format_name: decimal_0

    type: average
    sql: ${target_billable_capacity} ;;
  }

  measure: total_target_billable_capacity {
    label: "         Total Target Billable Capacity"
    value_format_name: decimal_0

    type: sum
    sql: ${target_billable_capacity} ;;
  }

  dimension: forecast_utilization {
    sql: ${forecast_billable_hours}/${target_billable_capacity} ;;
    hidden: yes
  }

  measure: average_forecast_utilization {
    value_format_name: percent_2
    type: average
    sql: ${forecast_utilization} ;;
  }

  dimension: actual_utilization {
    sql: ${actual_billable_hours}/${target_billable_capacity} ;;
    hidden: yes
  }

  measure: average_actual_utilization {
    value_format_name: percent_2
    type: average
    sql: ${actual_utilization} ;;
  }

  measure: actual_to_forecast_utilization_variance {
    value_format_name: percent_2
    type: average
    sql: ${actual_utilization}-${forecast_utilization} ;;
  }

  measure: actual_to_target_utilization_variance {
    value_format_name: percent_2
    type: average
    sql: ${actual_utilization}-${target} ;;
  }

  dimension: time_off {
    type: number
    hidden: yes
    sql: ${TABLE}.days_off ;;
  }

  measure: average_time_off {
    label: "                  Average Time-Off"
    value_format_name: decimal_0

    type: average
    sql: ${time_off} ;;
  }

  measure: total_time_off {
    label: "                  Total Time-Off"
    value_format_name: decimal_0

    type: sum
    sql: ${time_off} ;;
  }



  dimension: total_capacity {
    hidden: yes
    type: number
    sql: ${TABLE}.total_capacity ;;
  }

  measure: average_total_capacity {
    label: "           Average Total Capacity"
    value_format_name: decimal_0

    type: average
    sql: ${total_capacity} ;;
  }

  measure: total_total_capacity {
    label: "           Total Total Capacity"
    value_format_name: decimal_0

    type: sum
    sql: ${total_capacity} ;;
  }




}
