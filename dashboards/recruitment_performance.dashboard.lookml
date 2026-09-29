# recruitment_performance.dashboard.lookml
#
# Recruitment funnel across the company website (rittmananalytics.com, Segment) and
# the Teamtailor careers site (careers.rittmananalytics.com, GA4). Every tile reads the
# Web Analytics explore and listens to one date filter on session start.
#
# The two sites give the same person different visitor IDs, so each funnel stage is
# counted on its own. The tiles cannot follow one person from menu click to application.

- dashboard: recruitment_performance
  title: Recruitment Performance
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "How candidates find us and apply: careers menu clicks and careers page views on the company website, then visits, job views and applications on the Teamtailor careers site."
  refresh: 1 hour
  crossfilter_enabled: false

  filters:
  - name: Date
    title: Date
    type: field_filter
    default_value: 12 months
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
    model: analytics
    explore: web_sessions_fact
    field: web_sessions_fact.session_start_ts_date

  elements:

  # ── Notes ─────────────────────────────────────────────────────────────────────

  - name: notes
    type: text
    title_text: Recruitment Performance
    subtitle_text: Company website and Teamtailor careers site
    body_text: |-
      **Funnel:** careers menu click → careers page (rittmananalytics.com/careers) → click to the careers site → job listing view → application.

      - The company website and the careers site give each person a different visitor ID, so each stage is counted separately.
      - Clicks from the careers page to the careers site are tracked from 25 Sep 2026. Visits from the company website are counted under *Company website* from 29 Sep 2026; before then most arrived as *Direct or shared link*.
      - No job applications have been recorded since 4 May 2026. Check the Teamtailor application tracking if this is still the case.
    row: 0
    col: 0
    width: 24
    height: 4

  # ── Headline numbers ──────────────────────────────────────────────────────────

  - title: Careers Menu Clicks
    name: kpi_menu_clicks
    model: analytics
    explore: web_sessions_fact
    type: single_value
    fields: [web_events_fact.total_careers_link_clicks]
    limit: 1
    show_single_value_title: true
    single_value_title: Careers Menu Clicks
    show_comparison: false
    listen:
      Date: web_sessions_fact.session_start_ts_date
    row: 4
    col: 0
    width: 4
    height: 4

  - title: Careers Page Views
    name: kpi_careers_page_views
    model: analytics
    explore: web_sessions_fact
    type: single_value
    fields: [web_events_fact.total_careers_page_views]
    limit: 1
    show_single_value_title: true
    single_value_title: Careers Page Views
    show_comparison: false
    listen:
      Date: web_sessions_fact.session_start_ts_date
    row: 4
    col: 4
    width: 4
    height: 4

  - title: Clicks to Careers Site
    name: kpi_click_throughs
    model: analytics
    explore: web_sessions_fact
    type: single_value
    fields: [web_events_fact.total_careers_page_clicks_to_careers_site]
    limit: 1
    show_single_value_title: true
    single_value_title: Clicks to Careers Site
    show_comparison: false
    listen:
      Date: web_sessions_fact.session_start_ts_date
    row: 4
    col: 8
    width: 4
    height: 4

  - title: Careers Site Visitors
    name: kpi_careers_site_visitors
    model: analytics
    explore: web_sessions_fact
    type: single_value
    fields: [web_events_fact.total_careers_site_visitors]
    limit: 1
    show_single_value_title: true
    single_value_title: Careers Site Visitors
    show_comparison: false
    listen:
      Date: web_sessions_fact.session_start_ts_date
    row: 4
    col: 12
    width: 4
    height: 4

  - title: Job Applications
    name: kpi_job_applications
    model: analytics
    explore: web_sessions_fact
    type: single_value
    fields: [web_events_fact.total_job_applications]
    limit: 1
    show_single_value_title: true
    single_value_title: Job Applications
    show_comparison: false
    listen:
      Date: web_sessions_fact.session_start_ts_date
    row: 4
    col: 16
    width: 4
    height: 4

  - title: Application Rate
    name: kpi_application_rate
    model: analytics
    explore: web_sessions_fact
    type: single_value
    fields: [web_events_fact.careers_site_application_rate]
    limit: 1
    show_single_value_title: true
    single_value_title: Applicants per Careers Site Visitor
    show_comparison: false
    listen:
      Date: web_sessions_fact.session_start_ts_date
    row: 4
    col: 20
    width: 4
    height: 4

  # ── Funnel and trend ──────────────────────────────────────────────────────────

  - title: Recruitment Funnel
    name: funnel
    model: analytics
    explore: web_sessions_fact
    type: looker_bar
    fields: [web_events_fact.careers_funnel_stage, web_events_fact.total_recruitment_funnel_events,
      web_events_fact.total_recruitment_funnel_people]
    filters:
      web_events_fact.careers_funnel_stage: "-NULL"
    sorts: [web_events_fact.careers_funnel_stage]
    limit: 10
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    stacking: ''
    series_labels:
      web_events_fact.total_recruitment_funnel_events: Events
      web_events_fact.total_recruitment_funnel_people: People
    listen:
      Date: web_sessions_fact.session_start_ts_date
    row: 8
    col: 0
    width: 12
    height: 8

  - title: Careers Site Visitors and Applications by Month
    name: monthly_trend
    model: analytics
    explore: web_sessions_fact
    type: looker_column
    fields: [web_sessions_fact.session_start_ts_month, web_events_fact.total_careers_site_visitors,
      web_events_fact.total_job_applications]
    fill_fields: [web_sessions_fact.session_start_ts_month]
    filters:
      web_sessions_fact.is_careers_site_session: "Yes"
    sorts: [web_sessions_fact.session_start_ts_month]
    limit: 500
    show_value_labels: false
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    series_types:
      web_events_fact.total_job_applications: line
    series_labels:
      web_events_fact.total_careers_site_visitors: Visitors
      web_events_fact.total_job_applications: Applications
    y_axes:
    - label: Visitors
      orientation: left
      series:
      - id: web_events_fact.total_careers_site_visitors
        name: Visitors
    - label: Applications
      orientation: right
      series:
      - id: web_events_fact.total_job_applications
        name: Applications
    listen:
      Date: web_sessions_fact.session_start_ts_date
    row: 8
    col: 12
    width: 12
    height: 8

  # ── How candidates arrive ─────────────────────────────────────────────────────

  - title: Careers Site Sessions by Route
    name: sessions_by_route
    model: analytics
    explore: web_sessions_fact
    type: looker_bar
    fields: [web_sessions_fact.careers_entry_route, web_sessions_fact.total_sessions]
    filters:
      web_sessions_fact.is_careers_site_session: "Yes"
    sorts: [web_sessions_fact.total_sessions desc]
    limit: 20
    show_value_labels: true
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    series_labels:
      web_sessions_fact.total_sessions: Sessions
    listen:
      Date: web_sessions_fact.session_start_ts_date
    row: 16
    col: 0
    width: 10
    height: 8

  - title: Applications by Route
    name: applications_by_route
    model: analytics
    explore: web_sessions_fact
    type: looker_grid
    fields: [web_sessions_fact.careers_entry_route, web_sessions_fact.total_sessions,
      web_events_fact.total_careers_site_visitors, web_events_fact.total_job_applicants,
      web_events_fact.total_job_applications, web_events_fact.careers_site_application_rate]
    filters:
      web_sessions_fact.is_careers_site_session: "Yes"
    sorts: [web_events_fact.total_job_applications desc]
    limit: 20
    show_row_numbers: false
    show_totals: true
    show_view_names: false
    series_labels:
      web_sessions_fact.careers_entry_route: Route
      web_sessions_fact.total_sessions: Sessions
      web_events_fact.total_careers_site_visitors: Visitors
      web_events_fact.total_job_applicants: Applicants
      web_events_fact.total_job_applications: Applications
      web_events_fact.careers_site_application_rate: Application Rate
    listen:
      Date: web_sessions_fact.session_start_ts_date
    row: 16
    col: 10
    width: 14
    height: 8

  - title: Careers Page Views by Channel
    name: careers_page_by_channel
    model: analytics
    explore: web_sessions_fact
    type: looker_bar
    fields: [web_sessions_fact.channel, web_events_fact.total_careers_page_views]
    filters:
      web_events_fact.careers_funnel_stage: "2. Careers page view"
    sorts: [web_events_fact.total_careers_page_views desc]
    limit: 20
    show_value_labels: true
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    series_labels:
      web_events_fact.total_careers_page_views: Careers Page Views
    note_state: collapsed
    note_display: hover
    note_text: "Company website sessions that viewed rittmananalytics.com/careers, by the session's marketing channel. LinkedIn ads appear as Paid Social when tagged utm_medium=paid."
    listen:
      Date: web_sessions_fact.session_start_ts_date
    row: 24
    col: 0
    width: 10
    height: 8

  - title: Clicks from the Careers Page
    name: careers_page_clicks
    model: analytics
    explore: web_sessions_fact
    type: looker_bar
    fields: [web_events_fact.event_details, web_events_fact.total_careers_page_clicks_to_careers_site]
    filters:
      web_events_fact.careers_funnel_stage: "3. Click to careers site"
    sorts: [web_events_fact.total_careers_page_clicks_to_careers_site desc]
    limit: 10
    show_value_labels: true
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    series_labels:
      web_events_fact.event_details: Button
      web_events_fact.total_careers_page_clicks_to_careers_site: Clicks
    listen:
      Date: web_sessions_fact.session_start_ts_date
    row: 24
    col: 10
    width: 9
    height: 8

  - title: Talent Community Joins
    name: kpi_talent_community
    model: analytics
    explore: web_sessions_fact
    type: single_value
    fields: [web_events_fact.total_talent_community_joins]
    limit: 1
    show_single_value_title: true
    single_value_title: Talent Community Joins
    show_comparison: false
    listen:
      Date: web_sessions_fact.session_start_ts_date
    row: 24
    col: 19
    width: 5
    height: 8

  # ── Roles ─────────────────────────────────────────────────────────────────────

  - title: Job Views and Applications by Role
    name: roles
    model: analytics
    explore: web_sessions_fact
    type: looker_grid
    fields: [web_events_fact.job_title, web_events_fact.total_job_listing_views, web_events_fact.total_job_applicants,
      web_events_fact.total_job_applications]
    filters:
      web_events_fact.job_title: "-NULL"
    sorts: [web_events_fact.total_job_applications desc]
    limit: 50
    show_row_numbers: false
    show_totals: true
    show_view_names: false
    series_labels:
      web_events_fact.job_title: Role
      web_events_fact.total_job_listing_views: Job Page Views
      web_events_fact.total_job_applicants: Applicants
      web_events_fact.total_job_applications: Applications
    listen:
      Date: web_sessions_fact.session_start_ts_date
    row: 32
    col: 0
    width: 24
    height: 8
