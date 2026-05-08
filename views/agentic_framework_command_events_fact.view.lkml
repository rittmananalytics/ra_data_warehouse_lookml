view: agentic_framework_command_events_fact {
  sql_table_name: `ra-development.analytics.agentic_framework_command_events_fact` ;;

  dimension: agentic_framework_command_event_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.agentic_framework_command_event_pk ;;
  }

  # Foreign keys (hidden)
  dimension: consultant_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.consultant_fk ;;
  }

  dimension: src_control_repo_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.src_control_repo_fk ;;
  }

  dimension: agentic_framework_command_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.agentic_framework_command_fk ;;
  }

  dimension: agentic_framework_session_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.agentic_framework_session_fk ;;
  }

  dimension: event_date_fk {
    hidden: yes
    type: date
    sql: ${TABLE}.event_date_fk ;;
  }

  # Identity dimensions
  dimension: telemetry_user_id {
    hidden: yes
    type: string
    sql: ${TABLE}.telemetry_user_id ;;
  }

  dimension: username {
    label: "Wire Username"
    group_label: "Identity"
    type: string
    sql: ${TABLE}.username ;;
  }

  dimension: consultant_email {
    label: "Consultant Email"
    group_label: "Identity"
    type: string
    sql: ${TABLE}.consultant_email ;;
  }

  dimension: consultant_name {
    label: "Consultant"
    group_label: "Identity"
    type: string
    sql: ${TABLE}.consultant_name ;;
  }

  dimension: is_known_consultant {
    label: "Is Known Consultant"
    group_label: "Identity"
    type: yesno
    sql: ${TABLE}.is_known_consultant ;;
  }

  # Command dimensions
  dimension: command_name {
    label: "Command"
    group_label: "Command"
    type: string
    sql: ${TABLE}.command_name ;;
    link: {
      label: "Filter to this command"
      url: "/explore/agentic_framework_command_events_fact?f[agentic_framework_command_events_fact.command_name]={{ value | encode_uri }}"
    }
  }

  dimension: artifact_name {
    label: "Artifact"
    group_label: "Command"
    type: string
    sql: ${TABLE}.artifact_name ;;
  }

  dimension: action_name {
    label: "Action"
    group_label: "Command"
    type: string
    sql: ${TABLE}.action_name ;;
  }

  dimension: phase_name {
    label: "Phase"
    group_label: "Command"
    type: string
    sql: ${TABLE}.phase_name ;;
  }

  dimension: is_autopilot {
    label: "Is Autopilot"
    group_label: "Command"
    type: yesno
    sql: ${TABLE}.is_autopilot ;;
  }

  dimension: autopilot_phase {
    label: "Autopilot Phase"
    group_label: "Command"
    type: string
    sql: ${TABLE}.autopilot_phase ;;
  }

  # Repo / workstation dimensions
  dimension: git_repo_canonical {
    label: "Git Repo"
    group_label: "Repository"
    type: string
    sql: ${TABLE}.git_repo_canonical ;;
  }

  dimension: git_repo_owner {
    label: "Repo Owner"
    group_label: "Repository"
    type: string
    sql: ${TABLE}.git_repo_owner ;;
  }

  dimension: git_repo_name {
    label: "Repo Name"
    group_label: "Repository"
    type: string
    sql: ${TABLE}.git_repo_name ;;
  }

  dimension: git_branch {
    label: "Git Branch"
    group_label: "Repository"
    type: string
    sql: ${TABLE}.git_branch ;;
  }

  dimension: hostname {
    label: "Hostname"
    group_label: "Workstation"
    type: string
    sql: ${TABLE}.hostname ;;
  }

  dimension: os {
    label: "OS"
    group_label: "Workstation"
    type: string
    sql: ${TABLE}.os ;;
  }

  dimension: plugin_version {
    label: "Plugin Version"
    group_label: "Workstation"
    type: string
    sql: ${TABLE}.plugin_version ;;
  }

  dimension: runtime {
    label: "Runtime"
    group_label: "Workstation"
    type: string
    sql: ${TABLE}.runtime ;;
  }

  # Session position
  dimension: command_sequence_in_session {
    label: "Command # in Session"
    group_label: "Session"
    type: number
    sql: ${TABLE}.command_sequence_in_session ;;
  }

  dimension: seconds_since_prev_command_in_session {
    label: "Seconds Since Prev Command"
    group_label: "Session"
    type: number
    sql: ${TABLE}.seconds_since_prev_command_in_session ;;
  }

  # Time dimensions
  dimension_group: event {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.event_ts ;;
    label: "Event"
    datatype: timestamp
  }

  dimension: week_commencing {
    label: "Week Commencing"
    type: date
    sql: ${TABLE}.week_commencing ;;
  }

  # Measures
  measure: count {
    type: count
    label: "Command Events"
    drill_fields: [event_time, consultant_name, command_name, phase_name, git_repo_canonical]
  }

  measure: distinct_consultants {
    type: count_distinct
    sql: ${consultant_email} ;;
    label: "Distinct Consultants"
  }

  measure: distinct_commands {
    type: count_distinct
    sql: ${command_name} ;;
    label: "Distinct Commands"
  }

  measure: distinct_repos {
    type: count_distinct
    sql: ${git_repo_canonical} ;;
    label: "Distinct Repos"
  }

  measure: autopilot_command_count {
    type: count
    label: "Autopilot Commands"
    filters: [is_autopilot: "Yes"]
  }

  measure: autopilot_pct {
    type: number
    label: "Autopilot %"
    sql: SAFE_DIVIDE(${autopilot_command_count}, ${count}) ;;
    value_format_name: percent_1
  }

  measure: avg_gap_seconds {
    type: average
    sql: ${seconds_since_prev_command_in_session} ;;
    label: "Avg Gap Between Commands (sec)"
    value_format_name: decimal_1
  }
}
