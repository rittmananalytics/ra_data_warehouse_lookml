# =============================================================================
# FCT_UBER_RIDES - Uber Ride Events
# Grain: One row per ride
# Source: markr-data-lake.mark_dw_warehouse.fct_uber_rides
# =============================================================================

view: fct_uber_rides {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.fct_uber_rides` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: ride_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.ride_pk ;;
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

  dimension: pickup_location_fk {
    type: string
    sql: ${TABLE}.pickup_location_fk ;;
    hidden: yes
    description: "Foreign key to dim_location (pickup)"
  }

  dimension: dropoff_location_fk {
    type: string
    sql: ${TABLE}.dropoff_location_fk ;;
    hidden: yes
    description: "Foreign key to dim_location (dropoff)"
  }

  # =============================================================================
  # TIMESTAMP DIMENSIONS
  # =============================================================================

  dimension_group: request {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year, hour_of_day, day_of_week]
    datatype: timestamp
    sql: ${TABLE}.request_ts ;;
    label: "Request"
    description: "Ride request timestamp"
  }

  # =============================================================================
  # RIDE DIMENSIONS
  # =============================================================================

  dimension: city_name {
    type: string
    sql: ${TABLE}.city_name ;;
    label: "City"
    description: "City name"
  }

  dimension: pickup_address {
    type: string
    sql: ${TABLE}.pickup_address ;;
    label: "Pickup Address"
    description: "Pickup address"
  }

  dimension: dropoff_address {
    type: string
    sql: ${TABLE}.dropoff_address ;;
    label: "Dropoff Address"
    description: "Dropoff address"
  }

  dimension: fare_amount_gbp {
    type: number
    sql: ${TABLE}.fare_amount_gbp ;;
    label: "Fare"
    value_format_name: gbp
    description: "Fare amount in GBP"
  }

  # =============================================================================
  # RIDE FLAGS
  # =============================================================================

  dimension: is_completed {
    type: yesno
    sql: ${TABLE}.is_completed ;;
    label: "Is Completed"
    description: "TRUE if ride completed"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Ride Count"
    drill_fields: [request_date, city_name, pickup_address, dropoff_address, fare_amount_gbp]
  }

  measure: completed_rides {
    type: count
    filters: [is_completed: "yes"]
    label: "Completed Rides"
  }

  measure: total_fare {
    type: sum
    sql: ${fare_amount_gbp} ;;
    label: "Total Fare"
    value_format_name: gbp
  }

  measure: avg_fare {
    type: average
    sql: ${fare_amount_gbp} ;;
    label: "Avg Fare"
    value_format_name: gbp
  }

  measure: unique_cities {
    type: count_distinct
    sql: ${city_name} ;;
    label: "Unique Cities"
    description: "Count of distinct cities"
  }
}
