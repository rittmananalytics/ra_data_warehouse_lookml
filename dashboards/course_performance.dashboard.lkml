########################################################################
# Course Performance Dashboard
# Primary dashboard for monitoring subject and course performance
########################################################################

- dashboard: course_performance
  title: "Course Performance"
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  filters_location_top: true

  filters:
    - name: academic_year
      title: "Academic Year"
      type: field_filter
      explore: fct_enrolment
      field: dim_academic_year.academic_year_name
      default_value: ""
      allow_multiple_values: true
      ui_config:
        type: dropdown_menu
        display: inline

    - name: qualification_type
      title: "Qualification Type"
      type: field_filter
      explore: fct_enrolment
      field: dim_offering_type.offering_type_name
      default_value: ""
      allow_multiple_values: true
      ui_config:
        type: dropdown_menu
        display: inline

    - name: faculty
      title: "Faculty"
      type: field_filter
      explore: fct_enrolment
      field: dim_course_header.department
      default_value: ""
      allow_multiple_values: true
      ui_config:
        type: dropdown_menu
        display: inline

    - name: prior_attainment
      title: "Prior Attainment Band"
      type: field_filter
      explore: fct_enrolment
      field: fct_enrolment.prior_attainment_band
      default_value: ""
      allow_multiple_values: true
      ui_config:
        type: dropdown_menu
        display: inline

  elements:
    # =====================================================================
    # Row 1: Headline KPIs
    # =====================================================================

    - name: total_enrolments
      title: "Total Enrolments"
      type: single_value
      model: academic_analytics
      explore: fct_enrolment
      fields:
        - fct_enrolment.cohort_count
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: dim_offering_type.offering_type_name
        faculty: dim_course_header.department
        prior_attainment: fct_enrolment.prior_attainment_band
      font_size: large
      custom_color_enabled: true
      custom_color: "#4285F4"
      row: 0
      col: 0
      width: 4
      height: 3

    - name: pass_rate
      title: "Pass Rate"
      type: single_value
      model: academic_analytics
      explore: fct_enrolment
      fields:
        - fct_enrolment.pass_rate_pct
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: dim_offering_type.offering_type_name
        faculty: dim_course_header.department
        prior_attainment: fct_enrolment.prior_attainment_band
      font_size: large
      custom_color_enabled: true
      custom_color: "#34A853"
      value_format: "0.0\%"
      row: 0
      col: 4
      width: 4
      height: 3

    - name: high_grades
      title: "High Grades (A*-B / D*-M)"
      type: single_value
      model: academic_analytics
      explore: fct_enrolment
      fields:
        - fct_enrolment.high_grade_pct
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: dim_offering_type.offering_type_name
        faculty: dim_course_header.department
        prior_attainment: fct_enrolment.prior_attainment_band
      font_size: large
      custom_color_enabled: true
      custom_color: "#FBBC04"
      value_format: "0.0\%"
      row: 0
      col: 8
      width: 4
      height: 3

    - name: avg_grade_points
      title: "Average Grade Points"
      type: single_value
      model: academic_analytics
      explore: fct_enrolment
      fields:
        - fct_enrolment.avg_grade_points
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: dim_offering_type.offering_type_name
        faculty: dim_course_header.department
        prior_attainment: fct_enrolment.prior_attainment_band
      font_size: large
      value_format: "0.0"
      row: 0
      col: 12
      width: 4
      height: 3

    - name: completion_rate
      title: "Completion Rate"
      type: single_value
      model: academic_analytics
      explore: fct_enrolment
      fields:
        - fct_enrolment.completion_rate_pct
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: dim_offering_type.offering_type_name
        faculty: dim_course_header.department
        prior_attainment: fct_enrolment.prior_attainment_band
      font_size: large
      custom_color_enabled: true
      custom_color: "#5F6368"
      value_format: "0.0\%"
      row: 0
      col: 16
      width: 4
      height: 3

    - name: avg_gcse_entry
      title: "Average GCSE on Entry"
      type: single_value
      model: academic_analytics
      explore: fct_enrolment
      fields:
        - fct_enrolment.avg_gcse_cohort
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: dim_offering_type.offering_type_name
        faculty: dim_course_header.department
        prior_attainment: fct_enrolment.prior_attainment_band
      font_size: large
      value_format: "0.00"
      row: 0
      col: 20
      width: 4
      height: 3

    # =====================================================================
    # Row 2: Outcomes Trend
    # =====================================================================

    - name: outcomes_trend
      title: "How did headline outcomes trend over the last 6 years?"
      type: looker_line
      model: academic_analytics
      explore: fct_enrolment
      fields:
        - dim_academic_year.academic_year_name
        - fct_enrolment.pass_rate_pct
        - fct_enrolment.high_grade_pct
        - fct_enrolment.avg_grade_points
      sorts:
        - dim_academic_year.academic_year_name asc
      listen:
        qualification_type: dim_offering_type.offering_type_name
        faculty: dim_course_header.department
        prior_attainment: fct_enrolment.prior_attainment_band
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
        fct_enrolment.pass_rate_pct: "#4285F4"
        fct_enrolment.high_grade_pct: "#FBBC04"
        fct_enrolment.avg_grade_points: "#34A853"
      series_labels:
        fct_enrolment.pass_rate_pct: "Pass Rate %"
        fct_enrolment.high_grade_pct: "High Grade %"
        fct_enrolment.avg_grade_points: "Avg Grade Points"
      y_axes:
        - label: "Percentage"
          orientation: left
          series:
            - id: fct_enrolment.pass_rate_pct
              name: "Pass Rate %"
            - id: fct_enrolment.high_grade_pct
              name: "High Grade %"
          showLabels: true
          showValues: true
          minValue: 0
          maxValue: 100
        - label: "Grade Points"
          orientation: right
          series:
            - id: fct_enrolment.avg_grade_points
              name: "Avg Grade Points"
          showLabels: true
          showValues: true
      row: 3
      col: 0
      width: 24
      height: 6

    # =====================================================================
    # Row 3: Subject Performance Table
    # =====================================================================

    - name: subject_performance_table
      title: "Subject Performance Summary"
      type: looker_grid
      model: academic_analytics
      explore: fct_enrolment
      fields:
        - dim_offering.offering_name
        - dim_offering_type.offering_type_name
        - fct_enrolment.cohort_count
        - fct_enrolment.grade_a_star_count
        - fct_enrolment.grade_a_count
        - fct_enrolment.grade_b_count
        - fct_enrolment.grade_c_count
        - fct_enrolment.pass_rate_pct
        - fct_enrolment.high_grade_pct
        - fct_enrolment.avg_grade_points
      filters:
        dim_academic_year.is_current_year: "Yes"
      sorts:
        - dim_offering.offering_name asc
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: dim_offering_type.offering_type_name
        faculty: dim_course_header.department
        prior_attainment: fct_enrolment.prior_attainment_band
      show_view_names: false
      show_row_numbers: true
      truncate_text: true
      hide_totals: false
      hide_row_totals: false
      series_labels:
        dim_offering.offering_name: "Subject"
        dim_offering_type.offering_type_name: "Type"
        fct_enrolment.cohort_count: "Cohort"
        fct_enrolment.grade_a_star_count: "A*"
        fct_enrolment.grade_a_count: "A"
        fct_enrolment.grade_b_count: "B"
        fct_enrolment.grade_c_count: "C"
        fct_enrolment.pass_rate_pct: "Pass %"
        fct_enrolment.high_grade_pct: "High %"
        fct_enrolment.avg_grade_points: "Avg Pts"
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
            - fct_enrolment.pass_rate_pct
      row: 9
      col: 0
      width: 24
      height: 8

    # =====================================================================
    # Row 4: Charts Row
    # =====================================================================

    - name: grade_distribution
      title: "Grade Distribution by Subject"
      type: looker_bar
      model: academic_analytics
      explore: fct_enrolment
      fields:
        - dim_offering.offering_name
        - fct_enrolment.grade_a_star_count
        - fct_enrolment.grade_a_count
        - fct_enrolment.grade_b_count
        - fct_enrolment.grade_c_count
        - fct_enrolment.grade_d_count
        - fct_enrolment.grade_e_count
        - fct_enrolment.grade_u_count
      filters:
        dim_academic_year.is_current_year: "Yes"
      sorts:
        - dim_offering.offering_name asc
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: dim_offering_type.offering_type_name
        faculty: dim_course_header.department
        prior_attainment: fct_enrolment.prior_attainment_band
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      stacking: normal
      legend_position: bottom
      series_colors:
        fct_enrolment.grade_a_star_count: "#1a73e8"
        fct_enrolment.grade_a_count: "#4285f4"
        fct_enrolment.grade_b_count: "#669df6"
        fct_enrolment.grade_c_count: "#aecbfa"
        fct_enrolment.grade_d_count: "#fbbc04"
        fct_enrolment.grade_e_count: "#f9ab00"
        fct_enrolment.grade_u_count: "#ea4335"
      series_labels:
        fct_enrolment.grade_a_star_count: "A*"
        fct_enrolment.grade_a_count: "A"
        fct_enrolment.grade_b_count: "B"
        fct_enrolment.grade_c_count: "C"
        fct_enrolment.grade_d_count: "D"
        fct_enrolment.grade_e_count: "E"
        fct_enrolment.grade_u_count: "U"
      row: 17
      col: 0
      width: 12
      height: 7

    - name: outcomes_by_prior_attainment
      title: "Outcomes by Prior Attainment Band"
      type: looker_column
      model: academic_analytics
      explore: fct_enrolment
      fields:
        - fct_enrolment.prior_attainment_band
        - fct_enrolment.pass_rate_pct
        - fct_enrolment.high_grade_pct
      filters:
        dim_academic_year.is_current_year: "Yes"
        fct_enrolment.prior_attainment_band: "-N/A,-EMPTY"
      sorts:
        - fct_enrolment.prior_attainment_band
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: dim_offering_type.offering_type_name
        faculty: dim_course_header.department
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      legend_position: bottom
      series_colors:
        fct_enrolment.pass_rate_pct: "#34A853"
        fct_enrolment.high_grade_pct: "#4285F4"
      series_labels:
        fct_enrolment.pass_rate_pct: "Pass Rate %"
        fct_enrolment.high_grade_pct: "High Grade %"
      y_axis_combined: true
      y_axis_min:
        - 0
      y_axis_max:
        - 100
      row: 17
      col: 12
      width: 12
      height: 7

    # =====================================================================
    # Row 5: Year-over-Year Comparison
    # =====================================================================

    - name: subject_vs_prior_year
      title: "Subject Performance vs Prior Year (Bubble size = cohort)"
      type: looker_scatter
      model: academic_analytics
      explore: fct_enrolment_yoy
      fields:
        - dim_offering.offering_name
        - prior_year_performance.prior_pass_rate_pct
        - fct_enrolment_yoy.pass_rate_pct
        - fct_enrolment_yoy.cohort_count
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        qualification_type: dim_offering_type.offering_type_name
      show_view_names: false
      x_axis_gridlines: false
      y_axis_gridlines: true
      x_axis_label: "Prior Year Pass Rate %"
      y_axis_label: "Current Year Pass Rate %"
      series_colors:
        fct_enrolment_yoy.pass_rate_pct: "#4285F4"
      series_point_styles:
        fct_enrolment_yoy.pass_rate_pct: filled
      size_by_field: fct_enrolment_yoy.cohort_count
      reference_lines:
        - reference_type: line
          line_value: y=x
          range_start:
          range_end:
          margin_top: deviation
          margin_value:
          margin_bottom: deviation
          label_position: right
          color: "#5F6368"
          label: "No Change"
      row: 24
      col: 0
      width: 24
      height: 8
