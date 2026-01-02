# =============================================================================
# AGG_DAILY_COMMUNICATION - Daily Communication Summary
# Grain: One row per day
# Source: markr-data-lake.mark_dw_warehouse.agg_daily_communication
# =============================================================================

view: agg_daily_communication {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.agg_daily_communication` ;;

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
  # EMAIL DIMENSIONS
  # =============================================================================

  dimension: emails_received {
    type: number
    sql: ${TABLE}.emails_received ;;
    label: "Emails Received"
    value_format_name: decimal_0
    group_label: "Email"
    description: "Emails received count"
  }

  dimension: emails_sent {
    type: number
    sql: ${TABLE}.emails_sent ;;
    label: "Emails Sent"
    value_format_name: decimal_0
    group_label: "Email"
    description: "Emails sent count"
  }

  dimension: email_total {
    type: number
    sql: ${TABLE}.email_total ;;
    label: "Total Emails"
    value_format_name: decimal_0
    group_label: "Email"
    description: "Total emails"
  }

  dimension: receive_send_ratio {
    type: number
    sql: ${TABLE}.receive_send_ratio ;;
    label: "Receive/Send Ratio"
    value_format_name: decimal_2
    group_label: "Email"
    description: "Received/Sent ratio"
  }

  # =============================================================================
  # MESSAGE DIMENSIONS
  # =============================================================================

  dimension: slack_messages {
    type: number
    sql: ${TABLE}.slack_messages ;;
    label: "Slack Messages"
    value_format_name: decimal_0
    group_label: "Messages"
    description: "Slack message count"
  }

  dimension: imessage_count {
    type: number
    sql: ${TABLE}.imessage_count ;;
    label: "iMessage Count"
    value_format_name: decimal_0
    group_label: "Messages"
    description: "iMessage count"
  }

  dimension: whatsapp_count {
    type: number
    sql: ${TABLE}.whatsapp_count ;;
    label: "WhatsApp Count"
    value_format_name: decimal_0
    group_label: "Messages"
    description: "WhatsApp count"
  }

  dimension: total_messages {
    type: number
    sql: ${TABLE}.total_messages ;;
    label: "Total Messages"
    value_format_name: decimal_0
    group_label: "Messages"
    description: "Total messages all platforms"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Day Count"
    drill_fields: [full_date, email_total, total_messages]
  }

  measure: sum_emails_received {
    type: sum
    sql: ${emails_received} ;;
    label: "Total Emails Received"
    value_format_name: decimal_0
  }

  measure: sum_emails_sent {
    type: sum
    sql: ${emails_sent} ;;
    label: "Total Emails Sent"
    value_format_name: decimal_0
  }

  measure: sum_total_emails {
    type: sum
    sql: ${email_total} ;;
    label: "Total Emails"
    value_format_name: decimal_0
  }

  measure: avg_daily_emails {
    type: average
    sql: ${email_total} ;;
    label: "Avg Daily Emails"
    value_format_name: decimal_0
  }

  measure: sum_total_messages {
    type: sum
    sql: ${total_messages} ;;
    label: "Total Messages"
    value_format_name: decimal_0
  }

  measure: avg_daily_messages {
    type: average
    sql: ${total_messages} ;;
    label: "Avg Daily Messages"
    value_format_name: decimal_0
  }

  measure: sum_slack_messages {
    type: sum
    sql: ${slack_messages} ;;
    label: "Total Slack Messages"
    value_format_name: decimal_0
  }

  measure: avg_receive_send_ratio {
    type: average
    sql: ${receive_send_ratio} ;;
    label: "Avg Receive/Send Ratio"
    value_format_name: decimal_2
  }
}
