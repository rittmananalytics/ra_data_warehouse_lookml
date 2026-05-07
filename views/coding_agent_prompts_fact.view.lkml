view: coding_agent_prompts_fact {
  sql_table_name: `ra-development.analytics.coding_agent_prompts_fact` ;;

  dimension: coding_agent_prompt_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.coding_agent_prompt_pk ;;
  }

  # FKs
  dimension: consultant_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.consultant_fk ;;
  }

  dimension: coding_agent_command_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.coding_agent_command_fk ;;
  }

  dimension: src_control_repo_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.src_control_repo_fk ;;
  }

  dimension: coding_agent_session_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.coding_agent_session_fk ;;
  }

  dimension: event_date_fk {
    hidden: yes
    type: date
    sql: ${TABLE}.event_date_fk ;;
  }

  # Identity
  dimension: user_email {
    label: "User Email"
    group_label: "Identity"
    type: string
    sql: ${TABLE}.user_email ;;
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

  # Prompt content
  dimension: truncated_display {
    label: "Prompt (truncated)"
    group_label: "Prompt"
    type: string
    sql: ${TABLE}.truncated_display ;;
  }

  dimension: prompt_char_length {
    label: "Char Length"
    group_label: "Prompt"
    type: number
    sql: ${TABLE}.prompt_char_length ;;
  }

  dimension: prompt_word_count {
    label: "Word Count"
    group_label: "Prompt"
    type: number
    sql: ${TABLE}.prompt_word_count ;;
  }

  # Slash command
  dimension: is_slash_command {
    label: "Is Slash Command"
    group_label: "Slash Command"
    type: yesno
    sql: ${TABLE}.is_slash_command ;;
  }

  dimension: slash_command_raw {
    label: "Command (raw)"
    group_label: "Slash Command"
    type: string
    sql: ${TABLE}.slash_command_raw ;;
  }

  dimension: slash_command_namespace {
    label: "Namespace"
    group_label: "Slash Command"
    type: string
    sql: ${TABLE}.slash_command_namespace ;;
  }

  dimension: slash_command_name {
    label: "Command Name"
    group_label: "Slash Command"
    type: string
    sql: ${TABLE}.slash_command_name ;;
  }

  dimension: is_agentic_framework_slash_command {
    label: "Is Wire (Agentic Framework) Command"
    group_label: "Slash Command"
    type: yesno
    sql: ${TABLE}.is_agentic_framework_slash_command ;;
  }

  # Repository
  dimension: project_dir {
    label: "Project Dir"
    group_label: "Repository"
    type: string
    sql: ${TABLE}.project_dir ;;
  }

  dimension: project_dir_basename {
    label: "Project Dir (Name)"
    group_label: "Repository"
    type: string
    sql: ${TABLE}.project_dir_basename ;;
  }

  dimension: git_repo_canonical {
    label: "Git Repo"
    group_label: "Repository"
    type: string
    sql: ${TABLE}.git_repo_canonical ;;
  }

  dimension: repo_resolution_method {
    label: "Repo Resolution Method"
    group_label: "Repository"
    type: string
    sql: ${TABLE}.repo_resolution_method ;;
  }

  # Session position
  dimension: prompt_sequence_in_session {
    label: "Prompt # in Session"
    group_label: "Session"
    type: number
    sql: ${TABLE}.prompt_sequence_in_session ;;
  }

  dimension: seconds_since_prev_prompt_in_session {
    label: "Seconds Since Prev Prompt"
    group_label: "Session"
    type: number
    sql: ${TABLE}.seconds_since_prev_prompt_in_session ;;
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

  dimension: line_no {
    hidden: yes
    type: number
    sql: ${TABLE}.line_no ;;
  }

  # Measures
  measure: count {
    type: count
    label: "Prompts"
    drill_fields: [event_time, user_email, consultant_name, slash_command_raw, project_dir_basename, truncated_display]
  }

  measure: distinct_users {
    type: count_distinct
    sql: ${user_email} ;;
    label: "Distinct Users"
  }

  measure: slash_command_count {
    type: count
    label: "Slash Commands"
    filters: [is_slash_command: "Yes"]
  }

  measure: free_form_count {
    type: count
    label: "Free-Form Prompts"
    filters: [is_slash_command: "No"]
  }

  measure: wire_slash_command_count {
    type: count
    label: "Wire Slash Commands"
    filters: [is_agentic_framework_slash_command: "Yes"]
  }

  measure: avg_word_count {
    type: average
    sql: ${prompt_word_count} ;;
    label: "Avg Words / Prompt"
    value_format_name: decimal_1
  }

  measure: pct_slash_commands {
    type: number
    sql: SAFE_DIVIDE(${slash_command_count}, ${count}) ;;
    label: "% Slash Commands"
    value_format_name: percent_1
  }
}
