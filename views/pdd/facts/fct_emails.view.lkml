# =============================================================================
# FCT_EMAILS - Communications (Email focus)
# Grain: One row per email/communication
# Source: ra-development.pdd_analytics.communications_fct
# =============================================================================

view: fct_emails {
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

  dimension_group: communication {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.communication_date ;;
    label: "Communication"
    description: "Communication date"
  }

  dimension_group: communication_at {
    type: time
    timeframes: [raw, time, date, hour_of_day, day_of_week]
    datatype: timestamp
    sql: ${TABLE}.communication_at ;;
    label: "Sent/Received"
    description: "Communication timestamp"
  }

  # =============================================================================
  # COMMUNICATION DIMENSIONS
  # =============================================================================

  dimension: source_system {
    type: string
    sql: ${TABLE}.source_system ;;
    label: "Source"
    description: "Email source system"
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
    label: "Subject"
    description: "Email subject line"
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

  dimension: folder {
    type: string
    sql: ${TABLE}.folder ;;
    label: "Folder"
    description: "Email folder"
  }

  dimension: from_address {
    type: string
    sql: ${TABLE}.from_address ;;
    label: "From"
    description: "Sender address"
  }

  dimension: title_length {
    type: number
    sql: ${TABLE}.title_length ;;
    label: "Subject Length"
    value_format_name: decimal_0
    description: "Length of subject line"
  }

  # =============================================================================
  # COMMUNICATION FLAGS
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
    label: "Email Count"
    drill_fields: [communication_date, title, direction]
  }

  measure: emails_sent {
    type: count
    filters: [is_outbound: "yes"]
    label: "Emails Sent"
  }

  measure: emails_received {
    type: count
    filters: [is_inbound: "yes"]
    label: "Emails Received"
  }

  measure: receive_send_ratio {
    type: number
    sql: SAFE_DIVIDE(${emails_received}, ${emails_sent}) ;;
    label: "Receive/Send Ratio"
    value_format_name: decimal_2
    description: "Ratio of received to sent emails"
  }

  measure: avg_subject_length {
    type: average
    sql: ${title_length} ;;
    label: "Avg Subject Length"
    value_format_name: decimal_0
  }
}
