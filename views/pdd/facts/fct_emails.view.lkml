# =============================================================================
# FCT_EMAILS - Email Events
# Grain: One row per email
# Source: markr-data-lake.mark_dw_warehouse.fct_emails
# =============================================================================

view: fct_emails {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.fct_emails` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: email_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.email_pk ;;
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

  dimension: contact_from_fk {
    type: string
    sql: ${TABLE}.contact_from_fk ;;
    hidden: yes
    description: "Foreign key to dim_contact (sender)"
  }

  dimension: contact_to_fk {
    type: string
    sql: ${TABLE}.contact_to_fk ;;
    hidden: yes
    description: "Foreign key to dim_contact (recipient)"
  }

  # =============================================================================
  # TIMESTAMP DIMENSIONS
  # =============================================================================

  dimension_group: email {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year, hour_of_day, day_of_week]
    datatype: timestamp
    sql: ${TABLE}.email_ts ;;
    label: "Email"
    description: "Email timestamp"
  }

  # =============================================================================
  # EMAIL DIMENSIONS
  # =============================================================================

  dimension: email_subject {
    type: string
    sql: ${TABLE}.email_subject ;;
    label: "Subject"
    description: "Email subject line"
  }

  dimension: word_count {
    type: number
    sql: ${TABLE}.word_count ;;
    label: "Word Count"
    description: "Approximate word count"
  }

  # =============================================================================
  # EMAIL FLAGS
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
    label: "Email Count"
    drill_fields: [email_date, email_subject, is_sent, word_count]
  }

  measure: emails_sent {
    type: count
    filters: [is_sent: "yes"]
    label: "Emails Sent"
  }

  measure: emails_received {
    type: count
    filters: [is_received: "yes"]
    label: "Emails Received"
  }

  measure: receive_send_ratio {
    type: number
    sql: SAFE_DIVIDE(${emails_received}, ${emails_sent}) ;;
    label: "Receive/Send Ratio"
    value_format_name: decimal_2
    description: "Ratio of received to sent emails"
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
    label: "Avg Words per Email"
    value_format_name: decimal_0
  }
}
