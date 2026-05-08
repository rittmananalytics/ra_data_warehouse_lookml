view: developer_sessions_fact {
  sql_table_name: `ra-development.analytics.developer_sessions_fact` ;;

  dimension: developer_session_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.developer_session_pk ;;
  }

  dimension: consultant_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.consultant_fk ;;
  }

  dimension: workstation_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.workstation_fk ;;
  }

  dimension: session_start_date_fk {
    hidden: yes
    type: date
    sql: ${TABLE}.session_start_date_fk ;;
  }

  # Identity
  dimension: consultant_email {
    label: "Consultant Email"
    group_label: "Identity"
    type: string
    sql: ${TABLE}.consultant_email ;;
  }

  dimension: hostname {
    label: "Hostname"
    group_label: "Workstation"
    type: string
    sql: ${TABLE}.hostname ;;
  }

  # Timing
  dimension_group: session_start {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.session_start_ts ;;
    label: "Session Start"
    datatype: timestamp
  }

  dimension_group: session_end {
    type: time
    timeframes: [raw, time, date]
    sql: ${TABLE}.session_end_ts ;;
    label: "Session End"
    datatype: timestamp
  }

  dimension: duration_seconds {
    label: "Duration (sec)"
    group_label: "Session Stats"
    type: number
    sql: ${TABLE}.duration_seconds ;;
  }

  dimension: duration_minutes {
    label: "Duration (min)"
    group_label: "Session Stats"
    type: number
    sql: ROUND(${TABLE}.duration_seconds / 60.0, 1) ;;
    value_format_name: decimal_1
  }

  # Counts
  dimension: event_count {
    label: "Total Events"
    group_label: "Session Stats"
    type: number
    sql: ${TABLE}.event_count ;;
  }

  dimension: agentic_framework_event_count {
    label: "Wire Events"
    group_label: "Session Stats"
    type: number
    sql: ${TABLE}.agentic_framework_event_count ;;
  }

  dimension: coding_agent_event_count {
    label: "Claude Code Events"
    group_label: "Session Stats"
    type: number
    sql: ${TABLE}.coding_agent_event_count ;;
  }

  dimension: slash_command_count {
    label: "Slash Commands"
    group_label: "Session Stats"
    type: number
    sql: ${TABLE}.slash_command_count ;;
  }

  dimension: agentic_framework_namespace_command_count {
    label: "Wire Namespace Commands"
    group_label: "Session Stats"
    type: number
    sql: ${TABLE}.agentic_framework_namespace_command_count ;;
  }

  dimension: distinct_command_count {
    label: "Distinct Commands"
    group_label: "Session Stats"
    type: number
    sql: ${TABLE}.distinct_command_count ;;
  }

  dimension: distinct_repo_count {
    label: "Repos"
    group_label: "Session Stats"
    type: number
    sql: ${TABLE}.distinct_repo_count ;;
  }

  dimension: primary_git_repo_canonical {
    label: "Primary Repo"
    group_label: "Repository"
    type: string
    sql: ${TABLE}.primary_git_repo_canonical ;;
  }

  dimension: session_composition {
    label: "Session Composition"
    description: "wire_only / claude_code_only / wire_then_cc / cc_then_wire / interleaved"
    type: string
    sql: ${TABLE}.session_composition ;;
  }

  # Measures
  measure: count {
    type: count
    label: "Developer Sessions"
    drill_fields: [session_start_date, consultant_email, session_composition, event_count, duration_minutes]
  }

  measure: total_events {
    type: sum
    sql: ${event_count} ;;
    label: "Total Events"
  }

  measure: avg_events_per_session {
    type: average
    sql: ${event_count} ;;
    label: "Avg Events / Session"
    value_format_name: decimal_1
  }

  measure: avg_duration_minutes {
    type: average
    sql: ${duration_seconds} / 60.0 ;;
    label: "Avg Session Duration (min)"
    value_format_name: decimal_1
  }

  measure: distinct_consultants {
    type: count_distinct
    sql: ${consultant_email} ;;
    label: "Distinct Consultants"
  }

  measure: wire_only_sessions {
    type: count
    label: "Wire-Only Sessions"
    filters: [session_composition: "wire_only"]
  }

  measure: claude_code_only_sessions {
    type: count
    label: "Claude Code-Only Sessions"
    filters: [session_composition: "claude_code_only"]
  }

  measure: cross_tool_sessions {
    type: count
    label: "Cross-Tool Sessions"
    filters: [session_composition: "-wire_only,-claude_code_only"]
  }
}
