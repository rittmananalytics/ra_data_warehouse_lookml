# =============================================================================
# FCT_MUSIC_LIBRARY - Music Library Items
# Grain: One row per track in library
# Source: markr-data-lake.mark_dw_warehouse.fct_music_library
# =============================================================================

view: fct_music_library {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.fct_music_library` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: track_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.track_pk ;;
    hidden: yes
    description: "Primary key"
  }

  # =============================================================================
  # FOREIGN KEYS
  # =============================================================================

  dimension: artist_fk {
    type: string
    sql: ${TABLE}.artist_fk ;;
    hidden: yes
    description: "Foreign key to dim_artist"
  }

  dimension: genre_fk {
    type: string
    sql: ${TABLE}.genre_fk ;;
    hidden: yes
    description: "Foreign key to dim_genre"
  }

  dimension: date_added_fk {
    type: number
    sql: ${TABLE}.date_added_fk ;;
    hidden: yes
    description: "Foreign key to dim_date (date added)"
  }

  # =============================================================================
  # TRACK DIMENSIONS
  # =============================================================================

  dimension: track_name {
    type: string
    sql: ${TABLE}.track_name ;;
    label: "Track"
    description: "Track name"
  }

  dimension: album_name {
    type: string
    sql: ${TABLE}.album_name ;;
    label: "Album"
    description: "Album name"
  }

  dimension: year_released {
    type: number
    sql: ${TABLE}.year_released ;;
    label: "Year Released"
    value_format_name: id
    description: "Release year"
  }

  dimension: duration_ms {
    type: number
    sql: ${TABLE}.duration_ms ;;
    label: "Duration (ms)"
    hidden: yes
    description: "Duration in milliseconds"
  }

  dimension: duration_minutes {
    type: number
    sql: ${TABLE}.duration_minutes ;;
    label: "Duration (min)"
    value_format_name: decimal_1
    description: "Duration in minutes"
  }

  dimension: play_count {
    type: number
    sql: ${TABLE}.play_count ;;
    label: "Play Count"
    description: "Number of plays"
  }

  dimension: rating {
    type: number
    sql: ${TABLE}.rating ;;
    label: "Rating"
    description: "Star rating (0-100)"
  }

  # =============================================================================
  # TRACK FLAGS
  # =============================================================================

  dimension: is_loved {
    type: yesno
    sql: ${TABLE}.is_loved ;;
    label: "Is Loved"
    description: "TRUE if marked as loved"
  }

  dimension: is_apple_music {
    type: yesno
    sql: ${TABLE}.is_apple_music ;;
    label: "Is Apple Music"
    description: "TRUE if from Apple Music"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Track Count"
    drill_fields: [track_name, album_name, dim_artist.artist_name, dim_genre.genre_name, play_count]
  }

  measure: total_play_count {
    type: sum
    sql: ${play_count} ;;
    label: "Total Plays"
    value_format_name: decimal_0
  }

  measure: avg_play_count {
    type: average
    sql: ${play_count} ;;
    label: "Avg Plays"
    value_format_name: decimal_1
  }

  measure: total_duration_hours {
    type: sum
    sql: ${duration_minutes} / 60.0 ;;
    label: "Total Duration (hours)"
    value_format_name: decimal_1
  }

  measure: avg_duration_minutes {
    type: average
    sql: ${duration_minutes} ;;
    label: "Avg Track Duration (min)"
    value_format_name: decimal_1
  }

  measure: loved_track_count {
    type: count
    filters: [is_loved: "yes"]
    label: "Loved Tracks"
  }

  measure: unique_artists {
    type: count_distinct
    sql: ${artist_fk} ;;
    label: "Unique Artists"
  }

  measure: unique_albums {
    type: count_distinct
    sql: ${album_name} ;;
    label: "Unique Albums"
  }
}
