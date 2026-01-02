# =============================================================================
# AGG_MONTHLY_LOCATION - Monthly Location Summary
# Grain: One row per month
# Source: markr-data-lake.mark_dw_warehouse.agg_monthly_location
# =============================================================================

view: agg_monthly_location {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.agg_monthly_location` ;;

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
  # HOME/AWAY DIMENSIONS
  # =============================================================================

  dimension: home_hours {
    type: number
    sql: ${TABLE}.home_hours ;;
    label: "Home Hours"
    value_format_name: decimal_1
    group_label: "Home/Away"
    description: "Hours at home"
  }

  dimension: away_hours {
    type: number
    sql: ${TABLE}.away_hours ;;
    label: "Away Hours"
    value_format_name: decimal_1
    group_label: "Home/Away"
    description: "Hours away"
  }

  dimension: home_pct {
    type: number
    sql: ${TABLE}.home_pct ;;
    label: "Home %"
    value_format_name: percent_1
    group_label: "Home/Away"
    description: "Percentage of time at home"
  }

  dimension: away_pct {
    type: number
    sql: ${TABLE}.away_pct ;;
    label: "Away %"
    value_format_name: percent_1
    group_label: "Home/Away"
    description: "Percentage of time away"
  }

  # =============================================================================
  # TRAVEL DIMENSIONS
  # =============================================================================

  dimension: travel_days {
    type: number
    sql: ${TABLE}.travel_days ;;
    label: "Travel Days"
    value_format_name: decimal_0
    group_label: "Travel"
    description: "Number of travel days"
  }

  dimension: unique_places_visited {
    type: number
    sql: ${TABLE}.unique_places_visited ;;
    label: "Unique Places"
    value_format_name: decimal_0
    group_label: "Travel"
    description: "Unique places visited"
  }

  dimension: unique_cities_visited {
    type: number
    sql: ${TABLE}.unique_cities_visited ;;
    label: "Unique Cities"
    value_format_name: decimal_0
    group_label: "Travel"
    description: "Unique cities visited"
  }

  dimension: unique_countries_visited {
    type: number
    sql: ${TABLE}.unique_countries_visited ;;
    label: "Unique Countries"
    value_format_name: decimal_0
    group_label: "Travel"
    description: "Unique countries visited"
  }

  # =============================================================================
  # UBER DIMENSIONS
  # =============================================================================

  dimension: uber_trips {
    type: number
    sql: ${TABLE}.uber_trips ;;
    label: "Uber Trips"
    value_format_name: decimal_0
    group_label: "Uber"
    description: "Uber trip count"
  }

  dimension: uber_total_gbp {
    type: number
    sql: ${TABLE}.uber_total_gbp ;;
    label: "Uber Total"
    value_format_name: gbp
    group_label: "Uber"
    description: "Uber total spending"
  }

  dimension: uber_avg_fare_gbp {
    type: number
    sql: ${TABLE}.uber_avg_fare_gbp ;;
    label: "Uber Avg Fare"
    value_format_name: gbp
    group_label: "Uber"
    description: "Average Uber fare"
  }

  # =============================================================================
  # COMPARISON DIMENSIONS
  # =============================================================================

  dimension: home_pct_mom_change {
    type: number
    sql: ${TABLE}.home_pct_mom_change ;;
    label: "Home % MoM Change"
    value_format_name: percent_1
    group_label: "Comparisons"
    description: "Month-over-month home % change"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Month Count"
    drill_fields: [year_month, home_pct, travel_days, unique_places_visited]
  }

  measure: sum_home_hours {
    type: sum
    sql: ${home_hours} ;;
    label: "Total Home Hours"
    value_format_name: decimal_1
  }

  measure: sum_away_hours {
    type: sum
    sql: ${away_hours} ;;
    label: "Total Away Hours"
    value_format_name: decimal_1
  }

  measure: avg_home_pct {
    type: average
    sql: ${home_pct} ;;
    label: "Avg Home %"
    value_format_name: percent_1
  }

  measure: sum_travel_days {
    type: sum
    sql: ${travel_days} ;;
    label: "Total Travel Days"
    value_format_name: decimal_0
  }

  measure: sum_unique_places {
    type: sum
    sql: ${unique_places_visited} ;;
    label: "Total Unique Places"
    value_format_name: decimal_0
  }

  measure: sum_uber_trips {
    type: sum
    sql: ${uber_trips} ;;
    label: "Total Uber Trips"
    value_format_name: decimal_0
  }

  measure: sum_uber_spending {
    type: sum
    sql: ${uber_total_gbp} ;;
    label: "Total Uber Spending"
    value_format_name: gbp
  }
}
