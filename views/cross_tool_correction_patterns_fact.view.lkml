view: cross_tool_correction_patterns_fact {
  sql_table_name: `ra-development.analytics.cross_tool_correction_patterns_fact` ;;

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

  dimension: coding_agent_bucket {
    label: "Claude Code Bucket"
    description: "Category of Claude Code follow-up activity after the Wire command ran"
    type: string
    sql: ${TABLE}.coding_agent_bucket ;;
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

  dimension: avg_offset_seconds_after_agentic_framework {
    label: "Avg Offset After Wire (sec)"
    type: number
    sql: ${TABLE}.avg_offset_seconds_after_agentic_framework ;;
    value_format_name: decimal_1
  }

  dimension: median_offset_seconds_after_agentic_framework {
    label: "Median Offset After Wire (sec)"
    type: number
    sql: ${TABLE}.median_offset_seconds_after_agentic_framework ;;
  }

  measure: count {
    type: count
    label: "Correction Pattern Records"
  }

  measure: total_occurrences {
    type: sum
    sql: ${occurrence_count} ;;
    label: "Total Correction Occurrences"
  }

  measure: distinct_commands_with_corrections {
    type: count_distinct
    sql: ${agentic_framework_command_name} ;;
    label: "Distinct Wire Commands with Corrections"
  }
}
