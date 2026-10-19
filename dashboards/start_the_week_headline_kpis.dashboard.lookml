- dashboard: start_the_week
  title: Start the Week
  preferred_viewer: dashboards-next
  style: modern
  preferred_slug: CIaskZQfsZD47j7uscho6x
  layout: newspaper
  tabs:
  - name: ''
    label: ''
  elements:
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
          & Delivered,In Delivery,Closed Won
        companies_dim.company_name: ''
        deals_fact.deal_type: ''
        deals_fact.owner_full_name: ''
        deals_fact.partner_referral: ''
        deals_fact.sprint_type: ''
        deals_fact.deal_name: ''
        deals_fact.deal_is_deleted: 'No'
        deals_fact.deal_closed_date: 6 months
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
      collection_id: looker_2026
      palette_id: looker_2026_categorical_1
      options:
        steps: 5
    custom_color_enabled: true
    show_single_value_title: true
    smart_single_value_size: true
    value_format: '"£"0,"K"'
    show_comparison: true
    comparison_type: change_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
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
    show_chart_component: true
    kpi_chart_type: looker_area
    show_x_axis: false
    primary_series: deals_fact.total_closed_won_deal_amount_gbp
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
    row:
    col:
    width:
    height:
    tab_name: ''
  - name: Forecast Retained Earnings
    title: Forecast Retained Earnings
    merged_queries:
    - model: analytics
      explore: chart_of_accounts_dim
      type: single_value
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
      custom_color_enabled: true
      show_single_value_title: true
      show_comparison: false
      comparison_type: value
      comparison_reverse_colors: false
      show_comparison_label: true
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
    smart_single_value_size: true
    value_format: '"£"0,"K"'
    show_comparison: true
    comparison_type: change_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
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
    show_chart_component: true
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
    row:
    col:
    width:
    height:
    tab_name: ''
  - title: Recognised Revenue
    name: Recognised Revenue
    model: analytics
    explore: companies_dim
    type: single_value
    fields: [recognized_project_revenue.billing_month_month, recognized_project_revenue.total_recognized_revenue_gbp,
      team_revenue_targets.revenue_target]
    filters:
      recognized_project_revenue.total_recognized_revenue_gbp: NOT NULL
      recognized_project_revenue.billing_month_month: 12 months
    sorts: [recognized_project_revenue.billing_month_month desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${recognized_project_revenue.total_recognized_revenue_gbp}"
      label: Recognised Revenue
      value_format: '"£"0,"K"'
      value_format_name: __custom
      _kind_hint: measure
      table_calculation: recognised_revenue
      _type_hint: number
    - category: table_calculation
      expression: "${team_revenue_targets.revenue_target}"
      label: Target
      value_format: '"£"0,"K"'
      value_format_name: __custom
      _kind_hint: measure
      table_calculation: target
      _type_hint: number
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Recognised Revenue
    smart_single_value_size: true
    comparison_label: Target
    hidden_fields: [recognized_project_revenue.total_recognized_revenue_gbp, team_revenue_targets.revenue_target]
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
    legend_position: center
    label_value_format: '"£"0,"K"'
    point_style: circle
    series_colors:
      team_revenue_targets.revenue_target: "#D13452"
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    defaults_version: 1
    show_chart_component: true
    row:
    col:
    width:
    height:
    tab_name: ''
  - title: Forecast Billing Revenue
    name: Forecast Billing Revenue
    model: analytics
    explore: revenue_and_forecast
    type: single_value
    fields: [revenue_and_forecast.period_month, sum_of_booked_revenue, sum_of_forecast_revenue,
      sum_of_target_revenue_2]
    fill_fields: [revenue_and_forecast.period_month]
    filters:
      revenue_and_forecast.period_month: 12 months
    sorts: [revenue_and_forecast.period_month desc]
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
    comparison_type: change_percentage
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
    single_value_title: ''
    smart_single_value_size: true
    value_format: '"£"0,"K"'
    comparison_label: Target
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
    show_chart_component: true
    row:
    col:
    width:
    height:
    tab_name: ''
  - title: NPS Score
    name: NPS Score
    model: analytics
    explore: companies_dim
    type: single_value
    fields: [nps_survey_results_fact.average_nps_score, nps_survey_results_fact.nps_survey_ts_month]
    fill_fields: [nps_survey_results_fact.nps_survey_ts_month]
    filters:
      nps_survey_results_fact.nps_survey_ts_date: 12 months
    sorts: [nps_survey_results_fact.nps_survey_ts_month desc]
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
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    smart_single_value_size: true
    value_format: '0.0'
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
    hidden_fields: [nps_survey_results_fact.nps_survey_ts_month]
    show_chart_component: true
    row:
    col:
    width:
    height:
    tab_name: ''
  - name: Cost of Delivery %
    title: Cost of Delivery %
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
    smart_single_value_size: true
    show_comparison: true
    comparison_type: change_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Target
    enable_conditional_formatting: false
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
    show_chart_component: true
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
    row:
    col:
    width:
    height:
    tab_name: ''
  - title: Monthly Pipeline Forecast
    name: Monthly Pipeline Forecast
    model: analytics
    explore: monthly_resource_revenue_forecast_fact
    type: looker_column
    fields: [monthly_resource_revenue_forecast_fact.forecast_month, monthly_resource_revenue_forecast_fact.dynamic_measure,
      monthly_resource_revenue_forecast_fact.dynamic_split]
    pivots: [monthly_resource_revenue_forecast_fact.dynamic_split]
    filters:
      monthly_resource_revenue_forecast_fact.forecast_month: after 1 months from now
      monthly_resource_revenue_forecast_fact.dynamic_split: ''
      monthly_resource_revenue_forecast_fact.selected_measure: total^_forecast^_revenue^_gbp
      monthly_resource_revenue_forecast_fact.selected_split: forecast^_type
    sorts: [monthly_resource_revenue_forecast_fact.dynamic_split, monthly_resource_revenue_forecast_fact.forecast_month]
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
      collection_id: looker_2026
      options:
        steps: 5
        reverse: false
      custom:
        colors:
        - "#4285F4"
        - "#C4CCE1"
        - "#AD7FE6"
        - "#B5C665"
        - "#2BB8CA"
        - "#EAC43B"
        - "#E574B1"
        - "#6666BA"
        - "#DDBA83"
        - "#99D8F4"
        - "#1C7781"
        - "#E3AEF2"
        - "#803E8F"
        - "#70783A"
        - "#B95B41"
        - "#56BBE5"
        - "#3364A7"
        - "#966B54"
        - "#CC9434"
        - "#C4CCE1"
        type: discrete
    hidden_fields: []
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: [monthly_resource_revenue_forecast_fact.total_forecast_monthly_hours,
      monthly_resource_revenue_forecast_fact.total_forecast_sac_fte, Booked - monthly_resource_revenue_forecast_fact.total_forecast_monthly_hours,
      Pipeline - monthly_resource_revenue_forecast_fact.total_forecast_monthly_hours,
      Pipeline - monthly_resource_revenue_forecast_fact.total_forecast_sac_fte, Booked
        - monthly_resource_revenue_forecast_fact.total_forecast_sac_fte]
    label_value_format: ''
    series_colors: {}
    show_null_points: true
    interpolation: linear
    hidden_pivots: {}
    defaults_version: 1
    modern2026: true
    row:
    col:
    width:
    height:
    tab_name: ''
  - title: How much revenue is booked, forecasted and remaining to target?
    name: How much revenue is booked, forecasted and remaining to target?
    model: analytics
    explore: revenue_and_forecast
    type: looker_column
    fields: [revenue_and_forecast.period_month, sum_of_booked_revenue, sum_of_forecast_revenue,
      sum_of_target_revenue_2]
    fill_fields: [revenue_and_forecast.period_month]
    filters:
      revenue_and_forecast.period_month: 2026/04/01 to 2027/03/31
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
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: looker_2026
      palette_id: looker_2026_categorical_1
      options:
        steps: 5
    hidden_fields: [target_remaining_gbp]
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
      sum_of_forecast_revenue: "#C4CCE1"
      sum_of_target_revenue_2: "#B95B41"
    series_labels:
      sum_of_booked_revenue: Booked Revenue GBP
      sum_of_forecast_revenue: Forecast Revenue GBP
      sum_of_target_revenue_2: Target Revenue GBP
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: right, color: "#858585",
        line_value: '72000', label: Breakeven (Avg) - 2025}, {reference_type: line,
        range_start: max, range_end: min, margin_top: deviation, margin_value: mean,
        margin_bottom: deviation, label_position: right, color: "#000000", line_value: '93000',
        label: Breakeven (Avg) - 2026}]
    trend_lines: []
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_pivots: {}
    modern2026: true
    row:
    col:
    width:
    height:
    tab_name: ''
