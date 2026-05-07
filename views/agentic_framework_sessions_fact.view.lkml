view: agentic_framework_sessions_fact {
  sql_table_name: `ra-development.analytics.agentic_framework_sessions_fact` ;;

  dimension: agentic_framework_session_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.agentic_framework_session_pk ;;
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
  dimension: telemetry_user_id {
    hidden: yes
    type: string
    sql: ${TABLE}.telemetry_user_id ;;
  }

  dimension: hostname {
    label: "Hostname"
    group_label: "Workstation"
    type: string
    sql: ${TABLE}.hostname ;;
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

  dimension: os {
    label: "OS"
    group_label: "Workstation"
    type: string
    sql: ${TABLE}.os ;;
  }

  dimension: plugin_version_last {
    label: "Plugin Version"
    group_label: "Workstation"
    type: string
    sql: ${TABLE}.plugin_version_last ;;
  }

  dimension: runtime {
    label: "Runtime"
    group_label: "Workstation"
    type: string
    sql: ${TABLE}.runtime ;;
  }

  # Repo
  dimension: primary_git_repo_canonical {
    label: "Primary Repo"
    group_label: "Repository"
    type: string
    sql: ${TABLE}.primary_git_repo_canonical ;;
  }

  dimension: distinct_repo_count {
    label: "Repos in Session"
    group_label: "Repository"
    type: number
    sql: ${TABLE}.distinct_repo_count ;;
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

  dimension: session_start_date {
    hidden: yes
    type: date
    sql: ${TABLE}.session_start_date ;;
  }

  dimension: session_start_week {
    label: "Session Week"
    type: date
    sql: ${TABLE}.session_start_week ;;
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
  dimension: command_count {
    label: "Commands"
    group_label: "Session Stats"
    type: number
    sql: ${TABLE}.command_count ;;
  }

  dimension: distinct_command_count {
    label: "Distinct Commands"
    group_label: "Session Stats"
    type: number
    sql: ${TABLE}.distinct_command_count ;;
  }

  dimension: distinct_phase_count {
    label: "Phases Covered"
    group_label: "Session Stats"
    type: number
    sql: ${TABLE}.distinct_phase_count ;;
  }

  dimension: autopilot_command_count {
    label: "Autopilot Commands"
    group_label: "Session Stats"
    type: number
    sql: ${TABLE}.autopilot_command_count ;;
  }

  dimension: is_short_session {
    label: "Is Short Session (≤2 cmds)"
    group_label: "Session Stats"
    type: yesno
    sql: ${TABLE}.is_short_session ;;
  }

  dimension: did_run_autopilot {
    label: "Ran Autopilot"
    group_label: "Session Stats"
    type: yesno
    sql: ${TABLE}.did_run_autopilot ;;
  }

  dimension: did_3_phase_breadth {
    label: "3+ Phase Breadth"
    group_label: "Session Stats"
    type: yesno
    sql: ${TABLE}.did_3_phase_breadth ;;
  }

  dimension: session_outcome_class {
    label: "Session Outcome"
    group_label: "Session Stats"
    type: string
    sql: ${TABLE}.session_outcome_class ;;
  }

  # Measures
  measure: count {
    type: count
    label: "Sessions"
    drill_fields: [session_start_date, consultant_name, primary_git_repo_canonical, command_count, duration_minutes, session_outcome_class]
  }

  measure: total_commands {
    type: sum
    sql: ${command_count} ;;
    label: "Total Commands"
  }

  measure: avg_commands_per_session {
    type: average
    sql: ${command_count} ;;
    label: "Avg Commands / Session"
    value_format_name: decimal_1
  }

  measure: avg_duration_minutes {
    type: average
    sql: ${duration_seconds} / 60.0 ;;
    label: "Avg Session Duration (min)"
    value_format_name: decimal_1
  }

  measure: pct_autopilot_sessions {
    type: number
    sql: SAFE_DIVIDE(COUNTIF(${did_run_autopilot}), COUNT(*)) ;;
    label: "% Sessions with Autopilot"
    value_format_name: percent_1
  }

  measure: pct_short_sessions {
    type: number
    sql: SAFE_DIVIDE(COUNTIF(${is_short_session}), COUNT(*)) ;;
    label: "% Short Sessions"
    value_format_name: percent_1
  }

  measure: distinct_consultants {
    type: count_distinct
    sql: ${consultant_email} ;;
    label: "Distinct Consultants"
  }
}
