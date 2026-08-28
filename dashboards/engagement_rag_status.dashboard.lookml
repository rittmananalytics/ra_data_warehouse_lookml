# engagement_health.dashboard.lookml
#
# The engagement health board. Drop this file into your Looker project alongside the
# view and explore files, and change `model: analytics` below if your model is named
# differently.
#
# Three filters drive the whole page. Every tile listens to all three, using the same
# field names on whichever explore that tile reads, so the five explores behave as one
# dashboard.
#
# Tiles that are worth knowing about:
#   - The status tiles follow the RAG Status tile on the existing board: a looker_grid
#     with a large rows_font_size, the keys hidden, and the colour carried in the view's
#     html. Looker's own conditional formatting only applies to numbers, and these are
#     words.
#   - The sprint burn table uses cell visualisations for Budget Used % and conditional
#     formatting on Sprint State.
#   - The sprint timeline is looker_timeline, which needs the row label, a start date and
#     an end date, in that order. This is the one tile with no equivalent on the existing
#     board, so its options are a best reading of the spec rather than a copy.

- dashboard: engagement_health
  title: Engagement Health and Commentary
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "One engagement, one month. Delivery and commercial status computed from Harvest and Xero, with written commentary and the actions that follow from it."
  refresh: 30 minutes
  crossfilter_enabled: false
  tabs:
  - name: ''
    label: ''

  elements:

  # ── Banner ────────────────────────────────────────────────────────────────────

  - title: Engagement
    name: banner
    model: analytics
    explore: engagement_health_fact
    type: single_value
    fields: [engagement_health_fact.engagement_name]
    limit: 1
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    font_size: "large"
    text_color: "#3a4245"
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
      Reporting Month: engagement_health_fact.reporting_month_month
    row: 0
    col: 0
    width: 24
    height: 3
    tab_name: ''

  # ── Six single value tiles ────────────────────────────────────────────────────

  - title: Budget Used
    name: kpi_budget_used
    model: analytics
    explore: engagement_health_fact
    type: single_value
    fields: [engagement_health_fact.budget_used_pct_value]
    limit: 1
    value_format: '0"%"'
    single_value_title: Budget Used
    show_single_value_title: true
    show_comparison: false
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
      Reporting Month: engagement_health_fact.reporting_month_month
    row: 3
    col: 0
    width: 4
    height: 3
    tab_name: ''

  - title: Through Scheduled Days
    name: kpi_elapsed
    model: analytics
    explore: engagement_health_fact
    type: single_value
    fields: [engagement_health_fact.elapsed_pct_value]
    limit: 1
    value_format: '0"%"'
    single_value_title: Through Scheduled Days
    show_single_value_title: true
    show_comparison: false
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
      Reporting Month: engagement_health_fact.reporting_month_month
    row: 3
    col: 4
    width: 4
    height: 3
    tab_name: ''

  - title: Budget Exhausted On
    name: kpi_budget_exhausted
    model: analytics
    explore: engagement_health_fact
    type: single_value
    fields: [engagement_health_fact.budget_exhausted_date]
    limit: 1
    single_value_title: Budget Exhausted On
    show_single_value_title: true
    show_comparison: false
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
      Reporting Month: engagement_health_fact.reporting_month_month
    row: 3
    col: 8
    width: 4
    height: 3
    tab_name: ''

  - title: Realised Hourly Rate
    name: kpi_realised_rate
    model: analytics
    explore: engagement_health_fact
    type: single_value
    fields: [engagement_health_fact.realised_rate_value]
    limit: 1
    value_format: '"£"#,##0'
    single_value_title: Realised Hourly Rate
    show_single_value_title: true
    show_comparison: false
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
      Reporting Month: engagement_health_fact.reporting_month_month
    row: 3
    col: 12
    width: 4
    height: 3
    tab_name: ''

  - title: Earned Margin
    name: kpi_margin
    model: analytics
    explore: engagement_health_fact
    type: single_value
    fields: [engagement_health_fact.earned_margin_pct_value]
    limit: 1
    value_format: '0"%"'
    single_value_title: Earned Margin
    show_single_value_title: true
    show_comparison: false
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
      Reporting Month: engagement_health_fact.reporting_month_month
    row: 3
    col: 16
    width: 4
    height: 3
    tab_name: ''

  - title: Invoiced And Past Due
    name: kpi_past_due
    model: analytics
    explore: engagement_health_fact
    type: single_value
    fields: [engagement_health_fact.overdue_amount_value]
    limit: 1
    value_format: '"£"#,##0'
    single_value_title: Invoiced And Past Due
    show_single_value_title: true
    show_comparison: false
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
      Reporting Month: engagement_health_fact.reporting_month_month
    row: 3
    col: 20
    width: 4
    height: 3
    tab_name: ''

  # ── Status row ────────────────────────────────────────────────────────────────
  # Same pattern as the RAG Status tile on the existing board: a grid with a large row
  # font, the keys hidden, and the colour carried in the view's html. Looker's own
  # conditional formatting only applies to numbers, and these are words.

  - title: Overall
    name: status_overall
    model: analytics
    explore: engagement_health_fact
    type: looker_grid
    fields:
    - engagement_health_fact.engagement_code
    - engagement_health_fact.overall_status_block
    hidden_fields: [engagement_health_fact.engagement_code]
    limit: 1
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: true
    hide_row_totals: true
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '1'
    enable_conditional_formatting: false
    header_text_alignment: center
    header_font_size: '14'
    rows_font_size: '55'
    show_sql_query_menu_options: false
    minimum_column_width: 75
    series_labels:
      engagement_health_fact.overall_status_block: Overall
    defaults_version: 1
    title_hidden: true
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
      Reporting Month: engagement_health_fact.reporting_month_month
    row: 6
    col: 0
    width: 5
    height: 4
    tab_name: ''

  - title: RAG Status
    name: status_areas
    model: analytics
    explore: engagement_health_fact
    type: looker_grid
    fields:
    - engagement_health_fact.engagement_code
    - engagement_health_fact.delivery_status_block
    - engagement_health_fact.commercial_status_block
    - engagement_health_fact.client_status_block
    hidden_fields: [engagement_health_fact.engagement_code]
    limit: 1
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: true
    hide_row_totals: true
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '1'
    enable_conditional_formatting: false
    header_text_alignment: center
    header_font_size: '14'
    rows_font_size: '32'
    show_sql_query_menu_options: false
    minimum_column_width: 75
    series_labels:
      engagement_health_fact.delivery_status_block: Delivery
      engagement_health_fact.commercial_status_block: Commercial
      engagement_health_fact.client_status_block: Client
    defaults_version: 1
    title_hidden: true
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
      Reporting Month: engagement_health_fact.reporting_month_month
    row: 6
    col: 5
    width: 19
    height: 4
    tab_name: ''

  # ── Captions and commentary ───────────────────────────────────────────────────
  # One tile, three columns, as on the existing board's commentary row.

  - title: What Drove Each Status
    name: status_captions
    model: analytics
    explore: engagement_health_fact
    type: looker_grid
    fields:
    - engagement_health_fact.delivery_status_caption
    - engagement_health_fact.commercial_status_caption
    - engagement_health_fact.client_status_caption
    limit: 1
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    truncate_header: false
    hide_totals: true
    hide_row_totals: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '1'
    enable_conditional_formatting: false
    header_text_alignment: center
    header_font_size: '12'
    rows_font_size: '12'
    show_sql_query_menu_options: false
    series_labels:
      engagement_health_fact.delivery_status_caption: Delivery
      engagement_health_fact.commercial_status_caption: Commercial
      engagement_health_fact.client_status_caption: Client
    defaults_version: 1
    title_hidden: true
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
      Reporting Month: engagement_health_fact.reporting_month_month
    row: 10
    col: 0
    width: 24
    height: 3
    tab_name: ''

  - title: Commentary
    name: commentary
    model: analytics
    explore: engagement_health_fact
    type: looker_grid
    fields:
    - engagement_health_fact.delivery_commentary
    - engagement_health_fact.commercial_commentary
    - engagement_health_fact.client_commentary
    limit: 1
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    truncate_header: false
    hide_totals: true
    hide_row_totals: true
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '1'
    enable_conditional_formatting: false
    header_text_alignment: center
    header_font_size: '12'
    rows_font_size: '12'
    show_sql_query_menu_options: false
    series_labels:
      engagement_health_fact.delivery_commentary: Delivery
      engagement_health_fact.commercial_commentary: Commercial
      engagement_health_fact.client_commentary: Client
    defaults_version: 1
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
      Reporting Month: engagement_health_fact.reporting_month_month
    row: 13
    col: 0
    width: 24
    height: 5
    tab_name: ''

  # ── Delivery section ──────────────────────────────────────────────────────────

  - title: ""
    name: section_delivery
    type: text
    title_text: ""
    subtitle_text: ""
    body_text: "<div style='text-align:center;font-size:14px;color:#5a6467;padding-top:6px'>Delivery</div>"
    row: 18
    col: 0
    width: 24
    height: 2
    tab_name: ''

  - title: Budget Burn-up
    name: burn_up
    model: analytics
    explore: engagement_burn_up_fact
    type: looker_line
    fields:
    - engagement_burn_up_fact.week_start_date
    - engagement_burn_up_fact.cumulative_hours
    - engagement_burn_up_fact.projected_cumulative_hours
    - engagement_burn_up_fact.budget_line_hours
    sorts: [engagement_burn_up_fact.week_start_date]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    y_axis_labels: ["Hours"]
    point_style: circle
    interpolation: linear
    series_types: {}
    series_colors:
      engagement_burn_up_fact.cumulative_hours: "#4285F4"
      engagement_burn_up_fact.projected_cumulative_hours: "#EA4335"
      engagement_burn_up_fact.budget_line_hours: "#FF6D00"
    series_line_widths:
      engagement_burn_up_fact.budget_line_hours: 2
    label_density: 25
    legend_position: center
    hidden_series: []
    listen:
      Company Name: engagement_burn_up_fact.company_name
      Engagement Name: engagement_burn_up_fact.engagement_name
    row: 20
    col: 0
    width: 14
    height: 7
    tab_name: ''

  - title: Sprint Timeline
    name: sprint_timeline
    model: analytics
    explore: engagement_sprint_burn_fact
    type: looker_timeline
    fields:
    - engagement_sprint_burn_fact.sprint_name
    - engagement_sprint_burn_fact.sprint_start_date
    - engagement_sprint_burn_fact.sprint_end_date
    - engagement_sprint_burn_fact.sprint_state
    sorts: [engagement_sprint_burn_fact.sprint_start_date]
    limit: 100
    groupBars: true
    labelSize: 10pt
    showLegend: true
    color_application:
      collection_id: legacy
      palette_id: looker_classic
    listen:
      Company Name: engagement_sprint_burn_fact.company_name
      Engagement Name: engagement_sprint_burn_fact.engagement_name
      Reporting Month: engagement_sprint_burn_fact.reporting_month_month
    row: 20
    col: 14
    width: 10
    height: 7
    tab_name: ''

  - title: Sprint Burn
    name: sprint_burn
    model: analytics
    explore: engagement_sprint_burn_fact
    type: looker_grid
    fields:
    - engagement_sprint_burn_fact.sprint_name
    - engagement_sprint_burn_fact.sprint_window
    - engagement_sprint_burn_fact.sprint_budget_hours
    - engagement_sprint_burn_fact.sprint_hours_to_date
    - engagement_sprint_burn_fact.sprint_budget_used_pct
    - engagement_sprint_burn_fact.sprint_state
    - engagement_sprint_burn_fact.last_hours_booked_date
    sorts: [engagement_sprint_burn_fact.sprint_start_date]
    limit: 100
    show_row_numbers: true
    show_view_names: false
    hide_totals: true
    hide_row_totals: true
    table_theme: white
    truncate_column_names: false
    header_font_size: 11
    rows_font_size: 12
    # Data bar behind Budget Used %, as on the Engagement Objectives tile
    series_cell_visualizations:
      engagement_sprint_burn_fact.sprint_budget_used_pct:
        is_active: true
        palette:
          palette_id: sprint_burn_bar
          collection_id: legacy
    conditional_formatting:
    - type: equal to
      value: null
      background_color: "#F8D7D3"
      font_color: "#8B2015"
      color_application:
        collection_id: legacy
        palette_id: red
      bold: false
      italic: false
      strikethrough: false
      fields: [engagement_sprint_burn_fact.sprint_state]
      options:
        steps: 5
      string_value: "Over budget, in flight"
    - type: equal to
      value: null
      background_color: "#F8D7D3"
      font_color: "#8B2015"
      bold: false
      italic: false
      strikethrough: false
      fields: [engagement_sprint_burn_fact.sprint_state]
      string_value: "Not started, late"
    - type: equal to
      value: null
      background_color: "#F8D7D3"
      font_color: "#8B2015"
      bold: false
      italic: false
      strikethrough: false
      fields: [engagement_sprint_burn_fact.sprint_state]
      string_value: "Closed over budget"
    - type: equal to
      value: null
      background_color: "#FBE9CF"
      font_color: "#8A5A15"
      bold: false
      italic: false
      strikethrough: false
      fields: [engagement_sprint_burn_fact.sprint_state]
      string_value: "At budget, in flight"
    - type: equal to
      value: null
      background_color: "#D6EBD8"
      font_color: "#1F5222"
      bold: false
      italic: false
      strikethrough: false
      fields: [engagement_sprint_burn_fact.sprint_state]
      string_value: "Closed on budget"
    listen:
      Company Name: engagement_sprint_burn_fact.company_name
      Engagement Name: engagement_sprint_burn_fact.engagement_name
      Reporting Month: engagement_sprint_burn_fact.reporting_month_month
    row: 27
    col: 0
    width: 24
    height: 7
    tab_name: ''

  # ── Commercial section ────────────────────────────────────────────────────────

  - title: ""
    name: section_commercial
    type: text
    body_text: "<div style='text-align:center;font-size:14px;color:#5a6467;padding-top:6px'>Commercial and Cash</div>"
    row: 34
    col: 0
    width: 24
    height: 2
    tab_name: ''

  - title: Hours, Revenue and Cost by Month
    name: monthly_trend
    model: analytics
    explore: engagement_health_fact
    type: looker_column
    fields:
    - engagement_health_fact.reporting_month_month
    - engagement_health_fact.total_hours_in_month
    - engagement_health_fact.total_revenue_in_month_gbp
    - engagement_health_fact.total_delivery_cost_in_month_gbp
    sorts: [engagement_health_fact.reporting_month_month]
    limit: 24
    show_view_names: false
    series_types:
      engagement_health_fact.total_revenue_in_month_gbp: line
      engagement_health_fact.total_delivery_cost_in_month_gbp: line
    series_colors:
      engagement_health_fact.total_hours_in_month: "#4285F4"
      engagement_health_fact.total_revenue_in_month_gbp: "#34A853"
      engagement_health_fact.total_delivery_cost_in_month_gbp: "#EA4335"
    y_axes:
    - label: Hours
      orientation: left
      series:
      - id: engagement_health_fact.total_hours_in_month
        name: Hours
      showLabels: true
      showValues: true
      tickDensity: default
      type: linear
    - label: "£"
      orientation: right
      series:
      - id: engagement_health_fact.total_revenue_in_month_gbp
        name: Revenue
      - id: engagement_health_fact.total_delivery_cost_in_month_gbp
        name: Cost
      showLabels: true
      showValues: true
      tickDensity: default
      type: linear
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    # The month filter is deliberately not applied here: this tile is the trend.
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
    row: 36
    col: 0
    width: 9
    height: 7
    tab_name: ''

  - title: Where the Revenue Went
    name: revenue_split
    model: analytics
    explore: engagement_health_fact
    type: looker_pie
    fields:
    - engagement_health_fact.labour_cost_to_date_gbp
    - engagement_health_fact.expense_cost_to_date_gbp
    - engagement_health_fact.revenue_to_date_gbp
    limit: 1
    value_labels: legend
    label_type: labPer
    inner_radius: 55
    series_colors:
      engagement_health_fact.labour_cost_to_date_gbp: "#4285F4"
      engagement_health_fact.expense_cost_to_date_gbp: "#FF6D00"
      engagement_health_fact.revenue_to_date_gbp: "#34A853"
    note_state: collapsed
    note_display: below
    note_text: "Labour and expenses to date, against recognised revenue to date."
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
      Reporting Month: engagement_health_fact.reporting_month_month
    row: 36
    col: 9
    width: 7
    height: 7
    tab_name: ''

  - title: Open and Overdue Invoices
    name: invoices
    model: analytics
    explore: engagement_health_fact
    type: looker_grid
    fields:
    - engagement_health_fact.overdue_invoice_count
    - engagement_health_fact.overdue_amount_gbp
    - engagement_health_fact.max_days_overdue
    - engagement_health_fact.open_invoice_amount_gbp
    limit: 1
    show_row_numbers: false
    show_view_names: false
    hide_totals: true
    hide_row_totals: true
    table_theme: white
    truncate_column_names: false
    header_font_size: 11
    rows_font_size: 12
    conditional_formatting:
    - type: greater than
      value: 30
      background_color: "#F8D7D3"
      font_color: "#8B2015"
      bold: false
      italic: false
      strikethrough: false
      fields: [engagement_health_fact.max_days_overdue]
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
      Reporting Month: engagement_health_fact.reporting_month_month
    row: 36
    col: 16
    width: 8
    height: 7
    tab_name: ''

  # ── Actions ───────────────────────────────────────────────────────────────────

  - title: ""
    name: section_actions
    type: text
    body_text: "<div style='text-align:center;font-size:14px;color:#5a6467;padding-top:6px'>Actions</div>"
    row: 43
    col: 0
    width: 24
    height: 2
    tab_name: ''

  - title: Actions for the Month
    name: actions
    model: analytics
    explore: engagement_actions_fact
    type: looker_grid
    fields:
    - engagement_actions_fact.status_area
    - engagement_actions_fact.status_area_status
    - engagement_actions_fact.priority
    - engagement_actions_fact.owner
    - engagement_actions_fact.action
    - engagement_actions_fact.triggered_by
    sorts:
    - engagement_actions_fact.status_sort_order
    - engagement_actions_fact.status_area
    - engagement_actions_fact.priority
    limit: 50
    show_row_numbers: true
    show_view_names: false
    hide_totals: true
    hide_row_totals: true
    table_theme: white
    truncate_column_names: false
    header_font_size: 11
    rows_font_size: 12
    conditional_formatting:
    - type: equal to
      value: null
      background_color: "#F8D7D3"
      font_color: "#8B2015"
      bold: false
      italic: false
      strikethrough: false
      fields: [engagement_actions_fact.status_area_status]
      string_value: "RED"
    - type: equal to
      value: null
      background_color: "#FBE9CF"
      font_color: "#8A5A15"
      bold: false
      italic: false
      strikethrough: false
      fields: [engagement_actions_fact.status_area_status]
      string_value: "AMBER"
    listen:
      Company Name: engagement_actions_fact.company_name
      Engagement Name: engagement_actions_fact.engagement_name
      Reporting Month: engagement_actions_fact.reporting_month_month
    row: 45
    col: 0
    width: 24
    height: 7
    tab_name: ''

  # ── Client contact ────────────────────────────────────────────────────────────

  - title: ""
    name: section_client
    type: text
    body_text: "<div style='text-align:center;font-size:14px;color:#5a6467;padding-top:6px'>Client Contact</div>"
    row: 52
    col: 0
    width: 24
    height: 2
    tab_name: ''

  - title: Meetings and Sentiment by Month
    name: client_contact
    model: analytics
    explore: engagement_health_fact
    type: looker_column
    fields:
    - engagement_health_fact.reporting_month_month
    - engagement_health_fact.contact_meetings_in_month
    - engagement_health_fact.contact_sentiment_score
    sorts: [engagement_health_fact.reporting_month_month]
    limit: 24
    show_view_names: false
    series_types:
      engagement_health_fact.contact_sentiment_score: line
    series_colors:
      engagement_health_fact.contact_meetings_in_month: "#7E57C2"
      engagement_health_fact.contact_sentiment_score: "#FBBC04"
    y_axes:
    - label: Meetings
      orientation: left
      series:
      - id: engagement_health_fact.contact_meetings_in_month
        name: Meetings
      showLabels: true
      showValues: true
      type: linear
    - label: Sentiment
      orientation: right
      series:
      - id: engagement_health_fact.contact_sentiment_score
        name: Sentiment
      showLabels: true
      showValues: true
      minValue: -1
      maxValue: 1
      type: linear
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    listen:
      Company Name: engagement_health_fact.company_name
      Engagement Name: engagement_health_fact.engagement_name
    row: 54
    col: 0
    width: 12
    height: 6
    tab_name: ''

  - title: Context Behind the Client Tile
    name: client_context
    model: analytics
    explore: engagement_context_attribution
    type: looker_grid
    fields:
    - engagement_context_attribution.source_system
    - engagement_context_attribution.attribution_method
    - engagement_context_attribution.item_count
    pivots: []
    sorts: [engagement_context_attribution.item_count desc]
    limit: 20
    show_row_numbers: false
    show_view_names: false
    hide_totals: false
    hide_row_totals: true
    table_theme: white
    truncate_column_names: false
    header_font_size: 11
    rows_font_size: 12
    note_state: collapsed
    note_display: below
    note_text: "How each piece of context reached this engagement. client_meeting_fanout means a generic client meeting counted against every live engagement."
    listen:
      Company Name: engagement_context_attribution.company_name
      Engagement Name: engagement_context_attribution.engagement_name
      Reporting Month: engagement_context_attribution.item_month
    row: 54
    col: 12
    width: 12
    height: 6
    tab_name: ''

  filters:

  - name: Company Name
    title: Company Name
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: analytics
    explore: engagement_health_fact
    listens_to_filters: []
    field: engagement_health_fact.company_name

  - name: Engagement Name
    title: Engagement Name
    type: field_filter
    default_value: ""
    allow_multiple_values: false
    required: true
    ui_config:
      type: dropdown_menu
      display: inline
    model: analytics
    explore: engagement_health_fact
    listens_to_filters: [Company Name]
    field: engagement_health_fact.engagement_name

  - name: Reporting Month
    title: Reporting Month
    type: field_filter
    default_value: 1 months
    allow_multiple_values: false
    required: true
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    model: analytics
    explore: engagement_health_fact
    listens_to_filters: []
    field: engagement_health_fact.reporting_month_month
