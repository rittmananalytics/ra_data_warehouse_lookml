# =============================================================================
# FCT_SOCIAL_POSTS - Social Media Posts
# Grain: One row per post
# Source: markr-data-lake.mark_dw_warehouse.fct_social_posts
# =============================================================================

view: fct_social_posts {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.fct_social_posts` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: post_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.post_pk ;;
    hidden: yes
    description: "Primary key"
  }

  # =============================================================================
  # FOREIGN KEYS
  # =============================================================================

  dimension: date_fk {
    type: number
    sql: ${TABLE}.date_fk ;;
    hidden: yes
    description: "Foreign key to dim_date"
  }

  dimension: location_fk {
    type: string
    sql: ${TABLE}.location_fk ;;
    hidden: yes
    description: "Foreign key to dim_location"
  }

  # =============================================================================
  # TIMESTAMP DIMENSIONS
  # =============================================================================

  dimension_group: post {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year, hour_of_day, day_of_week]
    datatype: timestamp
    sql: ${TABLE}.post_ts ;;
    label: "Post"
    description: "Post timestamp"
  }

  # =============================================================================
  # POST DIMENSIONS
  # =============================================================================

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
    label: "Platform"
    description: "Facebook"
  }

  dimension: post_content {
    type: string
    sql: ${TABLE}.post_content ;;
    label: "Content"
    description: "Post text content"
  }

  # =============================================================================
  # POST FLAGS
  # =============================================================================

  dimension: is_checkin {
    type: yesno
    sql: ${TABLE}.is_checkin ;;
    label: "Is Check-in"
    description: "TRUE if location check-in"
  }

  dimension: has_location {
    type: yesno
    sql: ${TABLE}.has_location ;;
    label: "Has Location"
    description: "TRUE if has location data"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Post Count"
    drill_fields: [post_date, platform, post_content, is_checkin]
  }

  measure: checkin_count {
    type: count
    filters: [is_checkin: "yes"]
    label: "Check-in Count"
  }

  measure: posts_with_location {
    type: count
    filters: [has_location: "yes"]
    label: "Posts with Location"
  }
}
