view: organic_posts_dim {
  sql_table_name: `ra-development.analytics.organic_posts_dim` ;;

  dimension: organic_post_natural_key {
    hidden: yes
    sql: ${TABLE}.organic_post_natural_key ;;
  }

  dimension: organic_post_pk {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.organic_post_pk ;;
  }

  dimension: post_content {
    sql: ${TABLE}.post_content ;;
  }

  dimension: post_link_url {
    sql: ${TABLE}.post_link_url ;;
  }

  dimension: post_title {
    sql: ${TABLE}.post_title ;;
  }

  dimension: post_url {
    sql: ${TABLE}.post_url ;;
  }

  dimension: source {
    sql: ${TABLE}.source ;;
  }

  dimension_group: post_ts {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    label: "Published"
    sql: ${TABLE}.post_ts ;;
  }
}
