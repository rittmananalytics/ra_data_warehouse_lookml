view: workstations_dim {
  sql_table_name: `ra-development.analytics.workstations_dim` ;;

  dimension: workstation_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.workstation_pk ;;
  }

  dimension: consultant_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.consultant_fk ;;
  }

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

  dimension: agentic_framework_telemetry_user_id {
    label: "Wire Telemetry ID"
    group_label: "Wire"
    type: string
    sql: ${TABLE}.agentic_framework_telemetry_user_id ;;
  }

  dimension: os {
    label: "OS"
    group_label: "Workstation"
    type: string
    sql: ${TABLE}.os ;;
  }

  dimension: plugin_version_first {
    label: "Plugin Version (First)"
    group_label: "Wire"
    type: string
    sql: ${TABLE}.plugin_version_first ;;
  }

  dimension: plugin_version_last {
    label: "Plugin Version (Last)"
    group_label: "Wire"
    type: string
    sql: ${TABLE}.plugin_version_last ;;
  }

  dimension_group: agentic_framework_first_seen {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.agentic_framework_first_seen_ts ;;
    label: "Wire First Seen"
    datatype: timestamp
  }

  dimension_group: agentic_framework_last_seen {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.agentic_framework_last_seen_ts ;;
    label: "Wire Last Seen"
    datatype: timestamp
  }

  dimension_group: coding_agent_first_seen {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.coding_agent_first_seen_ts ;;
    label: "Claude Code First Seen"
    datatype: timestamp
  }

  dimension_group: coding_agent_last_seen {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.coding_agent_last_seen_ts ;;
    label: "Claude Code Last Seen"
    datatype: timestamp
  }

  dimension_group: first_seen {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.first_seen_ts ;;
    label: "First Seen (Any)"
    datatype: timestamp
  }

  dimension_group: last_seen {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.last_seen_ts ;;
    label: "Last Seen (Any)"
    datatype: timestamp
  }

  dimension: agentic_framework_event_count {
    label: "Wire Events"
    group_label: "Activity"
    type: number
    sql: ${TABLE}.agentic_framework_event_count ;;
  }

  dimension: coding_agent_prompt_count {
    label: "Claude Code Prompts"
    group_label: "Activity"
    type: number
    sql: ${TABLE}.coding_agent_prompt_count ;;
  }

  dimension: coding_agent_distinct_project_dirs {
    label: "Distinct Project Dirs"
    group_label: "Activity"
    type: number
    sql: ${TABLE}.coding_agent_distinct_project_dirs ;;
  }

  dimension: has_agentic_framework_activity {
    label: "Has Wire Activity"
    group_label: "Activity"
    type: yesno
    sql: ${TABLE}.has_agentic_framework_activity ;;
  }

  dimension: has_coding_agent_activity {
    label: "Has Claude Code Activity"
    group_label: "Activity"
    type: yesno
    sql: ${TABLE}.has_coding_agent_activity ;;
  }

  measure: count {
    type: count
    label: "Workstations"
  }

  measure: cross_tool_workstations {
    type: count
    label: "Cross-Tool Workstations"
    filters: [has_agentic_framework_activity: "Yes", has_coding_agent_activity: "Yes"]
  }
}
