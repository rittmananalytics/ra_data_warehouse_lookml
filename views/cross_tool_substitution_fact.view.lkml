<<<<<<< HEAD
# cross_tool_substitution_fact.view.lkml
# Exposes cross_tool_substitution_fact
# Table: ra-development.analytics.cross_tool_substitution_fact
# Grain: one row per (Wire phase, CC substitute command).
#
# Answers: "Which Claude Code slash commands are users running where we'd
# expect a Wire equivalent?" — for each Wire phase, ranked candidates.

view: cross_tool_substitution_fact {
  sql_table_name: `ra-development.analytics.cross_tool_substitution_fact` ;;

  dimension: pk {
    primary_key: yes
    hidden:      yes
    type:        string
    sql:         CONCAT(${TABLE}.agentic_framework_phase_substituted, '|', ${TABLE}.coding_agent_substitute_command) ;;
  }

  dimension: agentic_framework_phase_substituted {
    label:       "Wire Phase (substituted)"
    description: "The Wire delivery phase whose slot the CC command appears to be filling."
    type:        string
    sql:         ${TABLE}.agentic_framework_phase_substituted ;;
    suggestions: [
      "requirements", "data_model", "pipeline", "dbt", "semantic_layer",
      "dashboards", "data_quality", "deployment", "training", "documentation",
      "review", "startup", "other"
    ]
  }

  dimension: coding_agent_substitute_command {
    label:       "CC Command (substitute)"
    description: "The Claude Code slash-command users ran instead of a Wire equivalent."
    type:        string
    sql:         ${TABLE}.coding_agent_substitute_command ;;
  }

  dimension_group: last_observed {
    label:       "Last Observed"
    description: "Most recent occurrence of this substitution pattern."
    type:        time
    timeframes:  [time, date, week, month]
    sql:         ${TABLE}.last_observed_ts ;;
  }

  # ── Measures ──────────────────────────────────────────────────────────────────

  measure: substitution_count {
    label:       "Substitution Count"
    description: "Number of times this CC command was run where a Wire phase had no Wire activity in the same session."
    type:        sum
    sql:         ${TABLE}.substitution_count ;;
    drill_fields: [agentic_framework_phase_substituted, coding_agent_substitute_command, distinct_consultants, distinct_sessions]
  }

  measure: distinct_consultants {
    label:       "Distinct Consultants"
    description: "Number of consultants exhibiting this substitution pattern."
    type:        sum
    sql:         ${TABLE}.distinct_consultants ;;
  }

  measure: distinct_sessions {
    label:       "Distinct Sessions"
    description: "Number of sessions exhibiting this substitution pattern."
    type:        sum
    sql:         ${TABLE}.distinct_sessions ;;
  }

  measure: avg_consultants_per_substitution {
    label:       "Avg Consultants per Substitution"
    description: "How widely a substitution pattern is adopted (1 = idiosyncratic, higher = trend)."
    type:        number
    sql:         SAFE_DIVIDE(${distinct_consultants}, NULLIF(${substitution_count}, 0)) ;;
    value_format: "0.00"
=======
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
>>>>>>> cecfd541c93b7b0c10a4eaf837d8a5e33be5dc7f
  }
}
