# The name of this view in Looker is "Targets"
view: targets {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics_seed.targets`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Deals Closed Target" in Explore.

  dimension: deals_closed_target {
    type: number
    sql: ${TABLE}.deals_closed_target ;;
  }

  dimension: deals_target {
    type: number
    sql: ${TABLE}.deals_target ;;
  }

  dimension: enps {
    type: number
    sql: ${TABLE}.enps ;;
  }

  dimension_group: period {
    type: time
    timeframes : [month]
    sql: parse_timestamp('%d-%m-%Y', ${TABLE}.month) ;;
  }

  dimension: revenue_target {
    type: number
    sql: ${TABLE}.revenue_target ;;
  }

  dimension: pk {
    type: string
    primary_key: yes
    sql: ${TABLE}.month ;;
  }


  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_revenue_target {
    type: sum
    value_format_name: gbp

    sql: ${revenue_target} ;;
  }

  measure: total_deals_closed_target {
    type: sum
    value_format_name: gbp

    sql: ${deals_closed_target} ;;
  }

  measure: total_deals_target {
    type: sum
    value_format_name: gbp
    sql: ${deals_target} ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
