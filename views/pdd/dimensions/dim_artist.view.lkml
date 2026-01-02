# =============================================================================
# DIM_ARTIST - Music Artists
# For music library analysis with MusicBrainz metadata
# Source: markr-data-lake.mark_dw_warehouse.dim_artist
# =============================================================================

view: dim_artist {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.dim_artist` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: artist_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.artist_pk ;;
    hidden: yes
    description: "Primary key (MusicBrainz ID or hash)"
  }

  # =============================================================================
  # ARTIST DIMENSIONS
  # =============================================================================

  dimension: artist_name {
    type: string
    sql: ${TABLE}.artist_name ;;
    label: "Artist"
    description: "Artist name"
  }

  dimension: mb_artist_id {
    type: string
    sql: ${TABLE}.mb_artist_id ;;
    label: "MusicBrainz ID"
    hidden: yes
    description: "MusicBrainz artist ID"
  }

  dimension: artist_type {
    type: string
    sql: ${TABLE}.artist_type ;;
    label: "Artist Type"
    description: "Person, Group, Orchestra, etc."
  }

  dimension: artist_country {
    type: string
    sql: ${TABLE}.artist_country ;;
    label: "Country"
    description: "Country of origin"
  }

  dimension: artist_country_code {
    type: string
    sql: ${TABLE}.artist_country_code ;;
    label: "Country Code"
    description: "ISO country code"
  }

  dimension: artist_begin_year {
    type: number
    sql: ${TABLE}.artist_begin_year ;;
    label: "Start Year"
    description: "Year artist started/born"
  }

  dimension: artist_end_year {
    type: number
    sql: ${TABLE}.artist_end_year ;;
    label: "End Year"
    description: "Year artist ended (NULL if active)"
  }

  dimension: career_decade {
    type: string
    sql: ${TABLE}.career_decade ;;
    label: "Career Decade"
    description: "Decade artist started (1960s, 1970s, etc.)"
  }

  # =============================================================================
  # ARTIST FLAGS
  # =============================================================================

  dimension: is_active {
    type: yesno
    sql: ${TABLE}.is_active ;;
    label: "Is Active"
    description: "TRUE if still active"
  }

  dimension: is_solo_artist {
    type: yesno
    sql: ${TABLE}.is_solo_artist ;;
    label: "Is Solo Artist"
    description: "TRUE if solo artist (Person)"
  }

  dimension: is_group {
    type: yesno
    sql: ${TABLE}.is_group ;;
    label: "Is Group"
    description: "TRUE if group/band"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Artist Count"
    drill_fields: [artist_name, artist_country, artist_type, career_decade]
  }

  measure: active_artist_count {
    type: count
    label: "Active Artist Count"
    filters: [is_active: "yes"]
  }

  measure: solo_artist_count {
    type: count
    label: "Solo Artist Count"
    filters: [is_solo_artist: "yes"]
  }

  measure: group_count {
    type: count
    label: "Group Count"
    filters: [is_group: "yes"]
  }
}
