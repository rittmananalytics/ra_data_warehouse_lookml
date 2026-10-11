view: organic_post_performance_fact {
  sql_table_name: `ra-development.analytics.organic_post_performance_fact` ;;

  dimension: organic_post_fk {
    type: string
    hidden: yes
    sql: ${TABLE}.organic_post_fk ;;
  }

  dimension: organic_post_natural_key {
    type: string
    hidden: yes
    sql: ${TABLE}.organic_post_natural_key ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: concat(${organic_post_fk},${post_ts_date}) ;;
  }

  dimension: post_total_comments {
    type: number
    hidden: yes
    sql: ${TABLE}.post_total_comments ;;
  }

  dimension: post_total_likes {
    type: number
    hidden: yes
    sql: ${TABLE}.post_total_likes ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension_group: post_ts {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    hidden: yes
    sql: ${TABLE}.post_ts ;;
  }

  measure: total_organic_posts {
    type: count_distinct
    value_format_name: decimal_0
    sql: ${organic_post_fk} ;;
  }

  measure: total_post_comments {
    type: sum
    value_format_name: decimal_0
    sql: ${post_total_comments} ;;
  }

  measure: total_post_likes {
    type: average
    value_format_name: decimal_0
    sql: ${post_total_likes} ;;
  }
}
