# =============================================================================
# FCT_SEARCHES - Web Search Events
# Grain: One row per search
# Source: markr-data-lake.mark_dw_warehouse.fct_searches
# =============================================================================

view: fct_searches {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.fct_searches` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: search_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.search_pk ;;
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

  # =============================================================================
  # TIMESTAMP DIMENSIONS
  # =============================================================================

  dimension_group: search {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year, hour_of_day, day_of_week]
    datatype: timestamp
    sql: ${TABLE}.search_ts ;;
    label: "Search"
    description: "Search timestamp"
  }

  # =============================================================================
  # SEARCH DIMENSIONS
  # =============================================================================

  dimension: search_term {
    type: string
    sql: ${TABLE}.search_term ;;
    label: "Search Term"
    description: "Search query"
  }

  dimension: search_source {
    type: string
    sql: ${TABLE}.search_source ;;
    label: "Search Source"
    description: "Google, YouTube"
  }

  dimension: search_category {
    type: string
    sql: ${TABLE}.search_category ;;
    label: "Category"
    description: "Inferred search category/topic"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Search Count"
    drill_fields: [search_date, search_term, search_source, search_category]
  }

  measure: google_searches {
    type: count
    filters: [search_source: "Google"]
    label: "Google Searches"
  }

  measure: youtube_searches {
    type: count
    filters: [search_source: "YouTube"]
    label: "YouTube Searches"
  }

  measure: unique_search_terms {
    type: count_distinct
    sql: ${search_term} ;;
    label: "Unique Search Terms"
  }
}
