---
# Consultant Performance Dashboard
# Purpose: Individual consultant-level revenue attribution analysis
# Based on specification: /docs/consultant-dashboard-specification.md
- dashboard: consultant_performance
  title: Consultant Performance
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "Individual consultant revenue attribution analysis, comparing performance against targets and breaking down revenue by project and client"
  preferred_slug: consultant-performance-dashboard

  filters:
    - name: consultant_name
      title: "Consultant"
      type: field_filter
      default_value: ''
      allow_multiple_values: false
      required: true
      ui_config:
        type: dropdown_menu
        display: inline
      model: analytics
      explore: companies_dim
      field: recognized_revenue_contact.contact_name

    - name: billing_year
      title: "Year"
      type: field_filter
      default_value: "this year"
      allow_multiple_values: true
      required: false
      ui_config:
        type: checkboxes
        display: inline
      model: analytics
      explore: companies_dim
      field: recognized_project_revenue.billing_month_year

  elements:
    # =============================================================================
    # ROW 1: KPI CARDS
    # =============================================================================

    # KPI 1: Total Revenue
    - title: "Total Revenue"
      name: total_revenue_kpi
      model: analytics
      explore: companies_dim
      type: single_value
      fields:
        - recognized_project_revenue.total_recognized_revenue_attributed_gbp
      filters: {}
      listen:
        consultant_name: recognized_revenue_contact.contact_name
        billing_year: recognized_project_revenue.billing_month_year
      row: 0
      col: 0
      width: 6
      height: 4
      custom_color_enabled: true
      custom_color: "#1A73E8"
      show_single_value_title: true
      single_value_title: "Total Revenue"
      show_comparison: false
      comparison_type: value
      comparison_reverse_colors: false
      show_comparison_label: true
      enable_conditional_formatting: false
      conditional_formatting_include_totals: false
      conditional_formatting_include_nulls: false

    # KPI 2: Revenue vs Target
    - title: "Revenue vs Target"
      name: revenue_vs_target_kpi
      model: analytics
      explore: companies_dim
      type: single_value
      fields:
        - recognized_project_revenue.total_recognized_revenue_attributed_gbp
        - team_revenue_targets.revenue_target
      filters: {}
      listen:
        consultant_name: recognized_revenue_contact.contact_name
        billing_year: recognized_project_revenue.billing_month_year
      dynamic_fields:
        - category: table_calculation
          expression: "${recognized_project_revenue.total_recognized_revenue_attributed_gbp}/${team_revenue_targets.revenue_target}"
          label: "% of Target"
          value_format:
          value_format_name: percent_0
          _kind_hint: measure
          table_calculation: pct_of_target
          _type_hint: number
      row: 0
      col: 6
      width: 6
      height: 4
      custom_color_enabled: true
      custom_color: "#1A73E8"
      show_single_value_title: true
      single_value_title: "% of Target Achieved"
      show_comparison: true
      comparison_type: value
      comparison_reverse_colors: false
      show_comparison_label: true
      comparison_label: "Target"
      enable_conditional_formatting: true
      conditional_formatting:
        - type: greater than or equal to
          value: 1
          background_color: "#7CB342"
          font_color:
          color_application:
            collection_id: google
            palette_id: google-sequential-0
          bold: false
          italic: false
          strikethrough: false
          fields:
        - type: less than
          value: 1
          background_color: "#EA8600"
          font_color:
          color_application:
            collection_id: google
            palette_id: google-sequential-0
          bold: false
          italic: false
          strikethrough: false
          fields:
      conditional_formatting_include_totals: false
      conditional_formatting_include_nulls: false
      hidden_fields:
        - recognized_project_revenue.total_recognized_revenue_attributed_gbp
        - team_revenue_targets.revenue_target

    # KPI 3: Total Hours Billed
    - title: "Hours Billed"
      name: hours_billed_kpi
      model: analytics
      explore: companies_dim
      type: single_value
      fields:
        - recognized_project_revenue.total_hours_billed
      filters: {}
      listen:
        consultant_name: recognized_revenue_contact.contact_name
        billing_year: recognized_project_revenue.billing_month_year
      row: 0
      col: 12
      width: 6
      height: 4
      custom_color_enabled: true
      custom_color: "#1A73E8"
      show_single_value_title: true
      single_value_title: "Total Hours Billed"
      show_comparison: false
      comparison_type: value
      comparison_reverse_colors: false
      show_comparison_label: true
      enable_conditional_formatting: false
      conditional_formatting_include_totals: false
      conditional_formatting_include_nulls: false

    # KPI 4: Active Projects Count
    - title: "Projects Worked"
      name: projects_count_kpi
      model: analytics
      explore: companies_dim
      type: single_value
      fields:
        - projects_delivered.count_timesheet_projects
      filters: {}
      listen:
        consultant_name: recognized_revenue_contact.contact_name
        billing_year: recognized_project_revenue.billing_month_year
      row: 0
      col: 18
      width: 6
      height: 4
      custom_color_enabled: true
      custom_color: "#1A73E8"
      show_single_value_title: true
      single_value_title: "Projects Worked"
      show_comparison: false
      comparison_type: value
      comparison_reverse_colors: false
      show_comparison_label: true
      enable_conditional_formatting: false
      conditional_formatting_include_totals: false
      conditional_formatting_include_nulls: false

    # =============================================================================
    # ROW 2: CHARTS
    # =============================================================================

    # Monthly Revenue Trend Line Chart
    - title: "Monthly Revenue Trend"
      name: monthly_revenue_trend
      model: analytics
      explore: companies_dim
      type: looker_line
      fields:
        - recognized_project_revenue.billing_month_month
        - recognized_project_revenue.total_recognized_revenue_attributed_gbp
        - team_revenue_targets.revenue_target
      filters: {}
      sorts:
        - recognized_project_revenue.billing_month_month
      listen:
        consultant_name: recognized_revenue_contact.contact_name
        billing_year: recognized_project_revenue.billing_month_year
      row: 4
      col: 0
      width: 12
      height: 8
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
      show_value_labels: false
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      show_null_points: false
      interpolation: linear
      color_application:
        collection_id: google
        palette_id: google-categorical-0
      series_colors:
        recognized_project_revenue.total_recognized_revenue_attributed_gbp: "#1A73E8"
        team_revenue_targets.revenue_target: "#E8710A"
      series_labels:
        recognized_project_revenue.total_recognized_revenue_attributed_gbp: "Revenue"
        team_revenue_targets.revenue_target: "Target"
      x_axis_datetime_label: "%b %Y"
      x_axis_zoom: true
      y_axis_zoom: true

    # Revenue by Project Bar Chart
    - title: "Revenue by Project"
      name: revenue_by_project
      model: analytics
      explore: companies_dim
      type: looker_bar
      fields:
        - projects_delivered.project_name
        - recognized_project_revenue.total_recognized_revenue_attributed_gbp
      filters: {}
      sorts:
        - recognized_project_revenue.total_recognized_revenue_attributed_gbp desc
      limit: 10
      listen:
        consultant_name: recognized_revenue_contact.contact_name
        billing_year: recognized_project_revenue.billing_month_year
      row: 4
      col: 12
      width: 12
      height: 8
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
      show_value_labels: true
      label_density: 25
      x_axis_scale: auto
      y_axis_combined: true
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      color_application:
        collection_id: google
        palette_id: google-categorical-0
      series_colors:
        recognized_project_revenue.total_recognized_revenue_attributed_gbp: "#1A73E8"
      x_axis_zoom: true
      y_axis_zoom: true

    # =============================================================================
    # ROW 3: DETAIL TABLE
    # =============================================================================

    # Project Revenue Breakdown Table
    - title: "Project Revenue Breakdown"
      name: project_revenue_breakdown
      model: analytics
      explore: companies_dim
      type: looker_grid
      fields:
        - projects_delivered.project_name
        - companies_dim.company_name
        - recognized_project_revenue.billing_month_month
        - recognized_project_revenue.total_recognized_revenue_attributed_gbp
        - recognized_project_revenue.total_hours_billed
      filters: {}
      sorts:
        - recognized_project_revenue.total_recognized_revenue_attributed_gbp desc
      limit: 500
      listen:
        consultant_name: recognized_revenue_contact.contact_name
        billing_year: recognized_project_revenue.billing_month_year
      dynamic_fields:
        - category: table_calculation
          expression: "${recognized_project_revenue.total_recognized_revenue_attributed_gbp}/sum(${recognized_project_revenue.total_recognized_revenue_attributed_gbp})"
          label: "% of Total"
          value_format:
          value_format_name: percent_1
          _kind_hint: measure
          table_calculation: pct_of_total
          _type_hint: number
      row: 12
      col: 0
      width: 24
      height: 10
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
      series_labels:
        projects_delivered.project_name: "Project"
        companies_dim.company_name: "Client"
        recognized_project_revenue.billing_month_month: "Month"
        recognized_project_revenue.total_recognized_revenue_attributed_gbp: "Revenue (GBP)"
        recognized_project_revenue.total_hours_billed: "Hours"
        pct_of_total: "% of Total"
      series_cell_visualizations:
        recognized_project_revenue.total_recognized_revenue_attributed_gbp:
          is_active: true
          palette:
            palette_id: google-sequential-0
            collection_id: google
      conditional_formatting:
        - type: along a scale...
          value:
          background_color: "#1A73E8"
          font_color:
          color_application:
            collection_id: google
            palette_id: google-sequential-0
            options:
              constraints:
                min:
                  type: minimum
                mid:
                  type: middle
                max:
                  type: maximum
              mirror: false
              reverse: false
              stepped: false
          bold: false
          italic: false
          strikethrough: false
          fields:
            - pct_of_total
