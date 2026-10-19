- dashboard: engagement_rag_status_2026
  title: Engagement RAG Status 2026
  preferred_viewer: dashboards-next
  style: classic
  description: One engagement, one month. Delivery and commercial status computed
    from Harvest and Xero, with written commentary and the actions that follow from
    it.
  refresh: 30 minutes
  preferred_slug: 5H48Op4Czy3h1xl3JiP8B7
  theme_name: RA
  layout_granularity: granular
  layout: newspaper
  tabs:
  - name: ''
    label: ''
  elements:
  - title: Engagement
    name: Engagement
    model: analytics
    explore: engagement_health_fact
    type: single_value
    fields: [engagement_health_fact.engagement_name]
    limit: 1
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    font_size: large
    text_color: "#3a4245"
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
      Reporting Month: engagement_health_fact.reporting_month_month
    row: 0
    col: 0
    width: 72
    height: 6
    tab_name: ''
  - title: Budget Used
    name: Budget Used
    model: analytics
    explore: engagement_health_fact
    type: single_value
    fields: [engagement_health_fact.budget_used_pct_value]
    limit: 1
    value_format: 0"%"
    single_value_title: Budget Used
    show_single_value_title: true
    show_comparison: false
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
      Reporting Month: engagement_health_fact.reporting_month_month
    row: 14
    col: 0
    width: 12
    height: 6
    tab_name: ''
  - title: Through Scheduled Days
    name: Through Scheduled Days
    model: analytics
    explore: engagement_health_fact
    type: single_value
    fields: [engagement_health_fact.elapsed_pct_value]
    limit: 1
    value_format: 0"%"
    single_value_title: Through Scheduled Days
    show_single_value_title: true
    show_comparison: false
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
      Reporting Month: engagement_health_fact.reporting_month_month
    row: 14
    col: 12
    width: 12
    height: 6
    tab_name: ''
  - title: Budget Exhausted On
    name: Budget Exhausted On
    model: analytics
    explore: engagement_health_fact
    type: single_value
    fields: [engagement_health_fact.budget_exhausted_date]
    limit: 1
    single_value_title: Budget Exhausted On
    show_single_value_title: true
    show_comparison: false
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
      Reporting Month: engagement_health_fact.reporting_month_month
    row: 14
    col: 24
    width: 12
    height: 6
    tab_name: ''
  - title: Realised Hourly Rate
    name: Realised Hourly Rate
    model: analytics
    explore: engagement_health_fact
    type: single_value
    fields: [engagement_health_fact.realised_rate_value]
    limit: 1
    value_format: '"£"#,##0'
    single_value_title: Realised Hourly Rate
    show_single_value_title: true
    show_comparison: false
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
      Reporting Month: engagement_health_fact.reporting_month_month
    row: 20
    col: 0
    width: 12
    height: 6
    tab_name: ''
  - title: Earned Margin
    name: Earned Margin
    model: analytics
    explore: engagement_health_fact
    type: single_value
    fields: [engagement_health_fact.earned_margin_pct_value]
    limit: 1
    value_format: 0"%"
    single_value_title: Earned Margin
    show_single_value_title: true
    show_comparison: false
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
      Reporting Month: engagement_health_fact.reporting_month_month
    row: 20
    col: 12
    width: 12
    height: 6
    tab_name: ''
  - title: Invoiced And Past Due
    name: Invoiced And Past Due
    model: analytics
    explore: engagement_health_fact
    type: single_value
    fields: [engagement_health_fact.overdue_amount_value]
    limit: 1
    value_format: '"£"#,##0'
    single_value_title: Invoiced And Past Due
    show_single_value_title: true
    show_comparison: false
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
      Reporting Month: engagement_health_fact.reporting_month_month
    row: 20
    col: 24
    width: 12
    height: 6
    tab_name: ''
  - title: Overall
    name: Overall
    model: analytics
    explore: engagement_health_fact
    type: looker_grid
    fields: [engagement_health_fact.engagement_code, engagement_health_fact.overall_status_block]
    filters:
      engagement_health_fact.reporting_month_month: 12 months
    sorts: [engagement_health_fact.engagement_code]
    limit: 1
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: true
    hide_row_totals: true
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: true
    enable_conditional_formatting: false
    header_text_alignment: center
    header_font_size: '14'
    rows_font_size: '70'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      engagement_health_fact.overall_status_block: Overall
    table_show_footer: false
    table_enable_pagination: false
    table_page_size_options: 20, 50, 100
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '1'
    table_column_hover_highlight_enable: false
    table_show_headers: true
    header_font_bold: false
    header_font_italic: false
    cell_font_weight: ''
    cell_font_style: ''
    cell_text_alignment: ''
    table_custom_border_enable: false
    table_custom_border_width:
    table_custom_border_style: solid
    hidden_fields: [engagement_health_fact.engagement_code]
    defaults_version: 1
    modern2026: false
    title_hidden: true
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
      Reporting Month: engagement_health_fact.reporting_month_month
    row: 6
    col: 0
    width: 27
    height: 8
    tab_name: ''
  - title: RAG Status
    name: RAG Status
    model: analytics
    explore: engagement_health_fact
    type: looker_grid
    fields: [engagement_health_fact.engagement_code, engagement_health_fact.delivery_status_block,
      engagement_health_fact.commercial_status_block, engagement_health_fact.client_status_block]
    filters:
      engagement_health_fact.reporting_month_month: 12 months
    sorts: [engagement_health_fact.engagement_code]
    limit: 1
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: true
    hide_row_totals: true
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: true
    enable_conditional_formatting: false
    header_text_alignment: center
    header_font_size: '14'
    rows_font_size: '73'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      engagement_health_fact.delivery_status_block: Delivery
      engagement_health_fact.commercial_status_block: Commercial
      engagement_health_fact.client_status_block: Client
    table_show_footer: false
    table_enable_pagination: false
    table_page_size_options: 20, 50, 100
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '1'
    table_column_hover_highlight_enable: false
    table_show_headers: true
    header_font_bold: false
    header_font_italic: false
    cell_font_weight: ''
    cell_font_style: ''
    cell_text_alignment: ''
    table_custom_border_enable: false
    table_custom_border_width:
    table_custom_border_style: solid
    hidden_fields: [engagement_health_fact.engagement_code]
    defaults_version: 1
    modern2026: false
    title_hidden: true
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
      Reporting Month: engagement_health_fact.reporting_month_month
    row: 6
    col: 27
    width: 44
    height: 8
    tab_name: ''
  - title: What Drove Each Status
    name: What Drove Each Status
    model: analytics
    explore: engagement_health_fact
    type: looker_grid
    fields: [engagement_health_fact.delivery_status_caption, engagement_health_fact.commercial_status_caption,
      engagement_health_fact.client_status_caption]
    limit: 1
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: true
    hide_row_totals: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: true
    enable_conditional_formatting: false
    header_text_alignment: center
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    truncate_header: false
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '1'
    show_sql_query_menu_options: false
    series_labels:
      engagement_health_fact.delivery_status_caption: Delivery
      engagement_health_fact.commercial_status_caption: Commercial
      engagement_health_fact.client_status_caption: Client
    defaults_version: 1
    modern2026: false
    title_hidden: true
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
      Reporting Month: engagement_health_fact.reporting_month_month
    row: 26
    col: 0
    width: 72
    height: 3
    tab_name: ''
  - title: Commentary
    name: Commentary
    model: analytics
    explore: engagement_health_fact
    type: looker_grid
    fields: [engagement_health_fact.delivery_commentary, engagement_health_fact.commercial_commentary,
      engagement_health_fact.client_commentary]
    limit: 1
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: true
    hide_row_totals: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: true
    enable_conditional_formatting: false
    header_text_alignment: center
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    truncate_header: false
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '1'
    show_sql_query_menu_options: false
    series_labels:
      engagement_health_fact.delivery_commentary: Delivery
      engagement_health_fact.commercial_commentary: Commercial
      engagement_health_fact.client_commentary: Client
    defaults_version: 1
    modern2026: false
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
      Reporting Month: engagement_health_fact.reporting_month_month
    row: 29
    col: 0
    width: 72
    height: 9
    tab_name: ''
  - title: Budget Burn-up
    name: Budget Burn-up
    model: analytics
    explore: engagement_burn_up_fact
    type: looker_line
    fields: [engagement_burn_up_fact.week_start_date, engagement_burn_up_fact.cumulative_hours,
      engagement_burn_up_fact.projected_cumulative_hours, engagement_burn_up_fact.budget_line_hours]
    sorts: [engagement_burn_up_fact.week_start_date]
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
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    hidden_fields: []
    y_axis_labels: [Hours]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: []
    series_types:
      engagement_burn_up_fact.cumulative_hours: area
      engagement_burn_up_fact.projected_cumulative_hours: area
    series_colors:
      engagement_burn_up_fact.cumulative_hours: "#4285F4"
      engagement_burn_up_fact.projected_cumulative_hours: "#99D8F4"
      engagement_burn_up_fact.budget_line_hours: "#f90404"
    series_labels:
      engagement_burn_up_fact.cumulative_hours: ''
    series_line_widths:
      engagement_burn_up_fact.budget_line_hours: 2
    defaults_version: 1
    modern2026: false
    listen:
      Company Name: engagement_burn_up_fact.company_name
      Engagement Name: engagement_burn_up_fact.engagement_name
    row: 14
    col: 36
    width: 36
    height: 12
    tab_name: ''
  - title: Sprint Timeline
    name: Sprint Timeline
    model: analytics
    explore: engagement_sprint_burn_fact
    type: looker_timeline
    fields: [engagement_sprint_burn_fact.sprint_name, engagement_sprint_burn_fact.sprint_state,
      engagement_sprint_burn_fact.sprint_start_date, engagement_sprint_burn_fact.sprint_end_date,
      engagement_sprint_burn_fact.sprint_budget_used_pct]
    filters:
      engagement_sprint_burn_fact.reporting_month_month: 1 months
    sorts: [engagement_sprint_burn_fact.sprint_start_date]
    limit: 100
    column_limit: 50
    groupBars: true
    labelSize: 10pt
    showLegend: true
    color_application:
      collection_id: legacy
      palette_id: looker_classic
    defaults_version: 1
    hidden_pivots: {}
    modern2026: false
    listen:
      Company Name: engagement_sprint_burn_fact.company_name
      Engagement Name: engagement_sprint_burn_fact.engagement_name
      Reporting Month: engagement_sprint_burn_fact.reporting_month_month
    row: 38
    col: 47
    width: 24
    height: 14
    tab_name: ''
  - title: Sprint Burn
    name: Sprint Burn
    model: analytics
    explore: engagement_sprint_burn_fact
    type: looker_grid
    fields: [engagement_sprint_burn_fact.sprint_name, engagement_sprint_burn_fact.sprint_window,
      engagement_sprint_burn_fact.sprint_budget_hours, engagement_sprint_burn_fact.sprint_hours_to_date,
      engagement_sprint_burn_fact.sprint_budget_used_pct, engagement_sprint_burn_fact.sprint_state,
      engagement_sprint_burn_fact.last_hours_booked_date]
    sorts: [engagement_sprint_burn_fact.sprint_start_date]
    limit: 100
    column_limit: 50
    show_row_numbers: true
    show_view_names: false
    hide_totals: true
    hide_row_totals: true
    table_theme: white
    truncate_column_names: false
    header_font_size: 11
    rows_font_size: 12
    series_cell_visualizations:
      engagement_sprint_burn_fact.sprint_budget_used_pct:
        is_active: true
        palette:
          palette_id: sprint_burn_bar
          collection_id: legacy
    conditional_formatting: [{type: equal to, value: !!null '', background_color: "#F8D7D3",
        font_color: "#8B2015", color_application: {collection_id: legacy, palette_id: red},
        bold: false, italic: false, strikethrough: false, fields: [engagement_sprint_burn_fact.sprint_state],
        options: {steps: 5}, string_value: 'Over budget, in flight'}, {type: equal
          to, value: !!null '', background_color: "#F8D7D3", font_color: "#8B2015",
        bold: false, italic: false, strikethrough: false, fields: [engagement_sprint_burn_fact.sprint_state],
        string_value: 'Not started, late'}, {type: equal to, value: !!null '', background_color: "#F8D7D3",
        font_color: "#8B2015", bold: false, italic: false, strikethrough: false, fields: [
          engagement_sprint_burn_fact.sprint_state], string_value: Closed over budget},
      {type: equal to, value: !!null '', background_color: "#FBE9CF", font_color: "#8A5A15",
        bold: false, italic: false, strikethrough: false, fields: [engagement_sprint_burn_fact.sprint_state],
        string_value: 'At budget, in flight'}, {type: equal to, value: !!null '',
        background_color: "#D6EBD8", font_color: "#1F5222", bold: false, italic: false,
        strikethrough: false, fields: [engagement_sprint_burn_fact.sprint_state],
        string_value: Closed on budget}]
    modern2026: false
    listen:
      Company Name: engagement_sprint_burn_fact.company_name
      Engagement Name: engagement_sprint_burn_fact.engagement_name
      Reporting Month: engagement_sprint_burn_fact.reporting_month_month
    row: 52
    col: 0
    width: 72
    height: 14
    tab_name: ''
  - title: Hours, Revenue and Cost by Month
    name: Hours, Revenue and Cost by Month
    model: analytics
    explore: engagement_health_fact
    type: looker_column
    fields: [engagement_health_fact.reporting_month_month, engagement_health_fact.total_hours_in_month,
      engagement_health_fact.total_revenue_in_month_gbp, engagement_health_fact.total_delivery_cost_in_month_gbp]
    sorts: [engagement_health_fact.reporting_month_month]
    limit: 24
    column_limit: 50
    show_view_names: false
    series_types:
      engagement_health_fact.total_revenue_in_month_gbp: line
      engagement_health_fact.total_delivery_cost_in_month_gbp: line
    series_colors:
      engagement_health_fact.total_hours_in_month: "#4285F4"
      engagement_health_fact.total_revenue_in_month_gbp: "#34A853"
      engagement_health_fact.total_delivery_cost_in_month_gbp: "#EA4335"
    y_axes: [{label: Hours, orientation: left, series: [{id: engagement_health_fact.total_hours_in_month,
            name: Hours, axisId: engagement_health_fact.total_hours_in_month}], showLabels: true,
        showValues: true, tickDensity: default, type: linear}, {label: "£", orientation: right,
        series: [{id: engagement_health_fact.total_revenue_in_month_gbp, name: Revenue,
            axisId: engagement_health_fact.total_revenue_in_month_gbp}, {id: engagement_health_fact.total_delivery_cost_in_month_gbp,
            name: Cost, axisId: engagement_health_fact.total_delivery_cost_in_month_gbp}],
        showLabels: true, showValues: true, tickDensity: default, type: linear}]
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    modern2026: false
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
    row: 38
    col: 0
    width: 27
    height: 14
    tab_name: ''
  - title: Open and Overdue Invoices
    name: Open and Overdue Invoices
    model: analytics
    explore: engagement_health_fact
    type: looker_grid
    fields: [engagement_health_fact.overdue_invoice_count, engagement_health_fact.overdue_amount_gbp,
      engagement_health_fact.max_days_overdue, engagement_health_fact.open_invoice_amount_gbp]
    limit: 1
    column_limit: 50
    show_row_numbers: false
    show_view_names: false
    hide_totals: true
    hide_row_totals: true
    table_theme: white
    truncate_column_names: false
    header_font_size: 11
    rows_font_size: 12
    conditional_formatting: [{type: greater than, value: 30, background_color: "#F8D7D3",
        font_color: "#8B2015", bold: false, italic: false, strikethrough: false, fields: [
          engagement_health_fact.max_days_overdue]}]
    modern2026: false
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
      Reporting Month: engagement_health_fact.reporting_month_month
    row: 38
    col: 27
    width: 20
    height: 14
    tab_name: ''
  - title: Actions for the Month
    name: Actions for the Month
    model: analytics
    explore: engagement_actions_fact
    type: looker_grid
    fields: [engagement_actions_fact.status_area, engagement_actions_fact.status_area_status,
      engagement_actions_fact.priority, engagement_actions_fact.owner, engagement_actions_fact.action,
      engagement_actions_fact.triggered_by]
    sorts: [engagement_actions_fact.status_sort_order, engagement_actions_fact.status_area,
      engagement_actions_fact.priority]
    limit: 50
    column_limit: 50
    show_row_numbers: true
    show_view_names: false
    hide_totals: true
    hide_row_totals: true
    table_theme: white
    truncate_column_names: false
    header_font_size: 11
    rows_font_size: 12
    conditional_formatting: [{type: equal to, value: !!null '', background_color: "#F8D7D3",
        font_color: "#8B2015", bold: false, italic: false, strikethrough: false, fields: [
          engagement_actions_fact.status_area_status], string_value: RED}, {type: equal
          to, value: !!null '', background_color: "#FBE9CF", font_color: "#8A5A15",
        bold: false, italic: false, strikethrough: false, fields: [engagement_actions_fact.status_area_status],
        string_value: AMBER}]
    modern2026: false
    listen:
      Company Name: engagement_actions_fact.company_name
      Engagement Name: engagement_actions_fact.engagement_name
      Reporting Month: engagement_actions_fact.reporting_month_month
    row: 66
    col: 0
    width: 72
    height: 14
    tab_name: ''
  filters:
  - name: Company Name
    title: Company Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: analytics
    explore: engagement_health_fact
    listens_to_filters: []
    field: engagement_health_fact.company_name
  - name: Engagement Name
    title: Engagement Name
    type: field_filter
    default_value: ''
    allow_multiple_values: false
    required: true
    ui_config:
      type: dropdown_menu
      display: inline
    model: analytics
    explore: engagement_health_fact
    listens_to_filters: [Company Name]
    field: engagement_health_fact.engagement_name
  - name: Reporting Month
    title: Reporting Month
    type: field_filter
    default_value: 1 months
    allow_multiple_values: false
    required: true
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    model: analytics
    explore: engagement_health_fact
    listens_to_filters: []
    field: engagement_health_fact.reporting_month_month
