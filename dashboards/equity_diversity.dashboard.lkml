########################################################################
# Equity & Diversity Dashboard
# JEDI analysis of attainment gaps across demographic groups
########################################################################

- dashboard: equity_diversity
  title: "Equity & Diversity"
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

    - name: subject
      title: "Subject"
      type: field_filter
      explore: fct_enrolment
      field: dim_offering.offering_name
      default_value: ""
      allow_multiple_values: true
      ui_config:
        type: dropdown_menu
        display: inline

  elements:
    # =====================================================================
    # Row 1: Attainment Gap Summary KPIs
    # =====================================================================

    - name: gender_gap_kpi
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
        subject: dim_offering.offering_name
      font_size: large
      value_format: "+0.0;-0.0"
      note_state: collapsed
      note_display: below
      note_text: "Female - Male pass rate (pp)"
      row: 0
      col: 0
      width: 6
      height: 3

    - name: disadvantage_gap_kpi
      title: "Disadvantage Gap"
      type: single_value
      model: academic_analytics
      explore: fct_enrolment
      fields:
        - fct_enrolment.disadvantage_gap_pass_pp
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: dim_offering_type.offering_type_name
        subject: dim_offering.offering_name
      font_size: large
      value_format: "+0.0;-0.0"
      note_state: collapsed
      note_display: below
      note_text: "Non-PP minus PP pass rate (pp)"
      row: 0
      col: 6
      width: 6
      height: 3

    - name: ethnicity_gap_kpi
      title: "Ethnicity Gap"
      type: single_value
      model: academic_analytics
      explore: fct_enrolment
      fields:
        - fct_enrolment.ethnicity
        - fct_enrolment.pass_rate_pct
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: dim_offering_type.offering_type_name
        subject: dim_offering.offering_name
      dynamic_fields:
        - category: table_calculation
          expression: "max(${fct_enrolment.pass_rate_pct}) - min(${fct_enrolment.pass_rate_pct})"
          label: "Ethnicity Gap"
          value_format: "+0.0;-0.0"
          value_format_name:
          _kind_hint: measure
          table_calculation: ethnicity_gap
          _type_hint: number
      hidden_fields:
        - fct_enrolment.ethnicity
        - fct_enrolment.pass_rate_pct
      font_size: large
      note_state: collapsed
      note_display: below
      note_text: "Max - Min ethnicity pass rate (pp)"
      row: 0
      col: 12
      width: 6
      height: 3

    - name: send_gap_kpi
      title: "SEND Gap"
      type: single_value
      model: academic_analytics
      explore: fct_enrolment
      fields:
        - fct_enrolment.send_gap_pass_pp
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: dim_offering_type.offering_type_name
        subject: dim_offering.offering_name
      font_size: large
      value_format: "+0.0;-0.0"
      note_state: collapsed
      note_display: below
      note_text: "Non-SEND minus SEND pass rate (pp)"
      row: 0
      col: 18
      width: 6
      height: 3

    # =====================================================================
    # Row 2: Attainment Gap Visualization
    # =====================================================================

    - name: attainment_gaps_bar
      title: "Where are the attainment gaps?"
      type: looker_bar
      model: academic_analytics
      explore: fct_equity_gap
      fields:
        - fct_equity_gap.dimension_name
        - fct_equity_gap.avg_gap_grade_points
      filters:
        dim_academic_year.is_current_year: "Yes"
      sorts:
        - fct_equity_gap.avg_gap_grade_points desc
      listen:
        academic_year: dim_academic_year.academic_year_name
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      series_colors:
        fct_equity_gap.avg_gap_grade_points: "#5F6368"
      series_labels:
        fct_equity_gap.avg_gap_grade_points: "Gap (Grade Points)"
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
          label: "No Gap"
      row: 3
      col: 0
      width: 24
      height: 5

    # =====================================================================
    # Row 3: Gap Trends
    # =====================================================================

    - name: gap_trend_line
      title: "Are gaps narrowing over time?"
      type: looker_line
      model: academic_analytics
      explore: fct_equity_gap
      fields:
        - dim_academic_year.academic_year_name
        - fct_equity_gap.dimension_name
        - fct_equity_gap.avg_gap_grade_points
      pivots:
        - fct_equity_gap.dimension_name
      sorts:
        - dim_academic_year.academic_year_name asc
      listen: {}
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
        Gender - fct_equity_gap.avg_gap_grade_points: "#4285F4"
        Disadvantage - fct_equity_gap.avg_gap_grade_points: "#EA4335"
        Ethnicity - fct_equity_gap.avg_gap_grade_points: "#34A853"
        SEND - fct_equity_gap.avg_gap_grade_points: "#FBBC04"
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
      row: 8
      col: 0
      width: 14
      height: 6

    - name: gap_movement_summary
      title: "Gap Movement Summary"
      type: looker_grid
      model: academic_analytics
      explore: fct_equity_gap
      fields:
        - fct_equity_gap.dimension_name
        - fct_equity_gap.gap_trend
        - fct_equity_gap.avg_gap_grade_points
      filters:
        dim_academic_year.is_current_year: "Yes"
      listen:
        academic_year: dim_academic_year.academic_year_name
      show_view_names: false
      show_row_numbers: false
      series_labels:
        fct_equity_gap.dimension_name: "Dimension"
        fct_equity_gap.gap_trend: "Trend"
        fct_equity_gap.avg_gap_grade_points: "Current Gap"
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
            - fct_equity_gap.avg_gap_grade_points
      row: 8
      col: 14
      width: 10
      height: 6

    # =====================================================================
    # Row 4: Demographic Breakdown Detail
    # =====================================================================

    - name: demographic_breakdown_table
      title: "Demographic Breakdown Detail"
      type: looker_grid
      model: academic_analytics
      explore: fct_enrolment
      fields:
        - fct_enrolment.gender
        - fct_enrolment.ethnicity
        - fct_enrolment.is_disadvantaged
        - fct_enrolment.cohort_count
        - fct_enrolment.pass_rate_pct
        - fct_enrolment.high_grade_pct
        - fct_enrolment.avg_grade_points
        - fct_enrolment.gap_vs_overall_pass_pp
      filters:
        dim_academic_year.is_current_year: "Yes"
      sorts:
        - fct_enrolment.cohort_count desc
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: dim_offering_type.offering_type_name
        subject: dim_offering.offering_name
      show_view_names: false
      show_row_numbers: true
      truncate_text: true
      series_labels:
        fct_enrolment.gender: "Gender"
        fct_enrolment.ethnicity: "Ethnicity"
        fct_enrolment.is_disadvantaged: "Disadvantaged"
        fct_enrolment.cohort_count: "Cohort"
        fct_enrolment.pass_rate_pct: "Pass %"
        fct_enrolment.high_grade_pct: "High %"
        fct_enrolment.avg_grade_points: "Avg Pts"
        fct_enrolment.gap_vs_overall_pass_pp: "Gap vs Overall"
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
            - fct_enrolment.gap_vs_overall_pass_pp
      row: 14
      col: 0
      width: 24
      height: 8

    # =====================================================================
    # Row 5: Additional Analysis Charts
    # =====================================================================

    - name: gender_by_subject
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
        subject: dim_offering.offering_name
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      legend_position: bottom
      series_colors:
        Female - fct_enrolment.pass_rate_pct: "#4285F4"
        Male - fct_enrolment.pass_rate_pct: "#FBBC04"
      row: 22
      col: 0
      width: 12
      height: 7

    - name: disadvantage_prior_attainment
      title: "Disadvantage Analysis by Prior Attainment"
      type: looker_grid
      model: academic_analytics
      explore: fct_enrolment
      fields:
        - fct_enrolment.prior_attainment_band
        - fct_enrolment.is_disadvantaged
        - fct_enrolment.pass_rate_pct
      pivots:
        - fct_enrolment.is_disadvantaged
      filters:
        dim_academic_year.is_current_year: "Yes"
        fct_enrolment.prior_attainment_band: "-N/A,-EMPTY"
      sorts:
        - fct_enrolment.prior_attainment_band asc
      listen:
        academic_year: dim_academic_year.academic_year_name
        qualification_type: dim_offering_type.offering_type_name
        subject: dim_offering.offering_name
      show_view_names: false
      show_row_numbers: false
      series_labels:
        fct_enrolment.prior_attainment_band: "Prior Attainment"
        fct_enrolment.pass_rate_pct: "Pass Rate %"
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
      row: 22
      col: 12
      width: 12
      height: 7
