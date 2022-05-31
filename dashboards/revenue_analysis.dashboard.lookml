- dashboard: revenue_analysis
  title: Revenue Analysis
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - title: How much repeat business have we earned from each of our clients?
    name: How much repeat business have we earned from each of our clients?
    model: analytics
    explore: companies_dim
    type: looker_grid
    fields: [projects_invoiced.first_invoice_month, companies_dim.company_name, projects_invoiced.invoice_gbp_revenue_amount,
      projects_invoiced.months_since_first_invoice]
    pivots: [projects_invoiced.months_since_first_invoice]
    filters:
      projects_invoiced.invoice_gbp_revenue_amount: ">0"
      projects_invoiced.first_invoice_year: 2 years
      projects_invoiced.months_since_first_invoice: NOT NULL
    sorts: [projects_invoiced.months_since_first_invoice, projects_invoiced.first_invoice_month]
    limit: 500
    column_limit: 50
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
      projects_invoiced.invoice_gbp_revenue_amount:
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
    series_types: {}
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    reference_lines: []
    trend_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    value_labels: legend
    label_type: labPer
    hidden_fields: [projects_invoiced.first_invoice_month]
    listen: {}
    row: 17
    col: 0
    width: 18
    height: 10
  - title: How concentrated in a single client was it?
    name: How concentrated in a single client was it?
    model: analytics
    explore: companies_dim
    type: looker_line
    fields: [projects_invoiced.invoice_month, companies_dim.company_name, projects_invoiced.invoice_gbp_revenue_amount]
    pivots: [companies_dim.company_name]
    filters:
      projects_invoiced.invoice_date: after 2020/01/01
      projects_invoiced.invoice_gbp_revenue_amount: ">0"
    sorts: [projects_invoiced.invoice_month desc, companies_dim.company_name]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: table_calculation, expression: 'max(pivot_row(${projects_invoiced.invoice_gbp_revenue_amount}))/sum(pivot_row(${projects_invoiced.invoice_gbp_revenue_amount}))',
        label: Revenue Concentration, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: supermeasure, table_calculation: revenue_concentration, _type_hint: number}]
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    series_types: {}
    reference_lines: [{reference_type: range, range_end: '0', margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: right, color: "#519947",
        line_value: ".33", label: Ideal, range_start: ".33"}, {reference_type: range,
        line_value: mean, range_start: ".66", range_end: ".33", margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: right, color: "#F4B87B",
        label: Warning}, {reference_type: range, line_value: mean, range_end: ".66",
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: right,
        color: "#8C3535", range_start: '1', label: Danger}]
    trend_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_fields: [projects_invoiced.invoice_gbp_revenue_amount]
    listen: {}
    row: 0
    col: 12
    width: 6
    height: 9
  - title: What booked revenue do we have in the pipeline?
    name: What booked revenue do we have in the pipeline?
    model: analytics
    explore: companies_dim
    type: looker_column
    fields: [projects_delivered.total_project_fee_amount, companies_dim.company_name,
      projects_delivered.project_delivery_end_ts_month]
    pivots: [companies_dim.company_name]
    fill_fields: [projects_delivered.project_delivery_end_ts_month]
    filters:
      projects_delivered.is_project_active: 'Yes'
      projects_invoiced.invoice_paid_date: 'NULL'
      projects_delivered.project_delivery_start_ts_date: after this month
    sorts: [projects_delivered.total_project_fee_amount desc 0, projects_delivered.project_delivery_end_ts_month,
      companies_dim.company_name]
    limit: 500
    column_limit: 50
    total: true
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
    stacking: normal
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
    y_axes: [{label: '', orientation: left, series: [{axisId: Ageras A/S - projects_delivered.total_project_fee_amount,
            id: Ageras A/S - projects_delivered.total_project_fee_amount, name: Ageras
              A/S}, {axisId: Breakthrough - projects_delivered.total_project_fee_amount,
            id: Breakthrough - projects_delivered.total_project_fee_amount, name: Breakthrough},
          {axisId: Kaplan International Pathways - projects_delivered.total_project_fee_amount,
            id: Kaplan International Pathways - projects_delivered.total_project_fee_amount,
            name: Kaplan International Pathways}, {axisId: RIXO - projects_delivered.total_project_fee_amount,
            id: RIXO - projects_delivered.total_project_fee_amount, name: RIXO}, {
            axisId: Shutterstock - projects_delivered.total_project_fee_amount, id: Shutterstock
              - projects_delivered.total_project_fee_amount, name: Shutterstock}],
        showLabels: true, showValues: true, maxValue: 120000, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    series_types: {}
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_cell_visualizations:
      projects_delivered.total_project_fee_amount:
        is_active: false
    table_theme: white
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#3C358B",
        font_color: !!null '', color_application: {collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde,
          palette_id: c8e61ae5-b4ef-4fca-8f2f-92d1bd146bb1, options: {steps: 5}},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hide_totals: false
    hide_row_totals: false
    listen: {}
    row: 17
    col: 18
    width: 6
    height: 10
  - name: How Much Revenue and Margin Does Each Client Provide?
    title: How Much Revenue and Margin Does Each Client Provide?
    merged_queries:
    - model: finance
      explore: revenue_attribution
      type: looker_grid
      fields: [revenue_attribution.attributed_revenue, running_total_of_revenue_attribution_attributed_revenue,
        companies_dim.company_name]
      filters:
        revenue_attribution.invoice_year: 1 years
      sorts: [revenue_attribution.attributed_revenue desc]
      limit: 500
      total: true
      dynamic_fields: [{args: [revenue_attribution.attributed_revenue], calculation_type: running_total,
          category: table_calculation, based_on: revenue_attribution.attributed_revenue,
          label: Running total of Revenue Attribution Attributed Revenue, source_field: revenue_attribution.attributed_revenue,
          table_calculation: running_total_of_revenue_attribution_attributed_revenue,
          value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
          _type_hint: number}]
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
          is_active: true
          palette:
            palette_id: c8e61ae5-b4ef-4fca-8f2f-92d1bd146bb1
            collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde
      conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#3C358B",
          font_color: !!null '', color_application: {collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde,
            palette_id: c8e61ae5-b4ef-4fca-8f2f-92d1bd146bb1, options: {steps: 5}},
          bold: false, italic: false, strikethrough: false, fields: !!null ''}]
      series_value_format:
        revenue_attribution.attributed_revenue:
          name: gbp_0
          decimals: '0'
          format_string: '"£"#,##0'
          label: British Pounds (0)
          label_prefix: British Pounds
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
      stacking: normal
      legend_position: center
      font_size: 12
      series_types: {}
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
      defaults_version: 1
      hidden_fields: [running_total_of_revenue_attribution_attributed_revenue]
      show_null_points: true
      interpolation: linear
    - model: analytics
      explore: companies_dim
      type: table
      fields: [companies_dim.company_name, projects_invoiced.invoice_gbp_revenue_amount,
        project_timesheets.total_timesheet_hours_billed, project_timesheets.total_timesheet_cost_amount,
        project_timesheet_projects.count_timesheet_projects]
      filters:
        projects_invoiced.invoice_date: 1 years
        project_timesheets.timesheet_billing_date: 1 years
      sorts: [projects_invoiced.invoice_gbp_revenue_amount desc]
      limit: 500
      column_limit: 50
      total: true
      join_fields:
      - field_name: companies_dim.company_name
        source_field_name: companies_dim.company_name
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", companies_dim.company_name, revenuesprint,
      projects_invoiced.invoice_gbp_revenue_amount, margin_sprint, sprint_gross_margin,
      referral_fees, total_revenue, effective_hourly_rate, gross_margin, gross_margin_1]
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_labels:
      projects_invoiced.invoice_gbp_revenue_amount: Billing
      referral_fees: Referral Fees
    series_column_widths:
      revenuesprint: 136
      margin_sprint: 119
    series_cell_visualizations:
      projects_invoiced.invoice_gbp_revenue_amount:
        is_active: true
        palette:
          palette_id: 881a5da2-d185-c7ea-e514-bf79563d6ec5
          collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde
          custom_colors:
          - "#8C3535"
          - "#F4B87B"
          - "#519947"
      referral_fees:
        is_active: true
        palette:
          palette_id: 8a34e7e4-8781-9fe2-e91b-15c9bbd725aa
          collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde
          custom_colors:
          - "#8C3535"
          - "#F4B87B"
          - "#519947"
      total_revenue:
        is_active: true
        palette:
          palette_id: a0ab8281-7607-d289-eb59-7c7b9f0ab404
          collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde
          custom_colors:
          - "#8C3535"
          - "#F4B87B"
          - "#519947"
        value_display: true
      gross_margin:
        is_active: true
        palette:
          palette_id: dfba9698-4b86-f92d-9609-9604b15d34d9
          collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde
          custom_colors:
          - "#8C3535"
          - "#F4B87B"
          - "#519947"
      gross_margin_1:
        is_active: true
        palette:
          palette_id: 120c472e-3ff8-cd92-ba83-272ee752a4c4
          collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde
          custom_colors:
          - "#8C3535"
          - "#F4B87B"
          - "#519947"
      effective_hourly_rate:
        is_active: true
        palette:
          palette_id: bfcd5fd9-5305-a5df-8160-90db9c5d7e9c
          collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde
          custom_colors:
          - "#8C3535"
          - "#F4B87B"
          - "#519947"
      sprint_gross_margin:
        is_active: true
        palette:
          palette_id: '062581dc-997e-aeb4-4498-a5b709a649a8'
          collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde
          custom_colors:
          - "#8C3535"
          - "#F4B87B"
          - "#519947"
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    stacking: normal
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      referral_fees: "#F4B87B"
      projects_invoiced.invoice_gbp_revenue_amount: "#3C358B"
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [running_total_of_revenue_attribution_attributed_revenue, q0_running_total_of_revenue_attribution_attributed_revenue,
      revenue_attribution.attributed_revenue, project_timesheets.total_timesheet_hours_billed,
      project_timesheets.total_timesheet_cost_amount, project_timesheet_projects.count_timesheet_projects]
    type: looker_grid
    sorts: [total_revenue desc]
    total: true
    dynamic_fields: [{category: table_calculation, expression: 'if(${revenue_attribution.attributed_revenue}-${projects_invoiced.invoice_gbp_revenue_amount}>0,${revenue_attribution.attributed_revenue}-${projects_invoiced.invoice_gbp_revenue_amount},0)',
        label: Referral Fees, value_format: !!null '', value_format_name: gbp_0, _kind_hint: measure,
        table_calculation: referral_fees, _type_hint: number}, {category: table_calculation,
        expression: "${projects_invoiced.invoice_gbp_revenue_amount}+${referral_fees}",
        label: Total Revenue, value_format: !!null '', value_format_name: gbp_0, _kind_hint: measure,
        table_calculation: total_revenue, _type_hint: number}, {category: table_calculation,
        expression: "${total_revenue}/${project_timesheets.total_timesheet_hours_billed}",
        label: Effective Hourly Rate, value_format: !!null '', value_format_name: gbp_0,
        _kind_hint: measure, table_calculation: effective_hourly_rate, _type_hint: number},
      {category: table_calculation, expression: "${total_revenue}-${project_timesheets.total_timesheet_cost_amount}",
        label: Gross Margin, value_format: !!null '', value_format_name: gbp_0, _kind_hint: measure,
        table_calculation: gross_margin, _type_hint: number}, {category: table_calculation,
        expression: "${gross_margin}/${total_revenue}", label: Gross Margin %, value_format: !!null '',
        value_format_name: percent_0, _kind_hint: measure, table_calculation: gross_margin_1,
        _type_hint: number}, {category: table_calculation, expression: "${projects_invoiced.invoice_gbp_revenue_amount}/${project_timesheet_projects.count_timesheet_projects}",
        label: Revenue/Sprint, value_format: !!null '', value_format_name: gbp_0,
        _kind_hint: measure, table_calculation: revenuesprint, _type_hint: number},
      {category: table_calculation, expression: "${revenuesprint} - (${project_timesheets.total_timesheet_cost_amount}/${project_timesheet_projects.count_timesheet_projects})",
        label: Margin / Sprint, value_format: !!null '', value_format_name: gbp_0,
        _kind_hint: measure, table_calculation: margin_sprint, _type_hint: number},
      {category: table_calculation, expression: "(${margin_sprint})/${revenuesprint}",
        label: Sprint Gross Margin %, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: sprint_gross_margin, _type_hint: number}]
    row: 9
    col: 0
    width: 24
    height: 8
  - title: What's our monthly historic revenue by client?
    name: What's our monthly historic revenue by client?
    model: finance
    explore: revenue_attribution
    type: looker_column
    fields: [companies_dim.company_name, revenue_attribution.attributed_revenue, revenue_attribution.invoice_month]
    pivots: [companies_dim.company_name]
    fill_fields: [revenue_attribution.invoice_month]
    filters:
      revenue_attribution.invoice_month: after 2021/01/01
    sorts: [companies_dim.company_name, revenue_attribution.invoice_month desc]
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
    stacking: normal
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
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 0
    col: 0
    width: 12
    height: 9
  - title: How does our license referral fee income break-down by vendor?
    name: How does our license referral fee income break-down by vendor?
    model: analytics
    explore: companies_dim
    type: looker_column
    fields: [companies_dim.company_name, projects_invoiced.invoice_gbp_revenue_amount,
      projects_delivered.project_name]
    pivots: [projects_delivered.project_name]
    filters:
      companies_dim.company_name: Looker Data Sciences,Fivetran
      projects_invoiced.invoice_year: 1 years
    sorts: [projects_invoiced.invoice_gbp_revenue_amount desc 0, projects_delivered.project_name]
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
    stacking: normal
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
    defaults_version: 1
    listen: {}
    row: 27
    col: 0
    width: 8
    height: 8
  - title: How do we price sprints?
    name: How do we price sprints?
    model: analytics
    explore: companies_dim
    type: looker_pie
    fields: [projects_delivered.project_is_fixed_fee, projects_invoiced.count_invoices]
    fill_fields: [projects_delivered.project_is_fixed_fee]
    filters:
      projects_invoiced.invoice_year: 1 years
    sorts: [projects_invoiced.count_invoices desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: 'if(${projects_delivered.project_is_fixed_fee},"Fixed
          Price","Time & Materials")', label: Pricing Method, value_format: !!null '',
        value_format_name: !!null '', _kind_hint: dimension, table_calculation: pricing_method,
        _type_hint: string}]
    value_labels: legend
    label_type: labPer
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [projects_delivered.project_is_fixed_fee]
    row: 31
    col: 16
    width: 4
    height: 4
  - title: How does our client revenue break-down by Currency?
    name: How does our client revenue break-down by Currency?
    model: analytics
    explore: companies_dim
    type: looker_column
    fields: [projects_invoiced.invoice_currency, projects_invoiced.invoice_gbp_revenue_amount,
      companies_dim.company_name]
    pivots: [companies_dim.company_name]
    filters:
      projects_invoiced.invoice_date: 1 years
      companies_dim.company_name: "-Looker Data Sciences,-Fivetran"
    sorts: [projects_invoiced.invoice_currency desc, companies_dim.company_name]
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
    stacking: normal
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
    defaults_version: 1
    row: 27
    col: 8
    width: 8
    height: 8
  - title: What are our payment terms?
    name: What are our payment terms?
    model: analytics
    explore: companies_dim
    type: looker_pie
    fields: [projects_invoiced.invoice_payment_term, projects_invoiced.count_invoices]
    filters:
      projects_invoiced.invoice_date: 1 years
    sorts: [projects_invoiced.invoice_payment_term]
    limit: 500
    value_labels: legend
    label_type: labPer
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    row: 27
    col: 16
    width: 4
    height: 4
  - title: Where do we do business?
    name: Where do we do business?
    model: analytics
    explore: companies_dim
    type: looker_pie
    fields: [projects_invoiced.invoice_currency, projects_invoiced.invoice_gbp_revenue_amount]
    filters:
      projects_invoiced.invoice_date: 1 years
      companies_dim.company_name: "-Looker Data Sciences,-Fivetran"
    sorts: [projects_invoiced.invoice_currency desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: 'if(${projects_invoiced.invoice_currency}="USD","North
          America",if(${projects_invoiced.invoice_currency}="EUR","EU","UK"))', label: New
          Calculation, value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        table_calculation: new_calculation, _type_hint: string}]
    value_labels: legend
    label_type: labPer
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
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
    defaults_version: 1
    hidden_fields: [projects_invoiced.invoice_currency]
    row: 27
    col: 20
    width: 4
    height: 4
  - title: Is Project Time Billable?
    name: Is Project Time Billable?
    model: analytics
    explore: companies_dim
    type: looker_pie
    fields: [project_timesheets.timesheet_is_billable, project_timesheets.total_timesheet_hours_billed]
    fill_fields: [project_timesheets.timesheet_is_billable]
    filters:
      project_timesheet_users.contact_name: "-Mark Rittman"
    sorts: [project_timesheets.total_timesheet_hours_billed desc]
    limit: 500
    value_labels: legend
    label_type: labPer
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    listen: {}
    row: 31
    col: 20
    width: 4
    height: 4
  - title: How did it compare to previous years?
    name: How did it compare to previous years?
    model: analytics
    explore: companies_dim
    type: looker_area
    fields: [companies_dim.count, projects_invoiced.invoice_year, projects_invoiced.invoice_month_num,
      projects_invoiced.invoice_gbp_revenue_amount]
    pivots: [projects_invoiced.invoice_year]
    filters:
      projects_invoiced.invoice_local_revenue_amount: ">0"
      projects_invoiced.invoice_month_num: "<=7"
    sorts: [projects_invoiced.invoice_year, projects_invoiced.invoice_month_num]
    limit: 500
    column_limit: 50
    dynamic_fields: [{_kind_hint: measure, table_calculation: annual_cumulative_revenue,
        _type_hint: number, category: table_calculation, expression: 'running_total(${projects_invoiced.invoice_gbp_revenue_amount})',
        label: Annual Cumulative Revenue, value_format: !!null '', value_format_name: gbp_0}]
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
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde
      palette_id: f1a7a59e-893b-4b4c-a4fe-d04ad9e44b0e
      options:
        steps: 5
    label_value_format: '"£"0,"K"'
    series_types:
      2020 - annual_cumulative_revenue: line
      2019 - annual_cumulative_revenue: line
      2018 - annual_cumulative_revenue: line
      2021 - annual_cumulative_revenue: line
    series_colors:
      2021 - annual_cumulative_revenue: "#8C3535"
      2020 - annual_cumulative_revenue: "#904899"
      2019 - annual_cumulative_revenue: "#A4A8D1"
    hidden_fields: [companies_dim.count, projects_invoiced.invoice_gbp_revenue_amount]
    ordering: none
    show_null_labels: false
    defaults_version: 1
    listen: {}
    row: 0
    col: 18
    width: 6
    height: 9
