# =============================================================================
# FCT_MESSAGES - Message Events
# Grain: One row per message
# Source: markr-data-lake.mark_dw_warehouse.fct_messages
# =============================================================================

view: fct_messages {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.fct_messages` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: message_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.message_pk ;;
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

  dimension: platform_fk {
    type: string
    sql: ${TABLE}.platform_fk ;;
    hidden: yes
    description: "Foreign key to dim_platform"
  }

  dimension: contact_fk {
    type: string
    sql: ${TABLE}.contact_fk ;;
    hidden: yes
    description: "Foreign key to dim_contact"
  }

  # =============================================================================
  # TIMESTAMP DIMENSIONS
  # =============================================================================

  dimension_group: message {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year, hour_of_day, day_of_week]
    datatype: timestamp
    sql: ${TABLE}.message_ts ;;
    label: "Message"
    description: "Message timestamp"
  }

  # =============================================================================
  # MESSAGE DIMENSIONS
  # =============================================================================

  dimension: word_count {
    type: number
    sql: ${TABLE}.word_count ;;
    label: "Word Count"
    description: "Approximate word count"
  }

  # =============================================================================
  # MESSAGE FLAGS
  # =============================================================================

  dimension: is_sent {
    type: yesno
    sql: ${TABLE}.is_sent ;;
    label: "Is Sent"
    description: "TRUE if sent by Mark"
  }

  dimension: is_received {
    type: yesno
    sql: ${TABLE}.is_received ;;
    label: "Is Received"
    description: "TRUE if received by Mark"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Message Count"
    drill_fields: [message_date, dim_platform.platform_name, dim_contact.contact_name, is_sent]
  }

  measure: messages_sent {
    type: count
    filters: [is_sent: "yes"]
    label: "Messages Sent"
  }

  measure: messages_received {
    type: count
    filters: [is_received: "yes"]
    label: "Messages Received"
  }

  measure: total_word_count {
    type: sum
    sql: ${word_count} ;;
    label: "Total Words"
    value_format_name: decimal_0
  }

  measure: avg_word_count {
    type: average
    sql: ${word_count} ;;
    label: "Avg Words per Message"
    value_format_name: decimal_0
  }
}
