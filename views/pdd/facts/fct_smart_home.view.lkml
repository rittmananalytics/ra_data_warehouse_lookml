# =============================================================================
# FCT_SMART_HOME - Smart Home Events
# Grain: One row per reading/event
# Source: markr-data-lake.mark_dw_warehouse.fct_smart_home
# =============================================================================

view: fct_smart_home {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.fct_smart_home` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: smart_home_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.smart_home_pk ;;
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

  dimension_group: event {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year, hour_of_day]
    datatype: timestamp
    sql: ${TABLE}.event_ts ;;
    label: "Event"
    description: "Event timestamp"
  }

  # =============================================================================
  # EVENT DIMENSIONS
  # =============================================================================

  dimension: event_type {
    type: string
    sql: ${TABLE}.event_type ;;
    label: "Event Type"
    description: "environmental_reading, home_away_change"
  }

  dimension: event_subtype {
    type: string
    sql: ${TABLE}.event_subtype ;;
    label: "Event Subtype"
    description: "hourly, home, away"
  }

  # =============================================================================
  # TEMPERATURE DIMENSIONS
  # =============================================================================

  dimension: indoor_temp_c {
    type: number
    sql: ${TABLE}.indoor_temp_c ;;
    label: "Indoor Temp (C)"
    value_format_name: decimal_1
    group_label: "Temperature"
    description: "Indoor temperature (Celsius)"
  }

  dimension: outdoor_temp_c {
    type: number
    sql: ${TABLE}.outdoor_temp_c ;;
    label: "Outdoor Temp (C)"
    value_format_name: decimal_1
    group_label: "Temperature"
    description: "Outdoor temperature (Celsius)"
  }

  dimension: indoor_humidity_pct {
    type: number
    sql: ${TABLE}.indoor_humidity_pct ;;
    label: "Humidity %"
    value_format_name: decimal_0
    group_label: "Temperature"
    description: "Indoor humidity percentage"
  }

  # =============================================================================
  # HOME/HEATING FLAGS
  # =============================================================================

  dimension: is_heating_active {
    type: yesno
    sql: ${TABLE}.is_heating_active ;;
    label: "Is Heating Active"
    description: "TRUE if heating is on"
  }

  dimension: is_home {
    type: yesno
    sql: ${TABLE}.is_home ;;
    label: "Is Home"
    description: "TRUE if home presence"
  }

  dimension: is_away {
    type: yesno
    sql: ${TABLE}.is_away ;;
    label: "Is Away"
    description: "TRUE if away"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Event Count"
    drill_fields: [event_date, event_type, indoor_temp_c, is_home]
  }

  measure: avg_indoor_temp {
    type: average
    sql: ${indoor_temp_c} ;;
    label: "Avg Indoor Temp (C)"
    value_format_name: decimal_1
  }

  measure: min_indoor_temp {
    type: min
    sql: ${indoor_temp_c} ;;
    label: "Min Indoor Temp (C)"
    value_format_name: decimal_1
  }

  measure: max_indoor_temp {
    type: max
    sql: ${indoor_temp_c} ;;
    label: "Max Indoor Temp (C)"
    value_format_name: decimal_1
  }

  measure: avg_outdoor_temp {
    type: average
    sql: ${outdoor_temp_c} ;;
    label: "Avg Outdoor Temp (C)"
    value_format_name: decimal_1
  }

  measure: avg_humidity {
    type: average
    sql: ${indoor_humidity_pct} ;;
    label: "Avg Humidity %"
    value_format_name: decimal_0
  }

  measure: heating_active_count {
    type: count
    filters: [is_heating_active: "yes"]
    label: "Heating Active Count"
  }

  measure: heating_active_pct {
    type: number
    sql: SAFE_DIVIDE(${heating_active_count}, ${count}) ;;
    label: "Heating Active %"
    value_format_name: percent_1
    description: "Percentage of readings with heating active"
  }

  measure: home_event_count {
    type: count
    filters: [is_home: "yes"]
    label: "Home Events"
  }

  measure: away_event_count {
    type: count
    filters: [is_away: "yes"]
    label: "Away Events"
  }
}
