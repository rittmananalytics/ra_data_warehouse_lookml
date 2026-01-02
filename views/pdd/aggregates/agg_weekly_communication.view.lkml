# =============================================================================
# AGG_WEEKLY_COMMUNICATION - Weekly Communication Summary
# Grain: One row per week
# Source: markr-data-lake.mark_dw_warehouse.agg_weekly_communication
# =============================================================================

view: agg_weekly_communication {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.agg_weekly_communication` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension_group: week_start {
    type: time
    primary_key: yes
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.week_start_date ;;
    label: "Week Start"
    description: "Week start date"
  }

  # =============================================================================
  # WEEK DIMENSION
  # =============================================================================

  dimension: year_week {
    type: string
    sql: ${TABLE}.year_week ;;
    label: "Year-Week"
    description: "Year-Week"
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
    description: "Emails received"
  }

  dimension: emails_sent {
    type: number
    sql: ${TABLE}.emails_sent ;;
    label: "Emails Sent"
    value_format_name: decimal_0
    group_label: "Email"
    description: "Emails sent"
  }

  dimension: total_emails {
    type: number
    sql: ${TABLE}.total_emails ;;
    label: "Total Emails"
    value_format_name: decimal_0
    group_label: "Email"
    description: "Total emails"
  }

  # =============================================================================
  # MESSAGE DIMENSIONS
  # =============================================================================

  dimension: total_messages {
    type: number
    sql: ${TABLE}.total_messages ;;
    label: "Total Messages"
    value_format_name: decimal_0
    group_label: "Messages"
    description: "Total messages"
  }

  dimension: total_communication {
    type: number
    sql: ${TABLE}.total_communication ;;
    label: "Total Communication"
    value_format_name: decimal_0
    description: "Total emails + messages"
  }

  dimension: slack_messages {
    type: number
    sql: ${TABLE}.slack_messages ;;
    label: "Slack Messages"
    value_format_name: decimal_0
    group_label: "Messages"
    description: "Slack messages"
  }

  dimension: imessage_count {
    type: number
    sql: ${TABLE}.imessage_count ;;
    label: "iMessage Count"
    value_format_name: decimal_0
    group_label: "Messages"
    description: "iMessage count"
  }

  # =============================================================================
  # COMPARISON DIMENSIONS
  # =============================================================================

  dimension: total_wow_change {
    type: number
    sql: ${TABLE}.total_wow_change ;;
    label: "WoW Change"
    value_format_name: decimal_0
    group_label: "Comparisons"
    description: "Week-over-week change"
  }

  dimension: total_wow_pct_change {
    type: number
    sql: ${TABLE}.total_wow_pct_change ;;
    label: "WoW % Change"
    value_format_name: percent_1
    group_label: "Comparisons"
    description: "Week-over-week percentage change"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Week Count"
    drill_fields: [week_start_date, year_week, total_emails, total_messages]
  }

  measure: sum_total_emails {
    type: sum
    sql: ${total_emails} ;;
    label: "Total Emails"
    value_format_name: decimal_0
  }

  measure: sum_total_messages {
    type: sum
    sql: ${total_messages} ;;
    label: "Total Messages"
    value_format_name: decimal_0
  }

  measure: sum_total_communication {
    type: sum
    sql: ${total_communication} ;;
    label: "Total Communication"
    value_format_name: decimal_0
  }

  measure: avg_weekly_emails {
    type: average
    sql: ${total_emails} ;;
    label: "Avg Weekly Emails"
    value_format_name: decimal_0
  }

  measure: avg_weekly_messages {
    type: average
    sql: ${total_messages} ;;
    label: "Avg Weekly Messages"
    value_format_name: decimal_0
  }
}
