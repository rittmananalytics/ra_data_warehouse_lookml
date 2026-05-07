- dashboard: developer_tooling_wire
  title: Wire Framework Analytics
  layout: newspaper
  preferred_viewer: dashboards-next
  description: 'Wire Framework CLI telemetry: adoption scores, session funnel, retention cohorts, command sequences, aha moments, and engagement decay.'

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
    explore: agentic_framework_command_events_fact
    field: agentic_framework_command_events_fact.consultant_name

  elements:

  # ---- KPI Row ----
  - title: Total Wire Commands
    name: total_wire_commands
    model: analytics
    explore: agentic_framework_command_events_fact
    type: single_value
    fields: [agentic_framework_command_events_fact.count]
    filters:
      agentic_framework_command_events_fact.is_known_consultant: 'Yes'
    listen:
      week_commencing: agentic_framework_command_events_fact.event_week
      consultant: agentic_framework_command_events_fact.consultant_name
    value_format:
    value_format_name: decimal_0
    row: 0
    col: 0
    width: 4
    height: 4

  - title: Active Consultants
    name: active_consultants_wire
    model: analytics
    explore: agentic_framework_command_events_fact
    type: single_value
    fields: [agentic_framework_command_events_fact.distinct_consultants]
    filters:
      agentic_framework_command_events_fact.is_known_consultant: 'Yes'
    listen:
      week_commencing: agentic_framework_command_events_fact.event_week
      consultant: agentic_framework_command_events_fact.consultant_name
    row: 0
    col: 4
    width: 4
    height: 4

  - title: Total Sessions
    name: total_wire_sessions
    model: analytics
    explore: agentic_framework_sessions_fact
    type: single_value
    fields: [agentic_framework_sessions_fact.count]
    filters:
      agentic_framework_sessions_fact.is_known_consultant: 'Yes'
    listen:
      week_commencing: agentic_framework_sessions_fact.session_start_week
      consultant: agentic_framework_sessions_fact.consultant_name
    row: 0
    col: 8
    width: 4
    height: 4

  - title: Avg Adoption Score
    name: avg_adoption_score
    model: analytics
    explore: agentic_framework_adoption_weekly_fact
    type: single_value
    fields: [agentic_framework_adoption_weekly_fact.avg_adoption_score]
    listen:
      week_commencing: agentic_framework_adoption_weekly_fact.week_commencing_date
      consultant: agentic_framework_adoption_weekly_fact.consultant_name
    value_format_name: decimal_1
    row: 0
    col: 12
    width: 4
    height: 4

  - title: Autopilot Commands %
    name: autopilot_pct_kpi
    model: analytics
    explore: agentic_framework_command_events_fact
    type: single_value
    fields: [agentic_framework_command_events_fact.autopilot_pct]
    filters:
      agentic_framework_command_events_fact.is_known_consultant: 'Yes'
    listen:
      week_commencing: agentic_framework_command_events_fact.event_week
      consultant: agentic_framework_command_events_fact.consultant_name
    value_format_name: percent_1
    row: 0
    col: 16
    width: 4
    height: 4

  - title: Avg Session Duration (min)
    name: avg_session_duration_wire
    model: analytics
    explore: agentic_framework_sessions_fact
    type: single_value
    fields: [agentic_framework_sessions_fact.avg_duration_minutes]
    filters:
      agentic_framework_sessions_fact.is_known_consultant: 'Yes'
    listen:
      week_commencing: agentic_framework_sessions_fact.session_start_week
      consultant: agentic_framework_sessions_fact.consultant_name
    value_format_name: decimal_1
    row: 0
    col: 20
    width: 4
    height: 4

  # ---- Adoption Score Over Time ----
  - title: Wire Adoption Score — Weekly Trend by Consultant
    name: wire_adoption_trend
    model: analytics
    explore: agentic_framework_adoption_weekly_fact
    type: looker_line
    fields: [agentic_framework_adoption_weekly_fact.week_commencing_date, agentic_framework_adoption_weekly_fact.consultant_name, agentic_framework_adoption_weekly_fact.avg_adoption_score]
    pivots: [agentic_framework_adoption_weekly_fact.consultant_name]
    fill_fields: [agentic_framework_adoption_weekly_fact.week_commencing_date]
    sorts: [agentic_framework_adoption_weekly_fact.week_commencing_date asc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_x_axis_label: true
    y_axis_scale_mode: linear
    interpolation: linear
    show_value_labels: false
    legend_position: right
    listen:
      week_commencing: agentic_framework_adoption_weekly_fact.week_commencing_date
      consultant: agentic_framework_adoption_weekly_fact.consultant_name
    row: 4
    col: 0
    width: 14
    height: 8

  # ---- Lifecycle Stage Distribution ----
  - title: Consultant Lifecycle Stages
    name: lifecycle_stage_dist
    model: analytics
    explore: developer_users_dim
    type: looker_pie
    fields: [developer_users_dim.agentic_framework_lifecycle_stage, developer_users_dim.count]
    sorts: [developer_users_dim.count desc]
    limit: 20
    show_value_labels: true
    legend_position: right
    row: 4
    col: 14
    width: 10
    height: 8

  # ---- Commands by Phase ----
  - title: Wire Commands by Phase — Weekly
    name: wire_commands_by_phase
    model: analytics
    explore: agentic_framework_command_events_fact
    type: looker_column
    fields: [agentic_framework_command_events_fact.event_week, agentic_framework_command_events_fact.phase_name, agentic_framework_command_events_fact.count]
    pivots: [agentic_framework_command_events_fact.phase_name]
    fill_fields: [agentic_framework_command_events_fact.event_week]
    sorts: [agentic_framework_command_events_fact.event_week asc]
    filters:
      agentic_framework_command_events_fact.is_known_consultant: 'Yes'
    limit: 500
    stacking: normal
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_value_labels: false
    legend_position: right
    listen:
      week_commencing: agentic_framework_command_events_fact.event_week
      consultant: agentic_framework_command_events_fact.consultant_name
    row: 12
    col: 0
    width: 14
    height: 8

  # ---- Top Commands ----
  - title: Top Wire Commands
    name: top_wire_commands
    model: analytics
    explore: agentic_framework_command_events_fact
    type: looker_bar
    fields: [agentic_framework_command_events_fact.command_name, agentic_framework_command_events_fact.count, agentic_framework_command_events_fact.distinct_consultants]
    sorts: [agentic_framework_command_events_fact.count desc]
    filters:
      agentic_framework_command_events_fact.is_known_consultant: 'Yes'
    limit: 20
    show_view_names: false
    show_value_labels: true
    legend_position: right
    listen:
      week_commencing: agentic_framework_command_events_fact.event_week
      consultant: agentic_framework_command_events_fact.consultant_name
    row: 12
    col: 14
    width: 10
    height: 8

  # ---- Session Funnel ----
  - title: Wire Session Funnel — Weekly
    name: wire_session_funnel
    model: analytics
    explore: agentic_framework_session_funnel_fact
    type: looker_column
    fields: [agentic_framework_session_funnel_fact.week_commencing_date, agentic_framework_session_funnel_fact.total_sessions, agentic_framework_session_funnel_fact.reached_2nd_command, agentic_framework_session_funnel_fact.reached_3plus_phases, agentic_framework_session_funnel_fact.reached_autopilot, agentic_framework_session_funnel_fact.reached_pr_merged]
    sorts: [agentic_framework_session_funnel_fact.week_commencing_date asc]
    limit: 52
    stacking: ''
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_value_labels: false
    legend_position: right
    listen:
      week_commencing: agentic_framework_session_funnel_fact.week_commencing_date
    row: 20
    col: 0
    width: 14
    height: 8

  # ---- Session Outcome ----
  - title: Session Outcome Classes
    name: session_outcome_classes
    model: analytics
    explore: agentic_framework_sessions_fact
    type: looker_pie
    fields: [agentic_framework_sessions_fact.session_outcome_class, agentic_framework_sessions_fact.count]
    sorts: [agentic_framework_sessions_fact.count desc]
    filters:
      agentic_framework_sessions_fact.is_known_consultant: 'Yes'
    limit: 20
    show_value_labels: true
    legend_position: right
    listen:
      week_commencing: agentic_framework_sessions_fact.session_start_week
      consultant: agentic_framework_sessions_fact.consultant_name
    row: 20
    col: 14
    width: 10
    height: 8

  # ---- Retention Cohort Heatmap ----
  - title: Wire Retention Cohort Heatmap
    name: wire_retention_cohort
    model: analytics
    explore: agentic_framework_user_retention_cohorts_fact
    type: looker_grid
    fields: [agentic_framework_user_retention_cohorts_fact.cohort_week, agentic_framework_user_retention_cohorts_fact.weeks_since_cohort, agentic_framework_user_retention_cohorts_fact.avg_retention_pct]
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
      fields: [agentic_framework_user_retention_cohorts_fact.avg_retention_pct]
    row: 28
    col: 0
    width: 24
    height: 8

  # ---- Time to Aha ----
  - title: Distribution of Days to Aha Moment
    name: days_to_aha_dist
    model: analytics
    explore: agentic_framework_aha_moment_fact
    type: looker_bar
    fields: [agentic_framework_aha_moment_fact.days_to_aha_tier, agentic_framework_aha_moment_fact.count]
    filters:
      agentic_framework_aha_moment_fact.did_hit_aha: 'Yes'
    sorts: [agentic_framework_aha_moment_fact.days_to_aha_tier asc]
    limit: 20
    show_view_names: false
    show_value_labels: true
    row: 36
    col: 0
    width: 12
    height: 8

  # ---- Aha Moment Stats ----
  - title: Aha Moment — Consultant Summary
    name: aha_consultant_summary
    model: analytics
    explore: agentic_framework_aha_moment_fact
    type: looker_grid
    fields: [agentic_framework_aha_moment_fact.consultant_name, agentic_framework_aha_moment_fact.first_active_week, agentic_framework_aha_moment_fact.aha_week_commencing, agentic_framework_aha_moment_fact.days_to_aha, agentic_framework_aha_moment_fact.lifecycle_stage, agentic_framework_aha_moment_fact.weeks_active_after_aha]
    sorts: [agentic_framework_aha_moment_fact.days_to_aha asc]
    limit: 20
    show_view_names: false
    row: 36
    col: 12
    width: 12
    height: 8

  # ---- Engagement Decay ----
  - title: Engagement Decay — Active Users Over Time
    name: engagement_decay_trend
    model: analytics
    explore: agentic_framework_engagement_decay_fact
    type: looker_line
    fields: [agentic_framework_engagement_decay_fact.week_commencing_date, agentic_framework_engagement_decay_fact.active_consultants_7d, agentic_framework_engagement_decay_fact.active_consultants_28d]
    fill_fields: [agentic_framework_engagement_decay_fact.week_commencing_date]
    sorts: [agentic_framework_engagement_decay_fact.week_commencing_date asc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_value_labels: false
    interpolation: linear
    legend_position: right
    row: 44
    col: 0
    width: 14
    height: 8

  # ---- Command Sequences ----
  - title: Top Wire Command Transitions (Next Command After X)
    name: wire_command_sequences
    model: analytics
    explore: agentic_framework_command_sequences_fact
    type: looker_grid
    fields: [agentic_framework_command_sequences_fact.command_a, agentic_framework_command_sequences_fact.command_b, agentic_framework_command_sequences_fact.total_transitions, agentic_framework_command_sequences_fact.distinct_consultants, agentic_framework_command_sequences_fact.avg_gap_seconds_agg]
    sorts: [agentic_framework_command_sequences_fact.total_transitions desc]
    limit: 25
    show_view_names: false
    row: 44
    col: 14
    width: 10
    height: 8
