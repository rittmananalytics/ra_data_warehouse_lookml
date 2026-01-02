# =============================================================================
# AGG_MONTHLY_ENTERTAINMENT - Entertainment Statistics
# Grain: One row per month
# Source: markr-data-lake.mark_dw_warehouse.agg_monthly_entertainment
# =============================================================================

view: agg_monthly_entertainment {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.agg_monthly_entertainment` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: year_month {
    primary_key: yes
    type: string
    sql: ${TABLE}.year_month ;;
    label: "Year-Month"
    description: "Year-Month"
  }

  # =============================================================================
  # MUSIC DIMENSIONS
  # =============================================================================

  dimension: total_tracks {
    type: number
    sql: ${TABLE}.total_tracks ;;
    label: "Total Tracks"
    value_format_name: decimal_0
    group_label: "Music"
    description: "Total tracks in library"
  }

  dimension: total_artists {
    type: number
    sql: ${TABLE}.total_artists ;;
    label: "Total Artists"
    value_format_name: decimal_0
    group_label: "Music"
    description: "Total artists"
  }

  dimension: new_tracks_added {
    type: number
    sql: ${TABLE}.new_tracks_added ;;
    label: "New Tracks Added"
    value_format_name: decimal_0
    group_label: "Music"
    description: "New tracks added this month"
  }

  dimension: new_artists_added {
    type: number
    sql: ${TABLE}.new_artists_added ;;
    label: "New Artists Discovered"
    value_format_name: decimal_0
    group_label: "Music"
    description: "New artists discovered"
  }

  dimension: total_plays {
    type: number
    sql: ${TABLE}.total_plays ;;
    label: "Total Plays"
    value_format_name: decimal_0
    group_label: "Music"
    description: "Total play count"
  }

  # =============================================================================
  # YOUTUBE DIMENSIONS
  # =============================================================================

  dimension: youtube_videos_watched {
    type: number
    sql: ${TABLE}.youtube_videos_watched ;;
    label: "YouTube Videos Watched"
    value_format_name: decimal_0
    group_label: "YouTube"
    description: "YouTube videos watched"
  }

  dimension: youtube_watch_hours {
    type: number
    sql: ${TABLE}.youtube_watch_hours ;;
    label: "YouTube Watch Hours"
    value_format_name: decimal_1
    group_label: "YouTube"
    description: "YouTube watch time (hours)"
  }

  dimension: youtube_searches {
    type: number
    sql: ${TABLE}.youtube_searches ;;
    label: "YouTube Searches"
    value_format_name: decimal_0
    group_label: "YouTube"
    description: "YouTube search count"
  }

  # =============================================================================
  # SEARCH DIMENSIONS
  # =============================================================================

  dimension: google_searches {
    type: number
    sql: ${TABLE}.google_searches ;;
    label: "Google Searches"
    value_format_name: decimal_0
    group_label: "Search"
    description: "Google search count"
  }

  dimension: total_searches {
    type: number
    sql: ${TABLE}.total_searches ;;
    label: "Total Searches"
    value_format_name: decimal_0
    group_label: "Search"
    description: "Total searches"
  }

  # =============================================================================
  # DAILY AVERAGE DIMENSIONS
  # =============================================================================

  dimension: avg_daily_media_hours {
    type: number
    sql: ${TABLE}.avg_daily_media_hours ;;
    label: "Avg Daily Media Hours"
    value_format_name: decimal_1
    description: "Average daily media consumption"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Month Count"
    drill_fields: [year_month, total_tracks, youtube_watch_hours, total_searches]
  }

  measure: sum_tracks {
    type: sum
    sql: ${new_tracks_added} ;;
    label: "Total New Tracks"
    value_format_name: decimal_0
  }

  measure: sum_new_artists {
    type: sum
    sql: ${new_artists_added} ;;
    label: "Total New Artists"
    value_format_name: decimal_0
  }

  measure: sum_plays {
    type: sum
    sql: ${total_plays} ;;
    label: "Total Plays"
    value_format_name: decimal_0
  }

  measure: sum_youtube_videos {
    type: sum
    sql: ${youtube_videos_watched} ;;
    label: "Total YouTube Videos"
    value_format_name: decimal_0
  }

  measure: sum_youtube_hours {
    type: sum
    sql: ${youtube_watch_hours} ;;
    label: "Total YouTube Hours"
    value_format_name: decimal_1
  }

  measure: sum_searches {
    type: sum
    sql: ${total_searches} ;;
    label: "Total Searches"
    value_format_name: decimal_0
  }

  measure: avg_daily_media {
    type: average
    sql: ${avg_daily_media_hours} ;;
    label: "Avg Daily Media Hours"
    value_format_name: decimal_1
  }
}
