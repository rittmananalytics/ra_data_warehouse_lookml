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
  }
}
