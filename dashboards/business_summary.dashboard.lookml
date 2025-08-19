---
- dashboard: business_summary
  title: Business Summary
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: hoZHHXqtCAml2NMD4tRmR9
  elements:
  - name: How much attributed revenue has each consultant delivered MTD?
    title: How much attributed revenue has each consultant delivered MTD?
    note_state: collapsed
    note_display: hover
    note_text: Compares individual consultant's attributed revenue against their targets
      for the current month. Used for evaluating each consultant's contribution to
      revenue targets and identifying who has met or exceeded their goals.
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: looker_grid
      fields: [recognized_project_revenue.billing_month_month, recognized_revenue_contact.contact_name,
        recognized_project_revenue.total_recognized_revenue_gbp]
      filters:
        recognized_project_revenue.billing_month_month: 1 months
      sorts: [recognized_project_revenue.billing_month_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: "${consultant_revenue_attribution.attributed_project_revenue_gbp}-${consultant_revenue_attribution.attributed_project_cost_gbp}"
        label: Attributed Project Contribution GBP
        value_format:
        value_format_name: gbp_0
        _kind_hint: measure
        table_calculation: attributed_project_contribution_gbp
        _type_hint: number
        is_disabled: true
      - category: table_calculation
        expression: "${attributed_project_contribution_gbp}/${consultant_revenue_attribution.attributed_project_revenue_gbp}"
        label: Attributed Project Margin %
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: attributed_project_margin
        _type_hint: number
        is_disabled: true
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
      arm_length: 9
      arm_weight: 12
      spinner_length: 153
      spinner_weight: 25
      target_length: 10
      target_gap: 10
      target_weight: 25
      range_min: 0
      value_label_type: both
      value_label_font: 12
      value_label_padding: 45
      target_source: override
      target_label_type: both
      target_label_font: 3
      label_font_size: 2
      spinner_type: inner
      fill_color: "#0092E5"
      background_color: "#CECECE"
      spinner_color: "#282828"
      range_color: "#282828"
      gauge_fill_type: progress
      fill_colors: ["#7FCDAE", "#ffed6f", "#EE7772"]
      viz_trellis_by: row
      trellis_rows: 2
      trellis_cols: 2
      angle: 90
      cutout: 30
      range_x: 1
      range_y: 1
      target_label_padding: 1.06
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
      x_axis_zoom: true
      y_axis_zoom: true
      show_sql_query_menu_options: false
      show_totals: true
      show_row_totals: true
      truncate_header: false
      minimum_column_width: 75
      series_cell_visualizations:
        consultant_revenue_attribution.attributed_project_revenue_gbp:
          is_active: false
        attributed_project_contribution_gbp:
          is_active: true
      hidden_pivots: {}
      show_null_points: true
      interpolation: linear
      defaults_version: 1
      hidden_fields: [consultant_revenue_attribution.attributed_project_cost_gbp]
      hidden_points_if_no: []
      series_labels: {}
    - model: analytics
      explore: targets
      type: table
      fields: [targets.period_month, targets.ae_revenue_target, targets.sae_revenue_target,
        targets.prn_revenue_target]
      sorts: [targets.period_month desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: targets.period_month
        source_field_name: recognized_project_revenue.billing_month_month
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: consultant_revenue_attribution.attributed_project_revenue_gbp,
            id: consultant_revenue_attribution.attributed_project_revenue_gbp, name: Attributed
              Project Revenue Gbp}, {axisId: remaining_target_revenue_gbp, id: remaining_target_revenue_gbp,
            name: Remaining Target Revenue GBP}], showLabels: true, showValues: true,
        maxValue: 30000, minValue: 0, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      revenue_variance: "#E1E1E9"
      remaining_target_revenue_gbp: "#E1E1E9"
      remaining_target_gbp: "#E1E1E8"
    series_labels:
      consultant_revenue_attribution.attributed_project_revenue_gbp: Attributed Revenue
        GBP
      remaining_target_revenue_gbp: Remaining Target GBP
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    arm_length: 25
    arm_weight: 50
    spinner_length: 100
    spinner_weight: 50
    target_length: 15
    target_gap: 15
    target_weight: 50
    value_label_type: both
    value_label_padding: 60
    target_source: second
    gauge_fill_type: progress
    viz_trellis_by: row
    angle: 90
    cutout: 50
    range_x: 1
    range_y: 1
    target_label_padding: 1.5
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", recognized_project_revenue.billing_month_quarter,
      recognized_project_revenue.billing_month_month, recognized_revenue_contact.contact_name,
      recognized_project_revenue.total_recognized_revenue_gbp, revenue_target, variance]
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      consultant_revenue_attribution.attributed_project_revenue_gbp:
        is_active: false
      revenue_to_target:
        is_active: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [consultant_revenue_attribution.attributed_project_cost_gbp, targets.ae_revenue_target,
      targets.sae_revenue_target, targets.prn_revenue_target, revenue_to_target, variance,
      revenue_target, recognized_project_revenue.billing_month_month]
    type: looker_column
    hide_totals: false
    hide_row_totals: false
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
        label: Recognised Revenue Total Recognized Revenue Gbp
        label_from_parameter:
        label_short: Total Recognized Revenue Gbp
        map_layer:
        name: recognized_project_revenue.total_recognized_revenue_gbp
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
        view: recognized_project_revenue
        view_label: Recognised Revenue
        dynamic: false
        week_start_day: monday
        original_view: recognized_revenue_fact
        dimension_group:
        error:
        field_group_variant: Total Recognized Revenue Gbp
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: recognized_project_revenue
        suggest_dimension: recognized_project_revenue.total_recognized_revenue_gbp
        suggest_explore: companies_dim
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=54"
        permanent: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${consultant_recognized_revenue_gbp} "
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
        field_group_label: Billing Month Date
        fill_style: range
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: false
        label: Recognised Revenue Billing Month Month
        label_from_parameter:
        label_short: Billing Month Month
        map_layer:
        name: recognized_project_revenue.billing_month_month
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
        view: recognized_project_revenue
        view_label: Recognised Revenue
        dynamic: false
        week_start_day: monday
        original_view: recognized_revenue_fact
        dimension_group: recognized_project_revenue.billing_month
        error:
        field_group_variant: Month
        measure: false
        parameter: false
        primary_key: false
        project_name: analytics
        scope: recognized_project_revenue
        suggest_dimension: recognized_project_revenue.billing_month_month
        suggest_explore: companies_dim
        suggestable: false
        is_fiscal: false
        is_timeframe: true
        can_time_filter: false
        time_interval:
          name: month
          count: 1
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=13"
        permanent: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${TABLE}.billing_month "
        sql_case:
        filters:
        times_used: 0
        sorted:
          desc: false
          sort_index: 0
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        enumerations:
        field_group_label: "      Contact Details"
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: false
        label: Recognised Revenue         Contact Name
        label_from_parameter:
        label_short: "        Contact Name"
        map_layer:
        name: recognized_revenue_contact.contact_name
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: string
        user_attribute_filter_types:
        - string
        - advanced_filter_string
        value_format:
        view: recognized_revenue_contact
        view_label: Recognised Revenue
        dynamic: false
        week_start_day: monday
        original_view: contacts_dim
        dimension_group:
        error:
        field_group_variant: "        Contact Name"
        measure: false
        parameter: false
        primary_key: false
        project_name: analytics
        scope: recognized_revenue_contact
        suggest_dimension: recognized_revenue_contact.contact_name
        suggest_explore: companies_dim
        suggestable: true
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fcontacts_dim.view.lkml?line=140"
        permanent: true
        source_file: views/contacts_dim.view.lkml
        source_file_path: analytics/views/contacts_dim.view.lkml
        sql: "${TABLE}.contact_name "
        sql_case:
        filters:
        times_used: 0
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        enumerations:
        field_group_label: Billing Month Date
        fill_style: range
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: false
        label: Recognised Revenue Billing Month Quarter
        label_from_parameter:
        label_short: Billing Month Quarter
        map_layer:
        name: recognized_project_revenue.billing_month_quarter
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: date_quarter
        user_attribute_filter_types:
        - datetime
        - advanced_filter_datetime
        value_format:
        view: recognized_project_revenue
        view_label: Recognised Revenue
        dynamic: false
        week_start_day: monday
        original_view: recognized_revenue_fact
        dimension_group: recognized_project_revenue.billing_month
        error:
        field_group_variant: Quarter
        measure: false
        parameter: false
        primary_key: false
        project_name: analytics
        scope: recognized_project_revenue
        suggest_dimension: recognized_project_revenue.billing_month_quarter
        suggest_explore: companies_dim
        suggestable: false
        is_fiscal: false
        is_timeframe: true
        can_time_filter: false
        time_interval:
          name: month
          count: 3
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=13"
        permanent: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${TABLE}.billing_month "
        sql_case:
        filters:
        times_used: 0
      - align: right
        can_filter: false
        category: dimension
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
        label: Targets Ae Revenue Target
        label_from_parameter:
        label_short: Ae Revenue Target
        map_layer:
        name: targets.ae_revenue_target
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format:
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Ae Revenue Target
        measure: false
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.ae_revenue_target
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=99"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${TABLE}.ae_tgt "
        sql_case:
        filters:
        times_used: 0
      - align: right
        can_filter: false
        category: dimension
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
        label: Targets Sae Revenue Target
        label_from_parameter:
        label_short: Sae Revenue Target
        map_layer:
        name: targets.sae_revenue_target
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format:
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Sae Revenue Target
        measure: false
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.sae_revenue_target
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=85"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${TABLE}.sae_tgt "
        sql_case:
        filters:
        times_used: 0
      - align: right
        can_filter: false
        category: dimension
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
        label: Targets Prn Revenue Target
        label_from_parameter:
        label_short: Prn Revenue Target
        map_layer:
        name: targets.prn_revenue_target
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format:
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Prn Revenue Target
        measure: false
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.prn_revenue_target
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=92"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${TABLE}.prn_tgt "
        sql_case:
        filters:
        times_used: 0
      table_calculations:
      - label: Revenue Target
        name: revenue_target
        expression: |-
          if(${recognized_revenue_contact.contact_name}="Amir Jaber",${targets.sae_revenue_target},
            if(${recognized_revenue_contact.contact_name}="Jordan Ilyat",${targets.ae_revenue_target},
              if(${recognized_revenue_contact.contact_name}="Lydia Blackley",${targets.ae_revenue_target},
                if(${recognized_revenue_contact.contact_name}="Lewis Baker",${targets.prn_revenue_target},
                  if(${recognized_revenue_contact.contact_name}="Olivier Dupuis",12767,0)))))
        can_pivot: false
        sortable: true
        type: number
        align: right
        measure: false
        is_table_calculation: true
        dynamic: true
        value_format: '"£"#,##0'
        is_numeric: true
      - label: Variance
        name: variance
        expression: "${recognized_project_revenue.total_recognized_revenue_gbp}-${revenue_target}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: '"£"#,##0'
        is_numeric: true
      pivots: []
    hidden_pivots: {}
    sorts: [recognized_revenue_contact.contact_name]
    dynamic_fields:
    - category: table_calculation
      expression: "${recognized_project_revenue.total_recognized_revenue_gbp}-${revenue_target}"
      label: Variance
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: variance
      _type_hint: number
    - category: table_calculation
      expression: |-
        if(${recognized_revenue_contact.contact_name}="Bailey Sharpledger",${targets.sae_revenue_target},
          if(${recognized_revenue_contact.contact_name}="Jordan Ilyat",${targets.sae_revenue_target},
            if(${recognized_revenue_contact.contact_name}="Lydia Blackley",${targets.sae_revenue_target},
              if(${recognized_revenue_contact.contact_name}="Saverro Suseno",${targets.ae_revenue_target},
              if(${recognized_revenue_contact.contact_name}="Lewis Baker",${targets.prn_revenue_target},
                if(${recognized_revenue_contact.contact_name}="Olivier Dupuis",12767,0))))))
      label: Revenue Target
      value_format:
      value_format_name: gbp_0
      _kind_hint: dimension
      table_calculation: revenue_target
      _type_hint: number
    - category: table_calculation
      expression: "${revenue_target}-${recognized_project_revenue.total_recognized_revenue_gbp}"
      label: Remaining Target GBP
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: remaining_target_gbp
      _type_hint: number
    row: 99
    col: 0
    width: 12
    height: 11
  - title: How much revenue is booked, forecasted and remaining to target?
    name: How much revenue is booked, forecasted and remaining to target?
    model: analytics
    explore: revenue_and_forecast
    type: looker_column
    fields: [revenue_and_forecast.period_month, sum_of_booked_revenue, sum_of_forecast_revenue,
      sum_of_target_revenue_2]
    fill_fields: [revenue_and_forecast.period_month]
    sorts: [revenue_and_forecast.period_month desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - measure: sum_of_booked_revenue
      based_on: revenue_and_forecast.booked_revenue
      expression: ''
      label: Sum of Booked Revenue
      type: sum
      _kind_hint: measure
      _type_hint: number
    - measure: sum_of_forecast_revenue
      based_on: revenue_and_forecast.forecast_revenue
      expression: ''
      label: Sum of Forecast Revenue
      type: sum
      _kind_hint: measure
      _type_hint: number
    - measure: sum_of_target_revenue
      based_on: revenue_and_forecast.target_revenue
      expression: ''
      label: Sum of Target Revenue
      type: sum
      _kind_hint: measure
      _type_hint: number
    - measure: sum_of_forecast_net_profit
      based_on: revenue_and_forecast.forecast_net_profit
      expression: ''
      label: Sum of Forecast Net Profit
      type: sum
      _kind_hint: measure
      _type_hint: number
    - measure: sum_of_target_revenue_2
      based_on: revenue_and_forecast.target_revenue
      expression: ''
      label: Sum of Target Revenue
      type: sum
      _kind_hint: measure
      _type_hint: number
    - category: table_calculation
      expression: if(${sum_of_target_revenue_2}-${sum_of_booked_revenue}-${sum_of_forecast_revenue}>0,${sum_of_target_revenue_2}-${sum_of_booked_revenue}-${sum_of_forecast_revenue},0)
      label: Target Remaining GBP
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: target_remaining_gbp
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
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: sum_of_booked_revenue,
            id: sum_of_booked_revenue, name: Booked Revenue GBP}, {axisId: sum_of_forecast_revenue,
            id: sum_of_forecast_revenue, name: Forecast Revenue GBP}, {axisId: sum_of_target_revenue_2,
            id: sum_of_target_revenue_2, name: Sum of Target Revenue}], showLabels: true,
        showValues: true, maxValue: !!null '', unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: []
    label_value_format: '"£"0,"K"'
    series_types:
      sum_of_target_revenue_2: line
    series_colors:
      sum_of_forecast_revenue: "#dedede"
      target_remaining_gbp: "#E1E1E8"
      sum_of_target_revenue_2: "#D13452"
    series_labels:
      sum_of_booked_revenue: Booked Revenue GBP
      sum_of_forecast_revenue: Forecast Revenue GBP
      sum_of_target_revenue_2: Target Revenue GBP
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: right, color: "#858585",
        line_value: '73610', label: Breakeven (Avg)}]
    trend_lines: []
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_pivots: {}
    hidden_fields: [target_remaining_gbp]
    note_state: collapsed
    note_display: hover
    note_text: forecasted revenue is sourced from the Revenue spreadsheet and represents
      billing we are reasonably confident will get closed and delivered for those
      months
    listen: {}
    row: 9
    col: 0
    width: 12
    height: 10
  - name: How much new opportunities have we brought in, and remain to target?
    title: How much new opportunities have we brought in, and remain to target?
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: looker_line
      fields: [deals_fact.deal_created_month, deals_fact.total_deal_amount_gbp_converted]
      fill_fields: [deals_fact.deal_created_month]
      filters:
        deals_fact.deal_created_date: 1 years
      sorts: [deals_fact.deal_created_month]
      limit: 500
      column_limit: 50
      filter_expression: "${deals_fact.deal_created_month}>add_months(-12,now())"
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
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      defaults_version: 1
      join_fields: []
    - model: analytics
      explore: targets
      type: table
      fields: [targets.period_month, targets.total_deals_revenue_target]
      fill_fields: [targets.period_month]
      sorts: [targets.period_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: if(is_null(${targets.total_deals_target}),150000,${targets.total_deals_target})
        label: Target
        value_format:
        value_format_name: gbp_0
        _kind_hint: measure
        table_calculation: target
        _type_hint: number
        is_disabled: true
      hidden_pivots: {}
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
              (Forecast)}, {axisId: remaining_target_gbp, id: remaining_target_gbp,
            name: Remaining Target GBP}], showLabels: true, showValues: true, maxValue: !!null '',
        valueFormat: '"£"0,"K"', unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
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
    label_value_format: '"£"0,"K"'
    series_types:
      new_deals_gbp: column
    point_style: none
    series_colors:
      targets.total_deals_target: "#D13452"
      target_1: "#D13452"
      remaining_target_gbp: "#E1E1E8"
      targets.total_deals_revenue_target: "#D13452"
      new_deals_gbp: "#4A80BC"
    series_labels:
      deals_fact.total_deal_amount_gbp_converted: Actual New Deals (Forecast)
      targets.total_deals_target: Target
    show_value_labels: true
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    type: looker_line
    hidden_fields: [deals_fact.total_deal_amount_gbp_converted, remaining_target_gbp]
    hidden_pivots: {}
    sorts: [deals_fact.deal_created_month]
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: coalesce(${deals_fact.total_deal_amount_gbp_converted},0)
      label: New Deals GBP
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: new_deals_gbp
      _type_hint: number
    - category: table_calculation
      expression: if(${targets.total_deals_revenue_target}-coalesce(${deals_fact.total_deal_amount_gbp_converted},0)<0,0,${targets.total_deals_revenue_target}-coalesce(${deals_fact.total_deal_amount_gbp_converted},0))
      label: Remaining Target GBP
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: remaining_target_gbp
      _type_hint: number
    row: 68
    col: 0
    width: 12
    height: 10
  - name: How much profit have we made, and are forecast to make this month?
    title: How much profit have we made, and are forecast to make this month?
    merged_queries:
    - model: analytics
      explore: chart_of_accounts_dim
      type: looker_line
      fields: [cost_of_delivery, dividends, overheads, revenue, taxation, profit_and_loss_report_fact.period_month]
      fill_fields: [profit_and_loss_report_fact.period_month]
      filters:
        profit_and_loss_report_fact.period_month: 1 years
        profit_and_loss_report_fact.account_report_category: "-NULL"
      sorts: [profit_and_loss_report_fact.period_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: abs(${cost_of_delivery})/${revenue}
        label: Delivery as % of Revenue
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: delivery_as_of_revenue
        _type_hint: number
        is_disabled: true
      - category: table_calculation
        expression: abs(${overheads})/${revenue}
        label: Overheads as % of Revenue
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: overheads_as_of_revenue
        _type_hint: number
        is_disabled: true
      - category: table_calculation
        expression: "(${revenue}+${taxation}+${cost_of_delivery}+${overheads}+${dividends})/${revenue}"
        label: Retained Earnings as % of Revenue
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: retained_earnings_as_of_revenue
        _type_hint: number
        is_disabled: true
      - category: measure
        label: Cost of Delivery
        based_on: profit_and_loss_report_fact.amount
        _kind_hint: measure
        measure: cost_of_delivery
        type: count_distinct
        _type_hint: number
        filters:
          profit_and_loss_report_fact.account_report_category: Cost of Delivery
      - category: measure
        label: Dividends
        based_on: profit_and_loss_report_fact.amount
        _kind_hint: measure
        measure: dividends
        type: count_distinct
        _type_hint: number
        filters:
          profit_and_loss_report_fact.account_report_category: Dividends
      - category: measure
        label: Overheads
        based_on: profit_and_loss_report_fact.amount
        _kind_hint: measure
        measure: overheads
        type: count_distinct
        _type_hint: number
        filters:
          profit_and_loss_report_fact.account_report_category: Overheads
      - category: measure
        label: Revenue
        based_on: profit_and_loss_report_fact.amount
        _kind_hint: measure
        measure: revenue
        type: count_distinct
        _type_hint: number
        filters:
          profit_and_loss_report_fact.account_report_category: Revenue
      - category: measure
        label: Taxation
        based_on: profit_and_loss_report_fact.amount
        _kind_hint: measure
        measure: taxation
        type: count_distinct
        _type_hint: number
        filters:
          profit_and_loss_report_fact.account_report_category: Taxation
      - category: table_calculation
        expression: "${revenue}+${cost_of_delivery}+${overheads}+${dividends}+${taxation}"
        label: Actual Retained Earnings
        value_format:
        value_format_name: gbp_0
        _kind_hint: measure
        table_calculation: actual_retained_earnings
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
      show_null_points: true
      interpolation: linear
      color_application:
        collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
        palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
        options:
          steps: 5
      x_axis_zoom: true
      y_axis_zoom: true
      series_colors:
        ebitda_as_of_revenue: "#D13452"
        overheads_as_of_revenue: "#7bc739"
      reference_lines: []
      hidden_pivots: {}
      hidden_fields: []
      defaults_version: 1
    - model: analytics
      explore: revenue_and_forecast
      type: table
      fields: [revenue_and_forecast.period_month, sum_of_booked_and_forecast_revenue,
        sum_of_overheads, sum_of_forecast_net_profit, sum_of_delivery_costs, sum_of_dividends,
        sum_of_forecast_taxation]
      fill_fields: [revenue_and_forecast.period_month]
      filters:
        revenue_and_forecast.period_month: 1 months
      sorts: [revenue_and_forecast.period_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - measure: sum_of_booked_and_forecast_revenue
        based_on: revenue_and_forecast.booked_and_forecast_revenue
        expression: ''
        label: Sum of Booked and Forecast Revenue
        type: sum
        _kind_hint: measure
        _type_hint: number
      - measure: sum_of_overheads
        based_on: revenue_and_forecast.overheads
        expression: ''
        label: Sum of Overheads
        type: sum
        _kind_hint: measure
        _type_hint: number
      - measure: sum_of_forecast_net_profit
        based_on: revenue_and_forecast.forecast_net_profit
        expression: ''
        label: Sum of Forecast Net Profit
        type: sum
        _kind_hint: measure
        _type_hint: number
      - measure: sum_of_delivery_costs
        based_on: revenue_and_forecast.delivery_costs
        expression: ''
        label: Sum of Delivery Costs
        type: sum
        _kind_hint: measure
        _type_hint: number
      - measure: sum_of_dividends
        based_on: revenue_and_forecast.dividends
        expression: ''
        label: Sum of Dividends
        type: sum
        _kind_hint: measure
        _type_hint: number
      - measure: sum_of_forecast_taxation
        based_on: revenue_and_forecast.forecast_taxation
        expression: ''
        label: Sum of Forecast Taxation
        type: sum
        _kind_hint: measure
        _type_hint: number
      join_fields:
      - field_name: revenue_and_forecast.period_month
        source_field_name: profit_and_loss_report_fact.period_month
    - model: analytics
      explore: targets
      type: table
      fields: [targets.total_retained_earnings_target, targets.period_month]
      fill_fields: [targets.period_month]
      limit: 500
      join_fields:
      - field_name: targets.period_month
        source_field_name: profit_and_loss_report_fact.period_month
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: cost_of_delivery_as_of_revenue,
            id: cost_of_delivery_as_of_revenue, name: Cost of Delivery as % of Revenue},
          {axisId: overheads_as_of_revenue, id: overheads_as_of_revenue, name: Overheads
              as % of Revenue}, {axisId: retained_income_as_of_revenue, id: retained_income_as_of_revenue,
            name: Retained Income as % of Revenue}], showLabels: true, showValues: true,
        maxValue: !!null '', unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
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
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '12'
    legend_position: center
    label_value_format: '"£"0,"K"'
    series_types:
      targets.total_retained_earnings_target: line
    point_style: none
    series_colors:
      retained_income_as_of_revenue: "#D13452"
      overheads_as_of_revenue: "#7bc739"
      targets.total_retained_earnings_target: "#D13452"
      retained_income: "#4A80BC"
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    reference_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    hidden_pivots: {}
    hidden_fields: [cost_of_delivery, dividends, overheads, revenue, taxation, sum_of_overheads,
      sum_of_forecast_net_profit, sum_of_delivery_costs, cost_of_delivery_1, revenue_1,
      overheads_1, dividends_1, taxation_1, sum_of_dividends, sum_of_booked_and_forecast_revenue,
      actual_retained_earnings, sum_of_forecast_taxation, cost_of_delivery_as_of_revenue,
      overheads_as_of_revenue, retained_income_as_of_revenue, retained_earnings_to_target]
    type: looker_column
    sorts: [profit_and_loss_report_fact.period_month]
    dynamic_fields:
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_delivery_costs}*-1,${cost_of_delivery})
      label: Cost of Delivery
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: cost_of_delivery_1
      _type_hint: number
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_booked_and_forecast_revenue},${revenue})
      label: Revenue
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: revenue_1
      _type_hint: number
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_overheads}*-1,${overheads})
      label: Overheads
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: overheads_1
      _type_hint: number
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_dividends}*-1,${dividends})
      label: Dividends
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: dividends_1
      _type_hint: number
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_forecast_taxation}*-1,${taxation})
      label: Taxation
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: taxation_1
      _type_hint: number
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_forecast_net_profit},${actual_retained_earnings})
      label: Retained Income
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: retained_income
      _type_hint: number
    - category: table_calculation
      expression: abs(${cost_of_delivery}/${revenue})
      label: Cost of Delivery as % of Revenue
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: cost_of_delivery_as_of_revenue
      _type_hint: number
    - category: table_calculation
      expression: abs(${overheads}/${revenue})
      label: Overheads as % of Revenue
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: overheads_as_of_revenue
      _type_hint: number
    - category: table_calculation
      expression: "${actual_retained_earnings}/${revenue}"
      label: Retained Income as % of Revenue
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: retained_income_as_of_revenue
      _type_hint: number
    - category: table_calculation
      expression: "(${targets.total_retained_earnings_target}-${retained_income})/${targets.total_retained_earnings_target}"
      label: Retained Earnings to Target %
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: retained_earnings_to_target
      _type_hint: number
    row: 40
    col: 0
    width: 12
    height: 10
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '[{"type":"h1","children":[{"text":"Delivery"}],"align":"center"}]'
    rich_content_json: '{"format":"slate"}'
    row: 88
    col: 0
    width: 24
    height: 2
  - name: " (2)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '[{"type":"h1","children":[{"text":"Revenue & Profitability"}],"align":"center"}]'
    rich_content_json: '{"format":"slate"}'
    row: 7
    col: 0
    width: 24
    height: 2
  - title: What Sales Opportunities are in the Pipeline?
    name: What Sales Opportunities are in the Pipeline?
    model: analytics
    explore: companies_dim
    type: looker_grid
    fields: [deals_fact.pipeline_stage_label, deals_fact.deal_name, deals_fact.partner_referral,
      deals_fact.deal_pipeline_stage_date, deals_fact.deal_type, deals_fact.count_oppportunity_deals,
      deals_fact.count_deals, deals_fact.deal_currency_code, deals_fact.number_of_sprints,
      deals_fact.owner_full_name, deals_fact.sprint_type, deals_fact.total_deal_amount_gbp_converted,
      deals_fact.total_weighted_open_deal_amount_gbp, deals_fact.deal_source]
    filters:
      deals_fact.pipeline_stage_label: Proposal Sent & Delivery Qualified,Initial
        Enquiry,SoW Drafted,Project Scoping,Customer Agreed SoW,Partner Funding Signoff
        (*),Partner Funding Agreed (*)
      companies_dim.company_name: ''
      deals_fact.deal_name: "-Apex Auctions - Phase #2,-Apex Auctions - Segment event\
        \ tracking implementation"
    sorts: [deals_fact.pipeline_stage_label desc]
    limit: 500
    column_limit: 50
    total: true
    dynamic_fields:
    - category: table_calculation
      expression: diff_days(${deals_fact.deal_pipeline_stage_date},now())
      label: Days in Deal Stage
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: days_in_deal_stage
      _type_hint: number
    - measure: days_in_pipeline_2
      based_on: deals_fact.days_in_pipeline
      type: sum
      label: Days in Pipeline
      expression:
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
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
      deals_fact.deal_source, deals_fact.deal_type, deals_fact.partner_referral, deals_fact.number_of_sprints,
      days_in_deal_stage, deals_fact.total_deal_amount_gbp_converted, deals_fact.total_weighted_open_deal_amount_gbp]
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
        palette:
          palette_id: 478252b2-cfcc-fde7-3d73-e76ac2f1d260
          collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
          custom_colors:
          - "#8C3535"
          - "#FFFFFF"
          - "#519947"
    conditional_formatting: [{type: between, value: [0, 7], background_color: "#7bc739",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          custom: {id: e3400bbf-ab9f-faec-e711-615f78ba1468, label: Custom, type: continuous,
            stops: [{color: "#C4DF58", offset: 0}, {color: "#D13452", offset: 100}]},
          options: {steps: 5, constraints: {min: {type: minimum}, mid: {type: number,
                value: 30}, max: {type: maximum}}, mirror: true, reverse: false, stepped: false}},
        bold: false, italic: false, strikethrough: false, fields: [days_in_deal_stage]},
      {type: between, value: [7, 28], background_color: "#E48522", font_color: !!null '',
        color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c, palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830},
        bold: false, italic: false, strikethrough: false, fields: [days_in_deal_stage]},
      {type: greater than, value: 28, background_color: "#D13452", font_color: !!null '',
        color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c, palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830},
        bold: false, italic: false, strikethrough: false, fields: [days_in_deal_stage]}]
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
    hidden_pivots: {}
    minimum_column_width: 75
    listen: {}
    row: 62
    col: 0
    width: 24
    height: 6
  - title: Forecast Invoiced Revenue GBP
    name: Forecast Invoiced Revenue GBP
    model: analytics
    explore: revenue_and_forecast
    type: single_value
    fields: [revenue_and_forecast.period_month, sum_of_booked_revenue, sum_of_forecast_revenue,
      sum_of_target_revenue_2]
    fill_fields: [revenue_and_forecast.period_month]
    filters:
      revenue_and_forecast.period_month: 1 months
    sorts: [revenue_and_forecast.period_month]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${sum_of_booked_revenue}+${sum_of_forecast_revenue}"
      label: Forecast Revenue
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: forecast_revenue
      _type_hint: number
    - category: table_calculation
      expression: "${sum_of_target_revenue_2}"
      label: Target GBP
      value_format: '"£"0,"K"'
      value_format_name: __custom
      _kind_hint: measure
      table_calculation: target_gbp
      _type_hint: number
    - measure: sum_of_booked_revenue
      based_on: revenue_and_forecast.booked_revenue
      expression: ''
      label: Sum of Booked Revenue
      type: sum
      _kind_hint: measure
      _type_hint: number
    - measure: sum_of_forecast_revenue
      based_on: revenue_and_forecast.forecast_revenue
      expression: ''
      label: Sum of Forecast Revenue
      type: sum
      _kind_hint: measure
      _type_hint: number
    - measure: sum_of_target_revenue
      based_on: revenue_and_forecast.target_revenue
      expression: ''
      label: Sum of Target Revenue
      type: sum
      _kind_hint: measure
      _type_hint: number
    - measure: sum_of_forecast_net_profit
      based_on: revenue_and_forecast.forecast_net_profit
      expression: ''
      label: Sum of Forecast Net Profit
      type: sum
      _kind_hint: measure
      _type_hint: number
    - measure: sum_of_target_revenue_2
      based_on: revenue_and_forecast.target_revenue
      expression: ''
      label: Sum of Target Revenue
      type: sum
      _kind_hint: measure
      _type_hint: number
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    single_value_title: ''
    value_format: '"£"0,"K"'
    comparison_label: Target GBP
    conditional_formatting: [{type: less than, value: 66000, background_color: "#D13452",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: between, value: [66000, 83000],
        background_color: "#E48522", font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: greater than, value: 83000,
        background_color: "#7bc739", font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
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
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: sum_of_booked_revenue,
            id: sum_of_booked_revenue, name: Booked Revenue}, {axisId: sum_of_forecast_revenue,
            id: sum_of_forecast_revenue, name: Forecast Revenue}], showLabels: true,
        showValues: true, maxValue: 100000, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: []
    series_colors:
      sum_of_forecast_revenue: "#b1b0b2"
      target_remaining_gbp: "#E1E1E8"
    series_labels:
      sum_of_booked_revenue: Booked Revenue GBP
      sum_of_forecast_revenue: Forecast Revenue GBP
    reference_lines: []
    trend_lines: []
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_pivots: {}
    hidden_fields: [sum_of_booked_revenue, sum_of_forecast_revenue, target_remaining_gbp,
      sum_of_target_revenue_2]
    listen: {}
    row: 2
    col: 3
    width: 3
    height: 5
  - name: Forecast Invoiced Retained GBP
    title: Forecast Invoiced Retained GBP
    merged_queries:
    - model: analytics
      explore: chart_of_accounts_dim
      type: looker_line
      fields: [cost_of_delivery, dividends, overheads, revenue, taxation, profit_and_loss_report_fact.period_month]
      fill_fields: [profit_and_loss_report_fact.period_month]
      filters:
        profit_and_loss_report_fact.period_month: 1 months
        profit_and_loss_report_fact.account_report_category: "-NULL"
      sorts: [profit_and_loss_report_fact.period_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: abs(${cost_of_delivery})/${revenue}
        label: Delivery as % of Revenue
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: delivery_as_of_revenue
        _type_hint: number
        is_disabled: true
      - category: table_calculation
        expression: abs(${overheads})/${revenue}
        label: Overheads as % of Revenue
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: overheads_as_of_revenue
        _type_hint: number
        is_disabled: true
      - category: table_calculation
        expression: "(${revenue}+${taxation}+${cost_of_delivery}+${overheads}+${dividends})/${revenue}"
        label: Retained Earnings as % of Revenue
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: retained_earnings_as_of_revenue
        _type_hint: number
        is_disabled: true
      - category: measure
        label: Cost of Delivery
        based_on: profit_and_loss_report_fact.amount
        _kind_hint: measure
        measure: cost_of_delivery
        type: count_distinct
        _type_hint: number
        filters:
          profit_and_loss_report_fact.account_report_category: Cost of Delivery
      - category: measure
        label: Dividends
        based_on: profit_and_loss_report_fact.amount
        _kind_hint: measure
        measure: dividends
        type: count_distinct
        _type_hint: number
        filters:
          profit_and_loss_report_fact.account_report_category: Dividends
      - category: measure
        label: Overheads
        based_on: profit_and_loss_report_fact.amount
        _kind_hint: measure
        measure: overheads
        type: count_distinct
        _type_hint: number
        filters:
          profit_and_loss_report_fact.account_report_category: Overheads
      - category: measure
        label: Revenue
        based_on: profit_and_loss_report_fact.amount
        _kind_hint: measure
        measure: revenue
        type: count_distinct
        _type_hint: number
        filters:
          profit_and_loss_report_fact.account_report_category: Revenue
      - category: measure
        label: Taxation
        based_on: profit_and_loss_report_fact.amount
        _kind_hint: measure
        measure: taxation
        type: count_distinct
        _type_hint: number
        filters:
          profit_and_loss_report_fact.account_report_category: Taxation
      - category: table_calculation
        expression: "${revenue}+${cost_of_delivery}+${overheads}+${dividends}+${taxation}"
        label: Actual Retained Earnings
        value_format:
        value_format_name: gbp_0
        _kind_hint: measure
        table_calculation: actual_retained_earnings
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
      show_null_points: true
      interpolation: linear
      color_application:
        collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
        palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
        options:
          steps: 5
      x_axis_zoom: true
      y_axis_zoom: true
      series_colors:
        ebitda_as_of_revenue: "#D13452"
        overheads_as_of_revenue: "#7bc739"
      reference_lines: []
      hidden_pivots: {}
      hidden_fields: []
      defaults_version: 1
    - model: analytics
      explore: revenue_and_forecast
      type: table
      fields: [revenue_and_forecast.period_month, sum_of_booked_and_forecast_revenue,
        sum_of_overheads, sum_of_forecast_net_profit, sum_of_delivery_costs, sum_of_dividends,
        sum_of_forecast_taxation]
      fill_fields: [revenue_and_forecast.period_month]
      filters:
        revenue_and_forecast.period_month: 1 months
      sorts: [revenue_and_forecast.period_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - measure: sum_of_booked_and_forecast_revenue
        based_on: revenue_and_forecast.booked_and_forecast_revenue
        expression: ''
        label: Sum of Booked and Forecast Revenue
        type: sum
        _kind_hint: measure
        _type_hint: number
      - measure: sum_of_overheads
        based_on: revenue_and_forecast.overheads
        expression: ''
        label: Sum of Overheads
        type: sum
        _kind_hint: measure
        _type_hint: number
      - measure: sum_of_forecast_net_profit
        based_on: revenue_and_forecast.forecast_net_profit
        expression: ''
        label: Sum of Forecast Net Profit
        type: sum
        _kind_hint: measure
        _type_hint: number
      - measure: sum_of_delivery_costs
        based_on: revenue_and_forecast.delivery_costs
        expression: ''
        label: Sum of Delivery Costs
        type: sum
        _kind_hint: measure
        _type_hint: number
      - measure: sum_of_dividends
        based_on: revenue_and_forecast.dividends
        expression: ''
        label: Sum of Dividends
        type: sum
        _kind_hint: measure
        _type_hint: number
      - measure: sum_of_forecast_taxation
        based_on: revenue_and_forecast.forecast_taxation
        expression: ''
        label: Sum of Forecast Taxation
        type: sum
        _kind_hint: measure
        _type_hint: number
      join_fields:
      - field_name: revenue_and_forecast.period_month
        source_field_name: profit_and_loss_report_fact.period_month
    - model: analytics
      explore: targets
      type: table
      fields: [targets.total_retained_earnings_target, targets.period_month]
      fill_fields: [targets.period_month]
      limit: 500
      join_fields:
      - field_name: targets.period_month
        source_field_name: profit_and_loss_report_fact.period_month
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Forecast Profit (Loss)
    value_format: '"£"0,"K"'
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting: [{type: less than, value: 0, background_color: "#D13452",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: between, value: [0, 10000],
        background_color: "#E48522", font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: greater than, value: 10000,
        background_color: "#7bc739", font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: cost_of_delivery_as_of_revenue,
            id: cost_of_delivery_as_of_revenue, name: Cost of Delivery as % of Revenue},
          {axisId: overheads_as_of_revenue, id: overheads_as_of_revenue, name: Overheads
              as % of Revenue}, {axisId: retained_income_as_of_revenue, id: retained_income_as_of_revenue,
            name: Retained Income as % of Revenue}], showLabels: true, showValues: true,
        maxValue: !!null '', unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
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
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '12'
    legend_position: center
    label_value_format: '"£"0,"K"'
    series_types: {}
    point_style: none
    series_colors:
      retained_income_as_of_revenue: "#D13452"
      overheads_as_of_revenue: "#7bc739"
      targets.total_retained_earnings_target: "#D13452"
      retained_income: "#4A80BC"
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    reference_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    hidden_pivots: {}
    hidden_fields: [cost_of_delivery, dividends, overheads, revenue, taxation, sum_of_overheads,
      sum_of_forecast_net_profit, sum_of_delivery_costs, cost_of_delivery_1, revenue_1,
      overheads_1, dividends_1, taxation_1, sum_of_dividends, sum_of_booked_and_forecast_revenue,
      actual_retained_earnings, sum_of_forecast_taxation, cost_of_delivery_as_of_revenue,
      overheads_as_of_revenue, retained_income_as_of_revenue, retained_earnings_to_target,
      targets.total_retained_earnings_target]
    type: single_value
    sorts: [profit_and_loss_report_fact.period_month]
    dynamic_fields:
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_delivery_costs}*-1,${cost_of_delivery})
      label: Cost of Delivery
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: cost_of_delivery_1
      _type_hint: number
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_booked_and_forecast_revenue},${revenue})
      label: Revenue
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: revenue_1
      _type_hint: number
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_overheads}*-1,${overheads})
      label: Overheads
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: overheads_1
      _type_hint: number
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_dividends}*-1,${dividends})
      label: Dividends
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: dividends_1
      _type_hint: number
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_forecast_taxation}*-1,${taxation})
      label: Taxation
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: taxation_1
      _type_hint: number
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_forecast_net_profit},${actual_retained_earnings})
      label: Retained Income
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: retained_income
      _type_hint: number
    - category: table_calculation
      expression: abs(${cost_of_delivery}/${revenue})
      label: Cost of Delivery as % of Revenue
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: cost_of_delivery_as_of_revenue
      _type_hint: number
    - category: table_calculation
      expression: abs(${overheads}/${revenue})
      label: Overheads as % of Revenue
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: overheads_as_of_revenue
      _type_hint: number
    - category: table_calculation
      expression: "${actual_retained_earnings}/${revenue}"
      label: Retained Income as % of Revenue
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: retained_income_as_of_revenue
      _type_hint: number
    - category: table_calculation
      expression: "(${targets.total_retained_earnings_target}-${retained_income})/${targets.total_retained_earnings_target}"
      label: Retained Earnings to Target %
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: retained_earnings_to_target
      _type_hint: number
    - category: table_calculation
      expression: "${targets.total_retained_earnings_target}"
      label: Target
      value_format: '"£"0,"K"'
      value_format_name: __custom
      _kind_hint: measure
      table_calculation: target
      _type_hint: number
    row: 2
    col: 9
    width: 3
    height: 5
  - name: Closed Deals
    title: Closed Deals
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: single_value
      fields: [deals_fact.deal_closed_month, deals_fact.total_closed_won_deal_amount_gbp]
      fill_fields: [deals_fact.deal_closed_month]
      filters:
        deals_fact.pipeline_stage_label: Verbally Won & Working at Risk,Won & Scheduled,Won
          & Delivered,In Delivery
        companies_dim.company_name: ''
        deals_fact.deal_type: ''
        deals_fact.owner_full_name: ''
        deals_fact.partner_referral: ''
        deals_fact.sprint_type: ''
        deals_fact.deal_name: ''
        deals_fact.deal_is_deleted: 'No'
        deals_fact.deal_closed_date: 1 months
      sorts: [deals_fact.deal_closed_month]
      limit: 12
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: diff_days(${deals_fact.deal_pipeline_stage_date},now())
        label: Days in Deal Stage
        value_format:
        value_format_name:
        _kind_hint: dimension
        table_calculation: days_in_deal_stage
        _type_hint: number
        is_disabled: true
      - category: table_calculation
        expression: sum(${days_in_deal_stage})/count(${days_in_deal_stage})
        label: Avg. Days in Deal Stage
        value_format:
        value_format_name: decimal_0
        _kind_hint: dimension
        table_calculation: avg_days_in_deal_stage
        _type_hint: number
        is_disabled: true
      - category: table_calculation
        expression: "(sum(${deals_fact.total_weighted_opportunity_deal_amount}))/90000"
        label: Pipeline Coverage
        value_format: 0.##":1"
        value_format_name: __custom
        _kind_hint: measure
        table_calculation: pipeline_coverage
        _type_hint: number
        is_disabled: true
      - category: table_calculation
        expression: count(${deals_fact.count_deals})
        label: Active Deals
        value_format:
        value_format_name:
        _kind_hint: measure
        table_calculation: active_deals
        _type_hint: number
        is_disabled: true
      - category: table_calculation
        expression: sum(${deals_fact.total_oppportunity_deal_amount})
        label: Closed Won Deals This Month
        value_format: '"£"0,"K"'
        value_format_name: __custom
        _kind_hint: measure
        table_calculation: closed_won_deals_this_month
        _type_hint: number
        is_disabled: true
      custom_color_enabled: true
      show_single_value_title: true
      show_comparison: true
      comparison_type: value
      comparison_reverse_colors: false
      show_comparison_label: true
      enable_conditional_formatting: true
      conditional_formatting_include_totals: false
      conditional_formatting_include_nulls: false
      color_application:
        collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
        palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      value_format: '"£"0,"K"'
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
      x_axis_label_rotation: 0
      show_row_numbers: false
      transpose: false
      truncate_text: true
      hide_totals: false
      hide_row_totals: false
      size_to_fit: true
      table_theme: white
      header_text_alignment: left
      header_font_size: '12'
      rows_font_size: '12'
      show_sql_query_menu_options: false
      column_order: [deals_fact.deal_name, deals_fact.owner_full_name, deals_fact.pipeline_stage_label,
        deals_fact.sprint_type, deals_fact.deal_type, deals_fact.partner_referral,
        deals_fact.number_of_sprints, deals_fact.deal_currency_code, deals_fact.total_oppportunity_deal_amount,
        deals_fact.total_weighted_opportunity_deal_amount, deals_fact.deal_pipeline_stage_date,
        days_in_deal_stage]
      show_totals: true
      show_row_totals: true
      truncate_header: true
      series_cell_visualizations:
        deals_fact.total_weighted_opportunity_deal_amount:
          is_active: false
        deals_fact.total_oppportunity_deal_amount:
          is_active: true
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
      hidden_fields: [deals_fact.deal_pipeline_stage, deals_fact.deal_closed_month]
      hidden_points_if_no: []
    - model: analytics
      explore: targets
      type: table
      fields: [targets.period_month, targets.total_deals_closed_revenue_target]
      fill_fields: [targets.period_month]
      sorts: [targets.period_month desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: targets.period_month
        source_field_name: deals_fact.deal_closed_month
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    custom_color_enabled: true
    show_single_value_title: true
    value_format: '"£"0,"K"'
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting: [{type: less than, value: 60000, background_color: "#D13452",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: between, value: [60000, 90000],
        background_color: "#E48522", font_color: "#FFFFFF", color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: greater than, value: 90000,
        background_color: "#7bc739", font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: deals_fact.total_oppportunity_deal_amount,
            id: deals_fact.total_oppportunity_deal_amount, name: Closed Amount}, {
            axisId: targets.total_deals_closed_target, id: targets.total_deals_closed_target,
            name: Target}], showLabels: false, showValues: true, maxValue: !!null '',
        minValue: !!null '', valueFormat: '"£"0,"K"', unpinAxis: false, tickDensity: default,
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
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: normal
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '15'
    legend_position: center
    label_value_format: '"£"0,"K"'
    series_types: {}
    point_style: none
    series_colors:
      deals_fact.total_oppportunity_deal_amount: "#4A80BC"
      targets.total_deals_closed_target: "#D13452"
      remaining_target: "#E1E1E8"
    series_labels:
      deals_fact.total_oppportunity_deal_amount: Closed Amount
      targets.total_deals_closed_target: Target
      deals_fact.total_closed_won_deal_amount_gbp: Won Deals GBP
      remaining_target: Remaining Target GBP
    show_value_labels: true
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
    type: single_value
    hidden_fields: [remaining_target, targets.total_deals_closed_revenue_target, deals_fact.deal_closed_month]
    dynamic_fields:
    - category: table_calculation
      expression: if(${targets.total_deals_closed_revenue_target}-${deals_fact.total_closed_won_deal_amount_gbp}<0,0,${targets.total_deals_closed_revenue_target}-${deals_fact.total_closed_won_deal_amount_gbp})
      label: Remaining Target
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: remaining_target
      _type_hint: number
    - category: table_calculation
      expression: "${targets.total_deals_closed_revenue_target}"
      label: Target
      value_format: '"£"0,"K"'
      value_format_name: __custom
      _kind_hint: measure
      table_calculation: target
      _type_hint: number
    row: 2
    col: 0
    width: 3
    height: 5
  - name: Team Utilisation %
    title: Team Utilisation %
    note_state: collapsed
    note_display: hover
    note_text: Shows the utilization rate of the delivery team based on billable work
      across different months, useful for monitoring how effectively the team's time
      is being spent on billable tasks vs. their overall time at work
    merged_queries:
    - model: analytics
      explore: contacts
      type: looker_column
      fields: [timesheets_fact.timesheet_billing_month, timesheets_fact.total_timesheet_nonbillable_hours_billed,
        timesheets_fact.total_timesheet_billable_hours_billed]
      fill_fields: [timesheets_fact.timesheet_billing_month]
      filters:
        contacts.contact_is_staff: ''
        timesheets_fact.timesheet_billing_month: 1 months
        contacts.contact_name: Lewis Baker,Amir Jaber,Jordan Ilyat,Lydia Blackley,Abanoub
          Hakeem,Jack Goble,Bailey Sharpledger,John Haynes,Olivier Dupuis
      sorts: [timesheets_fact.timesheet_billing_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: "${timesheets_fact.total_timesheet_billable_hours_billed}/(${timesheets_fact.total_timesheet_billable_hours_billed}+${timesheets_fact.total_timesheet_nonbillable_hours_billed})"
        label: Util %
        value_format:
        value_format_name: percent_2
        _kind_hint: measure
        table_calculation: util
        _type_hint: number
      - category: measure
        label: Client Project Hours
        based_on: timesheets_fact.total_timesheet_hours_billed
        _kind_hint: measure
        measure: client_project_hours
        type: count_distinct
        _type_hint: number
        filters:
          projects_delivered.project_is_billable: 'Yes'
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
      x_axis_zoom: true
      y_axis_zoom: true
      series_colors:
        timesheets_fact.total_timesheet_nonbillable_hours_billed: "#d4d4d4"
        timesheets_fact.total_timesheet_billable_hours_billed: "#4A80BC"
      series_labels:
        timesheets_fact.total_timesheet_hours_billed: Paid Hours
        timesheets_fact.total_timesheet_nonbillable_hours_billed: Non-Billable Activity
        timesheets_fact.total_timesheet_billable_hours_billed: Billable Activity
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
      show_sql_query_menu_options: false
      show_totals: true
      show_row_totals: true
      truncate_header: false
      minimum_column_width: 75
      series_cell_visualizations:
        timesheets_fact.total_timesheet_hours_billed:
          is_active: true
      hidden_pivots: {}
      defaults_version: 1
      hidden_fields: [util]
    - model: analytics
      explore: contact_utilization_fact
      type: table
      fields: [staff_dim.contact_name, contact_utilization_fact.forecast_month, contact_utilization_fact.total_forecast_billable_hours,
        contact_utilization_fact.total_actual_story_points]
      limit: 500
      join_fields:
      - field_name: contact_utilization_fact.forecast_month
        source_field_name: timesheets_fact.timesheet_billing_month
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting: [{type: less than, value: 0.6, background_color: "#D13452",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: between, value: [0.6, 0.7],
        background_color: "#E48522", font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: greater than, value: 0.7,
        background_color: "#7bc739", font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
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
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    hidden_series: [Abanoub Hakeem - util, Mark Rittman - util, Olivier Dupuis - util,
      Tony Kau - util]
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    reference_lines: []
    trend_lines: []
    show_null_points: true
    interpolation: linear
    type: single_value
    hidden_pivots: {}
    hidden_fields: [timesheets_fact.total_timesheet_nonbillable_hours_billed, timesheets_fact.total_timesheet_billable_hours_billed,
      contact_utilization_fact.total_forecast_billable_hours, contact_utilization_fact.total_actual_story_points,
      staff_dim.contact_name, timesheets_fact.timesheet_billing_month]
    series_types: {}
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '0.80'
      label: Target
      value_format:
      value_format_name: percent_0
      _kind_hint: dimension
      table_calculation: target
      _type_hint: number
    row: 2
    col: 21
    width: 3
    height: 5
  - name: " (3)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '[{"type":"h1","children":[{"text":"KPI Performance This Month"}],"align":"center"}]'
    rich_content_json: '{"format":"slate"}'
    row: 0
    col: 0
    width: 24
    height: 2
  - title: Are our clients promoters of our services?
    name: Are our clients promoters of our services?
    model: analytics
    explore: nps_survey_results_fact
    type: looker_column
    fields: [nps_survey_results_fact.average_nps_score, nps_survey_results_fact.nps_survey_ts_month]
    fill_fields: [nps_survey_results_fact.nps_survey_ts_month]
    filters:
      nps_survey_results_fact.nps_survey_ts_date: 1 years
    sorts: [nps_survey_results_fact.nps_survey_ts_month]
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: false
    interpolation: linear
    x_axis_zoom: true
    y_axis_zoom: true
    reference_lines: [{reference_type: range, margin_top: deviation, margin_value: mean,
        margin_bottom: deviation, label_position: right, color: "#7bc739", line_value: '8',
        range_start: '8', range_end: '10', label: Promoter}, {reference_type: range,
        line_value: mean, margin_top: deviation, margin_value: mean, margin_bottom: deviation,
        label_position: right, color: "#E48522", range_start: '6', range_end: '8',
        label: Passive}, {reference_type: range, line_value: mean, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: right, color: "#D13452",
        range_start: '0', range_end: '6', label: Detractor}]
    defaults_version: 1
    listen: {}
    row: 90
    col: 12
    width: 6
    height: 9
  - title: Individual Utilisation
    name: Individual Utilisation
    model: analytics
    explore: contacts
    type: looker_line
    fields: [timesheets_fact.timesheet_billing_week, timesheets_fact.total_timesheet_billable_hours_billed,
      timesheets_fact.total_timesheet_nonbillable_hours_billed, contacts.contact_name]
    pivots: [contacts.contact_name]
    fill_fields: [timesheets_fact.timesheet_billing_week]
    filters:
      contacts.contact_is_staff: 'Yes'
      contacts.contact_name: Lewis Baker,Jordan Ilyat,Lydia Blackley,Bailey Sharpledger
      timesheets_fact.timesheet_billing_week: 26 week ago for 26 week
    sorts: [contacts.contact_name, timesheets_fact.timesheet_billing_week desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${timesheets_fact.total_timesheet_billable_hours_billed}/(${timesheets_fact.total_timesheet_billable_hours_billed}+${timesheets_fact.total_timesheet_nonbillable_hours_billed})"
      label: Util %
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: util
      _type_hint: number
    - category: measure
      label: Client Project Hours
      based_on: timesheets_fact.total_timesheet_hours_billed
      _kind_hint: measure
      measure: client_project_hours
      type: count_distinct
      _type_hint: number
      filters:
        projects_delivered.project_is_billable: 'Yes'
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
    trellis: pivot
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
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      timesheets_fact.total_timesheet_nonbillable_hours_billed: "#d4d4d4"
      timesheets_fact.total_timesheet_billable_hours_billed: "#4A80BC"
    series_labels:
      timesheets_fact.total_timesheet_hours_billed: Paid Hours
      timesheets_fact.total_timesheet_nonbillable_hours_billed: Non-Billable Activity
      timesheets_fact.total_timesheet_billable_hours_billed: Billable Activity
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#000000", label: ''}]
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
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
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      timesheets_fact.total_timesheet_hours_billed:
        is_active: true
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields: [timesheets_fact.total_timesheet_billable_hours_billed, timesheets_fact.total_timesheet_nonbillable_hours_billed]
    listen: {}
    row: 117
    col: 12
    width: 12
    height: 10
  - title: How does revenue break-down by consultant and project this month?
    name: How does revenue break-down by consultant and project this month?
    model: analytics
    explore: companies_dim
    type: marketplace_viz_report_table::report_table-marketplace
    fields: [recognized_project_revenue.billing_month_month, recognized_revenue_contact.contact_name,
      project_timesheet_projects.project_name, recognized_project_revenue.total_hours_billed,
      recognized_project_revenue.total_recognized_revenue_gbp]
    filters:
      recognized_project_revenue.billing_month_month: 1 months
    sorts: [recognized_project_revenue.billing_month_month, recognized_revenue_contact.contact_name
        desc, project_timesheet_projects.project_name]
    subtotals: [recognized_project_revenue.billing_month_month, recognized_revenue_contact.contact_name]
    limit: 500
    column_limit: 50
    total: true
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    theme: traditional
    layout: auto
    minWidthForIndexColumns: true
    bodyFontSize: 12
    columnOrder: {}
    rowSubtotals: true
    colSubtotals: false
    spanRows: true
    useUnit: false
    indexColumn: false
    hide|recognized_project_revenue.billing_month_month: true
    label|recognized_revenue_contact.contact_name: Consultant Name
    label|project_timesheet_projects.project_name: Project
    subtotalDepth: '2'
    label|recognized_project_revenue.total_recognized_revenue_gbp: Total Revenue Contribution
    style|recognized_project_revenue.total_recognized_revenue_gbp: normal
    reportIn|recognized_project_revenue.total_recognized_revenue_gbp: '1'
    unit|recognized_project_revenue.total_recognized_revenue_gbp: ''
    style|recognized_project_revenue.total_hours_billed: normal
    hidden_pivots: {}
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 0
    listen: {}
    row: 127
    col: 12
    width: 12
    height: 10
  - name: Recognized Revenue MTD
    title: Recognized Revenue MTD
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: looker_column
      fields: [recognized_project_revenue.billing_month_month, recognized_project_revenue.total_recognized_revenue_gbp]
      fill_fields: [recognized_project_revenue.billing_month_month]
      filters:
        recognized_project_revenue.billing_month_month: 1 months
      sorts: [recognized_project_revenue.billing_month_month desc]
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
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      show_null_points: true
      interpolation: linear
      defaults_version: 1
    - model: analytics
      explore: targets
      type: table
      fields: [targets.period_month, targets.revenue_target]
      sorts: [targets.period_month desc]
      limit: 500
      join_fields:
      - field_name: targets.period_month
        source_field_name: recognized_project_revenue.billing_month_month
    custom_color_enabled: true
    show_single_value_title: true
    value_format: ''
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting: [{type: greater than, value: 1, background_color: "#7bc739",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: between, value: [0.8, 1],
        background_color: "#E48522", font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: less than, value: 0.8, background_color: "#D13452",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1}, bold: false, italic: false,
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
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      remaining_target_gbp: "#E1E1E8"
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    type: single_value
    hidden_fields: [recognized_project_revenue.billing_month_month, remaining_target_gbp,
      targets.revenue_target, revenue_target, pro_rata_target_recognized_revenue,
      recognized_project_revenue.total_recognized_revenue_gbp]
    hidden_pivots: {}
    sorts: [recognized_project_revenue.billing_month_month]
    dynamic_fields:
    - category: table_calculation
      expression: "${targets.revenue_target}"
      label: Revenue Target
      value_format: '"£"0,"K"'
      value_format_name: __custom
      _kind_hint: dimension
      table_calculation: revenue_target
      _type_hint: number
    - category: table_calculation
      expression: "${revenue_target}*(extract_days(now())/30)"
      label: Pro-Rata Target Recognized Revenue
      value_format:
      value_format_name: gbp_0
      _kind_hint: dimension
      table_calculation: pro_rata_target_recognized_revenue
      _type_hint: number
    - category: table_calculation
      expression: "${recognized_project_revenue.total_recognized_revenue_gbp}/${pro_rata_target_recognized_revenue}"
      label: Recognized Revenue as % of Target
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: recognized_revenue_as_of_target
      _type_hint: number
    - category: table_calculation
      expression: '1'
      label: Target %
      value_format:
      value_format_name: percent_0
      _kind_hint: dimension
      table_calculation: target
      _type_hint: number
    row: 2
    col: 6
    width: 3
    height: 5
  - title: How well utilised is the Delivery team this year?
    name: How well utilised is the Delivery team this year?
    model: analytics
    explore: contacts
    type: looker_line
    fields: [timesheets_fact.timesheet_billing_week, timesheets_fact.total_timesheet_billable_hours_billed,
      timesheets_fact.total_timesheet_nonbillable_hours_billed]
    filters:
      contacts.contact_is_staff: 'Yes'
      contacts.contact_name: Lewis Baker,Amir Jaber,Jordan Ilyat,Lydia Blackley,Bailey
        Sharpledger,Olivier Dupuis
      timesheets_fact.timesheet_billing_week: 52 week ago for 52 week
      timesheets_fact.total_timesheet_billable_hours_billed: NOT NULL
    sorts: [timesheets_fact.timesheet_billing_week desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${timesheets_fact.total_timesheet_billable_hours_billed}/(${timesheets_fact.total_timesheet_billable_hours_billed}+${timesheets_fact.total_timesheet_nonbillable_hours_billed})"
      label: Util %
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: util
      _type_hint: number
    - category: measure
      label: Client Project Hours
      based_on: timesheets_fact.total_timesheet_hours_billed
      _kind_hint: measure
      measure: client_project_hours
      type: count_distinct
      _type_hint: number
      filters:
        projects_delivered.project_is_billable: 'Yes'
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
    trellis: pivot
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
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      timesheets_fact.total_timesheet_nonbillable_hours_billed: "#d4d4d4"
      timesheets_fact.total_timesheet_billable_hours_billed: "#4A80BC"
    series_labels:
      timesheets_fact.total_timesheet_hours_billed: Paid Hours
      timesheets_fact.total_timesheet_nonbillable_hours_billed: Non-Billable Activity
      timesheets_fact.total_timesheet_billable_hours_billed: Billable Activity
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#000000", label: ''}]
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
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
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      timesheets_fact.total_timesheet_hours_billed:
        is_active: true
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields: [timesheets_fact.total_timesheet_billable_hours_billed, timesheets_fact.total_timesheet_nonbillable_hours_billed]
    listen: {}
    row: 110
    col: 12
    width: 12
    height: 7
  - title: How "hot" is the delivery team machine running right now,  vs historically?
    name: How "hot" is the delivery team machine running right now,  vs historically?
    model: analytics
    explore: contacts
    type: marketplace_viz_calendar_heatmap::calendar_heatmap-marketplace
    fields: [timesheets_fact.total_timesheet_billable_hours_billed, timesheets_fact.total_timesheet_nonbillable_hours_billed,
      timesheets_fact.timesheet_billing_date]
    filters:
      contacts.contact_is_staff: 'Yes'
      contacts.contact_name: Jordan Ilyat,Lydia Blackley,Lewis Baker,Bailey Sharpledger,Amir
        Jaber,Olivier Dupuis
      timesheets_fact.timesheet_billing_week: 104 week ago for 104 week
      timesheets_fact.total_timesheet_billable_hours_billed: NOT NULL
    sorts: [timesheets_fact.timesheet_billing_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${timesheets_fact.total_timesheet_billable_hours_billed}/(${timesheets_fact.total_timesheet_billable_hours_billed}+${timesheets_fact.total_timesheet_nonbillable_hours_billed})"
      label: Util %
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: util
      _type_hint: number
    - category: measure
      label: Client Project Hours
      based_on: timesheets_fact.total_timesheet_hours_billed
      _kind_hint: measure
      measure: client_project_hours
      type: count_distinct
      _type_hint: number
      filters:
        projects_delivered.project_is_billable: 'Yes'
    hidden_fields: [timesheets_fact.total_timesheet_billable_hours_billed, timesheets_fact.total_timesheet_nonbillable_hours_billed]
    hidden_points_if_no: []
    series_labels:
      timesheets_fact.total_timesheet_hours_billed: Paid Hours
      timesheets_fact.total_timesheet_nonbillable_hours_billed: Non-Billable Activity
      timesheets_fact.total_timesheet_billable_hours_billed: Billable Activity
    show_view_names: false
    rounded: false
    outline: quarter
    label_year: true
    label_month: true
    viz_show_legend: true
    focus_tooltip: true
    outline_weight: 0.2
    cell_reducer: 1
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
    trellis: pivot
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
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
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      timesheets_fact.total_timesheet_nonbillable_hours_billed: "#d4d4d4"
      timesheets_fact.total_timesheet_billable_hours_billed: "#4A80BC"
    reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: left,
        color: "#000000", label: ''}]
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
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
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      timesheets_fact.total_timesheet_hours_billed:
        is_active: true
    hidden_pivots: {}
    defaults_version: 0
    listen: {}
    row: 99
    col: 12
    width: 12
    height: 11
  - title: What do our clients say about us?
    name: What do our clients say about us?
    model: analytics
    explore: companies_dim
    type: looker_grid
    fields: [nps_survey_results_fact.nps_survey_ts_date, companies_dim.company_name,
      nps_survey_results_fact.average_nps_score, nps_survey_results_fact.nps_survey_feedback,
      nps_survey_results_fact.nps_sentiment, nps_survey_results_fact.contact_name]
    filters:
      nps_survey_results_fact.nps_survey_ts_date: 1 years
    sorts: [nps_survey_results_fact.nps_survey_ts_date]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
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
    truncate_header: false
    minimum_column_width: 75
    series_column_widths:
      nps_survey_results_fact.nps_survey_ts_date: 163
      companies_dim.company_name: 171
      nps_survey_results_fact.nps_survey_feedback: 484
    series_cell_visualizations:
      nps_survey_results_fact.average_nps_score:
        is_active: false
    conditional_formatting: [{type: equal to, value: 10, background_color: "#7bc739",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: equal to, value: 9, background_color: "#C4DF58",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: between, value: [6, 8], background_color: "#E48522",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: less than, value: 6, background_color: "#D13452",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    hidden_pivots: {}
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
    listen: {}
    row: 90
    col: 0
    width: 12
    height: 9
  - title: What does our pipeline look like?
    name: What does our pipeline look like?
    model: analytics
    explore: companies_dim
    type: looker_funnel
    fields: [deals_fact.pipeline_stage_label, deals_fact.total_deal_amount_gbp_converted]
    filters:
      deals_fact.pipeline_stage_label: Initial Enquiry,Project Scoping,SoW Drafted,Partner
        Funding Agreed (*),Partner Funding Signoff (*),Customer Agreed SoW
    sorts: [deals_fact.pipeline_stage_label]
    limit: 500
    column_limit: 50
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    smoothedBars: false
    orientation: columns
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: inline
    labelColorEnabled: false
    labelColor: "#FFF"
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    isStepped: true
    labelOverlap: false
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
    legend_position: right
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
    x_axis_zoom: true
    y_axis_zoom: true
    hide_legend: false
    hidden_pivots: {}
    defaults_version: 1
    listen: {}
    row: 78
    col: 0
    width: 12
    height: 10
  - name: 'What does our backlog of booked and weighted pipeline look like historically? '
    title: 'What does our backlog of booked and weighted pipeline look like historically? '
    note_state: collapsed
    note_display: hover
    note_text: Each month's number is calculated from the total remaining unbilled
      revenue for booked (closed and being delivered) project engagements, plus the
      total weighted value of possible future engagement currently in the sales pipeline.
    merged_queries:
    - model: analytics
      explore: project_engagements
      type: table
      fields: [project_engagements.booking_month, project_engagements.booked_revenue]
      fill_fields: [project_engagements.booking_month]
      filters:
        project_engagements.booking_month: 18 months
      sorts: [project_engagements.booking_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: to_string(${project_engagements.booking_month})
        label: Booking Month String
        value_format:
        value_format_name:
        _kind_hint: dimension
        table_calculation: booking_month_string
        _type_hint: string
      join_fields: []
    - model: analytics
      explore: companies_dim
      type: looker_column
      fields: [deal_pipeline_history.total_weighted_amount_gbp, deal_pipeline_history.deal_month_ts_month]
      fill_fields: [deal_pipeline_history.deal_month_ts_month]
      sorts: [deal_pipeline_history.deal_month_ts_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: substring(to_string(add_months(1,${deal_pipeline_history.deal_month_ts_month})),1,7)
        label: Sales Pipeline Start of Month
        value_format:
        value_format_name:
        _kind_hint: dimension
        table_calculation: sales_pipeline_start_of_month
        _type_hint: string
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
        palette_id: 95584bf9-c29e-41ea-b6e7-79e9c126e177
        options:
          steps: 5
      x_axis_zoom: true
      y_axis_zoom: true
      limit_displayed_rows_values:
        show_hide: hide
        first_last: first
        num_rows: 0
      hidden_series: ['0: Lost - deal_pipeline_history.total_deal_amount_gbp', '4:
          Deal close - deal_pipeline_history.total_deal_amount_gbp']
      series_colors:
        '0: Lost - deal_pipeline_history.total_deal_amount_gbp': "#e3e3e3"
      show_null_points: true
      interpolation: linear
      hidden_pivots: {}
      defaults_version: 1
      hidden_fields: [deal_pipeline_history.deal_month_ts_month]
      join_fields:
      - field_name: sales_pipeline_start_of_month
        source_field_name: booking_month_string
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
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '3'
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      project_engagements.booked_revenue: "#4A80BC"
      deal_pipeline_history.total_weighted_amount_gbp: "#E1E1E8"
    series_labels:
      deal_pipeline_history.total_weighted_amount_gbp: Weighted Pipeline
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
    type: looker_column
    hidden_fields: [deal_pipeline_history.deal_month_ts_month, booking_month_string]
    row: 78
    col: 12
    width: 12
    height: 10
  - name: How much business did we close?
    title: How much business did we close?
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: looker_column
      fields: [deals_fact.deal_closed_month, deals_fact.total_closed_won_deal_amount_gbp]
      fill_fields: [deals_fact.deal_closed_month]
      filters:
        deals_fact.deal_closed_date: 1 years
      sorts: [deals_fact.deal_closed_month desc]
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
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      show_null_points: true
      interpolation: linear
      defaults_version: 1
    - model: analytics
      explore: targets
      type: table
      fields: [targets.total_deals_closed_revenue_target, targets.period_month]
      fill_fields: [targets.period_month]
      sorts: [targets.period_month desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: targets.period_month
        source_field_name: deals_fact.deal_closed_month
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
    series_types:
      deals_fact.total_closed_won_deal_amount_gbp: column
    point_style: none
    series_colors:
      targets.total_deals_closed_revenue_target: "#D13452"
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    type: looker_line
    row: 68
    col: 12
    width: 12
    height: 10
  - title: Current Engagements
    name: Current Engagements
    model: analytics
    explore: companies_dim
    type: looker_grid
    fields: [companies_dim.company_name, engagements.deal_name, engagements.engagement_start_ts_date,
      engagements.engagement_end_ts_date, engagements.total_engagement_deal_amount,
      timesheet_project_engagement_timesheets_projects_dim.total_project_fee_amount,
      timesheet_project_engagements_projects_invoiced.total_invoiced_net_amount_gbp,
      timesheet_project_engagement_timesheets.total_timesheet_billable_hours_billed,
      timesheet_project_engagement_timesheets.total_timesheet_cost_amount_gbp, timesheet_project_engagement_project_costs_fact.total_cost_gbp,
      timesheet_project_engagement_timesheets.total_timesheet_nonbillable_hours_billed]
    filters:
      engagements.engagement_end_ts_date: after 0 days ago
      engagements.engagement_start_ts_date: before 0 days ago
      companies_dim.company_name: ''
      customer_meetings.contact_name: ''
    sorts: [engagements.engagement_start_ts_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: diff_days(${engagements.engagement_start_ts_date},now())/diff_days(${engagements.engagement_start_ts_date},${engagements.engagement_end_ts_date})
      label: "% of Engagement Time"
      value_format:
      value_format_name: percent_0
      _kind_hint: dimension
      table_calculation: of_engagement_time
      _type_hint: number
    - category: table_calculation
      expression: "${timesheet_project_engagement_timesheets_projects_dim.total_project_fee_amount}/(${timesheet_project_engagement_timesheets.total_timesheet_billable_hours_billed}+${timesheet_project_engagement_timesheets.total_timesheet_nonbillable_hours_billed})"
      label: Blended Hourly Rate
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: blended_hourly_rate
      _type_hint: number
    - category: table_calculation
      expression: "(${timesheet_project_engagement_timesheets_projects_dim.total_project_fee_amount}-${timesheet_project_engagement_timesheets.total_timesheet_cost_amount_gbp}-coalesce(${timesheet_project_engagement_project_costs_fact.total_cost_gbp},0))/${timesheet_project_engagement_timesheets_projects_dim.total_project_fee_amount}"
      label: Engagement Margin %
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: engagement_margin
      _type_hint: number
    - category: table_calculation
      expression: "${timesheet_project_engagement_timesheets_projects_dim.total_project_fee_amount}/${engagements.total_engagement_deal_amount}"
      label: Budget Burned %
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: budget_burned
      _type_hint: number
    - category: table_calculation
      expression: "${timesheet_project_engagements_projects_invoiced.total_invoiced_net_amount_gbp}/${timesheet_project_engagement_timesheets_projects_dim.total_project_fee_amount}"
      label: Burned Invoiced %
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: burned_invoiced
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
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", companies_dim.company_name, engagements.deal_name,
      engagements.engagement_start_ts_date, of_engagement_time, budget_burned, burned_invoiced,
      engagement_margin, engagements.total_engagement_deal_amount, timesheet_project_engagement_timesheets_projects_dim.total_project_fee_amount,
      timesheet_project_engagements_projects_invoiced.total_invoiced_net_amount_gbp,
      timesheet_project_engagement_timesheets.total_timesheet_billable_hours_billed,
      timesheet_project_engagement_timesheets.total_timesheet_nonbillable_hours_billed,
      timesheet_project_engagement_timesheets.total_timesheet_cost_amount_gbp, timesheet_project_engagement_project_costs_fact.total_cost_gbp,
      blended_hourly_rate]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      engagements.total_engagement_deal_amount: Total Budget
      timesheet_project_engagement_timesheets_projects_dim.total_project_fee_amount: Budget
        Burned
      of_engagement_time: "% Days Complete"
      engagement_margin: Margin %
      engagements.engagement_start_ts_date: Start Date
      engagements.deal_name: Name
      companies_dim.company_name: Client
      timesheet_project_engagements_projects_invoiced.total_invoiced_net_amount_gbp: Budget
        Invoiced
      timesheet_project_engagement_timesheets.total_timesheet_billable_hours_billed: Billable
        Hours
      timesheet_project_engagement_timesheets.total_timesheet_cost_amount_gbp: Hours
        Cost
      timesheet_project_engagement_project_costs_fact.total_cost_gbp: Contractor Cost
      timesheet_project_engagement_timesheets.total_timesheet_nonbillable_hours_billed: Non-Billable
        Hours
      blended_hourly_rate: Blended Rate
    series_column_widths:
      timesheet_project_engagement_timesheets.total_timesheet_cost_amount_gbp: 1
    series_cell_visualizations:
      engagements.total_engagement_deal_amount:
        is_active: false
      of_engagement_time:
        is_active: true
      engagement_margin:
        is_active: true
      budget_burned:
        is_active: true
      burned_invoiced:
        is_active: true
    conditional_formatting: [{type: less than, value: 140, background_color: "#D13452",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830, options: {constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [blended_hourly_rate]}, {type: between, value: [
          140, 190], background_color: "#E48522", font_color: !!null '', color_application: {
          collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c, palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830,
          options: {constraints: {min: {type: minimum}, mid: {type: number, value: 0},
              max: {type: maximum}}, mirror: true, reverse: false, stepped: false}},
        bold: false, italic: false, strikethrough: false, fields: [blended_hourly_rate]},
      {type: greater than, value: 190, background_color: "#7bc739", font_color: !!null '',
        color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c, palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830,
          options: {constraints: {min: {type: minimum}, mid: {type: number, value: 0},
              max: {type: maximum}}, mirror: true, reverse: false, stepped: false}},
        bold: false, italic: false, strikethrough: false, fields: [blended_hourly_rate]}]
    series_value_format:
      engagements.total_engagement_deal_amount:
        name: gbp_0
        decimals: '0'
        format_string: '"£"#,##0'
        label: British Pounds (0)
        label_prefix: British Pounds
      timesheet_project_engagement_timesheets_projects_dim.total_project_fee_amount:
        name: gbp_0
        decimals: '0'
        format_string: '"£"#,##0'
        label: British Pounds (0)
        label_prefix: British Pounds
      timesheet_project_engagements_projects_invoiced.total_invoiced_net_amount_gbp:
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
    hidden_pivots: {}
    hidden_fields: [engagements.engagement_end_ts_date, timesheet_project_engagement_timesheets.total_timesheet_cost_amount_gbp,
      timesheet_project_engagement_project_costs_fact.total_cost_gbp]
    listen: {}
    row: 55
    col: 0
    width: 24
    height: 5
  - name: " (Copy)"
    type: text
    title_text: " (Copy)"
    subtitle_text: ''
    body_text: '[{"type":"h1","children":[{"text":"Sales Pipeline"}],"align":"center"}]'
    rich_content_json: '{"format":"slate"}'
    row: 60
    col: 0
    width: 24
    height: 2
  - title: Untitled
    name: Untitled
    model: analytics
    explore: companies_dim
    type: looker_grid
    fields: [timesheet_project_engagement_rag_status_fact.engagement_name, timesheet_project_engagement_rag_status_fact.financials_rag_status,
      timesheet_project_engagement_rag_status_fact.scope_rag_status, timesheet_project_engagement_rag_status_fact.schedule_rag_status,
      timesheet_project_engagement_rag_status_fact.resourcing_rag_status, timesheet_project_engagement_rag_status_fact.data_quality_qa_rag_status,
      timesheet_project_engagement_rag_status_fact.technology_rag_status]
    filters:
      timesheet_project_engagement_rag_status_fact.reporting_month: 1 months
    sorts: [timesheet_project_engagement_rag_status_fact.engagement_name]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: transparent
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
    truncate_column_names: false
    defaults_version: 1
    listen: {}
    row: 50
    col: 0
    width: 24
    height: 5
  - name: Consultant Billing Last Month
    title: Consultant Billing Last Month
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: looker_column
      fields: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_month,
        recognized_project_revenue.total_hours_billed, recognized_project_revenue.total_recognized_revenue_gbp]
      filters:
        recognized_project_revenue.billing_month_month: 1 month ago for 1 month
      sorts: [recognized_project_revenue.billing_month_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: "${recognized_project_revenue.total_recognized_revenue_gbp}/${recognized_project_revenue.total_hours_billed}"
        label: Avg Hourly Rate
        value_format:
        value_format_name: gbp_0
        _kind_hint: measure
        table_calculation: avg_hourly_rate
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
      defaults_version: 1
    - model: analytics
      explore: targets
      type: table
      fields: [targets.period_month, targets.total_sae_target_hours, targets.total_prn_target_hours,
        targets.total_con_target_hours, targets.total_ceo_target_hours, targets.total_ae_target_hours,
        targets.avg_sae_target_hourly_rate, targets.avg_prn_target_hourly_rate, targets.avg_con_target_hourly_rate,
        targets.avg_ceo_target_hourly_rate, targets.avg_ae_target_hourly_rate, targets.total_sae_revenue_target,
        targets.total_prn_revenue_target, targets.total_con_revenue_target, targets.total_ceo_revenue_target,
        targets.total_ae_revenue_target]
      fill_fields: [targets.period_month]
      limit: 500
      join_fields:
      - field_name: targets.period_month
        source_field_name: recognized_project_revenue.billing_month_month
    hidden_fields: [targets.total_ae_target_hours, targets.total_sae_target_hours,
      targets.total_prn_target_hours, targets.total_ceo_target_hours, targets.total_con_target_hours,
      targets.avg_ae_target_hourly_rate, targets.avg_sae_target_hourly_rate, targets.avg_prn_target_hourly_rate,
      targets.avg_ceo_target_hourly_rate, targets.avg_con_target_hourly_rate, targets.total_ae_revenue_target,
      targets.total_sae_revenue_target, targets.total_prn_revenue_target, targets.total_ceo_revenue_target,
      targets.total_con_revenue_target, target_billable_hours, target_billable_rate,
      target_billable_revenue]
    type: looker_grid
    series_types: {}
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
    minimum_column_width: 75
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", recognized_revenue_contact.contact_name,
      recognized_project_revenue.billing_month_month, recognized_project_revenue.total_recognized_revenue_gbp,
      target_recognized_revenue, recognized_project_revenue.total_hours_billed, target_hours_billed,
      avg_hourly_rate, target_hourly_rate]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    series_labels:
      recognized_project_revenue.total_recognized_revenue_gbp: Attributed Revenue
      avg_hourly_rate: Avg Hourly Rate
      target_hours_billed: "% Target Hours"
      target_hourly_rate: "% Target Rate"
      target_recognized_revenue: "% Target Revenue"
    series_cell_visualizations:
      recognized_project_revenue.total_hours_billed:
        is_active: false
      target_hours_billed:
        is_active: false
        palette:
          palette_id: 4868aae1-d096-4d4d-a37b-8d86e7f50396
          collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
        value_display: true
      target_hourly_rate:
        is_active: false
        palette:
          palette_id: 4868aae1-d096-4d4d-a37b-8d86e7f50396
          collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
        value_display: true
      target_recognized_revenue:
        is_active: false
        palette:
          palette_id: 4868aae1-d096-4d4d-a37b-8d86e7f50396
          collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
        value_display: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4A80BC",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 4868aae1-d096-4d4d-a37b-8d86e7f50396, options: {steps: 5}},
        bold: false, italic: false, strikethrough: false, fields: [target_hours_billed,
          target_hourly_rate, target_recognized_revenue]}]
    series_value_format: {}
    hidden_pivots: {}
    query_fields:
      measures:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: Total billable hours billed by consultant
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: "     Recognised Revenue Total Hours Billed"
        label_from_parameter:
        label_short: Total Hours Billed
        map_layer:
        name: recognized_project_revenue.total_hours_billed
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
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        original_view: recognized_revenue_fact
        dimension_group:
        error:
        field_group_variant: Total Hours Billed
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: recognized_project_revenue
        suggest_dimension: recognized_project_revenue.total_hours_billed
        suggest_explore: companies_dim
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=48"
        permanent: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${consultant_hours_billed} "
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
        label: "     Recognised Revenue Total Recognized Revenue Gbp"
        label_from_parameter:
        label_short: Total Recognized Revenue Gbp
        map_layer:
        name: recognized_project_revenue.total_recognized_revenue_gbp
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
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        original_view: recognized_revenue_fact
        dimension_group:
        error:
        field_group_variant: Total Recognized Revenue Gbp
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: recognized_project_revenue
        suggest_dimension: recognized_project_revenue.total_recognized_revenue_gbp
        suggest_explore: companies_dim
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=55"
        permanent: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${consultant_recognized_revenue_gbp} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - type: number
        align: right
        measure: true
        dynamic: false
        can_pivot: true
        value_format: '"£"#,##0'
        is_numeric: true
        name: avg_hourly_rate
        label: Avg Hourly Rate
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
        label: Targets Total Ae Target Hours
        label_from_parameter:
        label_short: Total Ae Target Hours
        map_layer:
        name: targets.total_ae_target_hours
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
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Total Ae Target Hours
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.total_ae_target_hours
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=201"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${ae_target_hours} "
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
        label: Targets Total Sae Target Hours
        label_from_parameter:
        label_short: Total Sae Target Hours
        map_layer:
        name: targets.total_sae_target_hours
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
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Total Sae Target Hours
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.total_sae_target_hours
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=206"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${sae_target_hours} "
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
        label: Targets Total Prn Target Hours
        label_from_parameter:
        label_short: Total Prn Target Hours
        map_layer:
        name: targets.total_prn_target_hours
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
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Total Prn Target Hours
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.total_prn_target_hours
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=211"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${prn_target_hours} "
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
        label: Targets Total Ceo Target Hours
        label_from_parameter:
        label_short: Total Ceo Target Hours
        map_layer:
        name: targets.total_ceo_target_hours
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
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Total Ceo Target Hours
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.total_ceo_target_hours
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=216"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${ceo_target_hours} "
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
        label: Targets Total Con Target Hours
        label_from_parameter:
        label_short: Total Con Target Hours
        map_layer:
        name: targets.total_con_target_hours
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
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Total Con Target Hours
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.total_con_target_hours
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=221"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${con_target_hours} "
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
        label: Targets Avg Ae Target Hourly Rate
        label_from_parameter:
        label_short: Avg Ae Target Hourly Rate
        map_layer:
        name: targets.avg_ae_target_hourly_rate
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
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Avg Ae Target Hourly Rate
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.avg_ae_target_hourly_rate
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=175"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${TABLE}.ae_tgt_rate "
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
        label: Targets Avg Sae Target Hourly Rate
        label_from_parameter:
        label_short: Avg Sae Target Hourly Rate
        map_layer:
        name: targets.avg_sae_target_hourly_rate
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
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Avg Sae Target Hourly Rate
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.avg_sae_target_hourly_rate
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=180"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${TABLE}.sae_tgt_rate "
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
        label: Targets Avg Prn Target Hourly Rate
        label_from_parameter:
        label_short: Avg Prn Target Hourly Rate
        map_layer:
        name: targets.avg_prn_target_hourly_rate
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
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Avg Prn Target Hourly Rate
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.avg_prn_target_hourly_rate
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=185"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${TABLE}.prn_tgt_rate "
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
        label: Targets Avg Ceo Target Hourly Rate
        label_from_parameter:
        label_short: Avg Ceo Target Hourly Rate
        map_layer:
        name: targets.avg_ceo_target_hourly_rate
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
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Avg Ceo Target Hourly Rate
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.avg_ceo_target_hourly_rate
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=190"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${TABLE}.ceo_tgt_rate "
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
        label: Targets Avg Con Target Hourly Rate
        label_from_parameter:
        label_short: Avg Con Target Hourly Rate
        map_layer:
        name: targets.avg_con_target_hourly_rate
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
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Avg Con Target Hourly Rate
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.avg_con_target_hourly_rate
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=195"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${TABLE}.con_tgt_rate "
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
        label: Targets Total Ae Revenue Target
        label_from_parameter:
        label_short: Total Ae Revenue Target
        map_layer:
        name: targets.total_ae_revenue_target
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
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Total Ae Revenue Target
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.total_ae_revenue_target
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=322"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${ae_revenue_target} "
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
        label: Targets Total Sae Revenue Target
        label_from_parameter:
        label_short: Total Sae Revenue Target
        map_layer:
        name: targets.total_sae_revenue_target
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
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Total Sae Revenue Target
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.total_sae_revenue_target
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=316"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${sae_revenue_target} "
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
        label: Targets Total Prn Revenue Target
        label_from_parameter:
        label_short: Total Prn Revenue Target
        map_layer:
        name: targets.total_prn_revenue_target
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
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Total Prn Revenue Target
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.total_prn_revenue_target
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=340"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${prn_revenue_target} "
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
        label: Targets Total Ceo Revenue Target
        label_from_parameter:
        label_short: Total Ceo Revenue Target
        map_layer:
        name: targets.total_ceo_revenue_target
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
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Total Ceo Revenue Target
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.total_ceo_revenue_target
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=328"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${ceo_revenue_target} "
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
        label: Targets Total Con Revenue Target
        label_from_parameter:
        label_short: Total Con Revenue Target
        map_layer:
        name: targets.total_con_revenue_target
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
        view: targets
        view_label: Targets
        dynamic: false
        week_start_day: monday
        original_view: targets
        dimension_group:
        error:
        field_group_variant: Total Con Revenue Target
        measure: true
        parameter: false
        primary_key: false
        project_name: analytics
        scope: targets
        suggest_dimension: targets.total_con_revenue_target
        suggest_explore: targets
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Ftargets.view.lkml?line=334"
        permanent: true
        source_file: views/targets.view.lkml
        source_file_path: analytics/views/targets.view.lkml
        sql: "${con_revenue_target} "
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
        field_group_label: "      Contact Details"
        fill_style:
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: false
        label: "     Recognised Revenue Contact Name"
        label_from_parameter:
        label_short: Contact Name
        map_layer:
        name: recognized_revenue_contact.contact_name
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: string
        user_attribute_filter_types:
        - string
        - advanced_filter_string
        value_format:
        view: recognized_revenue_contact
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        original_view: contacts_dim
        dimension_group:
        error:
        field_group_variant: Contact Name
        measure: false
        parameter: false
        primary_key: false
        project_name: analytics
        scope: recognized_revenue_contact
        suggest_dimension: recognized_revenue_contact.contact_name
        suggest_explore: companies_dim
        suggestable: true
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/analytics/files/views%2Fcontacts_dim.view.lkml?line=486"
        permanent: true
        source_file: views/contacts_dim.view.lkml
        source_file_path: analytics/views/contacts_dim.view.lkml
        sql: "${TABLE}.contact_name "
        sql_case:
        filters:
        times_used: 0
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        enumerations:
        field_group_label: Billing Month Date
        fill_style: range
        fiscal_month_offset: 3
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: false
        label: "     Recognised Revenue Billing Month Month"
        label_from_parameter:
        label_short: Billing Month Month
        map_layer:
        name: recognized_project_revenue.billing_month_month
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
        view: recognized_project_revenue
        view_label: "     Recognised Revenue"
        dynamic: false
        week_start_day: monday
        original_view: recognized_revenue_fact
        dimension_group: recognized_project_revenue.billing_month
        error:
        field_group_variant: Month
        measure: false
        parameter: false
        primary_key: false
        project_name: analytics
        scope: recognized_project_revenue
        suggest_dimension: recognized_project_revenue.billing_month_month
        suggest_explore: companies_dim
        suggestable: false
        is_fiscal: false
        is_timeframe: true
        can_time_filter: false
        time_interval:
          name: month
          count: 1
        lookml_link: "/projects/analytics/files/views%2Frecognized_revenue_fact.view.lkml?line=13"
        permanent: true
        source_file: views/recognized_revenue_fact.view.lkml
        source_file_path: analytics/views/recognized_revenue_fact.view.lkml
        sql: "${TABLE}.billing_month "
        sql_case:
        filters:
        times_used: 0
        sorted:
          sort_index: 0
          desc: true
      table_calculations:
      - label: Target Billable Hours
        name: target_billable_hours
        expression: "if(\n  ${recognized_revenue_contact.contact_name}=\"Lydia Blackley\"\
          \n  OR (${recognized_revenue_contact.contact_name}=\"Jordan Ilyat\" AND\
          \ extract_months(${recognized_project_revenue.billing_month_month})=1),\n\
          \  ${targets.total_ae_target_hours},\n  if(\n    ${recognized_revenue_contact.contact_name}=\"\
          Jordan Ilyat\" \n    AND extract_months(${recognized_project_revenue.billing_month_month})=2,\n\
          \    ${targets.total_sae_target_hours},\n    if(\n      ${recognized_revenue_contact.contact_name}=\"\
          Bailey Sharpledger\",\n      ${targets.total_sae_target_hours},\n      if(\n\
          \        ${recognized_revenue_contact.contact_name}=\"Lewis Baker\",\n \
          \       ${targets.total_prn_target_hours},\n        ${targets.total_ceo_target_hours}\n\
          \      )\n    )\n  )\n)"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format:
        is_numeric: true
      - label: Target Billable Rate
        name: target_billable_rate
        expression: "if(\n  ${recognized_revenue_contact.contact_name}=\"Lydia Blackley\"\
          \n  OR (${recognized_revenue_contact.contact_name}=\"Jordan Ilyat\" AND\
          \ extract_months(${recognized_project_revenue.billing_month_month})=1),\n\
          \  ${targets.avg_ae_target_hourly_rate},\n  if(\n    ${recognized_revenue_contact.contact_name}=\"\
          Jordan Ilyat\" \n    AND extract_months(${recognized_project_revenue.billing_month_month})=2,\n\
          \    ${targets.avg_sae_target_hourly_rate},\n    if(\n      ${recognized_revenue_contact.contact_name}=\"\
          Bailey Sharpledger\",\n      ${targets.avg_sae_target_hourly_rate},\n  \
          \    if(\n        ${recognized_revenue_contact.contact_name}=\"Lewis Baker\"\
          ,\n        ${targets.avg_prn_target_hourly_rate},\n        ${targets.avg_ceo_target_hourly_rate}\n\
          \      )\n    )\n  )\n)"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: '"£"#,##0'
        is_numeric: true
      - label: "% Target Hours Billed"
        name: target_hours_billed
        expression: "${recognized_project_revenue.total_hours_billed}/${target_billable_hours}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: "% Target Hourly Rate"
        name: target_hourly_rate
        expression: "${avg_hourly_rate}/${target_billable_rate}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0%"
        is_numeric: true
      - label: Target Billable Revenue
        name: target_billable_revenue
        expression: "if(\n  ${recognized_revenue_contact.contact_name}=\"Lydia Blackley\"\
          \n  OR (${recognized_revenue_contact.contact_name}=\"Jordan Ilyat\" AND\
          \ extract_months(${recognized_project_revenue.billing_month_month})=1),\n\
          \  ${targets.total_ae_revenue_target},\n  if(\n    ${recognized_revenue_contact.contact_name}=\"\
          Jordan Ilyat\" \n    AND extract_months(${recognized_project_revenue.billing_month_month})=2,\n\
          \    ${targets.total_sae_revenue_target},\n    if(\n      ${recognized_revenue_contact.contact_name}=\"\
          Bailey Sharpledger\",\n      ${targets.total_sae_revenue_target},\n    \
          \  if(\n        ${recognized_revenue_contact.contact_name}=\"Lewis Baker\"\
          ,\n        ${targets.total_prn_revenue_target},\n        ${targets.total_ceo_revenue_target}\n\
          \      )\n    )\n  )\n)"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: '"£"#,##0'
        is_numeric: true
      - label: "% Target Recognized Revenue"
        name: target_recognized_revenue
        expression: "${recognized_project_revenue.total_recognized_revenue_gbp}/${target_billable_revenue}"
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
    dynamic_fields:
    - category: table_calculation
      expression: "if(\n  ${recognized_revenue_contact.contact_name}=\"Lydia Blackley\"\
        \n  OR (${recognized_revenue_contact.contact_name}=\"Jordan Ilyat\" AND extract_months(${recognized_project_revenue.billing_month_month})=1),\n\
        \  ${targets.total_ae_target_hours},\n  if(\n    ${recognized_revenue_contact.contact_name}=\"\
        Jordan Ilyat\" \n    AND extract_months(${recognized_project_revenue.billing_month_month})=2,\n\
        \    ${targets.total_sae_target_hours},\n    if(\n      ${recognized_revenue_contact.contact_name}=\"\
        Bailey Sharpledger\",\n      ${targets.total_sae_target_hours},\n      if(\n\
        \        ${recognized_revenue_contact.contact_name}=\"Lewis Baker\",\n   \
        \     ${targets.total_prn_target_hours},\n        ${targets.total_ceo_target_hours}\n\
        \      )\n    )\n  )\n)"
      label: Target Billable Hours
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: target_billable_hours
      _type_hint: number
    - category: table_calculation
      expression: "if(\n  ${recognized_revenue_contact.contact_name}=\"Lydia Blackley\"\
        \n  OR (${recognized_revenue_contact.contact_name}=\"Jordan Ilyat\" AND extract_months(${recognized_project_revenue.billing_month_month})=1),\n\
        \  ${targets.avg_ae_target_hourly_rate},\n  if(\n    ${recognized_revenue_contact.contact_name}=\"\
        Jordan Ilyat\" \n    AND extract_months(${recognized_project_revenue.billing_month_month})=2,\n\
        \    ${targets.avg_sae_target_hourly_rate},\n    if(\n      ${recognized_revenue_contact.contact_name}=\"\
        Bailey Sharpledger\",\n      ${targets.avg_sae_target_hourly_rate},\n    \
        \  if(\n        ${recognized_revenue_contact.contact_name}=\"Lewis Baker\"\
        ,\n        ${targets.avg_prn_target_hourly_rate},\n        ${targets.avg_ceo_target_hourly_rate}\n\
        \      )\n    )\n  )\n)"
      label: Target Billable Rate
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: target_billable_rate
      _type_hint: number
    - category: table_calculation
      expression: "${recognized_project_revenue.total_hours_billed}/${target_billable_hours}"
      label: "% Target Hours Billed"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: target_hours_billed
      _type_hint: number
    - category: table_calculation
      expression: "${avg_hourly_rate}/${target_billable_rate}"
      label: "% Target Hourly Rate"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: target_hourly_rate
      _type_hint: number
    - category: table_calculation
      expression: "if(\n  ${recognized_revenue_contact.contact_name}=\"Lydia Blackley\"\
        \n  OR (${recognized_revenue_contact.contact_name}=\"Jordan Ilyat\" AND extract_months(${recognized_project_revenue.billing_month_month})=1),\n\
        \  ${targets.total_ae_revenue_target},\n  if(\n    ${recognized_revenue_contact.contact_name}=\"\
        Jordan Ilyat\" \n    AND extract_months(${recognized_project_revenue.billing_month_month})=2,\n\
        \    ${targets.total_sae_revenue_target},\n    if(\n      ${recognized_revenue_contact.contact_name}=\"\
        Bailey Sharpledger\",\n      ${targets.total_sae_revenue_target},\n      if(\n\
        \        ${recognized_revenue_contact.contact_name}=\"Lewis Baker\",\n   \
        \     ${targets.total_prn_revenue_target},\n        ${targets.total_ceo_revenue_target}\n\
        \      )\n    )\n  )\n)"
      label: Target Billable Revenue
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: target_billable_revenue
      _type_hint: number
    - category: table_calculation
      expression: "${recognized_project_revenue.total_recognized_revenue_gbp}/${target_billable_revenue}"
      label: "% Target Recognized Revenue"
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: target_recognized_revenue
      _type_hint: number
    row: 110
    col: 0
    width: 12
    height: 7
  - title: Current Engagements Hourly Rates
    name: Current Engagements Hourly Rates
    model: analytics
    explore: companies_dim
    type: looker_grid
    fields: [engagements.deal_name, engagements.avg_engagement_hourly_rate, engagements.total_engagement_deal_amount]
    filters:
      engagements.engagement_end_ts_date: after 0 months ago
      timesheet_project_engagement_timesheets.total_timesheet_billable_hours_billed: ">0"
    sorts: [engagements.avg_engagement_hourly_rate desc]
    limit: 500
    column_limit: 50
    total: true
    dynamic_fields:
    - category: table_calculation
      expression: "${engagements.total_engagement_deal_amount}/${engagements.avg_engagement_hourly_rate}"
      label: Total Hours
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: total_hours
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
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    bin_type: bins
    bin_style: binned_hist
    winsorization: false
    color_col: "#1A73E8"
    color_on_hover: "#338bff"
    x_axis_override: ''
    x_grids: true
    x_axis_title_font_size: 16
    x_axis_label_font_size: 12
    x_axis_label_angle: 0
    x_label_separation: 100
    y_axis_override: ''
    y_grids: true
    y_axis_title_font_size: 16
    y_axis_label_font_size: 12
    y_axis_label_angle: 0
    y_label_separation: 100
    x_axis_value_format: ''
    max_bins: '10'
    x: engagements_avg_engagement_hourly_rate
    "y": total_hours
    heatmap_opacity: 0.5
    point_opacity: 0.5
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
    hidden_fields: []
    hidden_points_if_no: []
    hidden_pivots: {}
    series_labels: {}
    show_null_points: true
    minimum_column_width: 75
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", engagements.deal_name, engagements.total_engagement_deal_amount,
      total_hours, engagements.avg_engagement_hourly_rate]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    series_cell_visualizations:
      engagements.avg_engagement_hourly_rate:
        is_active: false
    conditional_formatting: [{type: less than, value: 130, background_color: "#D13452",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1}, bold: false, italic: false,
        strikethrough: false, fields: [engagements.avg_engagement_hourly_rate]}, {
        type: between, value: [129, 160], background_color: "#E48522", font_color: !!null '',
        color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c, palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1},
        bold: false, italic: false, strikethrough: false, fields: [engagements.avg_engagement_hourly_rate]},
      {type: between, value: [159, 220], background_color: "#C4DF58", font_color: !!null '',
        color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c, palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1},
        bold: false, italic: false, strikethrough: false, fields: [engagements.avg_engagement_hourly_rate]},
      {type: greater than, value: 219, background_color: "#7bc739", font_color: !!null '',
        color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c, palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1},
        bold: false, italic: false, strikethrough: false, fields: [engagements.avg_engagement_hourly_rate]}]
    series_value_format:
      engagements.avg_engagement_hourly_rate:
        name: gbp_0
        decimals: '0'
        format_string: '"£"#,##0'
        label: British Pounds (0)
        label_prefix: British Pounds
      engagements.total_engagement_deal_amount:
        name: gbp_0
        decimals: '0'
        format_string: '"£"#,##0'
        label: British Pounds (0)
        label_prefix: British Pounds
    listen: {}
    row: 19
    col: 0
    width: 12
    height: 6
  - title: Current Pipeline Hourly Rates
    name: Current Pipeline Hourly Rates
    model: analytics
    explore: companies_dim
    type: looker_grid
    fields: [deals_fact.deal_name, deals_fact.total_deal_amount_gbp_converted, deals_fact.total_forecasted_hours]
    filters:
      deals_fact.pipeline_stage_label: Project Scoping,SoW Drafted,Partner Funding
        Signoff (*),Partner Funding Agreed (*)
    sorts: [avg_forecast_hourly_rate desc]
    limit: 500
    column_limit: 50
    total: true
    dynamic_fields:
    - category: table_calculation
      expression: "${deals_fact.total_deal_amount_gbp_converted}/${deals_fact.total_forecasted_hours}"
      label: Avg Forecast Hourly Rate
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: avg_forecast_hourly_rate
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
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", engagements.deal_name, engagements.total_engagement_deal_amount,
      total_hours, engagements.avg_engagement_hourly_rate]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels: {}
    series_cell_visualizations:
      engagements.avg_engagement_hourly_rate:
        is_active: false
    conditional_formatting: [{type: less than, value: 130, background_color: "#D13452",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1}, bold: false, italic: false,
        strikethrough: false, fields: [avg_forecast_hourly_rate]}, {type: between,
        value: [129, 160], background_color: "#E48522", font_color: !!null '', color_application: {
          collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c, palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1},
        bold: false, italic: false, strikethrough: false, fields: [avg_forecast_hourly_rate]},
      {type: between, value: [159, 220], background_color: "#C4DF58", font_color: !!null '',
        color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c, palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1},
        bold: false, italic: false, strikethrough: false, fields: [avg_forecast_hourly_rate]},
      {type: greater than, value: 219, background_color: "#7bc739", font_color: !!null '',
        color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c, palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1},
        bold: false, italic: false, strikethrough: false, fields: [avg_forecast_hourly_rate]}]
    bin_type: bins
    bin_style: binned_hist
    winsorization: false
    color_col: "#1A73E8"
    color_on_hover: "#338bff"
    x_axis_override: ''
    x_grids: true
    x_axis_title_font_size: 16
    x_axis_label_font_size: 12
    x_axis_label_angle: 0
    x_label_separation: 100
    y_axis_override: ''
    y_grids: true
    y_axis_title_font_size: 16
    y_axis_label_font_size: 12
    y_axis_label_angle: 0
    y_label_separation: 100
    x_axis_value_format: ''
    max_bins: '10'
    x: engagements_avg_engagement_hourly_rate
    "y": total_hours
    heatmap_opacity: 0.5
    point_opacity: 0.5
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
    hidden_fields: []
    hidden_points_if_no: []
    hidden_pivots: {}
    show_null_points: true
    listen: {}
    row: 19
    col: 12
    width: 12
    height: 6
  - title: Average Hourly Rate
    name: Average Hourly Rate
    model: analytics
    explore: companies_dim
    type: looker_line
    fields: [recognized_project_revenue.total_recognized_revenue_gbp, recognized_project_revenue.total_hours_billed,
      recognized_project_revenue.billing_month_month]
    fill_fields: [recognized_project_revenue.billing_month_month]
    filters:
      recognized_project_revenue.billing_month_month: 12 months
    sorts: [recognized_project_revenue.billing_month_month desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${recognized_project_revenue.total_recognized_revenue_gbp}/${recognized_project_revenue.total_hours_billed}"
      label: Avg Hourly Rate
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: avg_hourly_rate
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
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: recognized_project_revenue.total_hours_billed,
            id: recognized_project_revenue.total_hours_billed, name: Total Hours Billed},
          {axisId: avg_hourly_rate, id: avg_hourly_rate, name: Avg Hourly Rate}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: !!null '', orientation: right,
        series: [{axisId: recognized_project_revenue.total_recognized_revenue_gbp,
            id: recognized_project_revenue.total_recognized_revenue_gbp, name: Total
              Recognized Revenue Gbp}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    defaults_version: 1
    hidden_fields: [recognized_project_revenue.total_recognized_revenue_gbp, recognized_project_revenue.total_hours_billed]
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    row: 32
    col: 0
    width: 12
    height: 8
  - title: What are the hourly rates for our booked + forecasted (deals with a start
      date) pipeline work?
    name: What are the hourly rates for our booked + forecasted (deals with a start
      date) pipeline work?
    model: analytics
    explore: monthly_resource_revenue_forecast_fact
    type: looker_grid
    fields: [monthly_resource_revenue_forecast_fact.forecast_month, monthly_resource_revenue_forecast_fact.total_forecast_revenue_gbp,
      monthly_resource_revenue_forecast_fact.avg_forecast_hourly_rate, monthly_resource_revenue_forecast_fact.engagement_name]
    pivots: [monthly_resource_revenue_forecast_fact.forecast_month]
    fill_fields: [monthly_resource_revenue_forecast_fact.forecast_month]
    filters:
      monthly_resource_revenue_forecast_fact.forecast_month: after 1 months from now
      monthly_resource_revenue_forecast_fact.spend_agreed_with_buyer: 'Yes'
      monthly_resource_revenue_forecast_fact.buyer_confirmed_budget_available: 'Yes'
    sorts: [monthly_resource_revenue_forecast_fact.engagement_name, monthly_resource_revenue_forecast_fact.forecast_month]
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
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      monthly_resource_revenue_forecast_fact.avg_forecast_hourly_rate:
        is_active: false
    conditional_formatting: [{type: less than, value: 130, background_color: "#D13452",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1}, bold: false, italic: false,
        strikethrough: false, fields: [monthly_resource_revenue_forecast_fact.avg_forecast_hourly_rate]},
      {type: between, value: [129, 150], background_color: "#E48522", font_color: !!null '',
        color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c, palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1},
        bold: false, italic: false, strikethrough: false, fields: [monthly_resource_revenue_forecast_fact.avg_forecast_hourly_rate]},
      {type: between, value: [149, 210], background_color: "#C4DF58", font_color: !!null '',
        color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c, palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1},
        bold: false, italic: false, strikethrough: false, fields: [monthly_resource_revenue_forecast_fact.avg_forecast_hourly_rate]},
      {type: greater than, value: 210, background_color: "#7bc739", font_color: !!null '',
        color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c, palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1},
        bold: false, italic: false, strikethrough: false, fields: [monthly_resource_revenue_forecast_fact.avg_forecast_hourly_rate]}]
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
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: [monthly_resource_revenue_forecast_fact.total_forecast_monthly_hours,
      monthly_resource_revenue_forecast_fact.total_forecast_sac_fte, Booked - monthly_resource_revenue_forecast_fact.total_forecast_monthly_hours,
      Pipeline - monthly_resource_revenue_forecast_fact.total_forecast_monthly_hours,
      Pipeline - monthly_resource_revenue_forecast_fact.total_forecast_sac_fte, Booked
        - monthly_resource_revenue_forecast_fact.total_forecast_sac_fte]
    label_value_format: '"£"0,"K"'
    series_colors:
      Booked - monthly_resource_revenue_forecast_fact.total_forecast_sac_fte: "#4A80BC"
      Pipeline - monthly_resource_revenue_forecast_fact.total_forecast_sac_fte: "#E1E1E8"
      Pipeline - monthly_resource_revenue_forecast_fact.total_forecast_revenue_gbp: "#E1E1E8"
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields: [monthly_resource_revenue_forecast_fact.total_forecast_revenue_gbp]
    note_state: collapsed
    note_display: hover
    note_text: Forecast revenue is calculated from sales deals in the pipeline that
      have an identified budget holder and a level of spend verbally-agreed with our
      main sponsor
    listen: {}
    row: 25
    col: 12
    width: 12
    height: 7
  - name: Cost Ratios as % of Recognised Revenue
    title: Cost Ratios as % of Recognised Revenue
    merged_queries:
    - model: analytics
      explore: chart_of_accounts_dim
      type: looker_line
      fields: [cost_of_delivery, dividends, overheads, revenue, taxation, profit_and_loss_report_fact.period_month]
      fill_fields: [profit_and_loss_report_fact.period_month]
      filters:
        profit_and_loss_report_fact.period_month: 12 months
        profit_and_loss_report_fact.account_report_category: "-NULL"
      sorts: [profit_and_loss_report_fact.period_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: abs(${cost_of_delivery})/${revenue}
        label: Delivery as % of Revenue
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: delivery_as_of_revenue
        _type_hint: number
        is_disabled: true
      - category: table_calculation
        expression: abs(${overheads})/${revenue}
        label: Overheads as % of Revenue
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: overheads_as_of_revenue
        _type_hint: number
        is_disabled: true
      - category: table_calculation
        expression: "(${revenue}+${taxation}+${cost_of_delivery}+${overheads}+${dividends})/${revenue}"
        label: Retained Earnings as % of Revenue
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: retained_earnings_as_of_revenue
        _type_hint: number
        is_disabled: true
      - category: measure
        label: Cost of Delivery
        based_on: profit_and_loss_report_fact.amount
        _kind_hint: measure
        measure: cost_of_delivery
        type: count_distinct
        _type_hint: number
        filters:
          profit_and_loss_report_fact.account_report_category: Cost of Delivery
      - category: measure
        label: Dividends
        based_on: profit_and_loss_report_fact.amount
        _kind_hint: measure
        measure: dividends
        type: count_distinct
        _type_hint: number
        filters:
          profit_and_loss_report_fact.account_report_category: Dividends
      - category: measure
        label: Overheads
        based_on: profit_and_loss_report_fact.amount
        _kind_hint: measure
        measure: overheads
        type: count_distinct
        _type_hint: number
        filters:
          profit_and_loss_report_fact.account_report_category: Overheads
      - category: measure
        label: Revenue
        based_on: profit_and_loss_report_fact.amount
        _kind_hint: measure
        measure: revenue
        type: count_distinct
        _type_hint: number
        filters:
          profit_and_loss_report_fact.account_report_category: Revenue
      - category: measure
        label: Taxation
        based_on: profit_and_loss_report_fact.amount
        _kind_hint: measure
        measure: taxation
        type: count_distinct
        _type_hint: number
        filters:
          profit_and_loss_report_fact.account_report_category: Taxation
      - category: table_calculation
        expression: "${revenue}+${cost_of_delivery}+${overheads}+${dividends}+${taxation}"
        label: Actual Retained Earnings
        value_format:
        value_format_name: gbp_0
        _kind_hint: measure
        table_calculation: actual_retained_earnings
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
      show_null_points: true
      interpolation: linear
      color_application:
        collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
        palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
        options:
          steps: 5
      x_axis_zoom: true
      y_axis_zoom: true
      series_colors:
        ebitda_as_of_revenue: "#D13452"
        overheads_as_of_revenue: "#7bc739"
      reference_lines: []
      hidden_pivots: {}
      hidden_fields: []
      defaults_version: 1
    - model: analytics
      explore: revenue_and_forecast
      type: table
      fields: [revenue_and_forecast.period_month, sum_of_booked_and_forecast_revenue,
        sum_of_overheads, sum_of_forecast_net_profit, sum_of_delivery_costs, sum_of_dividends,
        sum_of_forecast_taxation]
      fill_fields: [revenue_and_forecast.period_month]
      filters:
        revenue_and_forecast.period_month: 1 months
      sorts: [revenue_and_forecast.period_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - measure: sum_of_booked_and_forecast_revenue
        based_on: revenue_and_forecast.booked_and_forecast_revenue
        expression: ''
        label: Sum of Booked and Forecast Revenue
        type: sum
        _kind_hint: measure
        _type_hint: number
      - measure: sum_of_overheads
        based_on: revenue_and_forecast.overheads
        expression: ''
        label: Sum of Overheads
        type: sum
        _kind_hint: measure
        _type_hint: number
      - measure: sum_of_forecast_net_profit
        based_on: revenue_and_forecast.forecast_net_profit
        expression: ''
        label: Sum of Forecast Net Profit
        type: sum
        _kind_hint: measure
        _type_hint: number
      - measure: sum_of_delivery_costs
        based_on: revenue_and_forecast.delivery_costs
        expression: ''
        label: Sum of Delivery Costs
        type: sum
        _kind_hint: measure
        _type_hint: number
      - measure: sum_of_dividends
        based_on: revenue_and_forecast.dividends
        expression: ''
        label: Sum of Dividends
        type: sum
        _kind_hint: measure
        _type_hint: number
      - measure: sum_of_forecast_taxation
        based_on: revenue_and_forecast.forecast_taxation
        expression: ''
        label: Sum of Forecast Taxation
        type: sum
        _kind_hint: measure
        _type_hint: number
      join_fields:
      - field_name: revenue_and_forecast.period_month
        source_field_name: profit_and_loss_report_fact.period_month
    - model: analytics
      explore: targets
      type: table
      fields: [targets.total_retained_earnings_target, targets.period_month]
      fill_fields: [targets.period_month]
      limit: 500
      join_fields:
      - field_name: targets.period_month
        source_field_name: profit_and_loss_report_fact.period_month
    - model: analytics
      explore: companies_dim
      type: table
      fields: [recognized_project_revenue.billing_month_month, recognized_project_revenue.total_recognized_revenue_gbp]
      fill_fields: [recognized_project_revenue.billing_month_month]
      sorts: [recognized_project_revenue.billing_month_month desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: recognized_project_revenue.billing_month_month
        source_field_name: profit_and_loss_report_fact.period_month
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: overheads_2, id: overheads_2,
            name: Overheads %}, {axisId: cost_of_delivery_2, id: cost_of_delivery_2,
            name: Cost of Delivery %}, {axisId: retained_income_1, id: retained_income_1,
            name: Retained Income %}, {axisId: taxation_2, id: taxation_2, name: Taxation
              %}], showLabels: true, showValues: true, maxValue: !!null '', minValue: -1,
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
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '12'
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      retained_income_as_of_revenue: "#D13452"
      overheads_as_of_revenue: "#7bc739"
      targets.total_retained_earnings_target: "#D13452"
      retained_income: "#4A80BC"
      retained_income_1: "#D13452"
      overheads_2: "#7bc739"
      cost_of_delivery_2: "#4A80BC"
      taxation_mtd: "#CD9D6B"
      taxation_2: "#E48522"
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    reference_lines: []
    show_null_points: true
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_pivots: {}
    hidden_fields: [cost_of_delivery, dividends, overheads, revenue, taxation, sum_of_overheads,
      sum_of_forecast_net_profit, sum_of_delivery_costs, cost_of_delivery_1, revenue_1,
      overheads_1, dividends_1, taxation_1, sum_of_dividends, sum_of_booked_and_forecast_revenue,
      actual_retained_earnings, sum_of_forecast_taxation, targets.total_retained_earnings_target,
      retained_income, recognized_project_revenue.total_recognized_revenue_gbp, overheads_as_of_revenue,
      retained_income_as_of_revenue, cost_of_delivery_mtd, overheads_mtd, cost_of_delivery_as_of_revenue,
      of_month_elapsed]
    type: looker_line
    sorts: [profit_and_loss_report_fact.period_month]
    dynamic_fields:
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_delivery_costs}*-1,${cost_of_delivery})
      label: Cost of Delivery
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: cost_of_delivery_1
      _type_hint: number
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_booked_and_forecast_revenue},${revenue})
      label: Revenue
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: revenue_1
      _type_hint: number
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_overheads}*-1,${overheads})
      label: Overheads
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: overheads_1
      _type_hint: number
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_dividends}*-1,${dividends})
      label: Dividends
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: dividends_1
      _type_hint: number
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_forecast_taxation}*-1,${taxation})
      label: Taxation
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: taxation_1
      _type_hint: number
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_forecast_net_profit},${actual_retained_earnings})
      label: Retained Income
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: retained_income
      _type_hint: number
    - category: table_calculation
      expression: abs(${cost_of_delivery_1}/${revenue_1})
      label: Cost of Delivery as % of Revenue
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: cost_of_delivery_as_of_revenue
      _type_hint: number
    - category: table_calculation
      expression: abs((${overheads_1}+${dividends_1})/${revenue_1})
      label: Overheads as % of Revenue
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: overheads_as_of_revenue
      _type_hint: number
    - category: table_calculation
      expression: "${retained_income}/${revenue_1}"
      label: Retained Income as % of Revenue
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: retained_income_as_of_revenue
      _type_hint: number
    - category: table_calculation
      expression: "${cost_of_delivery_1}*${of_month_elapsed}"
      label: Cost of Delivery MTD
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: cost_of_delivery_mtd
      _type_hint: number
    - category: table_calculation
      expression: "${overheads_1}*${of_month_elapsed}"
      label: Overheads MTD
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: overheads_mtd
      _type_hint: number
    - category: table_calculation
      expression: "(${overheads_mtd}/${recognized_project_revenue.total_recognized_revenue_gbp})*-1"
      label: Overheads %
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: overheads_2
      _type_hint: number
    - category: table_calculation
      expression: "(${cost_of_delivery_mtd}/${recognized_project_revenue.total_recognized_revenue_gbp})*-1"
      label: Cost of Delivery %
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: cost_of_delivery_2
      _type_hint: number
    - category: table_calculation
      expression: "(${retained_income}*${of_month_elapsed})/${recognized_project_revenue.total_recognized_revenue_gbp}"
      label: Retained Income %
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: retained_income_1
      _type_hint: number
    - category: table_calculation
      expression: extract_days(now())/extract_days(add_days(-1,add_months(1,trunc_months(now()))))
      label: "% of Month Elapsed"
      value_format:
      value_format_name: percent_0
      _kind_hint: dimension
      table_calculation: of_month_elapsed
      _type_hint: number
    - category: table_calculation
      expression: "((${taxation_1}*${of_month_elapsed})/${recognized_project_revenue.total_recognized_revenue_gbp})*-1"
      label: Taxation %
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: taxation_2
      _type_hint: number
    row: 32
    col: 12
    width: 12
    height: 8
  - name: New Tile
    title: New Tile
    note_state: collapsed
    note_display: hover
    note_text: Calculated as MTD overheads vs. MTD recognized revenue
    merged_queries:
    - model: analytics
      explore: chart_of_accounts_dim
      type: looker_line
      fields: [cost_of_delivery, dividends, overheads, revenue, taxation, profit_and_loss_report_fact.period_month]
      fill_fields: [profit_and_loss_report_fact.period_month]
      filters:
        profit_and_loss_report_fact.period_month: 12 months
        profit_and_loss_report_fact.account_report_category: "-NULL"
      sorts: [profit_and_loss_report_fact.period_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: abs(${cost_of_delivery})/${revenue}
        label: Delivery as % of Revenue
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: delivery_as_of_revenue
        _type_hint: number
        is_disabled: true
      - category: table_calculation
        expression: abs(${overheads})/${revenue}
        label: Overheads as % of Revenue
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: overheads_as_of_revenue
        _type_hint: number
        is_disabled: true
      - category: table_calculation
        expression: "(${revenue}+${taxation}+${cost_of_delivery}+${overheads}+${dividends})/${revenue}"
        label: Retained Earnings as % of Revenue
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: retained_earnings_as_of_revenue
        _type_hint: number
        is_disabled: true
      - category: measure
        label: Cost of Delivery
        based_on: profit_and_loss_report_fact.amount
        _kind_hint: measure
        measure: cost_of_delivery
        type: count_distinct
        _type_hint: number
        filters:
          profit_and_loss_report_fact.account_report_category: Cost of Delivery
      - category: measure
        label: Dividends
        based_on: profit_and_loss_report_fact.amount
        _kind_hint: measure
        measure: dividends
        type: count_distinct
        _type_hint: number
        filters:
          profit_and_loss_report_fact.account_report_category: Dividends
      - category: measure
        label: Overheads
        based_on: profit_and_loss_report_fact.amount
        _kind_hint: measure
        measure: overheads
        type: count_distinct
        _type_hint: number
        filters:
          profit_and_loss_report_fact.account_report_category: Overheads
      - category: measure
        label: Revenue
        based_on: profit_and_loss_report_fact.amount
        _kind_hint: measure
        measure: revenue
        type: count_distinct
        _type_hint: number
        filters:
          profit_and_loss_report_fact.account_report_category: Revenue
      - category: measure
        label: Taxation
        based_on: profit_and_loss_report_fact.amount
        _kind_hint: measure
        measure: taxation
        type: count_distinct
        _type_hint: number
        filters:
          profit_and_loss_report_fact.account_report_category: Taxation
      - category: table_calculation
        expression: "${revenue}+${cost_of_delivery}+${overheads}+${dividends}+${taxation}"
        label: Actual Retained Earnings
        value_format:
        value_format_name: gbp_0
        _kind_hint: measure
        table_calculation: actual_retained_earnings
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
      show_null_points: true
      interpolation: linear
      color_application:
        collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
        palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
        options:
          steps: 5
      x_axis_zoom: true
      y_axis_zoom: true
      series_colors:
        ebitda_as_of_revenue: "#D13452"
        overheads_as_of_revenue: "#7bc739"
      reference_lines: []
      hidden_pivots: {}
      hidden_fields: []
      defaults_version: 1
    - model: analytics
      explore: revenue_and_forecast
      type: table
      fields: [revenue_and_forecast.period_month, sum_of_booked_and_forecast_revenue,
        sum_of_overheads, sum_of_forecast_net_profit, sum_of_delivery_costs, sum_of_dividends,
        sum_of_forecast_taxation]
      fill_fields: [revenue_and_forecast.period_month]
      filters:
        revenue_and_forecast.period_month: 1 months
      sorts: [revenue_and_forecast.period_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - measure: sum_of_booked_and_forecast_revenue
        based_on: revenue_and_forecast.booked_and_forecast_revenue
        expression: ''
        label: Sum of Booked and Forecast Revenue
        type: sum
        _kind_hint: measure
        _type_hint: number
      - measure: sum_of_overheads
        based_on: revenue_and_forecast.overheads
        expression: ''
        label: Sum of Overheads
        type: sum
        _kind_hint: measure
        _type_hint: number
      - measure: sum_of_forecast_net_profit
        based_on: revenue_and_forecast.forecast_net_profit
        expression: ''
        label: Sum of Forecast Net Profit
        type: sum
        _kind_hint: measure
        _type_hint: number
      - measure: sum_of_delivery_costs
        based_on: revenue_and_forecast.delivery_costs
        expression: ''
        label: Sum of Delivery Costs
        type: sum
        _kind_hint: measure
        _type_hint: number
      - measure: sum_of_dividends
        based_on: revenue_and_forecast.dividends
        expression: ''
        label: Sum of Dividends
        type: sum
        _kind_hint: measure
        _type_hint: number
      - measure: sum_of_forecast_taxation
        based_on: revenue_and_forecast.forecast_taxation
        expression: ''
        label: Sum of Forecast Taxation
        type: sum
        _kind_hint: measure
        _type_hint: number
      join_fields:
      - field_name: revenue_and_forecast.period_month
        source_field_name: profit_and_loss_report_fact.period_month
    - model: analytics
      explore: targets
      type: table
      fields: [targets.total_retained_earnings_target, targets.period_month]
      fill_fields: [targets.period_month]
      limit: 500
      join_fields:
      - field_name: targets.period_month
        source_field_name: profit_and_loss_report_fact.period_month
    - model: analytics
      explore: companies_dim
      type: table
      fields: [recognized_project_revenue.billing_month_month, recognized_project_revenue.total_recognized_revenue_gbp]
      fill_fields: [recognized_project_revenue.billing_month_month]
      sorts: [recognized_project_revenue.billing_month_month desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: recognized_project_revenue.billing_month_month
        source_field_name: profit_and_loss_report_fact.period_month
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Overheads %
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting: [{type: between, value: [0.3, 0.4], background_color: "#E48522",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: less than, value: 0.3, background_color: "#7bc739",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: greater than, value: 0.4,
        background_color: "#D13452", font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: between, value: [0.3, 0.4],
        background_color: "#E48522", font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: less than, value: 0.2, background_color: "#7bc739",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: greater than, value: 0.4,
        background_color: "#D13452", font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: equal to, value: !!null '',
        background_color: !!null '', font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: overheads_2, id: overheads_2,
            name: Overheads %}, {axisId: cost_of_delivery_2, id: cost_of_delivery_2,
            name: Cost of Delivery %}, {axisId: retained_income_1, id: retained_income_1,
            name: Retained Income %}, {axisId: taxation_2, id: taxation_2, name: Taxation
              %}], showLabels: true, showValues: true, maxValue: !!null '', minValue: -1,
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
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '12'
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      retained_income_as_of_revenue: "#D13452"
      overheads_as_of_revenue: "#7bc739"
      targets.total_retained_earnings_target: "#D13452"
      retained_income: "#4A80BC"
      retained_income_1: "#D13452"
      overheads_2: "#7bc739"
      cost_of_delivery_2: "#4A80BC"
      taxation_mtd: "#CD9D6B"
      taxation_2: "#E48522"
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    reference_lines: []
    show_null_points: true
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_pivots: {}
    hidden_fields: [cost_of_delivery, dividends, overheads, revenue, taxation, sum_of_overheads,
      sum_of_forecast_net_profit, sum_of_delivery_costs, cost_of_delivery_1, revenue_1,
      overheads_1, dividends_1, taxation_1, sum_of_dividends, sum_of_booked_and_forecast_revenue,
      actual_retained_earnings, sum_of_forecast_taxation, targets.total_retained_earnings_target,
      retained_income, recognized_project_revenue.total_recognized_revenue_gbp, overheads_as_of_revenue,
      retained_income_as_of_revenue, cost_of_delivery_mtd, overheads_mtd, cost_of_delivery_as_of_revenue,
      of_month_elapsed, cost_of_delivery_2, retained_income_1, taxation_2, profit_and_loss_report_fact.period_month]
    type: single_value
    sorts: [profit_and_loss_report_fact.period_month desc]
    dynamic_fields:
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_delivery_costs}*-1,${cost_of_delivery})
      label: Cost of Delivery
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: cost_of_delivery_1
      _type_hint: number
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_booked_and_forecast_revenue},${revenue})
      label: Revenue
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: revenue_1
      _type_hint: number
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_overheads}*-1,${overheads})
      label: Overheads
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: overheads_1
      _type_hint: number
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_dividends}*-1,${dividends})
      label: Dividends
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: dividends_1
      _type_hint: number
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_forecast_taxation}*-1,${taxation})
      label: Taxation
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: taxation_1
      _type_hint: number
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_forecast_net_profit},${actual_retained_earnings})
      label: Retained Income
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: retained_income
      _type_hint: number
    - category: table_calculation
      expression: abs(${cost_of_delivery_1}/${revenue_1})
      label: Cost of Delivery as % of Revenue
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: cost_of_delivery_as_of_revenue
      _type_hint: number
    - category: table_calculation
      expression: abs((${overheads_1}+${dividends_1})/${revenue_1})
      label: Overheads as % of Revenue
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: overheads_as_of_revenue
      _type_hint: number
    - category: table_calculation
      expression: "${retained_income}/${revenue_1}"
      label: Retained Income as % of Revenue
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: retained_income_as_of_revenue
      _type_hint: number
    - category: table_calculation
      expression: "${cost_of_delivery_1}*${of_month_elapsed}"
      label: Cost of Delivery MTD
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: cost_of_delivery_mtd
      _type_hint: number
    - category: table_calculation
      expression: "${overheads_1}*${of_month_elapsed}"
      label: Overheads MTD
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: overheads_mtd
      _type_hint: number
    - category: table_calculation
      expression: "(${overheads_mtd}/${recognized_project_revenue.total_recognized_revenue_gbp})*-1"
      label: Overheads %
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: overheads_2
      _type_hint: number
    - category: table_calculation
      expression: "(${cost_of_delivery_mtd}/${recognized_project_revenue.total_recognized_revenue_gbp})*-1"
      label: Cost of Delivery %
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: cost_of_delivery_2
      _type_hint: number
    - category: table_calculation
      expression: "(${retained_income}*${of_month_elapsed})/${recognized_project_revenue.total_recognized_revenue_gbp}"
      label: Retained Income %
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: retained_income_1
      _type_hint: number
    - category: table_calculation
      expression: extract_days(now())/extract_days(add_days(-1,add_months(1,trunc_months(now()))))
      label: "% of Month Elapsed"
      value_format:
      value_format_name: percent_0
      _kind_hint: dimension
      table_calculation: of_month_elapsed
      _type_hint: number
    - category: table_calculation
      expression: "((${taxation_1}*${of_month_elapsed})/${recognized_project_revenue.total_recognized_revenue_gbp})*-1"
      label: Taxation %
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: taxation_2
      _type_hint: number
    - category: table_calculation
      expression: '0.29'
      label: Target Overheads %
      value_format:
      value_format_name: percent_0
      _kind_hint: dimension
      table_calculation: target_overheads
      _type_hint: number
    row: 2
    col: 15
    width: 3
    height: 5
  - name: Cost of Delivery
    title: Cost of Delivery
    merged_queries:
    - model: analytics
      explore: chart_of_accounts_dim
      type: looker_line
      fields: [cost_of_delivery, dividends, overheads, revenue, taxation, profit_and_loss_report_fact.period_month]
      fill_fields: [profit_and_loss_report_fact.period_month]
      filters:
        profit_and_loss_report_fact.period_month: 12 months
        profit_and_loss_report_fact.account_report_category: "-NULL"
      sorts: [profit_and_loss_report_fact.period_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: abs(${cost_of_delivery})/${revenue}
        label: Delivery as % of Revenue
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: delivery_as_of_revenue
        _type_hint: number
        is_disabled: true
      - category: table_calculation
        expression: abs(${overheads})/${revenue}
        label: Overheads as % of Revenue
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: overheads_as_of_revenue
        _type_hint: number
        is_disabled: true
      - category: table_calculation
        expression: "(${revenue}+${taxation}+${cost_of_delivery}+${overheads}+${dividends})/${revenue}"
        label: Retained Earnings as % of Revenue
        value_format:
        value_format_name: percent_0
        _kind_hint: measure
        table_calculation: retained_earnings_as_of_revenue
        _type_hint: number
        is_disabled: true
      - category: measure
        label: Cost of Delivery
        based_on: profit_and_loss_report_fact.amount
        _kind_hint: measure
        measure: cost_of_delivery
        type: count_distinct
        _type_hint: number
        filters:
          profit_and_loss_report_fact.account_report_category: Cost of Delivery
      - category: measure
        label: Dividends
        based_on: profit_and_loss_report_fact.amount
        _kind_hint: measure
        measure: dividends
        type: count_distinct
        _type_hint: number
        filters:
          profit_and_loss_report_fact.account_report_category: Dividends
      - category: measure
        label: Overheads
        based_on: profit_and_loss_report_fact.amount
        _kind_hint: measure
        measure: overheads
        type: count_distinct
        _type_hint: number
        filters:
          profit_and_loss_report_fact.account_report_category: Overheads
      - category: measure
        label: Revenue
        based_on: profit_and_loss_report_fact.amount
        _kind_hint: measure
        measure: revenue
        type: count_distinct
        _type_hint: number
        filters:
          profit_and_loss_report_fact.account_report_category: Revenue
      - category: measure
        label: Taxation
        based_on: profit_and_loss_report_fact.amount
        _kind_hint: measure
        measure: taxation
        type: count_distinct
        _type_hint: number
        filters:
          profit_and_loss_report_fact.account_report_category: Taxation
      - category: table_calculation
        expression: "${revenue}+${cost_of_delivery}+${overheads}+${dividends}+${taxation}"
        label: Actual Retained Earnings
        value_format:
        value_format_name: gbp_0
        _kind_hint: measure
        table_calculation: actual_retained_earnings
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
      show_null_points: true
      interpolation: linear
      color_application:
        collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
        palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
        options:
          steps: 5
      x_axis_zoom: true
      y_axis_zoom: true
      series_colors:
        ebitda_as_of_revenue: "#D13452"
        overheads_as_of_revenue: "#7bc739"
      reference_lines: []
      hidden_pivots: {}
      hidden_fields: []
      defaults_version: 1
    - model: analytics
      explore: revenue_and_forecast
      type: table
      fields: [revenue_and_forecast.period_month, sum_of_booked_and_forecast_revenue,
        sum_of_overheads, sum_of_forecast_net_profit, sum_of_delivery_costs, sum_of_dividends,
        sum_of_forecast_taxation]
      fill_fields: [revenue_and_forecast.period_month]
      filters:
        revenue_and_forecast.period_month: 1 months
      sorts: [revenue_and_forecast.period_month desc]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - measure: sum_of_booked_and_forecast_revenue
        based_on: revenue_and_forecast.booked_and_forecast_revenue
        expression: ''
        label: Sum of Booked and Forecast Revenue
        type: sum
        _kind_hint: measure
        _type_hint: number
      - measure: sum_of_overheads
        based_on: revenue_and_forecast.overheads
        expression: ''
        label: Sum of Overheads
        type: sum
        _kind_hint: measure
        _type_hint: number
      - measure: sum_of_forecast_net_profit
        based_on: revenue_and_forecast.forecast_net_profit
        expression: ''
        label: Sum of Forecast Net Profit
        type: sum
        _kind_hint: measure
        _type_hint: number
      - measure: sum_of_delivery_costs
        based_on: revenue_and_forecast.delivery_costs
        expression: ''
        label: Sum of Delivery Costs
        type: sum
        _kind_hint: measure
        _type_hint: number
      - measure: sum_of_dividends
        based_on: revenue_and_forecast.dividends
        expression: ''
        label: Sum of Dividends
        type: sum
        _kind_hint: measure
        _type_hint: number
      - measure: sum_of_forecast_taxation
        based_on: revenue_and_forecast.forecast_taxation
        expression: ''
        label: Sum of Forecast Taxation
        type: sum
        _kind_hint: measure
        _type_hint: number
      join_fields:
      - field_name: revenue_and_forecast.period_month
        source_field_name: profit_and_loss_report_fact.period_month
    - model: analytics
      explore: targets
      type: table
      fields: [targets.total_retained_earnings_target, targets.period_month]
      fill_fields: [targets.period_month]
      limit: 500
      join_fields:
      - field_name: targets.period_month
        source_field_name: profit_and_loss_report_fact.period_month
    - model: analytics
      explore: companies_dim
      type: table
      fields: [recognized_project_revenue.billing_month_month, recognized_project_revenue.total_recognized_revenue_gbp]
      fill_fields: [recognized_project_revenue.billing_month_month]
      sorts: [recognized_project_revenue.billing_month_month desc]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: recognized_project_revenue.billing_month_month
        source_field_name: profit_and_loss_report_fact.period_month
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Cost of Delivery %
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting: [{type: between, value: [0.47, 0.55], background_color: "#E48522",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: less than, value: 0.47, background_color: "#7bc739",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: greater than, value: 0.55,
        background_color: "#D13452", font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: 00fb21bc-5a8c-46b1-88bf-2a6a3d102830}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: overheads_2, id: overheads_2,
            name: Overheads %}, {axisId: cost_of_delivery_2, id: cost_of_delivery_2,
            name: Cost of Delivery %}, {axisId: retained_income_1, id: retained_income_1,
            name: Retained Income %}, {axisId: taxation_2, id: taxation_2, name: Taxation
              %}], showLabels: true, showValues: true, maxValue: !!null '', minValue: -1,
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
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '12'
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      retained_income_as_of_revenue: "#D13452"
      overheads_as_of_revenue: "#7bc739"
      targets.total_retained_earnings_target: "#D13452"
      retained_income: "#4A80BC"
      retained_income_1: "#D13452"
      overheads_2: "#7bc739"
      cost_of_delivery_2: "#4A80BC"
      taxation_mtd: "#CD9D6B"
      taxation_2: "#E48522"
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    reference_lines: []
    show_null_points: true
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_pivots: {}
    hidden_fields: [cost_of_delivery, dividends, overheads, revenue, taxation, sum_of_overheads,
      sum_of_forecast_net_profit, sum_of_delivery_costs, cost_of_delivery_1, revenue_1,
      overheads_1, dividends_1, taxation_1, sum_of_dividends, sum_of_booked_and_forecast_revenue,
      actual_retained_earnings, sum_of_forecast_taxation, targets.total_retained_earnings_target,
      retained_income, recognized_project_revenue.total_recognized_revenue_gbp, overheads_as_of_revenue,
      retained_income_as_of_revenue, cost_of_delivery_mtd, overheads_mtd, cost_of_delivery_as_of_revenue,
      of_month_elapsed, overheads_2, retained_income_1, taxation_2, profit_and_loss_report_fact.period_month]
    type: single_value
    sorts: [profit_and_loss_report_fact.period_month desc]
    dynamic_fields:
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_delivery_costs}*-1,${cost_of_delivery})
      label: Cost of Delivery
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: cost_of_delivery_1
      _type_hint: number
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_booked_and_forecast_revenue},${revenue})
      label: Revenue
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: revenue_1
      _type_hint: number
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_overheads}*-1,${overheads})
      label: Overheads
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: overheads_1
      _type_hint: number
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_dividends}*-1,${dividends})
      label: Dividends
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: dividends_1
      _type_hint: number
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_forecast_taxation}*-1,${taxation})
      label: Taxation
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: taxation_1
      _type_hint: number
    - category: table_calculation
      expression: if(${profit_and_loss_report_fact.period_month}=trunc_months(now()),${sum_of_forecast_net_profit},${actual_retained_earnings})
      label: Retained Income
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: retained_income
      _type_hint: number
    - category: table_calculation
      expression: abs(${cost_of_delivery_1}/${revenue_1})
      label: Cost of Delivery as % of Revenue
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: cost_of_delivery_as_of_revenue
      _type_hint: number
    - category: table_calculation
      expression: abs((${overheads_1}+${dividends_1})/${revenue_1})
      label: Overheads as % of Revenue
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: overheads_as_of_revenue
      _type_hint: number
    - category: table_calculation
      expression: "${retained_income}/${revenue_1}"
      label: Retained Income as % of Revenue
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: retained_income_as_of_revenue
      _type_hint: number
    - category: table_calculation
      expression: "${cost_of_delivery_1}*${of_month_elapsed}"
      label: Cost of Delivery MTD
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: cost_of_delivery_mtd
      _type_hint: number
    - category: table_calculation
      expression: "${overheads_1}*${of_month_elapsed}"
      label: Overheads MTD
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: overheads_mtd
      _type_hint: number
    - category: table_calculation
      expression: "(${overheads_mtd}/${recognized_project_revenue.total_recognized_revenue_gbp})*-1"
      label: Overheads %
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: overheads_2
      _type_hint: number
    - category: table_calculation
      expression: "(${cost_of_delivery_mtd}/${recognized_project_revenue.total_recognized_revenue_gbp})*-1"
      label: Cost of Delivery %
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: cost_of_delivery_2
      _type_hint: number
    - category: table_calculation
      expression: "(${retained_income}*${of_month_elapsed})/${recognized_project_revenue.total_recognized_revenue_gbp}"
      label: Retained Income %
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: retained_income_1
      _type_hint: number
    - category: table_calculation
      expression: extract_days(now())/extract_days(add_days(-1,add_months(1,trunc_months(now()))))
      label: "% of Month Elapsed"
      value_format:
      value_format_name: percent_0
      _kind_hint: dimension
      table_calculation: of_month_elapsed
      _type_hint: number
    - category: table_calculation
      expression: "((${taxation_1}*${of_month_elapsed})/${recognized_project_revenue.total_recognized_revenue_gbp})*-1"
      label: Taxation %
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: taxation_2
      _type_hint: number
    - category: table_calculation
      expression: '0.47'
      label: Target Cost of Delivery%
      value_format:
      value_format_name: percent_0
      _kind_hint: dimension
      table_calculation: target_cost_of_delivery
      _type_hint: number
    row: 2
    col: 12
    width: 3
    height: 5
  - title: NPS
    name: NPS
    model: analytics
    explore: companies_dim
    type: single_value
    fields: [nps_survey_results_fact.average_nps_score]
    filters:
      nps_survey_results_fact.nps_survey_ts_date: 4 weeks
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '10'
      label: Target
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: target
      _type_hint: number
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    conditional_formatting: [{type: equal to, value: 10, background_color: "#7bc739",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: between, value: [9, 9.9],
        background_color: "#E48522", font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}, {type: less than, value: 9, background_color: "#D13452",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1}, bold: false, italic: false,
        strikethrough: false, fields: [nps_survey_results_fact.average_nps_score]}]
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      nps_survey_results_fact.average_nps_score:
        is_active: false
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    hide_totals: false
    hide_row_totals: false
    hidden_pivots: {}
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
    note_state: collapsed
    note_display: hover
    note_text: Calculated as average over last 4 weeks
    listen: {}
    row: 2
    col: 18
    width: 3
    height: 5
  - title: Consultant Hourly Rates
    name: Consultant Hourly Rates
    model: analytics
    explore: companies_dim
    type: looker_grid
    fields: [recognized_revenue_contact.contact_name, recognized_project_revenue.total_recognized_revenue_gbp,
      recognized_project_revenue.total_hours_billed, recognized_project_revenue.billing_month_month]
    pivots: [recognized_project_revenue.billing_month_month]
    fill_fields: [recognized_project_revenue.billing_month_month]
    filters:
      recognized_project_revenue.billing_month_month: 1 years
      recognized_revenue_contact.contact_name: Lydia Blackley,Lewis Baker,Jordan Ilyat,Bailey
        Sharpledger,Olivier Dupuis,Saverro Suseno,Mark Rittman
    sorts: [recognized_revenue_contact.contact_name, recognized_project_revenue.billing_month_month]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${recognized_project_revenue.total_recognized_revenue_gbp}/${recognized_project_revenue.total_hours_billed}"
      label: Avg Hourly Rate
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      table_calculation: avg_hourly_rate
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
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [recognized_project_revenue.total_recognized_revenue_gbp, recognized_project_revenue.total_hours_billed]
    hidden_pivots: {}
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
    minimum_column_width: 75
    show_sql_query_menu_options: false
    column_order: []
    show_totals: true
    show_row_totals: true
    truncate_header: false
    conditional_formatting: [{type: less than, value: 130, background_color: "#D13452",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1}, bold: false, italic: false,
        strikethrough: false, fields: [avg_hourly_rate]}, {type: between, value: [
          129, 160], background_color: "#E48522", font_color: !!null '', color_application: {
          collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c, palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1},
        bold: false, italic: false, strikethrough: false, fields: [avg_hourly_rate]},
      {type: between, value: [159, 220], background_color: "#C4DF58", font_color: !!null '',
        color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c, palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1},
        bold: false, italic: false, strikethrough: false, fields: [avg_hourly_rate]},
      {type: greater than, value: 220, background_color: "#7bc739", font_color: !!null '',
        color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c, palette_id: d9abd293-3cd0-448c-9540-4a55690e4ce1},
        bold: false, italic: false, strikethrough: false, fields: [avg_hourly_rate]}]
    listen: {}
    row: 25
    col: 0
    width: 12
    height: 7
  - name: What's the "Mood" on our Projects?
    title: What's the "Mood" on our Projects?
    merged_queries:
    - model: analytics
      explore: companies_dim
      type: looker_line
      fields: [customer_meetings.average_contribution_sentiment_score, customer_meetings.avg_meeting_engagement_level,
        engagements.deal_name, customer_meetings.meeting_start_week]
      filters:
        customer_meetings.meeting_start_date: 4 weeks
        engagements.engagement_end_ts_date: after 0 days ago
      sorts: [engagements.deal_name, customer_meetings.meeting_start_week desc]
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
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      defaults_version: 1
      hidden_fields: [customer_meetings.avg_meeting_engagement_level]
      hidden_pivots: {}
      join_fields: []
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: mood, id: mood, name: Mood}],
        showLabels: true, showValues: true, maxValue: 9, minValue: -9, unpinAxis: false,
        tickDensity: custom, tickDensityCustom: 5, type: linear}]
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
    hide_legend: false
    legend_position: center
    series_types: {}
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: right, color: "#b8b8b8",
        line_value: '0', label: OK}, {reference_type: line, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: right,
        color: "#d1d1d1", line_value: "-4", label: Concerned}, {reference_type: line,
        range_start: max, range_end: min, margin_top: deviation, margin_value: mean,
        margin_bottom: deviation, label_position: right, color: "#d1d1d1", line_value: "-9",
        label: Bad}, {reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: right, color: "#d1d1d1",
        line_value: '4', label: Good}, {reference_type: line, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: right,
        color: "#d1d1d1", line_value: '8', label: Great}]
    show_null_points: false
    interpolation: linear
    discontinuous_nulls: false
    hidden_fields: [customer_meetings.average_contribution_sentiment_score, customer_meetings.avg_meeting_engagement_level]
    hidden_pivots: {}
    type: looker_line
    pivots: [engagements.deal_name]
    column_limit: 6
    dynamic_fields:
    - category: table_calculation
      expression: "${customer_meetings.average_contribution_sentiment_score}*${customer_meetings.avg_meeting_engagement_level}"
      label: Mood
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: mood
      _type_hint: number
    row: 90
    col: 18
    width: 6
    height: 9
  - title: Bank Balance This Year
    name: Bank Balance This Year
    model: analytics
    explore: monzo_bank_transactions_enriched
    type: looker_line
    fields: [average_of_balance, min_of_balance, max_of_balance, monzo_bank_transactions_enriched.date_week]
    filters:
      monzo_bank_transactions_enriched.date_month: 1 years
    sorts: [average_of_balance desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: measure
      expression: ''
      label: Average of Balance
      value_format:
      value_format_name: gbp_0
      based_on: monzo_bank_transactions_enriched.balance
      _kind_hint: measure
      measure: average_of_balance
      type: average
      _type_hint: number
    - category: measure
      expression: ''
      label: Min of Balance
      value_format:
      value_format_name: gbp_0
      based_on: monzo_bank_transactions_enriched.balance
      _kind_hint: measure
      measure: min_of_balance
      type: min
      _type_hint: number
    - category: measure
      expression: ''
      label: Max of Balance
      value_format:
      value_format_name: gbp_0
      based_on: monzo_bank_transactions_enriched.balance
      _kind_hint: measure
      measure: max_of_balance
      type: max
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
    show_null_points: false
    interpolation: linear
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      min_of_balance: "#d4d4d4"
      max_of_balance: "#d4d4d4"
      2025 - average_of_balance: "#4A80BC"
      2024 - average_of_balance: "#D13452"
      2023 - average_of_balance: "#F0C733"
    defaults_version: 1
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    hidden_pivots: {}
    listen: {}
    row: 40
    col: 12
    width: 12
    height: 10
  - name: Over-Under Delivery vs Forecast
    title: Over-Under Delivery vs Forecast
    merged_queries:
    - model: analytics
      explore: timesheets_forecast_fact
      type: looker_grid
      fields: [staff_dim.contact_name, timesheet_projects_dim.project_name, timesheets_forecast_fact.total_forecast_days,
        timesheets_forecast_fact.forecast_day_ts_month]
      filters:
        timesheets_forecast_fact.forecast_day_ts_month: 2 month ago for 2 month
      sorts: [timesheets_forecast_fact.forecast_day_ts_month, staff_dim.contact_name
          desc 0]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: round(${timesheets_forecast_fact.total_forecast_days}*8,0)
        label: Total Forecast Hours
        value_format:
        value_format_name:
        _kind_hint: measure
        table_calculation: total_forecast_hours
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
      header_font_size: 12
      rows_font_size: 12
      conditional_formatting_include_totals: false
      conditional_formatting_include_nulls: false
      hidden_fields: [timesheets_forecast_fact.total_forecast_days]
      hidden_pivots: {}
      defaults_version: 1
    - model: analytics
      explore: companies_dim
      type: table
      fields: [project_timesheet_projects.project_name, project_timesheet_users.contact_name,
        project_timesheets.total_timesheet_billable_hours_billed, project_timesheets.total_timesheet_nonbillable_hours_billed,
        project_timesheets.timesheet_billing_month]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: project_timesheet_projects.project_name
        source_field_name: timesheet_projects_dim.project_name
      - field_name: project_timesheet_users.contact_name
        source_field_name: staff_dim.contact_name
      - field_name: project_timesheets.timesheet_billing_month
        source_field_name: timesheets_forecast_fact.forecast_day_ts_month
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
    series_labels:
      staff_dim.contact_name: Consultant
      timesheets_forecast_fact.forecast_day_ts_month: Month
    series_cell_visualizations:
      total_forecast_hours:
        is_active: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4A80BC",
        font_color: !!null '', color_application: {collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c,
          custom: {id: 25be3904-f26f-db80-5257-830bdac82af5, label: Custom, type: continuous,
            stops: [{color: "#D13452", offset: 0}, {color: "#ffffff", offset: 50},
              {color: "#7BC739", offset: 100}]}, options: {steps: 5, constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [overunder_delivered_hours]}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_value_format: {}
    hidden_fields: [timesheets_forecast_fact.total_forecast_days, project_timesheets.total_timesheet_nonbillable_hours_billed]
    type: looker_grid
    series_types: {}
    hidden_pivots: {}
    pivots: [timesheets_forecast_fact.forecast_day_ts_month]
    sorts: [staff_dim.contact_name, timesheet_projects_dim.project_name]
    dynamic_fields:
    - category: table_calculation
      expression: round(${project_timesheets.total_timesheet_billable_hours_billed}-${total_forecast_hours},0)
      label: Over/Under-Delivered Hours
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: overunder_delivered_hours
      _type_hint: number
    row: 117
    col: 0
    width: 12
    height: 20
  - title: How many SAC FTEs are we likely to need (Spend/Budget Confirmed)
    name: How many SAC FTEs are we likely to need (Spend/Budget Confirmed)
    model: analytics
    explore: monthly_resource_revenue_forecast_fact
    type: looker_column
    fields: [monthly_resource_revenue_forecast_fact.forecast_month, monthly_resource_revenue_forecast_fact.total_forecast_sac_fte,
      monthly_resource_revenue_forecast_fact.forecast_type]
    pivots: [monthly_resource_revenue_forecast_fact.forecast_type]
    filters:
      monthly_resource_revenue_forecast_fact.forecast_month: after 0 months ago
      monthly_resource_revenue_forecast_fact.spend_agreed_with_buyer: 'Yes'
      monthly_resource_revenue_forecast_fact.forecast_type: Booked,Pipeline
      monthly_resource_revenue_forecast_fact.buyer_confirmed_budget_available: 'Yes'
      monthly_resource_revenue_forecast_fact.engagement_name: ''
      monthly_resource_revenue_forecast_fact.deal_partner_referral: ''
    sorts: [monthly_resource_revenue_forecast_fact.forecast_type, monthly_resource_revenue_forecast_fact.forecast_month]
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: left
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: [monthly_resource_revenue_forecast_fact.total_forecast_monthly_hours,
      monthly_resource_revenue_forecast_fact.total_forecast_sac_fte, Booked - monthly_resource_revenue_forecast_fact.total_forecast_monthly_hours,
      Booked - monthly_resource_revenue_forecast_fact.total_forecast_revenue_gbp,
      Pipeline - monthly_resource_revenue_forecast_fact.total_forecast_revenue_gbp,
      Pipeline - monthly_resource_revenue_forecast_fact.total_forecast_monthly_hours]
    series_colors:
      Booked - monthly_resource_revenue_forecast_fact.total_forecast_sac_fte: "#4A80BC"
      Pipeline - monthly_resource_revenue_forecast_fact.total_forecast_sac_fte: "#E1E1E8"
    show_null_points: true
    interpolation: linear
    hidden_pivots: {}
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: All deal opportunities regardless of whether spend or budget is agreed
    listen: {}
    row: 9
    col: 12
    width: 12
    height: 10
