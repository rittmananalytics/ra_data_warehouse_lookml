# =============================================================================
# FINANCIAL DASHBOARD
# Track spending patterns, category breakdowns, and financial health
# =============================================================================

- dashboard: financial
  title: "Financial"
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: "Track spending patterns, category breakdowns, merchant-specific spending, and account health"

  filters:
    - name: date_range
      title: "Date Range"
      type: field_filter
      default_value: "12 months"
      allow_multiple_values: false
      required: false
      ui_config:
        type: relative_timeframes
        display: inline
      explore: monthly_spending
      field: month_start_date

  elements:

  # ===========================================================================
  # ROW 1: KPI TILES
  # ===========================================================================

    - name: total_spending
      title: "Total Spending"
      type: single_value
      model: personal_data_dashboard
      explore: monthly_spending
      fields: [monthly_spending.sum_spending]
      limit: 1
      custom_color_enabled: true
      custom_color: "#E91E63"
      single_value_title: "Total Spend"
      value_format: '"GBP "#,##0'
      row: 0
      col: 0
      width: 4
      height: 3

    - name: total_income
      title: "Total Income"
      type: single_value
      model: personal_data_dashboard
      explore: monthly_spending
      fields: [monthly_spending.sum_income]
      limit: 1
      custom_color_enabled: true
      custom_color: "#4CAF50"
      single_value_title: "Total Income"
      value_format: '"GBP "#,##0'
      row: 0
      col: 4
      width: 4
      height: 3

    - name: avg_monthly
      title: "Avg Monthly Spending"
      type: single_value
      model: personal_data_dashboard
      explore: monthly_spending
      fields: [monthly_spending.avg_monthly_spending]
      limit: 1
      custom_color_enabled: true
      custom_color: "#FF9800"
      single_value_title: "Monthly Avg"
      value_format: '"GBP "#,##0'
      row: 0
      col: 8
      width: 4
      height: 3

    - name: total_transactions
      title: "Total Transactions"
      type: single_value
      model: personal_data_dashboard
      explore: monthly_spending
      fields: [monthly_spending.sum_transactions]
      limit: 1
      custom_color_enabled: true
      custom_color: "#2196F3"
      single_value_title: "Transactions"
      value_format: "#,##0"
      row: 0
      col: 12
      width: 4
      height: 3

    - name: months_tracked
      title: "Months Tracked"
      type: single_value
      model: personal_data_dashboard
      explore: monthly_spending
      fields: [monthly_spending.count]
      limit: 1
      custom_color_enabled: true
      custom_color: "#607D8B"
      single_value_title: "Months"
      value_format: "#,##0"
      row: 0
      col: 16
      width: 4
      height: 3

    - name: avg_transaction
      title: "Avg Transaction"
      type: single_value
      model: personal_data_dashboard
      explore: transactions
      fields: [transactions.avg_transaction_amount]
      limit: 1
      custom_color_enabled: true
      custom_color: "#9C27B0"
      single_value_title: "Avg Amount"
      value_format: '"GBP "#,##0.00'
      row: 0
      col: 20
      width: 4
      height: 3

  # ===========================================================================
  # ROW 2: SPENDING TRENDS
  # ===========================================================================

    - name: spending_trend
      title: "How is my spending trending month over month?"
      type: looker_area
      model: personal_data_dashboard
      explore: monthly_spending
      fields: [monthly_spending.month_start_month, monthly_spending.total_spending]
      fill_fields: [monthly_spending.month_start_month]
      sorts: [monthly_spending.month_start_month]
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
        monthly_spending.total_spending: "#E91E63"
      row: 3
      col: 0
      width: 12
      height: 8

    - name: spending_by_category
      title: "Where is my money going?"
      type: looker_pie
      model: personal_data_dashboard
      explore: transactions
      fields: [dim_spending_category.category_name, transactions.total_spending]
      sorts: [transactions.total_spending desc]
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
  # ROW 3: ESSENTIAL VS DISCRETIONARY
  # ===========================================================================

    - name: essential_vs_discretionary
      title: "Essential vs Discretionary by Month"
      type: looker_column
      model: personal_data_dashboard
      explore: monthly_spending
      fields: [monthly_spending.month_start_month, monthly_spending.essential_spending, monthly_spending.discretionary_spending]
      fill_fields: [monthly_spending.month_start_month]
      sorts: [monthly_spending.month_start_month]
      limit: 12
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
      show_totals_labels: true
      show_silhouette: false
      totals_color: "#808080"
      series_colors:
        monthly_spending.essential_spending: "#607D8B"
        monthly_spending.discretionary_spending: "#FF9800"
      row: 11
      col: 0
      width: 12
      height: 8

    - name: top_merchants
      title: "Top Merchants by Spending"
      type: looker_grid
      model: personal_data_dashboard
      explore: transactions
      fields: [dim_merchant.merchant_name, dim_spending_category.category_name, transactions.total_spending, transactions.transaction_count]
      sorts: [transactions.total_spending desc]
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
          background_color: "#E91E63"
          font_color:
          color_application:
            collection_id: material
            palette_id: material-sequential-0
          bold: false
          italic: false
          strikethrough: false
          fields: [transactions.total_spending]
      row: 11
      col: 12
      width: 12
      height: 8

  # ===========================================================================
  # ROW 4: INCOME VS SPENDING & NET FLOW
  # ===========================================================================

    - name: income_vs_spending
      title: "Income vs Spending by Month"
      type: looker_column
      model: personal_data_dashboard
      explore: monthly_spending
      fields: [monthly_spending.month_start_month, monthly_spending.total_income, monthly_spending.total_spending]
      fill_fields: [monthly_spending.month_start_month]
      sorts: [monthly_spending.month_start_month]
      limit: 12
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
        monthly_spending.total_income: "#4CAF50"
        monthly_spending.total_spending: "#E91E63"
      row: 19
      col: 0
      width: 24
      height: 8

  # ===========================================================================
  # ROW 5: MONTHLY SUMMARY TABLE
  # ===========================================================================

    - name: monthly_summary
      title: "Monthly Financial Summary"
      type: looker_grid
      model: personal_data_dashboard
      explore: monthly_spending
      fields: [monthly_spending.year_month, monthly_spending.total_spending, monthly_spending.total_income, monthly_spending.net_flow, monthly_spending.savings_rate_pct, monthly_spending.essential_pct, monthly_spending.transaction_count]
      sorts: [monthly_spending.year_month desc]
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
        - type: greater than
          value: 0
          background_color: "#C8E6C9"
          font_color:
          color_application:
            collection_id: material
            palette_id: material-sequential-0
          bold: false
          italic: false
          strikethrough: false
          fields: [monthly_spending.net_flow]
        - type: less than
          value: 0
          background_color: "#FFCDD2"
          font_color:
          color_application:
            collection_id: material
            palette_id: material-sequential-0
          bold: false
          italic: false
          strikethrough: false
          fields: [monthly_spending.net_flow]
      row: 27
      col: 0
      width: 24
      height: 8
