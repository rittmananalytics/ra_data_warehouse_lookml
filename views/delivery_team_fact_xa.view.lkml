# The name of this view in Looker is "Delivery Team Fact Xa"
view: delivery_team_fact_xa {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics.delivery_team_fact_xa`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Billable Utilisation Pct" in Explore.

  dimension: billable_utilisation_pct {
    hidden: yes
    type: number
    sql: ${TABLE}.billable_utilisation_pct ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.



  measure: average_billable_utilisation_pct {
    label: "Average Billable Utilization"
    type: average
    sql: ${billable_utilisation_pct} ;;
  }



  dimension: contact_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_pk ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: first_billing {
    type: time
    timeframes: [
      raw,
      date,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.first_billing_date ;;
  }

  dimension: hours_potentially_billable {
    hidden: yes
    type: number
    sql: ${TABLE}.hours_potentially_billable ;;
  }

  dimension: is_current_employee {
    type: yesno
    sql: ${TABLE}.is_current_employee ;;
  }

  dimension: is_employee{
    type: yesno
    sql: true ;;

  }

  dimension_group: last_billing {
    type: time
    hidden: no
    timeframes: [
      raw,

      date,

      month,
      quarter,
      year
    ]
    sql: ${TABLE}.last_billing_date ;;
  }

  dimension: months_employed {
    type: number
    sql: ${TABLE}.months_employed ;;
  }

  dimension: total_billable_hours {
    type: number
    sql: ${TABLE}.total_billable_hours ;;
  }

  dimension: total_clients {
    type: number
    hidden: no
    sql: ${TABLE}.total_clients ;;
  }



  dimension: total_non_billable_hours {
    type: number
    hidden: yes
    sql: ${TABLE}.total_non_billable_hours ;;
  }



  dimension: total_projects {
    type: number
    sql: ${TABLE}.total_projects ;;
  }


  dimension: total_utilisation_pct {
    type: number
    sql: ${TABLE}.total_utilisation_pct ;;
  }

  measure: average_utilisation_pct {
    label: "Average Utilization"

    type: average
    sql: ${TABLE}.total_utilisation_pct ;;
  }


}
