- dashboard: sales_orders_analytics
  title: Sales & Orders Analytics
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "Detailed sales performance, order trends, and revenue analysis"

  refresh: 30 minutes

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
    model: ecommerce_demo
    explore: orders
    field: order_date.calendar_date

  - name: product_vendor
    title: Product Vendor
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    model: ecommerce_demo
    explore: order_items
    field: products.vendor

  - name: customer_country
    title: Customer Country
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    model: ecommerce_demo
    explore: order_items
    field: customers.country

  elements:

  # Sales KPIs
  - title: Total Revenue
    name: sales_total_revenue
    model: ecommerce_demo
    explore: order_items
    type: single_value
    fields: [order_items.total_revenue]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    value_format: "$#,##0"
    listen:
      Date Range: order_date.calendar_date
      Product Vendor: products.vendor
      Customer Country: customers.country
    row: 0
    col: 0
    width: 6
    height: 4

  - title: Total Orders
    name: sales_total_orders
    model: ecommerce_demo
    explore: order_items
    type: single_value
    fields: [order_items.count_orders]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    value_format: "#,##0"
    listen:
      Date Range: order_date.calendar_date
      Product Vendor: products.vendor
      Customer Country: customers.country
    row: 0
    col: 6
    width: 6
    height: 4

  - title: Average Order Value
    name: sales_aov
    model: ecommerce_demo
    explore: order_items
    type: single_value
    fields: [orders.average_order_value]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    value_format: "$#,##0"
    listen:
      Date Range: order_date.calendar_date
      Product Vendor: products.vendor
      Customer Country: orders.shipping_country
    row: 0
    col: 12
    width: 6
    height: 4

  - title: Units Sold
    name: sales_units_sold
    model: ecommerce_demo
    explore: orders
    type: single_value
    fields: [orders.total_quantity_sold]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    value_format: "#,##0"
    listen:
      Date Range: order_date.calendar_date
      Product Vendor: products.vendor
      Customer Country: orders.shipping_country
    row: 0
    col: 18
    width: 6
    height: 4

  # Daily Sales Trend
  - title: Daily Sales Trend
    name: daily_sales_trend
    model: ecommerce_demo
    explore: orders
    type: looker_line
    fields: [order_date.calendar_date, orders.total_revenue, orders.count_orders]
    fill_fields: [order_date.calendar_date]
    sorts: [order_date.calendar_date desc]
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: Revenue, orientation: left, series: [{axisId: orders.total_revenue,
            id: orders.total_revenue, name: Total Revenue}], showLabels: true, showValues: true,
        valueFormat: '$#,##0', unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: Orders, orientation: right, series: [{axisId: orders.count_orders,
            id: orders.count_orders, name: Count Orders}], showLabels: true, showValues: true,
        valueFormat: '#,##0', unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    listen:
      Date Range: order_date.calendar_date
      Product Vendor: products.vendor
      Customer Country: orders.shipping_country
    row: 4
    col: 0
    width: 24
    height: 8

  # Sales by Product Category
  - title: Sales by Product Type
    name: sales_by_product_type
    model: ecommerce_demo
    explore: orders
    type: looker_pie
    fields: [products.product_type, orders.total_revenue]
    filters:
      products.is_current: "Yes"
    sorts: [orders.total_revenue desc]
    limit: 10
    value_labels: legend
    label_type: labPer
    inner_radius: 50
    start_angle: 90
    color_application:
      collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
      palette_id: 5d189dfc-4f46-46f3-822b-bfb0b61777b1
    series_colors: {}
    value_format: "$#,##0"
    listen:
      Date Range: order_date.calendar_date
      Product Vendor: products.vendor
      Customer Country: orders.shipping_country
    row: 12
    col: 0
    width: 12
    height: 8

  # Sales by Country
  - title: Sales by Country
    name: sales_by_country
    model: ecommerce_demo
    explore: orders
    type: looker_bar
    fields: [orders.shipping_country, orders.total_revenue, orders.count_orders]
    sorts: [orders.total_revenue desc]
    limit: 15
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
    y_axes: [{label: Revenue, orientation: left, series: [{axisId: orders.total_revenue,
            id: orders.total_revenue, name: Total Revenue}], showLabels: true, showValues: true,
        valueFormat: '$#,##0', unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: Orders, orientation: right, series: [{axisId: orders.count_orders,
            id: orders.count_orders, name: Count Orders}], showLabels: true, showValues: true,
        valueFormat: '#,##0', unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    listen:
      Date Range: order_date.calendar_date
      Product Vendor: products.vendor
      Customer Country: orders.shipping_country
    row: 12
    col: 12
    width: 12
    height: 8

  # Order Size Distribution
  - title: Order Size Distribution
    name: order_size_distribution
    model: ecommerce_demo
    explore: orders
    type: looker_column
    fields: [orders.order_size_category, orders.count_orders, orders.average_order_value]
    sorts: [orders.average_order_value]
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
    y_axes: [{label: Order Count, orientation: left, series: [{axisId: orders.count_orders,
            id: orders.count_orders, name: Count Orders}], showLabels: true, showValues: true,
        valueFormat: '#,##0', unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: Average Order Value, orientation: right, series: [{axisId: orders.average_order_value,
            id: orders.average_order_value, name: Average Order Value}], showLabels: true,
        showValues: true, valueFormat: '$#,##0', unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    listen:
      Date Range: order_date.calendar_date
      Product Vendor: products.vendor
      Customer Country: orders.shipping_country
    row: 20
    col: 0
    width: 12
    height: 8

  # Top Customers by Revenue
  - title: Top Customers by Revenue
    name: top_customers_revenue
    model: ecommerce_demo
    explore: orders
    type: looker_bar
    fields: [customers.full_name, customers.email, orders.total_revenue, orders.count_orders]
    filters:
      customers.is_current: "Yes"
    sorts: [orders.total_revenue desc]
    limit: 15
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
    value_format: "$#,##0"
    listen:
      Date Range: order_date.calendar_date
      Product Vendor: products.vendor
      Customer Country: orders.shipping_country
    row: 20
    col: 12
    width: 12
    height: 8
