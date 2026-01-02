# =============================================================================
# CROSS-DOMAIN INSIGHTS DASHBOARD
# Reveal correlations and insights across different life domains
# =============================================================================

- dashboard: cross_domain_insights
  title: "Cross-Domain Insights"
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: "Reveal correlations and insights across different life domains - health, productivity, and spending"

  elements:

  # ===========================================================================
  # ROW 1: CORRELATION KPI TILES
  # ===========================================================================

    - name: sleep_productivity_corr
      title: "Sleep vs Productivity"
      type: single_value
      model: personal_data_dashboard
      explore: cross_domain_correlations
      fields: [agg_cross_domain_correlations.sleep_vs_productivity_corr]
      limit: 1
      custom_color_enabled: true
      custom_color: "#7B68EE"
      single_value_title: "Correlation"
      value_format: "0.000"
      row: 0
      col: 0
      width: 4
      height: 3

    - name: sleep_productivity_strength
      title: "Sleep-Productivity Strength"
      type: single_value
      model: personal_data_dashboard
      explore: cross_domain_correlations
      fields: [agg_cross_domain_correlations.sleep_vs_productivity_strength]
      limit: 1
      custom_color_enabled: true
      custom_color: "#4CAF50"
      single_value_title: "Strength"
      row: 0
      col: 4
      width: 4
      height: 3

    - name: exercise_productivity_corr
      title: "Exercise vs Productivity"
      type: single_value
      model: personal_data_dashboard
      explore: cross_domain_correlations
      fields: [agg_cross_domain_correlations.exercise_vs_productivity_corr]
      limit: 1
      custom_color_enabled: true
      custom_color: "#FF6B6B"
      single_value_title: "Correlation"
      value_format: "0.000"
      row: 0
      col: 8
      width: 4
      height: 3

    - name: steps_spending_corr
      title: "Steps vs Spending"
      type: single_value
      model: personal_data_dashboard
      explore: cross_domain_correlations
      fields: [agg_cross_domain_correlations.steps_vs_spending_corr]
      limit: 1
      custom_color_enabled: true
      custom_color: "#2196F3"
      single_value_title: "Correlation"
      value_format: "0.000"
      row: 0
      col: 12
      width: 4
      height: 3

    - name: steps_spending_strength
      title: "Steps-Spending Strength"
      type: single_value
      model: personal_data_dashboard
      explore: cross_domain_correlations
      fields: [agg_cross_domain_correlations.steps_vs_spending_strength]
      limit: 1
      custom_color_enabled: true
      custom_color: "#FF9800"
      single_value_title: "Strength"
      row: 0
      col: 16
      width: 4
      height: 3

    - name: sample_size
      title: "Sample Size"
      type: single_value
      model: personal_data_dashboard
      explore: cross_domain_correlations
      fields: [agg_cross_domain_correlations.sample_size]
      limit: 1
      custom_color_enabled: true
      custom_color: "#607D8B"
      single_value_title: "Days Analyzed"
      value_format: "#,##0"
      row: 0
      col: 20
      width: 4
      height: 3

  # ===========================================================================
  # ROW 2: MORE CORRELATIONS
  # ===========================================================================

    - name: sleep_discretionary_corr
      title: "Sleep vs Discretionary Spending"
      type: single_value
      model: personal_data_dashboard
      explore: cross_domain_correlations
      fields: [agg_cross_domain_correlations.sleep_vs_discretionary_corr]
      limit: 1
      custom_color_enabled: true
      custom_color: "#9C27B0"
      single_value_title: "Correlation"
      value_format: "0.000"
      row: 3
      col: 0
      width: 4
      height: 3

    - name: workouts_food_corr
      title: "Workouts vs Food Spending"
      type: single_value
      model: personal_data_dashboard
      explore: cross_domain_correlations
      fields: [agg_cross_domain_correlations.workouts_vs_food_corr]
      limit: 1
      custom_color_enabled: true
      custom_color: "#00BCD4"
      single_value_title: "Correlation"
      value_format: "0.000"
      row: 3
      col: 4
      width: 4
      height: 3

    - name: steps_screen_time_corr
      title: "Steps vs Screen Time"
      type: single_value
      model: personal_data_dashboard
      explore: cross_domain_correlations
      fields: [agg_cross_domain_correlations.steps_vs_screen_time_corr]
      limit: 1
      custom_color_enabled: true
      custom_color: "#E91E63"
      single_value_title: "Correlation"
      value_format: "0.000"
      row: 3
      col: 8
      width: 4
      height: 3

    - name: spending_screen_time_corr
      title: "Spending vs Screen Time"
      type: single_value
      model: personal_data_dashboard
      explore: cross_domain_correlations
      fields: [agg_cross_domain_correlations.spending_vs_screen_time_corr]
      limit: 1
      custom_color_enabled: true
      custom_color: "#795548"
      single_value_title: "Correlation"
      value_format: "0.000"
      row: 3
      col: 12
      width: 4
      height: 3

    - name: entertainment_discretionary_corr
      title: "Entertainment vs Discretionary"
      type: single_value
      model: personal_data_dashboard
      explore: cross_domain_correlations
      fields: [agg_cross_domain_correlations.entertainment_vs_discretionary_corr]
      limit: 1
      custom_color_enabled: true
      custom_color: "#FF5722"
      single_value_title: "Correlation"
      value_format: "0.000"
      row: 3
      col: 16
      width: 4
      height: 3

    - name: exercise_spending_corr
      title: "Exercise vs Spending"
      type: single_value
      model: personal_data_dashboard
      explore: cross_domain_correlations
      fields: [agg_cross_domain_correlations.exercise_vs_spending_corr]
      limit: 1
      custom_color_enabled: true
      custom_color: "#3F51B5"
      single_value_title: "Correlation"
      value_format: "0.000"
      row: 3
      col: 20
      width: 4
      height: 3

  # ===========================================================================
  # ROW 3: LIFE PHASE COMPARISON
  # ===========================================================================

    - name: life_phase_comparison
      title: "How did the pandemic change my patterns?"
      type: looker_grid
      model: personal_data_dashboard
      explore: life_phase_metrics
      fields: [agg_life_phase_metrics.life_phase, agg_life_phase_metrics.avg_daily_steps, agg_life_phase_metrics.avg_daily_exercise_minutes, agg_life_phase_metrics.avg_daily_sleep_hours, agg_life_phase_metrics.avg_daily_spending, agg_life_phase_metrics.avg_productivity_score, agg_life_phase_metrics.avg_daily_screen_hours]
      sorts: [agg_life_phase_metrics.life_phase]
      limit: 5
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
      header_font_size: '14'
      rows_font_size: '14'
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
          fields: [agg_life_phase_metrics.avg_daily_steps]
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
          fields: [agg_life_phase_metrics.avg_productivity_score]
      row: 6
      col: 0
      width: 24
      height: 6

  # ===========================================================================
  # ROW 4: LIFE PHASE METRICS BREAKDOWN
  # ===========================================================================

    - name: steps_by_life_phase
      title: "Daily Steps by Life Phase"
      type: looker_column
      model: personal_data_dashboard
      explore: life_phase_metrics
      fields: [agg_life_phase_metrics.life_phase, agg_life_phase_metrics.avg_steps_measure]
      sorts: [agg_life_phase_metrics.life_phase]
      limit: 5
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
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      series_colors:
        agg_life_phase_metrics.avg_steps_measure: "#4CAF50"
      row: 12
      col: 0
      width: 8
      height: 8

    - name: spending_by_life_phase
      title: "Daily Spending by Life Phase"
      type: looker_column
      model: personal_data_dashboard
      explore: life_phase_metrics
      fields: [agg_life_phase_metrics.life_phase, agg_life_phase_metrics.avg_spending_measure]
      sorts: [agg_life_phase_metrics.life_phase]
      limit: 5
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
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      series_colors:
        agg_life_phase_metrics.avg_spending_measure: "#E91E63"
      row: 12
      col: 8
      width: 8
      height: 8

    - name: productivity_by_life_phase
      title: "Productivity Score by Life Phase"
      type: looker_column
      model: personal_data_dashboard
      explore: life_phase_metrics
      fields: [agg_life_phase_metrics.life_phase, agg_life_phase_metrics.avg_productivity_measure]
      sorts: [agg_life_phase_metrics.life_phase]
      limit: 5
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
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      series_colors:
        agg_life_phase_metrics.avg_productivity_measure: "#2196F3"
      row: 12
      col: 16
      width: 8
      height: 8

  # ===========================================================================
  # ROW 5: DETAILED LIFE PHASE BREAKDOWN
  # ===========================================================================

    - name: life_phase_health
      title: "Health Metrics by Life Phase"
      type: looker_grid
      model: personal_data_dashboard
      explore: life_phase_metrics
      fields: [agg_life_phase_metrics.life_phase, agg_life_phase_metrics.avg_daily_steps, agg_life_phase_metrics.avg_daily_exercise_minutes, agg_life_phase_metrics.avg_daily_sleep_hours, agg_life_phase_metrics.avg_weight_kg, agg_life_phase_metrics.avg_heart_rate, agg_life_phase_metrics.health_days]
      sorts: [agg_life_phase_metrics.life_phase]
      limit: 5
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
          fields: [agg_life_phase_metrics.avg_daily_steps]
      row: 20
      col: 0
      width: 12
      height: 6

    - name: life_phase_spending
      title: "Spending Metrics by Life Phase"
      type: looker_grid
      model: personal_data_dashboard
      explore: life_phase_metrics
      fields: [agg_life_phase_metrics.life_phase, agg_life_phase_metrics.avg_daily_spending, agg_life_phase_metrics.avg_daily_food_spending, agg_life_phase_metrics.avg_daily_transport_spending, agg_life_phase_metrics.avg_daily_entertainment_spending, agg_life_phase_metrics.essential_spending_pct, agg_life_phase_metrics.spending_days]
      sorts: [agg_life_phase_metrics.life_phase]
      limit: 5
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
      conditional_formatting:
        - type: along a scale...
          value:
          background_color: "#E91E63"
          font_color:
          color_application:
            collection_id: material
            palette_id: material-sequential-0
            options:
              steps: 5
              reverse: true
          bold: false
          italic: false
          strikethrough: false
          fields: [agg_life_phase_metrics.avg_daily_spending]
      row: 20
      col: 12
      width: 12
      height: 6

  # ===========================================================================
  # ROW 6: PRODUCTIVITY DETAILS
  # ===========================================================================

    - name: life_phase_productivity
      title: "Productivity Metrics by Life Phase"
      type: looker_grid
      model: personal_data_dashboard
      explore: life_phase_metrics
      fields: [agg_life_phase_metrics.life_phase, agg_life_phase_metrics.avg_daily_screen_minutes, agg_life_phase_metrics.avg_productivity_score, agg_life_phase_metrics.avg_work_minutes, agg_life_phase_metrics.avg_leisure_minutes, agg_life_phase_metrics.work_screen_time_pct, agg_life_phase_metrics.productivity_days]
      sorts: [agg_life_phase_metrics.life_phase]
      limit: 5
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
          fields: [agg_life_phase_metrics.avg_productivity_score]
      row: 26
      col: 0
      width: 24
      height: 6
