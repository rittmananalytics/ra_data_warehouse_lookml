- dashboard: developer_tooling_cross_tool
  title: Cross-Tool Developer Analytics (Wire + Claude Code)
  layout: newspaper
  preferred_viewer: dashboards-next
  description: 'Unified Wire + Claude Code analytics: substitution analysis, pre/post adjacency, session composition, cross-tool lifecycle stages, and correction patterns.'

  filters:
  - name: week_commencing
    title: Week
    type: date_filter
    default_value: '90 days'
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline

  - name: consultant
    title: Consultant
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
    model: analytics
    explore: developer_activity_fact
    field: developer_activity_fact.consultant_email

  elements:

  # ---- KPI Row ----
  - title: Total Developer Events
    name: total_dev_events
    model: analytics
    explore: developer_activity_fact
    type: single_value
    fields: [developer_activity_fact.count]
    listen:
      week_commencing: developer_activity_fact.event_week
      consultant: developer_activity_fact.consultant_email
    value_format_name: decimal_0
    row: 0
    col: 0
    width: 4
    height: 4

  - title: Wire Events
    name: wire_events_kpi
    model: analytics
    explore: developer_activity_fact
    type: single_value
    fields: [developer_activity_fact.wire_event_count]
    listen:
      week_commencing: developer_activity_fact.event_week
      consultant: developer_activity_fact.consultant_email
    row: 0
    col: 4
    width: 4
    height: 4

  - title: Claude Code Events
    name: cc_events_kpi
    model: analytics
    explore: developer_activity_fact
    type: single_value
    fields: [developer_activity_fact.claude_code_event_count]
    listen:
      week_commencing: developer_activity_fact.event_week
      consultant: developer_activity_fact.consultant_email
    row: 0
    col: 8
    width: 4
    height: 4

  - title: Total Developer Sessions
    name: total_dev_sessions
    model: analytics
    explore: developer_sessions_fact
    type: single_value
    fields: [developer_sessions_fact.count]
    listen:
      week_commencing: developer_sessions_fact.session_start_week
      consultant: developer_sessions_fact.consultant_email
    row: 0
    col: 12
    width: 4
    height: 4

  - title: Cross-Tool Sessions
    name: cross_tool_sessions_kpi
    model: analytics
    explore: developer_sessions_fact
    type: single_value
    fields: [developer_sessions_fact.cross_tool_sessions]
    listen:
      week_commencing: developer_sessions_fact.session_start_week
      consultant: developer_sessions_fact.consultant_email
    row: 0
    col: 16
    width: 4
    height: 4

  - title: Distinct Consultants (Both Tools)
    name: cross_tool_consultants
    model: analytics
    explore: developer_users_dim
    type: single_value
    fields: [developer_users_dim.count]
    row: 0
    col: 20
    width: 4
    height: 4

  # ---- Wire vs CC Events Over Time ----
  - title: Wire vs Claude Code Events — Weekly
    name: wire_vs_cc_weekly
    model: analytics
    explore: developer_activity_fact
    type: looker_line
    fields: [developer_activity_fact.event_week, developer_activity_fact.source_system, developer_activity_fact.count]
    pivots: [developer_activity_fact.source_system]
    fill_fields: [developer_activity_fact.event_week]
    sorts: [developer_activity_fact.event_week asc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_value_labels: false
    legend_position: right
    interpolation: linear
    listen:
      week_commencing: developer_activity_fact.event_week
      consultant: developer_activity_fact.consultant_email
    row: 4
    col: 0
    width: 14
    height: 8

  # ---- Cross-Tool Stage Distribution ----
  - title: Developer Cross-Tool Stage Distribution
    name: cross_tool_stage_dist
    model: analytics
    explore: developer_users_dim
    type: looker_pie
    fields: [developer_users_dim.cross_tool_stage, developer_users_dim.count]
    sorts: [developer_users_dim.count desc]
    limit: 20
    show_value_labels: true
    legend_position: right
    row: 4
    col: 14
    width: 10
    height: 8

  # ---- Session Composition Over Time ----
  - title: Session Composition — Weekly
    name: session_composition_weekly
    model: analytics
    explore: developer_session_composition_fact
    type: looker_column
    fields: [developer_session_composition_fact.session_start_week, developer_session_composition_fact.session_composition, developer_session_composition_fact.total_sessions]
    pivots: [developer_session_composition_fact.session_composition]
    fill_fields: [developer_session_composition_fact.session_start_week]
    sorts: [developer_session_composition_fact.session_start_week asc]
    limit: 500
    stacking: percent
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_value_labels: false
    legend_position: right
    listen:
      week_commencing: developer_session_composition_fact.session_start_week
    row: 12
    col: 0
    width: 14
    height: 8

  # ---- Session Composition Mix ----
  - title: Overall Session Composition Mix
    name: session_composition_mix
    model: analytics
    explore: developer_sessions_fact
    type: looker_pie
    fields: [developer_sessions_fact.session_composition, developer_sessions_fact.count]
    sorts: [developer_sessions_fact.count desc]
    limit: 20
    show_value_labels: true
    legend_position: right
    listen:
      week_commencing: developer_sessions_fact.session_start_week
      consultant: developer_sessions_fact.consultant_email
    row: 12
    col: 14
    width: 10
    height: 8

  # ---- Wire vs CC Substitution ----
  - title: Wire-vs-CC Substitution — Top Patterns by Phase
    name: substitution_top
    model: analytics
    explore: cross_tool_substitution_fact
    type: looker_grid
    fields: [cross_tool_substitution_fact.agentic_framework_phase_substituted, cross_tool_substitution_fact.coding_agent_substitute_command, cross_tool_substitution_fact.total_substitutions, cross_tool_substitution_fact.distinct_consultants, cross_tool_substitution_fact.distinct_sessions, cross_tool_substitution_fact.last_observed_date]
    sorts: [cross_tool_substitution_fact.total_substitutions desc]
    limit: 30
    show_view_names: false
    row: 20
    col: 0
    width: 24
    height: 10

  # ---- Substitution by Phase (Bar) ----
  - title: Substitution Count by Wire Phase
    name: substitution_by_phase
    model: analytics
    explore: cross_tool_substitution_fact
    type: looker_bar
    fields: [cross_tool_substitution_fact.agentic_framework_phase_substituted, cross_tool_substitution_fact.total_substitutions]
    sorts: [cross_tool_substitution_fact.total_substitutions desc]
    limit: 20
    show_view_names: false
    show_value_labels: true
    row: 30
    col: 0
    width: 12
    height: 8

  # ---- Pre/Post Adjacency ----
  - title: Wire-CC Adjacency — Pre vs Post by Wire Command
    name: adjacency_pre_post
    model: analytics
    explore: cross_tool_pre_post_adjacency_fact
    type: looker_column
    fields: [cross_tool_pre_post_adjacency_fact.agentic_framework_command_name, cross_tool_pre_post_adjacency_fact.temporal_relation, cross_tool_pre_post_adjacency_fact.total_occurrences]
    pivots: [cross_tool_pre_post_adjacency_fact.temporal_relation]
    sorts: [cross_tool_pre_post_adjacency_fact.agentic_framework_command_name asc]
    limit: 500
    stacking: normal
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_value_labels: false
    legend_position: right
    row: 30
    col: 12
    width: 12
    height: 8

  # ---- Adjacency Detail Table ----
  - title: Pre/Post Adjacency — Full Detail
    name: adjacency_detail
    model: analytics
    explore: cross_tool_pre_post_adjacency_fact
    type: looker_grid
    fields: [cross_tool_pre_post_adjacency_fact.agentic_framework_command_name, cross_tool_pre_post_adjacency_fact.agentic_framework_phase_name, cross_tool_pre_post_adjacency_fact.temporal_relation, cross_tool_pre_post_adjacency_fact.coding_agent_category, cross_tool_pre_post_adjacency_fact.total_occurrences, cross_tool_pre_post_adjacency_fact.distinct_consultants, cross_tool_pre_post_adjacency_fact.median_offset_seconds]
    sorts: [cross_tool_pre_post_adjacency_fact.total_occurrences desc]
    limit: 50
    show_view_names: false
    row: 38
    col: 0
    width: 24
    height: 10

  # ---- Correction Patterns ----
  - title: Wire Correction Patterns — Claude Code Follow-Up Categories
    name: correction_patterns
    model: analytics
    explore: cross_tool_correction_patterns_fact
    type: looker_bar
    fields: [cross_tool_correction_patterns_fact.agentic_framework_command_name, cross_tool_correction_patterns_fact.coding_agent_bucket, cross_tool_correction_patterns_fact.total_occurrences]
    pivots: [cross_tool_correction_patterns_fact.coding_agent_bucket]
    sorts: [cross_tool_correction_patterns_fact.agentic_framework_command_name asc]
    limit: 500
    stacking: normal
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_value_labels: false
    legend_position: right
    row: 48
    col: 0
    width: 14
    height: 8

  # ---- Correction Patterns Table ----
  - title: Correction Patterns — Full Table
    name: correction_patterns_table
    model: analytics
    explore: cross_tool_correction_patterns_fact
    type: looker_grid
    fields: [cross_tool_correction_patterns_fact.agentic_framework_command_name, cross_tool_correction_patterns_fact.agentic_framework_phase_name, cross_tool_correction_patterns_fact.coding_agent_bucket, cross_tool_correction_patterns_fact.total_occurrences, cross_tool_correction_patterns_fact.distinct_consultants, cross_tool_correction_patterns_fact.median_offset_seconds_after_agentic_framework]
    sorts: [cross_tool_correction_patterns_fact.total_occurrences desc]
    limit: 30
    show_view_names: false
    row: 48
    col: 14
    width: 10
    height: 8

  # ---- Developer User Profiles ----
  - title: Developer User Profiles
    name: developer_user_profiles
    model: analytics
    explore: developer_users_dim
    type: looker_grid
    fields: [developer_users_dim.consultant_name, developer_users_dim.cross_tool_stage, developer_users_dim.agentic_framework_lifecycle_stage, developer_users_dim.agentic_framework_lifetime_commands, developer_users_dim.agentic_framework_days_to_aha, developer_users_dim.coding_agent_lifetime_prompts, developer_users_dim.coding_agent_lifetime_slash_commands, developer_users_dim.coding_agent_lifetime_agentic_framework_slash_commands]
    sorts: [developer_users_dim.agentic_framework_lifetime_commands desc]
    limit: 50
    show_view_names: false
    row: 56
    col: 0
    width: 24
    height: 10

  # ---- Wire vs CC Retention Side-by-Side ----
  - title: Wire Retention Cohorts (Weekly)
    name: wire_retention_xtool
    model: analytics
    explore: agentic_framework_user_retention_cohorts_fact
    type: looker_grid
    fields: [agentic_framework_user_retention_cohorts_fact.cohort_week, agentic_framework_user_retention_cohorts_fact.weeks_since_cohort, agentic_framework_user_retention_cohorts_fact.pct_retained]
    pivots: [agentic_framework_user_retention_cohorts_fact.weeks_since_cohort]
    sorts: [agentic_framework_user_retention_cohorts_fact.cohort_week asc, agentic_framework_user_retention_cohorts_fact.weeks_since_cohort asc]
    limit: 500
    show_view_names: false
    show_row_numbers: false
    conditional_formatting:
    - type: along a scale
      value: null
      background_color: ''
      font_color: ''
      color_application:
        collection_id: b43731d5-dc87-4a8e-b807-635bef3948e1
        palette_id: 4a886745-44bb-4e87-9c7c-8c47a0eac46b
        options:
          steps: 10
          reverse: false
      bold: false
      italic: false
      strikethrough: false
      fields: [agentic_framework_user_retention_cohorts_fact.pct_retained]
    row: 66
    col: 0
    width: 12
    height: 8

  - title: Claude Code Retention Cohorts (Weekly)
    name: cc_retention_xtool
    model: analytics
    explore: coding_agent_user_retention_cohorts_fact
    type: looker_grid
    fields: [coding_agent_user_retention_cohorts_fact.cohort_week, coding_agent_user_retention_cohorts_fact.weeks_since_cohort, coding_agent_user_retention_cohorts_fact.pct_retained]
    pivots: [coding_agent_user_retention_cohorts_fact.weeks_since_cohort]
    sorts: [coding_agent_user_retention_cohorts_fact.cohort_week asc, coding_agent_user_retention_cohorts_fact.weeks_since_cohort asc]
    limit: 500
    show_view_names: false
    show_row_numbers: false
    conditional_formatting:
    - type: along a scale
      value: null
      background_color: ''
      font_color: ''
      color_application:
        collection_id: b43731d5-dc87-4a8e-b807-635bef3948e1
        palette_id: 4a886745-44bb-4e87-9c7c-8c47a0eac46b
        options:
          steps: 10
          reverse: false
      bold: false
      italic: false
      strikethrough: false
      fields: [coding_agent_user_retention_cohorts_fact.pct_retained]
    row: 66
    col: 12
    width: 12
    height: 8
