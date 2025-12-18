########################################################################
# Gender Gap Analysis Dashboard
# Detailed analysis of gender gaps at college and subject level
########################################################################

- dashboard: gender_gap_analysis
  title: "Gender Gap Analysis"
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
    # Row 1: Gender Gap Overview KPIs
    # =====================================================================

    - name: female_pass_rate
      title: "Female Pass Rate"
      type: single_value
      model: academic_analytics
      explore: fct_enrolment
      fields:
        - fct_enrolment.female_pass_rate_pct
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: dim_offering_type.offering_type_name
        prior_attainment: fct_enrolment.prior_attainment_band
      font_size: large
      custom_color_enabled: true
      custom_color: "#4285F4"
      value_format: "0.0%"
      row: 0
      col: 0
      width: 6
      height: 3

    - name: male_pass_rate
      title: "Male Pass Rate"
      type: single_value
      model: academic_analytics
      explore: fct_enrolment
      fields:
        - fct_enrolment.male_pass_rate_pct
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: dim_offering_type.offering_type_name
        prior_attainment: fct_enrolment.prior_attainment_band
      font_size: large
      custom_color_enabled: true
      custom_color: "#FBBC04"
      value_format: "0.0%"
      row: 0
      col: 6
      width: 6
      height: 3

    - name: gender_gap
      title: "Gender Gap"
      type: single_value
      model: academic_analytics
      explore: fct_enrolment
      fields:
        - fct_enrolment.gender_gap_pass_pp
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: dim_offering_type.offering_type_name
        prior_attainment: fct_enrolment.prior_attainment_band
      font_size: large
      value_format: "+0.0;-0.0"
      note_state: collapsed
      note_display: below
      note_text: "Female - Male pass rate (pp)"
      row: 0
      col: 12
      width: 6
      height: 3

    - name: subjects_large_gap
      title: "Subjects with Gap >5pp"
      type: single_value
      model: academic_analytics
      explore: subject_gender_gap
      fields:
        - subject_gender_gap.count_subjects_with_large_gap
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        academic_year: dim_academic_year.academic_year_name
      font_size: large
      custom_color_enabled: true
      custom_color: "#EA4335"
      note_state: collapsed
      note_display: below
      note_text: "Subjects requiring attention"
      row: 0
      col: 18
      width: 6
      height: 3

    # =====================================================================
    # Row 2: Gender Gap by Subject
    # =====================================================================

    - name: gender_gap_by_subject
      title: "Which subjects have the largest gender gaps?"
      type: looker_bar
      model: academic_analytics
      explore: subject_gender_gap
      fields:
        - subject_gender_gap.offering_name
        - subject_gender_gap.subject_gender_gap_pass
      filters:
        dim_academic_year.is_current_year: "Yes"
      sorts:
        - subject_gender_gap.subject_gender_gap_pass desc
      listen:
        academic_year: dim_academic_year.academic_year_name
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      legend_position: center
      series_colors:
        subject_gender_gap.subject_gender_gap_pass: "#4285F4"
      series_labels:
        subject_gender_gap.subject_gender_gap_pass: "Gender Gap (pp)"
        subject_gender_gap.offering_name: "Subject"
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
          label: "No Gap"
        - reference_type: line
          line_value: 5
          range_start:
          range_end:
          margin_top: deviation
          margin_value:
          margin_bottom: deviation
          label_position: right
          color: "#EA4335"
          label: "Alert Threshold (+5pp)"
        - reference_type: line
          line_value: -5
          range_start:
          range_end:
          margin_top: deviation
          margin_value:
          margin_bottom: deviation
          label_position: right
          color: "#EA4335"
          label: "Alert Threshold (-5pp)"
      conditional_formatting:
        - type: greater than
          value: 0
          font_color: "#4285F4"
          bold: false
          italic: false
          strikethrough: false
          fields:
            - subject_gender_gap.subject_gender_gap_pass
        - type: less than
          value: 0
          font_color: "#EA4335"
          bold: false
          italic: false
          strikethrough: false
          fields:
            - subject_gender_gap.subject_gender_gap_pass
      note_state: expanded
      note_display: below
      note_text: "Positive = Female outperforming | Negative = Male outperforming"
      row: 3
      col: 0
      width: 24
      height: 7

    # =====================================================================
    # Row 3: Gender Gap Trend and Pass Rate by Subject
    # =====================================================================

    - name: gender_gap_trend
      title: "Is the gender gap narrowing?"
      type: looker_line
      model: academic_analytics
      explore: fct_enrolment
      fields:
        - dim_academic_year.academic_year_name
        - fct_enrolment.gender_gap_pass_pp
      sorts:
        - dim_academic_year.academic_year_name asc
      listen:
        qualification_type: dim_offering_type.offering_type_name
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
        fct_enrolment.gender_gap_pass_pp: "#4285F4"
      series_labels:
        fct_enrolment.gender_gap_pass_pp: "Gender Gap (pp)"
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
          label: "No Gap"
      row: 10
      col: 0
      width: 12
      height: 6

    - name: pass_rate_by_gender_subject
      title: "Pass Rate by Gender & Subject"
      type: looker_bar
      model: academic_analytics
      explore: fct_enrolment
      fields:
        - dim_offering.offering_name
        - fct_enrolment.gender
        - fct_enrolment.pass_rate_pct
      pivots:
        - fct_enrolment.gender
      filters:
        dim_academic_year.is_current_year: "Yes"
      sorts:
        - dim_offering.offering_name asc
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: dim_offering_type.offering_type_name
        prior_attainment: fct_enrolment.prior_attainment_band
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      legend_position: bottom
      series_colors:
        Female - fct_enrolment.pass_rate_pct: "#4285F4"
        Male - fct_enrolment.pass_rate_pct: "#FBBC04"
      series_labels:
        Female - fct_enrolment.pass_rate_pct: "Female"
        Male - fct_enrolment.pass_rate_pct: "Male"
      row: 10
      col: 12
      width: 12
      height: 6

    # =====================================================================
    # Row 4: Subject-Level Gender Analysis Table
    # =====================================================================

    - name: subject_gender_table
      title: "Subject-Level Gender Analysis"
      type: looker_grid
      model: academic_analytics
      explore: subject_gender_gap
      fields:
        - subject_gender_gap.offering_name
        - subject_gender_gap.subject_female_count
        - subject_gender_gap.subject_male_count
        - subject_gender_gap.subject_female_pass_rate
        - subject_gender_gap.subject_male_pass_rate
        - subject_gender_gap.subject_gender_gap_pass
        - subject_gender_gap.subject_female_high_grade_rate
        - subject_gender_gap.subject_male_high_grade_rate
        - subject_gender_gap.subject_gender_gap_high_grade
      filters:
        dim_academic_year.is_current_year: "Yes"
      sorts:
        - subject_gender_gap.subject_gender_gap_pass desc
      listen:
        academic_year: dim_academic_year.academic_year_name
      show_view_names: false
      show_row_numbers: true
      truncate_text: true
      hide_totals: false
      hide_row_totals: false
      series_labels:
        subject_gender_gap.offering_name: "Subject"
        subject_gender_gap.subject_female_count: "Female N"
        subject_gender_gap.subject_male_count: "Male N"
        subject_gender_gap.subject_female_pass_rate: "Female Pass %"
        subject_gender_gap.subject_male_pass_rate: "Male Pass %"
        subject_gender_gap.subject_gender_gap_pass: "Gap (Pass)"
        subject_gender_gap.subject_female_high_grade_rate: "Female High %"
        subject_gender_gap.subject_male_high_grade_rate: "Male High %"
        subject_gender_gap.subject_gender_gap_high_grade: "Gap (High)"
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
            - subject_gender_gap.subject_gender_gap_pass
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
            - subject_gender_gap.subject_gender_gap_high_grade
      row: 16
      col: 0
      width: 24
      height: 8

    # =====================================================================
    # Row 5: High Grade Gender Analysis
    # =====================================================================

    - name: high_grade_gender_gap_by_subject
      title: "High Grade Gender Gap by Subject"
      type: looker_bar
      model: academic_analytics
      explore: subject_gender_gap
      fields:
        - subject_gender_gap.offering_name
        - subject_gender_gap.subject_gender_gap_high_grade
      filters:
        dim_academic_year.is_current_year: "Yes"
      sorts:
        - subject_gender_gap.subject_gender_gap_high_grade desc
      listen:
        academic_year: dim_academic_year.academic_year_name
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      legend_position: center
      series_colors:
        subject_gender_gap.subject_gender_gap_high_grade: "#34A853"
      series_labels:
        subject_gender_gap.subject_gender_gap_high_grade: "High Grade Gap (pp)"
        subject_gender_gap.offering_name: "Subject"
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
          label: "No Gap"
      note_state: expanded
      note_display: below
      note_text: "Positive = Female outperforming | Negative = Male outperforming"
      row: 24
      col: 0
      width: 12
      height: 7

    - name: gender_by_prior_attainment
      title: "Gender Gap by Prior Attainment Band"
      type: looker_column
      model: academic_analytics
      explore: fct_enrolment
      fields:
        - fct_enrolment.prior_attainment_band
        - fct_enrolment.gender
        - fct_enrolment.pass_rate_pct
      pivots:
        - fct_enrolment.gender
      filters:
        dim_academic_year.is_current_year: "Yes"
        fct_enrolment.prior_attainment_band: "-N/A,-EMPTY"
      sorts:
        - fct_enrolment.prior_attainment_band asc
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: dim_offering_type.offering_type_name
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      legend_position: bottom
      series_colors:
        Female - fct_enrolment.pass_rate_pct: "#4285F4"
        Male - fct_enrolment.pass_rate_pct: "#FBBC04"
      series_labels:
        Female - fct_enrolment.pass_rate_pct: "Female"
        Male - fct_enrolment.pass_rate_pct: "Male"
      y_axis_combined: true
      y_axis_min:
        - 0
      y_axis_max:
        - 100
      row: 24
      col: 12
      width: 12
      height: 7
