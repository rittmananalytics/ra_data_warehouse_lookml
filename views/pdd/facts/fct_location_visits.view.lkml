# =============================================================================
# FCT_LOCATION_VISITS - Location Visit Events
# Grain: One row per visit
# Source: markr-data-lake.mark_dw_warehouse.fct_location_visits
# =============================================================================

view: fct_location_visits {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.fct_location_visits` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: visit_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.visit_pk ;;
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

  dimension_group: visit_start {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year, hour_of_day]
    datatype: timestamp
    sql: ${TABLE}.visit_start_ts ;;
    label: "Visit Start"
    description: "Visit start timestamp"
  }

  dimension_group: visit_end {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year, hour_of_day]
    datatype: timestamp
    sql: ${TABLE}.visit_end_ts ;;
    label: "Visit End"
    description: "Visit end timestamp"
  }

  # =============================================================================
  # VISIT DIMENSIONS
  # =============================================================================

  dimension: duration_minutes {
    type: number
    sql: ${TABLE}.duration_minutes ;;
    label: "Duration (min)"
    value_format_name: decimal_0
    description: "Visit duration in minutes"
  }

  dimension: duration_hours {
    type: number
    sql: ${TABLE}.duration_hours ;;
    label: "Duration (hours)"
    value_format_name: decimal_1
    description: "Visit duration in hours"
  }

  # =============================================================================
  # VISIT FLAGS
  # =============================================================================

  dimension: is_home {
    type: yesno
    sql: ${TABLE}.is_home ;;
    label: "Is Home"
    description: "TRUE if home visit"
  }

  dimension: is_work {
    type: yesno
    sql: ${TABLE}.is_work ;;
    label: "Is Work"
    description: "TRUE if work visit"
  }

  dimension: is_travel {
    type: yesno
    sql: ${TABLE}.is_travel ;;
    label: "Is Travel"
    description: "TRUE if travel location"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Visit Count"
    drill_fields: [visit_start_date, dim_location.place_name, duration_hours, is_home]
  }

  measure: total_duration_hours {
    type: sum
    sql: ${duration_hours} ;;
    label: "Total Duration (hours)"
    value_format_name: decimal_1
  }

  measure: avg_duration_hours {
    type: average
    sql: ${duration_hours} ;;
    label: "Avg Duration (hours)"
    value_format_name: decimal_1
  }

  measure: home_hours {
    type: sum
    sql: ${duration_hours} ;;
    filters: [is_home: "yes"]
    label: "Home Hours"
    value_format_name: decimal_1
  }

  measure: away_hours {
    type: sum
    sql: ${duration_hours} ;;
    filters: [is_home: "no"]
    label: "Away Hours"
    value_format_name: decimal_1
  }

  measure: work_hours {
    type: sum
    sql: ${duration_hours} ;;
    filters: [is_work: "yes"]
    label: "Work Hours"
    value_format_name: decimal_1
  }

  measure: travel_hours {
    type: sum
    sql: ${duration_hours} ;;
    filters: [is_travel: "yes"]
    label: "Travel Hours"
    value_format_name: decimal_1
  }

  measure: home_pct {
    type: number
    sql: SAFE_DIVIDE(${home_hours}, ${total_duration_hours}) ;;
    label: "Home %"
    value_format_name: percent_1
    description: "Percentage of time at home"
  }

  measure: away_pct {
    type: number
    sql: SAFE_DIVIDE(${away_hours}, ${total_duration_hours}) ;;
    label: "Away %"
    value_format_name: percent_1
    description: "Percentage of time away"
  }

  measure: unique_places_visited {
    type: count_distinct
    sql: ${location_fk} ;;
    label: "Unique Places"
    description: "Count of distinct places visited"
  }
}
