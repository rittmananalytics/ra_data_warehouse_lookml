view: developer_activity_fact {
  sql_table_name: `ra-development.analytics.developer_activity_fact` ;;

  dimension: developer_activity_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.developer_activity_pk ;;
  }

  # Source routing
  dimension: source_system {
    label: "Source System"
    description: "wire = Wire CLI event; claude_code = Claude Code prompt"
    type: string
    sql: ${TABLE}.source_system ;;
  }

  # FKs
  dimension: consultant_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.consultant_fk ;;
  }

  dimension: workstation_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.workstation_fk ;;
  }

  dimension: src_control_repo_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.src_control_repo_fk ;;
  }

  # Identity
  dimension: consultant_email {
    label: "Consultant Email"
    group_label: "Identity"
    type: string
    sql: ${TABLE}.consultant_email ;;
  }

  dimension: user_email {
    label: "User Email"
    group_label: "Identity"
    type: string
    sql: ${TABLE}.user_email ;;
  }

  dimension: is_known_consultant {
    label: "Is Known Consultant"
    group_label: "Identity"
    type: yesno
    sql: ${TABLE}.is_known_consultant ;;
  }

  dimension: is_internal_user {
    label: "Is Internal User"
    group_label: "Identity"
    type: yesno
    sql: ${TABLE}.is_internal_user ;;
  }

  # Workstation
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

  # Command info
  dimension: is_slash_command {
    label: "Is Slash Command"
    group_label: "Command"
    type: yesno
    sql: ${TABLE}.is_slash_command ;;
  }

  dimension: slash_command_raw {
    label: "Command (raw)"
    group_label: "Command"
    type: string
    sql: ${TABLE}.slash_command_raw ;;
  }

  dimension: slash_command_namespace {
    label: "Namespace"
    group_label: "Command"
    type: string
    sql: ${TABLE}.slash_command_namespace ;;
  }

  dimension: slash_command_name {
    label: "Command Name"
    group_label: "Command"
    type: string
    sql: ${TABLE}.slash_command_name ;;
  }

  dimension: is_agentic_framework_event {
    label: "Is Wire Event"
    group_label: "Command"
    type: yesno
    sql: ${TABLE}.is_agentic_framework_event ;;
  }

  dimension: is_coding_agent_event {
    label: "Is Claude Code Event"
    group_label: "Command"
    type: yesno
    sql: ${TABLE}.is_coding_agent_event ;;
  }

  # Repository
  dimension: git_repo_canonical {
    label: "Git Repo"
    group_label: "Repository"
    type: string
    sql: ${TABLE}.git_repo_canonical ;;
  }

  dimension: project_dir {
    label: "Project Dir"
    group_label: "Repository"
    type: string
    sql: ${TABLE}.project_dir ;;
  }

  # Text
  dimension: activity_text {
    label: "Activity Text"
    description: "Command name (Wire) or truncated prompt (Claude Code)"
    type: string
    sql: ${TABLE}.activity_text ;;
  }

  # Timing
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
    label: "Developer Events"
    drill_fields: [event_time, source_system, consultant_email, slash_command_raw, git_repo_canonical, activity_text]
  }

  measure: wire_event_count {
    type: count
    label: "Wire Events"
    filters: [is_agentic_framework_event: "Yes"]
  }

  measure: claude_code_event_count {
    type: count
    label: "Claude Code Events"
    filters: [is_coding_agent_event: "Yes"]
  }

  measure: distinct_consultants {
    type: count_distinct
    sql: COALESCE(${consultant_email}, ${user_email}) ;;
    label: "Distinct Consultants"
  }

  measure: slash_command_count {
    type: count
    label: "Slash Commands"
    filters: [is_slash_command: "Yes"]
  }

  measure: distinct_repos {
    type: count_distinct
    sql: ${git_repo_canonical} ;;
    label: "Distinct Repos"
  }
}
