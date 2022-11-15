# The name of this view in Looker is "Marketing Content Dim"
view: marketing_content_dim {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics.marketing_content_dim`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Interaction Content" in Explore.

  dimension: interaction_content {
    type: string
    sql: ${TABLE}.interaction_content ;;
  }

  dimension: interaction_content_id {
    hidden: yes
    type: string
    sql: ${TABLE}.interaction_content_id ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: interaction_posted_ts {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.interaction_posted_ts ;;
  }

  dimension: interaction_reported_comment_count {
    hidden: yes
    type: number
    sql: ${TABLE}.interaction_reported_comment_count ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.



  dimension: interaction_reported_like_count {
    hidden: no
    label: "Total Likes"

    type: number
    sql: ${TABLE}.interaction_reported_like_count ;;
  }



  dimension: post_url {
    type: string
    sql: ${TABLE}.interaction_content_url ;;
  }

  dimension: article_stub {
    primary_key: yes
    type: string
    sql: case when ${utm_source} = 'medium' then split(${post_url},'/')[safe_offset(4)]
              when ${utm_source} = 'squarespace' then ${post_url} end ;;
  }



  dimension: marketing_content_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.marketing_content_pk ;;
  }

  dimension: post_reported_impression_count  {
    hidden: no
    type:  number
    sql: ${TABLE}.post_reported_impression_count   ;;
  }

  dimension: post_reported_follower_count {
    hidden: yes

    type: number
    sql: ${TABLE}.post_reported_follower_count ;;
  }

  dimension: utm_account {
    type: string
    sql: ${TABLE}.utm_account ;;
  }

  dimension: utm_medium {
    type: string
    sql: ${TABLE}.utm_medium ;;
  }

  dimension: utm_source {
    type: string
    sql: ${TABLE}.utm_source ;;
  }
  measure: total_likes {
    type: sum
    sql: ${interaction_reported_like_count} ;;
    value_format_name: decimal_0
  }

  measure: total_impressions {
    type: sum
    sql: ${post_reported_impression_count} ;;
    value_format_name: decimal_0
  }

  measure: total_comments {
    type: sum
    sql: ${interaction_reported_comment_count} ;;
    value_format_name: decimal_0
  }
  measure: count {
    type: count
    drill_fields: []
  }
}
