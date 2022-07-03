# The name of this view in Looker is "Certification Progress"
view: certification_progress {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics_seed.certification_progress`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Month" in Explore.

  dimension: month {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.month ;;
  }

  dimension_group: progress {
    type: time
    timeframes: [month]
    sql: parse_timestamp('%b-%Y',${TABLE}.month);;
  }



  dimension: score {
    type: number
    sql: ${TABLE}.score ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_score {
    type: sum
    sql: ${score} ;;
  }

  measure: score_target {
    type: average
    sql: ${target} ;;
  }

  dimension: target {
    type: number
    sql: ${TABLE}.target ;;
  }


}
