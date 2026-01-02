# =============================================================================
# DIM_GENRE - Music Genres
# For genre-level music analysis
# Source: markr-data-lake.mark_dw_warehouse.dim_genre
# =============================================================================

view: dim_genre {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.dim_genre` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: genre_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.genre_pk ;;
    hidden: yes
    description: "Primary key"
  }

  # =============================================================================
  # GENRE DIMENSIONS
  # =============================================================================

  dimension: genre_name {
    type: string
    sql: ${TABLE}.genre_name ;;
    label: "Genre"
    description: "Genre name"
  }

  dimension: genre_group {
    type: string
    sql: ${TABLE}.genre_group ;;
    label: "Genre Group"
    description: "Parent genre group"
  }

  # =============================================================================
  # GENRE FLAGS
  # =============================================================================

  dimension: is_primary_genre {
    type: yesno
    sql: ${TABLE}.is_primary_genre ;;
    label: "Is Primary Genre"
    description: "TRUE if top-level genre"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Genre Count"
    drill_fields: [genre_name, genre_group]
  }
}
