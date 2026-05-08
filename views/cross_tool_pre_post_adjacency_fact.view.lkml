<<<<<<< HEAD
# cross_tool_pre_post_adjacency_fact.view.lkml
# Exposes cross_tool_pre_post_adjacency_fact
# Table: ra-development.analytics.cross_tool_pre_post_adjacency_fact
# Grain: one row per (Wire command, temporal_relation, CC category).

view: cross_tool_pre_post_adjacency_fact {
  sql_table_name: `ra-development.analytics.cross_tool_pre_post_adjacency_fact` ;;

  dimension: pk {
    primary_key: yes
    hidden:      yes
    type:        string
    sql: CONCAT(${TABLE}.agentic_framework_command_name, '|', ${TABLE}.temporal_relation, '|', ${TABLE}.coding_agent_category) ;;
  }

  dimension: agentic_framework_command_name {
    label:       "Wire Command"
    description: "The Wire slash-command at the centre of the adjacency window."
    type:        string
    sql:         ${TABLE}.agentic_framework_command_name ;;
  }

  dimension: agentic_framework_phase_name {
    label:       "Wire Phase"
    type:        string
    sql:         ${TABLE}.agentic_framework_phase_name ;;
  }

  dimension: temporal_relation {
    label:       "Temporal Relation"
    description: "Did the Claude Code prompt occur before or after the Wire command?"
    type:        string
    sql:         ${TABLE}.temporal_relation ;;
    suggestions: ["pre_agentic_framework", "post_agentic_framework"]
    html: {% if value == 'pre_agentic_framework' %}
            <span style="color:#1e6091;background:#cfe2f3;padding:2px 6px;border-radius:4px;">{{ value }}</span>
          {% elsif value == 'post_agentic_framework' %}
            <span style="color:#7b341e;background:#f9cb9c;padding:2px 6px;border-radius:4px;">{{ value }}</span>
          {% else %}{{ value }}{% endif %} ;;
  }

  dimension: coding_agent_category {
    label:       "CC Category"
    description: "Either the literal CC slash command (when slash) or '(free_form)' for natural-language prompts."
    type:        string
    sql:         ${TABLE}.coding_agent_category ;;
  }

  dimension: is_free_form {
    label:       "Is Free-Form Prompt"
    type:        yesno
    sql:         ${TABLE}.coding_agent_category = '(free_form)' ;;
  }

  # ── Measures ──────────────────────────────────────────────────────────────────

  measure: occurrence_count {
    label:       "Occurrence Count"
    description: "Number of (Wire command, CC prompt) pairs in the adjacency window matching this category."
    type:        sum
    sql:         ${TABLE}.occurrence_count ;;
    drill_fields: [agentic_framework_command_name, temporal_relation, coding_agent_category, distinct_consultants]
  }

  measure: distinct_consultants {
    label:       "Distinct Consultants"
    type:        sum
    sql:         ${TABLE}.distinct_consultants ;;
  }

  measure: avg_offset_seconds {
    label:       "Avg Offset (seconds)"
    description: "Average absolute time between the CC prompt and the Wire command."
    type:        average
    sql:         ${TABLE}.avg_offset_seconds ;;
    value_format: "0"
  }

  measure: median_offset_seconds {
    label:       "Median Offset (seconds)"
    type:        average
    sql:         ${TABLE}.median_offset_seconds ;;
    value_format: "0"
=======
view: cross_tool_pre_post_adjacency_fact {
  sql_table_name: `ra-development.analytics.cross_tool_pre_post_adjacency_fact` ;;

  dimension: agentic_framework_command_name {
    label: "Wire Command"
    group_label: "Wire"
    type: string
    sql: ${TABLE}.agentic_framework_command_name ;;
  }

  dimension: agentic_framework_phase_name {
    label: "Wire Phase"
    group_label: "Wire"
    type: string
    sql: ${TABLE}.agentic_framework_phase_name ;;
  }

  dimension: temporal_relation {
    label: "Temporal Relation"
    description: "Whether Claude Code activity occurred before or after the Wire command"
    type: string
    sql: ${TABLE}.temporal_relation ;;
  }

  dimension: coding_agent_category {
    label: "Claude Code Category"
    group_label: "Claude Code"
    description: "Category of Claude Code prompt that was adjacent to the Wire command"
    type: string
    sql: ${TABLE}.coding_agent_category ;;
  }

  dimension: occurrence_count {
    label: "Occurrence Count"
    type: number
    sql: ${TABLE}.occurrence_count ;;
  }

  dimension: distinct_consultants {
    label: "Distinct Consultants"
    type: number
    sql: ${TABLE}.distinct_consultants ;;
  }

  dimension: avg_offset_seconds {
    label: "Avg Offset (sec)"
    type: number
    sql: ${TABLE}.avg_offset_seconds ;;
    value_format_name: decimal_1
  }

  dimension: median_offset_seconds {
    label: "Median Offset (sec)"
    type: number
    sql: ${TABLE}.median_offset_seconds ;;
  }

  measure: count {
    type: count
    label: "Adjacency Pairs"
  }

  measure: total_occurrences {
    type: sum
    sql: ${occurrence_count} ;;
    label: "Total Occurrences"
  }

  measure: pre_wire_occurrences {
    type: sum
    sql: ${occurrence_count} ;;
    filters: [temporal_relation: "pre_wire"]
    label: "Pre-Wire Occurrences"
  }

  measure: post_wire_occurrences {
    type: sum
    sql: ${occurrence_count} ;;
    filters: [temporal_relation: "post_wire"]
    label: "Post-Wire Occurrences"
>>>>>>> cecfd541c93b7b0c10a4eaf837d8a5e33be5dc7f
  }
}
