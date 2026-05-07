view: cross_tool_substitution_fact {
  sql_table_name: `ra-development.analytics.cross_tool_substitution_fact` ;;

  dimension: agentic_framework_phase_substituted {
    label: "Wire Phase Substituted"
    description: "The Wire phase that was skipped in favour of a Claude Code command"
    type: string
    sql: ${TABLE}.agentic_framework_phase_substituted ;;
  }

  dimension: coding_agent_substitute_command {
    label: "Claude Code Substitute Command"
    description: "The Claude Code slash command that was run instead of the Wire command"
    type: string
    sql: ${TABLE}.coding_agent_substitute_command ;;
  }

  dimension: substitution_count {
    label: "Substitution Count"
    type: number
    sql: ${TABLE}.substitution_count ;;
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

  dimension_group: last_observed {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.last_observed_ts ;;
    label: "Last Observed"
    datatype: timestamp
  }

  measure: count {
    type: count
    label: "Substitution Pairs"
  }

  measure: total_substitutions {
    type: sum
    sql: ${substitution_count} ;;
    label: "Total Substitutions"
  }

  measure: max_substitution_count {
    type: max
    sql: ${substitution_count} ;;
    label: "Max Substitution Count"
  }

  measure: distinct_phases_substituted {
    type: count_distinct
    sql: ${agentic_framework_phase_substituted} ;;
    label: "Distinct Phases Substituted"
  }
}
