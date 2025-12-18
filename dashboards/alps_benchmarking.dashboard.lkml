########################################################################
# ALPS Subject Benchmarking Dashboard
# ALPS value-added benchmarking at subject level
########################################################################

- dashboard: alps_benchmarking
  title: "ALPS Subject Benchmarking"
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  filters_location_top: true

  filters:
    - name: academic_year
      title: "Academic Year"
      type: field_filter
      explore: fct_alps_subject_performance
      field: dim_academic_year.academic_year_name
      default_value: ""
      allow_multiple_values: true
      ui_config:
        type: dropdown_menu
        display: inline

    - name: qualification_type
      title: "Qualification Type"
      type: field_filter
      explore: fct_alps_subject_performance
      field: fct_alps_subject_performance.alps_qualification_type
      default_value: "A-Level"
      allow_multiple_values: true
      ui_config:
        type: dropdown_menu
        display: inline

    - name: alps_band
      title: "ALPS Band"
      type: field_filter
      explore: fct_alps_subject_performance
      field: fct_alps_subject_performance.alps_band
      default_value: ""
      allow_multiple_values: true
      ui_config:
        type: dropdown_menu
        display: inline

  elements:
    # =====================================================================
    # Row 1: ALPS Overview KPIs
    # =====================================================================

    - name: college_alps_score
      title: "College ALPS Band"
      type: single_value
      model: academic_analytics
      explore: fct_alps_subject_performance
      fields:
        - fct_alps_subject_performance.college_alps_band
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: fct_alps_subject_performance.alps_qualification_type
      font_size: large
      custom_color_enabled: true
      custom_color: "#4285F4"
      note_state: collapsed
      note_display: below
      note_text: "Weighted average band"
      row: 0
      col: 0
      width: 5
      height: 3

    - name: subjects_band_1_2
      title: "Subjects Band 1-2"
      type: single_value
      model: academic_analytics
      explore: fct_alps_subject_performance
      fields:
        - fct_alps_subject_performance.count_band_1_2
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: fct_alps_subject_performance.alps_qualification_type
      font_size: large
      custom_color_enabled: true
      custom_color: "#34A853"
      note_state: collapsed
      note_display: below
      note_text: "Excellent - Target increasing"
      row: 0
      col: 5
      width: 5
      height: 3

    - name: subjects_band_3_4
      title: "Subjects Band 3-4"
      type: single_value
      model: academic_analytics
      explore: fct_alps_subject_performance
      fields:
        - fct_alps_subject_performance.count_band_3_4
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: fct_alps_subject_performance.alps_qualification_type
      font_size: large
      custom_color_enabled: true
      custom_color: "#4285F4"
      note_state: collapsed
      note_display: below
      note_text: "Good - At Expected"
      row: 0
      col: 10
      width: 5
      height: 3

    - name: subjects_band_5_plus
      title: "Subjects Band 5+"
      type: single_value
      model: academic_analytics
      explore: fct_alps_subject_performance
      fields:
        - fct_alps_subject_performance.count_band_5_plus
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: fct_alps_subject_performance.alps_qualification_type
      font_size: large
      custom_color_enabled: true
      custom_color: "#EA4335"
      note_state: collapsed
      note_display: below
      note_text: "Below Average - Target decreasing"
      row: 0
      col: 15
      width: 5
      height: 3

    - name: unmapped_subjects
      title: "Unmapped Subjects"
      type: single_value
      model: academic_analytics
      explore: fct_alps_subject_performance
      fields:
        - fct_alps_subject_performance.count_unmapped_subjects
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: fct_alps_subject_performance.alps_qualification_type
      font_size: large
      custom_color_enabled: true
      custom_color: "#5F6368"
      note_state: collapsed
      note_display: below
      note_text: "Require mapping to internal offerings"
      row: 0
      col: 20
      width: 4
      height: 3

    # =====================================================================
    # Row 2: ALPS Band Distribution
    # =====================================================================

    - name: alps_band_distribution
      title: "What is our overall ALPS profile?"
      type: looker_bar
      model: academic_analytics
      explore: fct_alps_subject_performance
      fields:
        - fct_alps_subject_performance.alps_band
        - fct_alps_subject_performance.alps_band_description
        - fct_alps_subject_performance.count
      filters:
        dim_academic_year.is_current_year: "Yes"
      sorts:
        - fct_alps_subject_performance.alps_band asc
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: fct_alps_subject_performance.alps_qualification_type
        alps_band: fct_alps_subject_performance.alps_band
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      legend_position: center
      series_colors:
        fct_alps_subject_performance.count: "#4285F4"
      series_labels:
        fct_alps_subject_performance.count: "Subject Count"
        fct_alps_subject_performance.alps_band: "ALPS Band"
        fct_alps_subject_performance.alps_band_description: "Description"
      show_x_axis_label: true
      show_y_axis_label: true
      x_axis_label: "ALPS Band"
      y_axis_label: "Number of Subjects"
      row: 3
      col: 0
      width: 16
      height: 6

    - name: alps_band_legend
      title: "ALPS Band Reference"
      type: looker_single_record
      model: academic_analytics
      explore: fct_alps_subject_performance
      fields:
        - fct_alps_subject_performance.alps_band
        - fct_alps_subject_performance.alps_band_description
      filters:
        dim_academic_year.is_current_year: "Yes"
      sorts:
        - fct_alps_subject_performance.alps_band asc
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: fct_alps_subject_performance.alps_qualification_type
      show_single_value_title: false
      show_comparison: false
      series_labels:
        fct_alps_subject_performance.alps_band: "Band"
        fct_alps_subject_performance.alps_band_description: "Description"
      row: 3
      col: 16
      width: 8
      height: 6

    # =====================================================================
    # Row 3: ALPS Performance Scatter
    # =====================================================================

    - name: alps_performance_scatter
      title: "Which subjects significantly outperform or underperform?"
      type: looker_scatter
      model: academic_analytics
      explore: fct_alps_subject_performance
      fields:
        - fct_alps_subject_performance.alps_subject_name
        - fct_alps_subject_performance.cohort_count_dim
        - fct_alps_subject_performance.high_grades_pct_dim
        - fct_alps_subject_performance.alps_band
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: fct_alps_subject_performance.alps_qualification_type
        alps_band: fct_alps_subject_performance.alps_band
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      x_axis_label: "Cohort Size"
      y_axis_label: "High Grade %"
      legend_position: bottom
      series_colors:
        "1": "#34A853"
        "2": "#34A853"
        "3": "#4285F4"
        "4": "#4285F4"
        "5": "#FBBC04"
        "6": "#FBBC04"
        "7": "#EA4335"
        "8": "#EA4335"
        "9": "#EA4335"
      color_application:
        collection_id: google
        palette_id: google-categorical-0
      size_by_field: fct_alps_subject_performance.cohort_count_dim
      row: 9
      col: 0
      width: 24
      height: 7

    # =====================================================================
    # Row 4: Subject vs National Standards
    # =====================================================================

    - name: subjects_vs_national
      title: "Are subjects above or below national standards?"
      type: looker_bar
      model: academic_analytics
      explore: fct_alps_subject_performance
      fields:
        - fct_alps_subject_performance.alps_subject_name
        - fct_alps_subject_performance.average_value_added
      filters:
        dim_academic_year.is_current_year: "Yes"
      sorts:
        - fct_alps_subject_performance.average_value_added desc
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: fct_alps_subject_performance.alps_qualification_type
        alps_band: fct_alps_subject_performance.alps_band
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      legend_position: center
      series_colors:
        fct_alps_subject_performance.average_value_added: "#4285F4"
      series_labels:
        fct_alps_subject_performance.average_value_added: "Value Added"
        fct_alps_subject_performance.alps_subject_name: "Subject"
      reference_lines:
        - reference_type: line
          line_value: 0
          range_start:
          range_end:
          margin_top: deviation
          margin_value:
          margin_bottom: deviation
          label_position: right
          color: "#EA4335"
          label: "National Average"
      conditional_formatting:
        - type: greater than
          value: 0
          background_color: "#E6F4EA"
          font_color:
          color_application:
            collection_id:
            palette_id:
          bold: false
          italic: false
          strikethrough: false
          fields:
        - type: less than
          value: 0
          background_color: "#FCE8E6"
          font_color:
          color_application:
            collection_id:
            palette_id:
          bold: false
          italic: false
          strikethrough: false
          fields:
      row: 16
      col: 0
      width: 24
      height: 6

    # =====================================================================
    # Row 5: Subject ALPS Performance Table
    # =====================================================================

    - name: subject_alps_table
      title: "Subject ALPS Performance Detail"
      type: looker_grid
      model: academic_analytics
      explore: fct_alps_subject_performance
      fields:
        - fct_alps_subject_performance.alps_subject_name
        - fct_alps_subject_performance.alps_qualification_type
        - fct_alps_subject_performance.cohort_count_dim
        - fct_alps_subject_performance.alps_band
        - fct_alps_subject_performance.average_alps_score
        - fct_alps_subject_performance.pass_rate_pct_dim
        - fct_alps_subject_performance.high_grades_pct_dim
        - fct_alps_subject_performance.national_benchmark_grade
        - fct_alps_subject_performance.subject_mapping_status
      filters:
        dim_academic_year.is_current_year: "Yes"
      sorts:
        - fct_alps_subject_performance.alps_band asc
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: fct_alps_subject_performance.alps_qualification_type
        alps_band: fct_alps_subject_performance.alps_band
      show_view_names: false
      show_row_numbers: true
      truncate_text: true
      hide_totals: false
      hide_row_totals: false
      series_labels:
        fct_alps_subject_performance.alps_subject_name: "Subject"
        fct_alps_subject_performance.alps_qualification_type: "Qual Type"
        fct_alps_subject_performance.cohort_count_dim: "Cohort"
        fct_alps_subject_performance.alps_band: "ALPS Band"
        fct_alps_subject_performance.average_alps_score: "ALPS Score"
        fct_alps_subject_performance.pass_rate_pct_dim: "Pass %"
        fct_alps_subject_performance.high_grades_pct_dim: "High %"
        fct_alps_subject_performance.national_benchmark_grade: "National Grade"
        fct_alps_subject_performance.subject_mapping_status: "Mapping Status"
      conditional_formatting:
        - type: along a scale...
          value:
          background_color:
          font_color:
          color_application:
            collection_id: google
            palette_id: google-diverging-0
            options:
              steps: 9
              reverse: true
          bold: false
          italic: false
          strikethrough: false
          fields:
            - fct_alps_subject_performance.alps_band
      row: 22
      col: 0
      width: 24
      height: 8

    # =====================================================================
    # Row 6: ALPS Alerts
    # =====================================================================

    - name: alps_alerts
      title: "ALPS Alerts - Subjects Requiring Intervention"
      type: looker_grid
      model: academic_analytics
      explore: fct_alps_subject_performance
      fields:
        - fct_alps_subject_performance.alps_subject_name
        - fct_alps_subject_performance.alps_band
        - fct_alps_subject_performance.alps_band_description
        - fct_alps_subject_performance.cohort_count_dim
        - fct_alps_subject_performance.average_value_added
      filters:
        dim_academic_year.is_current_year: "Yes"
        fct_alps_subject_performance.alps_band: ">=5"
      sorts:
        - fct_alps_subject_performance.alps_band desc
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: fct_alps_subject_performance.alps_qualification_type
      show_view_names: false
      show_row_numbers: true
      series_labels:
        fct_alps_subject_performance.alps_subject_name: "Subject"
        fct_alps_subject_performance.alps_band: "Band"
        fct_alps_subject_performance.alps_band_description: "Performance Level"
        fct_alps_subject_performance.cohort_count_dim: "Cohort"
        fct_alps_subject_performance.average_value_added: "VA Score"
      note_state: expanded
      note_display: above
      note_text: "Subjects with ALPS Band 5 or higher require intervention to improve value-added performance"
      row: 30
      col: 0
      width: 24
      height: 5
