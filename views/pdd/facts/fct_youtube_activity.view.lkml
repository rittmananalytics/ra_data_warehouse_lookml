# =============================================================================
# FCT_YOUTUBE_ACTIVITY - Digital Activity (YouTube, Search, etc.)
# Grain: One row per activity (watch, search, browse)
# Source: ra-development.pdd_analytics.digital_activity_fct
# =============================================================================

view: fct_youtube_activity {
  sql_table_name: `ra-development.pdd_analytics.digital_activity_fct` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: activity_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.activity_id ;;
    hidden: yes
    description: "Primary key"
  }

  # =============================================================================
  # FOREIGN KEYS
  # =============================================================================

  dimension: date_key {
    type: number
    sql: ${TABLE}.date_key ;;
    hidden: yes
    description: "Foreign key to date_dim"
  }

  dimension: time_key {
    type: number
    sql: ${TABLE}.time_key ;;
    hidden: yes
    description: "Foreign key to time_dim"
  }

  dimension: content_type_key {
    type: string
    sql: ${TABLE}.content_type_key ;;
    hidden: yes
    description: "Foreign key to content_type_dim"
  }

  # =============================================================================
  # TIMESTAMP DIMENSIONS
  # =============================================================================

  dimension_group: activity {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.activity_date ;;
    label: "Activity"
    description: "Activity date"
  }

  dimension_group: activity_at {
    type: time
    timeframes: [raw, time, date, hour_of_day, day_of_week]
    datatype: timestamp
    sql: ${TABLE}.activity_at ;;
    label: "Activity Time"
    description: "Activity timestamp"
  }

  # =============================================================================
  # ACTIVITY DIMENSIONS
  # =============================================================================

  dimension: source_system {
    type: string
    sql: ${TABLE}.source_system ;;
    label: "Source"
    description: "Data source"
  }

  dimension: source_name {
    type: string
    sql: ${TABLE}.source_name ;;
    label: "Source Name"
    description: "Specific source name"
  }

  dimension: activity_title {
    type: string
    sql: ${TABLE}.activity_title ;;
    label: "Title"
    description: "Activity title/query"
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
    label: "URL"
    description: "Activity URL"
  }

  dimension: domain {
    type: string
    sql: ${TABLE}.domain ;;
    label: "Domain"
    description: "Website domain"
  }

  dimension: activity_type {
    type: string
    sql: ${TABLE}.activity_type ;;
    label: "Activity Type"
    description: "Type of digital activity"
  }

  dimension: url_length {
    type: number
    sql: ${TABLE}.url_length ;;
    label: "URL Length"
    value_format_name: decimal_0
    description: "Length of URL"
  }

  dimension: url_depth {
    type: number
    sql: ${TABLE}.url_depth ;;
    label: "URL Depth"
    value_format_name: decimal_0
    description: "Depth of URL path"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Activity Count"
    drill_fields: [activity_date, activity_type, activity_title, domain]
  }

  measure: unique_domains {
    type: count_distinct
    sql: ${domain} ;;
    label: "Unique Domains"
  }

  measure: unique_activities {
    type: count_distinct
    sql: ${activity_title} ;;
    label: "Unique Activities"
  }

  measure: avg_url_depth {
    type: average
    sql: ${url_depth} ;;
    label: "Avg URL Depth"
    value_format_name: decimal_1
  }
}
