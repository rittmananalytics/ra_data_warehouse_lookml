# =============================================================================
# HEALTH & WELLBEING DASHBOARD
# Track physical health metrics including weight, sleep, exercise, and vitals
# =============================================================================

- dashboard: health_wellbeing
  title: "Health & Wellbeing"
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: "Track physical health metrics including weight management, sleep quality, exercise habits, and vital signs"

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
      explore: monthly_health
      field: month_start_date

  elements:

  # ===========================================================================
  # ROW 1: KPI TILES
  # ===========================================================================

    - name: current_weight
      title: "Current Weight"
      type: single_value
      model: personal_data_dashboard
      explore: monthly_health
      fields: [monthly_health.avg_weight_measure]
      limit: 1
      custom_color_enabled: true
      custom_color: "#5A6B7C"
      single_value_title: "Avg Weight (kg)"
      value_format: "0.0"
      row: 0
      col: 0
      width: 4
      height: 3

    - name: avg_sleep
      title: "Avg Sleep"
      type: single_value
      model: personal_data_dashboard
      explore: monthly_health
      fields: [monthly_health.avg_sleep_measure]
      limit: 1
      custom_color_enabled: true
      custom_color: "#7B68EE"
      single_value_title: "Sleep (hours)"
      value_format: "0.0"
      row: 0
      col: 4
      width: 4
      height: 3

    - name: total_workouts
      title: "Total Workouts"
      type: single_value
      model: personal_data_dashboard
      explore: monthly_health
      fields: [monthly_health.sum_workouts]
      limit: 1
      custom_color_enabled: true
      custom_color: "#FF6B6B"
      single_value_title: "Workouts"
      value_format: "#,##0"
      row: 0
      col: 8
      width: 4
      height: 3

    - name: total_steps
      title: "Total Steps"
      type: single_value
      model: personal_data_dashboard
      explore: monthly_health
      fields: [monthly_health.sum_steps]
      limit: 1
      custom_color_enabled: true
      custom_color: "#4CAF50"
      single_value_title: "Total Steps"
      value_format: "#,##0"
      row: 0
      col: 12
      width: 4
      height: 3

    - name: avg_daily_steps
      title: "Avg Daily Steps"
      type: single_value
      model: personal_data_dashboard
      explore: monthly_health
      fields: [monthly_health.avg_steps_measure]
      limit: 1
      custom_color_enabled: true
      custom_color: "#2196F3"
      single_value_title: "Daily Steps"
      value_format: "#,##0"
      row: 0
      col: 16
      width: 4
      height: 3

    - name: month_count
      title: "Months Tracked"
      type: single_value
      model: personal_data_dashboard
      explore: monthly_health
      fields: [monthly_health.count]
      limit: 1
      custom_color_enabled: true
      custom_color: "#9C27B0"
      single_value_title: "Months"
      value_format: "#,##0"
      row: 0
      col: 20
      width: 4
      height: 3

  # ===========================================================================
  # ROW 2: TREND CHARTS
  # ===========================================================================

    - name: weight_trend
      title: "How is my weight trending over time?"
      type: looker_line
      model: personal_data_dashboard
      explore: monthly_health
      fields: [monthly_health.month_start_month, monthly_health.avg_weight_measure]
      fill_fields: [monthly_health.month_start_month]
      sorts: [monthly_health.month_start_month]
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
      point_style: circle
      show_value_labels: false
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      show_null_points: false
      interpolation: linear
      series_colors:
        monthly_health.avg_weight_measure: "#5A6B7C"
      row: 3
      col: 0
      width: 12
      height: 8

    - name: sleep_trend
      title: "What does my sleep look like over time?"
      type: looker_line
      model: personal_data_dashboard
      explore: monthly_health
      fields: [monthly_health.month_start_month, monthly_health.avg_sleep_measure]
      fill_fields: [monthly_health.month_start_month]
      sorts: [monthly_health.month_start_month]
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
      point_style: circle
      show_value_labels: false
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      show_null_points: false
      interpolation: linear
      series_colors:
        monthly_health.avg_sleep_measure: "#7B68EE"
      row: 3
      col: 12
      width: 12
      height: 8

  # ===========================================================================
  # ROW 3: ACTIVITY ANALYSIS
  # ===========================================================================

    - name: steps_by_month
      title: "Monthly step activity"
      type: looker_area
      model: personal_data_dashboard
      explore: monthly_health
      fields: [monthly_health.month_start_month, monthly_health.sum_steps]
      fill_fields: [monthly_health.month_start_month]
      sorts: [monthly_health.month_start_month]
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
        monthly_health.sum_steps: "#4CAF50"
      row: 11
      col: 0
      width: 12
      height: 8

    - name: workout_summary
      title: "What's my workout distribution?"
      type: looker_grid
      model: personal_data_dashboard
      explore: workouts
      fields: [dim_workout_type.workout_type, workouts.count, workouts.total_duration_minutes, workouts.avg_duration_minutes, workouts.total_distance_km]
      sorts: [workouts.count desc]
      limit: 10
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
          fields: [workouts.count]
      row: 11
      col: 12
      width: 12
      height: 8

  # ===========================================================================
  # ROW 4: DETAILED HEALTH METRICS
  # ===========================================================================

    - name: health_metrics_table
      title: "Monthly Health Summary"
      type: looker_grid
      model: personal_data_dashboard
      explore: monthly_health
      fields: [monthly_health.year_month, monthly_health.avg_weight_kg, monthly_health.avg_daily_sleep_hours, monthly_health.avg_daily_steps, monthly_health.total_workouts, monthly_health.days_with_data]
      sorts: [monthly_health.year_month desc]
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
          fields: [monthly_health.avg_daily_steps]
      row: 19
      col: 0
      width: 24
      height: 8
