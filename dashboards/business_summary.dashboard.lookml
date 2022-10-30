- dashboard: business_summary_2022_v6
  title: Business Summary 2022 v6
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: Xit9VBjBtA6TNM7Bs8jlfb
  elements:
  - name: Revenue vs Target L12M
    title: Revenue vs Target L12M
    merged_queries:
    - model: analytics
      explore: projects_delivered
      type: table
      fields: [projects_invoiced.invoice_month, projects_invoiced.total_net_amount_gbp]
      fill_fields: [projects_invoiced.invoice_month]
      sorts: [projects_invoiced.invoice_month desc]
      limit: 500
      filter_expression: "${projects_invoiced.invoice_date}>add_months(-12,now())"
      join_fields: []
    - model: analytics
      explore: targets
      type: table
      fields: [targets.period_month, targets.total_revenue_target]
      fill_fields: [targets.period_month]
      sorts: [targets.period_month desc]
      limit: 500
      join_fields:
      - field_name: targets.period_month
        source_field_name: projects_invoiced.invoice_month
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: projects_invoiced.total_net_amount_gbp,
            id: projects_invoiced.total_net_amount_gbp, name: Revenue}, {axisId: targets.total_revenue_target,
            id: targets.total_revenue_target, name: Target}], showLabels: true, showValues: true,
        valueFormat: '"£"0,"K"', unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
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
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '15'
    legend_position: center
    series_types:
      targets.total_revenue_target: line
      projects_invoiced.total_net_amount_gbp: line
    point_style: none
    series_colors:
      targets.total_revenue_target: "#D13452"
    series_labels:
      projects_invoiced.total_net_amount_gbp: Revenue (Actual, Forecast)
      targets.total_revenue_target: Target
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    type: looker_area
    column_limit: 50
    row: 31
    col: 0
    width: 8
    height: 9
  - title: Client Renewal Rate L12M
    name: Client Renewal Rate L12M
    model: analytics
    explore: companies_dim
    type: looker_line
    fields: [projects_invoiced.first_invoice_month, companies_dim.company_name, project_timesheets.total_timesheet_hours_billed,
      project_timesheets.timesheet_billing_month]
    pivots: [companies_dim.company_name, projects_invoiced.first_invoice_month]
    filters:
      project_timesheets.total_timesheet_hours_billed: ">0"
      companies_dim.company_name: "-Brighton & Hove City Council,-East Sussex County\
        \ Council"
      project_timesheets.timesheet_is_billable: 'Yes'
    sorts: [projects_invoiced.first_invoice_month, companies_dim.company_name, project_timesheets.timesheet_billing_month]
    limit: 500
    dynamic_fields: [{table_calculation: active, label: Active, expression: 'if(coalesce(${project_timesheets.total_timesheet_hours_billed},0)>0,yes,no)',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: yesno, is_disabled: true}, {category: table_calculation, expression: 'if(pivot_offset(${active},-1)=yes,if(${active}=no,yes,no),no)',
        label: At Risk, value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        table_calculation: at_risk, _type_hint: yesno, is_disabled: true}, {category: table_calculation,
        expression: "if(${active}=no,\n   if(pivot_offset(${at_risk},-1)=yes \n  \
          \  ,yes,no),no)", label: Churned, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: churned, _type_hint: yesno, is_disabled: true},
      {category: table_calculation, expression: 'if(${active}=yes,"Active",if(${churned}=yes,"Churned",if(${at_risk}=yes,"At
          Risk","")))', label: Status, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: status, _type_hint: string, is_disabled: true},
      {category: table_calculation, description: '1 if company was active last month,
          0 if not', expression: 'if(offset(coalesce(${project_timesheets.total_timesheet_hours_billed},0),-1)>0,1,0)',
        label: Active (last month), value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: active_last_month, _type_hint: number},
      {category: table_calculation, expression: 'if(coalesce(${project_timesheets.total_timesheet_hours_billed},0)>0
          AND ${active_last_month}=1,1,0)', label: Renewed, value_format: !!null '',
        value_format_name: !!null '', _kind_hint: measure, table_calculation: renewed,
        _type_hint: number}, {category: table_calculation, expression: 'sum(pivot_row(${active_last_month}))',
        label: Total Active (last month), value_format: !!null '', value_format_name: !!null '',
        _kind_hint: supermeasure, table_calculation: total_active_last_month, _type_hint: number},
      {category: table_calculation, expression: 'sum(pivot_row(${renewed}))', label: Total
          Renewed, value_format: !!null '', value_format_name: !!null '', _kind_hint: supermeasure,
        table_calculation: total_renewed, _type_hint: number}, {category: table_calculation,
        expression: "${total_renewed}/${total_active_last_month}", label: Renewal
          Rate, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: renewal_rate, _type_hint: number}, {category: table_calculation,
        expression: 'if(row()>=max(row())-11,yes,no)', label: 'Show in Vis?', value_format: !!null '',
        value_format_name: !!null '', _kind_hint: dimension, table_calculation: show_in_vis,
        _type_hint: yesno}]
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
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
    x_axis_label: Month
    series_types: {}
    series_labels:
      status_code: Status
      companies_dim.company_name: Client
      project_timesheets.timesheet_billing_month: Month
    swap_axes: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    enable_conditional_formatting: true
    conditional_formatting: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [project_timesheets.total_timesheet_hours_billed, status_code,
      renewed, active_last_month, total_active_last_month, total_renewed]
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    transpose: false
    truncate_text: true
    size_to_fit: true
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    hidden_points_if_no: [is_first_row, show_in_vis]
    listen: {}
    row: 71
    col: 8
    width: 8
    height: 8
  - title: Project On Time Delivery L12M
    name: Project On Time Delivery L12M
    model: analytics
    explore: projects_delivered
    type: looker_line
    fields: [companies_dim.company_name, projects_delivered.project_code, projects_delivered.project_name,
      projects_delivered.project_delivery_start_ts_date, projects_delivered.project_delivery_end_ts_date,
      project_timesheets.last_timesheet_billing_date, projects_delivered.project_delivery_end_ts_month,
      project_timesheets.total_timesheet_hours_billed, companies_dim.count, projects_invoiced.invoice_date]
    filters:
      companies_dim.company_name: "-Rittman Analytics Internal"
      projects_delivered.project_delivery_end_ts_date: before 0 minutes ago
      projects_delivered.project_name: ''
      project_timesheets.total_timesheet_hours_billed: ">0"
      projects_delivered.project_delivery_end_ts_month: 12 months
    sorts: [projects_delivered.project_delivery_end_ts_month]
    limit: 5000
    dynamic_fields: [{category: table_calculation, expression: 'diff_days(${projects_delivered.project_delivery_end_ts_date},${project_timesheets.last_timesheet_billing_date})',
        label: Days after sprint end, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: days_after_sprint_end, _type_hint: number},
      {category: table_calculation, expression: 'if(${days_after_sprint_end}>0,no,yes)',
        label: On-Time Delivery, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: on_time_delivery, _type_hint: yesno},
      {category: table_calculation, expression: 'match(${projects_delivered.project_delivery_end_ts_month},
          ${projects_delivered.project_delivery_end_ts_month})', label: Group Start
          row, value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        table_calculation: group_start_row, _type_hint: number}, {category: table_calculation,
        expression: 'count(${projects_delivered.project_delivery_end_ts_month}) -
          match(${projects_delivered.project_delivery_end_ts_month}, offset(${projects_delivered.project_delivery_end_ts_month},
          count(${projects_delivered.project_delivery_end_ts_month}) - row() * 2 +
          1)) + 2', label: Next group start row, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, table_calculation: next_group_start_row, _type_hint: number},
      {category: table_calculation, expression: 'sum(offset_list(${companies_dim.count},
          -1 * (row() - ${group_start_row}), ${next_group_start_row} - ${group_start_row}))',
        label: Total Monthly Sprints, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: total_monthly_sprints, _type_hint: number},
      {category: table_calculation, expression: count(1), label: New Calculation,
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        table_calculation: new_calculation, _type_hint: number, is_disabled: true},
      {category: measure, expression: !!null '', label: Count, value_format: !!null '',
        value_format_name: !!null '', based_on: companies_dim.company_name, _kind_hint: measure,
        measure: count, type: count_distinct, _type_hint: number}, {category: table_calculation,
        expression: 'offset_list(${count}, -1 * (row() - ${group_start_row}), ${next_group_start_row}
          - ${group_start_row})', label: New Calculation, value_format: !!null '',
        value_format_name: !!null '', _kind_hint: measure, table_calculation: new_calculation_1,
        _type_hint: number_list, is_disabled: true}, {category: table_calculation,
        expression: 'row() - ${group_start_row}', label: C0, value_format: !!null '',
        value_format_name: !!null '', _kind_hint: dimension, table_calculation: c0,
        _type_hint: number, is_disabled: true}, {category: table_calculation, expression: "${next_group_start_row}\
          \ - ${group_start_row}", label: C1, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, table_calculation: c1, _type_hint: number, is_disabled: true},
      {category: table_calculation, expression: 'count(${projects_delivered.project_delivery_end_ts_month})',
        label: NGS1, value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        table_calculation: ngs1, _type_hint: number, is_disabled: true}, {category: table_calculation,
        expression: 'count(${projects_delivered.project_delivery_end_ts_month}) -
          row() * 2 + 1', label: NSG2, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, table_calculation: nsg2, _type_hint: number, is_disabled: true},
      {category: table_calculation, expression: 'match(${projects_delivered.project_delivery_end_ts_month},
          offset(${projects_delivered.project_delivery_end_ts_month}, count(${projects_delivered.project_delivery_end_ts_month})
          - row() * 2 + 1))', label: NGS3, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, table_calculation: ngs3, _type_hint: number, is_disabled: true},
      {category: table_calculation, expression: 'if(${on_time_delivery}=yes,1,0)',
        label: On Time Count, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: on_time_count, _type_hint: number},
      {category: table_calculation, expression: 'if(${project_timesheets.total_timesheet_hours_billed}>0,1,0)',
        label: Count, value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        table_calculation: count_1, _type_hint: number, is_disabled: true}, {category: table_calculation,
        expression: 'sum(offset_list(${on_time_count}, -1 * (row() - ${group_start_row}),
          ${next_group_start_row} - ${group_start_row}))', label: Total Monthly On
          Time, value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        table_calculation: total_monthly_on_time, _type_hint: number}, {category: table_calculation,
        expression: "${total_monthly_on_time}/${total_monthly_sprints}", label: "%\
          \ On Time (monthly)", value_format: !!null '', value_format_name: percent_1,
        _kind_hint: measure, table_calculation: on_time_monthly, _type_hint: number},
      {category: table_calculation, expression: 'if(${group_start_row}=row(),yes,no)',
        label: 'Show in Table?', value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, table_calculation: show_in_table, _type_hint: yesno},
      {category: table_calculation, description: The number of days between the sprint
          end and the invoice date, expression: 'diff_days(${projects_delivered.project_delivery_end_ts_date},${projects_invoiced.invoice_date})',
        label: Days to Invoice, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, table_calculation: days_to_invoice, _type_hint: number}]
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
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    y_axes: [{label: "% of Sprints Delivered On Time", orientation: left, series: [
          {axisId: on_time_monthly, id: on_time_monthly, name: "% On Time (monthly)"}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_label: Month
    series_types: {}
    series_colors: {}
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: right, color: "#D03452",
        line_value: ".9", label: Target}]
    hidden_points_if_no: [show_in_table]
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_fields: [companies_dim.company_name, projects_delivered.project_code, projects_delivered.project_name,
      projects_delivered.project_delivery_start_ts_date, projects_delivered.project_delivery_end_ts_date,
      group_start_row, next_group_start_row, project_timesheets.last_timesheet_billing_date,
      project_timesheets.total_timesheet_hours_billed, days_after_sprint_end, on_time_delivery,
      total_monthly_sprints, total_monthly_on_time, on_time_count, companies_dim.count,
      days_to_invoice, projects_invoiced.invoice_date]
    listen: {}
    row: 71
    col: 16
    width: 8
    height: 8
  - title: Booked-In Revenue Pipeline
    name: Booked-In Revenue Pipeline
    model: analytics
    explore: companies_dim
    type: looker_column
    fields: [companies_dim.company_name, projects_delivered.total_project_fee_amount,
      projects_delivered.project_delivery_start_ts_month]
    pivots: [companies_dim.company_name]
    fill_fields: [projects_delivered.project_delivery_start_ts_month]
    filters:
      companies_dim.company_name: "-%Rittman%,-%Colourpop%,-%Football Index%,-%RevenueRoll%"
      projects_invoiced.invoice_status: ''
      projects_delivered.project_code: "-QUB-013-002"
      projects_delivered.project_delivery_start_ts_month: after 0 minutes ago
      projects_delivered.project_fee_amount: ">0"
      projects_delivered.project_name: "-Project X-Ray : Initial Build Phase"
    sorts: [companies_dim.company_name, projects_delivered.project_delivery_start_ts_month]
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
    hide_legend: true
    series_types: {}
    series_labels:
      companies_dim.company_name: Client
      projects_delivered.project_delivery_start_ts_date: Start
      projects_delivered.project_name: Project
      projects_delivered.project_fee_amount: Amount
      projects_delivered.total_business_days_pct_elapsed: "% Elapsed"
      projects_delivered.total_project_fee_amount: Amount
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: true
    series_cell_visualizations:
      projects_delivered.total_project_fee_amount:
        is_active: false
      projects_delivered.total_business_days_pct_elapsed:
        is_active: false
        value_display: false
        palette:
          palette_id: c8e61ae5-b4ef-4fca-8f2f-92d1bd146bb1
          collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#3C358B",
        font_color: !!null '', color_application: {collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde,
          palette_id: c8e61ae5-b4ef-4fca-8f2f-92d1bd146bb1, options: {constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    series_value_format:
      projects_delivered.total_project_fee_amount:
        name: gbp_0
        format_string: '"£"#,##0'
        label: British Pounds (0)
    truncate_column_names: false
    defaults_version: 1
    hidden_fields: []
    listen: {}
    row: 31
    col: 16
    width: 8
    height: 9
  - title: Client Project Margin % Variance from Average L3M
    name: Client Project Margin % Variance from Average L3M
    model: analytics
    explore: projects_delivered
    type: looker_grid
    fields: [companies_dim.company_name, project_timesheets.total_timesheet_hours_billed,
      project_timesheets.avg_timesheet_billable_hourly_cost_amount_gbp, project_timesheets.total_timesheet_cost_amount_gbp,
      projects_invoiced.count_invoices, timesheet_project_costs_fact.total_cost_gbp,
      projects_invoiced.total_net_amount_gbp]
    filters:
      companies_dim.company_name: ''
      projects_invoiced.count_invoices: ">0"
      projects_invoiced.invoice_status: "-DRAFT,-Draft"
      project_timesheets.timesheet_billing_date: 3 months
    sorts: [project_timesheets.total_timesheet_hours_billed desc 0]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: table_calculation, expression: "${projects_invoiced.total_net_amount_gbp}-${project_timesheets.total_timesheet_cost_amount_gbp}-${timesheet_project_costs_fact.total_cost_gbp}",
        label: Project Net Margin GBP, value_format: !!null '', value_format_name: gbp_0,
        _kind_hint: measure, table_calculation: project_net_margin_gbp, _type_hint: number},
      {category: table_calculation, expression: "${project_net_margin_gbp}/${projects_invoiced.total_net_amount_gbp}",
        label: Project Net Margin %, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: project_net_margin, _type_hint: number},
      {category: table_calculation, expression: 'sum(${project_net_margin_gbp})/sum(${projects_invoiced.total_net_amount_gbp})',
        label: Average Net Margin, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: average_net_margin, _type_hint: number},
      {category: table_calculation, expression: "${project_net_margin}-${average_net_margin}",
        label: Variance from Average Project Net Margin %, value_format: !!null '',
        value_format_name: percent_0, _kind_hint: measure, table_calculation: variance_from_average_project_net_margin,
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
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    series_labels:
      projects_invoiced.total_net_amount_gbp: Revenue
      project_net_margin_gbp: Margin
    series_cell_visualizations:
      projects_invoiced.total_net_amount_gbp:
        is_active: true
        palette:
          palette_id: 4868aae1-d096-4d4d-a37b-8d86e7f50396
          collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      project_net_margin_gbp:
        is_active: true
        palette:
          palette_id: 4868aae1-d096-4d4d-a37b-8d86e7f50396
          collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      project_net_margin:
        is_active: true
        palette:
          palette_id: 4868aae1-d096-4d4d-a37b-8d86e7f50396
          collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      variance_from_average_project_net_margin:
        is_active: true
        palette:
          palette_id: 4868aae1-d096-4d4d-a37b-8d86e7f50396
          collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_fields: [project_timesheets.total_timesheet_hours_billed, project_timesheets.avg_timesheet_billable_hourly_cost_amount_gbp,
      project_timesheets.total_timesheet_cost_amount_gbp, projects_invoiced.count_invoices,
      timesheet_project_costs_fact.total_cost_gbp, average_net_margin, project_net_margin_gbp,
      projects_invoiced.total_net_amount_gbp, project_net_margin]
    series_types: {}
    listen: {}
    row: 53
    col: 0
    width: 8
    height: 8
  - title: Gross and Net Margin vs Target % L12M
    name: Gross and Net Margin vs Target % L12M
    model: analytics
    explore: chart_of_accounts_dim
    type: looker_line
    fields: [profit_and_loss_report_fact.amount, profit_and_loss_report_fact.account_report_category,
      profit_and_loss_report_fact.period_month]
    pivots: [profit_and_loss_report_fact.account_report_category]
    fill_fields: [profit_and_loss_report_fact.period_month]
    filters:
      profit_and_loss_report_fact.account_report_category: Revenue,Cost of Delivery,Overheads
      profit_and_loss_report_fact.period_year: 12 months
    sorts: [profit_and_loss_report_fact.amount desc 0, profit_and_loss_report_fact.account_report_category]
    limit: 500
    total: true
    dynamic_fields: [{category: table_calculation, label: Cumulative Revenue, value_format: !!null '',
        value_format_name: !!null '', calculation_type: running_total, table_calculation: cumulative_revenue,
        args: [profit_and_loss_report_fact.amount], _kind_hint: measure, _type_hint: number,
        is_disabled: true}, {category: table_calculation, expression: "(pivot_index(${profit_and_loss_report_fact.amount},3)+pivot_index(${profit_and_loss_report_fact.amount},1))/pivot_index(${profit_and_loss_report_fact.amount},3)",
        label: Gross Margin %, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: supermeasure, table_calculation: gross_margin, _type_hint: number},
      {category: table_calculation, expression: "(pivot_index(${profit_and_loss_report_fact.amount},3)+pivot_index(${profit_and_loss_report_fact.amount},1)+pivot_index(${profit_and_loss_report_fact.amount},2))/pivot_index(${profit_and_loss_report_fact.amount},3)",
        label: Net Margin %, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: supermeasure, table_calculation: net_margin, _type_hint: number}]
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
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: gross_margin, id: gross_margin,
            name: Gross Margin %}, {axisId: net_margin, id: net_margin, name: Net
              Margin %}], showLabels: true, showValues: true, maxValue: 0.7, minValue: 0,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    series_types: {}
    series_colors:
      2021 - running_total_of_profit_loss_report_amount: "#3C358B"
      2020 - running_total_of_profit_loss_report_amount: "#F4B87B"
      2019 - running_total_of_profit_loss_report_amount: "#A4A8D1"
      2021 - profit_and_loss_report_fact.amount: "#3C358B"
      2019 - profit_and_loss_report_fact.amount: "#A4A8D1"
      2020 - profit_and_loss_report_fact.amount: "#F4B87B"
      net_margin: "#D13452"
      gross_margin: "#4A80BC"
    reference_lines: [{reference_type: range, line_value: mean, range_end: ".60",
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: right,
        color: "#3C358B", range_start: ".50", label: Target Gross Margin %}, {reference_type: range,
        line_value: mean, range_start: ".3", range_end: ".2", margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: right, color: "#8C3535",
        label: Target Net Margin %}]
    defaults_version: 1
    hidden_fields: [profit_and_loss_report_fact.amount]
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen: {}
    row: 53
    col: 8
    width: 8
    height: 8
  - name: ''
    type: text
    title_text: ''
    body_text: |-
      <p align="center">

      <b><font color="DimGrey" size="5">Operations</font></b>

      </p>
    row: 51
    col: 0
    width: 24
    height: 2
  - title: Client Concentration vs Target L12M
    name: Client Concentration vs Target L12M
    model: analytics
    explore: companies_dim
    type: looker_column
    fields: [projects_invoiced.invoice_month, projects_invoiced.invoice_gbp_revenue_amount,
      companies_dim.company_name]
    pivots: [companies_dim.company_name]
    filters:
      projects_invoiced.invoice_gbp_revenue_amount: ">0"
      projects_invoiced.invoice_year: 1 years
    sorts: [projects_invoiced.invoice_month desc, companies_dim.company_name]
    limit: 500
    dynamic_fields: [{table_calculation: of_total, label: "% of Total", expression: "${projects_invoiced.invoice_gbp_revenue_amount}/sum(pivot_row(${projects_invoiced.invoice_gbp_revenue_amount}))",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: client_concentration, label: Client
          Concentration, expression: 'max(pivot_row(${of_total}))', value_format: !!null '',
        value_format_name: percent_0, _kind_hint: supermeasure, _type_hint: number},
      {table_calculation: total_revenue, label: Total Revenue, expression: 'sum(pivot_row(${projects_invoiced.invoice_gbp_revenue_amount}))',
        value_format: !!null '', value_format_name: gbp_0, _kind_hint: supermeasure,
        _type_hint: number}]
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
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: client_concentration,
            id: client_concentration, name: Client Concentration}], showLabels: true,
        showValues: true, maxValue: 1, minValue: 0, unpinAxis: false, tickDensity: default,
        type: linear}]
    series_types:
      client_concentration: line
    series_colors:
      client_concentration: "#4A80BC"
    reference_lines: [{reference_type: margins, range_start: max, range_end: min,
        label_position: right, color: "#D03452", line_value: ".5", label: Target,
        margin_bottom: ".1", margin_top: ".2", margin_value: ".5"}, {reference_type: margins,
        range_start: max, range_end: min, label_position: right, color: "#F4B87B",
        line_value: ".3", margin_top: ".1", margin_value: ".3", margin_bottom: ".2",
        label: Monitor}]
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [of_total, total_revenue, projects_invoiced.invoice_gbp_revenue_amount]
    listen: {}
    row: 41
    col: 16
    width: 8
    height: 10
  - name: " (2)"
    type: text
    title_text: ''
    body_text: |-
      <p align="center">

      <b><font color="DimGrey" size="5">Delivery</font></b>

      </p>
    row: 61
    col: 0
    width: 24
    height: 2
  - name: Employee Net Promoter Score vs Target L12M
    title: Employee Net Promoter Score vs Target L12M
    merged_queries:
    - model: analytics
      explore: hr_survey_results_fact
      type: table
      fields: [hr_survey_results_fact.avg_e_nps, hr_survey_results_fact.survey_ts_month]
      filters:
        hr_survey_results_fact.survey_ts_month: 12 months
        hr_survey_results_fact.avg_e_nps: NOT NULL
      sorts: [hr_survey_results_fact.survey_ts_month desc]
      limit: 500
      join_fields: []
    - model: analytics
      explore: targets
      type: table
      fields: [targets.period_month, targets.avg_enps_target]
      fill_fields: [targets.period_month]
      sorts: [targets.period_month desc]
      limit: 500
      join_fields:
      - field_name: targets.period_month
        source_field_name: hr_survey_results_fact.survey_ts_month
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
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
    series_colors:
      targets.avg_enps_target: "#D13452"
    series_labels:
      hr_survey_results_fact.avg_e_nps: e-NPS
      targets.avg_enps_target: Target
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    type: looker_line
    column_limit: 50
    row: 71
    col: 0
    width: 8
    height: 8
  - title: Team Sentiment
    name: Team Sentiment
    model: analytics
    explore: hr_survey_results_fact
    type: marketplace_viz_spider::spider-marketplace
    fields: [hr_survey_results_fact.avg_alignment_score, hr_survey_results_fact.avg_ambassadorship_score,
      hr_survey_results_fact.avg_personal_growth_score, hr_survey_results_fact.avg_recognition_score,
      hr_survey_results_fact.avg_wellness_score, hr_survey_results_fact.avg_satisfaction_score,
      hr_survey_results_fact.survey_ts_month]
    fill_fields: [hr_survey_results_fact.survey_ts_month]
    filters:
      hr_survey_results_fact.survey_ts_month: 3 months
    sorts: [hr_survey_results_fact.survey_ts_month]
    limit: 500
    column_limit: 50
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
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
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 0
    series_types: {}
    listen: {}
    row: 79
    col: 0
    width: 8
    height: 8
  - title: Revenue by Client L12M
    name: Revenue by Client L12M
    model: analytics
    explore: projects_delivered
    type: looker_column
    fields: [projects_invoiced.total_net_amount_gbp, companies_dim.company_name, projects_invoiced.invoice_month]
    pivots: [companies_dim.company_name]
    fill_fields: [projects_invoiced.invoice_month]
    filters:
      projects_invoiced.invoice_month: 12 months
    sorts: [companies_dim.company_name, projects_invoiced.invoice_month desc]
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: Ageras - projects_invoiced.total_net_amount_gbp,
            id: Ageras - projects_invoiced.total_net_amount_gbp, name: Ageras}, {
            axisId: Breakthrough - projects_invoiced.total_net_amount_gbp, id: Breakthrough
              - projects_invoiced.total_net_amount_gbp, name: Breakthrough}, {axisId: Bridge-U
              - projects_invoiced.total_net_amount_gbp, id: Bridge-U - projects_invoiced.total_net_amount_gbp,
            name: Bridge-U}, {axisId: Dr. B - projects_invoiced.total_net_amount_gbp,
            id: Dr. B - projects_invoiced.total_net_amount_gbp, name: Dr. B}, {axisId: Fivetran
              - projects_invoiced.total_net_amount_gbp, id: Fivetran - projects_invoiced.total_net_amount_gbp,
            name: Fivetran}, {axisId: Flock  - projects_invoiced.total_net_amount_gbp,
            id: Flock  - projects_invoiced.total_net_amount_gbp, name: 'Flock '},
          {axisId: INTO University Partnerships - projects_invoiced.total_net_amount_gbp,
            id: INTO University Partnerships - projects_invoiced.total_net_amount_gbp,
            name: INTO University Partnerships}, {axisId: Kaplan International Pathways
              - projects_invoiced.total_net_amount_gbp, id: Kaplan International Pathways
              - projects_invoiced.total_net_amount_gbp, name: Kaplan International
              Pathways}, {axisId: Lick - projects_invoiced.total_net_amount_gbp, id: Lick
              - projects_invoiced.total_net_amount_gbp, name: Lick}, {axisId: Looker
              Data Sciences - projects_invoiced.total_net_amount_gbp, id: Looker Data
              Sciences - projects_invoiced.total_net_amount_gbp, name: Looker Data
              Sciences}, {axisId: Oda Norway AS - projects_invoiced.total_net_amount_gbp,
            id: Oda Norway AS - projects_invoiced.total_net_amount_gbp, name: Oda
              Norway AS}, {axisId: Qubit - projects_invoiced.total_net_amount_gbp,
            id: Qubit - projects_invoiced.total_net_amount_gbp, name: Qubit}, {axisId: RIXO
              - projects_invoiced.total_net_amount_gbp, id: RIXO - projects_invoiced.total_net_amount_gbp,
            name: RIXO}, {axisId: Shutterstock - projects_invoiced.total_net_amount_gbp,
            id: Shutterstock - projects_invoiced.total_net_amount_gbp, name: Shutterstock},
          {axisId: Sytner Group  - projects_invoiced.total_net_amount_gbp, id: Sytner
              Group  - projects_invoiced.total_net_amount_gbp, name: 'Sytner Group '},
          {axisId: The Oakland Group - projects_invoiced.total_net_amount_gbp, id: The
              Oakland Group - projects_invoiced.total_net_amount_gbp, name: The Oakland
              Group}, {axisId: Thrive Capital - projects_invoiced.total_net_amount_gbp,
            id: Thrive Capital - projects_invoiced.total_net_amount_gbp, name: Thrive
              Capital}], showLabels: true, showValues: true, valueFormat: '"£"0,"K"',
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    hide_legend: true
    font_size: '12'
    series_types: {}
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 31
    col: 8
    width: 8
    height: 9
  - name: " (3)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: |-
      <p align="center">

      <b><font size="5" color="DimGrey">Sales & Marketing</font></b>

      </p>
    row: 7
    col: 0
    width: 24
    height: 2
  - type: button
    name: button_1782
    rich_content_json: '{"text":"View Deals in Hubspot","description":"View current
      deal board in Hubspot","newTab":true,"alignment":"center","size":"small","style":"OUTLINED","color":"#1A73E8","href":"https://app.hubspot.com/contacts/4402794/objects/0-3/views/all/board"}'
    row: 30
    col: 0
    width: 8
    height: 1
  - type: button
    name: button_1783
    rich_content_json: '{"text":"View Open Deals in Hubspot","description":"","newTab":true,"alignment":"center","size":"small","style":"OUTLINED","color":"#1A73E8","href":"https://app.hubspot.com/contacts/4402794/objects/0-3/views/2560409/board"}'
    row: 30
    col: 16
    width: 8
    height: 1
  - type: button
    name: button_1784
    rich_content_json: '{"text":"View Closed Deals in Hubspot","description":"","newTab":true,"alignment":"center","size":"small","style":"OUTLINED","color":"#1A73E8","href":"https://app.hubspot.com/contacts/4402794/objects/0-3/views/8745353/list"}'
    row: 30
    col: 8
    width: 8
    height: 1
  - type: button
    name: button_1785
    rich_content_json: '{"text":"View Active Projects in Harvest","description":"","newTab":true,"alignment":"center","size":"small","style":"OUTLINED","color":"#1A73E8","href":"https://rittman.harvestapp.com/projects?filter=active"}'
    row: 40
    col: 16
    width: 8
    height: 1
  - type: button
    name: button_1786
    rich_content_json: '{"text":"View Revenue by Client YTD in Xero","description":"","newTab":true,"alignment":"center","size":"small","style":"OUTLINED","color":"#1A73E8","href":"https://reporting.xero.com/!2r8Ny/v1/Run/1209"}'
    row: 40
    col: 8
    width: 8
    height: 1
  - type: button
    name: button_1787
    rich_content_json: '{"text":"View Revenue vs Target and Forecast in Google Sheets","description":"","newTab":true,"alignment":"center","size":"small","style":"OUTLINED","color":"#1A73E8","href":"https://docs.google.com/spreadsheets/d/1gAVDTqfxpzGN6OFbYqGTMwoBSckCE0yTC1J4YS65Z_4/edit#gid=0"}'
    row: 40
    col: 0
    width: 8
    height: 1
  - name: Individual Attributed Revenue CM vs L3M
    title: Individual Attributed Revenue CM vs L3M
    merged_queries:
    - model: analytics
      explore: project_attribution
      type: table
      fields: [staff_dim.contact_name, project_attribution.attributed_revenue_gbp]
      filters:
        project_attribution.billing_month: 3 months
        staff_dim.contact_name: "-Mike Calleja,-Rob Bramwell,-Will Berrystone"
      sorts: [staff_dim.contact_name]
      limit: 500
      dynamic_fields: [{category: table_calculation, expression: "${project_attribution.attributed_revenue_gbp}/3",
          label: Avg Monthly Attributed Revenue, value_format: !!null '', value_format_name: gbp_0,
          _kind_hint: measure, table_calculation: avg_monthly_attributed_revenue,
          _type_hint: number}]
      join_fields: []
    - model: analytics
      explore: project_attribution
      type: table
      fields: [staff_dim.contact_name, project_attribution.attributed_revenue_gbp]
      filters:
        project_attribution.billing_month: 1 months
        staff_dim.contact_name: "-Mike Calleja,-Rob Bramwell,-Will Berrystone,-Toby\
          \ Sexton"
      sorts: [project_attribution.attributed_revenue_gbp desc 0]
      limit: 500
      join_fields:
      - field_name: staff_dim.contact_name
        source_field_name: staff_dim.contact_name
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
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
    series_types: {}
    point_style: none
    series_colors:
      avg_monthly_attributed_revenue: "#D13452"
      q1_project_attribution.attributed_revenue_gbp: "#4A80BC"
    series_labels:
      avg_monthly_attributed_revenue: Three-Month Avg Attributed Revenue GBP
      q1_project_attribution.attributed_revenue_gbp: Last Month Attributed Revenue
        GBP
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_dropoff: true
    hidden_fields: [project_attribution.attributed_revenue_gbp]
    type: looker_bar
    column_limit: 50
    row: 79
    col: 8
    width: 8
    height: 8
  - title: Certification Progress
    name: Certification Progress
    model: analytics
    explore: certification_progress
    type: looker_line
    fields: [certification_progress.progress_month, certification_progress.score_target,
      certification_progress.total_score]
    fill_fields: [certification_progress.progress_month]
    sorts: [certification_progress.progress_month]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: 'if(${certification_progress.total_score}=0,null,${certification_progress.score_target})',
        label: Target, value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        table_calculation: target, _type_hint: number}, {category: table_calculation,
        expression: 'if(${certification_progress.total_score}=0,null,${certification_progress.total_score})',
        label: Progress, value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        table_calculation: progress, _type_hint: number}, {args: [certification_progress.score_target],
        calculation_type: running_total, category: table_calculation, based_on: certification_progress.score_target,
        label: Running total of Certification Progress Score Target, source_field: certification_progress.score_target,
        table_calculation: running_total_of_certification_progress_score_target, value_format: !!null '',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: number, is_disabled: true},
      {args: [certification_progress.score_target], calculation_type: running_total,
        category: table_calculation, based_on: certification_progress.score_target,
        label: Running total of Certification Progress Score Target, source_field: certification_progress.score_target,
        table_calculation: running_total_of_certification_progress_score_target_2,
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {category: table_calculation, expression: "${running_total_of_certification_progress_score_target_2}/${total_points}",
        label: Target Progress, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: target_progress, _type_hint: number},
      {category: table_calculation, expression: 'max(${running_total_of_certification_progress_score_target_2})',
        label: Total Points, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: total_points, _type_hint: number},
      {category: table_calculation, expression: "${progress}/${total_points}", label: Progress
          to Date, value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        table_calculation: progress_to_date, _type_hint: number}]
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
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    series_colors:
      target: "#D13452"
      progress: "#4A80BC"
      certification_progress.score_target: "#D13452"
      running_total_of_certification_progress_score_target_2: "#D13452"
      target_progress: "#D13452"
      progress_to_date: "#4A80BC"
    series_labels:
      running_total_of_certification_progress_score_target_2: Target for GCP Looker
        Partner Status
    defaults_version: 1
    hidden_fields: [target, certification_progress.total_score, certification_progress.score_target,
      running_total_of_certification_progress_score_target_2, total_points, progress]
    listen: {}
    row: 79
    col: 16
    width: 8
    height: 8
  - name: New Deals vs Target This Month
    title: New Deals vs Target This Month
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: table
      fields: [deals_fact.deal_created_month, deals_fact.total_deal_amount_gbp_converted]
      fill_fields: [deals_fact.deal_created_month]
      filters:
        deals_fact.deal_created_month: 2 months
        deals_fact.deal_is_deleted: 'No'
      sorts: [deals_fact.deal_created_month desc]
      limit: 500
      join_fields: []
    - model: analytics
      explore: targets
      type: table
      fields: [targets.period_month, targets.total_deals_target]
      fill_fields: [targets.period_month]
      filters:
        targets.period_month: 12 months
      sorts: [targets.period_month desc]
      limit: 500
      join_fields:
      - field_name: targets.period_month
        source_field_name: deals_fact.deal_created_month
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: New Deals This Month
    value_format: '"£"0,"K"'
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Target
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    series_types: {}
    point_style: none
    series_colors:
      targets.total_deals_target: "#8C3535"
      targets.total_deals_closed_target: "#8C3535"
    series_labels:
      deals_fact.total_deal_amount_gbp_converted: Amount
      targets.total_deals_closed_target: Target
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    type: single_value
    column_limit: 50
    row: 2
    col: 0
    width: 4
    height: 5
  - name: Revenue vs Target This Month
    title: Revenue vs Target This Month
    merged_queries:
    - model: analytics
      explore: projects_delivered
      type: table
      fields: [projects_invoiced.invoice_month, projects_invoiced.total_net_amount_gbp]
      fill_fields: [projects_invoiced.invoice_month]
      filters:
        projects_invoiced.invoice_month: 2 months
      sorts: [projects_invoiced.invoice_month desc]
      limit: 500
      join_fields: []
    - model: analytics
      explore: targets
      type: table
      fields: [targets.period_month, targets.total_revenue_target]
      fill_fields: [targets.period_month]
      sorts: [targets.period_month desc]
      limit: 500
      join_fields:
      - field_name: targets.period_month
        source_field_name: projects_invoiced.invoice_month
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Net Revenue This Month
    value_format: '"£"0,"K"'
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Target
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '12'
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      targets.total_revenue_target: "#8C3535"
    series_labels:
      projects_invoiced.total_net_amount_gbp: Revenue
      targets.total_revenue_target: Target
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    type: single_value
    column_limit: 50
    row: 2
    col: 4
    width: 4
    height: 5
  - name: eNPS vs Target LM
    title: eNPS vs Target LM
    merged_queries:
    - model: analytics
      explore: hr_survey_results_fact
      type: table
      fields: [hr_survey_results_fact.avg_e_nps, hr_survey_results_fact.survey_ts_month]
      filters:
        hr_survey_results_fact.survey_ts_month: 1 months ago for 1 months
        hr_survey_results_fact.avg_e_nps: NOT NULL
      sorts: [hr_survey_results_fact.survey_ts_month desc]
      limit: 500
      join_fields: []
    - model: analytics
      explore: targets
      type: table
      fields: [targets.period_month, targets.avg_enps_target]
      fill_fields: [targets.period_month]
      sorts: [targets.period_month desc]
      limit: 500
      join_fields:
      - field_name: targets.period_month
        source_field_name: hr_survey_results_fact.survey_ts_month
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: eNPS LM
    value_format: 0"%"
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Target
    enable_conditional_formatting: true
    conditional_formatting: [{type: equal to, value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    series_colors:
      targets.avg_enps_target: "#D13452"
    series_labels:
      hr_survey_results_fact.avg_e_nps: e-NPS
      targets.avg_enps_target: Target
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    type: single_value
    series_types: {}
    column_limit: 50
    row: 2
    col: 16
    width: 4
    height: 5
  - title: Cert Progress vs Target To Date
    name: Cert Progress vs Target To Date
    model: analytics
    explore: certification_progress
    type: single_value
    fields: [certification_progress.progress_month, certification_progress.score_target,
      certification_progress.total_score]
    fill_fields: [certification_progress.progress_month]
    sorts: [certification_progress.progress_month]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: 'if(${certification_progress.total_score}=0,null,${certification_progress.score_target})',
        label: Target, value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        table_calculation: target, _type_hint: number}, {category: table_calculation,
        expression: 'if(${certification_progress.total_score}=0,offset(${certification_progress.total_score},-1),${certification_progress.total_score})',
        label: Progress, value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        table_calculation: progress, _type_hint: number}, {args: [certification_progress.score_target],
        calculation_type: running_total, category: table_calculation, based_on: certification_progress.score_target,
        label: Running total of Certification Progress Score Target, source_field: certification_progress.score_target,
        table_calculation: running_total_of_certification_progress_score_target, value_format: !!null '',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: number, is_disabled: true},
      {args: [certification_progress.score_target], calculation_type: running_total,
        category: table_calculation, based_on: certification_progress.score_target,
        label: Running total of Certification Progress Score Target, source_field: certification_progress.score_target,
        table_calculation: running_total_of_certification_progress_score_target_2,
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {category: table_calculation, expression: "${running_total_of_certification_progress_score_target_2}/${total_points}",
        label: Target Progress, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: target_progress, _type_hint: number},
      {category: table_calculation, expression: 'max(${running_total_of_certification_progress_score_target_2})',
        label: Total Points, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: total_points, _type_hint: number},
      {category: table_calculation, expression: "${progress}/${total_points}", label: Progress
          to Date, value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        table_calculation: progress_to_date, _type_hint: number}, {category: table_calculation,
        expression: "lookup(\n  trunc_months(now()),trunc_months(${certification_progress.progress_month}),${progress_to_date})",
        label: Total Progress To Date, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: total_progress_to_date, _type_hint: number},
      {category: table_calculation, expression: "lookup(\n  trunc_months(now()),trunc_months(${certification_progress.progress_month}),${target_progress})",
        label: Target Progress To Date, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: target_progress_to_date, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    single_value_title: Certification Progress To Date
    comparison_label: Target
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
    series_colors:
      target: "#D13452"
      progress: "#4A80BC"
      certification_progress.score_target: "#D13452"
      running_total_of_certification_progress_score_target_2: "#D13452"
      target_progress: "#D13452"
      progress_to_date: "#4A80BC"
    series_labels:
      running_total_of_certification_progress_score_target_2: Target for GCP Looker
        Partner Status
    defaults_version: 1
    hidden_fields: [target, certification_progress.total_score, certification_progress.score_target,
      running_total_of_certification_progress_score_target_2, total_points, progress,
      target_progress, progress_to_date]
    series_types: {}
    listen: {}
    row: 2
    col: 20
    width: 4
    height: 5
  - title: Project On Time Delivery vs Target This Month
    name: Project On Time Delivery vs Target This Month
    model: analytics
    explore: projects_delivered
    type: single_value
    fields: [companies_dim.company_name, projects_delivered.project_code, projects_delivered.project_name,
      projects_delivered.project_delivery_start_ts_date, projects_delivered.project_delivery_end_ts_date,
      project_timesheets.last_timesheet_billing_date, projects_delivered.project_delivery_end_ts_month,
      project_timesheets.total_timesheet_hours_billed, companies_dim.count, projects_invoiced.invoice_date]
    filters:
      companies_dim.company_name: "-Rittman Analytics Internal"
      projects_delivered.project_delivery_end_ts_date: before 0 minutes ago
      projects_delivered.project_name: ''
      project_timesheets.total_timesheet_hours_billed: ">0"
      projects_delivered.project_delivery_end_ts_month: 1 months
    sorts: [projects_delivered.project_delivery_end_ts_month]
    limit: 5000
    dynamic_fields: [{category: table_calculation, expression: 'diff_days(${projects_delivered.project_delivery_end_ts_date},${project_timesheets.last_timesheet_billing_date})',
        label: Days after sprint end, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: days_after_sprint_end, _type_hint: number},
      {category: table_calculation, expression: 'if(${days_after_sprint_end}>0,no,yes)',
        label: On-Time Delivery, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: on_time_delivery, _type_hint: yesno},
      {category: table_calculation, expression: 'match(${projects_delivered.project_delivery_end_ts_month},
          ${projects_delivered.project_delivery_end_ts_month})', label: Group Start
          row, value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        table_calculation: group_start_row, _type_hint: number}, {category: table_calculation,
        expression: 'count(${projects_delivered.project_delivery_end_ts_month}) -
          match(${projects_delivered.project_delivery_end_ts_month}, offset(${projects_delivered.project_delivery_end_ts_month},
          count(${projects_delivered.project_delivery_end_ts_month}) - row() * 2 +
          1)) + 2', label: Next group start row, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, table_calculation: next_group_start_row, _type_hint: number},
      {category: table_calculation, expression: 'sum(offset_list(${companies_dim.count},
          -1 * (row() - ${group_start_row}), ${next_group_start_row} - ${group_start_row}))',
        label: Total Monthly Sprints, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: total_monthly_sprints, _type_hint: number},
      {category: table_calculation, expression: count(1), label: New Calculation,
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        table_calculation: new_calculation, _type_hint: number, is_disabled: true},
      {category: measure, expression: !!null '', label: Count, value_format: !!null '',
        value_format_name: !!null '', based_on: companies_dim.company_name, _kind_hint: measure,
        measure: count, type: count_distinct, _type_hint: number}, {category: table_calculation,
        expression: 'offset_list(${count}, -1 * (row() - ${group_start_row}), ${next_group_start_row}
          - ${group_start_row})', label: New Calculation, value_format: !!null '',
        value_format_name: !!null '', _kind_hint: measure, table_calculation: new_calculation_1,
        _type_hint: number_list, is_disabled: true}, {category: table_calculation,
        expression: 'row() - ${group_start_row}', label: C0, value_format: !!null '',
        value_format_name: !!null '', _kind_hint: dimension, table_calculation: c0,
        _type_hint: number, is_disabled: true}, {category: table_calculation, expression: "${next_group_start_row}\
          \ - ${group_start_row}", label: C1, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, table_calculation: c1, _type_hint: number, is_disabled: true},
      {category: table_calculation, expression: 'count(${projects_delivered.project_delivery_end_ts_month})',
        label: NGS1, value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        table_calculation: ngs1, _type_hint: number, is_disabled: true}, {category: table_calculation,
        expression: 'count(${projects_delivered.project_delivery_end_ts_month}) -
          row() * 2 + 1', label: NSG2, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, table_calculation: nsg2, _type_hint: number, is_disabled: true},
      {category: table_calculation, expression: 'match(${projects_delivered.project_delivery_end_ts_month},
          offset(${projects_delivered.project_delivery_end_ts_month}, count(${projects_delivered.project_delivery_end_ts_month})
          - row() * 2 + 1))', label: NGS3, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, table_calculation: ngs3, _type_hint: number, is_disabled: true},
      {category: table_calculation, expression: 'if(${on_time_delivery}=yes,1,0)',
        label: On Time Count, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: on_time_count, _type_hint: number},
      {category: table_calculation, expression: 'if(${project_timesheets.total_timesheet_hours_billed}>0,1,0)',
        label: Count, value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        table_calculation: count_1, _type_hint: number, is_disabled: true}, {category: table_calculation,
        expression: 'sum(offset_list(${on_time_count}, -1 * (row() - ${group_start_row}),
          ${next_group_start_row} - ${group_start_row}))', label: Total Monthly On
          Time, value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        table_calculation: total_monthly_on_time, _type_hint: number}, {category: table_calculation,
        expression: "${total_monthly_on_time}/${total_monthly_sprints}", label: "%\
          \ On Time (monthly)", value_format: !!null '', value_format_name: percent_1,
        _kind_hint: measure, table_calculation: on_time_monthly, _type_hint: number},
      {category: table_calculation, expression: 'if(${group_start_row}=row(),yes,no)',
        label: 'Show in Table?', value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, table_calculation: show_in_table, _type_hint: yesno},
      {category: table_calculation, description: The number of days between the sprint
          end and the invoice date, expression: 'diff_days(${projects_delivered.project_delivery_end_ts_date},${projects_invoiced.invoice_date})',
        label: Days to Invoice, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, table_calculation: days_to_invoice, _type_hint: number},
      {category: table_calculation, expression: '0.9', label: Target, value_format: !!null '',
        value_format_name: percent_0, _kind_hint: dimension, table_calculation: target,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    comparison_label: Target
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
    y_axes: [{label: "% of Sprints Delivered On Time", orientation: left, series: [
          {axisId: on_time_monthly, id: on_time_monthly, name: "% On Time (monthly)"}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_label: Month
    series_types: {}
    series_colors: {}
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: right, color: "#D03452",
        line_value: ".9", label: Target}]
    hidden_points_if_no: [show_in_table]
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    hidden_fields: [companies_dim.company_name, projects_delivered.project_code, projects_delivered.project_name,
      projects_delivered.project_delivery_start_ts_date, projects_delivered.project_delivery_end_ts_date,
      group_start_row, next_group_start_row, project_timesheets.last_timesheet_billing_date,
      project_timesheets.total_timesheet_hours_billed, days_after_sprint_end, on_time_delivery,
      total_monthly_sprints, total_monthly_on_time, on_time_count, companies_dim.count,
      days_to_invoice, projects_invoiced.invoice_date, projects_delivered.project_delivery_end_ts_month]
    listen: {}
    row: 2
    col: 12
    width: 4
    height: 5
  - title: Client Billing L12M
    name: Client Billing L12M
    model: analytics
    explore: projects_delivered
    type: looker_grid
    fields: [companies_dim.company_name, projects_invoiced.invoice_month, projects_invoiced.total_net_amount_gbp]
    pivots: [projects_invoiced.invoice_month]
    fill_fields: [projects_invoiced.invoice_month]
    filters:
      projects_invoiced.invoice_date: 12 months
    sorts: [projects_invoiced.invoice_month, companies_dim.company_name]
    limit: 500
    column_limit: 50
    total: true
    dynamic_fields: [{category: table_calculation, expression: 'if(is_null(${projects_invoiced.total_gross_amount_gbp}),null,running_total(${projects_invoiced.total_gross_amount_gbp}))',
        label: Running total of    Invoices Total Gross Amount Gbp, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: running_total_of_invoices_total_gross_amount_gbp,
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
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: true
    series_labels:
      projects_invoiced.total_net_amount_gbp: Billing
    series_cell_visualizations:
      projects_invoiced.total_gross_amount_gbp:
        is_active: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 95584bf9-c29e-41ea-b6e7-79e9c126e177, options: {steps: 5}},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_value_format:
      projects_invoiced.total_net_amount_gbp: '"£"0,"K"'
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
    show_null_points: false
    interpolation: linear
    defaults_version: 1
    hidden_fields: [running_total_of_invoices_total_gross_amount_gbp]
    listen: {}
    row: 41
    col: 0
    width: 16
    height: 10
  - name: " (4)"
    type: text
    title_text: ''
    body_text: |-
      <p align="center">

      <b><font color="DimGrey" size="5">Overall Performance</font></b>

      </p>
    row: 0
    col: 0
    width: 24
    height: 2
  - title: Team Utilisation
    name: Team Utilisation
    model: analytics
    explore: contact_utilization_fact
    type: looker_line
    fields: [contact_utilization_fact.forecast_week, contact_utilization_fact.total_hours_per_week,
      contact_utilization_fact.total_time_off, contact_utilization_fact.average_target,
      contact_utilization_fact.total_total_capacity, contact_utilization_fact.total_target_billable_capacity,
      contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours,
      contact_utilization_fact.total_actual_story_points, contact_utilization_fact.average_forecast_utilization,
      contact_utilization_fact.actual_to_forecast_utilization_variance, contact_utilization_fact.average_actual_utilization,
      contact_utilization_fact.actual_to_target_utilization_variance]
    fill_fields: [contact_utilization_fact.forecast_week]
    filters:
      staff_dim.contact_is_contractor: 'No'
      staff_dim.contact_name: "-Toby Sexton,-Benjamin Zarif"
      contact_utilization_fact.forecast_week: 52 weeks ago for 52 weeks
    sorts: [contact_utilization_fact.forecast_week desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${contact_utilization_fact.total_target_billable_capacity}/${contact_utilization_fact.total_hours_per_week}",
        label: Target Utilization %, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: target_utilization, _type_hint: number},
      {category: table_calculation, expression: "${contact_utilization_fact.total_actual_billable_hours}/${contact_utilization_fact.total_hours_per_week}",
        label: Actual Utilization %, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: actual_utilization, _type_hint: number},
      {category: table_calculation, expression: "(${contact_utilization_fact.total_actual_billable_hours}+offset(${contact_utilization_fact.total_actual_billable_hours},1)+offset(${contact_utilization_fact.total_actual_billable_hours},2)+offset(${contact_utilization_fact.total_actual_billable_hours},3))/(${contact_utilization_fact.total_total_capacity}+offset(${contact_utilization_fact.total_total_capacity},1)+offset(${contact_utilization_fact.total_total_capacity},2)+offset(${contact_utilization_fact.total_total_capacity},3))",
        label: 4 Week Avg. Actual Utilisation, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: 4_week_avg_actual_utilisation, _type_hint: number},
      {category: table_calculation, expression: "(${contact_utilization_fact.total_target_billable_capacity}+offset(${contact_utilization_fact.total_target_billable_capacity},1)+offset(${contact_utilization_fact.total_target_billable_capacity},2)+offset(${contact_utilization_fact.total_target_billable_capacity},3))/(${contact_utilization_fact.total_total_capacity}+offset(${contact_utilization_fact.total_total_capacity},1)+offset(${contact_utilization_fact.total_total_capacity},2)+offset(${contact_utilization_fact.total_total_capacity},3))",
        label: 4 Week Avg. Target Utilisation, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: 4_week_avg_target_utilisation, _type_hint: number},
      {category: table_calculation, expression: "(${contact_utilization_fact.total_forecast_billable_hours}+offset(${contact_utilization_fact.total_forecast_billable_hours},1)+offset(${contact_utilization_fact.total_forecast_billable_hours},2)+offset(${contact_utilization_fact.total_forecast_billable_hours},3))/(${contact_utilization_fact.total_total_capacity}+offset(${contact_utilization_fact.total_total_capacity},1)+offset(${contact_utilization_fact.total_total_capacity},2)+offset(${contact_utilization_fact.total_total_capacity},3))",
        label: 4 Week Avg. Forecast Utilization, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: 4_week_avg_forecast_utilization, _type_hint: number}]
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
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    hidden_series: [contact_utilization_fact.total_total_capacity, contact_utilization_fact.total_target_billable_capacity,
      contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours]
    series_types: {}
    series_colors:
      4_week_avg_target_utilisation: "#D13452"
      4_week_avg_forecast_utilization: "#e3e3e3"
    series_labels:
      contact_utilization_fact.total_total_capacity: Capacity Hours
      contact_utilization_fact.average_target: Target %
      contact_utilization_fact.total_time_off: Time-Off
      contact_utilization_fact.total_hours_per_week: Total Hours
      contact_utilization_fact.total_target_billable_capacity: Target Hours
      contact_utilization_fact.total_forecast_billable_hours: Forecast Hours
      contact_utilization_fact.total_actual_billable_hours: Actual Hours
      contact_utilization_fact.total_actual_story_points: Story Points
      contact_utilization_fact.average_forecast_utilization: Forecast Utilization
      contact_utilization_fact.actual_to_forecast_utilization_variance: Actual Utilization
      contact_utilization_fact.actual_to_target_utilization_variance: Variance %
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", contact_utilization_fact.forecast_week,
      staff_dim.contact_name, contact_utilization_fact.total_hours_per_week, contact_utilization_fact.total_time_off,
      contact_utilization_fact.average_target, contact_utilization_fact.total_total_capacity,
      contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_forecast_billable_hours,
      contact_utilization_fact.total_actual_billable_hours, contact_utilization_fact.total_actual_story_points,
      contact_utilization_fact.average_forecast_utilization, contact_utilization_fact.actual_to_forecast_utilization_variance,
      contact_utilization_fact.average_actual_utilization, contact_utilization_fact.actual_to_target_utilization_variance]
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    series_column_widths:
      grouped-column-contact_utilization_fact.forecast_week: 165
    series_cell_visualizations:
      contact_utilization_fact.average_time_off:
        is_active: false
      forecast_utilization:
        is_active: true
        palette:
          palette_id: c8e61ae5-b4ef-4fca-8f2f-92d1bd146bb1
          collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde
      actual_utilization:
        is_active: false
        palette:
          palette_id: c8e61ae5-b4ef-4fca-8f2f-92d1bd146bb1
          collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde
      contact_utilization_fact.total_hours_per_week:
        is_active: false
        value_display: false
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hide_totals: false
    hide_row_totals: false
    hidden_fields: [contact_utilization_fact.average_actual_utilization, contact_utilization_fact.total_actual_story_points,
      contact_utilization_fact.total_hours_per_week, contact_utilization_fact.total_time_off,
      contact_utilization_fact.average_target, contact_utilization_fact.average_forecast_utilization,
      contact_utilization_fact.actual_to_forecast_utilization_variance, contact_utilization_fact.actual_to_target_utilization_variance,
      actual_utilization, target_utilization, contact_utilization_fact.total_total_capacity,
      contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_forecast_billable_hours,
      contact_utilization_fact.total_actual_billable_hours]
    hidden_points_if_no: []
    theme: traditional
    customTheme: ''
    layout: fixed
    minWidthForIndexColumns: true
    headerFontSize: 12
    bodyFontSize: 12
    showTooltip: true
    showHighlight: false
    columnOrder: {}
    rowSubtotals: true
    colSubtotals: false
    spanRows: true
    spanCols: true
    calculateOthers: false
    sortColumnsBy: pivots
    useViewName: false
    useHeadings: false
    useShortName: false
    useUnit: false
    groupVarianceColumns: false
    genericLabelForSubtotals: false
    indexColumn: false
    transposeTable: false
    label|contact_utilization_fact.forecast_week: Week
    heading|contact_utilization_fact.forecast_week: ''
    hide|contact_utilization_fact.forecast_week: false
    label|staff_dim.contact_name: Name
    heading|staff_dim.contact_name: ''
    hide|staff_dim.contact_name: false
    subtotalDepth: '1'
    label|contact_utilization_fact.total_time_off: Time Off
    heading|contact_utilization_fact.total_time_off: ''
    style|contact_utilization_fact.total_time_off: normal
    reportIn|contact_utilization_fact.total_time_off: '1'
    unit|contact_utilization_fact.total_time_off: Hours
    comparison|contact_utilization_fact.total_time_off: no_variance
    switch|contact_utilization_fact.total_time_off: false
    var_num|contact_utilization_fact.total_time_off: false
    var_pct|contact_utilization_fact.total_time_off: false
    label|contact_utilization_fact.average_target: Target
    heading|contact_utilization_fact.average_target: ''
    style|contact_utilization_fact.average_target: normal
    reportIn|contact_utilization_fact.average_target: '1'
    unit|contact_utilization_fact.average_target: ''
    comparison|contact_utilization_fact.average_target: no_variance
    switch|contact_utilization_fact.average_target: false
    var_num|contact_utilization_fact.average_target: true
    var_pct|contact_utilization_fact.average_target: false
    label|contact_utilization_fact.total_hours_per_week: Hours Per Week
    label|contact_utilization_fact.total_total_capacity: Total Capacity
    label|contact_utilization_fact.total_target_billable_capacity: Target Capacity
    label|contact_utilization_fact.total_forecast_billable_hours: Forecast Hours
    label|contact_utilization_fact.total_actual_billable_hours: Actual Hours
    label|contact_utilization_fact.total_actual_story_points: Story Points
    heading|contact_utilization_fact.total_actual_story_points: Story Points Delivered
    label|contact_utilization_fact.average_forecast_utilization: Forecast Utilization
    heading|contact_utilization_fact.average_forecast_utilization: Forecast Utilization
    switch|contact_utilization_fact.average_forecast_utilization: false
    label|contact_utilization_fact.average_actual_utilization: Actual Utilization
    label|contact_utilization_fact.actual_to_forecast_utilization_variance: Variance
    label|contact_utilization_fact.actual_to_target_utilization_variance: Variance
    label|actual_utilization: Actual Utilization
    heading|actual_utilization: ''
    style|actual_utilization: normal
    reportIn|actual_utilization: '1'
    unit|actual_utilization: ''
    comparison|actual_utilization: contact_utilization_fact.average_target
    switch|actual_utilization: false
    var_num|actual_utilization: true
    var_pct|actual_utilization: false
    label|actual_utilization_to_forecast_variance: Actual Utilization to Forecast
      Variance
    heading|actual_utilization_to_forecast_variance: ''
    style|actual_utilization_to_forecast_variance: normal
    reportIn|actual_utilization_to_forecast_variance: '1'
    unit|actual_utilization_to_forecast_variance: ''
    comparison|actual_utilization_to_forecast_variance: contact_utilization_fact.average_target
    switch|actual_utilization_to_forecast_variance: false
    var_num|actual_utilization_to_forecast_variance: true
    var_pct|actual_utilization_to_forecast_variance: true
    label|actual_utilization_to_target_variance: Actual Utilization to Target Variance
    heading|actual_utilization_to_target_variance: ''
    style|actual_utilization_to_target_variance: normal
    reportIn|actual_utilization_to_target_variance: '1'
    unit|actual_utilization_to_target_variance: ''
    comparison|actual_utilization_to_target_variance: contact_utilization_fact.average_target
    switch|actual_utilization_to_target_variance: false
    var_num|actual_utilization_to_target_variance: true
    var_pct|actual_utilization_to_target_variance: false
    label|contact_utilization_fact.average_hours_per_week: "             Hours Per\
      \ Week"
    heading|contact_utilization_fact.average_hours_per_week: ''
    style|contact_utilization_fact.average_hours_per_week: normal
    reportIn|contact_utilization_fact.average_hours_per_week: '1'
    unit|contact_utilization_fact.average_hours_per_week: ''
    comparison|contact_utilization_fact.average_hours_per_week: no_variance
    switch|contact_utilization_fact.average_hours_per_week: false
    var_num|contact_utilization_fact.average_hours_per_week: true
    var_pct|contact_utilization_fact.average_hours_per_week: false
    label|contact_utilization_fact.average_total_capacity: "           Total Capacity"
    heading|contact_utilization_fact.average_total_capacity: ''
    style|contact_utilization_fact.average_total_capacity: normal
    reportIn|contact_utilization_fact.average_total_capacity: '1'
    unit|contact_utilization_fact.average_total_capacity: ''
    comparison|contact_utilization_fact.average_total_capacity: no_variance
    switch|contact_utilization_fact.average_total_capacity: false
    var_num|contact_utilization_fact.average_total_capacity: true
    var_pct|contact_utilization_fact.average_total_capacity: false
    label|contact_utilization_fact.average_target_billable_capacity: "         Target\
      \ Billable Capacity"
    heading|contact_utilization_fact.average_target_billable_capacity: ''
    style|contact_utilization_fact.average_target_billable_capacity: normal
    reportIn|contact_utilization_fact.average_target_billable_capacity: '1'
    unit|contact_utilization_fact.average_target_billable_capacity: ''
    comparison|contact_utilization_fact.average_target_billable_capacity: no_variance
    switch|contact_utilization_fact.average_target_billable_capacity: false
    var_num|contact_utilization_fact.average_target_billable_capacity: true
    var_pct|contact_utilization_fact.average_target_billable_capacity: false
    label|contact_utilization_fact.average_forecast_billable_hours: "       Forecast\
      \ Billable Hours"
    heading|contact_utilization_fact.average_forecast_billable_hours: ''
    style|contact_utilization_fact.average_forecast_billable_hours: normal
    reportIn|contact_utilization_fact.average_forecast_billable_hours: '1'
    unit|contact_utilization_fact.average_forecast_billable_hours: ''
    comparison|contact_utilization_fact.average_forecast_billable_hours: no_variance
    switch|contact_utilization_fact.average_forecast_billable_hours: false
    var_num|contact_utilization_fact.average_forecast_billable_hours: true
    var_pct|contact_utilization_fact.average_forecast_billable_hours: false
    label|contact_utilization_fact.average_actual_billable_hours: "    Actual Billable\
      \ Hours"
    heading|contact_utilization_fact.average_actual_billable_hours: ''
    style|contact_utilization_fact.average_actual_billable_hours: normal
    reportIn|contact_utilization_fact.average_actual_billable_hours: '1'
    unit|contact_utilization_fact.average_actual_billable_hours: ''
    comparison|contact_utilization_fact.average_actual_billable_hours: no_variance
    switch|contact_utilization_fact.average_actual_billable_hours: false
    var_num|contact_utilization_fact.average_actual_billable_hours: true
    var_pct|contact_utilization_fact.average_actual_billable_hours: false
    label|contact_utilization_fact.average_actual_story_points: Actual Story Points
    heading|contact_utilization_fact.average_actual_story_points: ''
    style|contact_utilization_fact.average_actual_story_points: normal
    reportIn|contact_utilization_fact.average_actual_story_points: '1'
    unit|contact_utilization_fact.average_actual_story_points: ''
    comparison|contact_utilization_fact.average_actual_story_points: no_variance
    switch|contact_utilization_fact.average_actual_story_points: false
    var_num|contact_utilization_fact.average_actual_story_points: true
    var_pct|contact_utilization_fact.average_actual_story_points: false
    label|forecast_utilization: Forecast Utilization
    heading|forecast_utilization: ''
    style|forecast_utilization: normal
    reportIn|forecast_utilization: '1'
    unit|forecast_utilization: ''
    comparison|forecast_utilization: no_variance
    switch|forecast_utilization: false
    var_num|forecast_utilization: true
    var_pct|forecast_utilization: false
    label|contact_utilization_fact.average_time_off: "                  Time-Off"
    heading|contact_utilization_fact.average_time_off: ''
    style|contact_utilization_fact.average_time_off: normal
    reportIn|contact_utilization_fact.average_time_off: '1'
    unit|contact_utilization_fact.average_time_off: ''
    comparison|contact_utilization_fact.average_time_off: no_variance
    switch|contact_utilization_fact.average_time_off: false
    var_num|contact_utilization_fact.average_time_off: true
    var_pct|contact_utilization_fact.average_time_off: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    truncate_column_names: false
    listen: {}
    row: 63
    col: 0
    width: 8
    height: 8
  - title: Capacity
    name: Capacity
    model: analytics
    explore: contact_utilization_fact
    type: looker_line
    fields: [contact_utilization_fact.forecast_week, contact_utilization_fact.total_hours_per_week,
      contact_utilization_fact.total_time_off, contact_utilization_fact.average_target,
      contact_utilization_fact.total_total_capacity, contact_utilization_fact.total_target_billable_capacity,
      contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours,
      contact_utilization_fact.total_actual_story_points, contact_utilization_fact.average_forecast_utilization,
      contact_utilization_fact.actual_to_forecast_utilization_variance, contact_utilization_fact.average_actual_utilization,
      contact_utilization_fact.actual_to_target_utilization_variance]
    fill_fields: [contact_utilization_fact.forecast_week]
    filters:
      staff_dim.contact_is_contractor: 'No'
      staff_dim.contact_name: "-Toby Sexton,-Benjamin Zarif"
      contact_utilization_fact.forecast_week: 52 weeks ago for 52 weeks
    sorts: [contact_utilization_fact.forecast_week desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${contact_utilization_fact.total_target_billable_capacity}/${contact_utilization_fact.total_hours_per_week}",
        label: Target Utilization %, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: target_utilization, _type_hint: number},
      {category: table_calculation, expression: "${contact_utilization_fact.total_actual_billable_hours}/${contact_utilization_fact.total_hours_per_week}",
        label: Actual Utilization %, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: actual_utilization, _type_hint: number},
      {category: table_calculation, expression: "(${contact_utilization_fact.total_actual_billable_hours}+offset(${contact_utilization_fact.total_actual_billable_hours},1)+offset(${contact_utilization_fact.total_actual_billable_hours},2)+offset(${contact_utilization_fact.total_actual_billable_hours},3))/(${contact_utilization_fact.total_total_capacity}+offset(${contact_utilization_fact.total_total_capacity},1)+offset(${contact_utilization_fact.total_total_capacity},2)+offset(${contact_utilization_fact.total_total_capacity},3))",
        label: 4 Week Avg. Actual Utilisation, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: 4_week_avg_actual_utilisation, _type_hint: number},
      {category: table_calculation, expression: "(${contact_utilization_fact.total_target_billable_capacity}+offset(${contact_utilization_fact.total_target_billable_capacity},1)+offset(${contact_utilization_fact.total_target_billable_capacity},2)+offset(${contact_utilization_fact.total_target_billable_capacity},3))/(${contact_utilization_fact.total_total_capacity}+offset(${contact_utilization_fact.total_total_capacity},1)+offset(${contact_utilization_fact.total_total_capacity},2)+offset(${contact_utilization_fact.total_total_capacity},3))",
        label: 4 Week Avg. Target Utilisation, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: 4_week_avg_target_utilisation, _type_hint: number},
      {category: table_calculation, expression: "(${contact_utilization_fact.total_forecast_billable_hours}+offset(${contact_utilization_fact.total_forecast_billable_hours},1)+offset(${contact_utilization_fact.total_forecast_billable_hours},2)+offset(${contact_utilization_fact.total_forecast_billable_hours},3))/(${contact_utilization_fact.total_total_capacity}+offset(${contact_utilization_fact.total_total_capacity},1)+offset(${contact_utilization_fact.total_total_capacity},2)+offset(${contact_utilization_fact.total_total_capacity},3))",
        label: 4 Week Avg. Forecast Utilization, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: 4_week_avg_forecast_utilization, _type_hint: number},
      {category: table_calculation, expression: "(${contact_utilization_fact.total_actual_billable_hours}+offset(${contact_utilization_fact.total_actual_billable_hours},1)+offset(${contact_utilization_fact.total_actual_billable_hours},2)+offset(${contact_utilization_fact.total_actual_billable_hours},3))/4",
        label: 4 Week Avg. Actual Hours Billed, value_format: !!null '', value_format_name: decimal_0,
        _kind_hint: measure, table_calculation: 4_week_avg_actual_hours_billed, _type_hint: number},
      {category: table_calculation, expression: "(${contact_utilization_fact.total_forecast_billable_hours}+offset(${contact_utilization_fact.total_forecast_billable_hours},1)+offset(${contact_utilization_fact.total_forecast_billable_hours},2)+offset(${contact_utilization_fact.total_forecast_billable_hours},3))/4",
        label: 4 Week Avg. Forecast Hours Billed, value_format: !!null '', value_format_name: decimal_0,
        _kind_hint: measure, table_calculation: 4_week_avg_forecast_hours_billed,
        _type_hint: number}, {category: table_calculation, expression: "(${contact_utilization_fact.total_target_billable_capacity}+offset(${contact_utilization_fact.total_target_billable_capacity},1)+offset(${contact_utilization_fact.total_target_billable_capacity},2)+offset(${contact_utilization_fact.total_target_billable_capacity},3))/4",
        label: 4 Week Avg. Target Hours, value_format: !!null '', value_format_name: decimal_0,
        _kind_hint: measure, table_calculation: 4_week_avg_target_hours, _type_hint: number},
      {category: table_calculation, expression: "(${contact_utilization_fact.total_total_capacity}+offset(${contact_utilization_fact.total_total_capacity},1)+offset(${contact_utilization_fact.total_total_capacity},2)+offset(${contact_utilization_fact.total_total_capacity},3))/4",
        label: 4 Week Avg. Capacity, value_format: !!null '', value_format_name: decimal_0,
        _kind_hint: measure, table_calculation: 4_week_avg_capacity, _type_hint: number}]
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
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    hidden_series: [contact_utilization_fact.total_total_capacity, contact_utilization_fact.total_target_billable_capacity,
      contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours]
    series_types: {}
    series_colors:
      4_week_avg_target_utilisation: "#D13452"
      4_week_avg_forecast_utilization: "#e3e3e3"
      4_week_avg_forecast_hours_billed: "#dedede"
      4_week_avg_capacity: "#7bc739"
      4_week_avg_target_hours: "#D13452"
    series_labels:
      contact_utilization_fact.total_total_capacity: Capacity Hours
      contact_utilization_fact.average_target: Target %
      contact_utilization_fact.total_time_off: Time-Off
      contact_utilization_fact.total_hours_per_week: Total Hours
      contact_utilization_fact.total_target_billable_capacity: Target Hours
      contact_utilization_fact.total_forecast_billable_hours: Forecast Hours
      contact_utilization_fact.total_actual_billable_hours: Actual Hours
      contact_utilization_fact.total_actual_story_points: Story Points
      contact_utilization_fact.average_forecast_utilization: Forecast Utilization
      contact_utilization_fact.actual_to_forecast_utilization_variance: Actual Utilization
      contact_utilization_fact.actual_to_target_utilization_variance: Variance %
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", contact_utilization_fact.forecast_week,
      staff_dim.contact_name, contact_utilization_fact.total_hours_per_week, contact_utilization_fact.total_time_off,
      contact_utilization_fact.average_target, contact_utilization_fact.total_total_capacity,
      contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_forecast_billable_hours,
      contact_utilization_fact.total_actual_billable_hours, contact_utilization_fact.total_actual_story_points,
      contact_utilization_fact.average_forecast_utilization, contact_utilization_fact.actual_to_forecast_utilization_variance,
      contact_utilization_fact.average_actual_utilization, contact_utilization_fact.actual_to_target_utilization_variance]
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    series_column_widths:
      grouped-column-contact_utilization_fact.forecast_week: 165
    series_cell_visualizations:
      contact_utilization_fact.average_time_off:
        is_active: false
      forecast_utilization:
        is_active: true
        palette:
          palette_id: c8e61ae5-b4ef-4fca-8f2f-92d1bd146bb1
          collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde
      actual_utilization:
        is_active: false
        palette:
          palette_id: c8e61ae5-b4ef-4fca-8f2f-92d1bd146bb1
          collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde
      contact_utilization_fact.total_hours_per_week:
        is_active: false
        value_display: false
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hide_totals: false
    hide_row_totals: false
    hidden_fields: [contact_utilization_fact.average_actual_utilization, contact_utilization_fact.total_actual_story_points,
      contact_utilization_fact.total_hours_per_week, contact_utilization_fact.total_time_off,
      contact_utilization_fact.average_target, contact_utilization_fact.average_forecast_utilization,
      contact_utilization_fact.actual_to_forecast_utilization_variance, contact_utilization_fact.actual_to_target_utilization_variance,
      actual_utilization, target_utilization, contact_utilization_fact.total_target_billable_capacity,
      contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours,
      4_week_avg_forecast_utilization, 4_week_avg_target_utilisation, 4_week_avg_actual_utilisation,
      contact_utilization_fact.total_total_capacity]
    hidden_points_if_no: []
    theme: traditional
    customTheme: ''
    layout: fixed
    minWidthForIndexColumns: true
    headerFontSize: 12
    bodyFontSize: 12
    showTooltip: true
    showHighlight: false
    columnOrder: {}
    rowSubtotals: true
    colSubtotals: false
    spanRows: true
    spanCols: true
    calculateOthers: false
    sortColumnsBy: pivots
    useViewName: false
    useHeadings: false
    useShortName: false
    useUnit: false
    groupVarianceColumns: false
    genericLabelForSubtotals: false
    indexColumn: false
    transposeTable: false
    label|contact_utilization_fact.forecast_week: Week
    heading|contact_utilization_fact.forecast_week: ''
    hide|contact_utilization_fact.forecast_week: false
    label|staff_dim.contact_name: Name
    heading|staff_dim.contact_name: ''
    hide|staff_dim.contact_name: false
    subtotalDepth: '1'
    label|contact_utilization_fact.total_time_off: Time Off
    heading|contact_utilization_fact.total_time_off: ''
    style|contact_utilization_fact.total_time_off: normal
    reportIn|contact_utilization_fact.total_time_off: '1'
    unit|contact_utilization_fact.total_time_off: Hours
    comparison|contact_utilization_fact.total_time_off: no_variance
    switch|contact_utilization_fact.total_time_off: false
    var_num|contact_utilization_fact.total_time_off: false
    var_pct|contact_utilization_fact.total_time_off: false
    label|contact_utilization_fact.average_target: Target
    heading|contact_utilization_fact.average_target: ''
    style|contact_utilization_fact.average_target: normal
    reportIn|contact_utilization_fact.average_target: '1'
    unit|contact_utilization_fact.average_target: ''
    comparison|contact_utilization_fact.average_target: no_variance
    switch|contact_utilization_fact.average_target: false
    var_num|contact_utilization_fact.average_target: true
    var_pct|contact_utilization_fact.average_target: false
    label|contact_utilization_fact.total_hours_per_week: Hours Per Week
    label|contact_utilization_fact.total_total_capacity: Total Capacity
    label|contact_utilization_fact.total_target_billable_capacity: Target Capacity
    label|contact_utilization_fact.total_forecast_billable_hours: Forecast Hours
    label|contact_utilization_fact.total_actual_billable_hours: Actual Hours
    label|contact_utilization_fact.total_actual_story_points: Story Points
    heading|contact_utilization_fact.total_actual_story_points: Story Points Delivered
    label|contact_utilization_fact.average_forecast_utilization: Forecast Utilization
    heading|contact_utilization_fact.average_forecast_utilization: Forecast Utilization
    switch|contact_utilization_fact.average_forecast_utilization: false
    label|contact_utilization_fact.average_actual_utilization: Actual Utilization
    label|contact_utilization_fact.actual_to_forecast_utilization_variance: Variance
    label|contact_utilization_fact.actual_to_target_utilization_variance: Variance
    label|actual_utilization: Actual Utilization
    heading|actual_utilization: ''
    style|actual_utilization: normal
    reportIn|actual_utilization: '1'
    unit|actual_utilization: ''
    comparison|actual_utilization: contact_utilization_fact.average_target
    switch|actual_utilization: false
    var_num|actual_utilization: true
    var_pct|actual_utilization: false
    label|actual_utilization_to_forecast_variance: Actual Utilization to Forecast
      Variance
    heading|actual_utilization_to_forecast_variance: ''
    style|actual_utilization_to_forecast_variance: normal
    reportIn|actual_utilization_to_forecast_variance: '1'
    unit|actual_utilization_to_forecast_variance: ''
    comparison|actual_utilization_to_forecast_variance: contact_utilization_fact.average_target
    switch|actual_utilization_to_forecast_variance: false
    var_num|actual_utilization_to_forecast_variance: true
    var_pct|actual_utilization_to_forecast_variance: true
    label|actual_utilization_to_target_variance: Actual Utilization to Target Variance
    heading|actual_utilization_to_target_variance: ''
    style|actual_utilization_to_target_variance: normal
    reportIn|actual_utilization_to_target_variance: '1'
    unit|actual_utilization_to_target_variance: ''
    comparison|actual_utilization_to_target_variance: contact_utilization_fact.average_target
    switch|actual_utilization_to_target_variance: false
    var_num|actual_utilization_to_target_variance: true
    var_pct|actual_utilization_to_target_variance: false
    label|contact_utilization_fact.average_hours_per_week: "             Hours Per\
      \ Week"
    heading|contact_utilization_fact.average_hours_per_week: ''
    style|contact_utilization_fact.average_hours_per_week: normal
    reportIn|contact_utilization_fact.average_hours_per_week: '1'
    unit|contact_utilization_fact.average_hours_per_week: ''
    comparison|contact_utilization_fact.average_hours_per_week: no_variance
    switch|contact_utilization_fact.average_hours_per_week: false
    var_num|contact_utilization_fact.average_hours_per_week: true
    var_pct|contact_utilization_fact.average_hours_per_week: false
    label|contact_utilization_fact.average_total_capacity: "           Total Capacity"
    heading|contact_utilization_fact.average_total_capacity: ''
    style|contact_utilization_fact.average_total_capacity: normal
    reportIn|contact_utilization_fact.average_total_capacity: '1'
    unit|contact_utilization_fact.average_total_capacity: ''
    comparison|contact_utilization_fact.average_total_capacity: no_variance
    switch|contact_utilization_fact.average_total_capacity: false
    var_num|contact_utilization_fact.average_total_capacity: true
    var_pct|contact_utilization_fact.average_total_capacity: false
    label|contact_utilization_fact.average_target_billable_capacity: "         Target\
      \ Billable Capacity"
    heading|contact_utilization_fact.average_target_billable_capacity: ''
    style|contact_utilization_fact.average_target_billable_capacity: normal
    reportIn|contact_utilization_fact.average_target_billable_capacity: '1'
    unit|contact_utilization_fact.average_target_billable_capacity: ''
    comparison|contact_utilization_fact.average_target_billable_capacity: no_variance
    switch|contact_utilization_fact.average_target_billable_capacity: false
    var_num|contact_utilization_fact.average_target_billable_capacity: true
    var_pct|contact_utilization_fact.average_target_billable_capacity: false
    label|contact_utilization_fact.average_forecast_billable_hours: "       Forecast\
      \ Billable Hours"
    heading|contact_utilization_fact.average_forecast_billable_hours: ''
    style|contact_utilization_fact.average_forecast_billable_hours: normal
    reportIn|contact_utilization_fact.average_forecast_billable_hours: '1'
    unit|contact_utilization_fact.average_forecast_billable_hours: ''
    comparison|contact_utilization_fact.average_forecast_billable_hours: no_variance
    switch|contact_utilization_fact.average_forecast_billable_hours: false
    var_num|contact_utilization_fact.average_forecast_billable_hours: true
    var_pct|contact_utilization_fact.average_forecast_billable_hours: false
    label|contact_utilization_fact.average_actual_billable_hours: "    Actual Billable\
      \ Hours"
    heading|contact_utilization_fact.average_actual_billable_hours: ''
    style|contact_utilization_fact.average_actual_billable_hours: normal
    reportIn|contact_utilization_fact.average_actual_billable_hours: '1'
    unit|contact_utilization_fact.average_actual_billable_hours: ''
    comparison|contact_utilization_fact.average_actual_billable_hours: no_variance
    switch|contact_utilization_fact.average_actual_billable_hours: false
    var_num|contact_utilization_fact.average_actual_billable_hours: true
    var_pct|contact_utilization_fact.average_actual_billable_hours: false
    label|contact_utilization_fact.average_actual_story_points: Actual Story Points
    heading|contact_utilization_fact.average_actual_story_points: ''
    style|contact_utilization_fact.average_actual_story_points: normal
    reportIn|contact_utilization_fact.average_actual_story_points: '1'
    unit|contact_utilization_fact.average_actual_story_points: ''
    comparison|contact_utilization_fact.average_actual_story_points: no_variance
    switch|contact_utilization_fact.average_actual_story_points: false
    var_num|contact_utilization_fact.average_actual_story_points: true
    var_pct|contact_utilization_fact.average_actual_story_points: false
    label|forecast_utilization: Forecast Utilization
    heading|forecast_utilization: ''
    style|forecast_utilization: normal
    reportIn|forecast_utilization: '1'
    unit|forecast_utilization: ''
    comparison|forecast_utilization: no_variance
    switch|forecast_utilization: false
    var_num|forecast_utilization: true
    var_pct|forecast_utilization: false
    label|contact_utilization_fact.average_time_off: "                  Time-Off"
    heading|contact_utilization_fact.average_time_off: ''
    style|contact_utilization_fact.average_time_off: normal
    reportIn|contact_utilization_fact.average_time_off: '1'
    unit|contact_utilization_fact.average_time_off: ''
    comparison|contact_utilization_fact.average_time_off: no_variance
    switch|contact_utilization_fact.average_time_off: false
    var_num|contact_utilization_fact.average_time_off: true
    var_pct|contact_utilization_fact.average_time_off: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    truncate_column_names: false
    listen: {}
    row: 63
    col: 16
    width: 8
    height: 8
  - title: Amir
    name: Amir
    model: analytics
    explore: contact_utilization_fact
    type: looker_line
    fields: [contact_utilization_fact.forecast_week, contact_utilization_fact.total_hours_per_week,
      contact_utilization_fact.total_time_off, contact_utilization_fact.average_target,
      contact_utilization_fact.total_total_capacity, contact_utilization_fact.total_target_billable_capacity,
      contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours,
      contact_utilization_fact.total_actual_story_points, contact_utilization_fact.average_forecast_utilization,
      contact_utilization_fact.actual_to_forecast_utilization_variance, contact_utilization_fact.average_actual_utilization,
      contact_utilization_fact.actual_to_target_utilization_variance]
    fill_fields: [contact_utilization_fact.forecast_week]
    filters:
      staff_dim.contact_is_contractor: 'No'
      staff_dim.contact_name: Amir Jaber
      contact_utilization_fact.forecast_week: 52 weeks ago for 52 weeks
    sorts: [contact_utilization_fact.forecast_week desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${contact_utilization_fact.total_target_billable_capacity}/${contact_utilization_fact.total_hours_per_week}",
        label: Target Utilization %, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: target_utilization, _type_hint: number},
      {category: table_calculation, expression: "${contact_utilization_fact.total_actual_billable_hours}/${contact_utilization_fact.total_hours_per_week}",
        label: Actual Utilization %, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: actual_utilization, _type_hint: number},
      {category: table_calculation, expression: "(${contact_utilization_fact.total_actual_billable_hours}+offset(${contact_utilization_fact.total_actual_billable_hours},1)+offset(${contact_utilization_fact.total_actual_billable_hours},2)+offset(${contact_utilization_fact.total_actual_billable_hours},3))/(${contact_utilization_fact.total_total_capacity}+offset(${contact_utilization_fact.total_total_capacity},1)+offset(${contact_utilization_fact.total_total_capacity},2)+offset(${contact_utilization_fact.total_total_capacity},3))",
        label: 4 Week Avg. Actual Utilisation, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: 4_week_avg_actual_utilisation, _type_hint: number},
      {category: table_calculation, expression: "(${contact_utilization_fact.total_target_billable_capacity}+offset(${contact_utilization_fact.total_target_billable_capacity},1)+offset(${contact_utilization_fact.total_target_billable_capacity},2)+offset(${contact_utilization_fact.total_target_billable_capacity},3))/(${contact_utilization_fact.total_total_capacity}+offset(${contact_utilization_fact.total_total_capacity},1)+offset(${contact_utilization_fact.total_total_capacity},2)+offset(${contact_utilization_fact.total_total_capacity},3))",
        label: 4 Week Avg. Target Utilisation, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: 4_week_avg_target_utilisation, _type_hint: number},
      {category: table_calculation, expression: "(${contact_utilization_fact.total_forecast_billable_hours}+offset(${contact_utilization_fact.total_forecast_billable_hours},1)+offset(${contact_utilization_fact.total_forecast_billable_hours},2)+offset(${contact_utilization_fact.total_forecast_billable_hours},3))/(${contact_utilization_fact.total_total_capacity}+offset(${contact_utilization_fact.total_total_capacity},1)+offset(${contact_utilization_fact.total_total_capacity},2)+offset(${contact_utilization_fact.total_total_capacity},3))",
        label: 4 Week Avg. Forecast Utilization, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: 4_week_avg_forecast_utilization, _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
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
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: 4_week_avg_actual_utilisation,
            id: 4_week_avg_actual_utilisation, name: 4 Week Avg. Actual Utilisation},
          {axisId: 4_week_avg_target_utilisation, id: 4_week_avg_target_utilisation,
            name: 4 Week Avg. Target Utilisation}, {axisId: 4_week_avg_forecast_utilization,
            id: 4_week_avg_forecast_utilization, name: 4 Week Avg. Forecast Utilization}],
        showLabels: true, showValues: true, maxValue: 1.2, unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 2, type: linear}]
    hidden_series: [contact_utilization_fact.total_total_capacity, contact_utilization_fact.total_target_billable_capacity,
      contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours]
    series_types: {}
    series_colors:
      4_week_avg_target_utilisation: "#D13452"
      4_week_avg_forecast_utilization: "#e3e3e3"
    series_labels:
      contact_utilization_fact.total_total_capacity: Capacity Hours
      contact_utilization_fact.average_target: Target %
      contact_utilization_fact.total_time_off: Time-Off
      contact_utilization_fact.total_hours_per_week: Total Hours
      contact_utilization_fact.total_target_billable_capacity: Target Hours
      contact_utilization_fact.total_forecast_billable_hours: Forecast Hours
      contact_utilization_fact.total_actual_billable_hours: Actual Hours
      contact_utilization_fact.total_actual_story_points: Story Points
      contact_utilization_fact.average_forecast_utilization: Forecast Utilization
      contact_utilization_fact.actual_to_forecast_utilization_variance: Actual Utilization
      contact_utilization_fact.actual_to_target_utilization_variance: Variance %
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", contact_utilization_fact.forecast_week,
      staff_dim.contact_name, contact_utilization_fact.total_hours_per_week, contact_utilization_fact.total_time_off,
      contact_utilization_fact.average_target, contact_utilization_fact.total_total_capacity,
      contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_forecast_billable_hours,
      contact_utilization_fact.total_actual_billable_hours, contact_utilization_fact.total_actual_story_points,
      contact_utilization_fact.average_forecast_utilization, contact_utilization_fact.actual_to_forecast_utilization_variance,
      contact_utilization_fact.average_actual_utilization, contact_utilization_fact.actual_to_target_utilization_variance]
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    series_column_widths:
      grouped-column-contact_utilization_fact.forecast_week: 165
    series_cell_visualizations:
      contact_utilization_fact.average_time_off:
        is_active: false
      forecast_utilization:
        is_active: true
        palette:
          palette_id: c8e61ae5-b4ef-4fca-8f2f-92d1bd146bb1
          collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde
      actual_utilization:
        is_active: false
        palette:
          palette_id: c8e61ae5-b4ef-4fca-8f2f-92d1bd146bb1
          collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde
      contact_utilization_fact.total_hours_per_week:
        is_active: false
        value_display: false
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hide_totals: false
    hide_row_totals: false
    hidden_fields: [contact_utilization_fact.average_actual_utilization, contact_utilization_fact.total_actual_story_points,
      contact_utilization_fact.total_hours_per_week, contact_utilization_fact.total_time_off,
      contact_utilization_fact.average_target, contact_utilization_fact.average_forecast_utilization,
      contact_utilization_fact.actual_to_forecast_utilization_variance, contact_utilization_fact.actual_to_target_utilization_variance,
      actual_utilization, target_utilization, contact_utilization_fact.total_total_capacity,
      contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_forecast_billable_hours,
      contact_utilization_fact.total_actual_billable_hours]
    hidden_points_if_no: []
    theme: traditional
    customTheme: ''
    layout: fixed
    minWidthForIndexColumns: true
    headerFontSize: 12
    bodyFontSize: 12
    showTooltip: true
    showHighlight: false
    columnOrder: {}
    rowSubtotals: true
    colSubtotals: false
    spanRows: true
    spanCols: true
    calculateOthers: false
    sortColumnsBy: pivots
    useViewName: false
    useHeadings: false
    useShortName: false
    useUnit: false
    groupVarianceColumns: false
    genericLabelForSubtotals: false
    indexColumn: false
    transposeTable: false
    label|contact_utilization_fact.forecast_week: Week
    heading|contact_utilization_fact.forecast_week: ''
    hide|contact_utilization_fact.forecast_week: false
    label|staff_dim.contact_name: Name
    heading|staff_dim.contact_name: ''
    hide|staff_dim.contact_name: false
    subtotalDepth: '1'
    label|contact_utilization_fact.total_time_off: Time Off
    heading|contact_utilization_fact.total_time_off: ''
    style|contact_utilization_fact.total_time_off: normal
    reportIn|contact_utilization_fact.total_time_off: '1'
    unit|contact_utilization_fact.total_time_off: Hours
    comparison|contact_utilization_fact.total_time_off: no_variance
    switch|contact_utilization_fact.total_time_off: false
    var_num|contact_utilization_fact.total_time_off: false
    var_pct|contact_utilization_fact.total_time_off: false
    label|contact_utilization_fact.average_target: Target
    heading|contact_utilization_fact.average_target: ''
    style|contact_utilization_fact.average_target: normal
    reportIn|contact_utilization_fact.average_target: '1'
    unit|contact_utilization_fact.average_target: ''
    comparison|contact_utilization_fact.average_target: no_variance
    switch|contact_utilization_fact.average_target: false
    var_num|contact_utilization_fact.average_target: true
    var_pct|contact_utilization_fact.average_target: false
    label|contact_utilization_fact.total_hours_per_week: Hours Per Week
    label|contact_utilization_fact.total_total_capacity: Total Capacity
    label|contact_utilization_fact.total_target_billable_capacity: Target Capacity
    label|contact_utilization_fact.total_forecast_billable_hours: Forecast Hours
    label|contact_utilization_fact.total_actual_billable_hours: Actual Hours
    label|contact_utilization_fact.total_actual_story_points: Story Points
    heading|contact_utilization_fact.total_actual_story_points: Story Points Delivered
    label|contact_utilization_fact.average_forecast_utilization: Forecast Utilization
    heading|contact_utilization_fact.average_forecast_utilization: Forecast Utilization
    switch|contact_utilization_fact.average_forecast_utilization: false
    label|contact_utilization_fact.average_actual_utilization: Actual Utilization
    label|contact_utilization_fact.actual_to_forecast_utilization_variance: Variance
    label|contact_utilization_fact.actual_to_target_utilization_variance: Variance
    label|actual_utilization: Actual Utilization
    heading|actual_utilization: ''
    style|actual_utilization: normal
    reportIn|actual_utilization: '1'
    unit|actual_utilization: ''
    comparison|actual_utilization: contact_utilization_fact.average_target
    switch|actual_utilization: false
    var_num|actual_utilization: true
    var_pct|actual_utilization: false
    label|actual_utilization_to_forecast_variance: Actual Utilization to Forecast
      Variance
    heading|actual_utilization_to_forecast_variance: ''
    style|actual_utilization_to_forecast_variance: normal
    reportIn|actual_utilization_to_forecast_variance: '1'
    unit|actual_utilization_to_forecast_variance: ''
    comparison|actual_utilization_to_forecast_variance: contact_utilization_fact.average_target
    switch|actual_utilization_to_forecast_variance: false
    var_num|actual_utilization_to_forecast_variance: true
    var_pct|actual_utilization_to_forecast_variance: true
    label|actual_utilization_to_target_variance: Actual Utilization to Target Variance
    heading|actual_utilization_to_target_variance: ''
    style|actual_utilization_to_target_variance: normal
    reportIn|actual_utilization_to_target_variance: '1'
    unit|actual_utilization_to_target_variance: ''
    comparison|actual_utilization_to_target_variance: contact_utilization_fact.average_target
    switch|actual_utilization_to_target_variance: false
    var_num|actual_utilization_to_target_variance: true
    var_pct|actual_utilization_to_target_variance: false
    label|contact_utilization_fact.average_hours_per_week: "             Hours Per\
      \ Week"
    heading|contact_utilization_fact.average_hours_per_week: ''
    style|contact_utilization_fact.average_hours_per_week: normal
    reportIn|contact_utilization_fact.average_hours_per_week: '1'
    unit|contact_utilization_fact.average_hours_per_week: ''
    comparison|contact_utilization_fact.average_hours_per_week: no_variance
    switch|contact_utilization_fact.average_hours_per_week: false
    var_num|contact_utilization_fact.average_hours_per_week: true
    var_pct|contact_utilization_fact.average_hours_per_week: false
    label|contact_utilization_fact.average_total_capacity: "           Total Capacity"
    heading|contact_utilization_fact.average_total_capacity: ''
    style|contact_utilization_fact.average_total_capacity: normal
    reportIn|contact_utilization_fact.average_total_capacity: '1'
    unit|contact_utilization_fact.average_total_capacity: ''
    comparison|contact_utilization_fact.average_total_capacity: no_variance
    switch|contact_utilization_fact.average_total_capacity: false
    var_num|contact_utilization_fact.average_total_capacity: true
    var_pct|contact_utilization_fact.average_total_capacity: false
    label|contact_utilization_fact.average_target_billable_capacity: "         Target\
      \ Billable Capacity"
    heading|contact_utilization_fact.average_target_billable_capacity: ''
    style|contact_utilization_fact.average_target_billable_capacity: normal
    reportIn|contact_utilization_fact.average_target_billable_capacity: '1'
    unit|contact_utilization_fact.average_target_billable_capacity: ''
    comparison|contact_utilization_fact.average_target_billable_capacity: no_variance
    switch|contact_utilization_fact.average_target_billable_capacity: false
    var_num|contact_utilization_fact.average_target_billable_capacity: true
    var_pct|contact_utilization_fact.average_target_billable_capacity: false
    label|contact_utilization_fact.average_forecast_billable_hours: "       Forecast\
      \ Billable Hours"
    heading|contact_utilization_fact.average_forecast_billable_hours: ''
    style|contact_utilization_fact.average_forecast_billable_hours: normal
    reportIn|contact_utilization_fact.average_forecast_billable_hours: '1'
    unit|contact_utilization_fact.average_forecast_billable_hours: ''
    comparison|contact_utilization_fact.average_forecast_billable_hours: no_variance
    switch|contact_utilization_fact.average_forecast_billable_hours: false
    var_num|contact_utilization_fact.average_forecast_billable_hours: true
    var_pct|contact_utilization_fact.average_forecast_billable_hours: false
    label|contact_utilization_fact.average_actual_billable_hours: "    Actual Billable\
      \ Hours"
    heading|contact_utilization_fact.average_actual_billable_hours: ''
    style|contact_utilization_fact.average_actual_billable_hours: normal
    reportIn|contact_utilization_fact.average_actual_billable_hours: '1'
    unit|contact_utilization_fact.average_actual_billable_hours: ''
    comparison|contact_utilization_fact.average_actual_billable_hours: no_variance
    switch|contact_utilization_fact.average_actual_billable_hours: false
    var_num|contact_utilization_fact.average_actual_billable_hours: true
    var_pct|contact_utilization_fact.average_actual_billable_hours: false
    label|contact_utilization_fact.average_actual_story_points: Actual Story Points
    heading|contact_utilization_fact.average_actual_story_points: ''
    style|contact_utilization_fact.average_actual_story_points: normal
    reportIn|contact_utilization_fact.average_actual_story_points: '1'
    unit|contact_utilization_fact.average_actual_story_points: ''
    comparison|contact_utilization_fact.average_actual_story_points: no_variance
    switch|contact_utilization_fact.average_actual_story_points: false
    var_num|contact_utilization_fact.average_actual_story_points: true
    var_pct|contact_utilization_fact.average_actual_story_points: false
    label|forecast_utilization: Forecast Utilization
    heading|forecast_utilization: ''
    style|forecast_utilization: normal
    reportIn|forecast_utilization: '1'
    unit|forecast_utilization: ''
    comparison|forecast_utilization: no_variance
    switch|forecast_utilization: false
    var_num|forecast_utilization: true
    var_pct|forecast_utilization: false
    label|contact_utilization_fact.average_time_off: "                  Time-Off"
    heading|contact_utilization_fact.average_time_off: ''
    style|contact_utilization_fact.average_time_off: normal
    reportIn|contact_utilization_fact.average_time_off: '1'
    unit|contact_utilization_fact.average_time_off: ''
    comparison|contact_utilization_fact.average_time_off: no_variance
    switch|contact_utilization_fact.average_time_off: false
    var_num|contact_utilization_fact.average_time_off: true
    var_pct|contact_utilization_fact.average_time_off: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    truncate_column_names: false
    listen: {}
    row: 63
    col: 8
    width: 4
    height: 4
  - title: Jordan
    name: Jordan
    model: analytics
    explore: contact_utilization_fact
    type: looker_line
    fields: [contact_utilization_fact.forecast_week, contact_utilization_fact.total_hours_per_week,
      contact_utilization_fact.total_time_off, contact_utilization_fact.average_target,
      contact_utilization_fact.total_total_capacity, contact_utilization_fact.total_target_billable_capacity,
      contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours,
      contact_utilization_fact.total_actual_story_points, contact_utilization_fact.average_forecast_utilization,
      contact_utilization_fact.actual_to_forecast_utilization_variance, contact_utilization_fact.average_actual_utilization,
      contact_utilization_fact.actual_to_target_utilization_variance]
    fill_fields: [contact_utilization_fact.forecast_week]
    filters:
      staff_dim.contact_is_contractor: 'No'
      staff_dim.contact_name: Jordan Ilyat
      contact_utilization_fact.forecast_week: 52 weeks ago for 52 weeks
    sorts: [contact_utilization_fact.forecast_week desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${contact_utilization_fact.total_target_billable_capacity}/${contact_utilization_fact.total_hours_per_week}",
        label: Target Utilization %, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: target_utilization, _type_hint: number},
      {category: table_calculation, expression: "${contact_utilization_fact.total_actual_billable_hours}/${contact_utilization_fact.total_hours_per_week}",
        label: Actual Utilization %, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: actual_utilization, _type_hint: number},
      {category: table_calculation, expression: "(${contact_utilization_fact.total_actual_billable_hours}+offset(${contact_utilization_fact.total_actual_billable_hours},1)+offset(${contact_utilization_fact.total_actual_billable_hours},2)+offset(${contact_utilization_fact.total_actual_billable_hours},3))/(${contact_utilization_fact.total_total_capacity}+offset(${contact_utilization_fact.total_total_capacity},1)+offset(${contact_utilization_fact.total_total_capacity},2)+offset(${contact_utilization_fact.total_total_capacity},3))",
        label: 4 Week Avg. Actual Utilisation, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: 4_week_avg_actual_utilisation, _type_hint: number},
      {category: table_calculation, expression: "(${contact_utilization_fact.total_target_billable_capacity}+offset(${contact_utilization_fact.total_target_billable_capacity},1)+offset(${contact_utilization_fact.total_target_billable_capacity},2)+offset(${contact_utilization_fact.total_target_billable_capacity},3))/(${contact_utilization_fact.total_total_capacity}+offset(${contact_utilization_fact.total_total_capacity},1)+offset(${contact_utilization_fact.total_total_capacity},2)+offset(${contact_utilization_fact.total_total_capacity},3))",
        label: 4 Week Avg. Target Utilisation, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: 4_week_avg_target_utilisation, _type_hint: number},
      {category: table_calculation, expression: "(${contact_utilization_fact.total_forecast_billable_hours}+offset(${contact_utilization_fact.total_forecast_billable_hours},1)+offset(${contact_utilization_fact.total_forecast_billable_hours},2)+offset(${contact_utilization_fact.total_forecast_billable_hours},3))/(${contact_utilization_fact.total_total_capacity}+offset(${contact_utilization_fact.total_total_capacity},1)+offset(${contact_utilization_fact.total_total_capacity},2)+offset(${contact_utilization_fact.total_total_capacity},3))",
        label: 4 Week Avg. Forecast Utilization, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: 4_week_avg_forecast_utilization, _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
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
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: 4_week_avg_actual_utilisation,
            id: 4_week_avg_actual_utilisation, name: 4 Week Avg. Actual Utilisation},
          {axisId: 4_week_avg_target_utilisation, id: 4_week_avg_target_utilisation,
            name: 4 Week Avg. Target Utilisation}, {axisId: 4_week_avg_forecast_utilization,
            id: 4_week_avg_forecast_utilization, name: 4 Week Avg. Forecast Utilization}],
        showLabels: true, showValues: true, maxValue: 1.2, unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 2, type: linear}]
    hidden_series: [contact_utilization_fact.total_total_capacity, contact_utilization_fact.total_target_billable_capacity,
      contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours]
    series_types: {}
    series_colors:
      4_week_avg_target_utilisation: "#D13452"
      4_week_avg_forecast_utilization: "#e3e3e3"
    series_labels:
      contact_utilization_fact.total_total_capacity: Capacity Hours
      contact_utilization_fact.average_target: Target %
      contact_utilization_fact.total_time_off: Time-Off
      contact_utilization_fact.total_hours_per_week: Total Hours
      contact_utilization_fact.total_target_billable_capacity: Target Hours
      contact_utilization_fact.total_forecast_billable_hours: Forecast Hours
      contact_utilization_fact.total_actual_billable_hours: Actual Hours
      contact_utilization_fact.total_actual_story_points: Story Points
      contact_utilization_fact.average_forecast_utilization: Forecast Utilization
      contact_utilization_fact.actual_to_forecast_utilization_variance: Actual Utilization
      contact_utilization_fact.actual_to_target_utilization_variance: Variance %
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", contact_utilization_fact.forecast_week,
      staff_dim.contact_name, contact_utilization_fact.total_hours_per_week, contact_utilization_fact.total_time_off,
      contact_utilization_fact.average_target, contact_utilization_fact.total_total_capacity,
      contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_forecast_billable_hours,
      contact_utilization_fact.total_actual_billable_hours, contact_utilization_fact.total_actual_story_points,
      contact_utilization_fact.average_forecast_utilization, contact_utilization_fact.actual_to_forecast_utilization_variance,
      contact_utilization_fact.average_actual_utilization, contact_utilization_fact.actual_to_target_utilization_variance]
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    series_column_widths:
      grouped-column-contact_utilization_fact.forecast_week: 165
    series_cell_visualizations:
      contact_utilization_fact.average_time_off:
        is_active: false
      forecast_utilization:
        is_active: true
        palette:
          palette_id: c8e61ae5-b4ef-4fca-8f2f-92d1bd146bb1
          collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde
      actual_utilization:
        is_active: false
        palette:
          palette_id: c8e61ae5-b4ef-4fca-8f2f-92d1bd146bb1
          collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde
      contact_utilization_fact.total_hours_per_week:
        is_active: false
        value_display: false
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hide_totals: false
    hide_row_totals: false
    hidden_fields: [contact_utilization_fact.average_actual_utilization, contact_utilization_fact.total_actual_story_points,
      contact_utilization_fact.total_hours_per_week, contact_utilization_fact.total_time_off,
      contact_utilization_fact.average_target, contact_utilization_fact.average_forecast_utilization,
      contact_utilization_fact.actual_to_forecast_utilization_variance, contact_utilization_fact.actual_to_target_utilization_variance,
      actual_utilization, target_utilization, contact_utilization_fact.total_total_capacity,
      contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_forecast_billable_hours,
      contact_utilization_fact.total_actual_billable_hours]
    hidden_points_if_no: []
    theme: traditional
    customTheme: ''
    layout: fixed
    minWidthForIndexColumns: true
    headerFontSize: 12
    bodyFontSize: 12
    showTooltip: true
    showHighlight: false
    columnOrder: {}
    rowSubtotals: true
    colSubtotals: false
    spanRows: true
    spanCols: true
    calculateOthers: false
    sortColumnsBy: pivots
    useViewName: false
    useHeadings: false
    useShortName: false
    useUnit: false
    groupVarianceColumns: false
    genericLabelForSubtotals: false
    indexColumn: false
    transposeTable: false
    label|contact_utilization_fact.forecast_week: Week
    heading|contact_utilization_fact.forecast_week: ''
    hide|contact_utilization_fact.forecast_week: false
    label|staff_dim.contact_name: Name
    heading|staff_dim.contact_name: ''
    hide|staff_dim.contact_name: false
    subtotalDepth: '1'
    label|contact_utilization_fact.total_time_off: Time Off
    heading|contact_utilization_fact.total_time_off: ''
    style|contact_utilization_fact.total_time_off: normal
    reportIn|contact_utilization_fact.total_time_off: '1'
    unit|contact_utilization_fact.total_time_off: Hours
    comparison|contact_utilization_fact.total_time_off: no_variance
    switch|contact_utilization_fact.total_time_off: false
    var_num|contact_utilization_fact.total_time_off: false
    var_pct|contact_utilization_fact.total_time_off: false
    label|contact_utilization_fact.average_target: Target
    heading|contact_utilization_fact.average_target: ''
    style|contact_utilization_fact.average_target: normal
    reportIn|contact_utilization_fact.average_target: '1'
    unit|contact_utilization_fact.average_target: ''
    comparison|contact_utilization_fact.average_target: no_variance
    switch|contact_utilization_fact.average_target: false
    var_num|contact_utilization_fact.average_target: true
    var_pct|contact_utilization_fact.average_target: false
    label|contact_utilization_fact.total_hours_per_week: Hours Per Week
    label|contact_utilization_fact.total_total_capacity: Total Capacity
    label|contact_utilization_fact.total_target_billable_capacity: Target Capacity
    label|contact_utilization_fact.total_forecast_billable_hours: Forecast Hours
    label|contact_utilization_fact.total_actual_billable_hours: Actual Hours
    label|contact_utilization_fact.total_actual_story_points: Story Points
    heading|contact_utilization_fact.total_actual_story_points: Story Points Delivered
    label|contact_utilization_fact.average_forecast_utilization: Forecast Utilization
    heading|contact_utilization_fact.average_forecast_utilization: Forecast Utilization
    switch|contact_utilization_fact.average_forecast_utilization: false
    label|contact_utilization_fact.average_actual_utilization: Actual Utilization
    label|contact_utilization_fact.actual_to_forecast_utilization_variance: Variance
    label|contact_utilization_fact.actual_to_target_utilization_variance: Variance
    label|actual_utilization: Actual Utilization
    heading|actual_utilization: ''
    style|actual_utilization: normal
    reportIn|actual_utilization: '1'
    unit|actual_utilization: ''
    comparison|actual_utilization: contact_utilization_fact.average_target
    switch|actual_utilization: false
    var_num|actual_utilization: true
    var_pct|actual_utilization: false
    label|actual_utilization_to_forecast_variance: Actual Utilization to Forecast
      Variance
    heading|actual_utilization_to_forecast_variance: ''
    style|actual_utilization_to_forecast_variance: normal
    reportIn|actual_utilization_to_forecast_variance: '1'
    unit|actual_utilization_to_forecast_variance: ''
    comparison|actual_utilization_to_forecast_variance: contact_utilization_fact.average_target
    switch|actual_utilization_to_forecast_variance: false
    var_num|actual_utilization_to_forecast_variance: true
    var_pct|actual_utilization_to_forecast_variance: true
    label|actual_utilization_to_target_variance: Actual Utilization to Target Variance
    heading|actual_utilization_to_target_variance: ''
    style|actual_utilization_to_target_variance: normal
    reportIn|actual_utilization_to_target_variance: '1'
    unit|actual_utilization_to_target_variance: ''
    comparison|actual_utilization_to_target_variance: contact_utilization_fact.average_target
    switch|actual_utilization_to_target_variance: false
    var_num|actual_utilization_to_target_variance: true
    var_pct|actual_utilization_to_target_variance: false
    label|contact_utilization_fact.average_hours_per_week: "             Hours Per\
      \ Week"
    heading|contact_utilization_fact.average_hours_per_week: ''
    style|contact_utilization_fact.average_hours_per_week: normal
    reportIn|contact_utilization_fact.average_hours_per_week: '1'
    unit|contact_utilization_fact.average_hours_per_week: ''
    comparison|contact_utilization_fact.average_hours_per_week: no_variance
    switch|contact_utilization_fact.average_hours_per_week: false
    var_num|contact_utilization_fact.average_hours_per_week: true
    var_pct|contact_utilization_fact.average_hours_per_week: false
    label|contact_utilization_fact.average_total_capacity: "           Total Capacity"
    heading|contact_utilization_fact.average_total_capacity: ''
    style|contact_utilization_fact.average_total_capacity: normal
    reportIn|contact_utilization_fact.average_total_capacity: '1'
    unit|contact_utilization_fact.average_total_capacity: ''
    comparison|contact_utilization_fact.average_total_capacity: no_variance
    switch|contact_utilization_fact.average_total_capacity: false
    var_num|contact_utilization_fact.average_total_capacity: true
    var_pct|contact_utilization_fact.average_total_capacity: false
    label|contact_utilization_fact.average_target_billable_capacity: "         Target\
      \ Billable Capacity"
    heading|contact_utilization_fact.average_target_billable_capacity: ''
    style|contact_utilization_fact.average_target_billable_capacity: normal
    reportIn|contact_utilization_fact.average_target_billable_capacity: '1'
    unit|contact_utilization_fact.average_target_billable_capacity: ''
    comparison|contact_utilization_fact.average_target_billable_capacity: no_variance
    switch|contact_utilization_fact.average_target_billable_capacity: false
    var_num|contact_utilization_fact.average_target_billable_capacity: true
    var_pct|contact_utilization_fact.average_target_billable_capacity: false
    label|contact_utilization_fact.average_forecast_billable_hours: "       Forecast\
      \ Billable Hours"
    heading|contact_utilization_fact.average_forecast_billable_hours: ''
    style|contact_utilization_fact.average_forecast_billable_hours: normal
    reportIn|contact_utilization_fact.average_forecast_billable_hours: '1'
    unit|contact_utilization_fact.average_forecast_billable_hours: ''
    comparison|contact_utilization_fact.average_forecast_billable_hours: no_variance
    switch|contact_utilization_fact.average_forecast_billable_hours: false
    var_num|contact_utilization_fact.average_forecast_billable_hours: true
    var_pct|contact_utilization_fact.average_forecast_billable_hours: false
    label|contact_utilization_fact.average_actual_billable_hours: "    Actual Billable\
      \ Hours"
    heading|contact_utilization_fact.average_actual_billable_hours: ''
    style|contact_utilization_fact.average_actual_billable_hours: normal
    reportIn|contact_utilization_fact.average_actual_billable_hours: '1'
    unit|contact_utilization_fact.average_actual_billable_hours: ''
    comparison|contact_utilization_fact.average_actual_billable_hours: no_variance
    switch|contact_utilization_fact.average_actual_billable_hours: false
    var_num|contact_utilization_fact.average_actual_billable_hours: true
    var_pct|contact_utilization_fact.average_actual_billable_hours: false
    label|contact_utilization_fact.average_actual_story_points: Actual Story Points
    heading|contact_utilization_fact.average_actual_story_points: ''
    style|contact_utilization_fact.average_actual_story_points: normal
    reportIn|contact_utilization_fact.average_actual_story_points: '1'
    unit|contact_utilization_fact.average_actual_story_points: ''
    comparison|contact_utilization_fact.average_actual_story_points: no_variance
    switch|contact_utilization_fact.average_actual_story_points: false
    var_num|contact_utilization_fact.average_actual_story_points: true
    var_pct|contact_utilization_fact.average_actual_story_points: false
    label|forecast_utilization: Forecast Utilization
    heading|forecast_utilization: ''
    style|forecast_utilization: normal
    reportIn|forecast_utilization: '1'
    unit|forecast_utilization: ''
    comparison|forecast_utilization: no_variance
    switch|forecast_utilization: false
    var_num|forecast_utilization: true
    var_pct|forecast_utilization: false
    label|contact_utilization_fact.average_time_off: "                  Time-Off"
    heading|contact_utilization_fact.average_time_off: ''
    style|contact_utilization_fact.average_time_off: normal
    reportIn|contact_utilization_fact.average_time_off: '1'
    unit|contact_utilization_fact.average_time_off: ''
    comparison|contact_utilization_fact.average_time_off: no_variance
    switch|contact_utilization_fact.average_time_off: false
    var_num|contact_utilization_fact.average_time_off: true
    var_pct|contact_utilization_fact.average_time_off: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    truncate_column_names: false
    listen: {}
    row: 63
    col: 12
    width: 4
    height: 4
  - title: Mark
    name: Mark
    model: analytics
    explore: contact_utilization_fact
    type: looker_line
    fields: [contact_utilization_fact.forecast_week, contact_utilization_fact.total_hours_per_week,
      contact_utilization_fact.total_time_off, contact_utilization_fact.average_target,
      contact_utilization_fact.total_total_capacity, contact_utilization_fact.total_target_billable_capacity,
      contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours,
      contact_utilization_fact.total_actual_story_points, contact_utilization_fact.average_forecast_utilization,
      contact_utilization_fact.actual_to_forecast_utilization_variance, contact_utilization_fact.average_actual_utilization,
      contact_utilization_fact.actual_to_target_utilization_variance]
    fill_fields: [contact_utilization_fact.forecast_week]
    filters:
      staff_dim.contact_is_contractor: 'No'
      staff_dim.contact_name: Mark Rittman
      contact_utilization_fact.forecast_week: 52 weeks ago for 52 weeks
    sorts: [contact_utilization_fact.forecast_week desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${contact_utilization_fact.total_target_billable_capacity}/${contact_utilization_fact.total_hours_per_week}",
        label: Target Utilization %, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: target_utilization, _type_hint: number},
      {category: table_calculation, expression: "${contact_utilization_fact.total_actual_billable_hours}/${contact_utilization_fact.total_hours_per_week}",
        label: Actual Utilization %, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: actual_utilization, _type_hint: number},
      {category: table_calculation, expression: "(${contact_utilization_fact.total_actual_billable_hours}+offset(${contact_utilization_fact.total_actual_billable_hours},1)+offset(${contact_utilization_fact.total_actual_billable_hours},2)+offset(${contact_utilization_fact.total_actual_billable_hours},3))/(${contact_utilization_fact.total_total_capacity}+offset(${contact_utilization_fact.total_total_capacity},1)+offset(${contact_utilization_fact.total_total_capacity},2)+offset(${contact_utilization_fact.total_total_capacity},3))",
        label: 4 Week Avg. Actual Utilisation, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: 4_week_avg_actual_utilisation, _type_hint: number},
      {category: table_calculation, expression: "(${contact_utilization_fact.total_target_billable_capacity}+offset(${contact_utilization_fact.total_target_billable_capacity},1)+offset(${contact_utilization_fact.total_target_billable_capacity},2)+offset(${contact_utilization_fact.total_target_billable_capacity},3))/(${contact_utilization_fact.total_total_capacity}+offset(${contact_utilization_fact.total_total_capacity},1)+offset(${contact_utilization_fact.total_total_capacity},2)+offset(${contact_utilization_fact.total_total_capacity},3))",
        label: 4 Week Avg. Target Utilisation, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: 4_week_avg_target_utilisation, _type_hint: number},
      {category: table_calculation, expression: "(${contact_utilization_fact.total_forecast_billable_hours}+offset(${contact_utilization_fact.total_forecast_billable_hours},1)+offset(${contact_utilization_fact.total_forecast_billable_hours},2)+offset(${contact_utilization_fact.total_forecast_billable_hours},3))/(${contact_utilization_fact.total_total_capacity}+offset(${contact_utilization_fact.total_total_capacity},1)+offset(${contact_utilization_fact.total_total_capacity},2)+offset(${contact_utilization_fact.total_total_capacity},3))",
        label: 4 Week Avg. Forecast Utilization, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: 4_week_avg_forecast_utilization, _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
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
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: 4_week_avg_actual_utilisation,
            id: 4_week_avg_actual_utilisation, name: 4 Week Avg. Actual Utilisation},
          {axisId: 4_week_avg_target_utilisation, id: 4_week_avg_target_utilisation,
            name: 4 Week Avg. Target Utilisation}, {axisId: 4_week_avg_forecast_utilization,
            id: 4_week_avg_forecast_utilization, name: 4 Week Avg. Forecast Utilization}],
        showLabels: true, showValues: true, maxValue: 1.2, unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 2, type: linear}]
    hidden_series: [contact_utilization_fact.total_total_capacity, contact_utilization_fact.total_target_billable_capacity,
      contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours]
    series_types: {}
    series_colors:
      4_week_avg_target_utilisation: "#D13452"
      4_week_avg_forecast_utilization: "#e3e3e3"
    series_labels:
      contact_utilization_fact.total_total_capacity: Capacity Hours
      contact_utilization_fact.average_target: Target %
      contact_utilization_fact.total_time_off: Time-Off
      contact_utilization_fact.total_hours_per_week: Total Hours
      contact_utilization_fact.total_target_billable_capacity: Target Hours
      contact_utilization_fact.total_forecast_billable_hours: Forecast Hours
      contact_utilization_fact.total_actual_billable_hours: Actual Hours
      contact_utilization_fact.total_actual_story_points: Story Points
      contact_utilization_fact.average_forecast_utilization: Forecast Utilization
      contact_utilization_fact.actual_to_forecast_utilization_variance: Actual Utilization
      contact_utilization_fact.actual_to_target_utilization_variance: Variance %
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", contact_utilization_fact.forecast_week,
      staff_dim.contact_name, contact_utilization_fact.total_hours_per_week, contact_utilization_fact.total_time_off,
      contact_utilization_fact.average_target, contact_utilization_fact.total_total_capacity,
      contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_forecast_billable_hours,
      contact_utilization_fact.total_actual_billable_hours, contact_utilization_fact.total_actual_story_points,
      contact_utilization_fact.average_forecast_utilization, contact_utilization_fact.actual_to_forecast_utilization_variance,
      contact_utilization_fact.average_actual_utilization, contact_utilization_fact.actual_to_target_utilization_variance]
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    series_column_widths:
      grouped-column-contact_utilization_fact.forecast_week: 165
    series_cell_visualizations:
      contact_utilization_fact.average_time_off:
        is_active: false
      forecast_utilization:
        is_active: true
        palette:
          palette_id: c8e61ae5-b4ef-4fca-8f2f-92d1bd146bb1
          collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde
      actual_utilization:
        is_active: false
        palette:
          palette_id: c8e61ae5-b4ef-4fca-8f2f-92d1bd146bb1
          collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde
      contact_utilization_fact.total_hours_per_week:
        is_active: false
        value_display: false
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hide_totals: false
    hide_row_totals: false
    hidden_fields: [contact_utilization_fact.average_actual_utilization, contact_utilization_fact.total_actual_story_points,
      contact_utilization_fact.total_hours_per_week, contact_utilization_fact.total_time_off,
      contact_utilization_fact.average_target, contact_utilization_fact.average_forecast_utilization,
      contact_utilization_fact.actual_to_forecast_utilization_variance, contact_utilization_fact.actual_to_target_utilization_variance,
      actual_utilization, target_utilization, contact_utilization_fact.total_total_capacity,
      contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_forecast_billable_hours,
      contact_utilization_fact.total_actual_billable_hours]
    hidden_points_if_no: []
    theme: traditional
    customTheme: ''
    layout: fixed
    minWidthForIndexColumns: true
    headerFontSize: 12
    bodyFontSize: 12
    showTooltip: true
    showHighlight: false
    columnOrder: {}
    rowSubtotals: true
    colSubtotals: false
    spanRows: true
    spanCols: true
    calculateOthers: false
    sortColumnsBy: pivots
    useViewName: false
    useHeadings: false
    useShortName: false
    useUnit: false
    groupVarianceColumns: false
    genericLabelForSubtotals: false
    indexColumn: false
    transposeTable: false
    label|contact_utilization_fact.forecast_week: Week
    heading|contact_utilization_fact.forecast_week: ''
    hide|contact_utilization_fact.forecast_week: false
    label|staff_dim.contact_name: Name
    heading|staff_dim.contact_name: ''
    hide|staff_dim.contact_name: false
    subtotalDepth: '1'
    label|contact_utilization_fact.total_time_off: Time Off
    heading|contact_utilization_fact.total_time_off: ''
    style|contact_utilization_fact.total_time_off: normal
    reportIn|contact_utilization_fact.total_time_off: '1'
    unit|contact_utilization_fact.total_time_off: Hours
    comparison|contact_utilization_fact.total_time_off: no_variance
    switch|contact_utilization_fact.total_time_off: false
    var_num|contact_utilization_fact.total_time_off: false
    var_pct|contact_utilization_fact.total_time_off: false
    label|contact_utilization_fact.average_target: Target
    heading|contact_utilization_fact.average_target: ''
    style|contact_utilization_fact.average_target: normal
    reportIn|contact_utilization_fact.average_target: '1'
    unit|contact_utilization_fact.average_target: ''
    comparison|contact_utilization_fact.average_target: no_variance
    switch|contact_utilization_fact.average_target: false
    var_num|contact_utilization_fact.average_target: true
    var_pct|contact_utilization_fact.average_target: false
    label|contact_utilization_fact.total_hours_per_week: Hours Per Week
    label|contact_utilization_fact.total_total_capacity: Total Capacity
    label|contact_utilization_fact.total_target_billable_capacity: Target Capacity
    label|contact_utilization_fact.total_forecast_billable_hours: Forecast Hours
    label|contact_utilization_fact.total_actual_billable_hours: Actual Hours
    label|contact_utilization_fact.total_actual_story_points: Story Points
    heading|contact_utilization_fact.total_actual_story_points: Story Points Delivered
    label|contact_utilization_fact.average_forecast_utilization: Forecast Utilization
    heading|contact_utilization_fact.average_forecast_utilization: Forecast Utilization
    switch|contact_utilization_fact.average_forecast_utilization: false
    label|contact_utilization_fact.average_actual_utilization: Actual Utilization
    label|contact_utilization_fact.actual_to_forecast_utilization_variance: Variance
    label|contact_utilization_fact.actual_to_target_utilization_variance: Variance
    label|actual_utilization: Actual Utilization
    heading|actual_utilization: ''
    style|actual_utilization: normal
    reportIn|actual_utilization: '1'
    unit|actual_utilization: ''
    comparison|actual_utilization: contact_utilization_fact.average_target
    switch|actual_utilization: false
    var_num|actual_utilization: true
    var_pct|actual_utilization: false
    label|actual_utilization_to_forecast_variance: Actual Utilization to Forecast
      Variance
    heading|actual_utilization_to_forecast_variance: ''
    style|actual_utilization_to_forecast_variance: normal
    reportIn|actual_utilization_to_forecast_variance: '1'
    unit|actual_utilization_to_forecast_variance: ''
    comparison|actual_utilization_to_forecast_variance: contact_utilization_fact.average_target
    switch|actual_utilization_to_forecast_variance: false
    var_num|actual_utilization_to_forecast_variance: true
    var_pct|actual_utilization_to_forecast_variance: true
    label|actual_utilization_to_target_variance: Actual Utilization to Target Variance
    heading|actual_utilization_to_target_variance: ''
    style|actual_utilization_to_target_variance: normal
    reportIn|actual_utilization_to_target_variance: '1'
    unit|actual_utilization_to_target_variance: ''
    comparison|actual_utilization_to_target_variance: contact_utilization_fact.average_target
    switch|actual_utilization_to_target_variance: false
    var_num|actual_utilization_to_target_variance: true
    var_pct|actual_utilization_to_target_variance: false
    label|contact_utilization_fact.average_hours_per_week: "             Hours Per\
      \ Week"
    heading|contact_utilization_fact.average_hours_per_week: ''
    style|contact_utilization_fact.average_hours_per_week: normal
    reportIn|contact_utilization_fact.average_hours_per_week: '1'
    unit|contact_utilization_fact.average_hours_per_week: ''
    comparison|contact_utilization_fact.average_hours_per_week: no_variance
    switch|contact_utilization_fact.average_hours_per_week: false
    var_num|contact_utilization_fact.average_hours_per_week: true
    var_pct|contact_utilization_fact.average_hours_per_week: false
    label|contact_utilization_fact.average_total_capacity: "           Total Capacity"
    heading|contact_utilization_fact.average_total_capacity: ''
    style|contact_utilization_fact.average_total_capacity: normal
    reportIn|contact_utilization_fact.average_total_capacity: '1'
    unit|contact_utilization_fact.average_total_capacity: ''
    comparison|contact_utilization_fact.average_total_capacity: no_variance
    switch|contact_utilization_fact.average_total_capacity: false
    var_num|contact_utilization_fact.average_total_capacity: true
    var_pct|contact_utilization_fact.average_total_capacity: false
    label|contact_utilization_fact.average_target_billable_capacity: "         Target\
      \ Billable Capacity"
    heading|contact_utilization_fact.average_target_billable_capacity: ''
    style|contact_utilization_fact.average_target_billable_capacity: normal
    reportIn|contact_utilization_fact.average_target_billable_capacity: '1'
    unit|contact_utilization_fact.average_target_billable_capacity: ''
    comparison|contact_utilization_fact.average_target_billable_capacity: no_variance
    switch|contact_utilization_fact.average_target_billable_capacity: false
    var_num|contact_utilization_fact.average_target_billable_capacity: true
    var_pct|contact_utilization_fact.average_target_billable_capacity: false
    label|contact_utilization_fact.average_forecast_billable_hours: "       Forecast\
      \ Billable Hours"
    heading|contact_utilization_fact.average_forecast_billable_hours: ''
    style|contact_utilization_fact.average_forecast_billable_hours: normal
    reportIn|contact_utilization_fact.average_forecast_billable_hours: '1'
    unit|contact_utilization_fact.average_forecast_billable_hours: ''
    comparison|contact_utilization_fact.average_forecast_billable_hours: no_variance
    switch|contact_utilization_fact.average_forecast_billable_hours: false
    var_num|contact_utilization_fact.average_forecast_billable_hours: true
    var_pct|contact_utilization_fact.average_forecast_billable_hours: false
    label|contact_utilization_fact.average_actual_billable_hours: "    Actual Billable\
      \ Hours"
    heading|contact_utilization_fact.average_actual_billable_hours: ''
    style|contact_utilization_fact.average_actual_billable_hours: normal
    reportIn|contact_utilization_fact.average_actual_billable_hours: '1'
    unit|contact_utilization_fact.average_actual_billable_hours: ''
    comparison|contact_utilization_fact.average_actual_billable_hours: no_variance
    switch|contact_utilization_fact.average_actual_billable_hours: false
    var_num|contact_utilization_fact.average_actual_billable_hours: true
    var_pct|contact_utilization_fact.average_actual_billable_hours: false
    label|contact_utilization_fact.average_actual_story_points: Actual Story Points
    heading|contact_utilization_fact.average_actual_story_points: ''
    style|contact_utilization_fact.average_actual_story_points: normal
    reportIn|contact_utilization_fact.average_actual_story_points: '1'
    unit|contact_utilization_fact.average_actual_story_points: ''
    comparison|contact_utilization_fact.average_actual_story_points: no_variance
    switch|contact_utilization_fact.average_actual_story_points: false
    var_num|contact_utilization_fact.average_actual_story_points: true
    var_pct|contact_utilization_fact.average_actual_story_points: false
    label|forecast_utilization: Forecast Utilization
    heading|forecast_utilization: ''
    style|forecast_utilization: normal
    reportIn|forecast_utilization: '1'
    unit|forecast_utilization: ''
    comparison|forecast_utilization: no_variance
    switch|forecast_utilization: false
    var_num|forecast_utilization: true
    var_pct|forecast_utilization: false
    label|contact_utilization_fact.average_time_off: "                  Time-Off"
    heading|contact_utilization_fact.average_time_off: ''
    style|contact_utilization_fact.average_time_off: normal
    reportIn|contact_utilization_fact.average_time_off: '1'
    unit|contact_utilization_fact.average_time_off: ''
    comparison|contact_utilization_fact.average_time_off: no_variance
    switch|contact_utilization_fact.average_time_off: false
    var_num|contact_utilization_fact.average_time_off: true
    var_pct|contact_utilization_fact.average_time_off: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    truncate_column_names: false
    listen: {}
    row: 67
    col: 12
    width: 4
    height: 4
  - title: Lewis
    name: Lewis
    model: analytics
    explore: contact_utilization_fact
    type: looker_line
    fields: [contact_utilization_fact.forecast_week, contact_utilization_fact.total_hours_per_week,
      contact_utilization_fact.total_time_off, contact_utilization_fact.average_target,
      contact_utilization_fact.total_total_capacity, contact_utilization_fact.total_target_billable_capacity,
      contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours,
      contact_utilization_fact.total_actual_story_points, contact_utilization_fact.average_forecast_utilization,
      contact_utilization_fact.actual_to_forecast_utilization_variance, contact_utilization_fact.average_actual_utilization,
      contact_utilization_fact.actual_to_target_utilization_variance]
    fill_fields: [contact_utilization_fact.forecast_week]
    filters:
      staff_dim.contact_is_contractor: 'No'
      staff_dim.contact_name: Lewis Baker
      contact_utilization_fact.forecast_week: 52 weeks ago for 52 weeks
    sorts: [contact_utilization_fact.forecast_week desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${contact_utilization_fact.total_target_billable_capacity}/${contact_utilization_fact.total_hours_per_week}",
        label: Target Utilization %, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: target_utilization, _type_hint: number},
      {category: table_calculation, expression: "${contact_utilization_fact.total_actual_billable_hours}/${contact_utilization_fact.total_hours_per_week}",
        label: Actual Utilization %, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: actual_utilization, _type_hint: number},
      {category: table_calculation, expression: "(${contact_utilization_fact.total_actual_billable_hours}+offset(${contact_utilization_fact.total_actual_billable_hours},1)+offset(${contact_utilization_fact.total_actual_billable_hours},2)+offset(${contact_utilization_fact.total_actual_billable_hours},3))/(${contact_utilization_fact.total_total_capacity}+offset(${contact_utilization_fact.total_total_capacity},1)+offset(${contact_utilization_fact.total_total_capacity},2)+offset(${contact_utilization_fact.total_total_capacity},3))",
        label: 4 Week Avg. Actual Utilisation, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: 4_week_avg_actual_utilisation, _type_hint: number},
      {category: table_calculation, expression: "(${contact_utilization_fact.total_target_billable_capacity}+offset(${contact_utilization_fact.total_target_billable_capacity},1)+offset(${contact_utilization_fact.total_target_billable_capacity},2)+offset(${contact_utilization_fact.total_target_billable_capacity},3))/(${contact_utilization_fact.total_total_capacity}+offset(${contact_utilization_fact.total_total_capacity},1)+offset(${contact_utilization_fact.total_total_capacity},2)+offset(${contact_utilization_fact.total_total_capacity},3))",
        label: 4 Week Avg. Target Utilisation, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: 4_week_avg_target_utilisation, _type_hint: number},
      {category: table_calculation, expression: "(${contact_utilization_fact.total_forecast_billable_hours}+offset(${contact_utilization_fact.total_forecast_billable_hours},1)+offset(${contact_utilization_fact.total_forecast_billable_hours},2)+offset(${contact_utilization_fact.total_forecast_billable_hours},3))/(${contact_utilization_fact.total_total_capacity}+offset(${contact_utilization_fact.total_total_capacity},1)+offset(${contact_utilization_fact.total_total_capacity},2)+offset(${contact_utilization_fact.total_total_capacity},3))",
        label: 4 Week Avg. Forecast Utilization, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: 4_week_avg_forecast_utilization, _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
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
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: 4_week_avg_actual_utilisation,
            id: 4_week_avg_actual_utilisation, name: 4 Week Avg. Actual Utilisation},
          {axisId: 4_week_avg_target_utilisation, id: 4_week_avg_target_utilisation,
            name: 4 Week Avg. Target Utilisation}, {axisId: 4_week_avg_forecast_utilization,
            id: 4_week_avg_forecast_utilization, name: 4 Week Avg. Forecast Utilization}],
        showLabels: true, showValues: true, maxValue: 1.2, unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 2, type: linear}]
    hidden_series: [contact_utilization_fact.total_total_capacity, contact_utilization_fact.total_target_billable_capacity,
      contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours]
    series_types: {}
    series_colors:
      4_week_avg_target_utilisation: "#D13452"
      4_week_avg_forecast_utilization: "#e3e3e3"
    series_labels:
      contact_utilization_fact.total_total_capacity: Capacity Hours
      contact_utilization_fact.average_target: Target %
      contact_utilization_fact.total_time_off: Time-Off
      contact_utilization_fact.total_hours_per_week: Total Hours
      contact_utilization_fact.total_target_billable_capacity: Target Hours
      contact_utilization_fact.total_forecast_billable_hours: Forecast Hours
      contact_utilization_fact.total_actual_billable_hours: Actual Hours
      contact_utilization_fact.total_actual_story_points: Story Points
      contact_utilization_fact.average_forecast_utilization: Forecast Utilization
      contact_utilization_fact.actual_to_forecast_utilization_variance: Actual Utilization
      contact_utilization_fact.actual_to_target_utilization_variance: Variance %
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", contact_utilization_fact.forecast_week,
      staff_dim.contact_name, contact_utilization_fact.total_hours_per_week, contact_utilization_fact.total_time_off,
      contact_utilization_fact.average_target, contact_utilization_fact.total_total_capacity,
      contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_forecast_billable_hours,
      contact_utilization_fact.total_actual_billable_hours, contact_utilization_fact.total_actual_story_points,
      contact_utilization_fact.average_forecast_utilization, contact_utilization_fact.actual_to_forecast_utilization_variance,
      contact_utilization_fact.average_actual_utilization, contact_utilization_fact.actual_to_target_utilization_variance]
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    series_column_widths:
      grouped-column-contact_utilization_fact.forecast_week: 165
    series_cell_visualizations:
      contact_utilization_fact.average_time_off:
        is_active: false
      forecast_utilization:
        is_active: true
        palette:
          palette_id: c8e61ae5-b4ef-4fca-8f2f-92d1bd146bb1
          collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde
      actual_utilization:
        is_active: false
        palette:
          palette_id: c8e61ae5-b4ef-4fca-8f2f-92d1bd146bb1
          collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde
      contact_utilization_fact.total_hours_per_week:
        is_active: false
        value_display: false
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hide_totals: false
    hide_row_totals: false
    hidden_fields: [contact_utilization_fact.average_actual_utilization, contact_utilization_fact.total_actual_story_points,
      contact_utilization_fact.total_hours_per_week, contact_utilization_fact.total_time_off,
      contact_utilization_fact.average_target, contact_utilization_fact.average_forecast_utilization,
      contact_utilization_fact.actual_to_forecast_utilization_variance, contact_utilization_fact.actual_to_target_utilization_variance,
      actual_utilization, target_utilization, contact_utilization_fact.total_total_capacity,
      contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_forecast_billable_hours,
      contact_utilization_fact.total_actual_billable_hours]
    hidden_points_if_no: []
    theme: traditional
    customTheme: ''
    layout: fixed
    minWidthForIndexColumns: true
    headerFontSize: 12
    bodyFontSize: 12
    showTooltip: true
    showHighlight: false
    columnOrder: {}
    rowSubtotals: true
    colSubtotals: false
    spanRows: true
    spanCols: true
    calculateOthers: false
    sortColumnsBy: pivots
    useViewName: false
    useHeadings: false
    useShortName: false
    useUnit: false
    groupVarianceColumns: false
    genericLabelForSubtotals: false
    indexColumn: false
    transposeTable: false
    label|contact_utilization_fact.forecast_week: Week
    heading|contact_utilization_fact.forecast_week: ''
    hide|contact_utilization_fact.forecast_week: false
    label|staff_dim.contact_name: Name
    heading|staff_dim.contact_name: ''
    hide|staff_dim.contact_name: false
    subtotalDepth: '1'
    label|contact_utilization_fact.total_time_off: Time Off
    heading|contact_utilization_fact.total_time_off: ''
    style|contact_utilization_fact.total_time_off: normal
    reportIn|contact_utilization_fact.total_time_off: '1'
    unit|contact_utilization_fact.total_time_off: Hours
    comparison|contact_utilization_fact.total_time_off: no_variance
    switch|contact_utilization_fact.total_time_off: false
    var_num|contact_utilization_fact.total_time_off: false
    var_pct|contact_utilization_fact.total_time_off: false
    label|contact_utilization_fact.average_target: Target
    heading|contact_utilization_fact.average_target: ''
    style|contact_utilization_fact.average_target: normal
    reportIn|contact_utilization_fact.average_target: '1'
    unit|contact_utilization_fact.average_target: ''
    comparison|contact_utilization_fact.average_target: no_variance
    switch|contact_utilization_fact.average_target: false
    var_num|contact_utilization_fact.average_target: true
    var_pct|contact_utilization_fact.average_target: false
    label|contact_utilization_fact.total_hours_per_week: Hours Per Week
    label|contact_utilization_fact.total_total_capacity: Total Capacity
    label|contact_utilization_fact.total_target_billable_capacity: Target Capacity
    label|contact_utilization_fact.total_forecast_billable_hours: Forecast Hours
    label|contact_utilization_fact.total_actual_billable_hours: Actual Hours
    label|contact_utilization_fact.total_actual_story_points: Story Points
    heading|contact_utilization_fact.total_actual_story_points: Story Points Delivered
    label|contact_utilization_fact.average_forecast_utilization: Forecast Utilization
    heading|contact_utilization_fact.average_forecast_utilization: Forecast Utilization
    switch|contact_utilization_fact.average_forecast_utilization: false
    label|contact_utilization_fact.average_actual_utilization: Actual Utilization
    label|contact_utilization_fact.actual_to_forecast_utilization_variance: Variance
    label|contact_utilization_fact.actual_to_target_utilization_variance: Variance
    label|actual_utilization: Actual Utilization
    heading|actual_utilization: ''
    style|actual_utilization: normal
    reportIn|actual_utilization: '1'
    unit|actual_utilization: ''
    comparison|actual_utilization: contact_utilization_fact.average_target
    switch|actual_utilization: false
    var_num|actual_utilization: true
    var_pct|actual_utilization: false
    label|actual_utilization_to_forecast_variance: Actual Utilization to Forecast
      Variance
    heading|actual_utilization_to_forecast_variance: ''
    style|actual_utilization_to_forecast_variance: normal
    reportIn|actual_utilization_to_forecast_variance: '1'
    unit|actual_utilization_to_forecast_variance: ''
    comparison|actual_utilization_to_forecast_variance: contact_utilization_fact.average_target
    switch|actual_utilization_to_forecast_variance: false
    var_num|actual_utilization_to_forecast_variance: true
    var_pct|actual_utilization_to_forecast_variance: true
    label|actual_utilization_to_target_variance: Actual Utilization to Target Variance
    heading|actual_utilization_to_target_variance: ''
    style|actual_utilization_to_target_variance: normal
    reportIn|actual_utilization_to_target_variance: '1'
    unit|actual_utilization_to_target_variance: ''
    comparison|actual_utilization_to_target_variance: contact_utilization_fact.average_target
    switch|actual_utilization_to_target_variance: false
    var_num|actual_utilization_to_target_variance: true
    var_pct|actual_utilization_to_target_variance: false
    label|contact_utilization_fact.average_hours_per_week: "             Hours Per\
      \ Week"
    heading|contact_utilization_fact.average_hours_per_week: ''
    style|contact_utilization_fact.average_hours_per_week: normal
    reportIn|contact_utilization_fact.average_hours_per_week: '1'
    unit|contact_utilization_fact.average_hours_per_week: ''
    comparison|contact_utilization_fact.average_hours_per_week: no_variance
    switch|contact_utilization_fact.average_hours_per_week: false
    var_num|contact_utilization_fact.average_hours_per_week: true
    var_pct|contact_utilization_fact.average_hours_per_week: false
    label|contact_utilization_fact.average_total_capacity: "           Total Capacity"
    heading|contact_utilization_fact.average_total_capacity: ''
    style|contact_utilization_fact.average_total_capacity: normal
    reportIn|contact_utilization_fact.average_total_capacity: '1'
    unit|contact_utilization_fact.average_total_capacity: ''
    comparison|contact_utilization_fact.average_total_capacity: no_variance
    switch|contact_utilization_fact.average_total_capacity: false
    var_num|contact_utilization_fact.average_total_capacity: true
    var_pct|contact_utilization_fact.average_total_capacity: false
    label|contact_utilization_fact.average_target_billable_capacity: "         Target\
      \ Billable Capacity"
    heading|contact_utilization_fact.average_target_billable_capacity: ''
    style|contact_utilization_fact.average_target_billable_capacity: normal
    reportIn|contact_utilization_fact.average_target_billable_capacity: '1'
    unit|contact_utilization_fact.average_target_billable_capacity: ''
    comparison|contact_utilization_fact.average_target_billable_capacity: no_variance
    switch|contact_utilization_fact.average_target_billable_capacity: false
    var_num|contact_utilization_fact.average_target_billable_capacity: true
    var_pct|contact_utilization_fact.average_target_billable_capacity: false
    label|contact_utilization_fact.average_forecast_billable_hours: "       Forecast\
      \ Billable Hours"
    heading|contact_utilization_fact.average_forecast_billable_hours: ''
    style|contact_utilization_fact.average_forecast_billable_hours: normal
    reportIn|contact_utilization_fact.average_forecast_billable_hours: '1'
    unit|contact_utilization_fact.average_forecast_billable_hours: ''
    comparison|contact_utilization_fact.average_forecast_billable_hours: no_variance
    switch|contact_utilization_fact.average_forecast_billable_hours: false
    var_num|contact_utilization_fact.average_forecast_billable_hours: true
    var_pct|contact_utilization_fact.average_forecast_billable_hours: false
    label|contact_utilization_fact.average_actual_billable_hours: "    Actual Billable\
      \ Hours"
    heading|contact_utilization_fact.average_actual_billable_hours: ''
    style|contact_utilization_fact.average_actual_billable_hours: normal
    reportIn|contact_utilization_fact.average_actual_billable_hours: '1'
    unit|contact_utilization_fact.average_actual_billable_hours: ''
    comparison|contact_utilization_fact.average_actual_billable_hours: no_variance
    switch|contact_utilization_fact.average_actual_billable_hours: false
    var_num|contact_utilization_fact.average_actual_billable_hours: true
    var_pct|contact_utilization_fact.average_actual_billable_hours: false
    label|contact_utilization_fact.average_actual_story_points: Actual Story Points
    heading|contact_utilization_fact.average_actual_story_points: ''
    style|contact_utilization_fact.average_actual_story_points: normal
    reportIn|contact_utilization_fact.average_actual_story_points: '1'
    unit|contact_utilization_fact.average_actual_story_points: ''
    comparison|contact_utilization_fact.average_actual_story_points: no_variance
    switch|contact_utilization_fact.average_actual_story_points: false
    var_num|contact_utilization_fact.average_actual_story_points: true
    var_pct|contact_utilization_fact.average_actual_story_points: false
    label|forecast_utilization: Forecast Utilization
    heading|forecast_utilization: ''
    style|forecast_utilization: normal
    reportIn|forecast_utilization: '1'
    unit|forecast_utilization: ''
    comparison|forecast_utilization: no_variance
    switch|forecast_utilization: false
    var_num|forecast_utilization: true
    var_pct|forecast_utilization: false
    label|contact_utilization_fact.average_time_off: "                  Time-Off"
    heading|contact_utilization_fact.average_time_off: ''
    style|contact_utilization_fact.average_time_off: normal
    reportIn|contact_utilization_fact.average_time_off: '1'
    unit|contact_utilization_fact.average_time_off: ''
    comparison|contact_utilization_fact.average_time_off: no_variance
    switch|contact_utilization_fact.average_time_off: false
    var_num|contact_utilization_fact.average_time_off: true
    var_pct|contact_utilization_fact.average_time_off: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    truncate_column_names: false
    listen: {}
    row: 67
    col: 8
    width: 4
    height: 4
  - title: Utilisation
    name: Utilisation
    model: analytics
    explore: contact_utilization_fact
    type: single_value
    fields: [contact_utilization_fact.forecast_week, contact_utilization_fact.total_hours_per_week,
      contact_utilization_fact.total_time_off, contact_utilization_fact.average_target,
      contact_utilization_fact.total_total_capacity, contact_utilization_fact.total_target_billable_capacity,
      contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours,
      contact_utilization_fact.total_actual_story_points, contact_utilization_fact.average_forecast_utilization,
      contact_utilization_fact.actual_to_forecast_utilization_variance, contact_utilization_fact.average_actual_utilization,
      contact_utilization_fact.actual_to_target_utilization_variance]
    fill_fields: [contact_utilization_fact.forecast_week]
    filters:
      staff_dim.contact_is_contractor: 'No'
      staff_dim.contact_name: "-Toby Sexton,-Benjamin Zarif"
      contact_utilization_fact.forecast_week: 52 weeks ago for 52 weeks
    sorts: [contact_utilization_fact.forecast_week desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${contact_utilization_fact.total_target_billable_capacity}/${contact_utilization_fact.total_hours_per_week}",
        label: Target Utilization %, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: target_utilization, _type_hint: number},
      {category: table_calculation, expression: "${contact_utilization_fact.total_actual_billable_hours}/${contact_utilization_fact.total_hours_per_week}",
        label: Actual Utilization %, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: actual_utilization, _type_hint: number},
      {category: table_calculation, expression: "(${contact_utilization_fact.total_actual_billable_hours}+offset(${contact_utilization_fact.total_actual_billable_hours},1)+offset(${contact_utilization_fact.total_actual_billable_hours},2)+offset(${contact_utilization_fact.total_actual_billable_hours},3))/(${contact_utilization_fact.total_total_capacity}+offset(${contact_utilization_fact.total_total_capacity},1)+offset(${contact_utilization_fact.total_total_capacity},2)+offset(${contact_utilization_fact.total_total_capacity},3))",
        label: 4 Week Avg. Actual Utilisation, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: 4_week_avg_actual_utilisation, _type_hint: number},
      {category: table_calculation, expression: "(${contact_utilization_fact.total_target_billable_capacity}+offset(${contact_utilization_fact.total_target_billable_capacity},1)+offset(${contact_utilization_fact.total_target_billable_capacity},2)+offset(${contact_utilization_fact.total_target_billable_capacity},3))/(${contact_utilization_fact.total_total_capacity}+offset(${contact_utilization_fact.total_total_capacity},1)+offset(${contact_utilization_fact.total_total_capacity},2)+offset(${contact_utilization_fact.total_total_capacity},3))",
        label: 4 Week Avg. Target Utilisation, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: 4_week_avg_target_utilisation, _type_hint: number},
      {category: table_calculation, expression: "(${contact_utilization_fact.total_forecast_billable_hours}+offset(${contact_utilization_fact.total_forecast_billable_hours},1)+offset(${contact_utilization_fact.total_forecast_billable_hours},2)+offset(${contact_utilization_fact.total_forecast_billable_hours},3))/(${contact_utilization_fact.total_total_capacity}+offset(${contact_utilization_fact.total_total_capacity},1)+offset(${contact_utilization_fact.total_total_capacity},2)+offset(${contact_utilization_fact.total_total_capacity},3))",
        label: 4 Week Avg. Forecast Utilization, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: 4_week_avg_forecast_utilization, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    comparison_label: 4 Week Avg. Target
    conditional_formatting: [{type: equal to, value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
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
    hidden_series: [contact_utilization_fact.total_total_capacity, contact_utilization_fact.total_target_billable_capacity,
      contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours]
    series_types: {}
    series_colors:
      4_week_avg_target_utilisation: "#D13452"
      4_week_avg_forecast_utilization: "#e3e3e3"
    series_labels:
      contact_utilization_fact.total_total_capacity: Capacity Hours
      contact_utilization_fact.average_target: Target %
      contact_utilization_fact.total_time_off: Time-Off
      contact_utilization_fact.total_hours_per_week: Total Hours
      contact_utilization_fact.total_target_billable_capacity: Target Hours
      contact_utilization_fact.total_forecast_billable_hours: Forecast Hours
      contact_utilization_fact.total_actual_billable_hours: Actual Hours
      contact_utilization_fact.total_actual_story_points: Story Points
      contact_utilization_fact.average_forecast_utilization: Forecast Utilization
      contact_utilization_fact.actual_to_forecast_utilization_variance: Actual Utilization
      contact_utilization_fact.actual_to_target_utilization_variance: Variance %
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", contact_utilization_fact.forecast_week,
      staff_dim.contact_name, contact_utilization_fact.total_hours_per_week, contact_utilization_fact.total_time_off,
      contact_utilization_fact.average_target, contact_utilization_fact.total_total_capacity,
      contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_forecast_billable_hours,
      contact_utilization_fact.total_actual_billable_hours, contact_utilization_fact.total_actual_story_points,
      contact_utilization_fact.average_forecast_utilization, contact_utilization_fact.actual_to_forecast_utilization_variance,
      contact_utilization_fact.average_actual_utilization, contact_utilization_fact.actual_to_target_utilization_variance]
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    series_column_widths:
      grouped-column-contact_utilization_fact.forecast_week: 165
    series_cell_visualizations:
      contact_utilization_fact.average_time_off:
        is_active: false
      forecast_utilization:
        is_active: true
        palette:
          palette_id: c8e61ae5-b4ef-4fca-8f2f-92d1bd146bb1
          collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde
      actual_utilization:
        is_active: false
        palette:
          palette_id: c8e61ae5-b4ef-4fca-8f2f-92d1bd146bb1
          collection_id: 427412fe-10ef-4870-bd3d-76cae7a14bde
      contact_utilization_fact.total_hours_per_week:
        is_active: false
        value_display: false
    table_theme: white
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    hide_totals: false
    hide_row_totals: false
    hidden_fields: [contact_utilization_fact.average_actual_utilization, contact_utilization_fact.total_actual_story_points,
      contact_utilization_fact.total_hours_per_week, contact_utilization_fact.total_time_off,
      contact_utilization_fact.average_target, contact_utilization_fact.average_forecast_utilization,
      contact_utilization_fact.actual_to_forecast_utilization_variance, contact_utilization_fact.actual_to_target_utilization_variance,
      actual_utilization, target_utilization, contact_utilization_fact.total_total_capacity,
      contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_forecast_billable_hours,
      contact_utilization_fact.total_actual_billable_hours, 4_week_avg_forecast_utilization]
    hidden_points_if_no: []
    theme: traditional
    customTheme: ''
    layout: fixed
    minWidthForIndexColumns: true
    headerFontSize: 12
    bodyFontSize: 12
    showTooltip: true
    showHighlight: false
    columnOrder: {}
    rowSubtotals: true
    colSubtotals: false
    spanRows: true
    spanCols: true
    calculateOthers: false
    sortColumnsBy: pivots
    useViewName: false
    useHeadings: false
    useShortName: false
    useUnit: false
    groupVarianceColumns: false
    genericLabelForSubtotals: false
    indexColumn: false
    transposeTable: false
    label|contact_utilization_fact.forecast_week: Week
    heading|contact_utilization_fact.forecast_week: ''
    hide|contact_utilization_fact.forecast_week: false
    label|staff_dim.contact_name: Name
    heading|staff_dim.contact_name: ''
    hide|staff_dim.contact_name: false
    subtotalDepth: '1'
    label|contact_utilization_fact.total_time_off: Time Off
    heading|contact_utilization_fact.total_time_off: ''
    style|contact_utilization_fact.total_time_off: normal
    reportIn|contact_utilization_fact.total_time_off: '1'
    unit|contact_utilization_fact.total_time_off: Hours
    comparison|contact_utilization_fact.total_time_off: no_variance
    switch|contact_utilization_fact.total_time_off: false
    var_num|contact_utilization_fact.total_time_off: false
    var_pct|contact_utilization_fact.total_time_off: false
    label|contact_utilization_fact.average_target: Target
    heading|contact_utilization_fact.average_target: ''
    style|contact_utilization_fact.average_target: normal
    reportIn|contact_utilization_fact.average_target: '1'
    unit|contact_utilization_fact.average_target: ''
    comparison|contact_utilization_fact.average_target: no_variance
    switch|contact_utilization_fact.average_target: false
    var_num|contact_utilization_fact.average_target: true
    var_pct|contact_utilization_fact.average_target: false
    label|contact_utilization_fact.total_hours_per_week: Hours Per Week
    label|contact_utilization_fact.total_total_capacity: Total Capacity
    label|contact_utilization_fact.total_target_billable_capacity: Target Capacity
    label|contact_utilization_fact.total_forecast_billable_hours: Forecast Hours
    label|contact_utilization_fact.total_actual_billable_hours: Actual Hours
    label|contact_utilization_fact.total_actual_story_points: Story Points
    heading|contact_utilization_fact.total_actual_story_points: Story Points Delivered
    label|contact_utilization_fact.average_forecast_utilization: Forecast Utilization
    heading|contact_utilization_fact.average_forecast_utilization: Forecast Utilization
    switch|contact_utilization_fact.average_forecast_utilization: false
    label|contact_utilization_fact.average_actual_utilization: Actual Utilization
    label|contact_utilization_fact.actual_to_forecast_utilization_variance: Variance
    label|contact_utilization_fact.actual_to_target_utilization_variance: Variance
    label|actual_utilization: Actual Utilization
    heading|actual_utilization: ''
    style|actual_utilization: normal
    reportIn|actual_utilization: '1'
    unit|actual_utilization: ''
    comparison|actual_utilization: contact_utilization_fact.average_target
    switch|actual_utilization: false
    var_num|actual_utilization: true
    var_pct|actual_utilization: false
    label|actual_utilization_to_forecast_variance: Actual Utilization to Forecast
      Variance
    heading|actual_utilization_to_forecast_variance: ''
    style|actual_utilization_to_forecast_variance: normal
    reportIn|actual_utilization_to_forecast_variance: '1'
    unit|actual_utilization_to_forecast_variance: ''
    comparison|actual_utilization_to_forecast_variance: contact_utilization_fact.average_target
    switch|actual_utilization_to_forecast_variance: false
    var_num|actual_utilization_to_forecast_variance: true
    var_pct|actual_utilization_to_forecast_variance: true
    label|actual_utilization_to_target_variance: Actual Utilization to Target Variance
    heading|actual_utilization_to_target_variance: ''
    style|actual_utilization_to_target_variance: normal
    reportIn|actual_utilization_to_target_variance: '1'
    unit|actual_utilization_to_target_variance: ''
    comparison|actual_utilization_to_target_variance: contact_utilization_fact.average_target
    switch|actual_utilization_to_target_variance: false
    var_num|actual_utilization_to_target_variance: true
    var_pct|actual_utilization_to_target_variance: false
    label|contact_utilization_fact.average_hours_per_week: "             Hours Per\
      \ Week"
    heading|contact_utilization_fact.average_hours_per_week: ''
    style|contact_utilization_fact.average_hours_per_week: normal
    reportIn|contact_utilization_fact.average_hours_per_week: '1'
    unit|contact_utilization_fact.average_hours_per_week: ''
    comparison|contact_utilization_fact.average_hours_per_week: no_variance
    switch|contact_utilization_fact.average_hours_per_week: false
    var_num|contact_utilization_fact.average_hours_per_week: true
    var_pct|contact_utilization_fact.average_hours_per_week: false
    label|contact_utilization_fact.average_total_capacity: "           Total Capacity"
    heading|contact_utilization_fact.average_total_capacity: ''
    style|contact_utilization_fact.average_total_capacity: normal
    reportIn|contact_utilization_fact.average_total_capacity: '1'
    unit|contact_utilization_fact.average_total_capacity: ''
    comparison|contact_utilization_fact.average_total_capacity: no_variance
    switch|contact_utilization_fact.average_total_capacity: false
    var_num|contact_utilization_fact.average_total_capacity: true
    var_pct|contact_utilization_fact.average_total_capacity: false
    label|contact_utilization_fact.average_target_billable_capacity: "         Target\
      \ Billable Capacity"
    heading|contact_utilization_fact.average_target_billable_capacity: ''
    style|contact_utilization_fact.average_target_billable_capacity: normal
    reportIn|contact_utilization_fact.average_target_billable_capacity: '1'
    unit|contact_utilization_fact.average_target_billable_capacity: ''
    comparison|contact_utilization_fact.average_target_billable_capacity: no_variance
    switch|contact_utilization_fact.average_target_billable_capacity: false
    var_num|contact_utilization_fact.average_target_billable_capacity: true
    var_pct|contact_utilization_fact.average_target_billable_capacity: false
    label|contact_utilization_fact.average_forecast_billable_hours: "       Forecast\
      \ Billable Hours"
    heading|contact_utilization_fact.average_forecast_billable_hours: ''
    style|contact_utilization_fact.average_forecast_billable_hours: normal
    reportIn|contact_utilization_fact.average_forecast_billable_hours: '1'
    unit|contact_utilization_fact.average_forecast_billable_hours: ''
    comparison|contact_utilization_fact.average_forecast_billable_hours: no_variance
    switch|contact_utilization_fact.average_forecast_billable_hours: false
    var_num|contact_utilization_fact.average_forecast_billable_hours: true
    var_pct|contact_utilization_fact.average_forecast_billable_hours: false
    label|contact_utilization_fact.average_actual_billable_hours: "    Actual Billable\
      \ Hours"
    heading|contact_utilization_fact.average_actual_billable_hours: ''
    style|contact_utilization_fact.average_actual_billable_hours: normal
    reportIn|contact_utilization_fact.average_actual_billable_hours: '1'
    unit|contact_utilization_fact.average_actual_billable_hours: ''
    comparison|contact_utilization_fact.average_actual_billable_hours: no_variance
    switch|contact_utilization_fact.average_actual_billable_hours: false
    var_num|contact_utilization_fact.average_actual_billable_hours: true
    var_pct|contact_utilization_fact.average_actual_billable_hours: false
    label|contact_utilization_fact.average_actual_story_points: Actual Story Points
    heading|contact_utilization_fact.average_actual_story_points: ''
    style|contact_utilization_fact.average_actual_story_points: normal
    reportIn|contact_utilization_fact.average_actual_story_points: '1'
    unit|contact_utilization_fact.average_actual_story_points: ''
    comparison|contact_utilization_fact.average_actual_story_points: no_variance
    switch|contact_utilization_fact.average_actual_story_points: false
    var_num|contact_utilization_fact.average_actual_story_points: true
    var_pct|contact_utilization_fact.average_actual_story_points: false
    label|forecast_utilization: Forecast Utilization
    heading|forecast_utilization: ''
    style|forecast_utilization: normal
    reportIn|forecast_utilization: '1'
    unit|forecast_utilization: ''
    comparison|forecast_utilization: no_variance
    switch|forecast_utilization: false
    var_num|forecast_utilization: true
    var_pct|forecast_utilization: false
    label|contact_utilization_fact.average_time_off: "                  Time-Off"
    heading|contact_utilization_fact.average_time_off: ''
    style|contact_utilization_fact.average_time_off: normal
    reportIn|contact_utilization_fact.average_time_off: '1'
    unit|contact_utilization_fact.average_time_off: ''
    comparison|contact_utilization_fact.average_time_off: no_variance
    switch|contact_utilization_fact.average_time_off: false
    var_num|contact_utilization_fact.average_time_off: true
    var_pct|contact_utilization_fact.average_time_off: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    truncate_column_names: false
    listen: {}
    row: 2
    col: 8
    width: 4
    height: 5
  - title: Website Traffic
    name: Website Traffic
    model: analytics
    explore: web_sessions_fact
    type: looker_line
    fields: [web_events_fact.total_sessions, web_events_fact.total_blended_user_id,
      web_events_fact.total_session_conversions, web_events_fact.total_session_goal_achieveds,
      web_events_fact.event_ts_week, web_events_fact.total_page_views]
    filters:
      web_events_fact.event_ts_month: 52 weeks
      web_events_fact.total_sessions: ''
      web_events_fact.site: rittmananalytics.com
    sorts: [web_events_fact.event_ts_week desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${web_events_fact.total_session_goal_achieveds}/${web_events_fact.total_sessions}",
        label: Session Conversion Rate, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: session_conversion_rate, _type_hint: number},
      {category: table_calculation, expression: "${web_events_fact.total_session_goal_achieveds}/${web_events_fact.total_sessions}",
        label: Session Goal Achieved Rate, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: session_goal_achieved_rate, _type_hint: number},
      {category: table_calculation, expression: "(${web_events_fact.total_sessions}+offset(${web_events_fact.total_sessions},1)+offset(${web_events_fact.total_sessions},2)+offset(${web_events_fact.total_sessions},3))/4",
        label: Sessions 4Wk Avg., value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: sessions_4wk_avg, _type_hint: number},
      {category: table_calculation, expression: "(${web_events_fact.total_page_views}+offset(${web_events_fact.total_page_views},1)+offset(${web_events_fact.total_page_views},2)+offset(${web_events_fact.total_page_views},3))/4",
        label: Page Views 4Wk Avg., value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: page_views_4wk_avg, _type_hint: number},
      {category: table_calculation, expression: 'coalesce((${web_events_fact.total_blended_user_id}+offset(${web_events_fact.total_blended_user_id},1)+offset(${web_events_fact.total_blended_user_id},2)+offset(${web_events_fact.total_blended_user_id},3))/4,0)',
        label: Unique Visitors 4 Wk Avg., value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: unique_visitors_4_wk_avg, _type_hint: number}]
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
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: sessions_4wk_avg, id: sessions_4wk_avg,
            name: Sessions 4Wk Avg.}, {axisId: page_views_4wk_avg, id: page_views_4wk_avg,
            name: Page Views 4Wk Avg.}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, type: linear}, {label: !!null '', orientation: right,
        series: [{axisId: unique_visitors_4_wk_avg, id: unique_visitors_4_wk_avg,
            name: Unique Visitors 4 Wk Avg.}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, type: linear}]
    series_types: {}
    series_colors:
      unique_visitors_4_wk_avg: "#D13452"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_fields: [web_events_fact.total_session_conversions, web_events_fact.total_session_goal_achieveds,
      web_events_fact.total_blended_user_id, session_goal_achieved_rate, session_conversion_rate,
      web_events_fact.total_sessions, web_events_fact.total_page_views]
    listen: {}
    row: 9
    col: 16
    width: 8
    height: 8
  - name: New Deals
    title: New Deals
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: looker_column
      fields: [deals_fact.deal_created_month, deals_fact.total_deal_amount_gbp_converted]
      fill_fields: [deals_fact.deal_created_month]
      sorts: [deals_fact.deal_created_month desc]
      limit: 500
      filter_expression: "${deals_fact.deal_created_month}>add_months(-12,now())"
      analysis_config:
        forecasting:
        - confidence_interval: 0.95
          field_name: deals_fact.total_deal_amount_gbp_converted
          forecast_n: 3
          forecast_interval: month
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
      show_null_points: true
      interpolation: linear
      defaults_version: 1
      series_types: {}
      join_fields: []
    - model: analytics
      explore: targets
      type: table
      fields: [targets.period_month, targets.total_deals_target]
      fill_fields: [targets.period_month]
      filters:
        targets.period_month: 12 months
      sorts: [targets.period_month desc]
      limit: 500
      dynamic_fields: [{category: table_calculation, expression: 'if(is_null(${targets.total_deals_target}),150000,${targets.total_deals_target})',
          label: Target, value_format: !!null '', value_format_name: gbp_0, _kind_hint: measure,
          table_calculation: target, _type_hint: number}]
      join_fields:
      - field_name: targets.period_month
        source_field_name: deals_fact.deal_created_month
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: deals_fact.total_deal_amount_gbp_converted,
            id: deals_fact.total_deal_amount_gbp_converted, name: Actual New Deals
              (Forecast)}, {axisId: target_1, id: target_1, name: Target}], showLabels: true,
        showValues: true, maxValue: 500000, valueFormat: '"£"0,"K"', unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
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
    series_types:
      target_1: line
    point_style: none
    series_colors:
      targets.total_deals_target: "#D13452"
      target_1: "#d6d6d6"
    series_labels:
      deals_fact.total_deal_amount_gbp_converted: Actual New Deals (Forecast)
      targets.total_deals_target: Target
    show_value_labels: false
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    type: looker_column
    hidden_fields: [target, targets.total_deals_target]
    column_limit: 50
    dynamic_fields: [{category: table_calculation, expression: 'if(is_null(${targets.total_deals_target}),150000,${targets.total_deals_target})',
        label: Target, value_format: !!null '', value_format_name: gbp_0, _kind_hint: measure,
        table_calculation: target_1, _type_hint: number}]
    row: 9
    col: 0
    width: 8
    height: 8
  - name: Won Deals
    title: Won Deals
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: single_value
      fields: [deals_fact.total_oppportunity_deal_amount, deals_fact.deal_closed_month]
      fill_fields: [deals_fact.deal_closed_month]
      filters:
        deals_fact.pipeline_stage_label: Verbally Won & Working at Risk,Won & Scheduled,Won
          & Delivered
        companies_dim.company_name: "-Apex Auctions"
        deals_fact.deal_type: ''
        deals_fact.owner_full_name: ''
        deals_fact.partner_referral: ''
        deals_fact.sprint_type: ''
        deals_fact.deal_name: ''
        deals_fact.deal_is_deleted: 'No'
      sorts: [deals_fact.deal_closed_month desc]
      column_limit: 50
      dynamic_fields: [{category: table_calculation, expression: 'diff_days(${deals_fact.deal_pipeline_stage_date},now())',
          label: Days in Deal Stage, value_format: !!null '', value_format_name: !!null '',
          _kind_hint: dimension, table_calculation: days_in_deal_stage, _type_hint: number,
          is_disabled: true}, {measure: days_in_pipeline_2, based_on: deals_fact.days_in_pipeline,
          type: sum, label: Days in Pipeline, expression: !!null '', value_format: !!null '',
          value_format_name: !!null '', _kind_hint: measure, _type_hint: number},
        {category: table_calculation, expression: 'sum(${days_in_deal_stage})/count(${days_in_deal_stage})',
          label: Avg. Days in Deal Stage, value_format: !!null '', value_format_name: decimal_0,
          _kind_hint: dimension, table_calculation: avg_days_in_deal_stage, _type_hint: number,
          is_disabled: true}, {category: table_calculation, expression: "(sum(${deals_fact.total_weighted_opportunity_deal_amount}))/90000",
          label: Pipeline Coverage, value_format: '0.##":1"', value_format_name: __custom,
          _kind_hint: measure, table_calculation: pipeline_coverage, _type_hint: number,
          is_disabled: true}, {category: table_calculation, expression: 'count(${deals_fact.count_deals})',
          label: Active Deals, value_format: !!null '', value_format_name: !!null '',
          _kind_hint: measure, table_calculation: active_deals, _type_hint: number,
          is_disabled: true}, {category: table_calculation, expression: 'sum(${deals_fact.total_oppportunity_deal_amount})',
          label: Closed Won Deals This Month, value_format: '"£"0,"K"', value_format_name: __custom,
          _kind_hint: measure, table_calculation: closed_won_deals_this_month, _type_hint: number,
          is_disabled: true}]
      analysis_config:
        forecasting:
        - confidence_interval: 0.95
          field_name: deals_fact.total_oppportunity_deal_amount
          forecast_n: 3
          forecast_interval: month
      custom_color_enabled: true
      show_single_value_title: true
      show_comparison: false
      comparison_type: value
      comparison_reverse_colors: false
      show_comparison_label: true
      enable_conditional_formatting: true
      conditional_formatting_include_totals: false
      conditional_formatting_include_nulls: false
      show_view_names: false
      show_row_numbers: false
      transpose: false
      truncate_text: true
      hide_totals: false
      hide_row_totals: false
      size_to_fit: true
      table_theme: white
      limit_displayed_rows: false
      header_text_alignment: left
      header_font_size: '12'
      rows_font_size: '12'
      color_application:
        collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
        palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      show_sql_query_menu_options: false
      column_order: [deals_fact.deal_name, deals_fact.owner_full_name, deals_fact.pipeline_stage_label,
        deals_fact.sprint_type, deals_fact.deal_type, deals_fact.partner_referral,
        deals_fact.number_of_sprints, deals_fact.deal_currency_code, deals_fact.total_oppportunity_deal_amount,
        deals_fact.total_weighted_opportunity_deal_amount, deals_fact.deal_pipeline_stage_date,
        days_in_deal_stage]
      show_totals: true
      show_row_totals: true
      truncate_header: true
      series_labels:
        deals_fact.owner_full_name: Owner
        deals_fact.deal_type: Type
        deals_fact.pipeline_stage_label: Pipeline Stage
        days_in_pipeline_stage: Days In Stage
        days_in_pipeline: Days In Pipeline
        deals_fact.total_oppportunity_deal_amount: Amount
        deals_fact.total_weighted_opportunity_deal_amount: Weighted
        deals_fact.number_of_sprints: Sprints
        deals_fact.partner_referral: Partner
      series_cell_visualizations:
        deals_fact.total_weighted_opportunity_deal_amount:
          is_active: false
        deals_fact.total_oppportunity_deal_amount:
          is_active: true
      series_text_format:
        deals_fact.total_weighted_opportunity_deal_amount:
          italic: true
      conditional_formatting: [{type: between, value: [0, 7], background_color: "#7bc739",
          font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
            custom: {id: e3400bbf-ab9f-faec-e711-615f78ba1468, label: Custom, type: continuous,
              stops: [{color: "#C4DF58", offset: 0}, {color: "#D13452", offset: 100}]},
            options: {steps: 5, constraints: {min: {type: minimum}, mid: {type: number,
                  value: 30}, max: {type: maximum}}, mirror: true, reverse: false,
              stepped: false}}, bold: false, italic: false, strikethrough: false,
          fields: []}, {type: between, value: [7, 14], background_color: "#E48522",
          font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
            palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830}, bold: false, italic: false,
          strikethrough: false, fields: []}, {type: greater than, value: 14, background_color: "#D13452",
          font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
            palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830}, bold: false, italic: false,
          strikethrough: false, fields: []}]
      series_value_format:
        deals_fact.total_oppportunity_deal_amount:
          name: gbp_0
          decimals: '0'
          format_string: '"£"#,##0'
          label: British Pounds (0)
          label_prefix: British Pounds
        deals_fact.total_weighted_opportunity_deal_amount:
          name: gbp_0
          decimals: '0'
          format_string: '"£"#,##0'
          label: British Pounds (0)
          label_prefix: British Pounds
      leftAxisLabelVisible: false
      leftAxisLabel: ''
      rightAxisLabelVisible: false
      rightAxisLabel: ''
      smoothedBars: false
      orientation: automatic
      labelPosition: left
      percentType: total
      percentPosition: hidden
      valuePosition: inline
      labelColorEnabled: false
      labelColor: "#FFF"
      x_axis_gridlines: false
      y_axis_gridlines: true
      y_axes: [{label: '', orientation: bottom, series: [{axisId: BridgeU - Ongoing
                Support - deals_fact.total_oppportunity_deal_amount, id: BridgeU -
                Ongoing Support - deals_fact.total_oppportunity_deal_amount, name: BridgeU
                - Ongoing Support}, {axisId: Drafthouse - GA4 to Snowflake Replication
                - deals_fact.total_oppportunity_deal_amount, id: Drafthouse - GA4
                to Snowflake Replication - deals_fact.total_oppportunity_deal_amount,
              name: Drafthouse - GA4 to Snowflake Replication}, {axisId: Jobandtalent
                - Analytics Enablement (Full Project) - deals_fact.total_oppportunity_deal_amount,
              id: Jobandtalent - Analytics Enablement (Full Project) - deals_fact.total_oppportunity_deal_amount,
              name: Jobandtalent - Analytics Enablement (Full Project)}, {axisId: Kaplan
                - Phase 2 - deals_fact.total_oppportunity_deal_amount, id: Kaplan
                - Phase 2 - deals_fact.total_oppportunity_deal_amount, name: Kaplan
                - Phase 2}, {axisId: Lucanet - Analytics Enablement - deals_fact.total_oppportunity_deal_amount,
              id: Lucanet - Analytics Enablement - deals_fact.total_oppportunity_deal_amount,
              name: Lucanet - Analytics Enablement}, {axisId: PollEverywhere - Analytics
                Enablement - deals_fact.total_oppportunity_deal_amount, id: PollEverywhere
                - Analytics Enablement - deals_fact.total_oppportunity_deal_amount,
              name: PollEverywhere - Analytics Enablement}, {axisId: Rixo - Create
                Smoke Test & Upgrade Sandbox Environments - deals_fact.total_oppportunity_deal_amount,
              id: Rixo - Create Smoke Test & Upgrade Sandbox Environments - deals_fact.total_oppportunity_deal_amount,
              name: Rixo - Create Smoke Test & Upgrade Sandbox Environments}, {axisId: Rixo
                - Follow-On Sprints (Placeholder) - deals_fact.total_oppportunity_deal_amount,
              id: Rixo - Follow-On Sprints (Placeholder) - deals_fact.total_oppportunity_deal_amount,
              name: Rixo - Follow-On Sprints (Placeholder)}, {axisId: Thrive Commercial
                Insights  - May 22 Extension - deals_fact.total_oppportunity_deal_amount,
              id: Thrive Commercial Insights  - May 22 Extension - deals_fact.total_oppportunity_deal_amount,
              name: Thrive Commercial Insights  - May 22 Extension}, {axisId: Thrive
                Investment Performance Part 2 - deals_fact.total_oppportunity_deal_amount,
              id: Thrive Investment Performance Part 2 - deals_fact.total_oppportunity_deal_amount,
              name: Thrive Investment Performance Part 2}, {axisId: Torticity - Data
                Modeling and Analytics Enablement - Discovery - deals_fact.total_oppportunity_deal_amount,
              id: Torticity - Data Modeling and Analytics Enablement - Discovery -
                deals_fact.total_oppportunity_deal_amount, name: Torticity - Data
                Modeling and Analytics Enablement - Discovery}, {axisId: 'Translucent
                - Sprint #2 - deals_fact.total_oppportunity_deal_amount', id: 'Translucent
                - Sprint #2 - deals_fact.total_oppportunity_deal_amount', name: 'Translucent
                - Sprint #2'}], showLabels: true, showValues: true, valueFormat: '"£"0,"K"',
          unpinAxis: false, tickDensity: custom, tickDensityCustom: 8, type: linear}]
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
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      x_axis_label_rotation: 0
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      isStepped: true
      font_size_main: ''
      style_deals_fact.count_oppportunity_deals: "#3B4245"
      show_title_deals_fact.count_oppportunity_deals: true
      title_overrride_deals_fact.count_oppportunity_deals: Open Opportunities
      title_placement_deals_fact.count_oppportunity_deals: below
      value_format_deals_fact.count_oppportunity_deals: ''
      style_deals_fact.total_oppportunity_deal_amount: "#3B4245"
      show_title_deals_fact.total_oppportunity_deal_amount: true
      title_overrride_deals_fact.total_oppportunity_deal_amount: Open Opportunity
        Value
      title_placement_deals_fact.total_oppportunity_deal_amount: below
      value_format_deals_fact.total_oppportunity_deal_amount: '"£"0,"K"'
      show_comparison_deals_fact.total_oppportunity_deal_amount: false
      style_deals_fact.total_weighted_opportunity_deal_amount: "#3B4245"
      show_title_deals_fact.total_weighted_opportunity_deal_amount: true
      title_overrride_deals_fact.total_weighted_opportunity_deal_amount: Weighted
        Value
      title_placement_deals_fact.total_weighted_opportunity_deal_amount: below
      value_format_deals_fact.total_weighted_opportunity_deal_amount: '"£"0,"K"'
      show_comparison_deals_fact.total_weighted_opportunity_deal_amount: false
      style_deals_fact.total_closed_in_delivery_deal_amount: "#3B4245"
      show_title_deals_fact.total_closed_in_delivery_deal_amount: true
      title_overrride_deals_fact.total_closed_in_delivery_deal_amount: In-Progress
        value
      title_placement_deals_fact.total_closed_in_delivery_deal_amount: below
      value_format_deals_fact.total_closed_in_delivery_deal_amount: '"£"0,"K"'
      show_comparison_deals_fact.total_closed_in_delivery_deal_amount: false
      style_deals_fact.count_closed_in_delivery_deals: "#3B4245"
      show_title_deals_fact.count_closed_in_delivery_deals: true
      title_overrride_deals_fact.count_closed_in_delivery_deals: Projects In-Progress
      title_placement_deals_fact.count_closed_in_delivery_deals: below
      value_format_deals_fact.count_closed_in_delivery_deals: ''
      show_comparison_deals_fact.count_closed_in_delivery_deals: false
      defaults_version: 1
      hidden_fields: [deals_fact.deal_pipeline_stage, deals_fact.total_oppportunity_deal_amount]
      hidden_points_if_no: []
    - model: analytics
      explore: targets
      type: table
      fields: [targets.period_month, targets.total_deals_closed_target]
      fill_fields: [targets.period_month]
      sorts: [targets.period_month desc]
      limit: 500
      join_fields:
      - field_name: targets.period_month
        source_field_name: deals_fact.deal_closed_month
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: deals_fact.total_oppportunity_deal_amount,
            id: deals_fact.total_oppportunity_deal_amount, name: Closed Amount}, {
            axisId: targets.total_deals_closed_target, id: targets.total_deals_closed_target,
            name: Target}], showLabels: false, showValues: true, maxValue: 500000,
        minValue: 0, valueFormat: '"£"0,"K"', unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
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
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '15'
    legend_position: center
    label_value_format: '"£"0,"K"'
    series_types:
      deals_fact.total_oppportunity_deal_amount: column
    point_style: none
    series_colors:
      deals_fact.total_oppportunity_deal_amount: "#D13452"
      targets.total_deals_closed_target: "#e0e0e0"
    series_labels:
      deals_fact.total_oppportunity_deal_amount: Closed Amount
      targets.total_deals_closed_target: Target
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    type: looker_line
    row: 9
    col: 8
    width: 8
    height: 8
  - title: Current Pipeline
    name: Current Pipeline
    model: analytics
    explore: companies_dim
    type: looker_grid
    fields: [deals_fact.pipeline_stage_label, deals_fact.deal_name, deals_fact.partner_referral,
      deals_fact.deal_pipeline_stage_date, deals_fact.deal_type, deals_fact.total_oppportunity_deal_amount,
      deals_fact.total_weighted_opportunity_deal_amount, deals_fact.count_oppportunity_deals,
      deals_fact.count_deals, deals_fact.deal_currency_code, deals_fact.number_of_sprints,
      deals_fact.owner_full_name, deals_fact.sprint_type]
    filters:
      deals_fact.pipeline_stage_label: Initial Enquiry & Sales Qualification,Project
        Scoping & Sales Qualified,Sprint Scoping & Delivery Qualification,Proposal
        Sent & Delivery Qualified
      companies_dim.company_name: "-Apex Auctions"
      deals_fact.deal_type: ''
      deals_fact.owner_full_name: ''
      deals_fact.partner_referral: ''
      deals_fact.sprint_type: ''
      deals_fact.deal_name: ''
    sorts: [deals_fact.total_oppportunity_deal_amount desc]
    limit: 500
    column_limit: 50
    total: true
    dynamic_fields: [{category: table_calculation, expression: 'diff_days(${deals_fact.deal_pipeline_stage_date},now())',
        label: Days in Deal Stage, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, table_calculation: days_in_deal_stage, _type_hint: number},
      {measure: days_in_pipeline_2, based_on: deals_fact.days_in_pipeline, type: sum,
        label: Days in Pipeline, expression: !!null '', value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: number}]
    show_view_names: false
    show_row_numbers: false
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
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
    show_sql_query_menu_options: false
    column_order: [deals_fact.deal_name, deals_fact.owner_full_name, deals_fact.pipeline_stage_label,
      deals_fact.sprint_type, deals_fact.deal_type, deals_fact.partner_referral, deals_fact.number_of_sprints,
      deals_fact.deal_currency_code, deals_fact.total_oppportunity_deal_amount, deals_fact.total_weighted_opportunity_deal_amount,
      deals_fact.deal_pipeline_stage_date, days_in_deal_stage]
    show_totals: true
    show_row_totals: true
    truncate_header: true
    series_labels:
      deals_fact.owner_full_name: Owner
      deals_fact.deal_type: Type
      deals_fact.pipeline_stage_label: Pipeline Stage
      days_in_pipeline_stage: Days In Stage
      days_in_pipeline: Days In Pipeline
      deals_fact.total_oppportunity_deal_amount: Amount
      deals_fact.total_weighted_opportunity_deal_amount: Weighted
      deals_fact.number_of_sprints: Sprints
      deals_fact.partner_referral: Partner
    series_cell_visualizations:
      deals_fact.total_weighted_opportunity_deal_amount:
        is_active: false
      deals_fact.total_oppportunity_deal_amount:
        is_active: true
    series_text_format:
      deals_fact.total_weighted_opportunity_deal_amount:
        italic: true
    conditional_formatting: [{type: between, value: [0, 7], background_color: "#7bc739",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          custom: {id: e3400bbf-ab9f-faec-e711-615f78ba1468, label: Custom, type: continuous,
            stops: [{color: "#C4DF58", offset: 0}, {color: "#D13452", offset: 100}]},
          options: {steps: 5, constraints: {min: {type: minimum}, mid: {type: number,
                value: 30}, max: {type: maximum}}, mirror: true, reverse: false, stepped: false}},
        bold: false, italic: false, strikethrough: false, fields: [days_in_deal_stage]},
      {type: between, value: [7, 14], background_color: "#E48522", font_color: !!null '',
        color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c, palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830},
        bold: false, italic: false, strikethrough: false, fields: [days_in_deal_stage]},
      {type: greater than, value: 14, background_color: "#D13452", font_color: !!null '',
        color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c, palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830},
        bold: false, italic: false, strikethrough: false, fields: [days_in_deal_stage]}]
    series_value_format:
      deals_fact.total_oppportunity_deal_amount:
        name: gbp_0
        decimals: '0'
        format_string: '"£"#,##0'
        label: British Pounds (0)
        label_prefix: British Pounds
      deals_fact.total_weighted_opportunity_deal_amount:
        name: gbp_0
        decimals: '0'
        format_string: '"£"#,##0'
        label: British Pounds (0)
        label_prefix: British Pounds
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    smoothedBars: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: hidden
    valuePosition: inline
    labelColorEnabled: false
    labelColor: "#FFF"
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axes: [{label: '', orientation: bottom, series: [{axisId: BridgeU - Ongoing
              Support - deals_fact.total_oppportunity_deal_amount, id: BridgeU - Ongoing
              Support - deals_fact.total_oppportunity_deal_amount, name: BridgeU -
              Ongoing Support}, {axisId: Drafthouse - GA4 to Snowflake Replication
              - deals_fact.total_oppportunity_deal_amount, id: Drafthouse - GA4 to
              Snowflake Replication - deals_fact.total_oppportunity_deal_amount, name: Drafthouse
              - GA4 to Snowflake Replication}, {axisId: Jobandtalent - Analytics Enablement
              (Full Project) - deals_fact.total_oppportunity_deal_amount, id: Jobandtalent
              - Analytics Enablement (Full Project) - deals_fact.total_oppportunity_deal_amount,
            name: Jobandtalent - Analytics Enablement (Full Project)}, {axisId: Kaplan
              - Phase 2 - deals_fact.total_oppportunity_deal_amount, id: Kaplan -
              Phase 2 - deals_fact.total_oppportunity_deal_amount, name: Kaplan -
              Phase 2}, {axisId: Lucanet - Analytics Enablement - deals_fact.total_oppportunity_deal_amount,
            id: Lucanet - Analytics Enablement - deals_fact.total_oppportunity_deal_amount,
            name: Lucanet - Analytics Enablement}, {axisId: PollEverywhere - Analytics
              Enablement - deals_fact.total_oppportunity_deal_amount, id: PollEverywhere
              - Analytics Enablement - deals_fact.total_oppportunity_deal_amount,
            name: PollEverywhere - Analytics Enablement}, {axisId: Rixo - Create Smoke
              Test & Upgrade Sandbox Environments - deals_fact.total_oppportunity_deal_amount,
            id: Rixo - Create Smoke Test & Upgrade Sandbox Environments - deals_fact.total_oppportunity_deal_amount,
            name: Rixo - Create Smoke Test & Upgrade Sandbox Environments}, {axisId: Rixo
              - Follow-On Sprints (Placeholder) - deals_fact.total_oppportunity_deal_amount,
            id: Rixo - Follow-On Sprints (Placeholder) - deals_fact.total_oppportunity_deal_amount,
            name: Rixo - Follow-On Sprints (Placeholder)}, {axisId: Thrive Commercial
              Insights  - May 22 Extension - deals_fact.total_oppportunity_deal_amount,
            id: Thrive Commercial Insights  - May 22 Extension - deals_fact.total_oppportunity_deal_amount,
            name: Thrive Commercial Insights  - May 22 Extension}, {axisId: Thrive
              Investment Performance Part 2 - deals_fact.total_oppportunity_deal_amount,
            id: Thrive Investment Performance Part 2 - deals_fact.total_oppportunity_deal_amount,
            name: Thrive Investment Performance Part 2}, {axisId: Torticity - Data
              Modeling and Analytics Enablement - Discovery - deals_fact.total_oppportunity_deal_amount,
            id: Torticity - Data Modeling and Analytics Enablement - Discovery - deals_fact.total_oppportunity_deal_amount,
            name: Torticity - Data Modeling and Analytics Enablement - Discovery},
          {axisId: 'Translucent - Sprint #2 - deals_fact.total_oppportunity_deal_amount',
            id: 'Translucent - Sprint #2 - deals_fact.total_oppportunity_deal_amount',
            name: 'Translucent - Sprint #2'}], showLabels: true, showValues: true,
        valueFormat: '"£"0,"K"', unpinAxis: false, tickDensity: custom, tickDensityCustom: 8,
        type: linear}]
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
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    x_axis_label_rotation: 0
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    isStepped: true
    font_size_main: ''
    style_deals_fact.count_oppportunity_deals: "#3B4245"
    show_title_deals_fact.count_oppportunity_deals: true
    title_overrride_deals_fact.count_oppportunity_deals: Open Opportunities
    title_placement_deals_fact.count_oppportunity_deals: below
    value_format_deals_fact.count_oppportunity_deals: ''
    style_deals_fact.total_oppportunity_deal_amount: "#3B4245"
    show_title_deals_fact.total_oppportunity_deal_amount: true
    title_overrride_deals_fact.total_oppportunity_deal_amount: Open Opportunity Value
    title_placement_deals_fact.total_oppportunity_deal_amount: below
    value_format_deals_fact.total_oppportunity_deal_amount: '"£"0,"K"'
    show_comparison_deals_fact.total_oppportunity_deal_amount: false
    style_deals_fact.total_weighted_opportunity_deal_amount: "#3B4245"
    show_title_deals_fact.total_weighted_opportunity_deal_amount: true
    title_overrride_deals_fact.total_weighted_opportunity_deal_amount: Weighted Value
    title_placement_deals_fact.total_weighted_opportunity_deal_amount: below
    value_format_deals_fact.total_weighted_opportunity_deal_amount: '"£"0,"K"'
    show_comparison_deals_fact.total_weighted_opportunity_deal_amount: false
    style_deals_fact.total_closed_in_delivery_deal_amount: "#3B4245"
    show_title_deals_fact.total_closed_in_delivery_deal_amount: true
    title_overrride_deals_fact.total_closed_in_delivery_deal_amount: In-Progress value
    title_placement_deals_fact.total_closed_in_delivery_deal_amount: below
    value_format_deals_fact.total_closed_in_delivery_deal_amount: '"£"0,"K"'
    show_comparison_deals_fact.total_closed_in_delivery_deal_amount: false
    style_deals_fact.count_closed_in_delivery_deals: "#3B4245"
    show_title_deals_fact.count_closed_in_delivery_deals: true
    title_overrride_deals_fact.count_closed_in_delivery_deals: Projects In-Progress
    title_placement_deals_fact.count_closed_in_delivery_deals: below
    value_format_deals_fact.count_closed_in_delivery_deals: ''
    show_comparison_deals_fact.count_closed_in_delivery_deals: false
    defaults_version: 1
    hidden_fields: [deals_fact.count_oppportunity_deals, deals_fact.deal_pipeline_stage,
      deals_fact.count_deals, deals_fact.sprint_type, deals_fact.deal_currency_code,
      deals_fact.deal_pipeline_stage_date]
    hidden_points_if_no: []
    listen: {}
    row: 17
    col: 0
    width: 24
    height: 8
  - title: Won Deals
    name: Won Deals (2)
    model: analytics
    explore: companies_dim
    type: looker_grid
    fields: [deals_fact.pipeline_stage_label, deals_fact.deal_name, deals_fact.partner_referral,
      deals_fact.deal_pipeline_stage_date, deals_fact.deal_type, deals_fact.total_oppportunity_deal_amount,
      deals_fact.total_weighted_opportunity_deal_amount, deals_fact.count_oppportunity_deals,
      deals_fact.count_deals, deals_fact.deal_currency_code, deals_fact.number_of_sprints,
      deals_fact.owner_full_name, deals_fact.sprint_type, deals_fact.deal_closed_date]
    filters:
      deals_fact.pipeline_stage_label: Won & Scheduled,Verbally Won & Working at Risk
      companies_dim.company_name: "-Apex Auctions"
      deals_fact.deal_pipeline_stage_date: 1 months
      deals_fact.deal_type: ''
      deals_fact.owner_full_name: ''
      deals_fact.partner_referral: ''
      deals_fact.sprint_type: ''
      deals_fact.deal_name: ''
    sorts: [deals_fact.total_oppportunity_deal_amount desc]
    limit: 500
    column_limit: 50
    total: true
    dynamic_fields: [{category: table_calculation, expression: 'diff_days(${deals_fact.deal_pipeline_stage_date},now())',
        label: Days in Deal Stage, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, table_calculation: days_in_deal_stage, _type_hint: number},
      {measure: days_in_pipeline_2, based_on: deals_fact.days_in_pipeline, type: sum,
        label: Days in Pipeline, expression: !!null '', value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: number}]
    show_view_names: false
    show_row_numbers: false
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
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
    show_sql_query_menu_options: false
    column_order: [deals_fact.deal_name, deals_fact.owner_full_name, deals_fact.pipeline_stage_label,
      deals_fact.deal_type, deals_fact.deal_closed_date, deals_fact.partner_referral,
      deals_fact.number_of_sprints, deals_fact.total_oppportunity_deal_amount, deals_fact.total_weighted_opportunity_deal_amount,
      days_in_deal_stage]
    show_totals: true
    show_row_totals: true
    truncate_header: true
    series_labels:
      deals_fact.owner_full_name: Owner
      deals_fact.deal_type: Type
      deals_fact.pipeline_stage_label: Pipeline Stage
      days_in_pipeline_stage: Days In Stage
      days_in_pipeline: Days In Pipeline
      deals_fact.total_oppportunity_deal_amount: Amount
      deals_fact.total_weighted_opportunity_deal_amount: Weighted
      deals_fact.number_of_sprints: Sprints
      deals_fact.partner_referral: Partner
    series_cell_visualizations:
      deals_fact.total_weighted_opportunity_deal_amount:
        is_active: false
      deals_fact.total_oppportunity_deal_amount:
        is_active: true
    series_text_format:
      deals_fact.total_weighted_opportunity_deal_amount:
        italic: true
    conditional_formatting: [{type: between, value: [0, 7], background_color: "#7bc739",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          custom: {id: e3400bbf-ab9f-faec-e711-615f78ba1468, label: Custom, type: continuous,
            stops: [{color: "#C4DF58", offset: 0}, {color: "#D13452", offset: 100}]},
          options: {steps: 5, constraints: {min: {type: minimum}, mid: {type: number,
                value: 30}, max: {type: maximum}}, mirror: true, reverse: false, stepped: false}},
        bold: false, italic: false, strikethrough: false, fields: [days_in_deal_stage]},
      {type: between, value: [7, 14], background_color: "#E48522", font_color: !!null '',
        color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c, palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830},
        bold: false, italic: false, strikethrough: false, fields: [days_in_deal_stage]},
      {type: greater than, value: 14, background_color: "#D13452", font_color: !!null '',
        color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c, palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830},
        bold: false, italic: false, strikethrough: false, fields: [days_in_deal_stage]}]
    series_value_format:
      deals_fact.total_oppportunity_deal_amount:
        name: gbp_0
        decimals: '0'
        format_string: '"£"#,##0'
        label: British Pounds (0)
        label_prefix: British Pounds
      deals_fact.total_weighted_opportunity_deal_amount:
        name: gbp_0
        decimals: '0'
        format_string: '"£"#,##0'
        label: British Pounds (0)
        label_prefix: British Pounds
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    smoothedBars: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: hidden
    valuePosition: inline
    labelColorEnabled: false
    labelColor: "#FFF"
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axes: [{label: '', orientation: bottom, series: [{axisId: BridgeU - Ongoing
              Support - deals_fact.total_oppportunity_deal_amount, id: BridgeU - Ongoing
              Support - deals_fact.total_oppportunity_deal_amount, name: BridgeU -
              Ongoing Support}, {axisId: Drafthouse - GA4 to Snowflake Replication
              - deals_fact.total_oppportunity_deal_amount, id: Drafthouse - GA4 to
              Snowflake Replication - deals_fact.total_oppportunity_deal_amount, name: Drafthouse
              - GA4 to Snowflake Replication}, {axisId: Jobandtalent - Analytics Enablement
              (Full Project) - deals_fact.total_oppportunity_deal_amount, id: Jobandtalent
              - Analytics Enablement (Full Project) - deals_fact.total_oppportunity_deal_amount,
            name: Jobandtalent - Analytics Enablement (Full Project)}, {axisId: Kaplan
              - Phase 2 - deals_fact.total_oppportunity_deal_amount, id: Kaplan -
              Phase 2 - deals_fact.total_oppportunity_deal_amount, name: Kaplan -
              Phase 2}, {axisId: Lucanet - Analytics Enablement - deals_fact.total_oppportunity_deal_amount,
            id: Lucanet - Analytics Enablement - deals_fact.total_oppportunity_deal_amount,
            name: Lucanet - Analytics Enablement}, {axisId: PollEverywhere - Analytics
              Enablement - deals_fact.total_oppportunity_deal_amount, id: PollEverywhere
              - Analytics Enablement - deals_fact.total_oppportunity_deal_amount,
            name: PollEverywhere - Analytics Enablement}, {axisId: Rixo - Create Smoke
              Test & Upgrade Sandbox Environments - deals_fact.total_oppportunity_deal_amount,
            id: Rixo - Create Smoke Test & Upgrade Sandbox Environments - deals_fact.total_oppportunity_deal_amount,
            name: Rixo - Create Smoke Test & Upgrade Sandbox Environments}, {axisId: Rixo
              - Follow-On Sprints (Placeholder) - deals_fact.total_oppportunity_deal_amount,
            id: Rixo - Follow-On Sprints (Placeholder) - deals_fact.total_oppportunity_deal_amount,
            name: Rixo - Follow-On Sprints (Placeholder)}, {axisId: Thrive Commercial
              Insights  - May 22 Extension - deals_fact.total_oppportunity_deal_amount,
            id: Thrive Commercial Insights  - May 22 Extension - deals_fact.total_oppportunity_deal_amount,
            name: Thrive Commercial Insights  - May 22 Extension}, {axisId: Thrive
              Investment Performance Part 2 - deals_fact.total_oppportunity_deal_amount,
            id: Thrive Investment Performance Part 2 - deals_fact.total_oppportunity_deal_amount,
            name: Thrive Investment Performance Part 2}, {axisId: Torticity - Data
              Modeling and Analytics Enablement - Discovery - deals_fact.total_oppportunity_deal_amount,
            id: Torticity - Data Modeling and Analytics Enablement - Discovery - deals_fact.total_oppportunity_deal_amount,
            name: Torticity - Data Modeling and Analytics Enablement - Discovery},
          {axisId: 'Translucent - Sprint #2 - deals_fact.total_oppportunity_deal_amount',
            id: 'Translucent - Sprint #2 - deals_fact.total_oppportunity_deal_amount',
            name: 'Translucent - Sprint #2'}], showLabels: true, showValues: true,
        valueFormat: '"£"0,"K"', unpinAxis: false, tickDensity: custom, tickDensityCustom: 8,
        type: linear}]
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
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    x_axis_label_rotation: 0
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    isStepped: true
    font_size_main: ''
    style_deals_fact.count_oppportunity_deals: "#3B4245"
    show_title_deals_fact.count_oppportunity_deals: true
    title_overrride_deals_fact.count_oppportunity_deals: Open Opportunities
    title_placement_deals_fact.count_oppportunity_deals: below
    value_format_deals_fact.count_oppportunity_deals: ''
    style_deals_fact.total_oppportunity_deal_amount: "#3B4245"
    show_title_deals_fact.total_oppportunity_deal_amount: true
    title_overrride_deals_fact.total_oppportunity_deal_amount: Open Opportunity Value
    title_placement_deals_fact.total_oppportunity_deal_amount: below
    value_format_deals_fact.total_oppportunity_deal_amount: '"£"0,"K"'
    show_comparison_deals_fact.total_oppportunity_deal_amount: false
    style_deals_fact.total_weighted_opportunity_deal_amount: "#3B4245"
    show_title_deals_fact.total_weighted_opportunity_deal_amount: true
    title_overrride_deals_fact.total_weighted_opportunity_deal_amount: Weighted Value
    title_placement_deals_fact.total_weighted_opportunity_deal_amount: below
    value_format_deals_fact.total_weighted_opportunity_deal_amount: '"£"0,"K"'
    show_comparison_deals_fact.total_weighted_opportunity_deal_amount: false
    style_deals_fact.total_closed_in_delivery_deal_amount: "#3B4245"
    show_title_deals_fact.total_closed_in_delivery_deal_amount: true
    title_overrride_deals_fact.total_closed_in_delivery_deal_amount: In-Progress value
    title_placement_deals_fact.total_closed_in_delivery_deal_amount: below
    value_format_deals_fact.total_closed_in_delivery_deal_amount: '"£"0,"K"'
    show_comparison_deals_fact.total_closed_in_delivery_deal_amount: false
    style_deals_fact.count_closed_in_delivery_deals: "#3B4245"
    show_title_deals_fact.count_closed_in_delivery_deals: true
    title_overrride_deals_fact.count_closed_in_delivery_deals: Projects In-Progress
    title_placement_deals_fact.count_closed_in_delivery_deals: below
    value_format_deals_fact.count_closed_in_delivery_deals: ''
    show_comparison_deals_fact.count_closed_in_delivery_deals: false
    defaults_version: 1
    hidden_fields: [deals_fact.count_oppportunity_deals, deals_fact.deal_pipeline_stage,
      deals_fact.count_deals, deals_fact.sprint_type, deals_fact.deal_currency_code,
      deals_fact.deal_pipeline_stage_date]
    hidden_points_if_no: []
    listen: {}
    row: 25
    col: 0
    width: 24
    height: 5
  - title: Retained Profit L12M
    name: Retained Profit L12M
    model: analytics
    explore: chart_of_accounts_dim
    type: looker_column
    fields: [profit_and_loss_report_fact.period_month, profit_and_loss_report_fact.amount]
    fill_fields: [profit_and_loss_report_fact.period_month]
    filters:
      profit_and_loss_report_fact.period_month: 12 months
    sorts: [profit_and_loss_report_fact.period_month desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: 'coalesce(pivot_index(${profit_and_loss_report_fact.amount},1),0)+coalesce(pivot_index(${profit_and_loss_report_fact.amount},2),0)+coalesce(pivot_index(${profit_and_loss_report_fact.amount},3),0)+coalesce(pivot_index(${profit_and_loss_report_fact.amount},4),0)+coalesce(pivot_index(${profit_and_loss_report_fact.amount},5),0)+coalesce(pivot_index(${profit_and_loss_report_fact.amount},6),0)+coalesce(pivot_index(${profit_and_loss_report_fact.amount},7),0)+coalesce(pivot_index(${profit_and_loss_report_fact.amount},8),0)+coalesce(pivot_index(${profit_and_loss_report_fact.amount},9),0)',
        label: Retained Income, value_format: !!null '', value_format_name: gbp_0,
        _kind_hint: supermeasure, table_calculation: retained_income, _type_hint: number,
        is_disabled: true}, {category: table_calculation, expression: 'sum(pivot_row(${profit_and_loss_report_fact.amount}))',
        label: 'Total ', value_format: '"£"0,"K"', value_format_name: __custom, _kind_hint: supermeasure,
        table_calculation: total, _type_hint: number, is_disabled: true}, {category: table_calculation,
        expression: 'pivot_index(${profit_and_loss_report_fact.amount},1)+pivot_index(${profit_and_loss_report_fact.amount},2)',
        label: Profit, value_format: !!null '', value_format_name: gbp_0, _kind_hint: supermeasure,
        table_calculation: profit, _type_hint: number, is_disabled: true}]
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
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: profit_and_loss_report_fact.amount,
            id: profit_and_loss_report_fact.amount, name: Amount}], showLabels: true,
        showValues: true, maxValue: !!null '', minValue: !!null '', valueFormat: '"£"0,"K"',
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    hidden_series: [Revenue - profit_and_loss_report_fact.amount, REVENUE - profit_and_loss_report_fact.amount]
    label_value_format: '"£"0,"K"'
    series_types: {}
    series_colors:
      total: "#7bc739"
      Cost of Delivery - profit_and_loss_report_fact.amount: "#D13452"
      Overheads - profit_and_loss_report_fact.amount: "#E48522"
      Revenue - profit_and_loss_report_fact.amount: "#69d6de"
      Taxation - profit_and_loss_report_fact.amount: "#CD9D6B"
      profit_and_loss_report_fact.account_report_category___null - profit_and_loss_report_fact.amount: "#c76273"
      Dividends - profit_and_loss_report_fact.amount: "#DFC858"
      profit: "#7bc739"
      EXPENSE - profit_and_loss_report_fact.amount: "#D13452"
    series_labels:
      total: Retained Earnings / Loss
      Cost of Delivery - profit_and_loss_report_fact.amount: Delivery Cost
      Overheads - profit_and_loss_report_fact.amount: Overheads
      profit_and_loss_report_fact.account_report_category___null - profit_and_loss_report_fact.amount: One-Offs
      EXPENSE - profit_and_loss_report_fact.amount: Costs
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen: {}
    row: 53
    col: 16
    width: 8
    height: 8
