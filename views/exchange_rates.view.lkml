# The name of this view in Looker is "Exchange Rates"
view: exchange_rates {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics_seed.exchange_rates`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Currency Code" in Explore.

  dimension: currency_code {
    type: string
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.CURRENCY_CODE ;;
  }

  dimension: currency_rate {
    type: number
    hidden: yes
    sql: ${TABLE}.CURRENCY_RATE ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.



}
