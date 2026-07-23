- dashboard: developer_tooling_claude_code
  title: Claude Code Analytics
  layout: newspaper
  preferred_viewer: dashboards-next
  description: 'Claude Code prompt telemetry: prompt volume, slash command usage, session behaviour, and project activity.'

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
    col: 0
    width: 12
    height: 8

  # ---- Prompts by Consultant Over Time ----
  - title: Prompts by Consultant — Weekly
    name: cc_prompts_by_consultant
    model: analytics
    explore: coding_agent_prompts_fact
    type: looker_column
    fields: [coding_agent_prompts_fact.event_week, coding_agent_prompts_fact.consultant_name, coding_agent_prompts_fact.count]
    pivots: [coding_agent_prompts_fact.consultant_name]
    fill_fields: [coding_agent_prompts_fact.event_week]
    sorts: [coding_agent_prompts_fact.event_week asc]
    filters:
      coding_agent_prompts_fact.is_known_consultant: 'Yes'
    limit: 500
    stacking: normal
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_value_labels: false
    legend_position: right
    listen:
      week_commencing: coding_agent_prompts_fact.event_week
      consultant: coding_agent_prompts_fact.consultant_name
    row: 4
    col: 12
    width: 12
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
      coding_agent_prompts_fact.is_slash_command: 'No'
      coding_agent_prompts_fact.is_known_consultant: 'Yes'
    sorts: [coding_agent_prompts_fact.prompt_word_count asc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_value_labels: false
    listen:
      week_commencing: coding_agent_prompts_fact.event_week
      consultant: coding_agent_prompts_fact.consultant_name
    row: 12
    col: 0
    width: 14
    height: 8

  # ---- Top Projects ----
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
    row: 12
    col: 14
    width: 10
    height: 8
