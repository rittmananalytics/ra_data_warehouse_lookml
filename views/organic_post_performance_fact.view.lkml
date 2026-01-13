# The name of this view in Looker is "Organic Post Performance Fact"
view: organic_post_performance_fact {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics.organic_post_performance_fact` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Organic Post Fk" in Explore.

  dimension: organic_post_fk {
    hidden: yes

    type: string
    sql: ${TABLE}.organic_post_fk ;;
  }

  dimension: pk {
    type: string
    sql: concat(${organic_post_fk},${post_ts_date} ;;
    primary_key: yes
    hidden: yes
  }

  dimension: organic_post_natural_key {
    hidden: yes
    type: string
    sql: ${TABLE}.organic_post_natural_key ;;
  }

  dimension: post_total_comments {
    hidden: yes

    type: number
    sql: ${TABLE}.post_total_comments ;;
  }

  measure: total_organic_posts {
    value_format_name: decimal_0

    type: count_distinct
    sql: ${organic_post_fk} ;;
  }



  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_post_comments {
    type: sum
    value_format_name: decimal_0
    sql: ${post_total_comments} ;;  }
  measure: total_post_likes {
    value_format_name: decimal_0

    type: average
    sql: ${post_total_likes} ;;  }

  dimension: post_total_likes {
    hidden: yes

    type: number
    sql: ${TABLE}.post_total_likes ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: post_ts {
    hidden: yes
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.post_ts ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

}
