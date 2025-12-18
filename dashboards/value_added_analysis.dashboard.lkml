########################################################################
# Value-Added Analysis Dashboard
# Six Dimensions subject-level value-added benchmarking
########################################################################

- dashboard: value_added_analysis
  title: "Value-Added Analysis"
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  filters_location_top: true

  filters:
    - name: academic_year
      title: "Academic Year"
      type: field_filter
      explore: fct_subject_benchmark
      field: dim_academic_year.academic_year_name
      default_value: ""
      allow_multiple_values: true
      ui_config:
        type: dropdown_menu
        display: inline

    - name: report_type
      title: "Report Type"
      type: field_filter
      explore: fct_subject_benchmark
      field: fct_subject_benchmark.report_type
      default_value: "VA"
      allow_multiple_values: false
      ui_config:
        type: dropdown_menu
        display: inline

    - name: qualification_type
      title: "Qualification Type"
      type: field_filter
      explore: fct_subject_benchmark
      field: fct_subject_benchmark.qualification_type
      default_value: ""
      allow_multiple_values: true
      ui_config:
        type: dropdown_menu
        display: inline

  elements:
    # =====================================================================
    # Row 1: VA Overview KPIs
    # =====================================================================

    - name: college_va_score
      title: "College VA Score"
      type: single_value
      model: academic_analytics
      explore: fct_subject_benchmark
      fields:
        - fct_subject_benchmark.weighted_avg_va_score
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        academic_year: dim_academic_year.academic_year_name
        report_type: fct_subject_benchmark.report_type
        qualification_type: fct_subject_benchmark.qualification_type
      font_size: large
      custom_color_enabled: true
      custom_color: "#4285F4"
      value_format: "+0.00;-0.00"
      note_state: collapsed
      note_display: below
      note_text: "Weighted by cohort size"
      row: 0
      col: 0
      width: 6
      height: 3

    - name: va_percentile
      title: "VA Percentile Tier"
      type: single_value
      model: academic_analytics
      explore: fct_subject_benchmark
      fields:
        - fct_subject_benchmark.va_percentile_tier
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        academic_year: dim_academic_year.academic_year_name
        report_type: fct_subject_benchmark.report_type
        qualification_type: fct_subject_benchmark.qualification_type
      font_size: large
      note_state: collapsed
      note_display: below
      note_text: "Approximate national ranking"
      row: 0
      col: 6
      width: 6
      height: 3

    - name: va_band
      title: "Overall VA Band"
      type: single_value
      model: academic_analytics
      explore: fct_subject_benchmark
      fields:
        - fct_subject_benchmark.college_va_band
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        academic_year: dim_academic_year.academic_year_name
        report_type: fct_subject_benchmark.report_type
        qualification_type: fct_subject_benchmark.qualification_type
      font_size: large
      custom_color_enabled: true
      custom_color: "#34A853"
      note_state: collapsed
      note_display: below
      note_text: "A-E scale (A=Excellent)"
      row: 0
      col: 12
      width: 6
      height: 3

    - name: subjects_above_expected
      title: "Subjects Above Expected"
      type: single_value
      model: academic_analytics
      explore: fct_subject_benchmark
      fields:
        - fct_subject_benchmark.count_above_expected
        - fct_subject_benchmark.count
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        academic_year: dim_academic_year.academic_year_name
        report_type: fct_subject_benchmark.report_type
        qualification_type: fct_subject_benchmark.qualification_type
      dynamic_fields:
        - category: table_calculation
          expression: "concat(${fct_subject_benchmark.count_above_expected}, \" / \", ${fct_subject_benchmark.count})"
          label: "Above Expected"
          value_format:
          value_format_name:
          _kind_hint: measure
          table_calculation: above_expected_display
          _type_hint: string
      hidden_fields:
        - fct_subject_benchmark.count_above_expected
        - fct_subject_benchmark.count
      font_size: large
      custom_color_enabled: true
      custom_color: "#34A853"
      note_state: collapsed
      note_display: below
      note_text: "Subjects with positive VA score"
      row: 0
      col: 18
      width: 6
      height: 3

    # =====================================================================
    # Row 2: Value-Added by Subject
    # =====================================================================

    - name: va_by_subject
      title: "Which subjects add the most value?"
      type: looker_bar
      model: academic_analytics
      explore: fct_subject_benchmark
      fields:
        - fct_subject_benchmark.six_dimensions_subject_name
        - fct_subject_benchmark.avg_value_added_score
      filters:
        dim_academic_year.is_current_year: "Yes"
      sorts:
        - fct_subject_benchmark.avg_value_added_score desc
      listen:
        academic_year: dim_academic_year.academic_year_name
        report_type: fct_subject_benchmark.report_type
        qualification_type: fct_subject_benchmark.qualification_type
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      legend_position: center
      series_colors:
        fct_subject_benchmark.avg_value_added_score: "#4285F4"
      series_labels:
        fct_subject_benchmark.avg_value_added_score: "VA Score"
        fct_subject_benchmark.six_dimensions_subject_name: "Subject"
      reference_lines:
        - reference_type: line
          line_value: 0
          range_start:
          range_end:
          margin_top: deviation
          margin_value:
          margin_bottom: deviation
          label_position: right
          color: "#5F6368"
          label: "Expected"
      conditional_formatting:
        - type: greater than
          value: 0
          background_color:
          font_color: "#34A853"
          color_application:
            collection_id:
            palette_id:
          bold: false
          italic: false
          strikethrough: false
          fields:
        - type: less than
          value: 0
          background_color:
          font_color: "#EA4335"
          color_application:
            collection_id:
            palette_id:
          bold: false
          italic: false
          strikethrough: false
          fields:
      row: 3
      col: 0
      width: 24
      height: 7

    # =====================================================================
    # Row 3: VA Analysis Charts
    # =====================================================================

    - name: va_vs_gcse_scatter
      title: "Is VA driven by intake quality or teaching?"
      type: looker_scatter
      model: academic_analytics
      explore: fct_subject_benchmark
      fields:
        - fct_subject_benchmark.six_dimensions_subject_name
        - fct_subject_benchmark.average_gcse_on_entry
        - fct_subject_benchmark.avg_value_added_score
        - fct_subject_benchmark.total_cohort_count
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        academic_year: dim_academic_year.academic_year_name
        report_type: fct_subject_benchmark.report_type
        qualification_type: fct_subject_benchmark.qualification_type
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      x_axis_label: "Avg GCSE Entry Score"
      y_axis_label: "VA Score"
      legend_position: center
      series_colors:
        fct_subject_benchmark.avg_value_added_score: "#4285F4"
      size_by_field: fct_subject_benchmark.total_cohort_count
      reference_lines:
        - reference_type: line
          line_value: 0
          range_start:
          range_end:
          margin_top: deviation
          margin_value:
          margin_bottom: deviation
          label_position: right
          color: "#5F6368"
          label: "Expected"
      note_state: expanded
      note_display: below
      note_text: "Top-left = Low intake, high VA (excellent teaching). Size = cohort."
      row: 10
      col: 0
      width: 12
      height: 7

    - name: va_trend
      title: "Is our value-added improving?"
      type: looker_line
      model: academic_analytics
      explore: fct_subject_benchmark
      fields:
        - dim_academic_year.academic_year_name
        - fct_subject_benchmark.qualification_type
        - fct_subject_benchmark.avg_value_added_score
      pivots:
        - fct_subject_benchmark.qualification_type
      sorts:
        - dim_academic_year.academic_year_name asc
      listen:
        report_type: fct_subject_benchmark.report_type
        qualification_type: fct_subject_benchmark.qualification_type
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      show_y_axis_labels: true
      show_y_axis_ticks: true
      show_x_axis_label: true
      show_x_axis_ticks: true
      legend_position: bottom
      point_style: circle
      series_colors:
        A-Level - fct_subject_benchmark.avg_value_added_score: "#4285F4"
        BTEC - fct_subject_benchmark.avg_value_added_score: "#34A853"
        Applied General - fct_subject_benchmark.avg_value_added_score: "#FBBC04"
      reference_lines:
        - reference_type: line
          line_value: 0
          range_start:
          range_end:
          margin_top: deviation
          margin_value:
          margin_bottom: deviation
          label_position: right
          color: "#5F6368"
          label: "Expected"
      row: 10
      col: 12
      width: 12
      height: 7

    # =====================================================================
    # Row 4: Subject VA Performance Table
    # =====================================================================

    - name: subject_va_table
      title: "Subject VA Performance Detail"
      type: looker_grid
      model: academic_analytics
      explore: fct_subject_benchmark
      fields:
        - fct_subject_benchmark.six_dimensions_subject_name
        - fct_subject_benchmark.qualification_type
        - fct_subject_benchmark.cohort_count
        - fct_subject_benchmark.average_gcse_on_entry
        - fct_subject_benchmark.expected_grade
        - fct_subject_benchmark.actual_avg_grade
        - fct_subject_benchmark.avg_value_added_score
        - fct_subject_benchmark.va_band
        - fct_subject_benchmark.va_percentile_tier
      filters:
        dim_academic_year.is_current_year: "Yes"
      sorts:
        - fct_subject_benchmark.avg_value_added_score desc
      listen:
        academic_year: dim_academic_year.academic_year_name
        report_type: fct_subject_benchmark.report_type
        qualification_type: fct_subject_benchmark.qualification_type
      show_view_names: false
      show_row_numbers: true
      truncate_text: true
      hide_totals: false
      hide_row_totals: false
      series_labels:
        fct_subject_benchmark.six_dimensions_subject_name: "Subject"
        fct_subject_benchmark.qualification_type: "Qual Type"
        fct_subject_benchmark.cohort_count: "Cohort"
        fct_subject_benchmark.average_gcse_on_entry: "Avg GCSE"
        fct_subject_benchmark.expected_grade: "Expected"
        fct_subject_benchmark.actual_avg_grade: "Actual"
        fct_subject_benchmark.avg_value_added_score: "VA Score"
        fct_subject_benchmark.va_band: "VA Band"
        fct_subject_benchmark.va_percentile_tier: "Percentile"
      conditional_formatting:
        - type: along a scale...
          value:
          background_color:
          font_color:
          color_application:
            collection_id: google
            palette_id: google-diverging-0
          bold: false
          italic: false
          strikethrough: false
          fields:
            - fct_subject_benchmark.avg_value_added_score
      row: 17
      col: 0
      width: 24
      height: 8

    # =====================================================================
    # Row 5: Top/Bottom Performers
    # =====================================================================

    - name: top_5_va
      title: "Top 5 VA Performers"
      type: looker_grid
      model: academic_analytics
      explore: fct_subject_benchmark
      fields:
        - fct_subject_benchmark.six_dimensions_subject_name
        - fct_subject_benchmark.avg_value_added_score
        - fct_subject_benchmark.va_band
        - fct_subject_benchmark.cohort_count
      filters:
        dim_academic_year.is_current_year: "Yes"
      sorts:
        - fct_subject_benchmark.avg_value_added_score desc
      limit: 5
      listen:
        academic_year: dim_academic_year.academic_year_name
        report_type: fct_subject_benchmark.report_type
        qualification_type: fct_subject_benchmark.qualification_type
      show_view_names: false
      show_row_numbers: true
      series_labels:
        fct_subject_benchmark.six_dimensions_subject_name: "Subject"
        fct_subject_benchmark.avg_value_added_score: "VA Score"
        fct_subject_benchmark.va_band: "Band"
        fct_subject_benchmark.cohort_count: "Cohort"
      series_cell_visualizations:
        fct_subject_benchmark.avg_value_added_score:
          is_active: true
          palette:
            palette_id: google-sequential-0
            collection_id: google
      row: 25
      col: 0
      width: 12
      height: 5

    - name: bottom_5_va
      title: "Bottom 5 VA Performers (Intervention Required)"
      type: looker_grid
      model: academic_analytics
      explore: fct_subject_benchmark
      fields:
        - fct_subject_benchmark.six_dimensions_subject_name
        - fct_subject_benchmark.avg_value_added_score
        - fct_subject_benchmark.va_band
        - fct_subject_benchmark.cohort_count
      filters:
        dim_academic_year.is_current_year: "Yes"
      sorts:
        - fct_subject_benchmark.avg_value_added_score asc
      limit: 5
      listen:
        academic_year: dim_academic_year.academic_year_name
        report_type: fct_subject_benchmark.report_type
        qualification_type: fct_subject_benchmark.qualification_type
      show_view_names: false
      show_row_numbers: true
      series_labels:
        fct_subject_benchmark.six_dimensions_subject_name: "Subject"
        fct_subject_benchmark.avg_value_added_score: "VA Score"
        fct_subject_benchmark.va_band: "Band"
        fct_subject_benchmark.cohort_count: "Cohort"
      series_cell_visualizations:
        fct_subject_benchmark.avg_value_added_score:
          is_active: true
          palette:
            palette_id: google-diverging-0
            collection_id: google
            options:
              reverse: true
      row: 25
      col: 12
      width: 12
      height: 5
