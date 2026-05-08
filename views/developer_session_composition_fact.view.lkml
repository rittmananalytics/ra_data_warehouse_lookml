view: developer_session_composition_fact {
  sql_table_name: `ra-development.analytics.developer_session_composition_fact` ;;

  # Cast DATE → TIMESTAMP so Looker's date_filter emits TIMESTAMP >= TIMESTAMP,
  # which BigQuery accepts. Without the cast BigQuery rejects DATE >= TIMESTAMP.
  # dimension_group generates session_start_week — no dashboard field renames needed.
  dimension_group: session_start {
    type: time
    timeframes: [date, week, month, year]
    sql: CAST(${TABLE}.session_start_week AS TIMESTAMP) ;;
    label: "Session Start"
  }

  dimension: cross_tool_stage {
    label: "Cross-Tool Stage"
    description: "Lifecycle stage across both Wire and Claude Code usage"
    type: string
    sql: ${TABLE}.cross_tool_stage ;;
  }

  dimension: session_composition {
    label: "Session Composition"
    description: "wire_only / claude_code_only / wire_then_cc / cc_then_wire / interleaved"
    type: string
    sql: ${TABLE}.session_composition ;;
  }

  dimension: session_count {
    label: "Session Count"
    type: number
    sql: ${TABLE}.session_count ;;
  }

  dimension: total_events {
    label: "Total Events"
    type: number
    sql: ${TABLE}.total_events ;;
  }

  dimension: avg_events_per_session {
    label: "Avg Events / Session"
    type: number
    sql: ${TABLE}.avg_events_per_session ;;
    value_format_name: decimal_1
  }

  dimension: avg_duration_seconds {
    label: "Avg Duration (sec)"
    type: number
    sql: ${TABLE}.avg_duration_seconds ;;
    value_format_name: decimal_1
  }

  dimension: avg_duration_minutes {
    label: "Avg Duration (min)"
    type: number
    sql: ROUND(${TABLE}.avg_duration_seconds / 60.0, 1) ;;
    value_format_name: decimal_1
  }

  measure: total_sessions {
    type: sum
    sql: ${session_count} ;;
    label: "Total Sessions"
  }

  measure: total_events_sum {
    type: sum
    sql: ${total_events} ;;
    label: "Total Events"
  }

  measure: count {
    type: count
    label: "Records"
  }
}
