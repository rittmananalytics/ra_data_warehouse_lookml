- dashboard: hkm_pop_dashboard_retail
  title: HKM Example Retail Dashboard
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: OYWdYMVrGMUglf34ntCulS
  elements:

  # --- CHART 1: LINE CHART (Current vs Prior) ---
  - title: HKM Example Dashboard
    name: HKM Example Dashboard
    model: analytics
    explore: web_sessions_fact
    type: looker_line
    fields: [web_sessions_fact.total_sessions, web_sessions_fact.period_normalized_date, web_sessions_fact.period]
    pivots: [web_sessions_fact.period]
    fill_fields: [web_sessions_fact.period_normalized_date]

    # Filter out rows that didn't match the selected criteria
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

    # LISTEN: Connects the Dashboard Filters to the View Fields
    listen:
      Period Selector: web_sessions_fact.period_selector
      Custom Date Range: web_sessions_fact.date_filter
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
    fields: [web_sessions_fact.total_sessions, web_sessions_fact.period]
    pivots: [web_sessions_fact.period]

    # Filter out rows that didn't match the selected criteria
    filters:
      web_sessions_fact.period: "-NULL"

    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
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

    # LISTEN: Connects the Dashboard Filters to the View Fields
    listen:
      Period Selector: web_sessions_fact.period_selector
      Custom Date Range: web_sessions_fact.date_filter
    row: 0
    col: 0
    width: 6
    height: 5

  # --- FILTERS CONFIGURATION ---
  filters:

  # 1. The Primary Selector (Retail Weeks, Months, or Custom)
  - name: Period Selector
    title: Period Selector
    type: field_filter
    default_value: "this_retail_week"
    allow_multiple_values: false
    required: true
    ui_config:
      type: button_toggles    # 'button_toggles' or 'dropdown_menu'
      display: inline
    model: analytics
    explore: web_sessions_fact
    field: web_sessions_fact.period_selector

  # 2. The Custom Date Picker (Only used if 'Custom Range' is selected above)
  - name: Custom Date Range
    title: Custom Date Range (Only if Custom Selected)
    type: field_filter
    default_value: "7 days"
    allow_multiple_values: false
    required: false
    ui_config:
      type: advanced          # Allows full date picker flexibility
      display: popover
    model: analytics
    explore: web_sessions_fact
    field: web_sessions_fact.date_filter
