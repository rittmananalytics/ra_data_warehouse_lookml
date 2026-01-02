# =============================================================================
# DIM_LOCATION - Locations and Places
# For location and travel analysis
# Source: markr-data-lake.mark_dw_warehouse.dim_location
# =============================================================================

view: dim_location {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.dim_location` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: location_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.location_pk ;;
    hidden: yes
    description: "Primary key (hash of place name + lat/long)"
  }

  # =============================================================================
  # LOCATION DIMENSIONS
  # =============================================================================

  dimension: place_name {
    type: string
    sql: ${TABLE}.place_name ;;
    label: "Place Name"
    description: "Name of place"
  }

  dimension: address {
    type: string
    sql: ${TABLE}.address ;;
    label: "Address"
    description: "Full address"
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    label: "City"
    description: "City name"
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
    label: "Country"
    description: "Country name"
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
    hidden: yes
    description: "Latitude coordinate"
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
    hidden: yes
    description: "Longitude coordinate"
  }

  dimension: location {
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
    label: "Location"
    description: "Map coordinates"
  }

  dimension: semantic_type {
    type: string
    sql: ${TABLE}.semantic_type ;;
    label: "Semantic Type"
    description: "TYPE_HOME, TYPE_WORK, or OTHER"
  }

  dimension: location_category {
    type: string
    sql: ${TABLE}.location_category ;;
    label: "Location Category"
    description: "Location category: Home, Work, Restaurant, Shop, etc."
  }

  # =============================================================================
  # LOCATION FLAGS
  # =============================================================================

  dimension: is_home {
    type: yesno
    sql: ${TABLE}.is_home ;;
    label: "Is Home"
    description: "TRUE if home location"
  }

  dimension: is_work {
    type: yesno
    sql: ${TABLE}.is_work ;;
    label: "Is Work"
    description: "TRUE if work location"
  }

  dimension: is_travel {
    type: yesno
    sql: ${TABLE}.is_travel ;;
    label: "Is Travel"
    description: "TRUE if travel destination"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Location Count"
    drill_fields: [place_name, city, country, location_category]
  }

  measure: unique_cities_count {
    type: count_distinct
    sql: ${city} ;;
    label: "Unique Cities"
    description: "Count of distinct cities"
  }

  measure: unique_countries_count {
    type: count_distinct
    sql: ${country} ;;
    label: "Unique Countries"
    description: "Count of distinct countries"
  }
}
