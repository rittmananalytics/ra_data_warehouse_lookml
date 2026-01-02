# =============================================================================
# AGG_DAILY_SMART_HOME - Daily Smart Home Summary
# Grain: One row per day
# Source: markr-data-lake.mark_dw_warehouse.agg_daily_smart_home
# =============================================================================

view: agg_daily_smart_home {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.agg_daily_smart_home` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: date_fk {
    primary_key: yes
    type: number
    sql: ${TABLE}.date_fk ;;
    hidden: yes
    description: "Foreign key to dim_date"
  }

  # =============================================================================
  # DATE DIMENSION
  # =============================================================================

  dimension_group: full {
    type: time
    timeframes: [raw, date, week, month, quarter, year, day_of_week]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.full_date ;;
    label: "Date"
    description: "Full date"
  }

  # =============================================================================
  # TEMPERATURE DIMENSIONS
  # =============================================================================

  dimension: avg_indoor_temp_c {
    type: number
    sql: ${TABLE}.avg_indoor_temp_c ;;
    label: "Avg Indoor Temp (C)"
    value_format_name: decimal_1
    group_label: "Temperature"
    description: "Average indoor temperature"
  }

  dimension: min_indoor_temp_c {
    type: number
    sql: ${TABLE}.min_indoor_temp_c ;;
    label: "Min Indoor Temp (C)"
    value_format_name: decimal_1
    group_label: "Temperature"
    description: "Minimum indoor temperature"
  }

  dimension: max_indoor_temp_c {
    type: number
    sql: ${TABLE}.max_indoor_temp_c ;;
    label: "Max Indoor Temp (C)"
    value_format_name: decimal_1
    group_label: "Temperature"
    description: "Maximum indoor temperature"
  }

  dimension: avg_outdoor_temp_c {
    type: number
    sql: ${TABLE}.avg_outdoor_temp_c ;;
    label: "Avg Outdoor Temp (C)"
    value_format_name: decimal_1
    group_label: "Temperature"
    description: "Average outdoor temperature"
  }

  dimension: avg_humidity_pct {
    type: number
    sql: ${TABLE}.avg_humidity_pct ;;
    label: "Avg Humidity %"
    value_format_name: decimal_0
    group_label: "Temperature"
    description: "Average humidity"
  }

  # =============================================================================
  # HEATING DIMENSIONS
  # =============================================================================

  dimension: heating_hours {
    type: number
    sql: ${TABLE}.heating_hours ;;
    label: "Heating Hours"
    value_format_name: decimal_1
    group_label: "Heating"
    description: "Hours heating was active"
  }

  # =============================================================================
  # PRESENCE DIMENSIONS
  # =============================================================================

  dimension: home_hours {
    type: number
    sql: ${TABLE}.home_hours ;;
    label: "Home Hours"
    value_format_name: decimal_1
    group_label: "Presence"
    description: "Hours at home"
  }

  dimension: away_hours {
    type: number
    sql: ${TABLE}.away_hours ;;
    label: "Away Hours"
    value_format_name: decimal_1
    group_label: "Presence"
    description: "Hours away"
  }

  dimension: home_pct {
    type: number
    sql: ${TABLE}.home_pct ;;
    label: "Home %"
    value_format_name: percent_1
    group_label: "Presence"
    description: "Percentage of day at home"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Day Count"
    drill_fields: [full_date, avg_indoor_temp_c, home_pct, heating_hours]
  }

  measure: avg_indoor_temp_measure {
    type: average
    sql: ${avg_indoor_temp_c} ;;
    label: "Avg Indoor Temp (C)"
    value_format_name: decimal_1
  }

  measure: avg_outdoor_temp_measure {
    type: average
    sql: ${avg_outdoor_temp_c} ;;
    label: "Avg Outdoor Temp (C)"
    value_format_name: decimal_1
  }

  measure: avg_humidity_measure {
    type: average
    sql: ${avg_humidity_pct} ;;
    label: "Avg Humidity %"
    value_format_name: decimal_0
  }

  measure: sum_heating_hours {
    type: sum
    sql: ${heating_hours} ;;
    label: "Total Heating Hours"
    value_format_name: decimal_1
  }

  measure: avg_daily_heating_hours {
    type: average
    sql: ${heating_hours} ;;
    label: "Avg Daily Heating Hours"
    value_format_name: decimal_1
  }

  measure: sum_home_hours {
    type: sum
    sql: ${home_hours} ;;
    label: "Total Home Hours"
    value_format_name: decimal_1
  }

  measure: avg_home_pct {
    type: average
    sql: ${home_pct} ;;
    label: "Avg Home %"
    value_format_name: percent_1
  }
}
