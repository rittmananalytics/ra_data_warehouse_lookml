# =============================================================================
# FCT_MESSAGES - Communications (Messaging focus)
# Grain: One row per message/communication
# Source: ra-development.pdd_analytics.communications_fct
# =============================================================================

view: fct_messages {
  sql_table_name: `ra-development.pdd_analytics.communications_fct` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: communication_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.communication_id ;;
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

  dimension_group: message {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.communication_date ;;
    label: "Message"
    description: "Message date"
  }

  dimension_group: message_at {
    type: time
    timeframes: [raw, time, date, hour_of_day, day_of_week]
    datatype: timestamp
    sql: ${TABLE}.communication_at ;;
    label: "Sent/Received"
    description: "Message timestamp"
  }

  # =============================================================================
  # MESSAGE DIMENSIONS
  # =============================================================================

  dimension: source_system {
    type: string
    sql: ${TABLE}.source_system ;;
    label: "Source"
    description: "Message source system"
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
    label: "Content"
    description: "Message content/title"
  }

  dimension: direction {
    type: string
    sql: ${TABLE}.direction ;;
    label: "Direction"
    description: "sent or received"
  }

  dimension: communication_type {
    type: string
    sql: ${TABLE}.communication_type ;;
    label: "Type"
    description: "Communication type"
  }

  dimension: title_length {
    type: number
    sql: ${TABLE}.title_length ;;
    label: "Message Length"
    value_format_name: decimal_0
    description: "Length of message"
  }

  # =============================================================================
  # MESSAGE FLAGS
  # =============================================================================

  dimension: is_outbound {
    type: yesno
    sql: ${TABLE}.is_outbound = 1 ;;
    label: "Is Sent"
    description: "TRUE if sent by Mark"
  }

  dimension: is_inbound {
    type: yesno
    sql: ${TABLE}.is_inbound = 1 ;;
    label: "Is Received"
    description: "TRUE if received by Mark"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Message Count"
    drill_fields: [message_date, communication_type, direction]
  }

  measure: messages_sent {
    type: count
    filters: [is_outbound: "yes"]
    label: "Messages Sent"
  }

  measure: messages_received {
    type: count
    filters: [is_inbound: "yes"]
    label: "Messages Received"
  }

  measure: avg_message_length {
    type: average
    sql: ${title_length} ;;
    label: "Avg Message Length"
    value_format_name: decimal_0
  }
}
