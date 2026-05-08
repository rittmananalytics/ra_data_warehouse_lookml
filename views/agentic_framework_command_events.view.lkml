# agentic_framework_command_events.view.lkml
# Exposes the wh_agentic_framework_command_events_fact dbt table (alias: agentic_framework_command_events_fact)
# Table: ra-development.analytics.agentic_framework_command_events_fact
# Grain: one row per Wire CLI command event.

view: agentic_framework_command_events {
  sql_table_name: `ra-development.analytics.agentic_framework_command_events_fact` ;;

  # ── Primary key ───────────────────────────────────────────────────────────────

  dimension: pk {
    primary_key: yes
    hidden:      yes
    type:        string
    sql:         ${TABLE}.agentic_framework_command_event_pk ;;
  }

  # ── Identity ──────────────────────────────────────────────────────────────────

  dimension: consultant_email {
    label:       "Consultant Email"
    description: "Resolved RA consultant email via agentic_framework_username_map. NULL for unknown users."
    type:        string
    sql:         ${TABLE}.consultant_email ;;
  }

  dimension: consultant_name {
    label:       "Consultant Name"
    type:        string
    sql:         ${TABLE}.consultant_name ;;
  }

  dimension: username {
    label:       "Wire Username"
    description: "Shell `whoami` value at command-run time."
    type:        string
    sql:         ${TABLE}.username ;;
  }

  dimension: is_known_consultant {
    label:       "Is Known Consultant"
    description: "Yes when agentic_framework_username_map maps the username to a consultant."
    type:        yesno
    sql:         ${TABLE}.is_known_consultant ;;
  }

  # ── Command ───────────────────────────────────────────────────────────────────

  dimension: command_name {
    label:       "Command"
    description: "Full Wire slash-command name (e.g. semantic_layer-validate)."
    type:        string
    sql:         ${TABLE}.command_name ;;
    drill_fields: [artifact_name, action_name, phase_name]
  }

  dimension: artifact_name {
    label:       "Artifact"
    description: "Leading segment of command (e.g. semantic_layer)."
    type:        string
    sql:         ${TABLE}.artifact_name ;;
  }

  dimension: action_name {
    label:       "Action"
    description: "Trailing segment of command (e.g. validate). NULL for single-token commands."
    type:        string
    sql:         ${TABLE}.action_name ;;
  }

  dimension: phase_name {
    label:       "Phase"
    description: "Wire delivery phase the command belongs to."
    type:        string
    sql:         ${TABLE}.phase_name ;;
    suggestions: [
      "autopilot", "requirements", "data_model", "pipeline", "dbt",
      "semantic_layer", "dashboards", "data_quality", "deployment",
      "training", "documentation", "other"
    ]
  }

  dimension: is_autopilot {
    label:       "Is Autopilot"
    description: "Yes when the command was emitted from a /agentic_framework:autopilot run."
    type:        yesno
    sql:         ${TABLE}.is_autopilot ;;
  }

  # ── Repo / Git context ────────────────────────────────────────────────────────

  dimension: git_repo_canonical {
    label:       "Git Repo (owner/name)"
    description: "Normalised git remote in owner/name form."
    type:        string
    sql:         ${TABLE}.git_repo_canonical ;;
  }

  dimension: git_repo_owner {
    label:       "Git Repo Owner"
    type:        string
    sql:         ${TABLE}.git_repo_owner ;;
  }

  dimension: git_repo_name {
    label:       "Git Repo Name"
    type:        string
    sql:         ${TABLE}.git_repo_name ;;
  }

  dimension: git_branch {
    label:       "Git Branch"
    type:        string
    sql:         ${TABLE}.git_branch ;;
  }

  # ── Workstation ───────────────────────────────────────────────────────────────

  dimension: hostname {
    label:       "Hostname"
    type:        string
    sql:         ${TABLE}.hostname ;;
  }

  dimension: os {
    label:       "OS"
    type:        string
    sql:         ${TABLE}.os ;;
  }

  dimension: plugin_version {
    label:       "Wire Plugin Version"
    type:        string
    sql:         ${TABLE}.plugin_version ;;
  }

  dimension: runtime {
    label:       "Runtime"
    description: "Runtime emitting the command (currently 'claude')."
    type:        string
    sql:         ${TABLE}.runtime ;;
  }

  # ── Sequencing within session ─────────────────────────────────────────────────

  dimension: command_sequence_in_session {
    label:       "Command Sequence in Session"
    description: "1-indexed position of this command within its Wire session."
    type:        number
    sql:         ${TABLE}.command_sequence_in_session ;;
  }

  dimension: seconds_since_prev_command_in_session {
    label:       "Seconds Since Previous Command"
    description: "Time gap since the previous command in the same session."
    type:        number
    sql:         ${TABLE}.seconds_since_prev_command_in_session ;;
  }

  # ── Time ──────────────────────────────────────────────────────────────────────

  dimension_group: event {
    label:       "Event"
    description: "When the command was emitted by the Wire CLI."
    type:        time
    timeframes:  [time, hour, date, day_of_week, week, month, quarter, year]
    sql:         ${TABLE}.event_ts ;;
  }

  dimension: week_commencing {
    label:       "Week Commencing"
    type:        date
    sql:         ${TABLE}.week_commencing ;;
  }

  # ── Measures ──────────────────────────────────────────────────────────────────

  measure: command_count {
    label:       "Command Count"
    description: "Number of Wire commands."
    type:        sum
    sql:         ${TABLE}.command_count ;;
    drill_fields: [event_date, consultant_email, command_name, phase_name, git_repo_canonical]
  }

  measure: distinct_consultants {
    label:       "Distinct Consultants"
    type:        count_distinct
    sql:         ${TABLE}.consultant_email ;;
  }

  measure: distinct_commands {
    label:       "Distinct Commands"
    type:        count_distinct
    sql:         ${TABLE}.command_name ;;
  }

  measure: distinct_phases {
    label:       "Distinct Phases"
    type:        count_distinct
    sql:         ${TABLE}.phase_name ;;
  }

  measure: distinct_sessions {
    label:       "Distinct Sessions"
    type:        count_distinct
    sql:         ${TABLE}.agentic_framework_session_fk ;;
  }

  measure: distinct_repos {
    label:       "Distinct Repos"
    type:        count_distinct
    sql:         ${TABLE}.git_repo_canonical ;;
  }

  measure: autopilot_command_count {
    label:       "Autopilot Command Count"
    type:        sum
    sql:         CASE WHEN ${TABLE}.is_autopilot THEN ${TABLE}.command_count ELSE 0 END ;;
  }

  measure: pct_autopilot {
    label:       "% Autopilot"
    type:        number
    sql:         SAFE_DIVIDE(${autopilot_command_count}, NULLIF(${command_count}, 0)) * 100 ;;
    value_format: "0.0"
  }

  measure: avg_seconds_between_commands {
    label:       "Avg Seconds Between Commands (in session)"
    type:        average
    sql:         ${TABLE}.seconds_since_prev_command_in_session ;;
    value_format: "0"
  }
}
