# The name of this view in Looker is "Sales Targets"
view: sales_targets {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics_seed.sales_targets`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Client Meetings Target Number" in Explore.

  dimension: client_meetings_target_number {
    hidden: yes
    type: number
    sql: ${TABLE}.client_meetings_target_number ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_client_meetings_target_number {
    type: sum
    sql: ${client_meetings_target_number} ;;
  }



  dimension: closed_deals_new_clients_target_number {
    hidden: yes
    type: number
    sql: ${TABLE}.closed_deals_new_clients_target_number ;;
  }

  measure: total_closed_deals_new_clients_target_number {
    type: sum

    sql: ${closed_deals_new_clients_target_number} ;;
  }

  dimension: closed_deals_renewal_clients_target_number {
    hidden: yes

    type: number
    sql: ${TABLE}.closed_deals_renewal_clients_target_number ;;
  }

  measure: total_closed_deals_renewal_clients_target_number {
    type: sum

    sql: ${closed_deals_renewal_clients_target_number} ;;
  }

  dimension: closed_won_target_revenue {
    hidden: yes

    type: number
    sql: ${TABLE}.closed_won_target_revenue ;;
  }

  measure: total_closed_won_target_revenue {
    type: sum

    sql: ${closed_won_target_revenue} ;;
  }

  dimension: closed_won_target_revenue_ben {
    hidden: yes

    type: number
    sql: ${TABLE}.closed_won_target_revenue_ben ;;
  }

  measure: total_closed_won_target_revenue_ben {
    type: sum

    sql: ${closed_won_target_revenue_ben}  ;;
  }

  dimension: closed_won_target_revenue_others {
    hidden: yes

    type: number
    sql: ${TABLE}.closed_won_target_revenue_others ;;
  }

  measure: total_closed_won_target_revenue_others {
    type: sum

    sql: ${closed_won_target_revenue_others} ;;
  }

  dimension: deals_target_revenue {
    hidden: yes

    type: number
    sql: ${TABLE}.deals_target_revenue ;;
  }

  measure: total_deals_target_revenue {
    type: sum

    sql: ${deals_target_revenue} ;;
  }

  dimension: new_deals_target_number {
    hidden: yes

    type: number
    sql: ${TABLE}.new_deals_target_number ;;
  }

  measure: total_new_deals_target_number {
    type: sum

    sql: ${new_deals_target_number} ;;
    }

  dimension: new_mqls_target_number {
    hidden: yes

    type: number
    sql: ${TABLE}.new_mqls_target_number ;;
  }

    measure: total_new_mqls_target_number {
      type: sum

      sql: ${new_mqls_target_number} ;;
    }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: period {
    hidden: yes
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.period ;;
  }

  dimension: pk {
    hidden: yes
    primary_key: yes
    sql: ${period_date} ;;
  }

  dimension: target_revenue {
    type: number
    hidden: yes
    sql: ${TABLE}.target_revenue ;;
  }

    measure: total_target_revenue {
      type: sum
      hidden: yes
      sql: ${target_revenue};;
    }


}
