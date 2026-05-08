view: coding_agent_sessions_fact {
  sql_table_name: `ra-development.analytics.coding_agent_sessions_fact` ;;

  dimension: coding_agent_session_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.coding_agent_session_pk ;;
  }

  dimension: consultant_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.consultant_fk ;;
  }

  dimension: primary_src_control_repo_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.primary_src_control_repo_fk ;;
  }

  dimension: session_start_date_fk {
    hidden: yes
    type: date
    sql: ${TABLE}.session_start_date_fk ;;
  }

  # Identity
  dimension: user_email {
    label: "User Email"
    group_label: "Identity"
    type: string
    sql: ${TABLE}.user_email ;;
  }

  dimension: hostname {
    label: "Hostname"
    group_label: "Workstation"
    type: string
    sql: ${TABLE}.hostname ;;
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

  dimension: primary_project_dir {
    label: "Primary Project Dir"
    group_label: "Repository"
    type: string
    sql: ${TABLE}.primary_project_dir ;;
  }

  # Timing
  dimension_group: session_start {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.session_start_ts ;;
    label: "Session Start"
    datatype: timestamp
  }

  dimension_group: session_end {
    type: time
    timeframes: [raw, time, date]
    sql: ${TABLE}.session_end_ts ;;
    label: "Session End"
    datatype: timestamp
  }

  dimension: duration_seconds {
    label: "Duration (sec)"
    group_label: "Session Stats"
    type: number
    sql: ${TABLE}.duration_seconds ;;
  }

  dimension: duration_minutes {
    label: "Duration (min)"
    group_label: "Session Stats"
    type: number
    sql: ROUND(${TABLE}.duration_seconds / 60.0, 1) ;;
    value_format_name: decimal_1
  }

  # Session stats
  dimension: prompt_count {
    label: "Prompts"
    group_label: "Session Stats"
    type: number
    sql: ${TABLE}.prompt_count ;;
  }

  dimension: slash_command_count {
    label: "Slash Commands"
    group_label: "Session Stats"
    type: number
    sql: ${TABLE}.slash_command_count ;;
  }

  dimension: free_form_prompt_count {
    label: "Free-Form Prompts"
    group_label: "Session Stats"
    type: number
    sql: ${TABLE}.free_form_prompt_count ;;
  }

  dimension: distinct_command_count {
    label: "Distinct Commands"
    group_label: "Session Stats"
    type: number
    sql: ${TABLE}.distinct_command_count ;;
  }

  dimension: distinct_namespace_count {
    label: "Distinct Namespaces"
    group_label: "Session Stats"
    type: number
    sql: ${TABLE}.distinct_namespace_count ;;
  }

  dimension: agentic_framework_slash_command_count {
    label: "Wire Commands"
    group_label: "Session Stats"
    type: number
    sql: ${TABLE}.agentic_framework_slash_command_count ;;
  }

  dimension: is_short_session {
    label: "Is Short Session (≤2 prompts)"
    group_label: "Session Stats"
    type: yesno
    sql: ${TABLE}.is_short_session ;;
  }

  dimension: did_run_agentic_framework_slash_command {
    label: "Ran Wire Command"
    group_label: "Session Stats"
    type: yesno
    sql: ${TABLE}.did_run_agentic_framework_slash_command ;;
  }

  # Measures
  measure: count {
    type: count
    label: "Sessions"
    drill_fields: [session_start_date, user_email, primary_project_dir, prompt_count, duration_minutes]
  }

  measure: total_prompts {
    type: sum
    sql: ${prompt_count} ;;
    label: "Total Prompts"
  }

  measure: avg_prompts_per_session {
    type: average
    sql: ${prompt_count} ;;
    label: "Avg Prompts / Session"
    value_format_name: decimal_1
  }

  measure: avg_duration_minutes {
    type: average
    sql: ${duration_seconds} / 60.0 ;;
    label: "Avg Session Duration (min)"
    value_format_name: decimal_1
  }

  measure: pct_with_wire_commands {
    type: number
    sql: SAFE_DIVIDE(COUNTIF(${did_run_agentic_framework_slash_command}), COUNT(*)) ;;
    label: "% Sessions with Wire Commands"
    value_format_name: percent_1
  }

  measure: distinct_users {
    type: count_distinct
    sql: ${user_email} ;;
    label: "Distinct Users"
  }
}
