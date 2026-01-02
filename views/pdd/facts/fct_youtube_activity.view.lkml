# =============================================================================
# FCT_YOUTUBE_ACTIVITY - YouTube Activity
# Grain: One row per activity (watch, search, visit)
# Source: ra-development.pdd_analytics.digital_activity_fct
# =============================================================================

view: fct_youtube_activity {
  sql_table_name: `ra-development.pdd_analytics.digital_activity_fct` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: activity_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.activity_pk ;;
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

  dimension: time_fk {
    type: number
    sql: ${TABLE}.time_fk ;;
    hidden: yes
    description: "Foreign key to dim_time_of_day"
  }

  dimension: channel_fk {
    type: string
    sql: ${TABLE}.channel_fk ;;
    hidden: yes
    description: "Foreign key to dim_youtube_channel"
  }

  # =============================================================================
  # TIMESTAMP DIMENSIONS
  # =============================================================================

  dimension_group: activity {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year, hour_of_day, day_of_week]
    datatype: timestamp
    sql: ${TABLE}.activity_ts ;;
    label: "Activity"
    description: "Activity timestamp"
  }

  # =============================================================================
  # ACTIVITY DIMENSIONS
  # =============================================================================

  dimension: activity_type {
    type: string
    sql: ${TABLE}.activity_type ;;
    label: "Activity Type"
    description: "Watched, Searched, Visited"
  }

  dimension: video_title {
    type: string
    sql: ${TABLE}.video_title ;;
    label: "Video Title"
    description: "Video title or search query"
  }

  dimension: youtube_url {
    type: string
    sql: ${TABLE}.youtube_url ;;
    label: "URL"
    description: "Video/channel URL"
  }

  dimension: estimated_duration_min {
    type: number
    sql: ${TABLE}.estimated_duration_min ;;
    label: "Est. Duration (min)"
    value_format_name: decimal_0
    description: "Estimated watch duration (minutes)"
  }

  # =============================================================================
  # ACTIVITY FLAGS
  # =============================================================================

  dimension: is_watched {
    type: yesno
    sql: ${TABLE}.is_watched ;;
    label: "Is Watched"
    description: "TRUE if watched video"
  }

  dimension: is_searched {
    type: yesno
    sql: ${TABLE}.is_searched ;;
    label: "Is Searched"
    description: "TRUE if search activity"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Activity Count"
    drill_fields: [activity_date, activity_type, video_title, dim_youtube_channel.channel_name]
  }

  measure: videos_watched {
    type: count
    filters: [is_watched: "yes"]
    label: "Videos Watched"
  }

  measure: searches {
    type: count
    filters: [is_searched: "yes"]
    label: "Searches"
  }

  measure: total_watch_minutes {
    type: sum
    sql: ${estimated_duration_min} ;;
    filters: [is_watched: "yes"]
    label: "Total Watch Time (min)"
    value_format_name: decimal_0
  }

  measure: total_watch_hours {
    type: sum
    sql: ${estimated_duration_min} / 60.0 ;;
    filters: [is_watched: "yes"]
    label: "Total Watch Time (hours)"
    value_format_name: decimal_1
  }

  measure: avg_watch_minutes {
    type: average
    sql: ${estimated_duration_min} ;;
    filters: [is_watched: "yes"]
    label: "Avg Watch Time (min)"
    value_format_name: decimal_0
  }

  measure: unique_channels {
    type: count_distinct
    sql: ${channel_fk} ;;
    label: "Unique Channels"
  }
}
