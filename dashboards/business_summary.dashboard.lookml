- dashboard: business_summary_2022
  title: Business Summary 2022
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: ozZDN2fqLKhgMwiLNNw1zS
  elements:
  - name: Revenue vs Target L12M
    title: Revenue vs Target L12M
    merged_queries:
    - model: analytics
      explore: projects_delivered
      type: table
      fields: [projects_invoiced.invoice_month, projects_invoiced.total_net_amount_gbp]
      fill_fields: [projects_invoiced.invoice_month]
      filters:
        projects_invoiced.invoice_month: 12 months ago for 12 months
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
    series_types:
      targets.total_revenue_target: line
      projects_invoiced.total_net_amount_gbp: line
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
    type: looker_area
    column_limit: 50
    row: 26
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
    row: 57
    col: 8
    width: 8
    height: 6
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
    row: 57
    col: 16
    width: 8
    height: 6
  - title: Booked-In Revenue Pipeline
    name: Booked-In Revenue Pipeline
    model: analytics
    explore: companies_dim
    type: looker_grid
    fields: [companies_dim.company_name, projects_delivered.project_name, projects_invoiced.invoice_date,
      projects_invoiced.invoice_due_date, projects_invoiced.invoice_status, projects_invoiced.invoice_payment_term,
      projects_delivered.total_project_fee_amount, projects_delivered.project_delivery_start_ts_date,
      projects_delivered.project_delivery_end_ts_date, projects_delivered.project_fee_amount,
      projects_delivered.total_business_days_pct_elapsed, projects_delivered.project_delivery_start_ts_month]
    pivots: [projects_delivered.project_delivery_start_ts_month]
    fill_fields: [projects_delivered.project_delivery_start_ts_month]
    filters:
      companies_dim.company_name: "-%Rittman%,-%Colourpop%,-%Football Index%,-%RevenueRoll%"
      projects_invoiced.invoice_status: ''
      projects_delivered.project_code: "-QUB-013-002"
      projects_delivered.project_delivery_start_ts_month: after 0 minutes ago
      projects_delivered.project_fee_amount: ">0"
      projects_delivered.project_name: "-Project X-Ray : Initial Build Phase"
    sorts: [projects_delivered.project_delivery_start_ts_month, companies_dim.company_name
        desc]
    limit: 500
    column_limit: 50
    total: true
    show_view_names: false
    show_row_numbers: false
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
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: true
    series_labels:
      companies_dim.company_name: Client
      projects_delivered.project_delivery_start_ts_date: Start
      projects_delivered.project_name: Project
      projects_delivered.project_fee_amount: Amount
      projects_delivered.total_business_days_pct_elapsed: "% Elapsed"
      projects_delivered.total_project_fee_amount: Amount
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
    hidden_fields: [projects_invoiced.invoice_due_date, projects_invoiced.invoice_date,
      projects_invoiced.invoice_payment_term, projects_invoiced.invoice_status, projects_delivered.project_fee_amount,
      projects_delivered.project_delivery_end_ts_date, projects_delivered.project_delivery_start_ts_date,
      projects_delivered.total_business_days_pct_elapsed, companies_dim.company_name]
    listen: {}
    row: 26
    col: 16
    width: 8
    height: 9
  - title: Current Sales Pipeline
    name: Current Sales Pipeline
    model: analytics
    explore: companies_dim
    type: looker_grid
    fields: [companies_dim.company_name, deals_fact.deal_name, deals_fact.pipeline_stage_label,
      deals_fact.deal_type, deals_fact.partner_referral, deals_fact.deal_created_date,
      deals_fact.owner_full_name, deals_fact.deal_pipeline_stage_date, deals_fact.total_oppportunity_deal_amount,
      deals_fact.total_weighted_opportunity_deal_amount, deals_fact.count_oppportunity_deals]
    filters:
      deals_fact.pipeline_stage_label: Initial Enquiry,Meeting and Sales Qualified,Presentation
        Given & Sprints Scoped,Proposal Sent,PoC Underway,Deal Agreed & Awaiting Sign-off
      companies_dim.company_name: "-Apex Auctions"
    sorts: [deals_fact.total_oppportunity_deal_amount desc]
    limit: 500
    total: true
    dynamic_fields: [{table_calculation: days_in_pipeline, label: Days in Pipeline,
        expression: 'diff_days(${deals_fact.deal_created_date},now())', value_format: !!null '',
        value_format_name: !!null '', _kind_hint: dimension, _type_hint: number},
      {category: table_calculation, expression: 'diff_days(${deals_fact.deal_pipeline_stage_date},now())',
        label: Days in Pipeline Stage, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, table_calculation: days_in_pipeline_stage, _type_hint: number},
      {table_calculation: next_action, label: Next Action, expression: 'if(${days_in_pipeline}>60
          AND ${days_in_pipeline_stage}>30,"Review for blockers",if(${days_in_pipeline}>60
          AND ${days_in_pipeline_stage}>60,"Requalify Opportunity",if(${days_in_pipeline}>30
          AND ${days_in_pipeline_stage}>30,"Review and contact",if(${days_in_pipeline}>30
          AND ${days_in_pipeline_stage}<30,"Agree Deal and Close Business",if(${days_in_pipeline}<30
          AND ${days_in_pipeline_stage}<30,"Nurture Opportunity","Monitor")))))',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: string}, {measure: days_in_pipeline_2, based_on: deals_fact.days_in_pipeline,
        type: sum, label: Days in Pipeline, expression: !!null '', value_format: !!null '',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: number}]
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
    column_order: [deals_fact.deal_name, deals_fact.pipeline_stage_label, next_action,
      deals_fact.total_oppportunity_deal_amount, deals_fact.total_weighted_opportunity_deal_amount,
      days_in_pipeline]
    show_totals: true
    show_row_totals: true
    truncate_header: true
    series_labels:
      deals_fact.owner_full_name: Owner
      deals_fact.deal_type: Type
      deals_fact.pipeline_stage_label: Stage
      days_in_pipeline_stage: Days In Stage
      days_in_pipeline: Days In Pipeline
      deals_fact.total_oppportunity_deal_amount: Amount
      deals_fact.total_weighted_opportunity_deal_amount: Weighted
    series_cell_visualizations:
      deals_fact.total_weighted_opportunity_deal_amount:
        is_active: true
      deals_fact.total_oppportunity_deal_amount:
        is_active: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4A80BC",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1, options: {steps: 5, constraints: {
              min: {type: minimum}, mid: {type: number, value: 30}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [days_in_pipeline_stage, days_in_pipeline]}]
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    hidden_fields: [deals_fact.count_oppportunity_deals, deals_fact.deal_created_date,
      deals_fact.deal_pipeline_stage, companies_dim.company_name, deals_fact.deal_pipeline_stage_date,
      deals_fact.owner_full_name, deals_fact.deal_type, deals_fact.partner_referral,
      days_in_pipeline_stage]
    hidden_points_if_no: []
    listen: {}
    row: 18
    col: 16
    width: 8
    height: 7
  - name: New Deals vs Target L12M
    title: New Deals vs Target L12M
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: table
      fields: [deals_fact.deal_created_month, deals_fact.total_deal_amount_gbp_converted]
      fill_fields: [deals_fact.deal_created_month]
      filters:
        deals_fact.deal_created_month: 12 months
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
    series_labels:
      deals_fact.total_deal_amount_gbp_converted: Amount
      targets.total_deals_target: Target
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    type: looker_line
    column_limit: 50
    row: 18
    col: 0
    width: 8
    height: 7
  - name: Closed Deals vs Target L12M
    title: Closed Deals vs Target L12M
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: table
      fields: [deals_fact.deal_created_month, deals_fact.total_deal_amount_gbp_converted]
      fill_fields: [deals_fact.deal_created_month]
      filters:
        deals_fact.deal_created_month: 12 months
        deals_fact.deal_is_deleted: 'No'
        deals_fact.pipeline_stage_closed_won: 'Yes'
      sorts: [deals_fact.deal_created_month desc]
      limit: 500
      join_fields: []
    - model: analytics
      explore: targets
      type: table
      fields: [targets.period_month, targets.total_deals_closed_target]
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
    type: looker_line
    column_limit: 50
    row: 18
    col: 8
    width: 8
    height: 7
  - title: Client Profitability L3M
    name: Client Profitability L3M
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
        _kind_hint: measure, table_calculation: project_net_margin, _type_hint: number}]
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
      timesheet_project_costs_fact.total_cost_gbp]
    series_types: {}
    listen: {}
    row: 48
    col: 0
    width: 8
    height: 7
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
      profit_and_loss_report_fact.period_year: 12 months ago for 12 months
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
    row: 48
    col: 8
    width: 8
    height: 7
  - name: ''
    type: text
    title_text: ''
    body_text: |-
      <p align="center">

      <b><font color="DimGrey" size="5">Operations</font></b>

      </p>
    row: 46
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
    row: 36
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
    row: 55
    col: 0
    width: 24
    height: 2
  - title: Utilization Actual vs Forecast vs Target L12M
    name: Utilization Actual vs Forecast vs Target L12M
    model: analytics
    explore: contact_utilization_fact
    type: looker_line
    fields: [contact_utilization_fact.forecast_week, contact_utilization_fact.total_forecast_billable_hours,
      contact_utilization_fact.total_actual_billable_hours, contact_utilization_fact.total_target_billable_capacity,
      contact_utilization_fact.total_total_capacity]
    fill_fields: [contact_utilization_fact.forecast_week]
    filters:
      contact_utilization_fact.forecast_week: 2 months ago for 3 months
      staff_dim.contact_name: "-Toby Sexton"
      staff_dim.contact_is_contractor: 'No'
    sorts: [contact_utilization_fact.forecast_week desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: table_calculation, expression: "${contact_utilization_fact.total_target_billable_capacity}/${contact_utilization_fact.total_total_capacity}",
        label: Target Utilization, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: target_utilization, _type_hint: number},
      {category: table_calculation, expression: "${contact_utilization_fact.total_forecast_billable_hours}/${contact_utilization_fact.total_total_capacity}",
        label: Forecast Utilization, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: forecast_utilization, _type_hint: number},
      {category: table_calculation, expression: "${contact_utilization_fact.total_actual_billable_hours}/${contact_utilization_fact.total_total_capacity}",
        label: Actual Utilization, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: actual_utilization, _type_hint: number}]
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
    series_types: {}
    series_colors:
      target_utilization: "#8C3535"
      actual_utilization: "#519947"
      forecast_utilization: "#7AB7F4"
    series_labels: {}
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
    hidden_fields: [contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours,
      contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_total_capacity]
    hidden_points_if_no: []
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
    show_row_numbers: true
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
    label|contact_utilization_fact.average_time_off: "                  Time-Off"
    heading|contact_utilization_fact.average_time_off: ''
    style|contact_utilization_fact.average_time_off: normal
    reportIn|contact_utilization_fact.average_time_off: '1'
    unit|contact_utilization_fact.average_time_off: ''
    comparison|contact_utilization_fact.average_time_off: no_variance
    switch|contact_utilization_fact.average_time_off: false
    var_num|contact_utilization_fact.average_time_off: true
    var_pct|contact_utilization_fact.average_time_off: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    truncate_column_names: false
    listen: {}
    row: 57
    col: 0
    width: 8
    height: 6
  - title: Net Profit after Tax & Dividends
    name: Net Profit after Tax & Dividends
    model: analytics
    explore: chart_of_accounts_dim
    type: looker_line
    fields: [general_ledger_fact.net_amount, general_ledger_fact.journal_month]
    fill_fields: [general_ledger_fact.journal_month]
    filters:
      general_ledger_fact.journal_month: 12 months
      chart_of_accounts_dim.account_report_group: "-NULL"
    sorts: [general_ledger_fact.journal_month]
    limit: 500
    column_limit: 50
    total: true
    dynamic_fields: [{category: table_calculation, expression: "${general_ledger_fact.net_amount}*2",
        label: Amount, value_format: !!null '', value_format_name: gbp_0, _kind_hint: measure,
        table_calculation: amount, _type_hint: number, is_disabled: true}]
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
    series_types: {}
    series_labels: {}
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: []
    hidden_points_if_no: []
    theme: traditional
    layout: auto
    minWidthForIndexColumns: false
    headerFontSize: 14
    bodyFontSize: 12
    showTooltip: false
    showHighlight: false
    columnOrder: {}
    rowSubtotals: true
    colSubtotals: true
    spanRows: true
    spanCols: true
    sortColumnsBy: pivots
    useHeadings: false
    useShortName: false
    groupVarianceColumns: false
    indexColumn: false
    transposeTable: false
    hide|chart_of_accounts_dim.account_report_category: true
    hide|chart_of_accounts_dim.account_report_sub_category: true
    hide|chart_of_accounts_dim.account_report_group: true
    label|chart_of_accounts_dim.account_name: Account
    hide|chart_of_accounts_dim.account_name: false
    label|chart_of_accounts_dim.account_code: Code
    subtotalDepth: '2'
    label|general_ledger_fact.net_amount: ''
    heading|general_ledger_fact.net_amount: Net Amount
    style|general_ledger_fact.net_amount: normal
    reportIn|general_ledger_fact.net_amount: '1'
    comparison|general_ledger_fact.net_amount: general_ledger_fact.journal_month
    switch|general_ledger_fact.net_amount: false
    var_num|general_ledger_fact.net_amount: false
    defaults_version: 1
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
    column_order: ["$$$_row_numbers_$$$", chart_of_accounts_dim.account_report_category,
      chart_of_accounts_dim.account_code, chart_of_accounts_dim.account_name, 2020-10_general_ledger_fact.net_amount,
      2020-11_general_ledger_fact.net_amount, 2020-12_general_ledger_fact.net_amount,
      2021-01_general_ledger_fact.net_amount, 2021-02_general_ledger_fact.net_amount,
      2021-03_general_ledger_fact.net_amount, 2021-04_general_ledger_fact.net_amount,
      2021-05_general_ledger_fact.net_amount, 2021-06_general_ledger_fact.net_amount,
      2021-07_general_ledger_fact.net_amount, 2021-08_general_ledger_fact.net_amount,
      2021-09_general_ledger_fact.net_amount]
    listen: {}
    row: 48
    col: 16
    width: 8
    height: 7
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
    height: 7
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
    row: 71
    col: 8
    width: 8
    height: 7
  - title: Individual Utilization vs Target L4W
    name: Individual Utilization vs Target L4W
    model: analytics
    explore: contact_utilization_fact
    type: looker_bar
    fields: [contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours,
      contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_total_capacity,
      staff_dim.contact_name]
    filters:
      contact_utilization_fact.forecast_week: 1 month ago for 1 month
      staff_dim.contact_name: "-Toby Sexton"
      staff_dim.contact_is_contractor: 'No'
    sorts: [contact_utilization_fact.total_forecast_billable_hours desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: table_calculation, expression: "${contact_utilization_fact.total_target_billable_capacity}/${contact_utilization_fact.total_total_capacity}",
        label: Target Utilization, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: target_utilization, _type_hint: number},
      {category: table_calculation, expression: "${contact_utilization_fact.total_forecast_billable_hours}/${contact_utilization_fact.total_total_capacity}",
        label: Forecast Utilization, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: forecast_utilization, _type_hint: number},
      {category: table_calculation, expression: "${contact_utilization_fact.total_actual_billable_hours}/${contact_utilization_fact.total_total_capacity}",
        label: Actual Utilization, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: actual_utilization, _type_hint: number}]
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
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    font_size: '12'
    series_types: {}
    series_colors:
      target_utilization: "#D13452"
      actual_utilization: "#4A80BC"
      forecast_utilization: "#7AB7F4"
    series_labels: {}
    legend: 'off'
    label_value: 'on'
    center_value: 'off'
    color_range: ["#9E0041", "#C32F4B", "#E1514B", "#F47245", "#FB9F59", "#FEC574",
      "#FAE38C", "#EAF195", "#C7E89E", "#9CD6A4", "#6CC4A4", "#4D9DB4", "#4776B4",
      "#5E4EA1"]
    inner_circle_color: "#ffffff"
    text_color: "#000000"
    threshold: 0.2
    label_size: 10
    chart_size: 100%
    show_null_points: true
    interpolation: linear
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
    hidden_fields: [contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours,
      contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_total_capacity,
      forecast_utilization]
    hidden_points_if_no: []
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
    show_row_numbers: true
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
    label|contact_utilization_fact.average_time_off: "                  Time-Off"
    heading|contact_utilization_fact.average_time_off: ''
    style|contact_utilization_fact.average_time_off: normal
    reportIn|contact_utilization_fact.average_time_off: '1'
    unit|contact_utilization_fact.average_time_off: ''
    comparison|contact_utilization_fact.average_time_off: no_variance
    switch|contact_utilization_fact.average_time_off: false
    var_num|contact_utilization_fact.average_time_off: true
    var_pct|contact_utilization_fact.average_time_off: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
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
    defaults_version: 1
    truncate_column_names: false
    listen: {}
    row: 63
    col: 8
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
      projects_invoiced.invoice_month: 12 months ago for 12 months
    sorts: [companies_dim.company_name, projects_invoiced.invoice_month desc]
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
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    font_size: '12'
    series_types: {}
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 26
    col: 8
    width: 8
    height: 9
  - name: " (3)"
    type: text
    title_text: ''
    body_text: |-
      <p align="center">

      <b><font size="5">Revenue and Sales</font></b>

      </p>
    row: 16
    col: 0
    width: 24
    height: 2
  - type: button
    name: button_1441
    rich_content_json: '{"text":"View Deals in Hubspot","description":"View current
      deal board in Hubspot","newTab":true,"alignment":"center","size":"small","style":"OUTLINED","color":"#1A73E8","href":"https://app.hubspot.com/contacts/4402794/objects/0-3/views/all/board"}'
    row: 25
    col: 0
    width: 8
    height: 1
  - type: button
    name: button_1442
    rich_content_json: '{"text":"View Open Deals in Hubspot","description":"","newTab":true,"alignment":"center","size":"small","style":"OUTLINED","color":"#1A73E8","href":"https://app.hubspot.com/contacts/4402794/objects/0-3/views/2560409/board"}'
    row: 25
    col: 16
    width: 8
    height: 1
  - type: button
    name: button_1443
    rich_content_json: '{"text":"View Closed Deals in Hubspot","description":"","newTab":true,"alignment":"center","size":"small","style":"OUTLINED","color":"#1A73E8","href":"https://app.hubspot.com/contacts/4402794/objects/0-3/views/8745353/list"}'
    row: 25
    col: 8
    width: 8
    height: 1
  - type: button
    name: button_1444
    rich_content_json: '{"text":"View Active Projects in Harvest","description":"","newTab":true,"alignment":"center","size":"small","style":"OUTLINED","color":"#1A73E8","href":"https://rittman.harvestapp.com/projects?filter=active"}'
    row: 35
    col: 16
    width: 8
    height: 1
  - type: button
    name: button_1445
    rich_content_json: '{"text":"View Revenue by Client YTD in Xero","description":"","newTab":true,"alignment":"center","size":"small","style":"OUTLINED","color":"#1A73E8","href":"https://reporting.xero.com/!2r8Ny/v1/Run/1209"}'
    row: 35
    col: 8
    width: 8
    height: 1
  - type: button
    name: button_1446
    rich_content_json: '{"text":"View Revenue vs Target and Forecast in Google Sheets","description":"","newTab":true,"alignment":"center","size":"small","style":"OUTLINED","color":"#1A73E8","href":"https://docs.google.com/spreadsheets/d/1gAVDTqfxpzGN6OFbYqGTMwoBSckCE0yTC1J4YS65Z_4/edit#gid=0"}'
    row: 35
    col: 0
    width: 8
    height: 1
  - title: Monthly Attributed Share of Project Revenue L12M
    name: Monthly Attributed Share of Project Revenue L12M
    model: analytics
    explore: project_attribution
    type: looker_column
    fields: [staff_dim.contact_name, project_attribution.billing_month, project_attribution.attributed_revenue_gbp]
    pivots: [staff_dim.contact_name]
    fill_fields: [project_attribution.billing_month]
    filters:
      project_attribution.billing_month: 12 months ago for 12 months
    sorts: [staff_dim.contact_name, project_attribution.billing_month desc]
    limit: 500
    row_total: right
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
    hidden_series: []
    listen: {}
    row: 63
    col: 0
    width: 8
    height: 8
  - name: Individual 1mth vs 3mth Avg Attributed Revenue LM
    title: Individual 1mth vs 3mth Avg Attributed Revenue LM
    merged_queries:
    - model: analytics
      explore: project_attribution
      type: table
      fields: [staff_dim.contact_name, project_attribution.attributed_revenue_gbp]
      filters:
        project_attribution.billing_month: 3 months ago for 3 months
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
        project_attribution.billing_month: 1 months ago for 1 months
        staff_dim.contact_name: "-Mike Calleja,-Rob Bramwell,-Will Berrystone"
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
    row: 63
    col: 16
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
    row: 71
    col: 16
    width: 8
    height: 7
  - name: Closed Deals vs Target LM
    title: Closed Deals vs Target LM
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: table
      fields: [deals_fact.deal_created_month, deals_fact.total_deal_amount_gbp_converted]
      fill_fields: [deals_fact.deal_created_month]
      filters:
        deals_fact.deal_created_month: 2 months ago for 2 months
        deals_fact.deal_is_deleted: 'No'
        deals_fact.pipeline_stage_closed_won: 'Yes'
      sorts: [deals_fact.deal_created_month desc]
      limit: 500
      join_fields: []
    - model: analytics
      explore: targets
      type: table
      fields: [targets.period_month, targets.total_deals_closed_target]
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
    single_value_title: Closed Deals
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
    row: 3
    col: 0
    width: 4
    height: 5
  - name: Revenue vs Target LM
    title: Revenue vs Target LM
    merged_queries:
    - model: analytics
      explore: projects_delivered
      type: table
      fields: [projects_invoiced.invoice_month, projects_invoiced.total_net_amount_gbp]
      fill_fields: [projects_invoiced.invoice_month]
      filters:
        projects_invoiced.invoice_month: 2 months ago for 2 months
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
    single_value_title: Revenue
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
    row: 3
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
    single_value_title: eNPS
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
    row: 3
    col: 16
    width: 4
    height: 5
  - title: Certification Progress vs Target LM
    name: Certification Progress vs Target LM
    model: analytics
    explore: certification_progress
    type: single_value
    fields: [certification_progress.progress_month, certification_progress.score_target,
      certification_progress.total_score]
    fill_fields: [certification_progress.progress_month]
    filters:
      certification_progress.progress_month: 1 months ago for 1 months
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
      running_total_of_certification_progress_score_target_2, total_points, progress]
    series_types: {}
    listen: {}
    row: 3
    col: 20
    width: 4
    height: 5
  - title: Project On Time Delivery vs Target LM
    name: Project On Time Delivery vs Target LM
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
    row: 3
    col: 12
    width: 4
    height: 5
  - title: Actual Utilisation vs Target LM
    name: Actual Utilisation vs Target LM
    model: analytics
    explore: contact_utilization_fact
    type: single_value
    fields: [contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours,
      contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_total_capacity]
    filters:
      contact_utilization_fact.forecast_week: 1 months ago for 1 months
      staff_dim.contact_name: "-Toby Sexton"
      staff_dim.contact_is_contractor: 'No'
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: table_calculation, expression: "${contact_utilization_fact.total_actual_billable_hours}/${contact_utilization_fact.total_total_capacity}",
        label: Actual Utilization, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: actual_utilization, _type_hint: number},
      {category: table_calculation, expression: "${contact_utilization_fact.total_target_billable_capacity}/${contact_utilization_fact.total_total_capacity}",
        label: Target Utilization, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: target_utilization, _type_hint: number},
      {category: table_calculation, expression: "${contact_utilization_fact.total_forecast_billable_hours}/${contact_utilization_fact.total_total_capacity}",
        label: Forecast Utilization, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: forecast_utilization, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    series_types: {}
    series_colors:
      target_utilization: "#8C3535"
      actual_utilization: "#519947"
      forecast_utilization: "#7AB7F4"
    series_labels: {}
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
    hidden_fields: [contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours,
      contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_total_capacity,
      forecast_utilization]
    hidden_points_if_no: []
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
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    label|contact_utilization_fact.average_time_off: "                  Time-Off"
    heading|contact_utilization_fact.average_time_off: ''
    style|contact_utilization_fact.average_time_off: normal
    reportIn|contact_utilization_fact.average_time_off: '1'
    unit|contact_utilization_fact.average_time_off: ''
    comparison|contact_utilization_fact.average_time_off: no_variance
    switch|contact_utilization_fact.average_time_off: false
    var_num|contact_utilization_fact.average_time_off: true
    var_pct|contact_utilization_fact.average_time_off: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    truncate_column_names: false
    listen: {}
    row: 3
    col: 8
    width: 4
    height: 5
  - title: Client Billing L12M
    name: Client Billing L12M
    model: analytics
    explore: projects_delivered
    type: looker_grid
    fields: [projects_invoiced.total_gross_amount_gbp, companies_dim.company_name,
      projects_invoiced.invoice_month]
    pivots: [projects_invoiced.invoice_month]
    fill_fields: [projects_invoiced.invoice_month]
    filters:
      projects_invoiced.first_invoice_year: 24 months ago for 24 months
      projects_invoiced.invoice_date: 12 months ago for 12 months
      projects_invoiced.months_since_first_invoice: "<=12"
    sorts: [projects_invoiced.invoice_month, companies_dim.company_name]
    limit: 500
    column_limit: 50
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
    truncate_header: false
    series_cell_visualizations:
      projects_invoiced.total_gross_amount_gbp:
        is_active: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 95584bf9-c29e-41ea-b6e7-79e9c126e177, options: {steps: 5}},
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
    show_null_points: false
    interpolation: linear
    defaults_version: 1
    hidden_fields: [running_total_of_invoices_total_gross_amount_gbp]
    listen: {}
    row: 36
    col: 0
    width: 16
    height: 10
  - name: Overall Company Performance L12M
    title: Overall Company Performance L12M
    note_state: collapsed
    note_display: above
    note_text: Weighted Overall Performance of the Business based on Kaplan/Norton
      Balanced Scorecard Approach
    merged_queries:
    - model: analytics
      explore: contact_utilization_fact
      type: single_value
      fields: [contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours,
        contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_total_capacity,
        contact_utilization_fact.forecast_month]
      fill_fields: [contact_utilization_fact.forecast_month]
      filters:
        contact_utilization_fact.forecast_week: 12 months ago for 12 months
        staff_dim.contact_name: "-Toby Sexton"
        staff_dim.contact_is_contractor: 'No'
      sorts: [contact_utilization_fact.forecast_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields: [{category: table_calculation, expression: "${contact_utilization_fact.total_actual_billable_hours}/${contact_utilization_fact.total_total_capacity}",
          label: Actual Utilization, value_format: !!null '', value_format_name: percent_0,
          _kind_hint: measure, table_calculation: actual_utilization, _type_hint: number},
        {category: table_calculation, expression: "${contact_utilization_fact.total_target_billable_capacity}/${contact_utilization_fact.total_total_capacity}",
          label: Target Utilization, value_format: !!null '', value_format_name: percent_0,
          _kind_hint: measure, table_calculation: target_utilization, _type_hint: number},
        {category: table_calculation, expression: "${contact_utilization_fact.total_forecast_billable_hours}/${contact_utilization_fact.total_total_capacity}",
          label: Forecast Utilization, value_format: !!null '', value_format_name: percent_0,
          _kind_hint: measure, table_calculation: forecast_utilization, _type_hint: number}]
      custom_color_enabled: true
      show_single_value_title: true
      show_comparison: true
      comparison_type: progress_percentage
      comparison_reverse_colors: false
      show_comparison_label: true
      enable_conditional_formatting: false
      conditional_formatting_include_totals: false
      conditional_formatting_include_nulls: false
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
      series_types: {}
      series_colors:
        target_utilization: "#8C3535"
        actual_utilization: "#519947"
        forecast_utilization: "#7AB7F4"
      series_labels: {}
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
      hidden_fields: [contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours,
        contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_total_capacity,
        forecast_utilization]
      hidden_points_if_no: []
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
      show_row_numbers: true
      transpose: false
      truncate_text: true
      hide_totals: false
      hide_row_totals: false
      size_to_fit: true
      table_theme: white
      header_text_alignment: left
      header_font_size: '12'
      rows_font_size: '12'
      label|contact_utilization_fact.average_time_off: "                  Time-Off"
      heading|contact_utilization_fact.average_time_off: ''
      style|contact_utilization_fact.average_time_off: normal
      reportIn|contact_utilization_fact.average_time_off: '1'
      unit|contact_utilization_fact.average_time_off: ''
      comparison|contact_utilization_fact.average_time_off: no_variance
      switch|contact_utilization_fact.average_time_off: false
      var_num|contact_utilization_fact.average_time_off: true
      var_pct|contact_utilization_fact.average_time_off: false
      show_sql_query_menu_options: false
      show_totals: true
      show_row_totals: true
      truncate_header: false
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
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      defaults_version: 1
      truncate_column_names: false
    - model: analytics
      explore: projects_delivered
      type: table
      fields: [projects_delivered_is_ontime.count_ontime_timesheet_projects, projects_delivered.count_timesheet_projects,
        projects_delivered.project_delivery_end_ts_month]
      fill_fields: [projects_delivered.project_delivery_end_ts_month]
      filters:
        projects_delivered.project_is_billable: 'Yes'
      sorts: [projects_delivered.project_delivery_end_ts_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields: [{category: table_calculation, expression: "${projects_delivered_is_ontime.count_ontime_timesheet_projects}/${projects_delivered.count_timesheet_projects}",
          label: "% of Projects Ontime", value_format: !!null '', value_format_name: percent_0,
          _kind_hint: measure, table_calculation: of_projects_ontime, _type_hint: number},
        {category: table_calculation, expression: '0.9', label: Target % of Projects
            Ontime, value_format: !!null '', value_format_name: percent_0, _kind_hint: dimension,
          table_calculation: target_of_projects_ontime, _type_hint: number}]
      hidden_fields: [projects_delivered_is_ontime.count_ontime_timesheet_projects,
        projects_delivered.count_timesheet_projects]
      join_fields:
      - field_name: projects_delivered.project_delivery_end_ts_month
        source_field_name: contact_utilization_fact.forecast_month
    - model: analytics
      explore: targets
      type: table
      fields: [targets.period_month, targets.total_revenue_target, targets.total_deals_closed_target,
        targets.avg_hr_survey_target, targets.avg_enps_target]
      fill_fields: [targets.period_month]
      limit: 500
      join_fields:
      - field_name: targets.period_month
        source_field_name: contact_utilization_fact.forecast_month
    - model: analytics
      explore: companies_dim
      type: table
      fields: [deals_fact.total_deal_amount_gbp_converted, deals_fact.deal_created_month]
      fill_fields: [deals_fact.deal_created_month]
      filters:
        deals_fact.pipeline_stage_closed_won: 'Yes'
      sorts: [deals_fact.deal_created_month]
      limit: 500
      join_fields:
      - field_name: deals_fact.deal_created_month
        source_field_name: contact_utilization_fact.forecast_month
    - model: analytics
      explore: projects_delivered
      type: table
      fields: [projects_invoiced.invoice_month, projects_invoiced.total_net_amount_gbp]
      fill_fields: [projects_invoiced.invoice_month]
      limit: 500
      join_fields:
      - field_name: projects_invoiced.invoice_month
        source_field_name: contact_utilization_fact.forecast_month
    - model: analytics
      explore: hr_survey_results_fact
      type: table
      fields: [hr_survey_results_fact.survey_ts_month, hr_survey_results_fact.avg_e_nps]
      fill_fields: [hr_survey_results_fact.survey_ts_month]
      limit: 500
      join_fields:
      - field_name: hr_survey_results_fact.survey_ts_month
        source_field_name: contact_utilization_fact.forecast_month
    - model: analytics
      explore: certification_progress
      type: table
      fields: [certification_progress.progress_month, certification_progress.total_score,
        certification_progress.score_target]
      fill_fields: [certification_progress.progress_month]
      sorts: [certification_progress.progress_month desc]
      limit: 500
      join_fields:
      - field_name: certification_progress.progress_month
        source_field_name: contact_utilization_fact.forecast_month
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
        reverse: false
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
    hidden_series: [pct_certification_progression_to_target, pct_of_utilization_to_target]
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      innovation_learning_perspective_weighted_20: "#E48522"
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: right, color: "#d03452",
        line_value: '1', label: Target}]
    show_null_points: true
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", contact_utilization_fact.forecast_month,
      weighted_performance, pct_of_utilization_to_target, pct_enps_to_target, pct_certification_progression_to_target]
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4A80BC",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 95584bf9-c29e-41ea-b6e7-79e9c126e177, options: {steps: 5}},
        bold: false, italic: false, strikethrough: false, fields: []}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    font_size_main: ''
    show_comparison_deals_fact.total_deal_amount_gbp_converted: false
    comparison_style_deals_fact.total_deal_amount_gbp_converted: value
    comparison_show_label_deals_fact.total_deal_amount_gbp_converted: true
    comparison_label_placement_deals_fact.total_deal_amount_gbp_converted: below
    show_comparison_of_projects_ontime: false
    comparison_style_of_projects_ontime: value
    comparison_show_label_of_projects_ontime: true
    comparison_label_placement_of_projects_ontime: below
    show_comparison_targets.total_revenue_target: true
    comparison_style_targets.total_revenue_target: value
    comparison_show_label_targets.total_revenue_target: true
    comparison_label_placement_targets.total_revenue_target: below
    show_comparison_targets.total_deals_closed_target: true
    comparison_style_targets.total_deals_closed_target: value
    comparison_show_label_targets.total_deals_closed_target: true
    comparison_label_placement_targets.total_deals_closed_target: below
    show_comparison_targets.avg_enps_target: true
    comparison_style_targets.avg_enps_target: value
    comparison_show_label_targets.avg_enps_target: true
    comparison_label_placement_targets.avg_enps_target: below
    show_comparison_certification_progress.score_target: true
    comparison_style_certification_progress.score_target: value
    comparison_show_label_certification_progress.score_target: true
    comparison_label_placement_certification_progress.score_target: below
    show_title_of_projects_ontime: false
    hidden_fields: [contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours,
      contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_total_capacity,
      actual_utilization, forecast_utilization, projects_delivered_is_ontime.count_ontime_timesheet_projects,
      projects_delivered.count_timesheet_projects, targets.avg_hr_survey_target, of_projects_ontime,
      targets.total_revenue_target, targets.avg_enps_target, projects_invoiced.total_net_amount_gbp,
      hr_survey_results_fact.avg_e_nps, certification_progress.total_score, certification_progress.score_target,
      target_utilization, deals_fact.total_deal_amount_gbp_converted, targets.total_deals_closed_target,
      target_of_projects_ontime, new_deals_pct_to_target, revenue_pct_to_target, pct_of_projects_ontime_to_target,
      pct_certification_progression_to_target, pct_of_utilization_to_target, pct_enps_to_target,
      financial_weighted_50, process_customer_perspective_weighted_30, innovation_learning_perspective_weighted_20]
    type: looker_line
    query_fields:
      measures:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Utilization        Total Forecast Billable Hours
        label_from_parameter:
        label_short: "       Total Forecast Billable Hours"
        map_layer:
        name: contact_utilization_fact.total_forecast_billable_hours
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0.00"
        view: contact_utilization_fact
        view_label: Utilization
        dynamic: false
        week_start_day: monday
        original_view: contact_utilization_fact
        dimension_group:
        error:
        field_group_variant: "       Total Forecast Billable Hours"
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: contact_utilization_fact
        suggest_dimension: contact_utilization_fact.total_forecast_billable_hours
        suggest_explore: contact_utilization_fact
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fcontact_utilization_fact.view.lkml?line=89"
        permanent: true
        source_file: views/contact_utilization_fact.view.lkml
        source_file_path: analytics/views/contact_utilization_fact.view.lkml
        sql: "${forecast_billable_hours} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Utilization     Total Actual Billable Hours
        label_from_parameter:
        label_short: "    Total Actual Billable Hours"
        map_layer:
        name: contact_utilization_fact.total_actual_billable_hours
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        view: contact_utilization_fact
        view_label: Utilization
        dynamic: false
        week_start_day: monday
        original_view: contact_utilization_fact
        dimension_group:
        error:
        field_group_variant: "    Total Actual Billable Hours"
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: contact_utilization_fact
        suggest_dimension: contact_utilization_fact.total_actual_billable_hours
        suggest_explore: contact_utilization_fact
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fcontact_utilization_fact.view.lkml?line=34"
        permanent: true
        source_file: views/contact_utilization_fact.view.lkml
        source_file_path: analytics/views/contact_utilization_fact.view.lkml
        sql: "${actual_billable_hours} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Utilization          Total Target Billable Capacity
        label_from_parameter:
        label_short: "         Total Target Billable Capacity"
        map_layer:
        name: contact_utilization_fact.total_target_billable_capacity
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        view: contact_utilization_fact
        view_label: Utilization
        dynamic: false
        week_start_day: monday
        original_view: contact_utilization_fact
        dimension_group:
        error:
        field_group_variant: "         Total Target Billable Capacity"
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: contact_utilization_fact
        suggest_dimension: contact_utilization_fact.total_target_billable_capacity
        suggest_explore: contact_utilization_fact
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fcontact_utilization_fact.view.lkml?line=169"
        permanent: true
        source_file: views/contact_utilization_fact.view.lkml
        source_file_path: analytics/views/contact_utilization_fact.view.lkml
        sql: "${target_billable_capacity} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Utilization            Total Total Capacity
        label_from_parameter:
        label_short: "           Total Total Capacity"
        map_layer:
        name: contact_utilization_fact.total_total_capacity
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        view: contact_utilization_fact
        view_label: Utilization
        dynamic: false
        week_start_day: monday
        original_view: contact_utilization_fact
        dimension_group:
        error:
        field_group_variant: "           Total Total Capacity"
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: contact_utilization_fact
        suggest_dimension: contact_utilization_fact.total_total_capacity
        suggest_explore: contact_utilization_fact
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fcontact_utilization_fact.view.lkml?line=249"
        permanent: true
        source_file: views/contact_utilization_fact.view.lkml
        source_file_path: analytics/views/contact_utilization_fact.view.lkml
        sql: "${total_capacity} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - type: number
        align: right
        measure: true
        dynamic: false
        can_pivot: true
        is_numeric: true
        name: actual_utilization
        label: Actual Utilization
        value_format: "#,##0%"
        is_disabled:
        sortable: true
        aggregate: true
        can_filter: false
        permanent: true
      - type: number
        align: right
        measure: true
        dynamic: false
        can_pivot: true
        is_numeric: true
        name: target_utilization
        label: Target Utilization
        value_format: "#,##0%"
        is_disabled:
        sortable: true
        aggregate: true
        can_filter: false
        permanent: true
      - type: number
        align: right
        measure: true
        dynamic: false
        can_pivot: true
        is_numeric: true
        name: forecast_utilization
        label: Forecast Utilization
        value_format: "#,##0%"
        is_disabled:
        sortable: true
        aggregate: true
        can_filter: false
        permanent: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: "         Projects Count Ontime Timesheet Projects"
        label_from_parameter:
        label_short: Count Ontime Timesheet Projects
        map_layer:
        name: projects_delivered_is_ontime.count_ontime_timesheet_projects
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: count_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format:
        view: projects_delivered_is_ontime
        view_label: "         Projects"
        dynamic: false
        week_start_day: monday
        original_view: projects_delivered_is_ontime
        dimension_group:
        error:
        field_group_variant: Count Ontime Timesheet Projects
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: projects_delivered_is_ontime
        suggest_dimension: projects_delivered_is_ontime.count_ontime_timesheet_projects
        suggest_explore: projects_delivered
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fprojects_delivered_is_ontime.view.lkml?line=61"
        permanent: true
        source_file: views/projects_delivered_is_ontime.view.lkml
        source_file_path: analytics/views/projects_delivered_is_ontime.view.lkml
        sql: "${timesheet_project_pk} "
        sql_case:
        filters:
        - field: projects_delivered_is_ontime.is_ontime_project
          condition: 'Yes'
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: "         Projects Count Timesheet Projects"
        label_from_parameter:
        label_short: Count Timesheet Projects
        map_layer:
        name: projects_delivered.count_timesheet_projects
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: count_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format:
        view: projects_delivered
        view_label: "         Projects"
        dynamic: false
        week_start_day: monday
        original_view: timesheet_projects_dim
        dimension_group:
        error:
        field_group_variant: Count Timesheet Projects
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: projects_delivered
        suggest_dimension: projects_delivered.count_timesheet_projects
        suggest_explore: projects_delivered
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftimesheet_projects_dim.view.lkml?line=178"
        permanent: true
        source_file: views/timesheet_projects_dim.view.lkml
        source_file_path: analytics/views/timesheet_projects_dim.view.lkml
        sql: "${TABLE}.timesheet_project_pk "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - type: number
        align: right
        measure: true
        dynamic: false
        can_pivot: true
        is_numeric: true
        name: of_projects_ontime
        label: "% of Projects Ontime"
        value_format: "#,##0%"
        is_disabled:
        sortable: true
        aggregate: true
        can_filter: false
        permanent: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Targets Total Revenue Target
        label_from_parameter:
        label_short: Total Revenue Target
        map_layer:
        name: targets.total_revenue_target
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0.00'
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Total Revenue Target
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.total_revenue_target
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=56"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${revenue_target} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Targets Total Deals Closed Target
        label_from_parameter:
        label_short: Total Deals Closed Target
        map_layer:
        name: targets.total_deals_closed_target
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0.00'
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Total Deals Closed Target
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.total_deals_closed_target
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=63"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${deals_closed_target} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Targets Avg Hr Survey Target
        label_from_parameter:
        label_short: Avg Hr Survey Target
        map_layer:
        name: targets.avg_hr_survey_target
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: average
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0.00"
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Avg Hr Survey Target
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.avg_hr_survey_target
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=82"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${hr_survey_target} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Targets Avg Enps Target
        label_from_parameter:
        label_short: Avg Enps Target
        map_layer:
        name: targets.avg_enps_target
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: average
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0.00"
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Avg Enps Target
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.avg_enps_target
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=76"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${enps_target} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label: Deals fact  Measures
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: "     Sales (Hubspot) Total Deal Amount GBP"
        label_from_parameter:
        label_short: Total Deal Amount GBP
        map_layer:
        name: deals_fact.total_deal_amount_gbp_converted
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0.00'
        view: deals_fact
        view_label: "     Sales (Hubspot)"
        dynamic: false
        week_start_day: monday
        original_view: deals_fact
        dimension_group:
        error:
        field_group_variant: Total Deal Amount GBP
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: deals_fact
        suggest_dimension: deals_fact.total_deal_amount_gbp_converted
        suggest_explore: companies_dim
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fdeals_fact.view.lkml?line=26"
        permanent: true
        source_file: views/deals_fact.view.lkml
        source_file_path: analytics/views/deals_fact.view.lkml
        sql: "CASE\n         when ${TABLE}.deal_currency_code = 'USD' then ${TABLE}.deal_amount\
          \ * .75\n         when ${TABLE}.deal_currency_code = 'CAD' then ${TABLE}.deal_amount\
          \ * .58\n         when ${TABLE}.deal_currency_code = 'EUR' then ${TABLE}.deal_amount\
          \ * 0.90\n         else ${TABLE}.deal_amount end "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label: Reporting
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: "   Invoices Total Net Amount Gbp"
        label_from_parameter:
        label_short: Total Net Amount Gbp
        map_layer:
        name: projects_invoiced.total_net_amount_gbp
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        view: projects_invoiced
        view_label: "   Invoices"
        dynamic: false
        week_start_day: monday
        original_view: invoices_fact
        dimension_group:
        error:
        field_group_variant: Total Net Amount Gbp
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: projects_invoiced
        suggest_dimension: projects_invoiced.total_net_amount_gbp
        suggest_explore: projects_delivered
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Finvoices_fact.view.lkml?line=555"
        permanent: true
        source_file: views/invoices_fact.view.lkml
        source_file_path: analytics/views/invoices_fact.view.lkml
        sql: "${invoice_gbp_amount} - coalesce(${invoice_gbp_tax_amount},0)"
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Staff Satisfaction Avg E Nps
        label_from_parameter:
        label_short: Avg E Nps
        map_layer:
        name: hr_survey_results_fact.avg_e_nps
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: average
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0.00"
        view: hr_survey_results_fact
        view_label: Staff Satisfaction
        dynamic: false
        week_start_day: monday
        original_view: hr_survey_results_fact
        dimension_group:
        error:
        field_group_variant: Avg E Nps
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: hr_survey_results_fact
        suggest_dimension: hr_survey_results_fact.avg_e_nps
        suggest_explore: hr_survey_results_fact
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fhr_survey_results_fact.view.lkml?line=132"
        permanent: true
        source_file: views/hr_survey_results_fact.view.lkml
        source_file_path: analytics/views/hr_survey_results_fact.view.lkml
        sql: "${TABLE}.e_nps "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Certification Progress Total Score
        label_from_parameter:
        label_short: Total Score
        map_layer:
        name: certification_progress.total_score
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format:
        view: certification_progress
        view_label: Certification Progress
        dynamic: false
        week_start_day: monday
        original_view: certification_progress
        dimension_group:
        error:
        field_group_variant: Total Score
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: certification_progress
        suggest_dimension: certification_progress.total_score
        suggest_explore: certification_progress
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fcertification_progress.view.lkml?line=38"
        permanent: true
        source_file: views/certification_progress.view.lkml
        source_file_path: analytics/views/certification_progress.view.lkml
        sql: "${score} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Certification Progress Score Target
        label_from_parameter:
        label_short: Score Target
        map_layer:
        name: certification_progress.score_target
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: average
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format:
        view: certification_progress
        view_label: Certification Progress
        dynamic: false
        week_start_day: monday
        original_view: certification_progress
        dimension_group:
        error:
        field_group_variant: Score Target
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: certification_progress
        suggest_dimension: certification_progress.score_target
        suggest_explore: certification_progress
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fcertification_progress.view.lkml?line=43"
        permanent: true
        source_file: views/certification_progress.view.lkml
        source_file_path: analytics/views/certification_progress.view.lkml
        sql: "${target} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      dimensions:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        enumerations:
        field_group_label: "               Forecast Date"
        fill_style: range
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: false
        label: Utilization                Forecast Month
        label_from_parameter:
        label_short: "               Forecast Month"
        map_layer:
        name: contact_utilization_fact.forecast_month
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: date_month
        user_attribute_filter_types:
        - datetime
        - advanced_filter_datetime
        value_format:
        view: contact_utilization_fact
        view_label: Utilization
        dynamic: false
        week_start_day: monday
        original_view: contact_utilization_fact
        dimension_group: contact_utilization_fact.forecast
        error:
        field_group_variant: Month
        measure: false
        parameter: false
        primary_key: false
        project_name: analytics
        scope: contact_utilization_fact
        suggest_dimension: contact_utilization_fact.forecast_month
        suggest_explore: contact_utilization_fact
        suggestable: false
        is_fiscal: false
        is_timeframe: true
        can_time_filter: false
        time_interval:
          name: month
          count: 1
        lookml_link: "/projects/analytics/files/views%2Fcontact_utilization_fact.view.lkml?line=101"
        permanent: true
        source_file: views/contact_utilization_fact.view.lkml
        source_file_path: analytics/views/contact_utilization_fact.view.lkml
        sql: "${TABLE}.forecast_week "
        sql_case:
        filters:
        times_used: 0
        sorted:
          sort_index: 0
          desc: true
      - type: number
        align: right
        measure: false
        dynamic: false
        can_pivot: false
        is_numeric: true
        name: target_of_projects_ontime
        label: Target % of Projects Ontime
        value_format: "#,##0%"
        is_disabled:
        sortable: true
        aggregate: true
        can_filter: false
        permanent: true
      table_calculations:
      - label: New Deals Pct to Target
        name: new_deals_pct_to_target
        expression: coalesce(${deals_fact.total_deal_amount_gbp_converted}/${targets.total_deals_closed_target},0)
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Revenue Pct to Target
        name: revenue_pct_to_target
        expression: "${projects_invoiced.total_net_amount_gbp}/${targets.total_revenue_target}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Pct of Projects Ontime to Target
        name: pct_of_projects_ontime_to_target
        expression: "${of_projects_ontime}/${target_of_projects_ontime}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Pct of Utilization % to Target
        name: pct_of_utilization_to_target
        expression: "${actual_utilization}/${target_utilization}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Pct eNPS to Target
        name: pct_enps_to_target
        expression: "${hr_survey_results_fact.avg_e_nps}/${targets.avg_enps_target}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Pct Certification Progression to Target
        name: pct_certification_progression_to_target
        expression: "${certification_progress.total_score}/${certification_progress.score_target}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Weighted Team %
        name: weighted_team
        expression: "((${pct_enps_to_target}*0.5)+(${pct_certification_progression_to_target}*0.5)*0.2)"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Weighted Revenue %
        name: weighted_revenue
        expression: "((${new_deals_pct_to_target}*0.5)+(${revenue_pct_to_target}*0.5)*0.5)"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Weighted Delivery %
        name: weighted_delivery
        expression: "((${pct_of_projects_ontime_to_target}*0.5)+(${pct_of_utilization_to_target}*0.5)*0.3)"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Weighted Performance %
        name: weighted_performance
        expression: if(is_null(${weighted_team}),(${weighted_revenue}+${weighted_delivery})/8*10,${weighted_revenue}+${weighted_revenue}+${weighted_team})
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      pivots: []
    dynamic_fields: [{category: table_calculation, expression: 'coalesce(${deals_fact.total_deal_amount_gbp_converted}/${targets.total_deals_closed_target},0)',
        label: New Deals Pct to Target, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: new_deals_pct_to_target, _type_hint: number},
      {category: table_calculation, expression: "${projects_invoiced.total_net_amount_gbp}/${targets.total_revenue_target}",
        label: Revenue Pct to Target, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: revenue_pct_to_target, _type_hint: number},
      {category: table_calculation, expression: "${of_projects_ontime}/${target_of_projects_ontime}",
        label: Pct of Projects Ontime to Target, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: pct_of_projects_ontime_to_target,
        _type_hint: number}, {category: table_calculation, expression: "${actual_utilization}/${target_utilization}",
        label: Pct of Utilization % to Target, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: pct_of_utilization_to_target, _type_hint: number},
      {category: table_calculation, expression: "${hr_survey_results_fact.avg_e_nps}/${targets.avg_enps_target}",
        label: Pct eNPS to Target, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: pct_enps_to_target, _type_hint: number},
      {category: table_calculation, expression: "${certification_progress.total_score}/${certification_progress.score_target}",
        label: Pct Certification Progression to Target, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: pct_certification_progression_to_target,
        _type_hint: number}, {category: table_calculation, expression: "((${new_deals_pct_to_target}*0.5)+(${revenue_pct_to_target}*0.5)*0.5)",
        label: Financial (Weighted 50%), value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: financial_weighted_50, _type_hint: number},
      {category: table_calculation, expression: "((${pct_of_projects_ontime_to_target}*0.5)+(${pct_of_utilization_to_target}*0.5)*0.3)",
        label: Process & Customer Perspective (Weighted 30%), value_format: !!null '',
        value_format_name: percent_0, _kind_hint: measure, table_calculation: process_customer_perspective_weighted_30,
        _type_hint: number}, {category: table_calculation, expression: 'coalesce(((${pct_enps_to_target}*0.5)+(${pct_certification_progression_to_target}*0.5)*0.2),0)',
        label: Innovation & Learning Perspective (Weighted 20%), value_format: !!null '',
        value_format_name: percent_0, _kind_hint: measure, table_calculation: innovation_learning_perspective_weighted_20,
        _type_hint: number}, {category: table_calculation, expression: "${financial_weighted_50}+${process_customer_perspective_weighted_30}+${innovation_learning_perspective_weighted_20}",
        label: Weighted Overall Performance to Target %, value_format: !!null '',
        value_format_name: percent_0, _kind_hint: measure, table_calculation: weighted_overall_performance_to_target,
        _type_hint: number}]
    row: 9
    col: 0
    width: 12
    height: 7
  - name: " (4)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: |-
      <p align="center">
      <b><font size="5">Headline Performance</font></b>
    row: 0
    col: 0
    width: 24
    height: 2
  - name: Scorecard Objectives to Target LM
    title: Scorecard Objectives to Target LM
    note_state: collapsed
    note_display: above
    note_text: Weighted Overall Performance of the Business based on Kaplan/Norton
      Balanced Scorecard Approach
    merged_queries:
    - model: analytics
      explore: contact_utilization_fact
      type: single_value
      fields: [contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours,
        contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_total_capacity,
        contact_utilization_fact.forecast_month]
      fill_fields: [contact_utilization_fact.forecast_month]
      filters:
        contact_utilization_fact.forecast_week: 1 months ago for 1 months
        staff_dim.contact_name: "-Toby Sexton"
        staff_dim.contact_is_contractor: 'No'
      sorts: [contact_utilization_fact.forecast_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields: [{category: table_calculation, expression: "${contact_utilization_fact.total_actual_billable_hours}/${contact_utilization_fact.total_total_capacity}",
          label: Actual Utilization, value_format: !!null '', value_format_name: percent_0,
          _kind_hint: measure, table_calculation: actual_utilization, _type_hint: number},
        {category: table_calculation, expression: "${contact_utilization_fact.total_target_billable_capacity}/${contact_utilization_fact.total_total_capacity}",
          label: Target Utilization, value_format: !!null '', value_format_name: percent_0,
          _kind_hint: measure, table_calculation: target_utilization, _type_hint: number},
        {category: table_calculation, expression: "${contact_utilization_fact.total_forecast_billable_hours}/${contact_utilization_fact.total_total_capacity}",
          label: Forecast Utilization, value_format: !!null '', value_format_name: percent_0,
          _kind_hint: measure, table_calculation: forecast_utilization, _type_hint: number}]
      custom_color_enabled: true
      show_single_value_title: true
      show_comparison: true
      comparison_type: progress_percentage
      comparison_reverse_colors: false
      show_comparison_label: true
      enable_conditional_formatting: false
      conditional_formatting_include_totals: false
      conditional_formatting_include_nulls: false
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
      series_types: {}
      series_colors:
        target_utilization: "#8C3535"
        actual_utilization: "#519947"
        forecast_utilization: "#7AB7F4"
      series_labels: {}
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
      hidden_fields: [contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours,
        contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_total_capacity,
        forecast_utilization]
      hidden_points_if_no: []
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
      show_row_numbers: true
      transpose: false
      truncate_text: true
      hide_totals: false
      hide_row_totals: false
      size_to_fit: true
      table_theme: white
      header_text_alignment: left
      header_font_size: '12'
      rows_font_size: '12'
      label|contact_utilization_fact.average_time_off: "                  Time-Off"
      heading|contact_utilization_fact.average_time_off: ''
      style|contact_utilization_fact.average_time_off: normal
      reportIn|contact_utilization_fact.average_time_off: '1'
      unit|contact_utilization_fact.average_time_off: ''
      comparison|contact_utilization_fact.average_time_off: no_variance
      switch|contact_utilization_fact.average_time_off: false
      var_num|contact_utilization_fact.average_time_off: true
      var_pct|contact_utilization_fact.average_time_off: false
      show_sql_query_menu_options: false
      show_totals: true
      show_row_totals: true
      truncate_header: false
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
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      defaults_version: 1
      truncate_column_names: false
    - model: analytics
      explore: projects_delivered
      type: table
      fields: [projects_delivered_is_ontime.count_ontime_timesheet_projects, projects_delivered.count_timesheet_projects,
        projects_delivered.project_delivery_end_ts_month]
      fill_fields: [projects_delivered.project_delivery_end_ts_month]
      filters:
        projects_delivered.project_is_billable: 'Yes'
      sorts: [projects_delivered.project_delivery_end_ts_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields: [{category: table_calculation, expression: "${projects_delivered_is_ontime.count_ontime_timesheet_projects}/${projects_delivered.count_timesheet_projects}",
          label: "% of Projects Ontime", value_format: !!null '', value_format_name: percent_0,
          _kind_hint: measure, table_calculation: of_projects_ontime, _type_hint: number},
        {category: table_calculation, expression: '0.9', label: Target % of Projects
            Ontime, value_format: !!null '', value_format_name: percent_0, _kind_hint: dimension,
          table_calculation: target_of_projects_ontime, _type_hint: number}]
      hidden_fields: [projects_delivered_is_ontime.count_ontime_timesheet_projects,
        projects_delivered.count_timesheet_projects]
      join_fields:
      - field_name: projects_delivered.project_delivery_end_ts_month
        source_field_name: contact_utilization_fact.forecast_month
    - model: analytics
      explore: targets
      type: table
      fields: [targets.period_month, targets.total_revenue_target, targets.total_deals_closed_target,
        targets.avg_hr_survey_target, targets.avg_enps_target]
      fill_fields: [targets.period_month]
      limit: 500
      join_fields:
      - field_name: targets.period_month
        source_field_name: contact_utilization_fact.forecast_month
    - model: analytics
      explore: companies_dim
      type: table
      fields: [deals_fact.total_deal_amount_gbp_converted, deals_fact.deal_created_month]
      fill_fields: [deals_fact.deal_created_month]
      filters:
        deals_fact.pipeline_stage_closed_won: 'Yes'
      sorts: [deals_fact.deal_created_month]
      limit: 500
      join_fields:
      - field_name: deals_fact.deal_created_month
        source_field_name: contact_utilization_fact.forecast_month
    - model: analytics
      explore: projects_delivered
      type: table
      fields: [projects_invoiced.invoice_month, projects_invoiced.total_net_amount_gbp]
      fill_fields: [projects_invoiced.invoice_month]
      limit: 500
      join_fields:
      - field_name: projects_invoiced.invoice_month
        source_field_name: contact_utilization_fact.forecast_month
    - model: analytics
      explore: hr_survey_results_fact
      type: table
      fields: [hr_survey_results_fact.survey_ts_month, hr_survey_results_fact.avg_e_nps]
      fill_fields: [hr_survey_results_fact.survey_ts_month]
      limit: 500
      join_fields:
      - field_name: hr_survey_results_fact.survey_ts_month
        source_field_name: contact_utilization_fact.forecast_month
    - model: analytics
      explore: certification_progress
      type: table
      fields: [certification_progress.progress_month, certification_progress.total_score,
        certification_progress.score_target]
      fill_fields: [certification_progress.progress_month]
      sorts: [certification_progress.progress_month desc]
      limit: 500
      join_fields:
      - field_name: certification_progress.progress_month
        source_field_name: contact_utilization_fact.forecast_month
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
        reverse: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: financial_weighted_50,
            id: financial_weighted_50, name: Financial (Weighted 50%)}, {axisId: process_customer_perspective_weighted_30,
            id: process_customer_perspective_weighted_30, name: Process & Customer
              Perspective (Weighted 30%)}, {axisId: innovation_learning_perspective_weighted_20,
            id: innovation_learning_perspective_weighted_20, name: Innovation & Learning
              Perspective (Weighted 20%)}], showLabels: true, showValues: true, maxValue: 2,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
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
    hidden_series: [pct_certification_progression_to_target, pct_of_utilization_to_target]
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      innovation_learning_perspective_weighted_20: "#E48522"
    series_labels:
      financial_weighted_50: Finance % (50% of Overall)
      process_customer_perspective_weighted_30: Process % (30% of Overall)
      innovation_learning_perspective_weighted_20: Learning % (20% of Overall)
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: right, color: "#D03452",
        line_value: '1', label: Target}]
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    levels: 3
    label_factor: 85
    label_fine: 6
    rounded_strokes: false
    independent: false
    labelScale: true
    negatives: true
    wrap_width: 100
    opacity_area: 15
    dot_radius: 30
    opacity_circles: 0
    backgroundColor: "#CDCDCD"
    axisColor: "#CDCDCD"
    stroke_width: 15
    glow: 9
    axis_label_font: 12
    axis_scale_font: 12
    legend_font: 12
    legend_padding: 20
    legend_side: none
    2022-06_color: "#4A80BC"
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", contact_utilization_fact.forecast_month,
      weighted_performance, pct_of_utilization_to_target, pct_enps_to_target, pct_certification_progression_to_target]
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4A80BC",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 95584bf9-c29e-41ea-b6e7-79e9c126e177, options: {steps: 5}},
        bold: false, italic: false, strikethrough: false, fields: []}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    font_size_main: ''
    show_comparison_deals_fact.total_deal_amount_gbp_converted: false
    comparison_style_deals_fact.total_deal_amount_gbp_converted: value
    comparison_show_label_deals_fact.total_deal_amount_gbp_converted: true
    comparison_label_placement_deals_fact.total_deal_amount_gbp_converted: below
    show_comparison_of_projects_ontime: false
    comparison_style_of_projects_ontime: value
    comparison_show_label_of_projects_ontime: true
    comparison_label_placement_of_projects_ontime: below
    show_comparison_targets.total_revenue_target: true
    comparison_style_targets.total_revenue_target: value
    comparison_show_label_targets.total_revenue_target: true
    comparison_label_placement_targets.total_revenue_target: below
    show_comparison_targets.total_deals_closed_target: true
    comparison_style_targets.total_deals_closed_target: value
    comparison_show_label_targets.total_deals_closed_target: true
    comparison_label_placement_targets.total_deals_closed_target: below
    show_comparison_targets.avg_enps_target: true
    comparison_style_targets.avg_enps_target: value
    comparison_show_label_targets.avg_enps_target: true
    comparison_label_placement_targets.avg_enps_target: below
    show_comparison_certification_progress.score_target: true
    comparison_style_certification_progress.score_target: value
    comparison_show_label_certification_progress.score_target: true
    comparison_label_placement_certification_progress.score_target: below
    show_title_of_projects_ontime: false
    hidden_fields: [contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours,
      contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_total_capacity,
      actual_utilization, forecast_utilization, projects_delivered_is_ontime.count_ontime_timesheet_projects,
      projects_delivered.count_timesheet_projects, targets.avg_hr_survey_target, of_projects_ontime,
      targets.total_revenue_target, targets.avg_enps_target, projects_invoiced.total_net_amount_gbp,
      hr_survey_results_fact.avg_e_nps, certification_progress.total_score, certification_progress.score_target,
      target_utilization, deals_fact.total_deal_amount_gbp_converted, targets.total_deals_closed_target,
      target_of_projects_ontime, new_deals_pct_to_target, revenue_pct_to_target, pct_of_projects_ontime_to_target,
      pct_certification_progression_to_target, pct_of_utilization_to_target, pct_enps_to_target]
    type: looker_column
    query_fields:
      measures:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Utilization        Total Forecast Billable Hours
        label_from_parameter:
        label_short: "       Total Forecast Billable Hours"
        map_layer:
        name: contact_utilization_fact.total_forecast_billable_hours
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0.00"
        view: contact_utilization_fact
        view_label: Utilization
        dynamic: false
        week_start_day: monday
        original_view: contact_utilization_fact
        dimension_group:
        error:
        field_group_variant: "       Total Forecast Billable Hours"
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: contact_utilization_fact
        suggest_dimension: contact_utilization_fact.total_forecast_billable_hours
        suggest_explore: contact_utilization_fact
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fcontact_utilization_fact.view.lkml?line=89"
        permanent: true
        source_file: views/contact_utilization_fact.view.lkml
        source_file_path: analytics/views/contact_utilization_fact.view.lkml
        sql: "${forecast_billable_hours} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Utilization     Total Actual Billable Hours
        label_from_parameter:
        label_short: "    Total Actual Billable Hours"
        map_layer:
        name: contact_utilization_fact.total_actual_billable_hours
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        view: contact_utilization_fact
        view_label: Utilization
        dynamic: false
        week_start_day: monday
        original_view: contact_utilization_fact
        dimension_group:
        error:
        field_group_variant: "    Total Actual Billable Hours"
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: contact_utilization_fact
        suggest_dimension: contact_utilization_fact.total_actual_billable_hours
        suggest_explore: contact_utilization_fact
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fcontact_utilization_fact.view.lkml?line=34"
        permanent: true
        source_file: views/contact_utilization_fact.view.lkml
        source_file_path: analytics/views/contact_utilization_fact.view.lkml
        sql: "${actual_billable_hours} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Utilization          Total Target Billable Capacity
        label_from_parameter:
        label_short: "         Total Target Billable Capacity"
        map_layer:
        name: contact_utilization_fact.total_target_billable_capacity
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        view: contact_utilization_fact
        view_label: Utilization
        dynamic: false
        week_start_day: monday
        original_view: contact_utilization_fact
        dimension_group:
        error:
        field_group_variant: "         Total Target Billable Capacity"
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: contact_utilization_fact
        suggest_dimension: contact_utilization_fact.total_target_billable_capacity
        suggest_explore: contact_utilization_fact
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fcontact_utilization_fact.view.lkml?line=169"
        permanent: true
        source_file: views/contact_utilization_fact.view.lkml
        source_file_path: analytics/views/contact_utilization_fact.view.lkml
        sql: "${target_billable_capacity} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Utilization            Total Total Capacity
        label_from_parameter:
        label_short: "           Total Total Capacity"
        map_layer:
        name: contact_utilization_fact.total_total_capacity
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        view: contact_utilization_fact
        view_label: Utilization
        dynamic: false
        week_start_day: monday
        original_view: contact_utilization_fact
        dimension_group:
        error:
        field_group_variant: "           Total Total Capacity"
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: contact_utilization_fact
        suggest_dimension: contact_utilization_fact.total_total_capacity
        suggest_explore: contact_utilization_fact
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fcontact_utilization_fact.view.lkml?line=249"
        permanent: true
        source_file: views/contact_utilization_fact.view.lkml
        source_file_path: analytics/views/contact_utilization_fact.view.lkml
        sql: "${total_capacity} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - type: number
        align: right
        measure: true
        dynamic: false
        can_pivot: true
        is_numeric: true
        name: actual_utilization
        label: Actual Utilization
        value_format: "#,##0%"
        is_disabled:
        sortable: true
        aggregate: true
        can_filter: false
        permanent: true
      - type: number
        align: right
        measure: true
        dynamic: false
        can_pivot: true
        is_numeric: true
        name: target_utilization
        label: Target Utilization
        value_format: "#,##0%"
        is_disabled:
        sortable: true
        aggregate: true
        can_filter: false
        permanent: true
      - type: number
        align: right
        measure: true
        dynamic: false
        can_pivot: true
        is_numeric: true
        name: forecast_utilization
        label: Forecast Utilization
        value_format: "#,##0%"
        is_disabled:
        sortable: true
        aggregate: true
        can_filter: false
        permanent: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: "         Projects Count Ontime Timesheet Projects"
        label_from_parameter:
        label_short: Count Ontime Timesheet Projects
        map_layer:
        name: projects_delivered_is_ontime.count_ontime_timesheet_projects
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: count_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format:
        view: projects_delivered_is_ontime
        view_label: "         Projects"
        dynamic: false
        week_start_day: monday
        original_view: projects_delivered_is_ontime
        dimension_group:
        error:
        field_group_variant: Count Ontime Timesheet Projects
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: projects_delivered_is_ontime
        suggest_dimension: projects_delivered_is_ontime.count_ontime_timesheet_projects
        suggest_explore: projects_delivered
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fprojects_delivered_is_ontime.view.lkml?line=61"
        permanent: true
        source_file: views/projects_delivered_is_ontime.view.lkml
        source_file_path: analytics/views/projects_delivered_is_ontime.view.lkml
        sql: "${timesheet_project_pk} "
        sql_case:
        filters:
        - field: projects_delivered_is_ontime.is_ontime_project
          condition: 'Yes'
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: "         Projects Count Timesheet Projects"
        label_from_parameter:
        label_short: Count Timesheet Projects
        map_layer:
        name: projects_delivered.count_timesheet_projects
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: count_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format:
        view: projects_delivered
        view_label: "         Projects"
        dynamic: false
        week_start_day: monday
        original_view: timesheet_projects_dim
        dimension_group:
        error:
        field_group_variant: Count Timesheet Projects
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: projects_delivered
        suggest_dimension: projects_delivered.count_timesheet_projects
        suggest_explore: projects_delivered
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftimesheet_projects_dim.view.lkml?line=178"
        permanent: true
        source_file: views/timesheet_projects_dim.view.lkml
        source_file_path: analytics/views/timesheet_projects_dim.view.lkml
        sql: "${TABLE}.timesheet_project_pk "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - type: number
        align: right
        measure: true
        dynamic: false
        can_pivot: true
        is_numeric: true
        name: of_projects_ontime
        label: "% of Projects Ontime"
        value_format: "#,##0%"
        is_disabled:
        sortable: true
        aggregate: true
        can_filter: false
        permanent: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Targets Total Revenue Target
        label_from_parameter:
        label_short: Total Revenue Target
        map_layer:
        name: targets.total_revenue_target
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0.00'
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Total Revenue Target
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.total_revenue_target
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=56"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${revenue_target} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Targets Total Deals Closed Target
        label_from_parameter:
        label_short: Total Deals Closed Target
        map_layer:
        name: targets.total_deals_closed_target
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0.00'
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Total Deals Closed Target
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.total_deals_closed_target
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=63"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${deals_closed_target} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Targets Avg Hr Survey Target
        label_from_parameter:
        label_short: Avg Hr Survey Target
        map_layer:
        name: targets.avg_hr_survey_target
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: average
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0.00"
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Avg Hr Survey Target
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.avg_hr_survey_target
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=82"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${hr_survey_target} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Targets Avg Enps Target
        label_from_parameter:
        label_short: Avg Enps Target
        map_layer:
        name: targets.avg_enps_target
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: average
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0.00"
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Avg Enps Target
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.avg_enps_target
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=76"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${enps_target} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label: Deals fact  Measures
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: "     Sales (Hubspot) Total Deal Amount GBP"
        label_from_parameter:
        label_short: Total Deal Amount GBP
        map_layer:
        name: deals_fact.total_deal_amount_gbp_converted
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0.00'
        view: deals_fact
        view_label: "     Sales (Hubspot)"
        dynamic: false
        week_start_day: monday
        original_view: deals_fact
        dimension_group:
        error:
        field_group_variant: Total Deal Amount GBP
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: deals_fact
        suggest_dimension: deals_fact.total_deal_amount_gbp_converted
        suggest_explore: companies_dim
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fdeals_fact.view.lkml?line=26"
        permanent: true
        source_file: views/deals_fact.view.lkml
        source_file_path: analytics/views/deals_fact.view.lkml
        sql: "CASE\n         when ${TABLE}.deal_currency_code = 'USD' then ${TABLE}.deal_amount\
          \ * .75\n         when ${TABLE}.deal_currency_code = 'CAD' then ${TABLE}.deal_amount\
          \ * .58\n         when ${TABLE}.deal_currency_code = 'EUR' then ${TABLE}.deal_amount\
          \ * 0.90\n         else ${TABLE}.deal_amount end "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label: Reporting
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: "   Invoices Total Net Amount Gbp"
        label_from_parameter:
        label_short: Total Net Amount Gbp
        map_layer:
        name: projects_invoiced.total_net_amount_gbp
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        view: projects_invoiced
        view_label: "   Invoices"
        dynamic: false
        week_start_day: monday
        original_view: invoices_fact
        dimension_group:
        error:
        field_group_variant: Total Net Amount Gbp
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: projects_invoiced
        suggest_dimension: projects_invoiced.total_net_amount_gbp
        suggest_explore: projects_delivered
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Finvoices_fact.view.lkml?line=555"
        permanent: true
        source_file: views/invoices_fact.view.lkml
        source_file_path: analytics/views/invoices_fact.view.lkml
        sql: "${invoice_gbp_amount} - coalesce(${invoice_gbp_tax_amount},0)"
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Staff Satisfaction Avg E Nps
        label_from_parameter:
        label_short: Avg E Nps
        map_layer:
        name: hr_survey_results_fact.avg_e_nps
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: average
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0.00"
        view: hr_survey_results_fact
        view_label: Staff Satisfaction
        dynamic: false
        week_start_day: monday
        original_view: hr_survey_results_fact
        dimension_group:
        error:
        field_group_variant: Avg E Nps
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: hr_survey_results_fact
        suggest_dimension: hr_survey_results_fact.avg_e_nps
        suggest_explore: hr_survey_results_fact
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fhr_survey_results_fact.view.lkml?line=132"
        permanent: true
        source_file: views/hr_survey_results_fact.view.lkml
        source_file_path: analytics/views/hr_survey_results_fact.view.lkml
        sql: "${TABLE}.e_nps "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Certification Progress Total Score
        label_from_parameter:
        label_short: Total Score
        map_layer:
        name: certification_progress.total_score
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format:
        view: certification_progress
        view_label: Certification Progress
        dynamic: false
        week_start_day: monday
        original_view: certification_progress
        dimension_group:
        error:
        field_group_variant: Total Score
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: certification_progress
        suggest_dimension: certification_progress.total_score
        suggest_explore: certification_progress
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fcertification_progress.view.lkml?line=38"
        permanent: true
        source_file: views/certification_progress.view.lkml
        source_file_path: analytics/views/certification_progress.view.lkml
        sql: "${score} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Certification Progress Score Target
        label_from_parameter:
        label_short: Score Target
        map_layer:
        name: certification_progress.score_target
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: average
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format:
        view: certification_progress
        view_label: Certification Progress
        dynamic: false
        week_start_day: monday
        original_view: certification_progress
        dimension_group:
        error:
        field_group_variant: Score Target
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: certification_progress
        suggest_dimension: certification_progress.score_target
        suggest_explore: certification_progress
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fcertification_progress.view.lkml?line=43"
        permanent: true
        source_file: views/certification_progress.view.lkml
        source_file_path: analytics/views/certification_progress.view.lkml
        sql: "${target} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      dimensions:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        enumerations:
        field_group_label: "               Forecast Date"
        fill_style: range
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: false
        label: Utilization                Forecast Month
        label_from_parameter:
        label_short: "               Forecast Month"
        map_layer:
        name: contact_utilization_fact.forecast_month
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: date_month
        user_attribute_filter_types:
        - datetime
        - advanced_filter_datetime
        value_format:
        view: contact_utilization_fact
        view_label: Utilization
        dynamic: false
        week_start_day: monday
        original_view: contact_utilization_fact
        dimension_group: contact_utilization_fact.forecast
        error:
        field_group_variant: Month
        measure: false
        parameter: false
        primary_key: false
        project_name: analytics
        scope: contact_utilization_fact
        suggest_dimension: contact_utilization_fact.forecast_month
        suggest_explore: contact_utilization_fact
        suggestable: false
        is_fiscal: false
        is_timeframe: true
        can_time_filter: false
        time_interval:
          name: month
          count: 1
        lookml_link: "/projects/analytics/files/views%2Fcontact_utilization_fact.view.lkml?line=101"
        permanent: true
        source_file: views/contact_utilization_fact.view.lkml
        source_file_path: analytics/views/contact_utilization_fact.view.lkml
        sql: "${TABLE}.forecast_week "
        sql_case:
        filters:
        times_used: 0
        sorted:
          sort_index: 0
          desc: true
      - type: number
        align: right
        measure: false
        dynamic: false
        can_pivot: false
        is_numeric: true
        name: target_of_projects_ontime
        label: Target % of Projects Ontime
        value_format: "#,##0%"
        is_disabled:
        sortable: true
        aggregate: true
        can_filter: false
        permanent: true
      table_calculations:
      - label: New Deals Pct to Target
        name: new_deals_pct_to_target
        expression: coalesce(${deals_fact.total_deal_amount_gbp_converted}/${targets.total_deals_closed_target},0)
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Revenue Pct to Target
        name: revenue_pct_to_target
        expression: "${projects_invoiced.total_net_amount_gbp}/${targets.total_revenue_target}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Pct of Projects Ontime to Target
        name: pct_of_projects_ontime_to_target
        expression: "${of_projects_ontime}/${target_of_projects_ontime}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Pct of Utilization % to Target
        name: pct_of_utilization_to_target
        expression: "${actual_utilization}/${target_utilization}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Pct eNPS to Target
        name: pct_enps_to_target
        expression: "${hr_survey_results_fact.avg_e_nps}/${targets.avg_enps_target}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Pct Certification Progression to Target
        name: pct_certification_progression_to_target
        expression: "${certification_progress.total_score}/${certification_progress.score_target}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Financial (Weighted 50%)
        name: financial_weighted_50
        expression: "((${new_deals_pct_to_target}*0.5)+(${revenue_pct_to_target}*0.5)*1)"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Process & Customer Perspective (Weighted 30%)
        name: process_customer_perspective_weighted_30
        expression: "((${pct_of_projects_ontime_to_target}*0.5)+(${pct_of_utilization_to_target}*0.5)*1)"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Innovation & Learning Perspective (Weighted 20%)
        name: innovation_learning_perspective_weighted_20
        expression: "((${pct_enps_to_target}*0.5)+(${pct_certification_progression_to_target}*0.5)*1)"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      pivots: []
    dynamic_fields: [{category: table_calculation, expression: 'coalesce(${deals_fact.total_deal_amount_gbp_converted}/${targets.total_deals_closed_target},0)',
        label: New Deals Pct to Target, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: new_deals_pct_to_target, _type_hint: number},
      {category: table_calculation, expression: "${projects_invoiced.total_net_amount_gbp}/${targets.total_revenue_target}",
        label: Revenue Pct to Target, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: revenue_pct_to_target, _type_hint: number},
      {category: table_calculation, expression: "${of_projects_ontime}/${target_of_projects_ontime}",
        label: Pct of Projects Ontime to Target, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: pct_of_projects_ontime_to_target,
        _type_hint: number}, {category: table_calculation, expression: "${actual_utilization}/${target_utilization}",
        label: Pct of Utilization % to Target, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: pct_of_utilization_to_target, _type_hint: number},
      {category: table_calculation, expression: "${hr_survey_results_fact.avg_e_nps}/${targets.avg_enps_target}",
        label: Pct eNPS to Target, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: pct_enps_to_target, _type_hint: number},
      {category: table_calculation, expression: "${certification_progress.total_score}/${certification_progress.score_target}",
        label: Pct Certification Progression to Target, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: pct_certification_progression_to_target,
        _type_hint: number}, {category: table_calculation, expression: "((${new_deals_pct_to_target}*0.5)+(${revenue_pct_to_target}*0.5)*1)",
        label: Financial (Weighted 50%), value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: financial_weighted_50, _type_hint: number},
      {category: table_calculation, expression: "((${pct_of_projects_ontime_to_target}*0.5)+(${pct_of_utilization_to_target}*0.5)*1)",
        label: Process & Customer Perspective (Weighted 30%), value_format: !!null '',
        value_format_name: percent_0, _kind_hint: measure, table_calculation: process_customer_perspective_weighted_30,
        _type_hint: number}, {category: table_calculation, expression: "((${pct_enps_to_target}*0.5)+(${pct_certification_progression_to_target}*0.5)*1)",
        label: Innovation & Learning Perspective (Weighted 20%), value_format: !!null '',
        value_format_name: percent_0, _kind_hint: measure, table_calculation: innovation_learning_perspective_weighted_20,
        _type_hint: number}]
    row: 9
    col: 12
    width: 8
    height: 7
  - name: Weighted Performance LM
    title: Weighted Performance LM
    note_state: collapsed
    note_display: above
    note_text: Weighted Overall Performance of the Business based on Kaplan/Norton
      Balanced Scorecard Approach
    title_hidden: true
    merged_queries:
    - model: analytics
      explore: contact_utilization_fact
      type: single_value
      fields: [contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours,
        contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_total_capacity,
        contact_utilization_fact.forecast_month]
      fill_fields: [contact_utilization_fact.forecast_month]
      filters:
        contact_utilization_fact.forecast_week: 2 months ago for 2 months
        staff_dim.contact_name: "-Toby Sexton"
        staff_dim.contact_is_contractor: 'No'
      sorts: [contact_utilization_fact.forecast_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields: [{category: table_calculation, expression: "${contact_utilization_fact.total_actual_billable_hours}/${contact_utilization_fact.total_total_capacity}",
          label: Actual Utilization, value_format: !!null '', value_format_name: percent_0,
          _kind_hint: measure, table_calculation: actual_utilization, _type_hint: number},
        {category: table_calculation, expression: "${contact_utilization_fact.total_target_billable_capacity}/${contact_utilization_fact.total_total_capacity}",
          label: Target Utilization, value_format: !!null '', value_format_name: percent_0,
          _kind_hint: measure, table_calculation: target_utilization, _type_hint: number},
        {category: table_calculation, expression: "${contact_utilization_fact.total_forecast_billable_hours}/${contact_utilization_fact.total_total_capacity}",
          label: Forecast Utilization, value_format: !!null '', value_format_name: percent_0,
          _kind_hint: measure, table_calculation: forecast_utilization, _type_hint: number}]
      custom_color_enabled: true
      show_single_value_title: true
      show_comparison: true
      comparison_type: progress_percentage
      comparison_reverse_colors: false
      show_comparison_label: true
      enable_conditional_formatting: false
      conditional_formatting_include_totals: false
      conditional_formatting_include_nulls: false
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
      series_types: {}
      series_colors:
        target_utilization: "#8C3535"
        actual_utilization: "#519947"
        forecast_utilization: "#7AB7F4"
      series_labels: {}
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
      hidden_fields: [contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours,
        contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_total_capacity,
        forecast_utilization]
      hidden_points_if_no: []
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
      show_row_numbers: true
      transpose: false
      truncate_text: true
      hide_totals: false
      hide_row_totals: false
      size_to_fit: true
      table_theme: white
      header_text_alignment: left
      header_font_size: '12'
      rows_font_size: '12'
      label|contact_utilization_fact.average_time_off: "                  Time-Off"
      heading|contact_utilization_fact.average_time_off: ''
      style|contact_utilization_fact.average_time_off: normal
      reportIn|contact_utilization_fact.average_time_off: '1'
      unit|contact_utilization_fact.average_time_off: ''
      comparison|contact_utilization_fact.average_time_off: no_variance
      switch|contact_utilization_fact.average_time_off: false
      var_num|contact_utilization_fact.average_time_off: true
      var_pct|contact_utilization_fact.average_time_off: false
      show_sql_query_menu_options: false
      show_totals: true
      show_row_totals: true
      truncate_header: false
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
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      defaults_version: 1
      truncate_column_names: false
    - model: analytics
      explore: projects_delivered
      type: table
      fields: [projects_delivered_is_ontime.count_ontime_timesheet_projects, projects_delivered.count_timesheet_projects,
        projects_delivered.project_delivery_end_ts_month]
      fill_fields: [projects_delivered.project_delivery_end_ts_month]
      filters:
        projects_delivered.project_is_billable: 'Yes'
      sorts: [projects_delivered.project_delivery_end_ts_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields: [{category: table_calculation, expression: "${projects_delivered_is_ontime.count_ontime_timesheet_projects}/${projects_delivered.count_timesheet_projects}",
          label: "% of Projects Ontime", value_format: !!null '', value_format_name: percent_0,
          _kind_hint: measure, table_calculation: of_projects_ontime, _type_hint: number},
        {category: table_calculation, expression: '0.9', label: Target % of Projects
            Ontime, value_format: !!null '', value_format_name: percent_0, _kind_hint: dimension,
          table_calculation: target_of_projects_ontime, _type_hint: number}]
      hidden_fields: [projects_delivered_is_ontime.count_ontime_timesheet_projects,
        projects_delivered.count_timesheet_projects]
      join_fields:
      - field_name: projects_delivered.project_delivery_end_ts_month
        source_field_name: contact_utilization_fact.forecast_month
    - model: analytics
      explore: targets
      type: table
      fields: [targets.period_month, targets.total_revenue_target, targets.total_deals_closed_target,
        targets.avg_hr_survey_target, targets.avg_enps_target]
      fill_fields: [targets.period_month]
      limit: 500
      join_fields:
      - field_name: targets.period_month
        source_field_name: contact_utilization_fact.forecast_month
    - model: analytics
      explore: companies_dim
      type: table
      fields: [deals_fact.total_deal_amount_gbp_converted, deals_fact.deal_created_month]
      fill_fields: [deals_fact.deal_created_month]
      filters:
        deals_fact.pipeline_stage_closed_won: 'Yes'
      sorts: [deals_fact.deal_created_month]
      limit: 500
      join_fields:
      - field_name: deals_fact.deal_created_month
        source_field_name: contact_utilization_fact.forecast_month
    - model: analytics
      explore: projects_delivered
      type: table
      fields: [projects_invoiced.invoice_month, projects_invoiced.total_net_amount_gbp]
      fill_fields: [projects_invoiced.invoice_month]
      limit: 500
      join_fields:
      - field_name: projects_invoiced.invoice_month
        source_field_name: contact_utilization_fact.forecast_month
    - model: analytics
      explore: hr_survey_results_fact
      type: table
      fields: [hr_survey_results_fact.survey_ts_month, hr_survey_results_fact.avg_e_nps]
      fill_fields: [hr_survey_results_fact.survey_ts_month]
      limit: 500
      join_fields:
      - field_name: hr_survey_results_fact.survey_ts_month
        source_field_name: contact_utilization_fact.forecast_month
    - model: analytics
      explore: certification_progress
      type: table
      fields: [certification_progress.progress_month, certification_progress.total_score,
        certification_progress.score_target]
      fill_fields: [certification_progress.progress_month]
      sorts: [certification_progress.progress_month desc]
      limit: 500
      join_fields:
      - field_name: certification_progress.progress_month
        source_field_name: contact_utilization_fact.forecast_month
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
        reverse: false
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Weighted Performance
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Previous Month
    enable_conditional_formatting: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4A80BC",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 95584bf9-c29e-41ea-b6e7-79e9c126e177, options: {steps: 5}},
        bold: false, italic: false, strikethrough: false, fields: []}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: financial_weighted_50,
            id: financial_weighted_50, name: Financial (Weighted 50%)}, {axisId: process_customer_perspective_weighted_30,
            id: process_customer_perspective_weighted_30, name: Process & Customer
              Perspective (Weighted 30%)}, {axisId: innovation_learning_perspective_weighted_20,
            id: innovation_learning_perspective_weighted_20, name: Innovation & Learning
              Perspective (Weighted 20%)}], showLabels: true, showValues: true, maxValue: 2,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
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
    hidden_series: [pct_certification_progression_to_target, pct_of_utilization_to_target]
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      innovation_learning_perspective_weighted_20: "#E48522"
    series_labels:
      financial_weighted_50: Finance % (50% of Overall)
      process_customer_perspective_weighted_30: Process % (30% of Overall)
      innovation_learning_perspective_weighted_20: Learning % (20% of Overall)
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: right, color: "#D03452",
        line_value: '1', label: Target}]
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    levels: 3
    label_factor: 85
    label_fine: 6
    rounded_strokes: false
    independent: false
    labelScale: true
    negatives: true
    wrap_width: 100
    opacity_area: 15
    dot_radius: 30
    opacity_circles: 0
    backgroundColor: "#CDCDCD"
    axisColor: "#CDCDCD"
    stroke_width: 15
    glow: 9
    axis_label_font: 12
    axis_scale_font: 12
    legend_font: 12
    legend_padding: 20
    legend_side: none
    2022-06_color: "#4A80BC"
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", contact_utilization_fact.forecast_month,
      weighted_performance, pct_of_utilization_to_target, pct_enps_to_target, pct_certification_progression_to_target]
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    font_size_main: ''
    show_comparison_deals_fact.total_deal_amount_gbp_converted: false
    comparison_style_deals_fact.total_deal_amount_gbp_converted: value
    comparison_show_label_deals_fact.total_deal_amount_gbp_converted: true
    comparison_label_placement_deals_fact.total_deal_amount_gbp_converted: below
    show_comparison_of_projects_ontime: false
    comparison_style_of_projects_ontime: value
    comparison_show_label_of_projects_ontime: true
    comparison_label_placement_of_projects_ontime: below
    show_comparison_targets.total_revenue_target: true
    comparison_style_targets.total_revenue_target: value
    comparison_show_label_targets.total_revenue_target: true
    comparison_label_placement_targets.total_revenue_target: below
    show_comparison_targets.total_deals_closed_target: true
    comparison_style_targets.total_deals_closed_target: value
    comparison_show_label_targets.total_deals_closed_target: true
    comparison_label_placement_targets.total_deals_closed_target: below
    show_comparison_targets.avg_enps_target: true
    comparison_style_targets.avg_enps_target: value
    comparison_show_label_targets.avg_enps_target: true
    comparison_label_placement_targets.avg_enps_target: below
    show_comparison_certification_progress.score_target: true
    comparison_style_certification_progress.score_target: value
    comparison_show_label_certification_progress.score_target: true
    comparison_label_placement_certification_progress.score_target: below
    show_title_of_projects_ontime: false
    hidden_fields: [contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_billable_hours,
      contact_utilization_fact.total_target_billable_capacity, contact_utilization_fact.total_total_capacity,
      actual_utilization, forecast_utilization, projects_delivered_is_ontime.count_ontime_timesheet_projects,
      projects_delivered.count_timesheet_projects, targets.avg_hr_survey_target, of_projects_ontime,
      targets.total_revenue_target, targets.avg_enps_target, projects_invoiced.total_net_amount_gbp,
      hr_survey_results_fact.avg_e_nps, certification_progress.total_score, certification_progress.score_target,
      target_utilization, deals_fact.total_deal_amount_gbp_converted, targets.total_deals_closed_target,
      target_of_projects_ontime, new_deals_pct_to_target, revenue_pct_to_target, pct_of_projects_ontime_to_target,
      pct_certification_progression_to_target, pct_of_utilization_to_target, pct_enps_to_target,
      financial_weighted_50, process_customer_perspective_weighted_30, innovation_learning_perspective_weighted_20,
      contact_utilization_fact.forecast_month]
    type: single_value
    query_fields:
      measures:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Utilization        Total Forecast Billable Hours
        label_from_parameter:
        label_short: "       Total Forecast Billable Hours"
        map_layer:
        name: contact_utilization_fact.total_forecast_billable_hours
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0.00"
        view: contact_utilization_fact
        view_label: Utilization
        dynamic: false
        week_start_day: monday
        original_view: contact_utilization_fact
        dimension_group:
        error:
        field_group_variant: "       Total Forecast Billable Hours"
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: contact_utilization_fact
        suggest_dimension: contact_utilization_fact.total_forecast_billable_hours
        suggest_explore: contact_utilization_fact
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fcontact_utilization_fact.view.lkml?line=89"
        permanent: true
        source_file: views/contact_utilization_fact.view.lkml
        source_file_path: analytics/views/contact_utilization_fact.view.lkml
        sql: "${forecast_billable_hours} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Utilization     Total Actual Billable Hours
        label_from_parameter:
        label_short: "    Total Actual Billable Hours"
        map_layer:
        name: contact_utilization_fact.total_actual_billable_hours
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        view: contact_utilization_fact
        view_label: Utilization
        dynamic: false
        week_start_day: monday
        original_view: contact_utilization_fact
        dimension_group:
        error:
        field_group_variant: "    Total Actual Billable Hours"
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: contact_utilization_fact
        suggest_dimension: contact_utilization_fact.total_actual_billable_hours
        suggest_explore: contact_utilization_fact
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fcontact_utilization_fact.view.lkml?line=34"
        permanent: true
        source_file: views/contact_utilization_fact.view.lkml
        source_file_path: analytics/views/contact_utilization_fact.view.lkml
        sql: "${actual_billable_hours} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Utilization          Total Target Billable Capacity
        label_from_parameter:
        label_short: "         Total Target Billable Capacity"
        map_layer:
        name: contact_utilization_fact.total_target_billable_capacity
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        view: contact_utilization_fact
        view_label: Utilization
        dynamic: false
        week_start_day: monday
        original_view: contact_utilization_fact
        dimension_group:
        error:
        field_group_variant: "         Total Target Billable Capacity"
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: contact_utilization_fact
        suggest_dimension: contact_utilization_fact.total_target_billable_capacity
        suggest_explore: contact_utilization_fact
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fcontact_utilization_fact.view.lkml?line=169"
        permanent: true
        source_file: views/contact_utilization_fact.view.lkml
        source_file_path: analytics/views/contact_utilization_fact.view.lkml
        sql: "${target_billable_capacity} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Utilization            Total Total Capacity
        label_from_parameter:
        label_short: "           Total Total Capacity"
        map_layer:
        name: contact_utilization_fact.total_total_capacity
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        view: contact_utilization_fact
        view_label: Utilization
        dynamic: false
        week_start_day: monday
        original_view: contact_utilization_fact
        dimension_group:
        error:
        field_group_variant: "           Total Total Capacity"
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: contact_utilization_fact
        suggest_dimension: contact_utilization_fact.total_total_capacity
        suggest_explore: contact_utilization_fact
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fcontact_utilization_fact.view.lkml?line=249"
        permanent: true
        source_file: views/contact_utilization_fact.view.lkml
        source_file_path: analytics/views/contact_utilization_fact.view.lkml
        sql: "${total_capacity} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - type: number
        align: right
        measure: true
        dynamic: false
        can_pivot: true
        is_numeric: true
        name: actual_utilization
        label: Actual Utilization
        value_format: "#,##0%"
        is_disabled:
        sortable: true
        aggregate: true
        can_filter: false
        permanent: true
      - type: number
        align: right
        measure: true
        dynamic: false
        can_pivot: true
        is_numeric: true
        name: target_utilization
        label: Target Utilization
        value_format: "#,##0%"
        is_disabled:
        sortable: true
        aggregate: true
        can_filter: false
        permanent: true
      - type: number
        align: right
        measure: true
        dynamic: false
        can_pivot: true
        is_numeric: true
        name: forecast_utilization
        label: Forecast Utilization
        value_format: "#,##0%"
        is_disabled:
        sortable: true
        aggregate: true
        can_filter: false
        permanent: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: "         Projects Count Ontime Timesheet Projects"
        label_from_parameter:
        label_short: Count Ontime Timesheet Projects
        map_layer:
        name: projects_delivered_is_ontime.count_ontime_timesheet_projects
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: count_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format:
        view: projects_delivered_is_ontime
        view_label: "         Projects"
        dynamic: false
        week_start_day: monday
        original_view: projects_delivered_is_ontime
        dimension_group:
        error:
        field_group_variant: Count Ontime Timesheet Projects
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: projects_delivered_is_ontime
        suggest_dimension: projects_delivered_is_ontime.count_ontime_timesheet_projects
        suggest_explore: projects_delivered
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fprojects_delivered_is_ontime.view.lkml?line=61"
        permanent: true
        source_file: views/projects_delivered_is_ontime.view.lkml
        source_file_path: analytics/views/projects_delivered_is_ontime.view.lkml
        sql: "${timesheet_project_pk} "
        sql_case:
        filters:
        - field: projects_delivered_is_ontime.is_ontime_project
          condition: 'Yes'
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: "         Projects Count Timesheet Projects"
        label_from_parameter:
        label_short: Count Timesheet Projects
        map_layer:
        name: projects_delivered.count_timesheet_projects
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: count_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format:
        view: projects_delivered
        view_label: "         Projects"
        dynamic: false
        week_start_day: monday
        original_view: timesheet_projects_dim
        dimension_group:
        error:
        field_group_variant: Count Timesheet Projects
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: projects_delivered
        suggest_dimension: projects_delivered.count_timesheet_projects
        suggest_explore: projects_delivered
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftimesheet_projects_dim.view.lkml?line=178"
        permanent: true
        source_file: views/timesheet_projects_dim.view.lkml
        source_file_path: analytics/views/timesheet_projects_dim.view.lkml
        sql: "${TABLE}.timesheet_project_pk "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - type: number
        align: right
        measure: true
        dynamic: false
        can_pivot: true
        is_numeric: true
        name: of_projects_ontime
        label: "% of Projects Ontime"
        value_format: "#,##0%"
        is_disabled:
        sortable: true
        aggregate: true
        can_filter: false
        permanent: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Targets Total Revenue Target
        label_from_parameter:
        label_short: Total Revenue Target
        map_layer:
        name: targets.total_revenue_target
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0.00'
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Total Revenue Target
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.total_revenue_target
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=56"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${revenue_target} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Targets Total Deals Closed Target
        label_from_parameter:
        label_short: Total Deals Closed Target
        map_layer:
        name: targets.total_deals_closed_target
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0.00'
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Total Deals Closed Target
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.total_deals_closed_target
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=63"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${deals_closed_target} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Targets Avg Hr Survey Target
        label_from_parameter:
        label_short: Avg Hr Survey Target
        map_layer:
        name: targets.avg_hr_survey_target
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: average
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0.00"
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Avg Hr Survey Target
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.avg_hr_survey_target
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=82"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${hr_survey_target} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Targets Avg Enps Target
        label_from_parameter:
        label_short: Avg Enps Target
        map_layer:
        name: targets.avg_enps_target
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: average
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0.00"
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Avg Enps Target
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.avg_enps_target
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=76"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${enps_target} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label: Deals fact  Measures
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: "     Sales (Hubspot) Total Deal Amount GBP"
        label_from_parameter:
        label_short: Total Deal Amount GBP
        map_layer:
        name: deals_fact.total_deal_amount_gbp_converted
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0.00'
        view: deals_fact
        view_label: "     Sales (Hubspot)"
        dynamic: false
        week_start_day: monday
        original_view: deals_fact
        dimension_group:
        error:
        field_group_variant: Total Deal Amount GBP
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: deals_fact
        suggest_dimension: deals_fact.total_deal_amount_gbp_converted
        suggest_explore: companies_dim
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fdeals_fact.view.lkml?line=26"
        permanent: true
        source_file: views/deals_fact.view.lkml
        source_file_path: analytics/views/deals_fact.view.lkml
        sql: "CASE\n         when ${TABLE}.deal_currency_code = 'USD' then ${TABLE}.deal_amount\
          \ * .75\n         when ${TABLE}.deal_currency_code = 'CAD' then ${TABLE}.deal_amount\
          \ * .58\n         when ${TABLE}.deal_currency_code = 'EUR' then ${TABLE}.deal_amount\
          \ * 0.90\n         else ${TABLE}.deal_amount end "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label: Reporting
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: "   Invoices Total Net Amount Gbp"
        label_from_parameter:
        label_short: Total Net Amount Gbp
        map_layer:
        name: projects_invoiced.total_net_amount_gbp
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        view: projects_invoiced
        view_label: "   Invoices"
        dynamic: false
        week_start_day: monday
        original_view: invoices_fact
        dimension_group:
        error:
        field_group_variant: Total Net Amount Gbp
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: projects_invoiced
        suggest_dimension: projects_invoiced.total_net_amount_gbp
        suggest_explore: projects_delivered
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Finvoices_fact.view.lkml?line=555"
        permanent: true
        source_file: views/invoices_fact.view.lkml
        source_file_path: analytics/views/invoices_fact.view.lkml
        sql: "${invoice_gbp_amount} - coalesce(${invoice_gbp_tax_amount},0)"
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Staff Satisfaction Avg E Nps
        label_from_parameter:
        label_short: Avg E Nps
        map_layer:
        name: hr_survey_results_fact.avg_e_nps
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: average
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0.00"
        view: hr_survey_results_fact
        view_label: Staff Satisfaction
        dynamic: false
        week_start_day: monday
        original_view: hr_survey_results_fact
        dimension_group:
        error:
        field_group_variant: Avg E Nps
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: hr_survey_results_fact
        suggest_dimension: hr_survey_results_fact.avg_e_nps
        suggest_explore: hr_survey_results_fact
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fhr_survey_results_fact.view.lkml?line=132"
        permanent: true
        source_file: views/hr_survey_results_fact.view.lkml
        source_file_path: analytics/views/hr_survey_results_fact.view.lkml
        sql: "${TABLE}.e_nps "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Certification Progress Total Score
        label_from_parameter:
        label_short: Total Score
        map_layer:
        name: certification_progress.total_score
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format:
        view: certification_progress
        view_label: Certification Progress
        dynamic: false
        week_start_day: monday
        original_view: certification_progress
        dimension_group:
        error:
        field_group_variant: Total Score
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: certification_progress
        suggest_dimension: certification_progress.total_score
        suggest_explore: certification_progress
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fcertification_progress.view.lkml?line=38"
        permanent: true
        source_file: views/certification_progress.view.lkml
        source_file_path: analytics/views/certification_progress.view.lkml
        sql: "${score} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Certification Progress Score Target
        label_from_parameter:
        label_short: Score Target
        map_layer:
        name: certification_progress.score_target
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: average
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format:
        view: certification_progress
        view_label: Certification Progress
        dynamic: false
        week_start_day: monday
        original_view: certification_progress
        dimension_group:
        error:
        field_group_variant: Score Target
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: certification_progress
        suggest_dimension: certification_progress.score_target
        suggest_explore: certification_progress
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fcertification_progress.view.lkml?line=43"
        permanent: true
        source_file: views/certification_progress.view.lkml
        source_file_path: analytics/views/certification_progress.view.lkml
        sql: "${target} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      dimensions:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        enumerations:
        field_group_label: "               Forecast Date"
        fill_style: range
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: false
        label: Utilization                Forecast Month
        label_from_parameter:
        label_short: "               Forecast Month"
        map_layer:
        name: contact_utilization_fact.forecast_month
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: date_month
        user_attribute_filter_types:
        - datetime
        - advanced_filter_datetime
        value_format:
        view: contact_utilization_fact
        view_label: Utilization
        dynamic: false
        week_start_day: monday
        original_view: contact_utilization_fact
        dimension_group: contact_utilization_fact.forecast
        error:
        field_group_variant: Month
        measure: false
        parameter: false
        primary_key: false
        project_name: analytics
        scope: contact_utilization_fact
        suggest_dimension: contact_utilization_fact.forecast_month
        suggest_explore: contact_utilization_fact
        suggestable: false
        is_fiscal: false
        is_timeframe: true
        can_time_filter: false
        time_interval:
          name: month
          count: 1
        lookml_link: "/projects/analytics/files/views%2Fcontact_utilization_fact.view.lkml?line=101"
        permanent: true
        source_file: views/contact_utilization_fact.view.lkml
        source_file_path: analytics/views/contact_utilization_fact.view.lkml
        sql: "${TABLE}.forecast_week "
        sql_case:
        filters:
        times_used: 0
        sorted:
          sort_index: 0
          desc: true
      - type: number
        align: right
        measure: false
        dynamic: false
        can_pivot: false
        is_numeric: true
        name: target_of_projects_ontime
        label: Target % of Projects Ontime
        value_format: "#,##0%"
        is_disabled:
        sortable: true
        aggregate: true
        can_filter: false
        permanent: true
      table_calculations:
      - label: New Deals Pct to Target
        name: new_deals_pct_to_target
        expression: coalesce(${deals_fact.total_deal_amount_gbp_converted}/${targets.total_deals_closed_target},0)
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Revenue Pct to Target
        name: revenue_pct_to_target
        expression: "${projects_invoiced.total_net_amount_gbp}/${targets.total_revenue_target}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Pct of Projects Ontime to Target
        name: pct_of_projects_ontime_to_target
        expression: "${of_projects_ontime}/${target_of_projects_ontime}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Pct of Utilization % to Target
        name: pct_of_utilization_to_target
        expression: "${actual_utilization}/${target_utilization}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Pct eNPS to Target
        name: pct_enps_to_target
        expression: "${hr_survey_results_fact.avg_e_nps}/${targets.avg_enps_target}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Pct Certification Progression to Target
        name: pct_certification_progression_to_target
        expression: "${certification_progress.total_score}/${certification_progress.score_target}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Financial (Weighted 50%)
        name: financial_weighted_50
        expression: "((${new_deals_pct_to_target}*0.5)+(${revenue_pct_to_target}*0.5)*1)"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Process & Customer Perspective (Weighted 30%)
        name: process_customer_perspective_weighted_30
        expression: "((${pct_of_projects_ontime_to_target}*0.5)+(${pct_of_utilization_to_target}*0.5)*1)"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Innovation & Learning Perspective (Weighted 20%)
        name: innovation_learning_perspective_weighted_20
        expression: "((${pct_enps_to_target}*0.5)+(${pct_certification_progression_to_target}*0.5)*1)"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      pivots: []
    dynamic_fields: [{category: table_calculation, expression: 'coalesce(${deals_fact.total_deal_amount_gbp_converted}/${targets.total_deals_closed_target},0)',
        label: New Deals Pct to Target, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: new_deals_pct_to_target, _type_hint: number},
      {category: table_calculation, expression: "${projects_invoiced.total_net_amount_gbp}/${targets.total_revenue_target}",
        label: Revenue Pct to Target, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: revenue_pct_to_target, _type_hint: number},
      {category: table_calculation, expression: "${of_projects_ontime}/${target_of_projects_ontime}",
        label: Pct of Projects Ontime to Target, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: pct_of_projects_ontime_to_target,
        _type_hint: number}, {category: table_calculation, expression: "${actual_utilization}/${target_utilization}",
        label: Pct of Utilization % to Target, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: pct_of_utilization_to_target, _type_hint: number},
      {category: table_calculation, expression: "${hr_survey_results_fact.avg_e_nps}/${targets.avg_enps_target}",
        label: Pct eNPS to Target, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: pct_enps_to_target, _type_hint: number},
      {category: table_calculation, expression: "${certification_progress.total_score}/${certification_progress.score_target}",
        label: Pct Certification Progression to Target, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: pct_certification_progression_to_target,
        _type_hint: number}, {category: table_calculation, expression: "((${new_deals_pct_to_target}*0.5)+(${revenue_pct_to_target}*0.5)*0.5)",
        label: Financial (Weighted 50%), value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: financial_weighted_50, _type_hint: number},
      {category: table_calculation, expression: "((${pct_of_projects_ontime_to_target}*0.5)+(${pct_of_utilization_to_target}*0.5)*0.3)",
        label: Process & Customer Perspective (Weighted 30%), value_format: !!null '',
        value_format_name: percent_0, _kind_hint: measure, table_calculation: process_customer_perspective_weighted_30,
        _type_hint: number}, {category: table_calculation, expression: 'coalesce(((${pct_enps_to_target}*0.5)+(${pct_certification_progression_to_target}*0.5)*0.2),0)',
        label: Innovation & Learning Perspective (Weighted 20%), value_format: !!null '',
        value_format_name: percent_0, _kind_hint: measure, table_calculation: innovation_learning_perspective_weighted_20,
        _type_hint: number}, {category: table_calculation, expression: "${financial_weighted_50}+${process_customer_perspective_weighted_30}+${innovation_learning_perspective_weighted_20}",
        label: Overall Weighted Performance LM, value_format: !!null '', value_format_name: percent_0,
        _kind_hint: measure, table_calculation: overall_weighted_performance_lm, _type_hint: number}]
    row: 9
    col: 20
    width: 4
    height: 7
  - name: " (5)"
    type: text
    title_text: ''
    subtitle_text: Key Company Metrics
    body_text: ''
    row: 2
    col: 0
    width: 24
    height: 1
  - name: Balanced Scorecard
    type: text
    title_text: Balanced Scorecard
    subtitle_text: ''
    body_text: Weighted Overall Performance of the Business based on Kaplan/Norton
      Balanced Scorecard Approach
    row: 8
    col: 0
    width: 24
    height: 1
