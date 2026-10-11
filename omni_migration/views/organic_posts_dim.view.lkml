view: organic_posts_dim {
  sql_table_name: `ra-development.analytics.organic_posts_dim` ;;

  dimension: organic_post_natural_key {
    type: string
    hidden: yes
    sql: ${TABLE}.organic_post_natural_key ;;
  }

  dimension: organic_post_pk {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.organic_post_pk ;;
  }

  dimension: post_content {
    type: string
    sql: ${TABLE}.post_content ;;
  }

  dimension: post_link_url {
    type: string
    sql: ${TABLE}.post_link_url ;;
  }

  dimension: post_title {
    type: string
    sql: ${TABLE}.post_title ;;
  }

  dimension: post_url {
    type: string
    sql: ${TABLE}.post_url ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension_group: post_ts {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    label: "Published"
    sql: ${TABLE}.post_ts ;;
  }
}
