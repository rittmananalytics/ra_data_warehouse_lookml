# The name of this view in Looker is "Organic Posts Dim"
view: organic_posts_dim {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics.organic_posts_dim` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Organic Post Natural Key" in Explore.

  dimension: organic_post_natural_key {
    hidden: yes

    type: string
    sql: ${TABLE}.organic_post_natural_key ;;
  }

  dimension: organic_post_pk {
    hidden: yes

    type: string
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
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: post_ts {
    label: "Published"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.post_ts ;;
  }

  dimension: post_url {
    type: string
    sql: ${TABLE}.post_url ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

}
