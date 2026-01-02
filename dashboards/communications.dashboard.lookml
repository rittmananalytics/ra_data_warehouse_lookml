# =============================================================================
# COMMUNICATIONS DASHBOARD
# Analyze email patterns, volume, and communication trends
# =============================================================================

- dashboard: communications
  title: "Communications"
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: "Analyze email patterns, platform usage distribution, and communication frequency"

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
      explore: emails
      field: emails.communication_date

  elements:

  # ===========================================================================
  # ROW 1: KPI TILES
  # ===========================================================================

    - name: total_emails
      title: "Total Emails"
      type: single_value
      model: personal_data_dashboard
      explore: emails
      fields: [emails.count]
      limit: 1
      custom_color_enabled: true
      custom_color: "#2196F3"
      single_value_title: "Emails"
      value_format: "#,##0"
      row: 0
      col: 0
      width: 4
      height: 3

    - name: emails_received
      title: "Emails Received"
      type: single_value
      model: personal_data_dashboard
      explore: emails
      fields: [emails.emails_received]
      limit: 1
      custom_color_enabled: true
      custom_color: "#4CAF50"
      single_value_title: "Received"
      value_format: "#,##0"
      row: 0
      col: 4
      width: 4
      height: 3

    - name: emails_sent
      title: "Emails Sent"
      type: single_value
      model: personal_data_dashboard
      explore: emails
      fields: [emails.emails_sent]
      limit: 1
      custom_color_enabled: true
      custom_color: "#FF9800"
      single_value_title: "Sent"
      value_format: "#,##0"
      row: 0
      col: 8
      width: 4
      height: 3

    - name: receive_send_ratio
      title: "Receive/Send Ratio"
      type: single_value
      model: personal_data_dashboard
      explore: emails
      fields: [emails.receive_send_ratio]
      limit: 1
      custom_color_enabled: true
      custom_color: "#9C27B0"
      single_value_title: "Ratio"
      value_format: "0.0"
      row: 0
      col: 12
      width: 4
      height: 3

    - name: total_messages
      title: "Total Messages"
      type: single_value
      model: personal_data_dashboard
      explore: messages
      fields: [messages.count]
      limit: 1
      custom_color_enabled: true
      custom_color: "#00BCD4"
      single_value_title: "Messages"
      value_format: "#,##0"
      row: 0
      col: 16
      width: 4
      height: 3

    - name: avg_subject_length
      title: "Avg Subject Length"
      type: single_value
      model: personal_data_dashboard
      explore: emails
      fields: [emails.avg_subject_length]
      limit: 1
      custom_color_enabled: true
      custom_color: "#607D8B"
      single_value_title: "Characters"
      value_format: "#,##0"
      row: 0
      col: 20
      width: 4
      height: 3

  # ===========================================================================
  # ROW 2: EMAIL TRENDS
  # ===========================================================================

    - name: emails_by_day_of_week
      title: "What's my daily email pattern?"
      type: looker_column
      model: personal_data_dashboard
      explore: emails
      fields: [emails.communication_at_day_of_week, emails.emails_received, emails.emails_sent]
      fill_fields: [emails.communication_at_day_of_week]
      sorts: [emails.communication_at_day_of_week]
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
        emails.emails_received: "#4CAF50"
        emails.emails_sent: "#FF9800"
      row: 3
      col: 0
      width: 12
      height: 8

    - name: email_volume_trend
      title: "How is my communication volume trending?"
      type: looker_line
      model: personal_data_dashboard
      explore: emails
      fields: [emails.communication_week, emails.count]
      fill_fields: [emails.communication_week]
      sorts: [emails.communication_week]
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
        emails.count: "#2196F3"
      row: 3
      col: 12
      width: 12
      height: 8

  # ===========================================================================
  # ROW 3: SOURCE & HOUR BREAKDOWN
  # ===========================================================================

    - name: emails_by_source
      title: "Platform distribution"
      type: looker_pie
      model: personal_data_dashboard
      explore: emails
      fields: [emails.source_system, emails.count]
      sorts: [emails.count desc]
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

    - name: emails_by_hour
      title: "Email activity by hour of day"
      type: looker_column
      model: personal_data_dashboard
      explore: emails
      fields: [emails.communication_at_hour_of_day, emails.count]
      fill_fields: [emails.communication_at_hour_of_day]
      sorts: [emails.communication_at_hour_of_day]
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
        emails.count: "#2196F3"
      row: 11
      col: 8
      width: 16
      height: 8

  # ===========================================================================
  # ROW 4: MONTHLY TREND
  # ===========================================================================

    - name: monthly_email_volume
      title: "Monthly Email Volume"
      type: looker_area
      model: personal_data_dashboard
      explore: emails
      fields: [emails.communication_month, emails.emails_received, emails.emails_sent]
      fill_fields: [emails.communication_month]
      sorts: [emails.communication_month]
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
        emails.emails_received: "#4CAF50"
        emails.emails_sent: "#FF9800"
      row: 19
      col: 0
      width: 24
      height: 8

  # ===========================================================================
  # ROW 5: EMAIL FOLDER BREAKDOWN
  # ===========================================================================

    - name: emails_by_folder
      title: "Emails by Folder"
      type: looker_grid
      model: personal_data_dashboard
      explore: emails
      fields: [emails.folder, emails.count, emails.emails_received, emails.emails_sent]
      sorts: [emails.count desc]
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
          fields: [emails.count]
      row: 27
      col: 0
      width: 24
      height: 8
