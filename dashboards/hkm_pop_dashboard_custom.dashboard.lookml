- dashboard: hkm_pop_dashboard_custom
  title: HKM Example PoP (Custom) Dashboard
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: OYWdYMVrGMUglf34ntCulA
  elements:

  # --- CHART 1: LINE CHART (Current vs Prior) ---
  - title: HKM Example Pop Custom Dashboard
    name: HKM Example Dashboard
    model: analytics
    explore: web_sessions_fact
    type: looker_line
    # CHANGE 1: Use Normalized date and pivot on Period
    fields: [web_sessions_fact.total_sessions, web_sessions_fact.period_normalized_date, web_sessions_fact.period]
    pivots: [web_sessions_fact.period]
    fill_fields: [web_sessions_fact.period_normalized_date]
    # CHANGE 2: Filter to remove rows that aren't in Current or Prior
    filters:
      web_sessions_fact.period: "-NULL"
    sorts: [web_sessions_fact.period_normalized_date desc, web_sessions_fact.period]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    # CHANGE 3: Listen to the new date_filter
    listen:
      Session Start Date: web_sessions_fact.date_filter
    row: 5
    col: 0
    width: 24
    height: 12

  # --- CHART 2: SINGLE VALUE TILE (Total with Comparison) ---
  - title: Total Sessions
    name: Total Sessions
    model: analytics
    explore: web_sessions_fact
    type: single_value
    # CHANGE 1: Remove date, keep measure and Period
    fields: [web_sessions_fact.total_sessions, web_sessions_fact.period]
    pivots: [web_sessions_fact.period]
    # CHANGE 2: Filter out NULL
    filters:
      web_sessions_fact.period: "-NULL"
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    # CHANGE 3: Enable Comparison
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    defaults_version: 1
    # CHANGE 4: Listen to the new date_filter
    listen:
      Session Start Date: web_sessions_fact.date_filter
    row: 0
    col: 0
    width: 6
    height: 5

  # --- FILTERS ---
  filters:
  - name: Session Start Date
    title: Session Start Date
    type: field_filter
    default_value: 30 days
    allow_multiple_values: false
    required: false
    ui_config:
      type: advanced      # Changed from 'relative_timeframes' to 'advanced'
      display: popover    # 'popover' looks cleanest for this
    model: analytics
    explore: web_sessions_fact
    listens_to_filters: []
    field: web_sessions_fact.date_filter
