# =============================================================================
# FINANCIAL DASHBOARD
# Track spending patterns, category breakdowns, and account health
# =============================================================================

- dashboard: pdd_financial
  title: "Financial"
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "Track spending patterns, category breakdowns, merchant-specific spending, and account health"

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
      model: personal_data_dashboard
      explore: transactions
      field: transactions.transaction_date

  elements:
    # =========================================================================
    # ROW 1: KPI TILES
    # =========================================================================

    - title: "Monthly Spend"
      name: monthly_spend_kpi
      model: personal_data_dashboard
      explore: monthly_spending
      type: single_value
      fields: [monthly_spending.month_start_month, monthly_spending.total_spending, monthly_spending.mom_spending_change_pct]
      sorts: [monthly_spending.month_start_month desc]
      limit: 1
      custom_color_enabled: true
      show_single_value_title: true
      single_value_title: "Monthly Spend"
      show_comparison: true
      comparison_type: change
      comparison_reverse_colors: true
      show_comparison_label: true
      comparison_label: "vs Previous Month"
      enable_conditional_formatting: false
      conditional_formatting_include_totals: false
      conditional_formatting_include_nulls: false
      row: 0
      col: 0
      width: 4
      height: 4

    - title: "Avg Monthly"
      name: avg_monthly_kpi
      model: personal_data_dashboard
      explore: monthly_spending
      type: single_value
      fields: [monthly_spending.avg_monthly_spending]
      filters:
        monthly_spending.month_start_month: "6 months"
      limit: 1
      custom_color_enabled: true
      show_single_value_title: true
      single_value_title: "Avg Monthly (6mo)"
      show_comparison: false
      enable_conditional_formatting: false
      row: 0
      col: 4
      width: 4
      height: 4

    - title: "Amazon Spend"
      name: amazon_spend_kpi
      model: personal_data_dashboard
      explore: transactions
      type: single_value
      fields: [transactions.total_spending]
      filters:
        transactions.source_system: "Amazon"
        transactions.transaction_month: "1 months"
      limit: 1
      custom_color_enabled: true
      show_single_value_title: true
      single_value_title: "Amazon This Month"
      show_comparison: false
      enable_conditional_formatting: false
      row: 0
      col: 8
      width: 4
      height: 4

    - title: "Uber Spend"
      name: uber_spend_kpi
      model: personal_data_dashboard
      explore: transactions
      type: single_value
      fields: [transactions.total_spending]
      filters:
        transactions.source_system: "Uber"
        transactions.transaction_month: "1 months"
      limit: 1
      custom_color_enabled: true
      show_single_value_title: true
      single_value_title: "Uber This Month"
      show_comparison: false
      enable_conditional_formatting: false
      row: 0
      col: 12
      width: 4
      height: 4

    - title: "Subscriptions"
      name: subscriptions_kpi
      model: personal_data_dashboard
      explore: transactions
      type: single_value
      fields: [transactions.total_spending]
      filters:
        transactions.category: "Subscriptions"
        transactions.transaction_month: "1 months"
      limit: 1
      custom_color_enabled: true
      show_single_value_title: true
      single_value_title: "Subscriptions"
      show_comparison: false
      enable_conditional_formatting: false
      row: 0
      col: 16
      width: 4
      height: 4

    - title: "Net Flow"
      name: net_flow_kpi
      model: personal_data_dashboard
      explore: monthly_spending
      type: single_value
      fields: [monthly_spending.month_start_month, monthly_spending.net_flow]
      sorts: [monthly_spending.month_start_month desc]
      limit: 1
      custom_color_enabled: true
      show_single_value_title: true
      single_value_title: "Net Flow (This Month)"
      show_comparison: false
      enable_conditional_formatting: true
      conditional_formatting:
        - type: greater than
          value: 0
          background_color: "#72D16D"
          font_color:
          color_application:
            collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
            palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab
        - type: less than
          value: 0
          background_color: "#E57947"
          font_color:
          color_application:
            collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
            palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab
      conditional_formatting_include_totals: false
      conditional_formatting_include_nulls: false
      row: 0
      col: 20
      width: 4
      height: 4

    # =========================================================================
    # ROW 2: TREND AND CATEGORY CHARTS
    # =========================================================================

    - title: "How is my spending trending month over month?"
      name: monthly_spending_trend
      model: personal_data_dashboard
      explore: monthly_spending
      type: looker_area
      fields: [monthly_spending.month_start_month, monthly_spending.total_spending]
      fill_fields: [monthly_spending.month_start_month]
      sorts: [monthly_spending.month_start_month]
      limit: 24
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
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      color_application:
        collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
        palette_id: 5d189dfc-4f46-46f3-822b-bfb0b61777b1
        options:
          steps: 5
      series_colors:
        monthly_spending.total_spending: "#1A73E8"
      listen:
        date_range: monthly_spending.month_start_date
      row: 4
      col: 0
      width: 12
      height: 8

    - title: "Where is my money going?"
      name: spending_by_category
      model: personal_data_dashboard
      explore: transactions
      type: looker_pie
      fields: [transactions.category, transactions.total_spending]
      sorts: [transactions.total_spending desc]
      limit: 10
      value_labels: legend
      label_type: labPer
      inner_radius: 50
      color_application:
        collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
        palette_id: 5d189dfc-4f46-46f3-822b-bfb0b61777b1
        options:
          steps: 5
      series_colors: {}
      show_value_labels: true
      font_size: 12
      listen:
        date_range: transactions.transaction_date
      row: 4
      col: 12
      width: 12
      height: 8

    # =========================================================================
    # ROW 3: AMAZON, TRANSACTIONS, AND RECURRING
    # =========================================================================

    - title: "Amazon spending trend"
      name: amazon_spending_trend
      model: personal_data_dashboard
      explore: transactions
      type: looker_column
      fields: [transactions.transaction_month, transactions.total_spending]
      fill_fields: [transactions.transaction_month]
      filters:
        transactions.source_system: "Amazon"
      sorts: [transactions.transaction_month]
      limit: 12
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
      color_application:
        collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
        palette_id: 5d189dfc-4f46-46f3-822b-bfb0b61777b1
        options:
          steps: 5
      series_colors:
        transactions.total_spending: "#FF9800"
      row: 12
      col: 0
      width: 8
      height: 8

    - title: "Recent transactions"
      name: recent_transactions
      model: personal_data_dashboard
      explore: transactions
      type: looker_grid
      fields: [transactions.transaction_date, transactions.merchant_name, transactions.category, transactions.amount]
      sorts: [transactions.transaction_date desc]
      limit: 10
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
      conditional_formatting:
        - type: along a scale...
          value:
          background_color: "#1A73E8"
          font_color:
          color_application:
            collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
            palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab
            options:
              constraints:
                min:
                  type: minimum
                mid:
                  type: number
                  value: 0
                max:
                  type: maximum
              mirror: true
              reverse: false
              stepped: false
          bold: false
          italic: false
          strikethrough: false
          fields: [transactions.amount]
      conditional_formatting_include_totals: false
      conditional_formatting_include_nulls: false
      listen:
        date_range: transactions.transaction_date
      row: 12
      col: 8
      width: 8
      height: 8

    - title: "Top merchants"
      name: top_merchants
      model: personal_data_dashboard
      explore: transactions
      type: looker_grid
      fields: [transactions.merchant_name, transactions.total_spending, transactions.count]
      sorts: [transactions.total_spending desc]
      limit: 10
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
      conditional_formatting:
        - type: along a scale...
          value:
          background_color: "#1A73E8"
          font_color:
          color_application:
            collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
            palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab
          bold: false
          italic: false
          strikethrough: false
          fields: [transactions.total_spending]
      conditional_formatting_include_totals: false
      conditional_formatting_include_nulls: false
      listen:
        date_range: transactions.transaction_date
      row: 12
      col: 16
      width: 8
      height: 8
