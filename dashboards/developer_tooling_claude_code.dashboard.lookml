- dashboard: developer_tooling_claude_code
  title: Claude Code Analytics
  layout: newspaper
  preferred_viewer: dashboards-next
  description: 'Claude Code prompt telemetry: prompt volume, slash command catalog, adoption, session behaviour, and retention cohorts.'

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
    explore: coding_agent_prompts_fact
    field: coding_agent_prompts_fact.consultant_name

  elements:

  # ---- KPI Row ----
  - title: Total Prompts
    name: total_cc_prompts
    model: analytics
    explore: coding_agent_prompts_fact
    type: single_value
    fields: [coding_agent_prompts_fact.count]
    filters:
      coding_agent_prompts_fact.is_known_consultant: 'Yes'
    listen:
      week_commencing: coding_agent_prompts_fact.event_week
      consultant: coding_agent_prompts_fact.consultant_name
    value_format_name: decimal_0
    row: 0
    col: 0
    width: 4
    height: 4

  - title: Active Users
    name: active_cc_users
    model: analytics
    explore: coding_agent_prompts_fact
    type: single_value
    fields: [coding_agent_prompts_fact.distinct_users]
    filters:
      coding_agent_prompts_fact.is_known_consultant: 'Yes'
    listen:
      week_commencing: coding_agent_prompts_fact.event_week
      consultant: coding_agent_prompts_fact.consultant_name
    row: 0
    col: 4
    width: 4
    height: 4

  - title: Slash Commands
    name: total_slash_cmds
    model: analytics
    explore: coding_agent_prompts_fact
    type: single_value
    fields: [coding_agent_prompts_fact.slash_command_count]
    filters:
      coding_agent_prompts_fact.is_known_consultant: 'Yes'
    listen:
      week_commencing: coding_agent_prompts_fact.event_week
      consultant: coding_agent_prompts_fact.consultant_name
    row: 0
    col: 8
    width: 4
    height: 4

  - title: Slash Command %
    name: slash_pct_kpi
    model: analytics
    explore: coding_agent_prompts_fact
    type: single_value
    fields: [coding_agent_prompts_fact.pct_slash_commands]
    filters:
      coding_agent_prompts_fact.is_known_consultant: 'Yes'
    listen:
      week_commencing: coding_agent_prompts_fact.event_week
      consultant: coding_agent_prompts_fact.consultant_name
    value_format_name: percent_1
    row: 0
    col: 12
    width: 4
    height: 4

  - title: Wire Commands via CC
    name: wire_via_cc_kpi
    model: analytics
    explore: coding_agent_prompts_fact
    type: single_value
    fields: [coding_agent_prompts_fact.wire_slash_command_count]
    filters:
      coding_agent_prompts_fact.is_known_consultant: 'Yes'
    listen:
      week_commencing: coding_agent_prompts_fact.event_week
      consultant: coding_agent_prompts_fact.consultant_name
    row: 0
    col: 16
    width: 4
    height: 4

  - title: Avg Words / Prompt
    name: avg_words_kpi
    model: analytics
    explore: coding_agent_prompts_fact
    type: single_value
    fields: [coding_agent_prompts_fact.avg_word_count]
    filters:
      coding_agent_prompts_fact.is_known_consultant: 'Yes'
    listen:
      week_commencing: coding_agent_prompts_fact.event_week
      consultant: coding_agent_prompts_fact.consultant_name
    value_format_name: decimal_1
    row: 0
    col: 20
    width: 4
    height: 4

  # ---- Prompt Volume Over Time ----
  - title: Daily Prompt Volume — All Consultants
    name: cc_daily_volume
    model: analytics
    explore: coding_agent_prompt_volume_fact
    type: looker_line
    fields: [coding_agent_prompt_volume_fact.week_commencing, coding_agent_prompt_volume_fact.total_prompts, coding_agent_prompt_volume_fact.total_slash_commands, coding_agent_prompt_volume_fact.total_free_form]
    fill_fields: [coding_agent_prompt_volume_fact.week_commencing]
    sorts: [coding_agent_prompt_volume_fact.week_commencing asc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_value_labels: false
    legend_position: right
    interpolation: linear
    listen:
      week_commencing: coding_agent_prompt_volume_fact.week_commencing
      consultant: coding_agent_prompt_volume_fact.consultant_name
    row: 4
    col: 0
    width: 14
    height: 8

  # ---- Prompt Type Split ----
  - title: Prompt Type Mix
    name: prompt_type_mix
    model: analytics
    explore: coding_agent_prompts_fact
    type: looker_pie
    fields: [coding_agent_prompts_fact.is_slash_command, coding_agent_prompts_fact.count]
    filters:
      coding_agent_prompts_fact.is_known_consultant: 'Yes'
    listen:
      week_commencing: coding_agent_prompts_fact.event_week
      consultant: coding_agent_prompts_fact.consultant_name
    show_value_labels: true
    legend_position: right
    row: 4
    col: 14
    width: 10
    height: 8

  # ---- Top Slash Commands by Usage ----
  - title: Top Claude Code Slash Commands
    name: top_cc_commands
    model: analytics
    explore: coding_agent_command_usage_fact
    type: looker_bar
    fields: [coding_agent_command_usage_fact.command_raw, coding_agent_command_usage_fact.total_invocations_sum, coding_agent_command_usage_fact.total_distinct_users]
    sorts: [coding_agent_command_usage_fact.total_invocations_sum desc]
    limit: 20
    show_view_names: false
    show_value_labels: true
    legend_position: right
    row: 12
    col: 0
    width: 12
    height: 10

  # ---- Commands by Namespace ----
  - title: Commands by Namespace
    name: commands_by_namespace
    model: analytics
    explore: coding_agent_command_usage_fact
    type: looker_bar
    fields: [coding_agent_command_usage_fact.namespace, coding_agent_command_usage_fact.total_invocations_sum]
    sorts: [coding_agent_command_usage_fact.total_invocations_sum desc]
    limit: 20
    show_view_names: false
    show_value_labels: true
    row: 12
    col: 12
    width: 12
    height: 10

  # ---- Prompt Volume by Consultant ----
  - title: Prompt Volume by Consultant — Weekly
    name: cc_volume_by_consultant
    model: analytics
    explore: coding_agent_prompt_volume_fact
    type: looker_column
    fields: [coding_agent_prompt_volume_fact.week_commencing, coding_agent_prompt_volume_fact.consultant_name, coding_agent_prompt_volume_fact.total_prompts]
    pivots: [coding_agent_prompt_volume_fact.consultant_name]
    fill_fields: [coding_agent_prompt_volume_fact.week_commencing]
    sorts: [coding_agent_prompt_volume_fact.week_commencing asc]
    limit: 500
    stacking: normal
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_value_labels: false
    legend_position: right
    listen:
      week_commencing: coding_agent_prompt_volume_fact.week_commencing
      consultant: coding_agent_prompt_volume_fact.consultant_name
    row: 22
    col: 0
    width: 14
    height: 8

  # ---- Session Stats ----
  - title: Avg Claude Code Session Duration (min) — Weekly
    name: cc_session_duration
    model: analytics
    explore: coding_agent_sessions_fact
    type: looker_line
    fields: [coding_agent_sessions_fact.session_start_week, coding_agent_sessions_fact.avg_duration_minutes, coding_agent_sessions_fact.avg_prompts_per_session]
    fill_fields: [coding_agent_sessions_fact.session_start_week]
    sorts: [coding_agent_sessions_fact.session_start_week asc]
    filters:
      coding_agent_sessions_fact.is_known_consultant: 'Yes'
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_value_labels: false
    legend_position: right
    interpolation: linear
    listen:
      week_commencing: coding_agent_sessions_fact.session_start_week
      consultant: coding_agent_sessions_fact.user_email
    row: 22
    col: 14
    width: 10
    height: 8

  # ---- Retention Cohort Heatmap ----
  - title: Claude Code Retention Cohort Heatmap
    name: cc_retention_cohort
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
    row: 30
    col: 0
    width: 24
    height: 8

  # ---- Prompt Word Count Distribution ----
  - title: Prompt Word Count Distribution
    name: prompt_word_dist
    model: analytics
    explore: coding_agent_prompts_fact
    type: looker_column
    fields: [coding_agent_prompts_fact.prompt_word_count, coding_agent_prompts_fact.count]
    filters:
      coding_agent_prompts_fact.prompt_word_count: '>0'
      coding_agent_prompts_fact.prompt_word_count: '<=500'
      coding_agent_prompts_fact.is_slash_command: 'No'
    sorts: [coding_agent_prompts_fact.prompt_word_count asc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_value_labels: false
    listen:
      week_commencing: coding_agent_prompts_fact.event_week
      consultant: coding_agent_prompts_fact.consultant_name
    row: 38
    col: 0
    width: 14
    height: 8

  # ---- Project Dir Activity ----
  - title: Top Projects (by Claude Code Activity)
    name: top_cc_projects
    model: analytics
    explore: coding_agent_prompts_fact
    type: looker_bar
    fields: [coding_agent_prompts_fact.project_dir_basename, coding_agent_prompts_fact.count, coding_agent_prompts_fact.distinct_users]
    filters:
      coding_agent_prompts_fact.project_dir_basename: '-NULL'
      coding_agent_prompts_fact.is_known_consultant: 'Yes'
    sorts: [coding_agent_prompts_fact.count desc]
    limit: 15
    show_view_names: false
    show_value_labels: true
    listen:
      week_commencing: coding_agent_prompts_fact.event_week
      consultant: coding_agent_prompts_fact.consultant_name
    row: 38
    col: 14
    width: 10
    height: 8
