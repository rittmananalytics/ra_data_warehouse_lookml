# agentic_framework_command_sequences_fact.view.lkml
# Exposes agentic_framework_command_sequences_fact
# Table: ra-development.analytics.agentic_framework_command_sequences_fact
# Grain: one row per (command_a, command_b) ordered pair within a session.

view: agentic_framework_command_sequences_fact {
  sql_table_name: `ra-development.analytics.agentic_framework_command_sequences_fact` ;;

  dimension: pk {
    primary_key: yes
    hidden:      yes
    type:        string
    sql:         CONCAT(${TABLE}.command_a, '|', ${TABLE}.command_b) ;;
  }

  dimension: command_a {
    label:       "Command A (predecessor)"
    type:        string
    sql:         ${TABLE}.command_a ;;
  }

  dimension: phase_a {
    label:       "Phase A"
    type:        string
    sql:         ${TABLE}.phase_a ;;
  }

  dimension: command_b {
    label:       "Command B (successor)"
    type:        string
    sql:         ${TABLE}.command_b ;;
  }

  dimension: phase_b {
    label:       "Phase B"
    type:        string
    sql:         ${TABLE}.phase_b ;;
  }

  dimension: is_same_phase_transition {
    label:       "Same Phase Transition"
    description: "Yes when A and B are in the same Wire phase."
    type:        yesno
    sql:         ${TABLE}.phase_a = ${TABLE}.phase_b ;;
  }

  measure: transition_count {
    label:       "Transition Count"
    type:        sum
    sql:         ${TABLE}.transition_count ;;
    drill_fields: [command_a, command_b, distinct_consultants, distinct_sessions]
  }

  measure: distinct_consultants {
    label:       "Distinct Consultants"
    type:        sum
    sql:         ${TABLE}.distinct_consultants ;;
  }

  measure: distinct_sessions {
    label:       "Distinct Sessions"
    type:        sum
    sql:         ${TABLE}.distinct_sessions ;;
  }

  measure: avg_gap_seconds {
    label:       "Avg Gap (seconds)"
    description: "Average time between command A and command B."
    type:        average
    sql:         ${TABLE}.avg_gap_seconds ;;
    value_format: "0"
  }

  measure: median_gap_seconds {
    label:       "Median Gap (seconds)"
    type:        average
    sql:         ${TABLE}.median_gap_seconds ;;
    value_format: "0"
  }
}
