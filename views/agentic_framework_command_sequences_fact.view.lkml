view: agentic_framework_command_sequences_fact {
  sql_table_name: `ra-development.analytics.agentic_framework_command_sequences_fact` ;;

  dimension: command_a {
    label: "Command A (Source)"
    group_label: "Sequence"
    type: string
    sql: ${TABLE}.command_a ;;
  }

  dimension: phase_a {
    label: "Phase A"
    group_label: "Sequence"
    type: string
    sql: ${TABLE}.phase_a ;;
  }

  dimension: command_b {
    label: "Command B (Target)"
    group_label: "Sequence"
    type: string
    sql: ${TABLE}.command_b ;;
  }

  dimension: phase_b {
    label: "Phase B"
    group_label: "Sequence"
    type: string
    sql: ${TABLE}.phase_b ;;
  }

  dimension: transition_count {
    label: "Transition Count"
    type: number
    sql: ${TABLE}.transition_count ;;
  }

  dimension: distinct_consultants {
    label: "Distinct Consultants"
    type: number
    sql: ${TABLE}.distinct_consultants ;;
  }

  dimension: distinct_sessions {
    label: "Distinct Sessions"
    type: number
    sql: ${TABLE}.distinct_sessions ;;
  }

  dimension: avg_gap_seconds {
    label: "Avg Gap (sec)"
    type: number
    sql: ${TABLE}.avg_gap_seconds ;;
    value_format_name: decimal_1
  }

  dimension: median_gap_seconds {
    label: "Median Gap (sec)"
    type: number
    sql: ${TABLE}.median_gap_seconds ;;
  }

  measure: count {
    type: count
    label: "Command Pairs"
  }

  measure: total_transitions {
    type: sum
    sql: ${transition_count} ;;
    label: "Total Transitions"
  }

  measure: avg_gap_seconds_agg {
    type: average
    sql: ${avg_gap_seconds} ;;
    label: "Avg Gap (sec)"
    value_format_name: decimal_1
  }
}
