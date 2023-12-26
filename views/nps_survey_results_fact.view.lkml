# The name of this view in Looker is "Nps Survey Results Fact"
view: nps_survey_results_fact {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics.nps_survey_results_fact` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called " Dbt Source Relation" in Explore.


  dimension: contact_email {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_email ;;
  }

  dimension: contact_fk {
    hidden: yes

    type: string
    sql: ${TABLE}.contact_fk ;;
  }

  dimension: company_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.company_fk ;;
  }

  dimension: contact_name {
    type: string
    sql: ${TABLE}.contact_name ;;
  }

  dimension: nps_score {
    type: number
    sql: ${TABLE}.nps_score ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.


  measure: average_nps_score {
    type: average
    sql: ${nps_score} ;;  }

  dimension: nps_sentiment {
    type: string
    sql: ${TABLE}.nps_sentiment ;;
  }

  dimension: nps_survey_feedback {
    type: string
    sql: ${TABLE}.nps_survey_feedback ;;
  }

  dimension: nps_survey_results_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.nps_survey_results_pk ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: nps_survey_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.nps_survey_ts ;;
  }
  measure: count {
    type: count
    drill_fields: [contact_name]
  }
}
