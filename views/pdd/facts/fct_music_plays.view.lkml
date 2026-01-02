# =============================================================================
# FCT_MUSIC_PLAYS - Music Listening Events
# Grain: One row per play (from Last.fm)
# Source: markr-data-lake.mark_dw_warehouse.fct_music_plays
# =============================================================================

view: fct_music_plays {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.fct_music_plays` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: play_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.play_pk ;;
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

  dimension: artist_fk {
    type: string
    sql: ${TABLE}.artist_fk ;;
    hidden: yes
    description: "Foreign key to dim_artist"
  }

  # =============================================================================
  # TIMESTAMP DIMENSIONS
  # =============================================================================

  dimension_group: play {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year, hour_of_day, day_of_week]
    datatype: timestamp
    sql: ${TABLE}.play_ts ;;
    label: "Play"
    description: "Play timestamp"
  }

  # =============================================================================
  # PLAY DIMENSIONS
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

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Play Count"
    drill_fields: [play_date, dim_artist.artist_name, track_name, album_name]
  }

  measure: unique_tracks {
    type: count_distinct
    sql: ${track_name} ;;
    label: "Unique Tracks"
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
