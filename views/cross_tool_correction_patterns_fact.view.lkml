<<<<<<< HEAD
# cross_tool_correction_patterns_fact.view.lkml
# Exposes cross_tool_correction_patterns_fact
# Table: ra-development.analytics.cross_tool_correction_patterns_fact
# Restricted to post_agentic_framework adjacency, with keyword-bucketed CC categories.

view: cross_tool_correction_patterns_fact {
  sql_table_name: `ra-development.analytics.cross_tool_correction_patterns_fact` ;;

  dimension: pk {
    primary_key: yes
    hidden:      yes
    type:        string
    sql:         CONCAT(${TABLE}.agentic_framework_command_name, '|', ${TABLE}.coding_agent_bucket) ;;
  }

  dimension: agentic_framework_command_name {
    label:       "Wire Command"
    description: "Wire slash-command that the CC prompts followed."
    type:        string
    sql:         ${TABLE}.agentic_framework_command_name ;;
  }

  dimension: agentic_framework_phase_name {
    label:       "Wire Phase"
    type:        string
    sql:         ${TABLE}.agentic_framework_phase_name ;;
  }

  dimension: coding_agent_bucket {
    label:       "CC Bucket"
    description: "Coarse keyword bucketing of post-Wire CC prompts (v1)."
    type:        string
    sql:         ${TABLE}.coding_agent_bucket ;;
    suggestions: [
      "agentic_framework_followup", "coding_agent_startup", "coding_agent_review", "coding_agent_test", "coding_agent_other_slash",
      "free_form_fix_error", "free_form_explain", "free_form_dbt_sql",
      "free_form_test_check", "free_form_refactor", "free_form_other"
    ]
  }

  dimension: is_fix_or_error {
    label:       "Is Fix / Error Bucket"
    description: "Yes when the bucket implies the user is fixing an error."
    type:        yesno
    sql:         ${TABLE}.coding_agent_bucket = 'free_form_fix_error' ;;
  }

  dimension: is_dbt_sql {
    label:       "Is dbt / SQL Bucket"
    description: "Yes when the post-Wire prompt mentions dbt or SQL."
    type:        yesno
    sql:         ${TABLE}.coding_agent_bucket = 'free_form_dbt_sql' ;;
  }

  measure: occurrence_count {
    label:       "Occurrence Count"
    type:        sum
    sql:         ${TABLE}.occurrence_count ;;
    drill_fields: [agentic_framework_command_name, coding_agent_bucket, distinct_consultants]
  }

  measure: distinct_consultants {
    label:       "Distinct Consultants"
    type:        sum
    sql:         ${TABLE}.distinct_consultants ;;
  }

  measure: avg_offset_seconds_after_agentic_framework {
    label:       "Avg Seconds After Wire"
    description: "Average elapsed time between the Wire command and the follow-up CC prompt."
    type:        average
    sql:         ${TABLE}.avg_offset_seconds_after_agentic_framework ;;
    value_format: "0"
  }

  measure: median_offset_seconds_after_agentic_framework {
    label:       "Median Seconds After Wire"
    type:        average
    sql:         ${TABLE}.median_offset_seconds_after_agentic_framework ;;
    value_format: "0"
=======
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
>>>>>>> cecfd541c93b7b0c10a4eaf837d8a5e33be5dc7f
  }
}
