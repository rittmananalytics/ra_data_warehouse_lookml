- dashboard: executive_overview
  title: Executive Overview
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "High-level business performance summary for C-level stakeholders"

  refresh: 1 hour

  filters:
  - name: date_range
    title: Date Range
    type: field_filter
    default_value: "30 days"
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    model: ecommerce_demo
    explore: executive_overview
    listens_to_filters: []
    field: exec_order_date.calendar_date

  elements:

  # KPI Row 1
  - title: Total Revenue
    name: total_revenue
    model: ra_ecommerce_analytics
    explore: executive_overview
    type: single_value
    fields: [executive_overview.total_revenue]
    filters:
      exec_order_date.calendar_date: "30 days"
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_format: "$#,##0"
    series_types: {}
    listen:
      Date Range: exec_order_date.calendar_date
    row: 0
    col: 0
    width: 4
    height: 4

  - title: Total Orders
    name: total_orders
    model: ra_ecommerce_analytics
    explore: executive_overview
    type: single_value
    fields: [executive_overview.count]
    filters:
      exec_order_date.calendar_date: "30 days"
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    value_format: "#,##0"
    listen:
      Date Range: exec_order_date.calendar_date
    row: 0
    col: 4
    width: 4
    height: 4

  - title: Average Order Value
    name: average_order_value
    model: ra_ecommerce_analytics
    explore: executive_overview
    type: single_value
    fields: [executive_overview.average_order_value]
    filters:
      exec_order_date.calendar_date: "30 days"
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    value_format: "$#,##0"
    listen:
      Date Range: exec_order_date.calendar_date
    row: 0
    col: 8
    width: 4
    height: 4

  - title: Total Unique Customers
    name: total_unique_customers
    model: ra_ecommerce_analytics
    explore: executive_overview
    type: single_value
    fields: [exec_customers.count_current]
    filters:
      exec_order_date.calendar_date: "30 days"
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    value_format: "#,##0"
    listen:
      Date Range: exec_order_date.calendar_date
    row: 0
    col: 12
    width: 4
    height: 4

  - title: Customer Acquisition Cost
    name: customer_acquisition_cost
    model: ra_ecommerce_analytics
    explore: executive_overview
    type: single_value
    fields: [exec_marketing.overall_cpa]
    filters:
      exec_order_date.calendar_date: "30 days"
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    value_format: "$#,##0"
    listen:
      Date Range: exec_order_date.calendar_date
    row: 0
    col: 16
    width: 4
    height: 4

  - title: Return on Ad Spend
    name: return_on_ad_spend
    model: ra_ecommerce_analytics
    explore: executive_overview
    type: single_value
    fields: [exec_marketing.overall_roas]
    filters:
      exec_order_date.calendar_date: "30 days"
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    value_format: "0.00x"
    listen:
      Date Range: exec_order_date.calendar_date
    row: 0
    col: 20
    width: 4
    height: 4

  # Revenue Trend Charts
  - title: Revenue Trend
    name: revenue_trend
    model: ra_ecommerce_analytics
    explore: executive_overview
    type: looker_line
    fields: [exec_order_date.calendar_date, executive_overview.total_revenue]
    fill_fields: [exec_order_date.calendar_date]
    filters:
      exec_order_date.calendar_date: "30 days"
    sorts: [exec_order_date.calendar_date]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
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
    value_format: "$#,##0"
    listen:
      Date Range: exec_order_date.calendar_date
    row: 4
    col: 0
    width: 12
    height: 6

  - title: Orders by Channel
    name: orders_by_channel
    model: ra_ecommerce_analytics
    explore: executive_overview
    type: looker_pie
    fields: [exec_channels.source_medium, executive_overview.count]
    filters:
      exec_order_date.calendar_date: "30 days"
    sorts: [executive_overview.count desc]
    limit: 10
    value_labels: legend
    label_type: labPer
    listen:
      Date Range: exec_order_date.calendar_date
    row: 4
    col: 12
    width: 12
    height: 6

  # Customer Metrics
  - title: New vs Returning Customers
    name: new_vs_returning
    model: ra_ecommerce_analytics
    explore: executive_overview
    type: looker_column
    fields: [executive_overview.is_first_order, executive_overview.count]
    filters:
      exec_order_date.calendar_date: "30 days"
    sorts: [executive_overview.count desc]
    limit: 500
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
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Date Range: exec_order_date.calendar_date
    row: 10
    col: 0
    width: 8
    height: 6

  # Marketing Performance
  - title: Marketing Spend vs Revenue
    name: marketing_spend_vs_revenue
    model: ra_ecommerce_analytics
    explore: executive_overview
    type: looker_column
    fields: [exec_marketing.activity_date, exec_marketing.total_spend, exec_marketing.total_revenue]
    fill_fields: [exec_marketing.activity_date]
    filters:
      exec_marketing.activity_date: "30 days"
    sorts: [exec_marketing.activity_date]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_colors:
      exec_marketing.total_spend: "#E52165"
      exec_marketing.total_revenue: "#0071F2"
    listen:
      Date Range: exec_order_date.calendar_date
    row: 10
    col: 8
    width: 16
    height: 6

  # Session Metrics
  - title: Website Conversion Funnel
    name: website_conversion_funnel
    model: ra_ecommerce_analytics
    explore: executive_overview
    type: looker_funnel
    fields: [exec_sessions.count, exec_sessions.add_to_cart_rate, exec_sessions.conversion_rate]
    filters:
      exec_order_date.calendar_date: "30 days"
    limit: 500
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    smoothedBars: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    listen:
      Date Range: exec_order_date.calendar_date
    row: 16
    col: 0
    width: 24
    height: 6
