- dashboard: utilisation__recognised_attributed_revenue
  title: Utilisation & Recognised Attributed Revenue
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: e28hUsWAdXxeraDE2zJ2Ly
  theme_name: ''
  layout_granularity: granular
  default_dashboard_agent: agent_389
  layout: newspaper
  tabs:
  - name: ''
    label: ''
  elements:
  - name: Monthly Monthly Attributed Revenue and Utilisation L12M
    title: Monthly Monthly Attributed Revenue and Utilisation L12M
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: looker_column
      fields: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_month,
        recognized_project_revenue.total_recognized_revenue_attributed_gbp, team_revenue_targets.revenue_target,
        team_revenue_targets.utilisation_target]
      sorts: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_month]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: "${recognized_project_revenue.total_recognized_revenue_attributed_gbp}/${team_revenue_targets.revenue_target}"
        label: Revenue vs. Target %
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: revenue_vs_target
        _type_hint: number
      filter_expression: matches_filter(${recognized_project_revenue.billing_month_month},
        `after 2025/01/01`) AND matches_filter(${recognized_project_revenue.billing_month_month},
        `before 0 month ago`)
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
      hidden_pivots: {}
      defaults_version: 1
    - model: analytics
      explore: companies_dim
      type: table
      fields: [project_timesheet_users.contact_name, project_timesheets.timesheet_billing_month,
        project_timesheets.total_timesheet_hours_billed, project_timesheets.total_timesheet_billable_hours_billed,
        total_available_hours]
      sorts: [project_timesheets.timesheet_billing_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: measure
        label: Total Available Hours
        based_on: project_timesheets.total_timesheet_hours_billed
        _kind_hint: measure
        measure: total_available_hours
        type: count_distinct
        _type_hint: number
        filters:
          project_timesheet_tasks.task_name: "-Sickness,-Annual Leave"
      join_fields:
      - field_name: project_timesheet_users.contact_name
        source_field_name: recognized_revenue_contact.contact_name
      - field_name: project_timesheets.timesheet_billing_month
        source_field_name: recognized_project_revenue.billing_month_month
    theme: traditional
    customTheme: ''
    layout: fixed
    minWidthForIndexColumns: true
    headerFontSize: 12
    bodyFontSize: 12
    showTooltip: true
    showHighlight: true
    columnOrder: {}
    rowSubtotals: false
    colSubtotals: false
    spanRows: true
    spanCols: true
    calculateOthers: true
    sortColumnsBy: pivots
    useViewName: false
    useHeadings: false
    useShortName: false
    useUnit: false
    groupVarianceColumns: false
    genericLabelForSubtotals: false
    indexColumn: false
    transposeTable: false
    label|recognized_project_revenue.billing_month_month: Billing Month Month
    heading|recognized_project_revenue.billing_month_month: ''
    hide|recognized_project_revenue.billing_month_month: false
    subtotalDepth: '1'
    label|recognized_project_revenue.total_recognized_revenue_attributed_gbp: Revenue
    heading|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    style|recognized_project_revenue.total_recognized_revenue_attributed_gbp: normal
    reportIn|recognized_project_revenue.total_recognized_revenue_attributed_gbp: '1'
    unit|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    comparison|recognized_project_revenue.total_recognized_revenue_attributed_gbp: team_revenue_targets.revenue_target
    switch|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_num|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_pct|recognized_project_revenue.total_recognized_revenue_attributed_gbp: true
    label|team_revenue_targets.revenue_target: Revenue Target
    heading|team_revenue_targets.revenue_target: ''
    style|team_revenue_targets.revenue_target: hide
    reportIn|team_revenue_targets.revenue_target: '1'
    unit|team_revenue_targets.revenue_target: ''
    comparison|team_revenue_targets.revenue_target: no_variance
    switch|team_revenue_targets.revenue_target: false
    var_num|team_revenue_targets.revenue_target: true
    var_pct|team_revenue_targets.revenue_target: false
    label|team_revenue_targets.utilisation_target: Utilisation Target
    heading|team_revenue_targets.utilisation_target: ''
    style|team_revenue_targets.utilisation_target: hide
    reportIn|team_revenue_targets.utilisation_target: '1'
    unit|team_revenue_targets.utilisation_target: ''
    comparison|team_revenue_targets.utilisation_target: no_variance
    switch|team_revenue_targets.utilisation_target: false
    var_num|team_revenue_targets.utilisation_target: true
    var_pct|team_revenue_targets.utilisation_target: false
    label|revenue_vs_target: Revenue vs. Target %
    heading|revenue_vs_target: ''
    style|revenue_vs_target: hide
    reportIn|revenue_vs_target: '1'
    unit|revenue_vs_target: ''
    comparison|revenue_vs_target: no_variance
    switch|revenue_vs_target: false
    var_num|revenue_vs_target: true
    var_pct|revenue_vs_target: false
    label|project_timesheets.total_timesheet_hours_billed: Total Hours
    heading|project_timesheets.total_timesheet_hours_billed: ''
    style|project_timesheets.total_timesheet_hours_billed: hide
    reportIn|project_timesheets.total_timesheet_hours_billed: '1'
    unit|project_timesheets.total_timesheet_hours_billed: ''
    comparison|project_timesheets.total_timesheet_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_hours_billed: false
    var_num|project_timesheets.total_timesheet_hours_billed: false
    var_pct|project_timesheets.total_timesheet_hours_billed: false
    label|project_timesheets.total_timesheet_billable_hours_billed: Total Billable
      Hours
    heading|project_timesheets.total_timesheet_billable_hours_billed: ''
    style|project_timesheets.total_timesheet_billable_hours_billed: hide
    reportIn|project_timesheets.total_timesheet_billable_hours_billed: '1'
    unit|project_timesheets.total_timesheet_billable_hours_billed: ''
    comparison|project_timesheets.total_timesheet_billable_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_billable_hours_billed: false
    var_num|project_timesheets.total_timesheet_billable_hours_billed: false
    var_pct|project_timesheets.total_timesheet_billable_hours_billed: true
    label|recognized_revenue_contact.contact_name: Contact Name
    heading|recognized_revenue_contact.contact_name: ''
    hide|recognized_revenue_contact.contact_name: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      recognized_project_revenue.total_recognized_revenue_attributed_gbp:
        is_active: false
        value_display: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_value_format: {}
    type: marketplace_viz_report_table::report_table-marketplace
    series_types: {}
    hidden_pivots: {}
    query_fields:
      measures:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Total Recognized Revenue Attributed Gbp
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Total Recognized Revenue Attributed Gbp"
        label_from_parameter:
        label_short: Total Recognized Revenue Attributed Gbp
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=80"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${consultant_recognized_attributed_revenue_gbp} "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Revenue Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Revenue Target"
        label_from_parameter:
        label_short: Revenue Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=16"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.revenue_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.revenue_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.revenue_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: team_revenue_targets
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Utilisation Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Utilisation Target"
        label_from_parameter:
        label_short: Utilisation Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=21"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.utilisation_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.utilisation_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.utilisation_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: average_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0%"
        value_format_name: percent_0
        view: team_revenue_targets
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category:
        default_filter_value:
        description:
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant:
        fill_style:
        fiscal_month_offset:
        has_allowed_values:
        has_drills_metadata:
        hidden:
        is_filter:
        is_fiscal:
        is_numeric: true
        is_timeframe:
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter:
        time_interval:
        label: Revenue vs. Target %
        label_from_parameter:
        label_short:
        lookml_link:
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: revenue_vs_target
        strict_value_format:
        parameter:
        period_over_period_params:
        permanent: true
        primary_key:
        project_name:
        requires_refresh_on_sort:
        scope:
        sortable: true
        source_file:
        source_file_path:
        sql:
        sql_case:
        filters:
        suggest_dimension:
        suggest_explore:
        suggestable:
        suggestions:
        synonyms:
        tags:
        type: number
        user_attribute_filter_types:
        value_format: "#,##0%"
        value_format_name:
        view:
        view_label:
        dynamic: false
        week_start_day:
        times_used:
        original_view:
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot: true
        datatype:
        convert_tz:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Hours"
        label_from_parameter:
        label_short: Total Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=123"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        suggest_dimension: project_timesheets.total_timesheet_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Billable Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Billable Hours"
        label_from_parameter:
        label_short: Total Billable Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=134"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_billable_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        - field: project_timesheets.timesheet_is_billable
          condition: 'Yes'
        suggest_dimension: project_timesheets.total_timesheet_billable_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: Total Available Hours
        label_from_parameter:
        label_short: Total Available Hours
        lookml_link:
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: total_available_hours
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name:
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: ''
        source_file_path: ''
        sql:
        sql_case:
        filters:
        suggest_dimension: total_available_hours
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name:
        view: project_timesheets
        view_label: ''
        dynamic: true
        week_start_day: monday
        times_used: 0
        original_view: project_timesheets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      dimensions:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group: recognized_project_revenue.billing_month
        drill_fields:
        enumerations:
        error:
        field_group_label: Billing Month Date
        field_group_variant: Month
        fill_style: range
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: true
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
          name: month
          count: 1
        label: "     Recognised Revenue Billing Month Month"
        label_from_parameter:
        label_short: Billing Month Month
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=13"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_project_revenue.billing_month_month
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${TABLE}.billing_month "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.billing_month_month
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: date_month
        user_attribute_filter_types:
        - datetime
        - advanced_filter_datetime
        value_format:
        value_format_name:
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: DATE
        convert_tz: false
        sorted:
          desc: true
          sort_index: 0
      table_calculations:
      - label: Utilisation
        name: utilisation
        expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${project_timesheets.total_timesheet_hours_billed}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      pivots:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: "      Contact Details"
        field_group_variant: Contact Name
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Contact Name"
        label_from_parameter:
        label_short: Contact Name
        lookml_link: "/projects/analytics/files/views%2Fcontacts_dim.view.lkml?line=486"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_revenue_contact.contact_name
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_revenue_contact
        sortable: true
        source_file: views/contacts_dim.view.lkml
        source_file_path: analytics/views/contacts_dim.view.lkml
        sql: "${TABLE}.contact_name "
        sql_case:
        filters:
        suggest_dimension: recognized_revenue_contact.contact_name
        suggest_explore: companies_dim
        suggestable: true
        suggestions:
        synonyms: []
        tags: []
        type: string
        user_attribute_filter_types:
        - string
        - advanced_filter_string
        value_format:
        value_format_name:
        view: recognized_revenue_contact
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: contacts_dim
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
    pivots: [recognized_revenue_contact.contact_name]
    sorts: [recognized_project_revenue.billing_month_month desc]
    dynamic_fields:
    - category: table_calculation
      expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${total_available_hours}"
      label: Utilisation
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: utilisation
      _type_hint: number
    listen:
    - Contact Name: team_revenue_targets.contact_name
    - Contact Name: project_timesheet_users.contact_name
    row: 26
    col: 0
    width: 72
    height: 18
    tab_name: ''
  - name: Full Year Revenue & Utilization
    title: Full Year Revenue & Utilization
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: looker_column
      fields: [recognized_revenue_contact.contact_name, recognized_project_revenue.total_recognized_revenue_attributed_gbp,
        team_revenue_targets.revenue_target, team_revenue_targets.utilisation_target,
        recognized_project_revenue.billing_month_year]
      filters:
        recognized_project_revenue.billing_month_month: after 2025/01/01
        recognized_revenue_contact.contact_name: "-Giuseppe Mento,-Erik Edelmann,-Olivier\
          \ Dupuis,-Lewis Baker,-Colin Berry,-Mark Rittman,-Bailey Sharpledger"
      sorts: [recognized_revenue_contact.contact_name]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: "${recognized_project_revenue.total_recognized_revenue_attributed_gbp}/${team_revenue_targets.revenue_target}"
        label: Revenue vs. Target %
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: revenue_vs_target
        _type_hint: number
      - category: table_calculation
        expression: if(${recognized_project_revenue.total_recognized_revenue_attributed_gbp}>${team_revenue_targets.revenue_target},${recognized_project_revenue.total_recognized_revenue_attributed_gbp}*0.03,0)
        label: Bonus
        value_format:
        value_format_name: gbp_0
        _kind_hint: measure
        table_calculation: bonus
        _type_hint: number
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
      hidden_pivots: {}
      defaults_version: 1
    - model: analytics
      explore: companies_dim
      type: table
      fields: [project_timesheet_users.contact_name, project_timesheets.total_timesheet_hours_billed,
        project_timesheets.total_timesheet_billable_hours_billed, project_timesheets.timesheet_billing_year]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: project_timesheet_users.contact_name
        source_field_name: recognized_revenue_contact.contact_name
      - field_name: project_timesheets.timesheet_billing_year
        source_field_name: recognized_project_revenue.billing_month_year
    theme: traditional
    customTheme: ''
    layout: fixed
    minWidthForIndexColumns: true
    headerFontSize: 12
    bodyFontSize: 12
    showTooltip: true
    showHighlight: true
    columnOrder: {}
    rowSubtotals: false
    colSubtotals: false
    spanRows: true
    spanCols: true
    calculateOthers: true
    sortColumnsBy: pivots
    useViewName: false
    useHeadings: false
    useShortName: false
    useUnit: false
    groupVarianceColumns: false
    genericLabelForSubtotals: false
    indexColumn: false
    transposeTable: false
    label|recognized_project_revenue.billing_month_month: Billing Month Month
    heading|recognized_project_revenue.billing_month_month: ''
    hide|recognized_project_revenue.billing_month_month: false
    subtotalDepth: '1'
    label|recognized_project_revenue.total_recognized_revenue_attributed_gbp: Revenue
    heading|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    style|recognized_project_revenue.total_recognized_revenue_attributed_gbp: normal
    reportIn|recognized_project_revenue.total_recognized_revenue_attributed_gbp: '1'
    unit|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    comparison|recognized_project_revenue.total_recognized_revenue_attributed_gbp: team_revenue_targets.revenue_target
    switch|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_num|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_pct|recognized_project_revenue.total_recognized_revenue_attributed_gbp: true
    label|team_revenue_targets.revenue_target: Revenue Target
    heading|team_revenue_targets.revenue_target: ''
    style|team_revenue_targets.revenue_target: hide
    reportIn|team_revenue_targets.revenue_target: '1'
    unit|team_revenue_targets.revenue_target: ''
    comparison|team_revenue_targets.revenue_target: no_variance
    switch|team_revenue_targets.revenue_target: false
    var_num|team_revenue_targets.revenue_target: true
    var_pct|team_revenue_targets.revenue_target: false
    label|team_revenue_targets.utilisation_target: Utilisation Target
    heading|team_revenue_targets.utilisation_target: ''
    style|team_revenue_targets.utilisation_target: hide
    reportIn|team_revenue_targets.utilisation_target: '1'
    unit|team_revenue_targets.utilisation_target: ''
    comparison|team_revenue_targets.utilisation_target: no_variance
    switch|team_revenue_targets.utilisation_target: false
    var_num|team_revenue_targets.utilisation_target: true
    var_pct|team_revenue_targets.utilisation_target: false
    label|revenue_vs_target: Revenue vs. Target %
    heading|revenue_vs_target: ''
    style|revenue_vs_target: hide
    reportIn|revenue_vs_target: '1'
    unit|revenue_vs_target: ''
    comparison|revenue_vs_target: no_variance
    switch|revenue_vs_target: false
    var_num|revenue_vs_target: true
    var_pct|revenue_vs_target: false
    label|project_timesheets.total_timesheet_hours_billed: Total Hours
    heading|project_timesheets.total_timesheet_hours_billed: ''
    style|project_timesheets.total_timesheet_hours_billed: hide
    reportIn|project_timesheets.total_timesheet_hours_billed: '1'
    unit|project_timesheets.total_timesheet_hours_billed: ''
    comparison|project_timesheets.total_timesheet_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_hours_billed: false
    var_num|project_timesheets.total_timesheet_hours_billed: false
    var_pct|project_timesheets.total_timesheet_hours_billed: false
    label|project_timesheets.total_timesheet_billable_hours_billed: Total Billable
      Hours
    heading|project_timesheets.total_timesheet_billable_hours_billed: ''
    style|project_timesheets.total_timesheet_billable_hours_billed: hide
    reportIn|project_timesheets.total_timesheet_billable_hours_billed: '1'
    unit|project_timesheets.total_timesheet_billable_hours_billed: ''
    comparison|project_timesheets.total_timesheet_billable_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_billable_hours_billed: false
    var_num|project_timesheets.total_timesheet_billable_hours_billed: false
    var_pct|project_timesheets.total_timesheet_billable_hours_billed: true
    label|recognized_revenue_contact.contact_name: Contact Name
    heading|recognized_revenue_contact.contact_name: ''
    hide|recognized_revenue_contact.contact_name: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      recognized_project_revenue.total_recognized_revenue_attributed_gbp:
        is_active: false
        value_display: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_value_format: {}
    type: marketplace_viz_report_table::report_table-marketplace
    series_types: {}
    hidden_pivots: {}
    query_fields:
      measures:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Total Recognized Revenue Attributed Gbp
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Total Recognized Revenue Attributed Gbp"
        label_from_parameter:
        label_short: Total Recognized Revenue Attributed Gbp
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=80"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${consultant_recognized_attributed_revenue_gbp} "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        sorted:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Revenue Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Revenue Target"
        label_from_parameter:
        label_short: Revenue Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=16"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.revenue_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.revenue_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.revenue_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: team_revenue_targets
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        sorted:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Utilisation Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Utilisation Target"
        label_from_parameter:
        label_short: Utilisation Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=21"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.utilisation_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.utilisation_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.utilisation_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: average_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0%"
        value_format_name: percent_0
        view: team_revenue_targets
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        sorted:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category:
        default_filter_value:
        description:
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant:
        fill_style:
        fiscal_month_offset:
        has_allowed_values:
        has_drills_metadata:
        hidden:
        is_filter:
        is_fiscal:
        is_numeric: true
        is_timeframe:
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter:
        time_interval:
        label: Revenue vs. Target %
        label_from_parameter:
        label_short:
        lookml_link:
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: revenue_vs_target
        strict_value_format:
        parameter:
        period_over_period_params:
        permanent: true
        primary_key:
        project_name:
        requires_refresh_on_sort:
        scope:
        sortable: true
        source_file:
        source_file_path:
        sql:
        sql_case:
        filters:
        suggest_dimension:
        suggest_explore:
        suggestable:
        suggestions:
        synonyms:
        tags:
        type: number
        user_attribute_filter_types:
        value_format: "#,##0%"
        value_format_name:
        view:
        view_label:
        dynamic: false
        week_start_day:
        times_used:
        original_view:
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        sorted:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot: true
        datatype:
        convert_tz:
      - align: right
        can_filter: false
        category:
        default_filter_value:
        description:
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant:
        fill_style:
        fiscal_month_offset:
        has_allowed_values:
        has_drills_metadata:
        hidden:
        is_filter:
        is_fiscal:
        is_numeric: true
        is_timeframe:
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter:
        time_interval:
        label: Bonus
        label_from_parameter:
        label_short:
        lookml_link:
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: bonus
        strict_value_format:
        parameter:
        period_over_period_params:
        permanent: true
        primary_key:
        project_name:
        requires_refresh_on_sort:
        scope:
        sortable: true
        source_file:
        source_file_path:
        sql:
        sql_case:
        filters:
        suggest_dimension:
        suggest_explore:
        suggestable:
        suggestions:
        synonyms:
        tags:
        type: number
        user_attribute_filter_types:
        value_format: '"£"#,##0'
        value_format_name:
        view:
        view_label:
        dynamic: false
        week_start_day:
        times_used:
        original_view:
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        sorted:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot: true
        datatype:
        convert_tz:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Hours"
        label_from_parameter:
        label_short: Total Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=123"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        suggest_dimension: project_timesheets.total_timesheet_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        sorted:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Billable Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Billable Hours"
        label_from_parameter:
        label_short: Total Billable Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=134"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_billable_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        - field: project_timesheets.timesheet_is_billable
          condition: 'Yes'
        suggest_dimension: project_timesheets.total_timesheet_billable_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        sorted:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      dimensions:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group: recognized_project_revenue.billing_month
        drill_fields:
        enumerations:
        error:
        field_group_label: Billing Month Date
        field_group_variant: Year
        fill_style: range
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: true
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
          name: year
          count: 1
        label: "     Recognised Revenue Billing Month Year"
        label_from_parameter:
        label_short: Billing Month Year
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=13"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_project_revenue.billing_month_year
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${TABLE}.billing_month "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.billing_month_year
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: date_year
        user_attribute_filter_types:
        - datetime
        - advanced_filter_datetime
        value_format:
        value_format_name:
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        sorted:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: DATE
        convert_tz: false
      table_calculations:
      - label: Utilisation
        name: utilisation
        expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${project_timesheets.total_timesheet_hours_billed}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      pivots:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: "      Contact Details"
        field_group_variant: Contact Name
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Contact Name"
        label_from_parameter:
        label_short: Contact Name
        lookml_link: "/projects/analytics/files/views%2Fcontacts_dim.view.lkml?line=486"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_revenue_contact.contact_name
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_revenue_contact
        sortable: true
        source_file: views/contacts_dim.view.lkml
        source_file_path: analytics/views/contacts_dim.view.lkml
        sql: "${TABLE}.contact_name "
        sql_case:
        filters:
        suggest_dimension: recognized_revenue_contact.contact_name
        suggest_explore: companies_dim
        suggestable: true
        suggestions:
        synonyms: []
        tags: []
        type: string
        user_attribute_filter_types:
        - string
        - advanced_filter_string
        value_format:
        value_format_name:
        view: recognized_revenue_contact
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: contacts_dim
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        sorted:
          sort_index: 0
          desc: false
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
    hidden_fields: [bonus]
    pivots: [recognized_revenue_contact.contact_name]
    dynamic_fields:
    - category: table_calculation
      expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${project_timesheets.total_timesheet_hours_billed}"
      label: Utilisation
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: utilisation
      _type_hint: number
    listen:
    - Contact Name: team_revenue_targets.contact_name
    - Contact Name: project_timesheet_users.contact_name
    row: 104
    col: 0
    width: 72
    height: 10
    tab_name: ''
  - name: Quarterly Revenue, Bonus & Utilization
    title: Quarterly Revenue, Bonus & Utilization
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: looker_column
      fields: [recognized_revenue_contact.contact_name, recognized_project_revenue.total_recognized_revenue_attributed_gbp,
        team_revenue_targets.revenue_target, team_revenue_targets.utilisation_target,
        recognized_project_revenue.billing_month_quarter]
      filters:
        recognized_project_revenue.billing_month_month: after 2025/01/01
      sorts: [recognized_revenue_contact.contact_name]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: "${recognized_project_revenue.total_recognized_revenue_attributed_gbp}/${team_revenue_targets.revenue_target}"
        label: Revenue vs. Target %
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: revenue_vs_target
        _type_hint: number
      - category: table_calculation
        expression: if(${recognized_project_revenue.total_recognized_revenue_attributed_gbp}>${team_revenue_targets.revenue_target},${recognized_project_revenue.total_recognized_revenue_attributed_gbp}*0.03,0)
        label: Bonus
        value_format:
        value_format_name: gbp_0
        _kind_hint: measure
        table_calculation: bonus
        _type_hint: number
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
      hidden_pivots: {}
      defaults_version: 1
    - model: analytics
      explore: companies_dim
      type: table
      fields: [project_timesheet_users.contact_name, project_timesheets.total_timesheet_hours_billed,
        project_timesheets.total_timesheet_billable_hours_billed, project_timesheets.timesheet_billing_quarter]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: project_timesheet_users.contact_name
        source_field_name: recognized_revenue_contact.contact_name
      - field_name: project_timesheets.timesheet_billing_quarter
        source_field_name: recognized_project_revenue.billing_month_quarter
    theme: traditional
    customTheme: ''
    layout: fixed
    minWidthForIndexColumns: true
    headerFontSize: 12
    bodyFontSize: 12
    showTooltip: true
    showHighlight: true
    columnOrder: {}
    rowSubtotals: false
    colSubtotals: false
    spanRows: true
    spanCols: true
    calculateOthers: true
    sortColumnsBy: pivots
    useViewName: false
    useHeadings: false
    useShortName: false
    useUnit: false
    groupVarianceColumns: false
    genericLabelForSubtotals: false
    indexColumn: false
    transposeTable: false
    subtotalDepth: '1'
    label|recognized_project_revenue.total_recognized_revenue_attributed_gbp: Revenue
    heading|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    style|recognized_project_revenue.total_recognized_revenue_attributed_gbp: normal
    reportIn|recognized_project_revenue.total_recognized_revenue_attributed_gbp: '1'
    unit|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    comparison|recognized_project_revenue.total_recognized_revenue_attributed_gbp: team_revenue_targets.revenue_target
    switch|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_num|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_pct|recognized_project_revenue.total_recognized_revenue_attributed_gbp: true
    label|team_revenue_targets.revenue_target: Revenue Target
    heading|team_revenue_targets.revenue_target: ''
    style|team_revenue_targets.revenue_target: hide
    reportIn|team_revenue_targets.revenue_target: '1'
    unit|team_revenue_targets.revenue_target: ''
    comparison|team_revenue_targets.revenue_target: no_variance
    switch|team_revenue_targets.revenue_target: false
    var_num|team_revenue_targets.revenue_target: true
    var_pct|team_revenue_targets.revenue_target: false
    label|team_revenue_targets.utilisation_target: Utilisation Target
    heading|team_revenue_targets.utilisation_target: ''
    style|team_revenue_targets.utilisation_target: hide
    reportIn|team_revenue_targets.utilisation_target: '1'
    unit|team_revenue_targets.utilisation_target: ''
    comparison|team_revenue_targets.utilisation_target: no_variance
    switch|team_revenue_targets.utilisation_target: false
    var_num|team_revenue_targets.utilisation_target: true
    var_pct|team_revenue_targets.utilisation_target: false
    label|revenue_vs_target: Revenue vs. Target %
    heading|revenue_vs_target: ''
    style|revenue_vs_target: hide
    reportIn|revenue_vs_target: '1'
    unit|revenue_vs_target: ''
    comparison|revenue_vs_target: no_variance
    switch|revenue_vs_target: false
    var_num|revenue_vs_target: true
    var_pct|revenue_vs_target: false
    label|project_timesheets.total_timesheet_hours_billed: Total Hours
    heading|project_timesheets.total_timesheet_hours_billed: ''
    style|project_timesheets.total_timesheet_hours_billed: normal
    reportIn|project_timesheets.total_timesheet_hours_billed: '1'
    unit|project_timesheets.total_timesheet_hours_billed: ''
    comparison|project_timesheets.total_timesheet_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_hours_billed: false
    var_num|project_timesheets.total_timesheet_hours_billed: false
    var_pct|project_timesheets.total_timesheet_hours_billed: false
    label|project_timesheets.total_timesheet_billable_hours_billed: Total Billable
      Hours
    heading|project_timesheets.total_timesheet_billable_hours_billed: ''
    style|project_timesheets.total_timesheet_billable_hours_billed: normal
    reportIn|project_timesheets.total_timesheet_billable_hours_billed: '1'
    unit|project_timesheets.total_timesheet_billable_hours_billed: ''
    comparison|project_timesheets.total_timesheet_billable_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_billable_hours_billed: false
    var_num|project_timesheets.total_timesheet_billable_hours_billed: false
    var_pct|project_timesheets.total_timesheet_billable_hours_billed: true
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      recognized_project_revenue.total_recognized_revenue_attributed_gbp:
        is_active: false
        value_display: false
    table_theme: white
    limit_displayed_rows: true
    table_show_footer: false
    table_enable_pagination: false
    table_page_size_options: 20, 50, 100
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '1'
    table_column_hover_highlight_enable: false
    table_show_headers: true
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_bold: false
    header_font_italic: false
    header_font_size: '12'
    rows_font_size: '12'
    cell_font_weight: ''
    cell_font_style: ''
    cell_text_alignment: ''
    table_custom_border_enable: false
    table_custom_border_width:
    table_custom_border_style: solid
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_value_format: {}
    label|recognized_project_revenue.billing_month_month: Billing Month Month
    heading|recognized_project_revenue.billing_month_month: ''
    hide|recognized_project_revenue.billing_month_month: false
    label|recognized_revenue_contact.contact_name: Contact Name
    heading|recognized_revenue_contact.contact_name: ''
    hide|recognized_revenue_contact.contact_name: false
    type: marketplace_viz_report_table::report_table-marketplace
    series_types: {}
    hidden_pivots: {}
    query_fields:
      measures:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Total Recognized Revenue Attributed Gbp
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Recognised Revenue Total Recognized Revenue Attributed Gbp"
        label_from_parameter:
        label_short: Total Recognized Revenue Attributed Gbp
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=80"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${consultant_recognized_attributed_revenue_gbp} "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: recognized_project_revenue
        view_label: "      Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
        available_custom_timeframes:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Revenue Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Recognised Revenue Revenue Target"
        label_from_parameter:
        label_short: Revenue Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=16"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.revenue_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.revenue_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.revenue_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: team_revenue_targets
        view_label: "      Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
        available_custom_timeframes:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Utilisation Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Recognised Revenue Utilisation Target"
        label_from_parameter:
        label_short: Utilisation Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=21"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.utilisation_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.utilisation_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.utilisation_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: average_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0%"
        value_format_name: percent_0
        view: team_revenue_targets
        view_label: "      Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
        available_custom_timeframes:
      - align: right
        can_filter: false
        category:
        default_filter_value:
        description:
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant:
        fill_style:
        fiscal_month_offset:
        has_allowed_values:
        has_drills_metadata:
        hidden:
        is_filter:
        is_fiscal:
        is_numeric: true
        is_timeframe:
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter:
        time_interval:
        label: Revenue vs. Target %
        label_from_parameter:
        label_short:
        lookml_link:
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: revenue_vs_target
        strict_value_format:
        parameter:
        period_over_period_params:
        permanent: true
        primary_key:
        project_name:
        requires_refresh_on_sort:
        scope:
        sortable: true
        source_file:
        source_file_path:
        sql:
        sql_case:
        filters:
        suggest_dimension:
        suggest_explore:
        suggestable:
        suggestions:
        synonyms:
        tags:
        type: number
        user_attribute_filter_types:
        value_format: "#,##0%"
        value_format_name:
        view:
        view_label:
        dynamic: false
        week_start_day:
        times_used:
        original_view:
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot: true
        datatype:
        convert_tz:
        available_custom_timeframes:
      - align: right
        can_filter: false
        category:
        default_filter_value:
        description:
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant:
        fill_style:
        fiscal_month_offset:
        has_allowed_values:
        has_drills_metadata:
        hidden:
        is_filter:
        is_fiscal:
        is_numeric: true
        is_timeframe:
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter:
        time_interval:
        label: Bonus
        label_from_parameter:
        label_short:
        lookml_link:
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: bonus
        strict_value_format:
        parameter:
        period_over_period_params:
        permanent: true
        primary_key:
        project_name:
        requires_refresh_on_sort:
        scope:
        sortable: true
        source_file:
        source_file_path:
        sql:
        sql_case:
        filters:
        suggest_dimension:
        suggest_explore:
        suggestable:
        suggestions:
        synonyms:
        tags:
        type: number
        user_attribute_filter_types:
        value_format: '"£"#,##0'
        value_format_name:
        view:
        view_label:
        dynamic: false
        week_start_day:
        times_used:
        original_view:
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot: true
        datatype:
        convert_tz:
        available_custom_timeframes:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Hours"
        label_from_parameter:
        label_short: Total Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=123"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        suggest_dimension: project_timesheets.total_timesheet_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
        available_custom_timeframes:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Billable Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Billable Hours"
        label_from_parameter:
        label_short: Total Billable Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=134"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_billable_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        - field: project_timesheets.timesheet_is_billable
          condition: 'Yes'
        suggest_dimension: project_timesheets.total_timesheet_billable_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
        available_custom_timeframes:
      dimensions:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group: recognized_project_revenue.billing_month
        drill_fields:
        enumerations:
        error:
        field_group_label: Billing Month Date
        field_group_variant: Quarter
        fill_style: range
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: true
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
          name: month
          count: 3
        label: "      Recognised Revenue Billing Month Quarter"
        label_from_parameter:
        label_short: Billing Month Quarter
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=13"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_project_revenue.billing_month_quarter
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${TABLE}.billing_month "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.billing_month_quarter
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: date_quarter
        user_attribute_filter_types:
        - datetime
        - advanced_filter_datetime
        value_format:
        value_format_name:
        view: recognized_project_revenue
        view_label: "      Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: DATE
        convert_tz: false
        available_custom_timeframes:
        sorted:
          desc: true
          sort_index: 0
      table_calculations:
      - label: Utilisation
        name: utilisation
        expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${project_timesheets.total_timesheet_hours_billed}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      pivots:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: "      Contact Details"
        field_group_variant: Contact Name
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Recognised Revenue Contact Name"
        label_from_parameter:
        label_short: Contact Name
        lookml_link: "/projects/analytics/files/views%2Fcontacts_dim.view.lkml?line=486"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_revenue_contact.contact_name
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_revenue_contact
        sortable: true
        source_file: views/contacts_dim.view.lkml
        source_file_path: analytics/views/contacts_dim.view.lkml
        sql: "${TABLE}.contact_name "
        sql_case:
        filters:
        suggest_dimension: recognized_revenue_contact.contact_name
        suggest_explore: companies_dim
        suggestable: true
        suggestions:
        synonyms: []
        tags: []
        type: string
        user_attribute_filter_types:
        - string
        - advanced_filter_string
        value_format:
        value_format_name:
        view: recognized_revenue_contact
        view_label: "      Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: contacts_dim
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
        available_custom_timeframes:
    hidden_fields:
    pivots: [recognized_revenue_contact.contact_name]
    sorts: [recognized_project_revenue.billing_month_quarter desc]
    dynamic_fields:
    - category: table_calculation
      expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${project_timesheets.total_timesheet_hours_billed}"
      label: Utilisation
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: utilisation
      _type_hint: number
    listen:
    - Contact Name: team_revenue_targets.contact_name
    - Contact Name: project_timesheet_users.contact_name
    row: 88
    col: 0
    width: 72
    height: 16
    tab_name: ''
  - title: Recognized Revenue Share by Consultant
    name: Recognized Revenue Share by Consultant
    model: analytics
    explore: companies_dim
    type: looker_donut_multiples
    fields: [recognized_project_revenue.billing_month_quarter, recognized_project_revenue.total_recognized_revenue_attributed_gbp,
      recognized_revenue_contact.contact_name]
    pivots: [recognized_revenue_contact.contact_name]
    fill_fields: [recognized_project_revenue.billing_month_quarter]
    filters:
      recognized_project_revenue.billing_month_quarter: 4 quarter ago for 4 quarter
    sorts: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_quarter
        desc]
    limit: 500
    column_limit: 50
    show_value_labels: true
    font_size: 14
    charts_across: 4
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
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
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
    hidden_pivots: {}
    listen:
      Contact Name: team_revenue_targets.contact_name
    row: 72
    col: 0
    width: 36
    height: 16
    tab_name: ''
  - title: Billable Hours Share by Consultant
    name: Billable Hours Share by Consultant
    model: analytics
    explore: companies_dim
    type: looker_donut_multiples
    fields: [recognized_project_revenue.billing_month_quarter, recognized_project_revenue.total_recognized_revenue_attributed_gbp,
      project_timesheets.total_timesheet_billable_hours_billed, recognized_revenue_contact.contact_name]
    pivots: [recognized_revenue_contact.contact_name]
    fill_fields: [recognized_project_revenue.billing_month_quarter]
    filters:
      recognized_project_revenue.billing_month_quarter: 4 quarter ago for 4 quarter
    sorts: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_quarter]
    limit: 500
    column_limit: 50
    show_value_labels: true
    font_size: 14
    charts_across: 4
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
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_fields: [recognized_project_revenue.total_recognized_revenue_attributed_gbp]
    hidden_pivots: {}
    listen:
      Contact Name: team_revenue_targets.contact_name
    row: 72
    col: 36
    width: 36
    height: 16
    tab_name: ''
  - name: New Tile
    title: New Tile
    note_state: collapsed
    note_display: hover
    note_text: Excludes sick days and annual leave
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: looker_column
      fields: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_month,
        recognized_project_revenue.total_recognized_revenue_attributed_gbp, team_revenue_targets.revenue_target,
        team_revenue_targets.utilisation_target]
      filters:
        recognized_project_revenue.billing_month_month: 1 month ago for 1 month
        recognized_revenue_contact.contact_name: "-Giuseppe Mento,-Erik Edelmann,-Olivier\
          \ Dupuis,-Lewis Baker,-Colin Berry,-Mark Rittman,-Bailey Sharpledger"
      sorts: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_month]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: "${recognized_project_revenue.total_recognized_revenue_attributed_gbp}/${team_revenue_targets.revenue_target}"
        label: Revenue vs. Target %
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: revenue_vs_target
        _type_hint: number
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
      hidden_pivots: {}
      defaults_version: 1
    - model: analytics
      explore: companies_dim
      type: table
      fields: [project_timesheet_users.contact_name, project_timesheets.timesheet_billing_month,
        project_timesheets.total_timesheet_hours_billed, project_timesheets.total_timesheet_billable_hours_billed,
        total_available_hours]
      sorts: [project_timesheets.timesheet_billing_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: measure
        label: Total Available Hours
        based_on: project_timesheets.total_timesheet_hours_billed
        _kind_hint: measure
        measure: total_available_hours
        type: count_distinct
        _type_hint: number
        filters:
          project_timesheet_tasks.task_name: "-Sickness,-Annual Leave"
      join_fields:
      - field_name: project_timesheet_users.contact_name
        source_field_name: recognized_revenue_contact.contact_name
      - field_name: project_timesheets.timesheet_billing_month
        source_field_name: recognized_project_revenue.billing_month_month
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Total Available Hours
    smart_single_value_size: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    theme: traditional
    customTheme: ''
    layout: fixed
    minWidthForIndexColumns: true
    headerFontSize: 12
    bodyFontSize: 12
    showTooltip: true
    showHighlight: true
    columnOrder: {}
    rowSubtotals: false
    colSubtotals: false
    spanRows: true
    spanCols: true
    calculateOthers: true
    sortColumnsBy: pivots
    useViewName: false
    useHeadings: false
    useShortName: false
    useUnit: false
    groupVarianceColumns: false
    genericLabelForSubtotals: false
    indexColumn: false
    transposeTable: false
    label|recognized_project_revenue.billing_month_month: Billing Month Month
    heading|recognized_project_revenue.billing_month_month: ''
    hide|recognized_project_revenue.billing_month_month: false
    subtotalDepth: '1'
    label|recognized_project_revenue.total_recognized_revenue_attributed_gbp: Revenue
    heading|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    style|recognized_project_revenue.total_recognized_revenue_attributed_gbp: normal
    reportIn|recognized_project_revenue.total_recognized_revenue_attributed_gbp: '1'
    unit|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    comparison|recognized_project_revenue.total_recognized_revenue_attributed_gbp: team_revenue_targets.revenue_target
    switch|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_num|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_pct|recognized_project_revenue.total_recognized_revenue_attributed_gbp: true
    label|team_revenue_targets.revenue_target: Revenue Target
    heading|team_revenue_targets.revenue_target: ''
    style|team_revenue_targets.revenue_target: hide
    reportIn|team_revenue_targets.revenue_target: '1'
    unit|team_revenue_targets.revenue_target: ''
    comparison|team_revenue_targets.revenue_target: no_variance
    switch|team_revenue_targets.revenue_target: false
    var_num|team_revenue_targets.revenue_target: true
    var_pct|team_revenue_targets.revenue_target: false
    label|team_revenue_targets.utilisation_target: Utilisation Target
    heading|team_revenue_targets.utilisation_target: ''
    style|team_revenue_targets.utilisation_target: hide
    reportIn|team_revenue_targets.utilisation_target: '1'
    unit|team_revenue_targets.utilisation_target: ''
    comparison|team_revenue_targets.utilisation_target: no_variance
    switch|team_revenue_targets.utilisation_target: false
    var_num|team_revenue_targets.utilisation_target: true
    var_pct|team_revenue_targets.utilisation_target: false
    label|revenue_vs_target: Revenue vs. Target %
    heading|revenue_vs_target: ''
    style|revenue_vs_target: hide
    reportIn|revenue_vs_target: '1'
    unit|revenue_vs_target: ''
    comparison|revenue_vs_target: no_variance
    switch|revenue_vs_target: false
    var_num|revenue_vs_target: true
    var_pct|revenue_vs_target: false
    label|project_timesheets.total_timesheet_hours_billed: Total Hours
    heading|project_timesheets.total_timesheet_hours_billed: ''
    style|project_timesheets.total_timesheet_hours_billed: hide
    reportIn|project_timesheets.total_timesheet_hours_billed: '1'
    unit|project_timesheets.total_timesheet_hours_billed: ''
    comparison|project_timesheets.total_timesheet_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_hours_billed: false
    var_num|project_timesheets.total_timesheet_hours_billed: false
    var_pct|project_timesheets.total_timesheet_hours_billed: false
    label|project_timesheets.total_timesheet_billable_hours_billed: Total Billable
      Hours
    heading|project_timesheets.total_timesheet_billable_hours_billed: ''
    style|project_timesheets.total_timesheet_billable_hours_billed: hide
    reportIn|project_timesheets.total_timesheet_billable_hours_billed: '1'
    unit|project_timesheets.total_timesheet_billable_hours_billed: ''
    comparison|project_timesheets.total_timesheet_billable_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_billable_hours_billed: false
    var_num|project_timesheets.total_timesheet_billable_hours_billed: false
    var_pct|project_timesheets.total_timesheet_billable_hours_billed: true
    label|recognized_revenue_contact.contact_name: Contact Name
    heading|recognized_revenue_contact.contact_name: ''
    hide|recognized_revenue_contact.contact_name: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      recognized_project_revenue.total_recognized_revenue_attributed_gbp:
        is_active: false
        value_display: false
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    series_value_format: {}
    type: single_value
    series_types: {}
    hidden_pivots:
      Alex Caldwell:
        measure_names:
        - project_timesheets.total_timesheet_hours_billed
    query_fields:
      measures:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Total Recognized Revenue Attributed Gbp
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Total Recognized Revenue Attributed Gbp"
        label_from_parameter:
        label_short: Total Recognized Revenue Attributed Gbp
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=80"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${consultant_recognized_attributed_revenue_gbp} "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Revenue Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Revenue Target"
        label_from_parameter:
        label_short: Revenue Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=16"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.revenue_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.revenue_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.revenue_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: team_revenue_targets
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Utilisation Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Utilisation Target"
        label_from_parameter:
        label_short: Utilisation Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=21"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.utilisation_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.utilisation_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.utilisation_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: average_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0%"
        value_format_name: percent_0
        view: team_revenue_targets
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category:
        default_filter_value:
        description:
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant:
        fill_style:
        fiscal_month_offset:
        has_allowed_values:
        has_drills_metadata:
        hidden:
        is_filter:
        is_fiscal:
        is_numeric: true
        is_timeframe:
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter:
        time_interval:
        label: Revenue vs. Target %
        label_from_parameter:
        label_short:
        lookml_link:
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: revenue_vs_target
        strict_value_format:
        parameter:
        period_over_period_params:
        permanent: true
        primary_key:
        project_name:
        requires_refresh_on_sort:
        scope:
        sortable: true
        source_file:
        source_file_path:
        sql:
        sql_case:
        filters:
        suggest_dimension:
        suggest_explore:
        suggestable:
        suggestions:
        synonyms:
        tags:
        type: number
        user_attribute_filter_types:
        value_format: "#,##0%"
        value_format_name:
        view:
        view_label:
        dynamic: false
        week_start_day:
        times_used:
        original_view:
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot: true
        datatype:
        convert_tz:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Hours"
        label_from_parameter:
        label_short: Total Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=123"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        suggest_dimension: project_timesheets.total_timesheet_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Billable Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Billable Hours"
        label_from_parameter:
        label_short: Total Billable Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=134"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_billable_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        - field: project_timesheets.timesheet_is_billable
          condition: 'Yes'
        suggest_dimension: project_timesheets.total_timesheet_billable_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      dimensions:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group: recognized_project_revenue.billing_month
        drill_fields:
        enumerations:
        error:
        field_group_label: Billing Month Date
        field_group_variant: Month
        fill_style: range
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: true
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
          name: month
          count: 1
        label: "     Recognised Revenue Billing Month Month"
        label_from_parameter:
        label_short: Billing Month Month
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=13"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_project_revenue.billing_month_month
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${TABLE}.billing_month "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.billing_month_month
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: date_month
        user_attribute_filter_types:
        - datetime
        - advanced_filter_datetime
        value_format:
        value_format_name:
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: DATE
        convert_tz: false
        sorted:
          desc: true
          sort_index: 0
      table_calculations:
      - label: Utilisation
        name: utilisation
        expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${project_timesheets.total_timesheet_hours_billed}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Total Hours
        name: total_hours
        expression: sum(pivot_row(${project_timesheets.total_timesheet_hours_billed}))
        can_pivot: false
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0"
        is_numeric: true
      pivots:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: "      Contact Details"
        field_group_variant: Contact Name
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Contact Name"
        label_from_parameter:
        label_short: Contact Name
        lookml_link: "/projects/analytics/files/views%2Fcontacts_dim.view.lkml?line=486"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_revenue_contact.contact_name
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_revenue_contact
        sortable: true
        source_file: views/contacts_dim.view.lkml
        source_file_path: analytics/views/contacts_dim.view.lkml
        sql: "${TABLE}.contact_name "
        sql_case:
        filters:
        suggest_dimension: recognized_revenue_contact.contact_name
        suggest_explore: companies_dim
        suggestable: true
        suggestions:
        synonyms: []
        tags: []
        type: string
        user_attribute_filter_types:
        - string
        - advanced_filter_string
        value_format:
        value_format_name:
        view: recognized_revenue_contact
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: contacts_dim
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
    hidden_fields: [recognized_project_revenue.total_recognized_revenue_attributed_gbp,
      team_revenue_targets.revenue_target, team_revenue_targets.utilisation_target,
      revenue_vs_target, project_timesheets.total_timesheet_billable_hours_billed,
      utilisation, recognized_project_revenue.billing_month_month, project_timesheets.total_timesheet_hours_billed,
      total_available_hours]
    pivots: [recognized_revenue_contact.contact_name]
    sorts: [recognized_project_revenue.billing_month_month desc]
    dynamic_fields:
    - category: table_calculation
      expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${project_timesheets.total_timesheet_hours_billed}"
      label: Utilisation
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: utilisation
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${project_timesheets.total_timesheet_hours_billed}))
      label: Total Hours
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: total_hours
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${project_timesheets.total_timesheet_billable_hours_billed}))
      label: Total Billed Hours
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: total_billed_hours
      _type_hint: number
    row: 4
    col: 0
    width: 15
    height: 6
    tab_name: ''
  - name: New Tile (2)
    title: New Tile
    note_state: collapsed
    note_display: hover
    note_text: Excludes sick days and annual leave
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: looker_column
      fields: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_month,
        recognized_project_revenue.total_recognized_revenue_attributed_gbp, team_revenue_targets.revenue_target,
        team_revenue_targets.utilisation_target]
      filters:
        recognized_project_revenue.billing_month_month: 1 month ago for 1 month
        recognized_revenue_contact.contact_name: "-Giuseppe Mento,-Erik Edelmann,-Olivier\
          \ Dupuis,-Lewis Baker,-Colin Berry,-Mark Rittman,-Bailey Sharpledger"
      sorts: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_month]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: "${recognized_project_revenue.total_recognized_revenue_attributed_gbp}/${team_revenue_targets.revenue_target}"
        label: Revenue vs. Target %
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: revenue_vs_target
        _type_hint: number
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
      hidden_pivots: {}
      defaults_version: 1
    - model: analytics
      explore: companies_dim
      type: looker_column
      fields: [project_timesheet_users.contact_name, project_timesheets.timesheet_billing_month,
        project_timesheets.total_timesheet_hours_billed, project_timesheets.total_timesheet_billable_hours_billed,
        total_available_hours]
      sorts: [project_timesheets.timesheet_billing_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: measure
        label: Total Available Hours
        based_on: project_timesheets.total_timesheet_hours_billed
        _kind_hint: measure
        measure: total_available_hours
        type: count_distinct
        _type_hint: number
        filters:
          project_timesheet_tasks.task_name: "-Sickness,-Annual Leave"
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
      join_fields:
      - field_name: project_timesheet_users.contact_name
        source_field_name: recognized_revenue_contact.contact_name
      - field_name: project_timesheets.timesheet_billing_month
        source_field_name: recognized_project_revenue.billing_month_month
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Average Utilisation %
    smart_single_value_size: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    theme: traditional
    customTheme: ''
    layout: fixed
    minWidthForIndexColumns: true
    headerFontSize: 12
    bodyFontSize: 12
    showTooltip: true
    showHighlight: true
    columnOrder: {}
    rowSubtotals: false
    colSubtotals: false
    spanRows: true
    spanCols: true
    calculateOthers: true
    sortColumnsBy: pivots
    useViewName: false
    useHeadings: false
    useShortName: false
    useUnit: false
    groupVarianceColumns: false
    genericLabelForSubtotals: false
    indexColumn: false
    transposeTable: false
    label|recognized_project_revenue.billing_month_month: Billing Month Month
    heading|recognized_project_revenue.billing_month_month: ''
    hide|recognized_project_revenue.billing_month_month: false
    subtotalDepth: '1'
    label|recognized_project_revenue.total_recognized_revenue_attributed_gbp: Revenue
    heading|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    style|recognized_project_revenue.total_recognized_revenue_attributed_gbp: normal
    reportIn|recognized_project_revenue.total_recognized_revenue_attributed_gbp: '1'
    unit|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    comparison|recognized_project_revenue.total_recognized_revenue_attributed_gbp: team_revenue_targets.revenue_target
    switch|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_num|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_pct|recognized_project_revenue.total_recognized_revenue_attributed_gbp: true
    label|team_revenue_targets.revenue_target: Revenue Target
    heading|team_revenue_targets.revenue_target: ''
    style|team_revenue_targets.revenue_target: hide
    reportIn|team_revenue_targets.revenue_target: '1'
    unit|team_revenue_targets.revenue_target: ''
    comparison|team_revenue_targets.revenue_target: no_variance
    switch|team_revenue_targets.revenue_target: false
    var_num|team_revenue_targets.revenue_target: true
    var_pct|team_revenue_targets.revenue_target: false
    label|team_revenue_targets.utilisation_target: Utilisation Target
    heading|team_revenue_targets.utilisation_target: ''
    style|team_revenue_targets.utilisation_target: hide
    reportIn|team_revenue_targets.utilisation_target: '1'
    unit|team_revenue_targets.utilisation_target: ''
    comparison|team_revenue_targets.utilisation_target: no_variance
    switch|team_revenue_targets.utilisation_target: false
    var_num|team_revenue_targets.utilisation_target: true
    var_pct|team_revenue_targets.utilisation_target: false
    label|revenue_vs_target: Revenue vs. Target %
    heading|revenue_vs_target: ''
    style|revenue_vs_target: hide
    reportIn|revenue_vs_target: '1'
    unit|revenue_vs_target: ''
    comparison|revenue_vs_target: no_variance
    switch|revenue_vs_target: false
    var_num|revenue_vs_target: true
    var_pct|revenue_vs_target: false
    label|project_timesheets.total_timesheet_hours_billed: Total Hours
    heading|project_timesheets.total_timesheet_hours_billed: ''
    style|project_timesheets.total_timesheet_hours_billed: hide
    reportIn|project_timesheets.total_timesheet_hours_billed: '1'
    unit|project_timesheets.total_timesheet_hours_billed: ''
    comparison|project_timesheets.total_timesheet_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_hours_billed: false
    var_num|project_timesheets.total_timesheet_hours_billed: false
    var_pct|project_timesheets.total_timesheet_hours_billed: false
    label|project_timesheets.total_timesheet_billable_hours_billed: Total Billable
      Hours
    heading|project_timesheets.total_timesheet_billable_hours_billed: ''
    style|project_timesheets.total_timesheet_billable_hours_billed: hide
    reportIn|project_timesheets.total_timesheet_billable_hours_billed: '1'
    unit|project_timesheets.total_timesheet_billable_hours_billed: ''
    comparison|project_timesheets.total_timesheet_billable_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_billable_hours_billed: false
    var_num|project_timesheets.total_timesheet_billable_hours_billed: false
    var_pct|project_timesheets.total_timesheet_billable_hours_billed: true
    label|recognized_revenue_contact.contact_name: Contact Name
    heading|recognized_revenue_contact.contact_name: ''
    hide|recognized_revenue_contact.contact_name: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      recognized_project_revenue.total_recognized_revenue_attributed_gbp:
        is_active: false
        value_display: false
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    series_value_format: {}
    type: single_value
    series_types: {}
    hidden_pivots:
      Alex Caldwell:
        measure_names:
        - project_timesheets.total_timesheet_hours_billed
    query_fields:
      measures:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Total Recognized Revenue Attributed Gbp
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Total Recognized Revenue Attributed Gbp"
        label_from_parameter:
        label_short: Total Recognized Revenue Attributed Gbp
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=80"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${consultant_recognized_attributed_revenue_gbp} "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Revenue Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Revenue Target"
        label_from_parameter:
        label_short: Revenue Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=16"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.revenue_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.revenue_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.revenue_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: team_revenue_targets
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Utilisation Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Utilisation Target"
        label_from_parameter:
        label_short: Utilisation Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=21"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.utilisation_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.utilisation_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.utilisation_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: average_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0%"
        value_format_name: percent_0
        view: team_revenue_targets
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category:
        default_filter_value:
        description:
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant:
        fill_style:
        fiscal_month_offset:
        has_allowed_values:
        has_drills_metadata:
        hidden:
        is_filter:
        is_fiscal:
        is_numeric: true
        is_timeframe:
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter:
        time_interval:
        label: Revenue vs. Target %
        label_from_parameter:
        label_short:
        lookml_link:
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: revenue_vs_target
        strict_value_format:
        parameter:
        period_over_period_params:
        permanent: true
        primary_key:
        project_name:
        requires_refresh_on_sort:
        scope:
        sortable: true
        source_file:
        source_file_path:
        sql:
        sql_case:
        filters:
        suggest_dimension:
        suggest_explore:
        suggestable:
        suggestions:
        synonyms:
        tags:
        type: number
        user_attribute_filter_types:
        value_format: "#,##0%"
        value_format_name:
        view:
        view_label:
        dynamic: false
        week_start_day:
        times_used:
        original_view:
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot: true
        datatype:
        convert_tz:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Hours"
        label_from_parameter:
        label_short: Total Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=123"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        suggest_dimension: project_timesheets.total_timesheet_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Billable Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Billable Hours"
        label_from_parameter:
        label_short: Total Billable Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=134"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_billable_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        - field: project_timesheets.timesheet_is_billable
          condition: 'Yes'
        suggest_dimension: project_timesheets.total_timesheet_billable_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      dimensions:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group: recognized_project_revenue.billing_month
        drill_fields:
        enumerations:
        error:
        field_group_label: Billing Month Date
        field_group_variant: Month
        fill_style: range
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: true
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
          name: month
          count: 1
        label: "     Recognised Revenue Billing Month Month"
        label_from_parameter:
        label_short: Billing Month Month
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=13"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_project_revenue.billing_month_month
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${TABLE}.billing_month "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.billing_month_month
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: date_month
        user_attribute_filter_types:
        - datetime
        - advanced_filter_datetime
        value_format:
        value_format_name:
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: DATE
        convert_tz: false
        sorted:
          desc: true
          sort_index: 0
      table_calculations:
      - label: Utilisation
        name: utilisation
        expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${project_timesheets.total_timesheet_hours_billed}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Total Hours
        name: total_hours
        expression: sum(pivot_row(${project_timesheets.total_timesheet_hours_billed}))
        can_pivot: false
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0"
        is_numeric: true
      pivots:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: "      Contact Details"
        field_group_variant: Contact Name
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Contact Name"
        label_from_parameter:
        label_short: Contact Name
        lookml_link: "/projects/analytics/files/views%2Fcontacts_dim.view.lkml?line=486"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_revenue_contact.contact_name
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_revenue_contact
        sortable: true
        source_file: views/contacts_dim.view.lkml
        source_file_path: analytics/views/contacts_dim.view.lkml
        sql: "${TABLE}.contact_name "
        sql_case:
        filters:
        suggest_dimension: recognized_revenue_contact.contact_name
        suggest_explore: companies_dim
        suggestable: true
        suggestions:
        synonyms: []
        tags: []
        type: string
        user_attribute_filter_types:
        - string
        - advanced_filter_string
        value_format:
        value_format_name:
        view: recognized_revenue_contact
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: contacts_dim
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
    hidden_fields: [recognized_project_revenue.total_recognized_revenue_attributed_gbp,
      team_revenue_targets.revenue_target, team_revenue_targets.utilisation_target,
      revenue_vs_target, project_timesheets.total_timesheet_billable_hours_billed,
      utilisation, recognized_project_revenue.billing_month_month, project_timesheets.total_timesheet_hours_billed,
      total_hours, total_billed_hours, total_available_hours]
    pivots: [recognized_revenue_contact.contact_name]
    sorts: [recognized_project_revenue.billing_month_month desc]
    dynamic_fields:
    - category: table_calculation
      expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${total_available_hours}"
      label: Utilisation
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: utilisation
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${total_available_hours}))
      label: Total Hours
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: total_hours
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${project_timesheets.total_timesheet_billable_hours_billed}))
      label: Total Billed Hours
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: total_billed_hours
      _type_hint: number
    - category: table_calculation
      expression: "${total_billed_hours}/${total_hours}"
      label: Avg. Utilisation %
      value_format:
      value_format_name: percent_0
      _kind_hint: supermeasure
      table_calculation: avg_utilisation
      _type_hint: number
    row: 4
    col: 15
    width: 15
    height: 6
    tab_name: ''
  - name: New Tile (3)
    title: New Tile
    note_state: collapsed
    note_display: above
    note_text: Target revenue for our capacity for the month, note not the same as
      our sales revenue target
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: looker_column
      fields: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_month,
        recognized_project_revenue.total_recognized_revenue_attributed_gbp, team_revenue_targets.revenue_target,
        team_revenue_targets.utilisation_target]
      filters:
        recognized_project_revenue.billing_month_month: 1 month ago for 1 month
        recognized_revenue_contact.contact_name: "-Giuseppe Mento,-Erik Edelmann,-Lewis\
          \ Baker,-Colin Berry,-Mark Rittman,-Bailey Sharpledger"
      sorts: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_month]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: "${recognized_project_revenue.total_recognized_revenue_attributed_gbp}/${team_revenue_targets.revenue_target}"
        label: Revenue vs. Target %
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: revenue_vs_target
        _type_hint: number
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
      hidden_pivots: {}
      defaults_version: 1
    - model: analytics
      explore: companies_dim
      type: table
      fields: [project_timesheet_users.contact_name, project_timesheets.timesheet_billing_month,
        project_timesheets.total_timesheet_hours_billed, project_timesheets.total_timesheet_billable_hours_billed]
      sorts: [project_timesheets.timesheet_billing_month desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: project_timesheet_users.contact_name
        source_field_name: recognized_revenue_contact.contact_name
      - field_name: project_timesheets.timesheet_billing_month
        source_field_name: recognized_project_revenue.billing_month_month
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Target Revenue
    smart_single_value_size: true
    value_format: ''
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    theme: traditional
    customTheme: ''
    layout: fixed
    minWidthForIndexColumns: true
    headerFontSize: 12
    bodyFontSize: 12
    showTooltip: true
    showHighlight: true
    columnOrder: {}
    rowSubtotals: false
    colSubtotals: false
    spanRows: true
    spanCols: true
    calculateOthers: true
    sortColumnsBy: pivots
    useViewName: false
    useHeadings: false
    useShortName: false
    useUnit: false
    groupVarianceColumns: false
    genericLabelForSubtotals: false
    indexColumn: false
    transposeTable: false
    label|recognized_project_revenue.billing_month_month: Billing Month Month
    heading|recognized_project_revenue.billing_month_month: ''
    hide|recognized_project_revenue.billing_month_month: false
    subtotalDepth: '1'
    label|recognized_project_revenue.total_recognized_revenue_attributed_gbp: Revenue
    heading|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    style|recognized_project_revenue.total_recognized_revenue_attributed_gbp: normal
    reportIn|recognized_project_revenue.total_recognized_revenue_attributed_gbp: '1'
    unit|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    comparison|recognized_project_revenue.total_recognized_revenue_attributed_gbp: team_revenue_targets.revenue_target
    switch|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_num|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_pct|recognized_project_revenue.total_recognized_revenue_attributed_gbp: true
    label|team_revenue_targets.revenue_target: Revenue Target
    heading|team_revenue_targets.revenue_target: ''
    style|team_revenue_targets.revenue_target: hide
    reportIn|team_revenue_targets.revenue_target: '1'
    unit|team_revenue_targets.revenue_target: ''
    comparison|team_revenue_targets.revenue_target: no_variance
    switch|team_revenue_targets.revenue_target: false
    var_num|team_revenue_targets.revenue_target: true
    var_pct|team_revenue_targets.revenue_target: false
    label|team_revenue_targets.utilisation_target: Utilisation Target
    heading|team_revenue_targets.utilisation_target: ''
    style|team_revenue_targets.utilisation_target: hide
    reportIn|team_revenue_targets.utilisation_target: '1'
    unit|team_revenue_targets.utilisation_target: ''
    comparison|team_revenue_targets.utilisation_target: no_variance
    switch|team_revenue_targets.utilisation_target: false
    var_num|team_revenue_targets.utilisation_target: true
    var_pct|team_revenue_targets.utilisation_target: false
    label|revenue_vs_target: Revenue vs. Target %
    heading|revenue_vs_target: ''
    style|revenue_vs_target: hide
    reportIn|revenue_vs_target: '1'
    unit|revenue_vs_target: ''
    comparison|revenue_vs_target: no_variance
    switch|revenue_vs_target: false
    var_num|revenue_vs_target: true
    var_pct|revenue_vs_target: false
    label|project_timesheets.total_timesheet_hours_billed: Total Hours
    heading|project_timesheets.total_timesheet_hours_billed: ''
    style|project_timesheets.total_timesheet_hours_billed: hide
    reportIn|project_timesheets.total_timesheet_hours_billed: '1'
    unit|project_timesheets.total_timesheet_hours_billed: ''
    comparison|project_timesheets.total_timesheet_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_hours_billed: false
    var_num|project_timesheets.total_timesheet_hours_billed: false
    var_pct|project_timesheets.total_timesheet_hours_billed: false
    label|project_timesheets.total_timesheet_billable_hours_billed: Total Billable
      Hours
    heading|project_timesheets.total_timesheet_billable_hours_billed: ''
    style|project_timesheets.total_timesheet_billable_hours_billed: hide
    reportIn|project_timesheets.total_timesheet_billable_hours_billed: '1'
    unit|project_timesheets.total_timesheet_billable_hours_billed: ''
    comparison|project_timesheets.total_timesheet_billable_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_billable_hours_billed: false
    var_num|project_timesheets.total_timesheet_billable_hours_billed: false
    var_pct|project_timesheets.total_timesheet_billable_hours_billed: true
    label|recognized_revenue_contact.contact_name: Contact Name
    heading|recognized_revenue_contact.contact_name: ''
    hide|recognized_revenue_contact.contact_name: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      recognized_project_revenue.total_recognized_revenue_attributed_gbp:
        is_active: false
        value_display: false
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    series_value_format: {}
    type: single_value
    series_types: {}
    hidden_pivots:
      Alex Caldwell:
        measure_names:
        - project_timesheets.total_timesheet_hours_billed
    query_fields:
      measures:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Total Recognized Revenue Attributed Gbp
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Total Recognized Revenue Attributed Gbp"
        label_from_parameter:
        label_short: Total Recognized Revenue Attributed Gbp
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=80"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${consultant_recognized_attributed_revenue_gbp} "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Revenue Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Revenue Target"
        label_from_parameter:
        label_short: Revenue Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=16"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.revenue_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.revenue_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.revenue_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: team_revenue_targets
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Utilisation Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Utilisation Target"
        label_from_parameter:
        label_short: Utilisation Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=21"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.utilisation_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.utilisation_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.utilisation_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: average_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0%"
        value_format_name: percent_0
        view: team_revenue_targets
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category:
        default_filter_value:
        description:
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant:
        fill_style:
        fiscal_month_offset:
        has_allowed_values:
        has_drills_metadata:
        hidden:
        is_filter:
        is_fiscal:
        is_numeric: true
        is_timeframe:
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter:
        time_interval:
        label: Revenue vs. Target %
        label_from_parameter:
        label_short:
        lookml_link:
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: revenue_vs_target
        strict_value_format:
        parameter:
        period_over_period_params:
        permanent: true
        primary_key:
        project_name:
        requires_refresh_on_sort:
        scope:
        sortable: true
        source_file:
        source_file_path:
        sql:
        sql_case:
        filters:
        suggest_dimension:
        suggest_explore:
        suggestable:
        suggestions:
        synonyms:
        tags:
        type: number
        user_attribute_filter_types:
        value_format: "#,##0%"
        value_format_name:
        view:
        view_label:
        dynamic: false
        week_start_day:
        times_used:
        original_view:
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot: true
        datatype:
        convert_tz:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Hours"
        label_from_parameter:
        label_short: Total Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=123"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        suggest_dimension: project_timesheets.total_timesheet_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Billable Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Billable Hours"
        label_from_parameter:
        label_short: Total Billable Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=134"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_billable_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        - field: project_timesheets.timesheet_is_billable
          condition: 'Yes'
        suggest_dimension: project_timesheets.total_timesheet_billable_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      dimensions:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group: recognized_project_revenue.billing_month
        drill_fields:
        enumerations:
        error:
        field_group_label: Billing Month Date
        field_group_variant: Month
        fill_style: range
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: true
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
          name: month
          count: 1
        label: "     Recognised Revenue Billing Month Month"
        label_from_parameter:
        label_short: Billing Month Month
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=13"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_project_revenue.billing_month_month
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${TABLE}.billing_month "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.billing_month_month
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: date_month
        user_attribute_filter_types:
        - datetime
        - advanced_filter_datetime
        value_format:
        value_format_name:
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: DATE
        convert_tz: false
        sorted:
          desc: true
          sort_index: 0
      table_calculations:
      - label: Utilisation
        name: utilisation
        expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${project_timesheets.total_timesheet_hours_billed}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Total Hours
        name: total_hours
        expression: sum(pivot_row(${project_timesheets.total_timesheet_hours_billed}))
        can_pivot: false
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0"
        is_numeric: true
      pivots:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: "      Contact Details"
        field_group_variant: Contact Name
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Contact Name"
        label_from_parameter:
        label_short: Contact Name
        lookml_link: "/projects/analytics/files/views%2Fcontacts_dim.view.lkml?line=486"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_revenue_contact.contact_name
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_revenue_contact
        sortable: true
        source_file: views/contacts_dim.view.lkml
        source_file_path: analytics/views/contacts_dim.view.lkml
        sql: "${TABLE}.contact_name "
        sql_case:
        filters:
        suggest_dimension: recognized_revenue_contact.contact_name
        suggest_explore: companies_dim
        suggestable: true
        suggestions:
        synonyms: []
        tags: []
        type: string
        user_attribute_filter_types:
        - string
        - advanced_filter_string
        value_format:
        value_format_name:
        view: recognized_revenue_contact
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: contacts_dim
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
    hidden_fields: [recognized_project_revenue.total_recognized_revenue_attributed_gbp,
      team_revenue_targets.revenue_target, team_revenue_targets.utilisation_target,
      revenue_vs_target, project_timesheets.total_timesheet_billable_hours_billed,
      utilisation, recognized_project_revenue.billing_month_month, project_timesheets.total_timesheet_hours_billed,
      total_hours, total_billed_hours]
    pivots: [recognized_revenue_contact.contact_name]
    sorts: [recognized_project_revenue.billing_month_month desc]
    dynamic_fields:
    - category: table_calculation
      expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${project_timesheets.total_timesheet_hours_billed}"
      label: Utilisation
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: utilisation
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${project_timesheets.total_timesheet_hours_billed}))
      label: Total Hours
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: total_hours
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${project_timesheets.total_timesheet_billable_hours_billed}))
      label: Total Billed Hours
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: total_billed_hours
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${team_revenue_targets.revenue_target}))
      label: Target Revenue
      value_format: '"£"0,"K"'
      value_format_name: __custom
      _kind_hint: supermeasure
      table_calculation: target_revenue
      _type_hint: number
    row: 4
    col: 42
    width: 15
    height: 6
    tab_name: ''
  - name: New Tile (4)
    title: New Tile
    note_state: collapsed
    note_display: hover
    note_text: Disregards annual leave and sickness days i.e. target is not lowered
      for these events
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: looker_column
      fields: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_month,
        recognized_project_revenue.total_recognized_revenue_attributed_gbp, team_revenue_targets.revenue_target,
        team_revenue_targets.utilisation_target]
      filters:
        recognized_project_revenue.billing_month_month: 1 month ago for 1 month
        recognized_revenue_contact.contact_name: "-Lewis Baker,-Mark Rittman"
      sorts: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_month]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: "${recognized_project_revenue.total_recognized_revenue_attributed_gbp}/${team_revenue_targets.revenue_target}"
        label: Revenue vs. Target %
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: revenue_vs_target
        _type_hint: number
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
      hidden_pivots: {}
      defaults_version: 1
    - model: analytics
      explore: companies_dim
      type: table
      fields: [project_timesheet_users.contact_name, project_timesheets.timesheet_billing_month,
        project_timesheets.total_timesheet_hours_billed, project_timesheets.total_timesheet_billable_hours_billed]
      sorts: [project_timesheets.timesheet_billing_month desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: project_timesheet_users.contact_name
        source_field_name: recognized_revenue_contact.contact_name
      - field_name: project_timesheets.timesheet_billing_month
        source_field_name: recognized_project_revenue.billing_month_month
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Attributed Revenue vs Team Target
    smart_single_value_size: true
    value_format: ''
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    theme: traditional
    customTheme: ''
    layout: fixed
    minWidthForIndexColumns: true
    headerFontSize: 12
    bodyFontSize: 12
    showTooltip: true
    showHighlight: true
    columnOrder: {}
    rowSubtotals: false
    colSubtotals: false
    spanRows: true
    spanCols: true
    calculateOthers: true
    sortColumnsBy: pivots
    useViewName: false
    useHeadings: false
    useShortName: false
    useUnit: false
    groupVarianceColumns: false
    genericLabelForSubtotals: false
    indexColumn: false
    transposeTable: false
    label|recognized_project_revenue.billing_month_month: Billing Month Month
    heading|recognized_project_revenue.billing_month_month: ''
    hide|recognized_project_revenue.billing_month_month: false
    subtotalDepth: '1'
    label|recognized_project_revenue.total_recognized_revenue_attributed_gbp: Revenue
    heading|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    style|recognized_project_revenue.total_recognized_revenue_attributed_gbp: normal
    reportIn|recognized_project_revenue.total_recognized_revenue_attributed_gbp: '1'
    unit|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    comparison|recognized_project_revenue.total_recognized_revenue_attributed_gbp: team_revenue_targets.revenue_target
    switch|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_num|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_pct|recognized_project_revenue.total_recognized_revenue_attributed_gbp: true
    label|team_revenue_targets.revenue_target: Revenue Target
    heading|team_revenue_targets.revenue_target: ''
    style|team_revenue_targets.revenue_target: hide
    reportIn|team_revenue_targets.revenue_target: '1'
    unit|team_revenue_targets.revenue_target: ''
    comparison|team_revenue_targets.revenue_target: no_variance
    switch|team_revenue_targets.revenue_target: false
    var_num|team_revenue_targets.revenue_target: true
    var_pct|team_revenue_targets.revenue_target: false
    label|team_revenue_targets.utilisation_target: Utilisation Target
    heading|team_revenue_targets.utilisation_target: ''
    style|team_revenue_targets.utilisation_target: hide
    reportIn|team_revenue_targets.utilisation_target: '1'
    unit|team_revenue_targets.utilisation_target: ''
    comparison|team_revenue_targets.utilisation_target: no_variance
    switch|team_revenue_targets.utilisation_target: false
    var_num|team_revenue_targets.utilisation_target: true
    var_pct|team_revenue_targets.utilisation_target: false
    label|revenue_vs_target: Revenue vs. Target %
    heading|revenue_vs_target: ''
    style|revenue_vs_target: hide
    reportIn|revenue_vs_target: '1'
    unit|revenue_vs_target: ''
    comparison|revenue_vs_target: no_variance
    switch|revenue_vs_target: false
    var_num|revenue_vs_target: true
    var_pct|revenue_vs_target: false
    label|project_timesheets.total_timesheet_hours_billed: Total Hours
    heading|project_timesheets.total_timesheet_hours_billed: ''
    style|project_timesheets.total_timesheet_hours_billed: hide
    reportIn|project_timesheets.total_timesheet_hours_billed: '1'
    unit|project_timesheets.total_timesheet_hours_billed: ''
    comparison|project_timesheets.total_timesheet_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_hours_billed: false
    var_num|project_timesheets.total_timesheet_hours_billed: false
    var_pct|project_timesheets.total_timesheet_hours_billed: false
    label|project_timesheets.total_timesheet_billable_hours_billed: Total Billable
      Hours
    heading|project_timesheets.total_timesheet_billable_hours_billed: ''
    style|project_timesheets.total_timesheet_billable_hours_billed: hide
    reportIn|project_timesheets.total_timesheet_billable_hours_billed: '1'
    unit|project_timesheets.total_timesheet_billable_hours_billed: ''
    comparison|project_timesheets.total_timesheet_billable_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_billable_hours_billed: false
    var_num|project_timesheets.total_timesheet_billable_hours_billed: false
    var_pct|project_timesheets.total_timesheet_billable_hours_billed: true
    label|recognized_revenue_contact.contact_name: Contact Name
    heading|recognized_revenue_contact.contact_name: ''
    hide|recognized_revenue_contact.contact_name: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      recognized_project_revenue.total_recognized_revenue_attributed_gbp:
        is_active: false
        value_display: false
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    series_value_format: {}
    type: single_value
    series_types: {}
    hidden_pivots:
      Alex Caldwell:
        measure_names:
        - project_timesheets.total_timesheet_hours_billed
    query_fields:
      measures:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Total Recognized Revenue Attributed Gbp
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Total Recognized Revenue Attributed Gbp"
        label_from_parameter:
        label_short: Total Recognized Revenue Attributed Gbp
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=80"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${consultant_recognized_attributed_revenue_gbp} "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Revenue Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Revenue Target"
        label_from_parameter:
        label_short: Revenue Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=16"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.revenue_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.revenue_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.revenue_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: team_revenue_targets
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Utilisation Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Utilisation Target"
        label_from_parameter:
        label_short: Utilisation Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=21"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.utilisation_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.utilisation_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.utilisation_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: average_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0%"
        value_format_name: percent_0
        view: team_revenue_targets
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category:
        default_filter_value:
        description:
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant:
        fill_style:
        fiscal_month_offset:
        has_allowed_values:
        has_drills_metadata:
        hidden:
        is_filter:
        is_fiscal:
        is_numeric: true
        is_timeframe:
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter:
        time_interval:
        label: Revenue vs. Target %
        label_from_parameter:
        label_short:
        lookml_link:
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: revenue_vs_target
        strict_value_format:
        parameter:
        period_over_period_params:
        permanent: true
        primary_key:
        project_name:
        requires_refresh_on_sort:
        scope:
        sortable: true
        source_file:
        source_file_path:
        sql:
        sql_case:
        filters:
        suggest_dimension:
        suggest_explore:
        suggestable:
        suggestions:
        synonyms:
        tags:
        type: number
        user_attribute_filter_types:
        value_format: "#,##0%"
        value_format_name:
        view:
        view_label:
        dynamic: false
        week_start_day:
        times_used:
        original_view:
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot: true
        datatype:
        convert_tz:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Hours"
        label_from_parameter:
        label_short: Total Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=123"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        suggest_dimension: project_timesheets.total_timesheet_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Billable Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Billable Hours"
        label_from_parameter:
        label_short: Total Billable Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=134"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_billable_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        - field: project_timesheets.timesheet_is_billable
          condition: 'Yes'
        suggest_dimension: project_timesheets.total_timesheet_billable_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      dimensions:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group: recognized_project_revenue.billing_month
        drill_fields:
        enumerations:
        error:
        field_group_label: Billing Month Date
        field_group_variant: Month
        fill_style: range
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: true
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
          name: month
          count: 1
        label: "     Recognised Revenue Billing Month Month"
        label_from_parameter:
        label_short: Billing Month Month
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=13"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_project_revenue.billing_month_month
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${TABLE}.billing_month "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.billing_month_month
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: date_month
        user_attribute_filter_types:
        - datetime
        - advanced_filter_datetime
        value_format:
        value_format_name:
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: DATE
        convert_tz: false
        sorted:
          desc: true
          sort_index: 0
      table_calculations:
      - label: Utilisation
        name: utilisation
        expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${project_timesheets.total_timesheet_hours_billed}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Total Hours
        name: total_hours
        expression: sum(pivot_row(${project_timesheets.total_timesheet_hours_billed}))
        can_pivot: false
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0"
        is_numeric: true
      pivots:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: "      Contact Details"
        field_group_variant: Contact Name
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Contact Name"
        label_from_parameter:
        label_short: Contact Name
        lookml_link: "/projects/analytics/files/views%2Fcontacts_dim.view.lkml?line=486"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_revenue_contact.contact_name
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_revenue_contact
        sortable: true
        source_file: views/contacts_dim.view.lkml
        source_file_path: analytics/views/contacts_dim.view.lkml
        sql: "${TABLE}.contact_name "
        sql_case:
        filters:
        suggest_dimension: recognized_revenue_contact.contact_name
        suggest_explore: companies_dim
        suggestable: true
        suggestions:
        synonyms: []
        tags: []
        type: string
        user_attribute_filter_types:
        - string
        - advanced_filter_string
        value_format:
        value_format_name:
        view: recognized_revenue_contact
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: contacts_dim
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
    hidden_fields: [recognized_project_revenue.total_recognized_revenue_attributed_gbp,
      team_revenue_targets.revenue_target, team_revenue_targets.utilisation_target,
      revenue_vs_target, project_timesheets.total_timesheet_billable_hours_billed,
      utilisation, recognized_project_revenue.billing_month_month, project_timesheets.total_timesheet_hours_billed,
      total_hours, total_billed_hours, target_revenue, attributed_revenue]
    pivots: [recognized_revenue_contact.contact_name]
    sorts: [recognized_project_revenue.billing_month_month desc]
    dynamic_fields:
    - category: table_calculation
      expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${project_timesheets.total_timesheet_hours_billed}"
      label: Utilisation
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: utilisation
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${project_timesheets.total_timesheet_hours_billed}))
      label: Total Hours
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: total_hours
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${project_timesheets.total_timesheet_billable_hours_billed}))
      label: Total Billed Hours
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: total_billed_hours
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${team_revenue_targets.revenue_target}))
      label: Target Revenue
      value_format: '"£"0,"K"'
      value_format_name: __custom
      _kind_hint: supermeasure
      table_calculation: target_revenue
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${recognized_project_revenue.total_recognized_revenue_attributed_gbp}))
      label: Attributed Revenue
      value_format: '"£"0,"K"'
      value_format_name: __custom
      _kind_hint: supermeasure
      table_calculation: attributed_revenue
      _type_hint: number
    - category: table_calculation
      expression: "${attributed_revenue}/${target_revenue}"
      label: Revenue vs Target %
      value_format:
      value_format_name: percent_0
      _kind_hint: supermeasure
      table_calculation: revenue_vs_target_1
      _type_hint: number
    row: 4
    col: 57
    width: 15
    height: 6
    tab_name: ''
  - title: Hours Split by Category LM
    name: Hours Split by Category LM
    model: analytics
    explore: companies_dim
    type: looker_bar
    fields: [category, project_timesheet_users.contact_name, project_timesheets.total_timesheet_hours_billed]
    pivots: [category]
    filters:
      project_timesheets.timesheet_billing_date: 1 month ago for 1 month
      project_timesheet_users.contact_name: "-Mark Rittman,-Lewis Baker"
    sorts: [category, project_timesheets.total_timesheet_hours_billed desc 0]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: dimension
      description: ''
      label: Category
      value_format:
      value_format_name:
      calculation_type: group_by
      dimension: category
      args:
      - project_timesheet_tasks.task_name
      - - label: Sickness
          filter: Sickness
        - label: Annual Leave
          filter: Annual Leave
        - label: Company Meetings / Admin
          filter: Admin,Ad-hoc Customer Support,Client Account Calls,Cloud Cortex
            POC project,Company Standups and All-Hands,Conference Attendance,Contract
            Writing & Negotiation,Customer Strategy/Tactics,Customer Success,"Customer,
            Project & Supplier Management",Existing Customer Re-Activation,Finance
            & Accounting,G&A,GCP Professional Data Engineer,General Sales/Presales,Internal
            Analytics and Insights,Internal Metrics Development,License Referral Fee,Management
            / Exec Meetings,Marketing,Measurement,Non-Billable Onboarding Time,Non-Billable
            Project Assistance and Client Liaison,Non-Billable R&D Time,Non-Billable
            Support,Non-Billable Team Support & Management,Non-Billable Time,Office
            Management,Offsite Non-Billable Staff Training
      - Client Work
      _kind_hint: dimension
      _type_hint: string
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
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: bottom, series: [{axisId: Annual Leave - project_timesheets.total_timesheet_hours_billed,
            id: Annual Leave - project_timesheets.total_timesheet_hours_billed, name: Annual
              Leave}, {axisId: Client Work - project_timesheets.total_timesheet_hours_billed,
            id: Client Work - project_timesheets.total_timesheet_hours_billed, name: Client
              Work}, {axisId: Company Meetings / Admin - project_timesheets.total_timesheet_hours_billed,
            id: Company Meetings / Admin - project_timesheets.total_timesheet_hours_billed,
            name: Company Meetings / Admin}, {axisId: Sickness - project_timesheets.total_timesheet_hours_billed,
            id: Sickness - project_timesheets.total_timesheet_hours_billed, name: Sickness}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    font_size: '12'
    defaults_version: 1
    hidden_pivots: {}
    value_labels: legend
    label_type: labPer
    title_hidden: true
    listen:
      Contact Name: project_timesheet_users.contact_name
    row: 10
    col: 0
    width: 15
    height: 12
    tab_name: ''
  - title: Target Revenue Variance LM
    name: Target Revenue Variance LM
    model: analytics
    explore: companies_dim
    type: looker_grid
    fields: [recognized_revenue_contact.contact_name, recognized_project_revenue.total_recognized_revenue_attributed_gbp,
      team_revenue_targets.revenue_target]
    filters:
      team_revenue_targets.month_month: 1 month ago for 1 month
    sorts: [recognized_project_revenue.total_recognized_revenue_attributed_gbp desc
        0]
    limit: 500
    column_limit: 50
    total: true
    dynamic_fields:
    - category: table_calculation
      expression: "${recognized_project_revenue.total_recognized_revenue_attributed_gbp}-${team_revenue_targets.revenue_target}"
      label: Target Revenue Variance
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: target_revenue_variance
      _type_hint: number
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
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      target_revenue_variance:
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
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: ''
    legend_position: center
    label_value_format: ''
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
    defaults_version: 1
    hidden_fields: [recognized_project_revenue.total_recognized_revenue_attributed_gbp,
      team_revenue_targets.revenue_target]
    title_hidden: true
    row: 10
    col: 42
    width: 15
    height: 12
    tab_name: ''
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '[{"type":"h2","children":[{"text":"How did the delivery team perform
      last month?"}],"align":"center"},{"type":"p","children":[{"text":"Note that
      utilisation % excludes sickness and annual leave hours, i.e. is based on hours
      available to work"}],"id":"k0p3g","align":"center"}]'
    rich_content_json: '{"format":"slate"}'
    row: 0
    col: 0
    width: 72
    height: 4
    tab_name: ''
  - name: " (2)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '[{"type":"h1","children":[{"text":"How did they perform historically?"}],"align":"center"}]'
    rich_content_json: '{"format":"slate"}'
    row: 22
    col: 0
    width: 72
    height: 4
    tab_name: ''
  - name: Average Utilisation
    title: Average Utilisation
    title_hidden: true
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: looker_column
      fields: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_month,
        recognized_project_revenue.total_recognized_revenue_attributed_gbp, team_revenue_targets.revenue_target,
        team_revenue_targets.utilisation_target]
      filters:
        recognized_project_revenue.billing_month_month: 12 month ago for 12 month
        recognized_revenue_contact.contact_name: "-Mark Rittman,-Lewis Baker,-Olivier\
          \ Dupuis"
      sorts: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_month]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: "${recognized_project_revenue.total_recognized_revenue_attributed_gbp}/${team_revenue_targets.revenue_target}"
        label: Revenue vs. Target %
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: revenue_vs_target
        _type_hint: number
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
      hidden_pivots: {}
      defaults_version: 1
    - model: analytics
      explore: companies_dim
      type: table
      fields: [project_timesheet_users.contact_name, project_timesheets.timesheet_billing_month,
        project_timesheets.total_timesheet_hours_billed, project_timesheets.total_timesheet_billable_hours_billed,
        total_available_hours]
      sorts: [project_timesheets.timesheet_billing_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: measure
        label: Total Available Hours
        based_on: project_timesheets.total_timesheet_hours_billed
        _kind_hint: measure
        measure: total_available_hours
        type: count_distinct
        _type_hint: number
        filters:
          project_timesheet_tasks.task_name: "-Annual Leave,-Sickness"
      join_fields:
      - field_name: project_timesheet_users.contact_name
        source_field_name: recognized_revenue_contact.contact_name
      - field_name: project_timesheets.timesheet_billing_month
        source_field_name: recognized_project_revenue.billing_month_month
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: avg_utilisation, id: avg_utilisation,
            name: Avg. Utilisation %}], showLabels: false, showValues: true, maxValue: 1.25,
        minValue: 0, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
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
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    reference_lines: []
    show_null_points: true
    interpolation: linear
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Average Utilisation %
    smart_single_value_size: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    theme: traditional
    customTheme: ''
    layout: fixed
    minWidthForIndexColumns: true
    headerFontSize: 12
    bodyFontSize: 12
    showTooltip: true
    showHighlight: true
    columnOrder: {}
    rowSubtotals: false
    colSubtotals: false
    spanRows: true
    spanCols: true
    calculateOthers: true
    sortColumnsBy: pivots
    useViewName: false
    useHeadings: false
    useShortName: false
    useUnit: false
    groupVarianceColumns: false
    genericLabelForSubtotals: false
    indexColumn: false
    transposeTable: false
    label|recognized_project_revenue.billing_month_month: Billing Month Month
    heading|recognized_project_revenue.billing_month_month: ''
    hide|recognized_project_revenue.billing_month_month: false
    subtotalDepth: '1'
    label|recognized_project_revenue.total_recognized_revenue_attributed_gbp: Revenue
    heading|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    style|recognized_project_revenue.total_recognized_revenue_attributed_gbp: normal
    reportIn|recognized_project_revenue.total_recognized_revenue_attributed_gbp: '1'
    unit|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    comparison|recognized_project_revenue.total_recognized_revenue_attributed_gbp: team_revenue_targets.revenue_target
    switch|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_num|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_pct|recognized_project_revenue.total_recognized_revenue_attributed_gbp: true
    label|team_revenue_targets.revenue_target: Revenue Target
    heading|team_revenue_targets.revenue_target: ''
    style|team_revenue_targets.revenue_target: hide
    reportIn|team_revenue_targets.revenue_target: '1'
    unit|team_revenue_targets.revenue_target: ''
    comparison|team_revenue_targets.revenue_target: no_variance
    switch|team_revenue_targets.revenue_target: false
    var_num|team_revenue_targets.revenue_target: true
    var_pct|team_revenue_targets.revenue_target: false
    label|team_revenue_targets.utilisation_target: Utilisation Target
    heading|team_revenue_targets.utilisation_target: ''
    style|team_revenue_targets.utilisation_target: hide
    reportIn|team_revenue_targets.utilisation_target: '1'
    unit|team_revenue_targets.utilisation_target: ''
    comparison|team_revenue_targets.utilisation_target: no_variance
    switch|team_revenue_targets.utilisation_target: false
    var_num|team_revenue_targets.utilisation_target: true
    var_pct|team_revenue_targets.utilisation_target: false
    label|revenue_vs_target: Revenue vs. Target %
    heading|revenue_vs_target: ''
    style|revenue_vs_target: hide
    reportIn|revenue_vs_target: '1'
    unit|revenue_vs_target: ''
    comparison|revenue_vs_target: no_variance
    switch|revenue_vs_target: false
    var_num|revenue_vs_target: true
    var_pct|revenue_vs_target: false
    label|project_timesheets.total_timesheet_hours_billed: Total Hours
    heading|project_timesheets.total_timesheet_hours_billed: ''
    style|project_timesheets.total_timesheet_hours_billed: hide
    reportIn|project_timesheets.total_timesheet_hours_billed: '1'
    unit|project_timesheets.total_timesheet_hours_billed: ''
    comparison|project_timesheets.total_timesheet_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_hours_billed: false
    var_num|project_timesheets.total_timesheet_hours_billed: false
    var_pct|project_timesheets.total_timesheet_hours_billed: false
    label|project_timesheets.total_timesheet_billable_hours_billed: Total Billable
      Hours
    heading|project_timesheets.total_timesheet_billable_hours_billed: ''
    style|project_timesheets.total_timesheet_billable_hours_billed: hide
    reportIn|project_timesheets.total_timesheet_billable_hours_billed: '1'
    unit|project_timesheets.total_timesheet_billable_hours_billed: ''
    comparison|project_timesheets.total_timesheet_billable_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_billable_hours_billed: false
    var_num|project_timesheets.total_timesheet_billable_hours_billed: false
    var_pct|project_timesheets.total_timesheet_billable_hours_billed: true
    label|recognized_revenue_contact.contact_name: Contact Name
    heading|recognized_revenue_contact.contact_name: ''
    hide|recognized_revenue_contact.contact_name: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      recognized_project_revenue.total_recognized_revenue_attributed_gbp:
        is_active: false
        value_display: false
    table_theme: white
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    series_value_format: {}
    type: looker_line
    hidden_pivots:
      Alex Caldwell:
        measure_names:
        - project_timesheets.total_timesheet_hours_billed
    query_fields:
      measures:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Total Recognized Revenue Attributed Gbp
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Total Recognized Revenue Attributed Gbp"
        label_from_parameter:
        label_short: Total Recognized Revenue Attributed Gbp
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=80"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${consultant_recognized_attributed_revenue_gbp} "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Revenue Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Revenue Target"
        label_from_parameter:
        label_short: Revenue Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=16"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.revenue_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.revenue_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.revenue_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: team_revenue_targets
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Utilisation Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Utilisation Target"
        label_from_parameter:
        label_short: Utilisation Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=21"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.utilisation_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.utilisation_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.utilisation_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: average_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0%"
        value_format_name: percent_0
        view: team_revenue_targets
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category:
        default_filter_value:
        description:
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant:
        fill_style:
        fiscal_month_offset:
        has_allowed_values:
        has_drills_metadata:
        hidden:
        is_filter:
        is_fiscal:
        is_numeric: true
        is_timeframe:
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter:
        time_interval:
        label: Revenue vs. Target %
        label_from_parameter:
        label_short:
        lookml_link:
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: revenue_vs_target
        strict_value_format:
        parameter:
        period_over_period_params:
        permanent: true
        primary_key:
        project_name:
        requires_refresh_on_sort:
        scope:
        sortable: true
        source_file:
        source_file_path:
        sql:
        sql_case:
        filters:
        suggest_dimension:
        suggest_explore:
        suggestable:
        suggestions:
        synonyms:
        tags:
        type: number
        user_attribute_filter_types:
        value_format: "#,##0%"
        value_format_name:
        view:
        view_label:
        dynamic: false
        week_start_day:
        times_used:
        original_view:
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot: true
        datatype:
        convert_tz:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Hours"
        label_from_parameter:
        label_short: Total Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=123"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        suggest_dimension: project_timesheets.total_timesheet_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Billable Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Billable Hours"
        label_from_parameter:
        label_short: Total Billable Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=134"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_billable_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        - field: project_timesheets.timesheet_is_billable
          condition: 'Yes'
        suggest_dimension: project_timesheets.total_timesheet_billable_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      dimensions:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group: recognized_project_revenue.billing_month
        drill_fields:
        enumerations:
        error:
        field_group_label: Billing Month Date
        field_group_variant: Month
        fill_style: range
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: true
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
          name: month
          count: 1
        label: "     Recognised Revenue Billing Month Month"
        label_from_parameter:
        label_short: Billing Month Month
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=13"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_project_revenue.billing_month_month
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${TABLE}.billing_month "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.billing_month_month
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: date_month
        user_attribute_filter_types:
        - datetime
        - advanced_filter_datetime
        value_format:
        value_format_name:
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: DATE
        convert_tz: false
        sorted:
          desc: true
          sort_index: 0
      table_calculations:
      - label: Utilisation
        name: utilisation
        expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${project_timesheets.total_timesheet_hours_billed}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Total Hours
        name: total_hours
        expression: sum(pivot_row(${project_timesheets.total_timesheet_hours_billed}))
        can_pivot: false
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0"
        is_numeric: true
      pivots:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: "      Contact Details"
        field_group_variant: Contact Name
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Contact Name"
        label_from_parameter:
        label_short: Contact Name
        lookml_link: "/projects/analytics/files/views%2Fcontacts_dim.view.lkml?line=486"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_revenue_contact.contact_name
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_revenue_contact
        sortable: true
        source_file: views/contacts_dim.view.lkml
        source_file_path: analytics/views/contacts_dim.view.lkml
        sql: "${TABLE}.contact_name "
        sql_case:
        filters:
        suggest_dimension: recognized_revenue_contact.contact_name
        suggest_explore: companies_dim
        suggestable: true
        suggestions:
        synonyms: []
        tags: []
        type: string
        user_attribute_filter_types:
        - string
        - advanced_filter_string
        value_format:
        value_format_name:
        view: recognized_revenue_contact
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: contacts_dim
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
    hidden_fields: [recognized_project_revenue.total_recognized_revenue_attributed_gbp,
      team_revenue_targets.revenue_target, team_revenue_targets.utilisation_target,
      revenue_vs_target, project_timesheets.total_timesheet_billable_hours_billed,
      utilisation, project_timesheets.total_timesheet_hours_billed, total_hours, total_billed_hours,
      total_available_hours]
    pivots: [recognized_revenue_contact.contact_name]
    sorts: [recognized_project_revenue.billing_month_month desc]
    dynamic_fields:
    - category: table_calculation
      expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${project_timesheets.total_timesheet_hours_billed}"
      label: Utilisation
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: utilisation
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${total_available_hours}))
      label: Total Hours
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: total_hours
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${project_timesheets.total_timesheet_billable_hours_billed}))
      label: Total Billed Hours
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: total_billed_hours
      _type_hint: number
    - category: table_calculation
      expression: "${total_billed_hours}/${total_hours}"
      label: Avg. Utilisation %
      value_format:
      value_format_name: percent_0
      _kind_hint: supermeasure
      table_calculation: avg_utilisation
      _type_hint: number
    row: 10
    col: 15
    width: 15
    height: 12
    tab_name: ''
  - name: Attributed Revenu
    title: Attributed Revenu
    title_hidden: true
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: looker_column
      fields: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_month,
        recognized_project_revenue.total_recognized_revenue_attributed_gbp, team_revenue_targets.revenue_target,
        team_revenue_targets.utilisation_target]
      filters:
        recognized_project_revenue.billing_month_month: 12 month ago for 12 month
        recognized_revenue_contact.contact_name: "-Lewis Baker,-Mark Rittman"
      sorts: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_month]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: "${recognized_project_revenue.total_recognized_revenue_attributed_gbp}/${team_revenue_targets.revenue_target}"
        label: Revenue vs. Target %
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: revenue_vs_target
        _type_hint: number
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
      hidden_pivots: {}
      defaults_version: 1
    - model: analytics
      explore: companies_dim
      type: table
      fields: [project_timesheet_users.contact_name, project_timesheets.timesheet_billing_month,
        project_timesheets.total_timesheet_hours_billed, project_timesheets.total_timesheet_billable_hours_billed]
      sorts: [project_timesheets.timesheet_billing_month desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: project_timesheet_users.contact_name
        source_field_name: recognized_revenue_contact.contact_name
      - field_name: project_timesheets.timesheet_billing_month
        source_field_name: recognized_project_revenue.billing_month_month
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: revenue_vs_target_1,
            id: revenue_vs_target_1, name: Revenue vs Target %}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
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
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Attributed Revenue
    smart_single_value_size: true
    value_format: ''
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    theme: traditional
    customTheme: ''
    layout: fixed
    minWidthForIndexColumns: true
    headerFontSize: 12
    bodyFontSize: 12
    showTooltip: true
    showHighlight: true
    columnOrder: {}
    rowSubtotals: false
    colSubtotals: false
    spanRows: true
    spanCols: true
    calculateOthers: true
    sortColumnsBy: pivots
    useViewName: false
    useHeadings: false
    useShortName: false
    useUnit: false
    groupVarianceColumns: false
    genericLabelForSubtotals: false
    indexColumn: false
    transposeTable: false
    label|recognized_project_revenue.billing_month_month: Billing Month Month
    heading|recognized_project_revenue.billing_month_month: ''
    hide|recognized_project_revenue.billing_month_month: false
    subtotalDepth: '1'
    label|recognized_project_revenue.total_recognized_revenue_attributed_gbp: Revenue
    heading|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    style|recognized_project_revenue.total_recognized_revenue_attributed_gbp: normal
    reportIn|recognized_project_revenue.total_recognized_revenue_attributed_gbp: '1'
    unit|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    comparison|recognized_project_revenue.total_recognized_revenue_attributed_gbp: team_revenue_targets.revenue_target
    switch|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_num|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_pct|recognized_project_revenue.total_recognized_revenue_attributed_gbp: true
    label|team_revenue_targets.revenue_target: Revenue Target
    heading|team_revenue_targets.revenue_target: ''
    style|team_revenue_targets.revenue_target: hide
    reportIn|team_revenue_targets.revenue_target: '1'
    unit|team_revenue_targets.revenue_target: ''
    comparison|team_revenue_targets.revenue_target: no_variance
    switch|team_revenue_targets.revenue_target: false
    var_num|team_revenue_targets.revenue_target: true
    var_pct|team_revenue_targets.revenue_target: false
    label|team_revenue_targets.utilisation_target: Utilisation Target
    heading|team_revenue_targets.utilisation_target: ''
    style|team_revenue_targets.utilisation_target: hide
    reportIn|team_revenue_targets.utilisation_target: '1'
    unit|team_revenue_targets.utilisation_target: ''
    comparison|team_revenue_targets.utilisation_target: no_variance
    switch|team_revenue_targets.utilisation_target: false
    var_num|team_revenue_targets.utilisation_target: true
    var_pct|team_revenue_targets.utilisation_target: false
    label|revenue_vs_target: Revenue vs. Target %
    heading|revenue_vs_target: ''
    style|revenue_vs_target: hide
    reportIn|revenue_vs_target: '1'
    unit|revenue_vs_target: ''
    comparison|revenue_vs_target: no_variance
    switch|revenue_vs_target: false
    var_num|revenue_vs_target: true
    var_pct|revenue_vs_target: false
    label|project_timesheets.total_timesheet_hours_billed: Total Hours
    heading|project_timesheets.total_timesheet_hours_billed: ''
    style|project_timesheets.total_timesheet_hours_billed: hide
    reportIn|project_timesheets.total_timesheet_hours_billed: '1'
    unit|project_timesheets.total_timesheet_hours_billed: ''
    comparison|project_timesheets.total_timesheet_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_hours_billed: false
    var_num|project_timesheets.total_timesheet_hours_billed: false
    var_pct|project_timesheets.total_timesheet_hours_billed: false
    label|project_timesheets.total_timesheet_billable_hours_billed: Total Billable
      Hours
    heading|project_timesheets.total_timesheet_billable_hours_billed: ''
    style|project_timesheets.total_timesheet_billable_hours_billed: hide
    reportIn|project_timesheets.total_timesheet_billable_hours_billed: '1'
    unit|project_timesheets.total_timesheet_billable_hours_billed: ''
    comparison|project_timesheets.total_timesheet_billable_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_billable_hours_billed: false
    var_num|project_timesheets.total_timesheet_billable_hours_billed: false
    var_pct|project_timesheets.total_timesheet_billable_hours_billed: true
    label|recognized_revenue_contact.contact_name: Contact Name
    heading|recognized_revenue_contact.contact_name: ''
    hide|recognized_revenue_contact.contact_name: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      recognized_project_revenue.total_recognized_revenue_attributed_gbp:
        is_active: false
        value_display: false
    table_theme: white
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    series_value_format: {}
    type: looker_line
    hidden_pivots:
      Alex Caldwell:
        measure_names:
        - project_timesheets.total_timesheet_hours_billed
    query_fields:
      measures:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Total Recognized Revenue Attributed Gbp
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Total Recognized Revenue Attributed Gbp"
        label_from_parameter:
        label_short: Total Recognized Revenue Attributed Gbp
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=80"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${consultant_recognized_attributed_revenue_gbp} "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Revenue Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Revenue Target"
        label_from_parameter:
        label_short: Revenue Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=16"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.revenue_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.revenue_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.revenue_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: team_revenue_targets
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Utilisation Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Utilisation Target"
        label_from_parameter:
        label_short: Utilisation Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=21"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.utilisation_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.utilisation_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.utilisation_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: average_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0%"
        value_format_name: percent_0
        view: team_revenue_targets
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category:
        default_filter_value:
        description:
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant:
        fill_style:
        fiscal_month_offset:
        has_allowed_values:
        has_drills_metadata:
        hidden:
        is_filter:
        is_fiscal:
        is_numeric: true
        is_timeframe:
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter:
        time_interval:
        label: Revenue vs. Target %
        label_from_parameter:
        label_short:
        lookml_link:
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: revenue_vs_target
        strict_value_format:
        parameter:
        period_over_period_params:
        permanent: true
        primary_key:
        project_name:
        requires_refresh_on_sort:
        scope:
        sortable: true
        source_file:
        source_file_path:
        sql:
        sql_case:
        filters:
        suggest_dimension:
        suggest_explore:
        suggestable:
        suggestions:
        synonyms:
        tags:
        type: number
        user_attribute_filter_types:
        value_format: "#,##0%"
        value_format_name:
        view:
        view_label:
        dynamic: false
        week_start_day:
        times_used:
        original_view:
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot: true
        datatype:
        convert_tz:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Hours"
        label_from_parameter:
        label_short: Total Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=123"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        suggest_dimension: project_timesheets.total_timesheet_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Billable Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Billable Hours"
        label_from_parameter:
        label_short: Total Billable Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=134"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_billable_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        - field: project_timesheets.timesheet_is_billable
          condition: 'Yes'
        suggest_dimension: project_timesheets.total_timesheet_billable_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      dimensions:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group: recognized_project_revenue.billing_month
        drill_fields:
        enumerations:
        error:
        field_group_label: Billing Month Date
        field_group_variant: Month
        fill_style: range
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: true
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
          name: month
          count: 1
        label: "     Recognised Revenue Billing Month Month"
        label_from_parameter:
        label_short: Billing Month Month
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=13"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_project_revenue.billing_month_month
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${TABLE}.billing_month "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.billing_month_month
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: date_month
        user_attribute_filter_types:
        - datetime
        - advanced_filter_datetime
        value_format:
        value_format_name:
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: DATE
        convert_tz: false
        sorted:
          desc: true
          sort_index: 0
      table_calculations:
      - label: Utilisation
        name: utilisation
        expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${project_timesheets.total_timesheet_hours_billed}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Total Hours
        name: total_hours
        expression: sum(pivot_row(${project_timesheets.total_timesheet_hours_billed}))
        can_pivot: false
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0"
        is_numeric: true
      pivots:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: "      Contact Details"
        field_group_variant: Contact Name
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Contact Name"
        label_from_parameter:
        label_short: Contact Name
        lookml_link: "/projects/analytics/files/views%2Fcontacts_dim.view.lkml?line=486"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_revenue_contact.contact_name
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_revenue_contact
        sortable: true
        source_file: views/contacts_dim.view.lkml
        source_file_path: analytics/views/contacts_dim.view.lkml
        sql: "${TABLE}.contact_name "
        sql_case:
        filters:
        suggest_dimension: recognized_revenue_contact.contact_name
        suggest_explore: companies_dim
        suggestable: true
        suggestions:
        synonyms: []
        tags: []
        type: string
        user_attribute_filter_types:
        - string
        - advanced_filter_string
        value_format:
        value_format_name:
        view: recognized_revenue_contact
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: contacts_dim
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
    hidden_fields: [recognized_project_revenue.total_recognized_revenue_attributed_gbp,
      team_revenue_targets.revenue_target, team_revenue_targets.utilisation_target,
      revenue_vs_target, project_timesheets.total_timesheet_billable_hours_billed,
      utilisation, project_timesheets.total_timesheet_hours_billed, total_hours, total_billed_hours,
      target_revenue, attributed_revenue]
    pivots: [recognized_revenue_contact.contact_name]
    sorts: [recognized_project_revenue.billing_month_month desc]
    dynamic_fields:
    - category: table_calculation
      expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${project_timesheets.total_timesheet_hours_billed}"
      label: Utilisation
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: utilisation
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${project_timesheets.total_timesheet_hours_billed}))
      label: Total Hours
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: total_hours
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${project_timesheets.total_timesheet_billable_hours_billed}))
      label: Total Billed Hours
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: total_billed_hours
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${team_revenue_targets.revenue_target}))
      label: Target Revenue
      value_format: '"£"0,"K"'
      value_format_name: __custom
      _kind_hint: supermeasure
      table_calculation: target_revenue
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${recognized_project_revenue.total_recognized_revenue_attributed_gbp}))
      label: Attributed Revenue
      value_format: '"£"0,"K"'
      value_format_name: __custom
      _kind_hint: supermeasure
      table_calculation: attributed_revenue
      _type_hint: number
    - category: table_calculation
      expression: "${attributed_revenue}/${target_revenue}"
      label: Revenue vs Target %
      value_format:
      value_format_name: percent_0
      _kind_hint: supermeasure
      table_calculation: revenue_vs_target_1
      _type_hint: number
    row: 10
    col: 57
    width: 15
    height: 12
    tab_name: ''
  - name: Utilisation L12M
    title: Utilisation L12M
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: looker_column
      fields: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_month,
        recognized_project_revenue.total_recognized_revenue_attributed_gbp, team_revenue_targets.revenue_target,
        team_revenue_targets.utilisation_target]
      filters:
        recognized_project_revenue.billing_month_month: 12 month ago for 12 month
        recognized_revenue_contact.contact_name: Alex Caldwell,Tim Griew,Lydia Blackley,George
          Sanderson,Saverro Suseno,Jordan Ilyat,Timothy Griew
      sorts: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_month]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: "${recognized_project_revenue.total_recognized_revenue_attributed_gbp}/${team_revenue_targets.revenue_target}"
        label: Revenue vs. Target %
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: revenue_vs_target
        _type_hint: number
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
      hidden_pivots: {}
      defaults_version: 1
    - model: analytics
      explore: companies_dim
      type: table
      fields: [project_timesheet_users.contact_name, project_timesheets.timesheet_billing_month,
        project_timesheets.total_timesheet_hours_billed, project_timesheets.total_timesheet_billable_hours_billed,
        total_available_hours]
      sorts: [project_timesheets.timesheet_billing_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: measure
        label: Total Available Hours
        based_on: project_timesheets.total_timesheet_hours_billed
        _kind_hint: measure
        measure: total_available_hours
        type: count_distinct
        _type_hint: number
        filters:
          project_timesheet_tasks.task_name: "-Annual Leave,-Sickness"
      join_fields:
      - field_name: project_timesheet_users.contact_name
        source_field_name: recognized_revenue_contact.contact_name
      - field_name: project_timesheets.timesheet_billing_month
        source_field_name: recognized_project_revenue.billing_month_month
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: avg_utilisation, id: Alex
              Caldwell - avg_utilisation, name: Alex Caldwell}, {axisId: avg_utilisation,
            id: George Sanderson - avg_utilisation, name: George Sanderson}, {axisId: avg_utilisation,
            id: Jordan Ilyat - avg_utilisation, name: Jordan Ilyat}, {axisId: avg_utilisation,
            id: Lydia Blackley - avg_utilisation, name: Lydia Blackley}, {axisId: avg_utilisation,
            id: Saverro Suseno - avg_utilisation, name: Saverro Suseno}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
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
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: pivot
    stacking: ''
    limit_displayed_rows: false
    hide_legend: false
    legend_position: center
    trellis_rows: 2
    series_types: {}
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: left, color: "#adadad",
        line_value: ".80", label: 80% Goal}]
    show_null_points: false
    interpolation: linear
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Average Utilisation %
    smart_single_value_size: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    theme: traditional
    customTheme: ''
    layout: fixed
    minWidthForIndexColumns: true
    headerFontSize: 12
    bodyFontSize: 12
    showTooltip: true
    showHighlight: true
    columnOrder: {}
    rowSubtotals: false
    colSubtotals: false
    spanRows: true
    spanCols: true
    calculateOthers: true
    sortColumnsBy: pivots
    useViewName: false
    useHeadings: false
    useShortName: false
    useUnit: false
    groupVarianceColumns: false
    genericLabelForSubtotals: false
    indexColumn: false
    transposeTable: false
    label|recognized_project_revenue.billing_month_month: Billing Month Month
    heading|recognized_project_revenue.billing_month_month: ''
    hide|recognized_project_revenue.billing_month_month: false
    subtotalDepth: '1'
    label|recognized_project_revenue.total_recognized_revenue_attributed_gbp: Revenue
    heading|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    style|recognized_project_revenue.total_recognized_revenue_attributed_gbp: normal
    reportIn|recognized_project_revenue.total_recognized_revenue_attributed_gbp: '1'
    unit|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    comparison|recognized_project_revenue.total_recognized_revenue_attributed_gbp: team_revenue_targets.revenue_target
    switch|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_num|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_pct|recognized_project_revenue.total_recognized_revenue_attributed_gbp: true
    label|team_revenue_targets.revenue_target: Revenue Target
    heading|team_revenue_targets.revenue_target: ''
    style|team_revenue_targets.revenue_target: hide
    reportIn|team_revenue_targets.revenue_target: '1'
    unit|team_revenue_targets.revenue_target: ''
    comparison|team_revenue_targets.revenue_target: no_variance
    switch|team_revenue_targets.revenue_target: false
    var_num|team_revenue_targets.revenue_target: true
    var_pct|team_revenue_targets.revenue_target: false
    label|team_revenue_targets.utilisation_target: Utilisation Target
    heading|team_revenue_targets.utilisation_target: ''
    style|team_revenue_targets.utilisation_target: hide
    reportIn|team_revenue_targets.utilisation_target: '1'
    unit|team_revenue_targets.utilisation_target: ''
    comparison|team_revenue_targets.utilisation_target: no_variance
    switch|team_revenue_targets.utilisation_target: false
    var_num|team_revenue_targets.utilisation_target: true
    var_pct|team_revenue_targets.utilisation_target: false
    label|revenue_vs_target: Revenue vs. Target %
    heading|revenue_vs_target: ''
    style|revenue_vs_target: hide
    reportIn|revenue_vs_target: '1'
    unit|revenue_vs_target: ''
    comparison|revenue_vs_target: no_variance
    switch|revenue_vs_target: false
    var_num|revenue_vs_target: true
    var_pct|revenue_vs_target: false
    label|project_timesheets.total_timesheet_hours_billed: Total Hours
    heading|project_timesheets.total_timesheet_hours_billed: ''
    style|project_timesheets.total_timesheet_hours_billed: hide
    reportIn|project_timesheets.total_timesheet_hours_billed: '1'
    unit|project_timesheets.total_timesheet_hours_billed: ''
    comparison|project_timesheets.total_timesheet_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_hours_billed: false
    var_num|project_timesheets.total_timesheet_hours_billed: false
    var_pct|project_timesheets.total_timesheet_hours_billed: false
    label|project_timesheets.total_timesheet_billable_hours_billed: Total Billable
      Hours
    heading|project_timesheets.total_timesheet_billable_hours_billed: ''
    style|project_timesheets.total_timesheet_billable_hours_billed: hide
    reportIn|project_timesheets.total_timesheet_billable_hours_billed: '1'
    unit|project_timesheets.total_timesheet_billable_hours_billed: ''
    comparison|project_timesheets.total_timesheet_billable_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_billable_hours_billed: false
    var_num|project_timesheets.total_timesheet_billable_hours_billed: false
    var_pct|project_timesheets.total_timesheet_billable_hours_billed: true
    label|recognized_revenue_contact.contact_name: Contact Name
    heading|recognized_revenue_contact.contact_name: ''
    hide|recognized_revenue_contact.contact_name: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      recognized_project_revenue.total_recognized_revenue_attributed_gbp:
        is_active: false
        value_display: false
    table_theme: white
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    series_value_format: {}
    type: looker_line
    hidden_pivots:
      Alex Caldwell:
        measure_names:
        - project_timesheets.total_timesheet_hours_billed
    query_fields:
      measures:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Total Recognized Revenue Attributed Gbp
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Total Recognized Revenue Attributed Gbp"
        label_from_parameter:
        label_short: Total Recognized Revenue Attributed Gbp
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=80"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${consultant_recognized_attributed_revenue_gbp} "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Revenue Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Revenue Target"
        label_from_parameter:
        label_short: Revenue Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=16"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.revenue_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.revenue_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.revenue_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: team_revenue_targets
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Utilisation Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Utilisation Target"
        label_from_parameter:
        label_short: Utilisation Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=21"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.utilisation_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.utilisation_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.utilisation_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: average_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0%"
        value_format_name: percent_0
        view: team_revenue_targets
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category:
        default_filter_value:
        description:
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant:
        fill_style:
        fiscal_month_offset:
        has_allowed_values:
        has_drills_metadata:
        hidden:
        is_filter:
        is_fiscal:
        is_numeric: true
        is_timeframe:
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter:
        time_interval:
        label: Revenue vs. Target %
        label_from_parameter:
        label_short:
        lookml_link:
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: revenue_vs_target
        strict_value_format:
        parameter:
        period_over_period_params:
        permanent: true
        primary_key:
        project_name:
        requires_refresh_on_sort:
        scope:
        sortable: true
        source_file:
        source_file_path:
        sql:
        sql_case:
        filters:
        suggest_dimension:
        suggest_explore:
        suggestable:
        suggestions:
        synonyms:
        tags:
        type: number
        user_attribute_filter_types:
        value_format: "#,##0%"
        value_format_name:
        view:
        view_label:
        dynamic: false
        week_start_day:
        times_used:
        original_view:
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot: true
        datatype:
        convert_tz:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Hours"
        label_from_parameter:
        label_short: Total Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=123"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        suggest_dimension: project_timesheets.total_timesheet_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Billable Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Billable Hours"
        label_from_parameter:
        label_short: Total Billable Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=134"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_billable_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        - field: project_timesheets.timesheet_is_billable
          condition: 'Yes'
        suggest_dimension: project_timesheets.total_timesheet_billable_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      dimensions:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group: recognized_project_revenue.billing_month
        drill_fields:
        enumerations:
        error:
        field_group_label: Billing Month Date
        field_group_variant: Month
        fill_style: range
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: true
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
          name: month
          count: 1
        label: "     Recognised Revenue Billing Month Month"
        label_from_parameter:
        label_short: Billing Month Month
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=13"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_project_revenue.billing_month_month
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${TABLE}.billing_month "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.billing_month_month
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: date_month
        user_attribute_filter_types:
        - datetime
        - advanced_filter_datetime
        value_format:
        value_format_name:
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: DATE
        convert_tz: false
        sorted:
          desc: true
          sort_index: 0
      table_calculations:
      - label: Utilisation
        name: utilisation
        expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${project_timesheets.total_timesheet_hours_billed}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Total Hours
        name: total_hours
        expression: sum(pivot_row(${project_timesheets.total_timesheet_hours_billed}))
        can_pivot: false
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0"
        is_numeric: true
      pivots:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: "      Contact Details"
        field_group_variant: Contact Name
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Contact Name"
        label_from_parameter:
        label_short: Contact Name
        lookml_link: "/projects/analytics/files/views%2Fcontacts_dim.view.lkml?line=486"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_revenue_contact.contact_name
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_revenue_contact
        sortable: true
        source_file: views/contacts_dim.view.lkml
        source_file_path: analytics/views/contacts_dim.view.lkml
        sql: "${TABLE}.contact_name "
        sql_case:
        filters:
        suggest_dimension: recognized_revenue_contact.contact_name
        suggest_explore: companies_dim
        suggestable: true
        suggestions:
        synonyms: []
        tags: []
        type: string
        user_attribute_filter_types:
        - string
        - advanced_filter_string
        value_format:
        value_format_name:
        view: recognized_revenue_contact
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: contacts_dim
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
    hidden_fields: [recognized_project_revenue.total_recognized_revenue_attributed_gbp,
      team_revenue_targets.revenue_target, team_revenue_targets.utilisation_target,
      revenue_vs_target, project_timesheets.total_timesheet_billable_hours_billed,
      project_timesheets.total_timesheet_hours_billed, total_hours, total_billed_hours,
      total_available_hours, utilisation]
    pivots: [recognized_revenue_contact.contact_name]
    sorts: [recognized_project_revenue.billing_month_month desc]
    dynamic_fields:
    - category: table_calculation
      expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${project_timesheets.total_timesheet_hours_billed}"
      label: Utilisation
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: utilisation
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${project_timesheets.total_timesheet_hours_billed}))
      label: Total Hours
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: total_hours
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${project_timesheets.total_timesheet_billable_hours_billed}))
      label: Total Billed Hours
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: total_billed_hours
      _type_hint: number
    - category: table_calculation
      expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${total_available_hours}"
      label: Avg. Utilisation %
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: avg_utilisation
      _type_hint: number
    listen:
    - Contact Name: timesheet_project_engagement_timesheet_users.contact_name
    - Contact Name: project_timesheet_users.contact_name
    row: 44
    col: 0
    width: 39
    height: 28
    tab_name: ''
  - name: Revenue to Target L12M
    title: Revenue to Target L12M
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: looker_column
      fields: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_month,
        recognized_project_revenue.total_recognized_revenue_attributed_gbp, team_revenue_targets.revenue_target,
        team_revenue_targets.utilisation_target]
      filters:
        recognized_project_revenue.billing_month_month: 12 month ago for 12 month
        recognized_revenue_contact.contact_name: Saverro Suseno,Alex Caldwell,Lydia
          Blackley,Tim Griew,George Sanderson,Olivier Dupuis,Jordan Ilyat,Timothy
          Griew
      sorts: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_month]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: "${recognized_project_revenue.total_recognized_revenue_attributed_gbp}/${team_revenue_targets.revenue_target}"
        label: Revenue vs. Target %
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: revenue_vs_target
        _type_hint: number
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
      hidden_pivots: {}
      defaults_version: 1
    - model: analytics
      explore: companies_dim
      type: table
      fields: [project_timesheet_users.contact_name, project_timesheets.timesheet_billing_month,
        project_timesheets.total_timesheet_hours_billed, project_timesheets.total_timesheet_billable_hours_billed]
      sorts: [project_timesheets.timesheet_billing_month desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: project_timesheet_users.contact_name
        source_field_name: recognized_revenue_contact.contact_name
      - field_name: project_timesheets.timesheet_billing_month
        source_field_name: recognized_project_revenue.billing_month_month
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
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: pivot
    stacking: ''
    limit_displayed_rows: false
    hide_legend: true
    legend_position: center
    trellis_rows: 2
    series_types: {}
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    reference_lines: []
    show_null_points: true
    interpolation: linear
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Attributed Revenue
    smart_single_value_size: true
    value_format: ''
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    theme: traditional
    customTheme: ''
    layout: fixed
    minWidthForIndexColumns: true
    headerFontSize: 12
    bodyFontSize: 12
    showTooltip: true
    showHighlight: true
    columnOrder: {}
    rowSubtotals: false
    colSubtotals: false
    spanRows: true
    spanCols: true
    calculateOthers: true
    sortColumnsBy: pivots
    useViewName: false
    useHeadings: false
    useShortName: false
    useUnit: false
    groupVarianceColumns: false
    genericLabelForSubtotals: false
    indexColumn: false
    transposeTable: false
    label|recognized_project_revenue.billing_month_month: Billing Month Month
    heading|recognized_project_revenue.billing_month_month: ''
    hide|recognized_project_revenue.billing_month_month: false
    subtotalDepth: '1'
    label|recognized_project_revenue.total_recognized_revenue_attributed_gbp: Revenue
    heading|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    style|recognized_project_revenue.total_recognized_revenue_attributed_gbp: normal
    reportIn|recognized_project_revenue.total_recognized_revenue_attributed_gbp: '1'
    unit|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    comparison|recognized_project_revenue.total_recognized_revenue_attributed_gbp: team_revenue_targets.revenue_target
    switch|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_num|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_pct|recognized_project_revenue.total_recognized_revenue_attributed_gbp: true
    label|team_revenue_targets.revenue_target: Revenue Target
    heading|team_revenue_targets.revenue_target: ''
    style|team_revenue_targets.revenue_target: hide
    reportIn|team_revenue_targets.revenue_target: '1'
    unit|team_revenue_targets.revenue_target: ''
    comparison|team_revenue_targets.revenue_target: no_variance
    switch|team_revenue_targets.revenue_target: false
    var_num|team_revenue_targets.revenue_target: true
    var_pct|team_revenue_targets.revenue_target: false
    label|team_revenue_targets.utilisation_target: Utilisation Target
    heading|team_revenue_targets.utilisation_target: ''
    style|team_revenue_targets.utilisation_target: hide
    reportIn|team_revenue_targets.utilisation_target: '1'
    unit|team_revenue_targets.utilisation_target: ''
    comparison|team_revenue_targets.utilisation_target: no_variance
    switch|team_revenue_targets.utilisation_target: false
    var_num|team_revenue_targets.utilisation_target: true
    var_pct|team_revenue_targets.utilisation_target: false
    label|revenue_vs_target: Revenue vs. Target %
    heading|revenue_vs_target: ''
    style|revenue_vs_target: hide
    reportIn|revenue_vs_target: '1'
    unit|revenue_vs_target: ''
    comparison|revenue_vs_target: no_variance
    switch|revenue_vs_target: false
    var_num|revenue_vs_target: true
    var_pct|revenue_vs_target: false
    label|project_timesheets.total_timesheet_hours_billed: Total Hours
    heading|project_timesheets.total_timesheet_hours_billed: ''
    style|project_timesheets.total_timesheet_hours_billed: hide
    reportIn|project_timesheets.total_timesheet_hours_billed: '1'
    unit|project_timesheets.total_timesheet_hours_billed: ''
    comparison|project_timesheets.total_timesheet_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_hours_billed: false
    var_num|project_timesheets.total_timesheet_hours_billed: false
    var_pct|project_timesheets.total_timesheet_hours_billed: false
    label|project_timesheets.total_timesheet_billable_hours_billed: Total Billable
      Hours
    heading|project_timesheets.total_timesheet_billable_hours_billed: ''
    style|project_timesheets.total_timesheet_billable_hours_billed: hide
    reportIn|project_timesheets.total_timesheet_billable_hours_billed: '1'
    unit|project_timesheets.total_timesheet_billable_hours_billed: ''
    comparison|project_timesheets.total_timesheet_billable_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_billable_hours_billed: false
    var_num|project_timesheets.total_timesheet_billable_hours_billed: false
    var_pct|project_timesheets.total_timesheet_billable_hours_billed: true
    label|recognized_revenue_contact.contact_name: Contact Name
    heading|recognized_revenue_contact.contact_name: ''
    hide|recognized_revenue_contact.contact_name: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      recognized_project_revenue.total_recognized_revenue_attributed_gbp:
        is_active: false
        value_display: false
    table_theme: white
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    series_value_format: {}
    type: looker_line
    hidden_pivots:
      Alex Caldwell:
        measure_names:
        - project_timesheets.total_timesheet_hours_billed
    query_fields:
      measures:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Total Recognized Revenue Attributed Gbp
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Total Recognized Revenue Attributed Gbp"
        label_from_parameter:
        label_short: Total Recognized Revenue Attributed Gbp
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=80"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${consultant_recognized_attributed_revenue_gbp} "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Revenue Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Revenue Target"
        label_from_parameter:
        label_short: Revenue Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=16"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.revenue_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.revenue_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.revenue_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: team_revenue_targets
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Utilisation Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Utilisation Target"
        label_from_parameter:
        label_short: Utilisation Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=21"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.utilisation_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.utilisation_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.utilisation_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: average_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0%"
        value_format_name: percent_0
        view: team_revenue_targets
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category:
        default_filter_value:
        description:
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant:
        fill_style:
        fiscal_month_offset:
        has_allowed_values:
        has_drills_metadata:
        hidden:
        is_filter:
        is_fiscal:
        is_numeric: true
        is_timeframe:
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter:
        time_interval:
        label: Revenue vs. Target %
        label_from_parameter:
        label_short:
        lookml_link:
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: revenue_vs_target
        strict_value_format:
        parameter:
        period_over_period_params:
        permanent: true
        primary_key:
        project_name:
        requires_refresh_on_sort:
        scope:
        sortable: true
        source_file:
        source_file_path:
        sql:
        sql_case:
        filters:
        suggest_dimension:
        suggest_explore:
        suggestable:
        suggestions:
        synonyms:
        tags:
        type: number
        user_attribute_filter_types:
        value_format: "#,##0%"
        value_format_name:
        view:
        view_label:
        dynamic: false
        week_start_day:
        times_used:
        original_view:
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot: true
        datatype:
        convert_tz:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Hours"
        label_from_parameter:
        label_short: Total Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=123"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        suggest_dimension: project_timesheets.total_timesheet_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Billable Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Billable Hours"
        label_from_parameter:
        label_short: Total Billable Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=134"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_billable_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        - field: project_timesheets.timesheet_is_billable
          condition: 'Yes'
        suggest_dimension: project_timesheets.total_timesheet_billable_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      dimensions:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group: recognized_project_revenue.billing_month
        drill_fields:
        enumerations:
        error:
        field_group_label: Billing Month Date
        field_group_variant: Month
        fill_style: range
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: true
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
          name: month
          count: 1
        label: "     Recognised Revenue Billing Month Month"
        label_from_parameter:
        label_short: Billing Month Month
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=13"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_project_revenue.billing_month_month
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${TABLE}.billing_month "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.billing_month_month
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: date_month
        user_attribute_filter_types:
        - datetime
        - advanced_filter_datetime
        value_format:
        value_format_name:
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: DATE
        convert_tz: false
        sorted:
          desc: true
          sort_index: 0
      table_calculations:
      - label: Utilisation
        name: utilisation
        expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${project_timesheets.total_timesheet_hours_billed}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Total Hours
        name: total_hours
        expression: sum(pivot_row(${project_timesheets.total_timesheet_hours_billed}))
        can_pivot: false
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0"
        is_numeric: true
      pivots:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: "      Contact Details"
        field_group_variant: Contact Name
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Contact Name"
        label_from_parameter:
        label_short: Contact Name
        lookml_link: "/projects/analytics/files/views%2Fcontacts_dim.view.lkml?line=486"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_revenue_contact.contact_name
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_revenue_contact
        sortable: true
        source_file: views/contacts_dim.view.lkml
        source_file_path: analytics/views/contacts_dim.view.lkml
        sql: "${TABLE}.contact_name "
        sql_case:
        filters:
        suggest_dimension: recognized_revenue_contact.contact_name
        suggest_explore: companies_dim
        suggestable: true
        suggestions:
        synonyms: []
        tags: []
        type: string
        user_attribute_filter_types:
        - string
        - advanced_filter_string
        value_format:
        value_format_name:
        view: recognized_revenue_contact
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: contacts_dim
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
    hidden_fields: [recognized_project_revenue.total_recognized_revenue_attributed_gbp,
      team_revenue_targets.revenue_target, team_revenue_targets.utilisation_target,
      project_timesheets.total_timesheet_billable_hours_billed, utilisation, project_timesheets.total_timesheet_hours_billed,
      total_hours, total_billed_hours, target_revenue, attributed_revenue]
    pivots: [recognized_revenue_contact.contact_name]
    sorts: [recognized_project_revenue.billing_month_month desc]
    dynamic_fields:
    - category: table_calculation
      expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${project_timesheets.total_timesheet_hours_billed}"
      label: Utilisation
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: utilisation
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${project_timesheets.total_timesheet_hours_billed}))
      label: Total Hours
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: total_hours
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${project_timesheets.total_timesheet_billable_hours_billed}))
      label: Total Billed Hours
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: total_billed_hours
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${team_revenue_targets.revenue_target}))
      label: Target Revenue
      value_format: '"£"0,"K"'
      value_format_name: __custom
      _kind_hint: supermeasure
      table_calculation: target_revenue
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${recognized_project_revenue.total_recognized_revenue_attributed_gbp}))
      label: Attributed Revenue
      value_format: '"£"0,"K"'
      value_format_name: __custom
      _kind_hint: supermeasure
      table_calculation: attributed_revenue
      _type_hint: number
    - category: table_calculation
      expression: "${attributed_revenue}/${target_revenue}"
      label: Revenue vs Target %
      value_format:
      value_format_name: percent_0
      _kind_hint: supermeasure
      table_calculation: revenue_vs_target_1
      _type_hint: number
    listen:
    - Contact Name: team_revenue_targets.contact_name
    - Contact Name: team_revenue_targets.contact_name
    row: 44
    col: 39
    width: 33
    height: 28
    tab_name: ''
  - name: Average Sickness %
    title: Average Sickness %
    title_hidden: true
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: looker_column
      fields: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_month,
        recognized_project_revenue.total_recognized_revenue_attributed_gbp, team_revenue_targets.revenue_target,
        team_revenue_targets.utilisation_target]
      filters:
        recognized_project_revenue.billing_month_month: 12 month ago for 12 month
        recognized_revenue_contact.contact_name: "-Mark Rittman,-Lewis Baker,-Olivier\
          \ Dupuis"
      sorts: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_month]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: "${recognized_project_revenue.total_recognized_revenue_attributed_gbp}/${team_revenue_targets.revenue_target}"
        label: Revenue vs. Target %
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: revenue_vs_target
        _type_hint: number
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
      hidden_pivots: {}
      defaults_version: 1
    - model: analytics
      explore: companies_dim
      type: table
      fields: [project_timesheet_users.contact_name, project_timesheets.timesheet_billing_month,
        project_timesheets.total_timesheet_hours_billed, project_timesheets.total_timesheet_billable_hours_billed,
        total_available_hours, total_sickness_hours]
      sorts: [project_timesheets.timesheet_billing_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: measure
        label: Total Available Hours
        based_on: project_timesheets.total_timesheet_hours_billed
        _kind_hint: measure
        measure: total_available_hours
        type: count_distinct
        _type_hint: number
        filters:
          project_timesheet_tasks.task_name: "-Annual Leave,-Sickness"
      - category: measure
        label: Total Sickness Hours
        based_on: project_timesheets.total_timesheet_hours_billed
        _kind_hint: measure
        measure: total_sickness_hours
        type: count_distinct
        _type_hint: number
        filters:
          project_timesheet_tasks.task_name: Sickness
      join_fields:
      - field_name: project_timesheet_users.contact_name
        source_field_name: recognized_revenue_contact.contact_name
      - field_name: project_timesheets.timesheet_billing_month
        source_field_name: recognized_project_revenue.billing_month_month
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: sickness, id: sickness,
            name: Sickness %}], showLabels: false, showValues: true, maxValue: 0.5,
        minValue: 0, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
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
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    reference_lines: []
    show_null_points: false
    interpolation: linear
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Average Utilisation %
    smart_single_value_size: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    theme: traditional
    customTheme: ''
    layout: fixed
    minWidthForIndexColumns: true
    headerFontSize: 12
    bodyFontSize: 12
    showTooltip: true
    showHighlight: true
    columnOrder: {}
    rowSubtotals: false
    colSubtotals: false
    spanRows: true
    spanCols: true
    calculateOthers: true
    sortColumnsBy: pivots
    useViewName: false
    useHeadings: false
    useShortName: false
    useUnit: false
    groupVarianceColumns: false
    genericLabelForSubtotals: false
    indexColumn: false
    transposeTable: false
    label|recognized_project_revenue.billing_month_month: Billing Month Month
    heading|recognized_project_revenue.billing_month_month: ''
    hide|recognized_project_revenue.billing_month_month: false
    subtotalDepth: '1'
    label|recognized_project_revenue.total_recognized_revenue_attributed_gbp: Revenue
    heading|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    style|recognized_project_revenue.total_recognized_revenue_attributed_gbp: normal
    reportIn|recognized_project_revenue.total_recognized_revenue_attributed_gbp: '1'
    unit|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    comparison|recognized_project_revenue.total_recognized_revenue_attributed_gbp: team_revenue_targets.revenue_target
    switch|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_num|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_pct|recognized_project_revenue.total_recognized_revenue_attributed_gbp: true
    label|team_revenue_targets.revenue_target: Revenue Target
    heading|team_revenue_targets.revenue_target: ''
    style|team_revenue_targets.revenue_target: hide
    reportIn|team_revenue_targets.revenue_target: '1'
    unit|team_revenue_targets.revenue_target: ''
    comparison|team_revenue_targets.revenue_target: no_variance
    switch|team_revenue_targets.revenue_target: false
    var_num|team_revenue_targets.revenue_target: true
    var_pct|team_revenue_targets.revenue_target: false
    label|team_revenue_targets.utilisation_target: Utilisation Target
    heading|team_revenue_targets.utilisation_target: ''
    style|team_revenue_targets.utilisation_target: hide
    reportIn|team_revenue_targets.utilisation_target: '1'
    unit|team_revenue_targets.utilisation_target: ''
    comparison|team_revenue_targets.utilisation_target: no_variance
    switch|team_revenue_targets.utilisation_target: false
    var_num|team_revenue_targets.utilisation_target: true
    var_pct|team_revenue_targets.utilisation_target: false
    label|revenue_vs_target: Revenue vs. Target %
    heading|revenue_vs_target: ''
    style|revenue_vs_target: hide
    reportIn|revenue_vs_target: '1'
    unit|revenue_vs_target: ''
    comparison|revenue_vs_target: no_variance
    switch|revenue_vs_target: false
    var_num|revenue_vs_target: true
    var_pct|revenue_vs_target: false
    label|project_timesheets.total_timesheet_hours_billed: Total Hours
    heading|project_timesheets.total_timesheet_hours_billed: ''
    style|project_timesheets.total_timesheet_hours_billed: hide
    reportIn|project_timesheets.total_timesheet_hours_billed: '1'
    unit|project_timesheets.total_timesheet_hours_billed: ''
    comparison|project_timesheets.total_timesheet_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_hours_billed: false
    var_num|project_timesheets.total_timesheet_hours_billed: false
    var_pct|project_timesheets.total_timesheet_hours_billed: false
    label|project_timesheets.total_timesheet_billable_hours_billed: Total Billable
      Hours
    heading|project_timesheets.total_timesheet_billable_hours_billed: ''
    style|project_timesheets.total_timesheet_billable_hours_billed: hide
    reportIn|project_timesheets.total_timesheet_billable_hours_billed: '1'
    unit|project_timesheets.total_timesheet_billable_hours_billed: ''
    comparison|project_timesheets.total_timesheet_billable_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_billable_hours_billed: false
    var_num|project_timesheets.total_timesheet_billable_hours_billed: false
    var_pct|project_timesheets.total_timesheet_billable_hours_billed: true
    label|recognized_revenue_contact.contact_name: Contact Name
    heading|recognized_revenue_contact.contact_name: ''
    hide|recognized_revenue_contact.contact_name: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      recognized_project_revenue.total_recognized_revenue_attributed_gbp:
        is_active: false
        value_display: false
    table_theme: white
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    series_value_format: {}
    type: looker_line
    hidden_pivots:
      Alex Caldwell:
        measure_names:
        - project_timesheets.total_timesheet_hours_billed
    query_fields:
      measures:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Total Recognized Revenue Attributed Gbp
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Total Recognized Revenue Attributed Gbp"
        label_from_parameter:
        label_short: Total Recognized Revenue Attributed Gbp
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=80"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${consultant_recognized_attributed_revenue_gbp} "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Revenue Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Revenue Target"
        label_from_parameter:
        label_short: Revenue Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=16"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.revenue_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.revenue_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.revenue_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: team_revenue_targets
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Utilisation Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Utilisation Target"
        label_from_parameter:
        label_short: Utilisation Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=21"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.utilisation_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.utilisation_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.utilisation_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: average_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0%"
        value_format_name: percent_0
        view: team_revenue_targets
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category:
        default_filter_value:
        description:
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant:
        fill_style:
        fiscal_month_offset:
        has_allowed_values:
        has_drills_metadata:
        hidden:
        is_filter:
        is_fiscal:
        is_numeric: true
        is_timeframe:
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter:
        time_interval:
        label: Revenue vs. Target %
        label_from_parameter:
        label_short:
        lookml_link:
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: revenue_vs_target
        strict_value_format:
        parameter:
        period_over_period_params:
        permanent: true
        primary_key:
        project_name:
        requires_refresh_on_sort:
        scope:
        sortable: true
        source_file:
        source_file_path:
        sql:
        sql_case:
        filters:
        suggest_dimension:
        suggest_explore:
        suggestable:
        suggestions:
        synonyms:
        tags:
        type: number
        user_attribute_filter_types:
        value_format: "#,##0%"
        value_format_name:
        view:
        view_label:
        dynamic: false
        week_start_day:
        times_used:
        original_view:
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot: true
        datatype:
        convert_tz:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Hours"
        label_from_parameter:
        label_short: Total Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=123"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        suggest_dimension: project_timesheets.total_timesheet_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Billable Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Billable Hours"
        label_from_parameter:
        label_short: Total Billable Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=134"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_billable_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        - field: project_timesheets.timesheet_is_billable
          condition: 'Yes'
        suggest_dimension: project_timesheets.total_timesheet_billable_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      dimensions:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group: recognized_project_revenue.billing_month
        drill_fields:
        enumerations:
        error:
        field_group_label: Billing Month Date
        field_group_variant: Month
        fill_style: range
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: true
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
          name: month
          count: 1
        label: "     Recognised Revenue Billing Month Month"
        label_from_parameter:
        label_short: Billing Month Month
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=13"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_project_revenue.billing_month_month
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${TABLE}.billing_month "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.billing_month_month
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: date_month
        user_attribute_filter_types:
        - datetime
        - advanced_filter_datetime
        value_format:
        value_format_name:
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: DATE
        convert_tz: false
        sorted:
          desc: true
          sort_index: 0
      table_calculations:
      - label: Utilisation
        name: utilisation
        expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${project_timesheets.total_timesheet_hours_billed}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Total Hours
        name: total_hours
        expression: sum(pivot_row(${project_timesheets.total_timesheet_hours_billed}))
        can_pivot: false
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0"
        is_numeric: true
      pivots:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: "      Contact Details"
        field_group_variant: Contact Name
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Contact Name"
        label_from_parameter:
        label_short: Contact Name
        lookml_link: "/projects/analytics/files/views%2Fcontacts_dim.view.lkml?line=486"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_revenue_contact.contact_name
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_revenue_contact
        sortable: true
        source_file: views/contacts_dim.view.lkml
        source_file_path: analytics/views/contacts_dim.view.lkml
        sql: "${TABLE}.contact_name "
        sql_case:
        filters:
        suggest_dimension: recognized_revenue_contact.contact_name
        suggest_explore: companies_dim
        suggestable: true
        suggestions:
        synonyms: []
        tags: []
        type: string
        user_attribute_filter_types:
        - string
        - advanced_filter_string
        value_format:
        value_format_name:
        view: recognized_revenue_contact
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: contacts_dim
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
    hidden_fields: [recognized_project_revenue.total_recognized_revenue_attributed_gbp,
      team_revenue_targets.revenue_target, team_revenue_targets.utilisation_target,
      revenue_vs_target, project_timesheets.total_timesheet_billable_hours_billed,
      utilisation, project_timesheets.total_timesheet_hours_billed, total_hours, total_billed_hours,
      total_available_hours, avg_utilisation, total_sickness_hours]
    pivots: [recognized_revenue_contact.contact_name]
    sorts: [recognized_project_revenue.billing_month_month desc]
    dynamic_fields:
    - category: table_calculation
      expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${project_timesheets.total_timesheet_hours_billed}"
      label: Utilisation
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: utilisation
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${total_available_hours}))
      label: Total Hours
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: total_hours
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${project_timesheets.total_timesheet_billable_hours_billed}))
      label: Total Billed Hours
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: total_billed_hours
      _type_hint: number
    - category: table_calculation
      expression: "${total_billed_hours}/${total_hours}"
      label: Avg. Utilisation %
      value_format:
      value_format_name: percent_0
      _kind_hint: supermeasure
      table_calculation: avg_utilisation
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${total_sickness_hours}))/${total_hours}
      label: Sickness %
      value_format:
      value_format_name: percent_0
      _kind_hint: supermeasure
      table_calculation: sickness
      _type_hint: number
    row: 10
    col: 30
    width: 12
    height: 12
    tab_name: ''
  - name: New Tile (Copy)
    title: New Tile (Copy)
    note_state: collapsed
    note_display: hover
    note_text: Includes sick days when logged as "Sickness" against Rittman Analytics
      "Internal" project in Harvest
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: looker_column
      fields: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_month,
        recognized_project_revenue.total_recognized_revenue_attributed_gbp, team_revenue_targets.revenue_target,
        team_revenue_targets.utilisation_target]
      filters:
        recognized_project_revenue.billing_month_month: 1 month ago for 1 month
        recognized_revenue_contact.contact_name: "-Giuseppe Mento,-Erik Edelmann,-Olivier\
          \ Dupuis,-Lewis Baker,-Colin Berry,-Mark Rittman,-Bailey Sharpledger"
      sorts: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_month]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: "${recognized_project_revenue.total_recognized_revenue_attributed_gbp}/${team_revenue_targets.revenue_target}"
        label: Revenue vs. Target %
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: revenue_vs_target
        _type_hint: number
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
      hidden_pivots: {}
      defaults_version: 1
    - model: analytics
      explore: companies_dim
      type: looker_column
      fields: [project_timesheet_users.contact_name, project_timesheets.timesheet_billing_month,
        project_timesheets.total_timesheet_hours_billed, project_timesheets.total_timesheet_billable_hours_billed,
        total_available_hours, total_sickness_hours]
      sorts: [project_timesheets.timesheet_billing_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: measure
        label: Total Available Hours
        based_on: project_timesheets.total_timesheet_hours_billed
        _kind_hint: measure
        measure: total_available_hours
        type: count_distinct
        _type_hint: number
        filters:
          project_timesheet_tasks.task_name: "-Sickness,-Annual Leave"
      - category: measure
        label: Total Sickness Hours
        based_on: project_timesheets.total_timesheet_hours_billed
        _kind_hint: measure
        measure: total_sickness_hours
        type: count_distinct
        _type_hint: number
        filters:
          project_timesheet_tasks.task_name: Sickness
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
      join_fields:
      - field_name: project_timesheet_users.contact_name
        source_field_name: recognized_revenue_contact.contact_name
      - field_name: project_timesheets.timesheet_billing_month
        source_field_name: recognized_project_revenue.billing_month_month
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Sickness %
    smart_single_value_size: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    theme: traditional
    customTheme: ''
    layout: fixed
    minWidthForIndexColumns: true
    headerFontSize: 12
    bodyFontSize: 12
    showTooltip: true
    showHighlight: true
    columnOrder: {}
    rowSubtotals: false
    colSubtotals: false
    spanRows: true
    spanCols: true
    calculateOthers: true
    sortColumnsBy: pivots
    useViewName: false
    useHeadings: false
    useShortName: false
    useUnit: false
    groupVarianceColumns: false
    genericLabelForSubtotals: false
    indexColumn: false
    transposeTable: false
    label|recognized_project_revenue.billing_month_month: Billing Month Month
    heading|recognized_project_revenue.billing_month_month: ''
    hide|recognized_project_revenue.billing_month_month: false
    subtotalDepth: '1'
    label|recognized_project_revenue.total_recognized_revenue_attributed_gbp: Revenue
    heading|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    style|recognized_project_revenue.total_recognized_revenue_attributed_gbp: normal
    reportIn|recognized_project_revenue.total_recognized_revenue_attributed_gbp: '1'
    unit|recognized_project_revenue.total_recognized_revenue_attributed_gbp: ''
    comparison|recognized_project_revenue.total_recognized_revenue_attributed_gbp: team_revenue_targets.revenue_target
    switch|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_num|recognized_project_revenue.total_recognized_revenue_attributed_gbp: false
    var_pct|recognized_project_revenue.total_recognized_revenue_attributed_gbp: true
    label|team_revenue_targets.revenue_target: Revenue Target
    heading|team_revenue_targets.revenue_target: ''
    style|team_revenue_targets.revenue_target: hide
    reportIn|team_revenue_targets.revenue_target: '1'
    unit|team_revenue_targets.revenue_target: ''
    comparison|team_revenue_targets.revenue_target: no_variance
    switch|team_revenue_targets.revenue_target: false
    var_num|team_revenue_targets.revenue_target: true
    var_pct|team_revenue_targets.revenue_target: false
    label|team_revenue_targets.utilisation_target: Utilisation Target
    heading|team_revenue_targets.utilisation_target: ''
    style|team_revenue_targets.utilisation_target: hide
    reportIn|team_revenue_targets.utilisation_target: '1'
    unit|team_revenue_targets.utilisation_target: ''
    comparison|team_revenue_targets.utilisation_target: no_variance
    switch|team_revenue_targets.utilisation_target: false
    var_num|team_revenue_targets.utilisation_target: true
    var_pct|team_revenue_targets.utilisation_target: false
    label|revenue_vs_target: Revenue vs. Target %
    heading|revenue_vs_target: ''
    style|revenue_vs_target: hide
    reportIn|revenue_vs_target: '1'
    unit|revenue_vs_target: ''
    comparison|revenue_vs_target: no_variance
    switch|revenue_vs_target: false
    var_num|revenue_vs_target: true
    var_pct|revenue_vs_target: false
    label|project_timesheets.total_timesheet_hours_billed: Total Hours
    heading|project_timesheets.total_timesheet_hours_billed: ''
    style|project_timesheets.total_timesheet_hours_billed: hide
    reportIn|project_timesheets.total_timesheet_hours_billed: '1'
    unit|project_timesheets.total_timesheet_hours_billed: ''
    comparison|project_timesheets.total_timesheet_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_hours_billed: false
    var_num|project_timesheets.total_timesheet_hours_billed: false
    var_pct|project_timesheets.total_timesheet_hours_billed: false
    label|project_timesheets.total_timesheet_billable_hours_billed: Total Billable
      Hours
    heading|project_timesheets.total_timesheet_billable_hours_billed: ''
    style|project_timesheets.total_timesheet_billable_hours_billed: hide
    reportIn|project_timesheets.total_timesheet_billable_hours_billed: '1'
    unit|project_timesheets.total_timesheet_billable_hours_billed: ''
    comparison|project_timesheets.total_timesheet_billable_hours_billed: no_variance
    switch|project_timesheets.total_timesheet_billable_hours_billed: false
    var_num|project_timesheets.total_timesheet_billable_hours_billed: false
    var_pct|project_timesheets.total_timesheet_billable_hours_billed: true
    label|recognized_revenue_contact.contact_name: Contact Name
    heading|recognized_revenue_contact.contact_name: ''
    hide|recognized_revenue_contact.contact_name: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      recognized_project_revenue.total_recognized_revenue_attributed_gbp:
        is_active: false
        value_display: false
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    series_value_format: {}
    type: single_value
    series_types: {}
    hidden_pivots:
      Alex Caldwell:
        measure_names:
        - project_timesheets.total_timesheet_hours_billed
    query_fields:
      measures:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Total Recognized Revenue Attributed Gbp
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Total Recognized Revenue Attributed Gbp"
        label_from_parameter:
        label_short: Total Recognized Revenue Attributed Gbp
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=80"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${consultant_recognized_attributed_revenue_gbp} "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.total_recognized_revenue_attributed_gbp
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Revenue Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Revenue Target"
        label_from_parameter:
        label_short: Revenue Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=16"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.revenue_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.revenue_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.revenue_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        value_format_name: gbp_0
        view: team_revenue_targets
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant: Utilisation Target
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Utilisation Target"
        label_from_parameter:
        label_short: Utilisation Target
        lookml_link: "/projects/analytics/files/views%2Fteam_revenue_targets.view.lkml?line=21"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: team_revenue_targets.utilisation_target
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: team_revenue_targets
        sortable: true
        source_file: views/team_revenue_targets.view.lkml
        source_file_path: analytics/views/team_revenue_targets.view.lkml
        sql: "${TABLE}.utilisation_target "
        sql_case:
        filters:
        suggest_dimension: team_revenue_targets.utilisation_target
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: average_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0%"
        value_format_name: percent_0
        view: team_revenue_targets
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: team_revenue_targets
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category:
        default_filter_value:
        description:
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label:
        field_group_variant:
        fill_style:
        fiscal_month_offset:
        has_allowed_values:
        has_drills_metadata:
        hidden:
        is_filter:
        is_fiscal:
        is_numeric: true
        is_timeframe:
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter:
        time_interval:
        label: Revenue vs. Target %
        label_from_parameter:
        label_short:
        lookml_link:
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: revenue_vs_target
        strict_value_format:
        parameter:
        period_over_period_params:
        permanent: true
        primary_key:
        project_name:
        requires_refresh_on_sort:
        scope:
        sortable: true
        source_file:
        source_file_path:
        sql:
        sql_case:
        filters:
        suggest_dimension:
        suggest_explore:
        suggestable:
        suggestions:
        synonyms:
        tags:
        type: number
        user_attribute_filter_types:
        value_format: "#,##0%"
        value_format_name:
        view:
        view_label:
        dynamic: false
        week_start_day:
        times_used:
        original_view:
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot: true
        datatype:
        convert_tz:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Hours"
        label_from_parameter:
        label_short: Total Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=123"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        suggest_dimension: project_timesheets.total_timesheet_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: Timesheets
        field_group_variant: Total Billable Hours
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: true
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "      Project Timesheets Total Billable Hours"
        label_from_parameter:
        label_short: Total Billable Hours
        lookml_link: "/projects/analytics/files/views%2Ftimesheets_fact.view.lkml?line=134"
        lookml_expression:
        links:
        map_layer:
        measure: true
        name: project_timesheets.total_timesheet_billable_hours_billed
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: project_timesheets
        sortable: true
        source_file: views/timesheets_fact.view.lkml
        source_file_path: analytics/views/timesheets_fact.view.lkml
        sql: 'coalesce(${TABLE}.timesheet_hours_billed,0) '
        sql_case:
        filters:
        - field: project_timesheets.timesheet_is_billable
          condition: 'Yes'
        suggest_dimension: project_timesheets.total_timesheet_billable_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        value_format_name: decimal_0
        view: project_timesheets
        view_label: "      Project Timesheets"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: timesheets_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate: true
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
      dimensions:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group: recognized_project_revenue.billing_month
        drill_fields:
        enumerations:
        error:
        field_group_label: Billing Month Date
        field_group_variant: Month
        fill_style: range
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: true
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
          name: month
          count: 1
        label: "     Recognised Revenue Billing Month Month"
        label_from_parameter:
        label_short: Billing Month Month
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=13"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_project_revenue.billing_month_month
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_project_revenue
        sortable: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${TABLE}.billing_month "
        sql_case:
        filters:
        suggest_dimension: recognized_project_revenue.billing_month_month
        suggest_explore: companies_dim
        suggestable: false
        suggestions:
        synonyms: []
        tags: []
        type: date_month
        user_attribute_filter_types:
        - datetime
        - advanced_filter_datetime
        value_format:
        value_format_name:
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: recognized_revenue_fact
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: DATE
        convert_tz: false
        sorted:
          desc: true
          sort_index: 0
      table_calculations:
      - label: Utilisation
        name: utilisation
        expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${project_timesheets.total_timesheet_hours_billed}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Total Hours
        name: total_hours
        expression: sum(pivot_row(${project_timesheets.total_timesheet_hours_billed}))
        can_pivot: false
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0"
        is_numeric: true
      pivots:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        dimension_group:
        drill_fields:
        enumerations:
        error:
        field_group_label: "      Contact Details"
        field_group_variant: Contact Name
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        has_drills_metadata:
        hidden: false
        is_filter: false
        is_fiscal: false
        is_numeric: false
        is_timeframe: false
        is_turtle:
        can_turtle:
        turtle_dimension:
        can_time_filter: false
        time_interval:
        label: "     Recognised Revenue Contact Name"
        label_from_parameter:
        label_short: Contact Name
        lookml_link: "/projects/analytics/files/views%2Fcontacts_dim.view.lkml?line=486"
        lookml_expression:
        links:
        map_layer:
        measure: false
        name: recognized_revenue_contact.contact_name
        strict_value_format: false
        parameter: false
        period_over_period_params:
        permanent: true
        primary_key: false
        project_name: analytics
        requires_refresh_on_sort: false
        scope: recognized_revenue_contact
        sortable: true
        source_file: views/contacts_dim.view.lkml
        source_file_path: analytics/views/contacts_dim.view.lkml
        sql: "${TABLE}.contact_name "
        sql_case:
        filters:
        suggest_dimension: recognized_revenue_contact.contact_name
        suggest_explore: companies_dim
        suggestable: true
        suggestions:
        synonyms: []
        tags: []
        type: string
        user_attribute_filter_types:
        - string
        - advanced_filter_string
        value_format:
        value_format_name:
        view: recognized_revenue_contact
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        times_used: 0
        original_view: contacts_dim
        superkey:
        render_string:
        order_by_field:
        turtle:
        aggregate:
        is_table_calculation:
        expression:
        field:
        type_label_value:
        is_disabled:
        supports_filtering?:
        can_pivot:
        datatype: TIMESTAMP
        convert_tz: true
    hidden_fields: [recognized_project_revenue.total_recognized_revenue_attributed_gbp,
      team_revenue_targets.revenue_target, team_revenue_targets.utilisation_target,
      revenue_vs_target, project_timesheets.total_timesheet_billable_hours_billed,
      utilisation, recognized_project_revenue.billing_month_month, project_timesheets.total_timesheet_hours_billed,
      total_hours, total_billed_hours, total_available_hours, total_sickness_hours,
      avg_sickness]
    pivots: [recognized_revenue_contact.contact_name]
    sorts: [recognized_project_revenue.billing_month_month desc]
    dynamic_fields:
    - category: table_calculation
      expression: "${project_timesheets.total_timesheet_billable_hours_billed}/${total_available_hours}"
      label: Utilisation
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: utilisation
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${total_available_hours}))
      label: Total Hours
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: total_hours
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${project_timesheets.total_timesheet_billable_hours_billed}))
      label: Total Billed Hours
      value_format:
      value_format_name: decimal_0
      _kind_hint: supermeasure
      table_calculation: total_billed_hours
      _type_hint: number
    - category: table_calculation
      expression: sum(pivot_row(${total_sickness_hours}))/${total_hours}
      label: Avg. Utilisation %
      value_format:
      value_format_name: percent_0
      _kind_hint: supermeasure
      table_calculation: avg_utilisation
      _type_hint: number
    - category: table_calculation
      expression: "${total_sickness_hours}/${total_hours}"
      label: Avg Sickness %
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: avg_sickness
      _type_hint: number
    row: 4
    col: 30
    width: 12
    height: 6
    tab_name: ''
  filters:
  - name: Contact Name
    title: Contact Name
    type: field_filter
    default_value: Jordan Ilyat,Alex Caldwell,Lydia Blackley,Timothy Griew,Saverro
      Suseno,Mark Rittman,Olivier Dupuis
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    model: analytics
    explore: companies_dim
    listens_to_filters: []
    field: team_revenue_targets.contact_name
