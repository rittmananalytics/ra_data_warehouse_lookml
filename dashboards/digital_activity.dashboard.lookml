# =============================================================================
# DIGITAL ACTIVITY DASHBOARD
# Analyze YouTube, search, and digital activity patterns
# =============================================================================

- dashboard: digital_activity
  title: "Digital Activity"
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: "Analyze YouTube, search, and digital activity patterns"

  filters:
    - name: date_range
      title: "Date Range"
      type: field_filter
      default_value: "30 days"
      allow_multiple_values: false
      required: false
      ui_config:
        type: relative_timeframes
        display: inline
      explore: youtube_activity
      field: youtube_activity.activity_date

  elements:

  # ===========================================================================
  # ROW 1: KPI TILES
  # ===========================================================================

    - name: total_activities
      title: "Total Activities"
      type: single_value
      model: personal_data_dashboard
      explore: youtube_activity
      fields: [youtube_activity.count]
      limit: 1
      custom_color_enabled: true
      custom_color: "#FF0000"
      single_value_title: "Activities"
      value_format: "#,##0"
      row: 0
      col: 0
      width: 4
      height: 3

    - name: unique_domains
      title: "Unique Domains"
      type: single_value
      model: personal_data_dashboard
      explore: youtube_activity
      fields: [youtube_activity.unique_domains]
      limit: 1
      custom_color_enabled: true
      custom_color: "#2196F3"
      single_value_title: "Domains"
      value_format: "#,##0"
      row: 0
      col: 4
      width: 4
      height: 3

    - name: unique_activities
      title: "Unique Activities"
      type: single_value
      model: personal_data_dashboard
      explore: youtube_activity
      fields: [youtube_activity.unique_activities]
      limit: 1
      custom_color_enabled: true
      custom_color: "#4CAF50"
      single_value_title: "Unique"
      value_format: "#,##0"
      row: 0
      col: 8
      width: 4
      height: 3

    - name: avg_url_depth
      title: "Avg URL Depth"
      type: single_value
      model: personal_data_dashboard
      explore: youtube_activity
      fields: [youtube_activity.avg_url_depth]
      limit: 1
      custom_color_enabled: true
      custom_color: "#FF9800"
      single_value_title: "Depth"
      value_format: "0.0"
      row: 0
      col: 12
      width: 4
      height: 3

  # ===========================================================================
  # ROW 2: ACTIVITY TRENDS
  # ===========================================================================

    - name: activity_by_week
      title: "How is my digital activity trending?"
      type: looker_line
      model: personal_data_dashboard
      explore: youtube_activity
      fields: [youtube_activity.activity_week, youtube_activity.count]
      fill_fields: [youtube_activity.activity_week]
      sorts: [youtube_activity.activity_week]
      limit: 52
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      show_y_axis_labels: true
      show_y_axis_ticks: true
      show_x_axis_label: true
      show_x_axis_ticks: true
      y_axis_scale_mode: linear
      x_axis_reversed: false
      y_axis_reversed: false
      plot_size_by_field: false
      trellis: ''
      stacking: ''
      legend_position: center
      point_style: circle
      show_value_labels: false
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      show_null_points: false
      interpolation: linear
      series_colors:
        youtube_activity.count: "#FF0000"
      row: 3
      col: 0
      width: 12
      height: 8

    - name: activity_by_source
      title: "Activity by source"
      type: looker_pie
      model: personal_data_dashboard
      explore: youtube_activity
      fields: [youtube_activity.source_system, youtube_activity.count]
      sorts: [youtube_activity.count desc]
      limit: 10
      value_labels: legend
      label_type: labPer
      inner_radius: 50
      color_application:
        collection_id: material
        palette_id: material-categorical-0
      series_colors: {}
      row: 3
      col: 12
      width: 12
      height: 8

  # ===========================================================================
  # ROW 3: TIME OF DAY PATTERNS
  # ===========================================================================

    - name: activity_by_hour
      title: "Activity by hour of day"
      type: looker_column
      model: personal_data_dashboard
      explore: youtube_activity
      fields: [youtube_activity.activity_at_hour_of_day, youtube_activity.count]
      fill_fields: [youtube_activity.activity_at_hour_of_day]
      sorts: [youtube_activity.activity_at_hour_of_day]
      limit: 24
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      show_y_axis_labels: true
      show_y_axis_ticks: true
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
      series_colors:
        youtube_activity.count: "#FF0000"
      row: 11
      col: 0
      width: 12
      height: 8

    - name: activity_by_day_of_week
      title: "Activity by day of week"
      type: looker_column
      model: personal_data_dashboard
      explore: youtube_activity
      fields: [youtube_activity.activity_at_day_of_week, youtube_activity.count]
      fill_fields: [youtube_activity.activity_at_day_of_week]
      sorts: [youtube_activity.activity_at_day_of_week]
      limit: 7
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      show_y_axis_labels: true
      show_y_axis_ticks: true
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
      series_colors:
        youtube_activity.count: "#2196F3"
      row: 11
      col: 12
      width: 12
      height: 8

  # ===========================================================================
  # ROW 4: TOP DOMAINS
  # ===========================================================================

    - name: top_domains
      title: "Top Domains"
      type: looker_grid
      model: personal_data_dashboard
      explore: youtube_activity
      fields: [youtube_activity.domain, youtube_activity.count, youtube_activity.unique_activities]
      sorts: [youtube_activity.count desc]
      limit: 20
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
      conditional_formatting:
        - type: along a scale...
          value:
          background_color: "#FF0000"
          font_color:
          color_application:
            collection_id: material
            palette_id: material-sequential-0
          bold: false
          italic: false
          strikethrough: false
          fields: [youtube_activity.count]
      row: 19
      col: 0
      width: 12
      height: 8

    - name: top_activities
      title: "Recent Activities"
      type: looker_grid
      model: personal_data_dashboard
      explore: youtube_activity
      fields: [youtube_activity.activity_date, youtube_activity.activity_type, youtube_activity.activity_title, youtube_activity.domain]
      sorts: [youtube_activity.activity_date desc]
      limit: 20
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
      row: 19
      col: 12
      width: 12
      height: 8

  # ===========================================================================
  # ROW 5: MONTHLY TRENDS
  # ===========================================================================

    - name: monthly_activity
      title: "Monthly Activity Trend"
      type: looker_area
      model: personal_data_dashboard
      explore: youtube_activity
      fields: [youtube_activity.activity_month, youtube_activity.count, youtube_activity.unique_domains]
      fill_fields: [youtube_activity.activity_month]
      sorts: [youtube_activity.activity_month]
      limit: 24
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      show_y_axis_labels: true
      show_y_axis_ticks: true
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
      show_null_points: false
      interpolation: linear
      series_colors:
        youtube_activity.count: "#FF0000"
        youtube_activity.unique_domains: "#2196F3"
      y_axes:
        - label: ''
          orientation: left
          series:
            - id: youtube_activity.count
              name: Activity Count
              axisId: youtube_activity.count
          showLabels: true
          showValues: true
          unpinAxis: false
          tickDensity: default
          type: linear
        - label: ''
          orientation: right
          series:
            - id: youtube_activity.unique_domains
              name: Unique Domains
              axisId: youtube_activity.unique_domains
          showLabels: true
          showValues: true
          unpinAxis: false
          tickDensity: default
          type: linear
      row: 27
      col: 0
      width: 24
      height: 8
