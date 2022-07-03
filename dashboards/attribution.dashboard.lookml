- dashboard: consultant_revenue
  title: Consultant Revenue
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: dQS7ezf3Hu9ChnzpxMAadl
  elements:
  - title: Attributed Revenue per Month
    name: Attributed Revenue per Month
    model: analytics
    explore: revenue_attribution
    type: looker_grid
    fields: [revenue_attribution.invoice_month, revenue_attribution.consultant_name,
      revenue_attribution.attributed_revenue]
    pivots: [revenue_attribution.invoice_month]
    fill_fields: [revenue_attribution.invoice_month]
    filters:
      revenue_attribution.consultant_name: "-Janet Rittman,-Tomek Zbrozek"
    sorts: [revenue_attribution.invoice_month desc, revenue_attribution.consultant_name]
    limit: 500
    total: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      revenue_attribution.attributed_revenue:
        is_active: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#3C358B",
        font_color: !!null '', color_application: {collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde,
          palette_id: c8e61ae5-b4ef-4fca-8f2f-92d1bd146bb1, options: {steps: 5}},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    series_types: {}
    listen:
      "      Invoice Date": revenue_attribution.invoice_month
    row: 0
    col: 0
    width: 24
    height: 6
  filters:
  - name: "      Invoice Date"
    title: "      Invoice Date"
    type: field_filter
    default_value: this year to second
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    model: analytics
    explore: revenue_attribution
    listens_to_filters: []
    field: projects_invoiced.invoice_date
