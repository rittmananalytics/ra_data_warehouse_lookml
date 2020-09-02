- dashboard: web_traffic
  title: Web Traffic
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - name: What content did those visitors look at when on-site?
    title: What content did those visitors look at when on-site?
    merged_queries:
    - model: analytics
      explore: web_sessions_fact
      type: looker_grid
      fields: [web_events_fact.page_title, web_events_fact.total_page_views, web_events_fact.total_blended_user_id,
        web_events_fact.page_url_path]
      filters:
        web_events_fact.site: www.switcherstudio.com
        web_sessions_fact.group_a_yesno: 'Yes'
      sorts: [web_events_fact.total_blended_user_id desc]
      limit: 100
      total: true
      query_timezone: America/Los_Angeles
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
      series_cell_visualizations:
        web_events_rpt__event.total_page_views:
          is_active: true
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
      hidden_fields: []
      y_axes: []
    - model: switcherstudio
      explore: web_sessions_fact
      type: looker_column
      fields: [web_events_fact.page_title, web_events_fact.total_page_views, web_events_fact.total_blended_user_id,
        web_events_fact.page_url_path]
      filters:
        web_events_fact.site: www.switcherstudio.com
        web_sessions_fact.group_b_yesno: 'Yes'
      sorts: [web_events_fact.total_page_views desc]
      limit: 500
      total: true
      query_timezone: America/Los_Angeles
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
      hidden_fields: []
      y_axes: []
      join_fields:
      - field_name: web_events_fact.page_title
        source_field_name: web_events_fact.page_title
      - field_name: web_events_fact.page_url_path
        source_field_name: web_events_fact.page_url_path
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_labels:
      pageview_delta: Pageview % Δ
      visitors_delta: Unique Users % Δ
    series_cell_visualizations:
      web_events_rpt__event.total_page_views:
        is_active: true
      pageview_delta:
        is_active: false
        palette:
          palette_id: 1e4d66b9-f066-4c33-b0b7-cc10b4810688
          collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
        value_display: true
      visitors_delta:
        is_active: false
        palette:
          palette_id: 1e4d66b9-f066-4c33-b0b7-cc10b4810688
          collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
        value_display: true
      web_events_fact.total_page_views:
        is_active: true
      web_events_fact.total_blended_user_id:
        is_active: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#3EB0D5",
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 1e4d66b9-f066-4c33-b0b7-cc10b4810688, options: {steps: 5, constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [pageview_delta, visitors_delta]}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    type: looker_grid
    series_types: {}
    hidden_fields: [q1_web_events_rpt__event.total_page_views, q1_web_events_rpt.total_blended_user_id,
      q1_web_events_fact.total_page_views, q1_web_events_fact.total_blended_user_id]
    y_axes: []
    total: true
    dynamic_fields: [{table_calculation: pageview_delta, label: pageview_delta, expression: "${web_events_fact.total_page_views}/\
          \ ${q1_web_events_fact.total_page_views} -1", value_format: !!null '', value_format_name: percent_1,
        _kind_hint: measure, _type_hint: number}, {table_calculation: visitors_delta,
        label: visitors_delta, expression: "${web_events_fact.total_blended_user_id}/${q1_web_events_fact.total_blended_user_id}\
          \ - 1", value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number}]
    listen:
    - Continent: web_events_fact.continent_name
      Country: web_events_fact.country_name
      City: web_events_fact.city_name
      UTM Medium: web_events_fact.utm_medium
      UTM Campaign: web_events_fact.utm_campaign
      UTM Source: web_events_fact.utm_source
      Plan: plans_dim.plan_name
      Status: subscriptions_fact.subscription_status
      Channel: web_sessions_fact.channel
      Referrer: web_sessions_fact.referrer_host
      Page Category: web_events_fact.category
      Session Start Date: web_sessions_fact.timeframe_a
    - Continent: web_events_fact.continent_name
      Country: web_events_fact.country_name
      City: web_events_fact.city_name
      UTM Medium: web_events_fact.utm_medium
      UTM Campaign: web_events_fact.utm_campaign
      UTM Source: web_events_fact.utm_source
      Plan: plans_dim.plan_name
      Status: subscriptions_fact.subscription_status
      Channel: web_sessions_fact.channel
      Referrer: web_sessions_fact.referrer_host
      Page Category: web_events_fact.category
      Session Start Date: web_sessions_fact.timeframe_a
    row: 10
    col: 0
    width: 16
    height: 8
  - name: Which plan type did visitors have?
    title: Which plan type did visitors have?
    model: switcherstudio
    explore: web_sessions_fact
    type: looker_pie
    fields: [plans_dim.plan_name, web_events_fact.total_blended_user_id]
    filters:
      web_events_fact.site: www.switcherstudio.com
      web_sessions_fact.group_a_yesno: 'Yes'
    sorts: [web_events_fact.total_blended_user_id desc]
    limit: 500
    query_timezone: America/Los_Angeles
    value_labels: legend
    label_type: labPer
    inner_radius: 50
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
    hidden_fields: []
    y_axes: []
    listen:
      Continent: web_events_fact.continent_name
      Country: web_events_fact.country_name
      City: web_events_fact.city_name
      UTM Medium: web_events_fact.utm_medium
      UTM Campaign: web_events_fact.utm_campaign
      UTM Source: web_events_fact.utm_source
      Plan: plans_dim.plan_name
      Status: subscriptions_fact.subscription_status
      Channel: web_sessions_fact.channel
      Referrer: web_sessions_fact.referrer_host
      Page Category: web_events_fact.category
      Session Start Date: web_sessions_fact.timeframe_a
    row: 18
    col: 0
    width: 8
    height: 7
  - name: Site Visitors By Geography
    title: Site Visitors By Geography
    model: switcherstudio
    explore: web_sessions_fact
    type: looker_map
    fields: [web_events_fact.total_blended_user_id, web_events_fact.country_name]
    filters:
      web_events_fact.site: www.switcherstudio.com
      web_sessions_fact.group_a_yesno: 'Yes'
    sorts: [web_events_fact.total_blended_user_id desc]
    limit: 500
    total: true
    query_timezone: America/Los_Angeles
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    map_latitude: 1
    map_longitude: 1
    map_zoom: 1
    value_labels: legend
    label_type: labPer
    inner_radius: 50
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
    defaults_version: 1
    series_types: {}
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
    hidden_fields: []
    y_axes: []
    listen:
      Continent: web_events_fact.continent_name
      Country: web_events_fact.country_name
      City: web_events_fact.city_name
      UTM Medium: web_events_fact.utm_medium
      UTM Campaign: web_events_fact.utm_campaign
      UTM Source: web_events_fact.utm_source
      Plan: plans_dim.plan_name
      Status: subscriptions_fact.subscription_status
      Channel: web_sessions_fact.channel
      Referrer: web_sessions_fact.referrer_host
      Page Category: web_events_fact.category
      Session Start Date: web_sessions_fact.timeframe_a
    row: 25
    col: 16
    width: 8
    height: 10
  - name: Which subscription status did visitors have?
    title: Which subscription status did visitors have?
    model: switcherstudio
    explore: web_sessions_fact
    type: looker_pie
    fields: [web_events_fact.total_blended_user_id, subscriptions_fact.subscription_status]
    filters:
      web_events_fact.site: www.switcherstudio.com
      web_sessions_fact.group_a_yesno: 'Yes'
    sorts: [web_events_fact.total_blended_user_id desc]
    limit: 500
    query_timezone: America/Los_Angeles
    value_labels: legend
    label_type: labPer
    inner_radius: 50
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
    hidden_fields: []
    y_axes: []
    listen:
      Continent: web_events_fact.continent_name
      Country: web_events_fact.country_name
      City: web_events_fact.city_name
      UTM Medium: web_events_fact.utm_medium
      UTM Campaign: web_events_fact.utm_campaign
      UTM Source: web_events_fact.utm_source
      Plan: plans_dim.plan_name
      Status: subscriptions_fact.subscription_status
      Channel: web_sessions_fact.channel
      Referrer: web_sessions_fact.referrer_host
      Page Category: web_events_fact.category
      Session Start Date: web_sessions_fact.timeframe_a
    row: 18
    col: 8
    width: 8
    height: 7
  - name: Proportion of Plan Type Table Held by Unique Users in the Last 7 Days (totals)
      (copy)
    title: Proportion of Plan Type Table Held by Unique Users in the Last 7 Days (totals)
      (copy)
    model: switcherstudio
    explore: web_sessions_fact
    type: looker_grid
    fields: [plans_dim.plan_name, web_events_fact.total_blended_user_id]
    filters:
      web_events_fact.site: www.switcherstudio.com
      web_sessions_fact.group_a_yesno: 'Yes'
    sorts: [web_events_fact.total_blended_user_id desc]
    limit: 500
    total: true
    query_timezone: America/Los_Angeles
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
    series_cell_visualizations:
      web_events_rpt.total_blended_user_id:
        is_active: false
    value_labels: legend
    label_type: labPer
    inner_radius: 50
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
    hidden_fields: []
    y_axes: []
    title_hidden: true
    listen:
      Continent: web_events_fact.continent_name
      Country: web_events_fact.country_name
      City: web_events_fact.city_name
      UTM Medium: web_events_fact.utm_medium
      UTM Campaign: web_events_fact.utm_campaign
      UTM Source: web_events_fact.utm_source
      Plan: plans_dim.plan_name
      Status: subscriptions_fact.subscription_status
      Channel: web_sessions_fact.channel
      Referrer: web_sessions_fact.referrer_host
      Page Category: web_events_fact.category
      Session Start Date: web_sessions_fact.timeframe_a
    row: 25
    col: 0
    width: 8
    height: 10
  - name: Proportion of Subscription Statuses Table Held by Unique Users in the Last
      7 Days (copy)
    title: Proportion of Subscription Statuses Table Held by Unique Users in the Last
      7 Days (copy)
    model: switcherstudio
    explore: web_sessions_fact
    type: looker_grid
    fields: [web_events_fact.total_blended_user_id, subscriptions_fact.subscription_status]
    filters:
      web_events_fact.site: www.switcherstudio.com
      web_sessions_fact.group_a_yesno: 'Yes'
    sorts: [web_events_fact.total_blended_user_id desc]
    limit: 500
    query_timezone: America/Los_Angeles
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
    series_cell_visualizations:
      web_events_rpt.total_blended_user_id:
        is_active: false
    value_labels: legend
    label_type: labPer
    inner_radius: 50
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
    hidden_fields: []
    y_axes: []
    title_hidden: true
    listen:
      Continent: web_events_fact.continent_name
      Country: web_events_fact.country_name
      City: web_events_fact.city_name
      UTM Medium: web_events_fact.utm_medium
      UTM Campaign: web_events_fact.utm_campaign
      UTM Source: web_events_fact.utm_source
      Plan: plans_dim.plan_name
      Status: subscriptions_fact.subscription_status
      Channel: web_sessions_fact.channel
      Referrer: web_sessions_fact.referrer_host
      Page Category: web_events_fact.category
      Session Start Date: web_sessions_fact.timeframe_a
    row: 25
    col: 8
    width: 8
    height: 10
  - name: Site Visitors By Channel
    title: Site Visitors By Channel
    model: switcherstudio
    explore: web_sessions_fact
    type: looker_pie
    fields: [web_sessions_fact.channel, web_events_fact.total_blended_user_id]
    filters:
      web_events_fact.site: www.switcherstudio.com
      web_sessions_fact.group_a_yesno: 'Yes'
    sorts: [web_events_fact.total_blended_user_id desc]
    limit: 500
    total: true
    query_timezone: America/Los_Angeles
    value_labels: legend
    label_type: labPer
    inner_radius: 50
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
    hidden_fields: []
    y_axes: []
    listen:
      Continent: web_events_fact.continent_name
      Country: web_events_fact.country_name
      City: web_events_fact.city_name
      UTM Medium: web_events_fact.utm_medium
      UTM Campaign: web_events_fact.utm_campaign
      UTM Source: web_events_fact.utm_source
      Plan: plans_dim.plan_name
      Status: subscriptions_fact.subscription_status
      Channel: web_sessions_fact.channel
      Referrer: web_sessions_fact.referrer_host
      Page Category: web_events_fact.category
      Session Start Date: web_sessions_fact.timeframe_a
    row: 10
    col: 16
    width: 8
    height: 8
  - name: How many site visitors were there?
    title: How many site visitors were there?
    model: switcherstudio
    explore: web_sessions_fact
    type: looker_line
    fields: [web_events_fact.total_blended_user_id, web_sessions_fact.session_start_ts_date]
    fill_fields: [web_sessions_fact.session_start_ts_date]
    filters:
      web_events_fact.site: www.switcherstudio.com
      web_sessions_fact.group_a_yesno: 'Yes'
    sorts: [web_sessions_fact.session_start_ts_date desc]
    limit: 500
    query_timezone: America/Los_Angeles
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
    defaults_version: 1
    hidden_fields: []
    y_axes: []
    listen:
      Continent: web_events_fact.continent_name
      Country: web_events_fact.country_name
      City: web_events_fact.city_name
      UTM Medium: web_events_fact.utm_medium
      UTM Campaign: web_events_fact.utm_campaign
      UTM Source: web_events_fact.utm_source
      Plan: plans_dim.plan_name
      Status: subscriptions_fact.subscription_status
      Channel: web_sessions_fact.channel
      Referrer: web_sessions_fact.referrer_host
      Page Category: web_events_fact.category
      Session Start Date: web_sessions_fact.timeframe_a
    row: 2
    col: 0
    width: 12
    height: 8
  - name: How many pages did they visit?
    title: How many pages did they visit?
    model: switcherstudio
    explore: web_sessions_fact
    type: looker_line
    fields: [web_events_fact.event_ts_date, web_events_fact.total_page_views]
    fill_fields: [web_events_fact.event_ts_date]
    filters:
      web_events_fact.site: www.switcherstudio.com
      web_sessions_fact.group_a_yesno: 'Yes'
    sorts: [web_events_fact.event_ts_date desc]
    limit: 500
    query_timezone: America/Los_Angeles
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
    defaults_version: 1
    hidden_fields: []
    y_axes: []
    listen:
      Continent: web_events_fact.continent_name
      Country: web_events_fact.country_name
      City: web_events_fact.city_name
      UTM Medium: web_events_fact.utm_medium
      UTM Campaign: web_events_fact.utm_campaign
      UTM Source: web_events_fact.utm_source
      Plan: plans_dim.plan_name
      Status: subscriptions_fact.subscription_status
      Channel: web_sessions_fact.channel
      Referrer: web_sessions_fact.referrer_host
      Page Category: web_events_fact.category
      Session Start Date: web_sessions_fact.timeframe_a
    row: 2
    col: 12
    width: 12
    height: 8
  - name: Site Top Referral Domains
    title: Site Top Referral Domains
    model: switcherstudio
    explore: web_sessions_fact
    type: looker_grid
    fields: [web_events_fact.total_blended_user_id, web_sessions_fact.referrer_host]
    filters:
      web_events_fact.site: www.switcherstudio.com
      web_sessions_fact.group_a_yesno: 'Yes'
    sorts: [web_events_fact.total_blended_user_id desc]
    limit: 500
    total: true
    query_timezone: America/Los_Angeles
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
    value_labels: legend
    label_type: labPer
    inner_radius: 50
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
    hidden_fields: []
    y_axes: []
    listen:
      Continent: web_events_fact.continent_name
      Country: web_events_fact.country_name
      City: web_events_fact.city_name
      UTM Medium: web_events_fact.utm_medium
      UTM Campaign: web_events_fact.utm_campaign
      UTM Source: web_events_fact.utm_source
      Plan: plans_dim.plan_name
      Status: subscriptions_fact.subscription_status
      Channel: web_sessions_fact.channel
      Referrer: web_sessions_fact.referrer_host
      Page Category: web_events_fact.category
      Session Start Date: web_sessions_fact.timeframe_a
    row: 18
    col: 16
    width: 8
    height: 7
  - name: New Tile
    title: New Tile
    merged_queries:
    - model: switcherstudio
      explore: web_sessions_fact
      type: single_value
      fields: [web_events_fact.site, web_events_fact.total_blended_user_id]
      filters:
        web_events_fact.site: www.switcherstudio.com
        web_sessions_fact.group_a_yesno: 'Yes'
      sorts: [web_events_fact.total_blended_user_id desc]
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
      value_format: ''
      series_types: {}
      defaults_version: 1
      hidden_fields: []
      y_axes: []
    - model: switcherstudio
      explore: web_sessions_fact
      type: single_value
      fields: [web_events_fact.total_blended_user_id, web_events_fact.site]
      filters:
        web_events_fact.site: www.switcherstudio.com
        web_sessions_fact.group_b_yesno: 'Yes'
      sorts: [web_events_fact.total_blended_user_id desc]
      limit: 500
      query_timezone: America/Los_Angeles
      custom_color_enabled: true
      show_single_value_title: true
      show_comparison: false
      comparison_type: value
      comparison_reverse_colors: false
      show_comparison_label: true
      enable_conditional_formatting: false
      conditional_formatting_include_totals: false
      conditional_formatting_include_nulls: false
      series_types: {}
      defaults_version: 1
      hidden_fields: []
      y_axes: []
      join_fields:
      - field_name: web_events_fact.site
        source_field_name: web_events_fact.site
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Unique Visitors
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    type: single_value
    series_types: {}
    hidden_fields: [q1_web_events_rpt.total_blended_user_id, q1_web_events_fact.total_blended_user_id]
    y_axes: []
    dynamic_fields: [{table_calculation: total_users_delta, label: total_users_delta,
        expression: "${web_events_fact.total_blended_user_id}/${q1_web_events_fact.total_blended_user_id}\
          \ -1", value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number}]
    listen:
    - Continent: web_events_fact.continent_name
      Country: web_events_fact.country_name
      City: web_events_fact.city_name
      UTM Medium: web_events_fact.utm_medium
      UTM Campaign: web_events_fact.utm_campaign
      UTM Source: web_events_fact.utm_source
      Plan: plans_dim.plan_name
      Status: subscriptions_fact.subscription_status
      Channel: web_sessions_fact.channel
      Referrer: web_sessions_fact.referrer_host
      Page Category: web_events_fact.category
      Session Start Date: web_sessions_fact.timeframe_a
    - Continent: web_events_fact.continent_name
      Country: web_events_fact.country_name
      City: web_events_fact.city_name
      UTM Medium: web_events_fact.utm_medium
      UTM Campaign: web_events_fact.utm_campaign
      UTM Source: web_events_fact.utm_source
      Plan: plans_dim.plan_name
      Status: subscriptions_fact.subscription_status
      Channel: web_sessions_fact.channel
      Referrer: web_sessions_fact.referrer_host
      Page Category: web_events_fact.category
      Session Start Date: web_sessions_fact.timeframe_a
    row: 0
    col: 0
    width: 4
    height: 2
  - name: New Tile (2)
    title: New Tile
    merged_queries:
    - model: switcherstudio
      explore: web_sessions_fact
      type: single_value
      fields: [web_events_fact.total_page_views, web_events_fact.site]
      filters:
        web_events_fact.site: www.switcherstudio.com
        web_sessions_fact.group_a_yesno: 'Yes'
      sorts: [web_events_fact.total_page_views desc]
      limit: 500
      query_timezone: America/Los_Angeles
      custom_color_enabled: true
      show_single_value_title: true
      show_comparison: false
      comparison_type: value
      comparison_reverse_colors: false
      show_comparison_label: true
      enable_conditional_formatting: false
      conditional_formatting_include_totals: false
      conditional_formatting_include_nulls: false
      defaults_version: 1
      hidden_fields: []
      y_axes: []
    - model: switcherstudio
      explore: web_sessions_fact
      type: single_value
      fields: [web_events_fact.site, web_events_fact.total_page_views]
      filters:
        web_events_fact.site: www.switcherstudio.com
        web_sessions_fact.group_b_yesno: 'Yes'
      sorts: [web_events_fact.total_page_views desc]
      limit: 500
      query_timezone: America/Los_Angeles
      custom_color_enabled: true
      show_single_value_title: true
      show_comparison: false
      comparison_type: value
      comparison_reverse_colors: false
      show_comparison_label: true
      enable_conditional_formatting: false
      conditional_formatting_include_totals: false
      conditional_formatting_include_nulls: false
      series_types: {}
      value_labels: legend
      label_type: labPer
      defaults_version: 1
      hidden_fields: []
      y_axes: []
      join_fields:
      - field_name: web_events_fact.site
        source_field_name: web_events_fact.site
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Pageviews
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    type: single_value
    series_types: {}
    hidden_fields: [q1_web_events_rpt__event.total_page_views, q1_web_events_fact.total_page_views]
    y_axes: []
    dynamic_fields: [{table_calculation: page_views_delta, label: page_views_delta,
        expression: "${web_events_fact.total_page_views} / ${q1_web_events_fact.total_page_views}\
          \ -1", value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number}]
    listen:
    - Continent: web_events_fact.continent_name
      Country: web_events_fact.country_name
      City: web_events_fact.city_name
      UTM Medium: web_events_fact.utm_medium
      UTM Campaign: web_events_fact.utm_campaign
      UTM Source: web_events_fact.utm_source
      Plan: plans_dim.plan_name
      Status: subscriptions_fact.subscription_status
      Channel: web_sessions_fact.channel
      Referrer: web_sessions_fact.referrer_host
      Page Category: web_events_fact.category
      Session Start Date: web_sessions_fact.timeframe_a
    - Continent: web_events_fact.continent_name
      Country: web_events_fact.country_name
      City: web_events_fact.city_name
      UTM Medium: web_events_fact.utm_medium
      UTM Campaign: web_events_fact.utm_campaign
      UTM Source: web_events_fact.utm_source
      Plan: plans_dim.plan_name
      Status: subscriptions_fact.subscription_status
      Channel: web_sessions_fact.channel
      Referrer: web_sessions_fact.referrer_host
      Page Category: web_events_fact.category
      Session Start Date: web_sessions_fact.timeframe_a
    row: 0
    col: 8
    width: 4
    height: 2
  - name: Sessions
    title: Sessions
    merged_queries:
    - model: switcherstudio
      explore: web_sessions_fact
      type: table
      fields: [web_sessions_fact.total_web_sessions_pk, web_events_fact.site]
      filters:
        web_events_fact.site: www.switcherstudio.com
        web_sessions_fact.group_a_yesno: 'Yes'
      limit: 500
      query_timezone: America/Los_Angeles
      hidden_fields: []
      y_axes: []
    - model: switcherstudio
      explore: web_sessions_fact
      type: table
      fields: [web_events_fact.site, web_sessions_fact.total_web_sessions_pk]
      filters:
        web_events_fact.site: www.switcherstudio.com
        web_sessions_fact.group_b_yesno: 'Yes'
      sorts: [web_sessions_fact.total_web_sessions_pk desc]
      limit: 500
      query_timezone: America/Los_Angeles
      hidden_fields: []
      y_axes: []
      join_fields:
      - field_name: web_events_fact.site
        source_field_name: web_events_fact.site
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: Sessions
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [q1_web_events_rpt.total_web_sessions_pk, q1_web_sessions_fact.total_web_sessions_pk]
    series_types: {}
    type: single_value
    y_axes: []
    dynamic_fields: [{table_calculation: sessions_delta, label: sessions_delta, expression: "${web_sessions_fact.total_web_sessions_pk}\
          \ / ${q1_web_sessions_fact.total_web_sessions_pk} - 1", value_format: !!null '',
        value_format_name: percent_1, _kind_hint: measure, _type_hint: number}]
    listen:
    - Continent: web_events_fact.continent_name
      Country: web_events_fact.country_name
      City: web_events_fact.city_name
      UTM Medium: web_events_fact.utm_medium
      UTM Campaign: web_events_fact.utm_campaign
      UTM Source: web_events_fact.utm_source
      Plan: plans_dim.plan_name
      Status: subscriptions_fact.subscription_status
      Channel: web_sessions_fact.channel
      Referrer: web_sessions_fact.referrer_host
      Page Category: web_events_fact.category
      Session Start Date: web_sessions_fact.timeframe_a
    - Continent: web_events_fact.continent_name
      Country: web_events_fact.country_name
      City: web_events_fact.city_name
      UTM Medium: web_events_fact.utm_medium
      UTM Campaign: web_events_fact.utm_campaign
      UTM Source: web_events_fact.utm_source
      Plan: plans_dim.plan_name
      Status: subscriptions_fact.subscription_status
      Channel: web_sessions_fact.channel
      Referrer: web_sessions_fact.referrer_host
      Page Category: web_events_fact.category
      Session Start Date: web_sessions_fact.timeframe_a
    row: 0
    col: 12
    width: 4
    height: 2
  - name: PageViews Per Visitor
    title: PageViews Per Visitor
    merged_queries:
    - model: switcherstudio
      explore: web_sessions_fact
      type: single_value
      fields: [web_events_fact.site, web_events_fact.total_page_views, web_events_fact.total_blended_user_id]
      filters:
        web_events_fact.site: www.switcherstudio.com
        web_sessions_fact.group_a_yesno: 'Yes'
      sorts: [web_events_fact.total_page_views desc]
      limit: 500
      dynamic_fields: [{table_calculation: views_per_visitor_1, label: views_per_visitor_1,
          expression: "${web_events_fact.total_page_views} / ${web_events_fact.total_blended_user_id}",
          value_format: !!null '', value_format_name: decimal_2, _kind_hint: measure,
          _type_hint: number}]
      query_timezone: America/Los_Angeles
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
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      defaults_version: 1
      series_types: {}
      hidden_fields: []
      y_axes: []
    - model: switcherstudio
      explore: web_sessions_fact
      type: table
      fields: [web_events_fact.site, web_events_fact.total_page_views, web_events_fact.total_blended_user_id]
      filters:
        web_events_fact.site: www.switcherstudio.com
        web_sessions_fact.group_b_yesno: 'Yes'
      limit: 500
      dynamic_fields: [{table_calculation: pages_per_visitor_2, label: pages_per_visitor_2,
          expression: "${web_events_fact.total_page_views} / ${web_events_fact.total_blended_user_id}",
          value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
          _type_hint: number}]
      query_timezone: America/Los_Angeles
      hidden_fields: []
      y_axes: []
      join_fields:
      - field_name: web_events_fact.site
        source_field_name: web_events_fact.site
    custom_color_enabled: true
    show_single_value_title: true
    single_value_title: PageViews / Unique Visitors
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: false
    conditional_formatting: [{type: equal to, value: !!null '', background_color: "#3EB0D5",
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [web_events_fact.total_page_views, web_events_fact.total_blended_user_id,
      q1_web_events_rpt__event.total_page_views, q1_web_events_rpt.total_blended_user_id,
      pages_per_visitor_2, q1_web_events_fact.total_page_views, q1_web_events_fact.total_blended_user_id]
    series_types: {}
    type: single_value
    y_axes: []
    dynamic_fields: [{table_calculation: views_per_visitor_delta, label: views_per_visitor_delta,
        expression: "#${views_per_visitor_1} / ${pages_per_visitor_2} - 1\n${views_per_visitor_1}\
          \ - ${pages_per_visitor_2}", value_format: !!null '', value_format_name: decimal_2,
        _kind_hint: measure, _type_hint: number}]
    listen:
    - Continent: web_events_fact.continent_name
      Country: web_events_fact.country_name
      City: web_events_fact.city_name
      UTM Medium: web_events_fact.utm_medium
      UTM Campaign: web_events_fact.utm_campaign
      UTM Source: web_events_fact.utm_source
      Plan: plans_dim.plan_name
      Status: subscriptions_fact.subscription_status
      Channel: web_sessions_fact.channel
      Referrer: web_sessions_fact.referrer_host
      Page Category: web_events_fact.category
      Session Start Date: web_sessions_fact.timeframe_a
    - Continent: web_events_fact.continent_name
      Country: web_events_fact.country_name
      City: web_events_fact.city_name
      UTM Medium: web_events_fact.utm_medium
      UTM Campaign: web_events_fact.utm_campaign
      UTM Source: web_events_fact.utm_source
      Plan: plans_dim.plan_name
      Status: subscriptions_fact.subscription_status
      Channel: web_sessions_fact.channel
      Referrer: web_sessions_fact.referrer_host
      Page Category: web_events_fact.category
      Session Start Date: web_sessions_fact.timeframe_a
    row: 0
    col: 16
    width: 4
    height: 2
  - name: Session Duration
    title: Session Duration
    merged_queries:
    - model: switcherstudio
      explore: web_sessions_fact
      type: table
      fields: [web_sessions_fact.total_duration_in_s, web_events_fact.site]
      filters:
        web_events_fact.site: www.switcherstudio.com
        web_sessions_fact.group_a_yesno: 'Yes'
      limit: 500
      query_timezone: America/Los_Angeles
      hidden_fields: []
      y_axes: []
    - model: switcherstudio
      explore: web_sessions_fact
      type: table
      fields: [web_events_fact.site, web_sessions_fact.total_duration_in_s]
      filters:
        web_events_fact.site: www.switcherstudio.com
        web_sessions_fact.group_b_yesno: 'Yes'
      limit: 500
      query_timezone: America/Los_Angeles
      hidden_fields: []
      y_axes: []
      join_fields:
      - field_name: web_events_fact.site
        source_field_name: web_events_fact.site
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Session Duration (mins)
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [q1_web_events_rpt.total_duration_in_s, q1_web_sessions_fact.total_duration_in_s]
    series_types: {}
    type: single_value
    y_axes: []
    dynamic_fields: [{table_calculation: duration_delta, label: duration_delta, expression: "${web_sessions_fact.total_duration_in_s}\
          \ / ${q1_web_sessions_fact.total_duration_in_s} - 1", value_format: !!null '',
        value_format_name: percent_1, _kind_hint: measure, _type_hint: number}]
    listen:
    - Continent: web_events_fact.continent_name
      Country: web_events_fact.country_name
      City: web_events_fact.city_name
      UTM Medium: web_events_fact.utm_medium
      UTM Campaign: web_events_fact.utm_campaign
      UTM Source: web_events_fact.utm_source
      Plan: plans_dim.plan_name
      Status: subscriptions_fact.subscription_status
      Channel: web_sessions_fact.channel
      Referrer: web_sessions_fact.referrer_host
      Page Category: web_events_fact.category
      Session Start Date: web_sessions_fact.timeframe_a
    - Continent: web_events_fact.continent_name
      Country: web_events_fact.country_name
      City: web_events_fact.city_name
      UTM Medium: web_events_fact.utm_medium
      UTM Campaign: web_events_fact.utm_campaign
      UTM Source: web_events_fact.utm_source
      Plan: plans_dim.plan_name
      Status: subscriptions_fact.subscription_status
      Channel: web_sessions_fact.channel
      Referrer: web_sessions_fact.referrer_host
      Page Category: web_events_fact.category
      Session Start Date: web_sessions_fact.timeframe_a
    row: 0
    col: 20
    width: 4
    height: 2
  - name: Bounce Rate
    title: Bounce Rate
    merged_queries:
    - model: switcherstudio
      explore: web_sessions_fact
      type: single_value
      fields: [web_sessions_fact.bounced_session_rate, web_events_fact.site]
      filters:
        web_events_fact.site: www.switcherstudio.com
        web_sessions_fact.group_a_yesno: 'Yes'
      sorts: [web_sessions_fact.bounced_session_rate desc]
      limit: 500
      query_timezone: America/Los_Angeles
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
      defaults_version: 1
      series_types: {}
    - model: switcherstudio
      explore: web_sessions_fact
      type: table
      fields: [web_sessions_fact.bounced_session_rate, web_events_fact.site]
      filters:
        web_events_fact.site: www.switcherstudio.com
        web_sessions_fact.group_b_yesno: 'Yes'
      limit: 500
      query_timezone: America/Los_Angeles
      join_fields:
      - field_name: web_events_fact.site
        source_field_name: web_events_fact.site
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    comparison_label: Bounce Rate
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    type: single_value
    series_types: {}
    hidden_fields: [q1_web_sessions_fact.bounced_session_rate]
    dynamic_fields: [{table_calculation: bounce_rate_delta, label: bounce_rate_delta,
        expression: "${web_sessions_fact.bounced_session_rate} - ${q1_web_sessions_fact.bounced_session_rate}",
        value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
        _type_hint: number}]
    listen:
    - Session Start Date: web_sessions_fact.timeframe_a
    - Session Start Date: web_sessions_fact.timeframe_a
    row: 0
    col: 4
    width: 4
    height: 2
  filters:
  - name: Continent
    title: Continent
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: switcherstudio
    explore: web_sessions_fact
    listens_to_filters: []
    field: web_events_fact.continent_name
  - name: Country
    title: Country
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: switcherstudio
    explore: web_sessions_fact
    listens_to_filters: []
    field: web_events_fact.country_name
  - name: City
    title: City
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: switcherstudio
    explore: web_sessions_fact
    listens_to_filters: []
    field: web_events_fact.city_name
  - name: UTM Medium
    title: UTM Medium
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: switcherstudio
    explore: web_sessions_fact
    listens_to_filters: []
    field: web_events_fact.utm_medium
  - name: UTM Campaign
    title: UTM Campaign
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: switcherstudio
    explore: web_sessions_fact
    listens_to_filters: []
    field: web_events_fact.utm_campaign
  - name: UTM Source
    title: UTM Source
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: switcherstudio
    explore: web_sessions_fact
    listens_to_filters: []
    field: web_events_fact.utm_source
  - name: Plan
    title: Plan
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: switcherstudio
    explore: web_sessions_fact
    listens_to_filters: []
    field: plans_dim.plan_name
  - name: Status
    title: Status
    type: string_filter
    default_value: ''
    allow_multiple_values: true
    required: false
  - name: Channel
    title: Channel
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: switcherstudio
    explore: web_sessions_fact
    listens_to_filters: []
    field: web_sessions_fact.channel
  - name: Referrer
    title: Referrer
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: switcherstudio
    explore: web_sessions_fact
    listens_to_filters: []
    field: web_sessions_fact.referrer_host
  - name: Page Category
    title: Page Category
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: switcherstudio
    explore: web_sessions_fact
    listens_to_filters: []
    field: web_events_fact.category
  - name: Session Start Date
    title: Timeframe A
    type: field_filter
    default_value: 7 day
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: inline
      options: []
    model: switcherstudio
    explore: web_sessions_fact
    listens_to_filters: []
    field: web_sessions_fact.timeframe_a
