# =============================================================================
# PRODUCTIVITY DASHBOARD
# Monitor work productivity patterns, focus time, and application usage
# =============================================================================

- dashboard: productivity
  title: "Productivity"
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: "Monitor work productivity patterns, focus time, application usage, and distraction management"

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
      explore: weekly_productivity
      field: week_start_date

  elements:

  # ===========================================================================
  # ROW 1: KPI TILES
  # ===========================================================================

    - name: avg_screen_hours
      title: "Avg Daily Screen Time"
      type: single_value
      model: personal_data_dashboard
      explore: weekly_productivity
      fields: [weekly_productivity.avg_weekly_screen_hours]
      limit: 1
      custom_color_enabled: true
      custom_color: "#2196F3"
      single_value_title: "Hours/Day"
      value_format: "0.0"
      row: 0
      col: 0
      width: 4
      height: 3

    - name: productivity_score
      title: "Productivity Score"
      type: single_value
      model: personal_data_dashboard
      explore: weekly_productivity
      fields: [weekly_productivity.avg_productivity_score_measure]
      limit: 1
      custom_color_enabled: true
      custom_color: "#4CAF50"
      single_value_title: "Avg Score"
      value_format: "0.00"
      row: 0
      col: 4
      width: 4
      height: 3

    - name: productive_time
      title: "Productive Time"
      type: single_value
      model: personal_data_dashboard
      explore: weekly_productivity
      fields: [weekly_productivity.sum_productive_minutes]
      limit: 1
      custom_color_enabled: true
      custom_color: "#4CAF50"
      single_value_title: "Minutes"
      value_format: "#,##0"
      row: 0
      col: 8
      width: 4
      height: 3

    - name: distracted_time
      title: "Distracted Time"
      type: single_value
      model: personal_data_dashboard
      explore: weekly_productivity
      fields: [weekly_productivity.sum_distracted_minutes]
      limit: 1
      custom_color_enabled: true
      custom_color: "#FF6B6B"
      single_value_title: "Minutes"
      value_format: "#,##0"
      row: 0
      col: 12
      width: 4
      height: 3

    - name: total_screen_time
      title: "Total Screen Time"
      type: single_value
      model: personal_data_dashboard
      explore: weekly_productivity
      fields: [weekly_productivity.sum_screen_time]
      limit: 1
      custom_color_enabled: true
      custom_color: "#9C27B0"
      single_value_title: "Minutes"
      value_format: "#,##0"
      row: 0
      col: 16
      width: 4
      height: 3

    - name: weeks_tracked
      title: "Weeks Tracked"
      type: single_value
      model: personal_data_dashboard
      explore: weekly_productivity
      fields: [weekly_productivity.count]
      limit: 1
      custom_color_enabled: true
      custom_color: "#607D8B"
      single_value_title: "Weeks"
      value_format: "#,##0"
      row: 0
      col: 20
      width: 4
      height: 3

  # ===========================================================================
  # ROW 2: PRODUCTIVITY TRENDS
  # ===========================================================================

    - name: productivity_by_week
      title: "What's my weekly productivity trend?"
      type: looker_line
      model: personal_data_dashboard
      explore: weekly_productivity
      fields: [weekly_productivity.week_start_week, weekly_productivity.avg_productivity_score_measure]
      fill_fields: [weekly_productivity.week_start_week]
      sorts: [weekly_productivity.week_start_week]
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
        weekly_productivity.avg_productivity_score_measure: "#4CAF50"
      row: 3
      col: 0
      width: 12
      height: 8

    - name: screen_time_by_week
      title: "How is my screen time trending?"
      type: looker_area
      model: personal_data_dashboard
      explore: weekly_productivity
      fields: [weekly_productivity.week_start_week, weekly_productivity.avg_weekly_screen_hours]
      fill_fields: [weekly_productivity.week_start_week]
      sorts: [weekly_productivity.week_start_week]
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
      point_style: none
      show_value_labels: false
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      show_null_points: false
      interpolation: linear
      series_colors:
        weekly_productivity.avg_weekly_screen_hours: "#2196F3"
      row: 3
      col: 12
      width: 12
      height: 8

  # ===========================================================================
  # ROW 3: TIME BREAKDOWN
  # ===========================================================================

    - name: time_by_category
      title: "Where does my time go?"
      type: looker_pie
      model: personal_data_dashboard
      explore: application_usage
      fields: [dim_application.productivity_category, application_usage.total_duration_minutes]
      sorts: [application_usage.total_duration_minutes desc]
      limit: 10
      value_labels: legend
      label_type: labPer
      inner_radius: 50
      color_application:
        collection_id: material
        palette_id: material-categorical-0
      series_colors: {}
      row: 11
      col: 0
      width: 8
      height: 8

    - name: top_applications
      title: "Top applications by time spent"
      type: looker_grid
      model: personal_data_dashboard
      explore: application_usage
      fields: [dim_application.application_name, dim_application.productivity_category, application_usage.total_duration_minutes, application_usage.count]
      sorts: [application_usage.total_duration_minutes desc]
      limit: 15
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
          background_color: "#2196F3"
          font_color:
          color_application:
            collection_id: material
            palette_id: material-sequential-0
          bold: false
          italic: false
          strikethrough: false
          fields: [application_usage.total_duration_minutes]
      row: 11
      col: 8
      width: 16
      height: 8

  # ===========================================================================
  # ROW 4: WORK VS LEISURE
  # ===========================================================================

    - name: productive_vs_distracted
      title: "Productive vs Distracted Time by Week"
      type: looker_column
      model: personal_data_dashboard
      explore: weekly_productivity
      fields: [weekly_productivity.week_start_week, weekly_productivity.sum_productive_minutes, weekly_productivity.sum_distracted_minutes]
      fill_fields: [weekly_productivity.week_start_week]
      sorts: [weekly_productivity.week_start_week]
      limit: 26
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
      series_colors:
        weekly_productivity.sum_productive_minutes: "#4CAF50"
        weekly_productivity.sum_distracted_minutes: "#FF6B6B"
      row: 19
      col: 0
      width: 24
      height: 8

  # ===========================================================================
  # ROW 5: WEEKLY SUMMARY TABLE
  # ===========================================================================

    - name: weekly_summary
      title: "Weekly Productivity Summary"
      type: looker_grid
      model: personal_data_dashboard
      explore: weekly_productivity
      fields: [weekly_productivity.year_week, weekly_productivity.total_screen_hours, weekly_productivity.avg_daily_productivity_score, weekly_productivity.productive_pct, weekly_productivity.work_pct, weekly_productivity.leisure_pct, weekly_productivity.days_with_data]
      sorts: [weekly_productivity.year_week desc]
      limit: 12
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
          background_color: "#4CAF50"
          font_color:
          color_application:
            collection_id: material
            palette_id: material-sequential-0
          bold: false
          italic: false
          strikethrough: false
          fields: [weekly_productivity.productive_pct]
      row: 27
      col: 0
      width: 24
      height: 8
