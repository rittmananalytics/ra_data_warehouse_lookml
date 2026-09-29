# recruitment_performance.dashboard.lookml
#
# Recruitment funnel across the company website (rittmananalytics.com, Segment), the
# Teamtailor careers site (careers.rittmananalytics.com, GA4) and Teamtailor itself.
#
# Two explores:
#   - web_sessions_fact (Web Analytics): menu clicks, careers page, careers-site visits,
#     job page views and site applications. Visitors who decline cookies are not tracked.
#   - recruitment_applications: every application in Teamtailor, including LinkedIn,
#     Indeed and recruiter-added candidates. This is the application count of record.
#
# Filters:
#   - Date: session start on web tiles, application created date on Teamtailor tiles.
#   - Role: Teamtailor job title. Web tiles match it through careers_job, joined on the
#     job ID in careers-site page paths. Company-website tiles (menu clicks, careers page,
#     clicks to the careers site, funnel) have no role and do not listen to it.
#
# The company website and careers site give each person a different visitor ID, so the
# web funnel counts each stage separately.

- dashboard: recruitment_performance
  title: Recruitment Performance
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "How candidates find us and apply: careers menu and careers page on the company website, job page views on the Teamtailor careers site, and applications recorded in Teamtailor. Filter by date and role."
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

  - name: Role
    title: Role
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: analytics
    explore: recruitment_applications
    field: recruiting_jobs_dim.job_title

  elements:

  # ── Notes ─────────────────────────────────────────────────────────────────────

  - name: notes
    type: text
    title_text: Recruitment Performance
    subtitle_text: Company website, Teamtailor careers site and Teamtailor applications
    body_text: |-
      - **Applications** come from Teamtailor and include every route: the careers site, LinkedIn, Indeed, job boards and candidates added by a recruiter.
      - **Site applications** are applications made on the careers site, counted from the application confirmation page, including visitors who declined cookies. **Site applicants** and the application rates cover only visitors who accepted cookies, so they can be compared with job page views for the same visitors.
      - Tiles marked **(all roles)** are on the company website and do not change with the Role filter.
      - Visits from the company website are counted under *Company website* from 29 Sep 2026. Before then most arrived as *Direct or shared link*.
    row: 0
    col: 0
    width: 24
    height: 5

  # ── Headline numbers ──────────────────────────────────────────────────────────

  - title: Careers Menu Clicks (all roles)
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
    row: 5
    col: 0
    width: 4
    height: 4

  - title: Careers Page Views (all roles)
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
    row: 5
    col: 4
    width: 4
    height: 4

  - title: Clicks to Careers Site (all roles)
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
    row: 5
    col: 8
    width: 4
    height: 4

  - title: Job Page Viewers
    name: kpi_job_page_viewers
    model: analytics
    explore: web_sessions_fact
    type: single_value
    fields: [web_events_fact.total_job_page_viewers]
    limit: 1
    show_single_value_title: true
    single_value_title: Job Page Viewers
    show_comparison: false
    listen:
      Date: web_sessions_fact.session_start_ts_date
      Role: careers_job.job_title
    row: 5
    col: 12
    width: 4
    height: 4

  - title: Applications
    name: kpi_applications
    model: analytics
    explore: recruitment_applications
    type: single_value
    fields: [recruiting_job_applications_fact.total_applications]
    limit: 1
    show_single_value_title: true
    single_value_title: Applications (Teamtailor)
    show_comparison: false
    listen:
      Date: recruiting_job_applications_fact.job_application_created_date
      Role: recruiting_jobs_dim.job_title
    row: 5
    col: 16
    width: 4
    height: 4

  - title: Recruiter-Added Candidates
    name: kpi_recruiter_added
    model: analytics
    explore: recruitment_applications
    type: single_value
    fields: [recruiting_job_applications_fact.total_recruiter_added_candidates]
    limit: 1
    show_single_value_title: true
    single_value_title: Recruiter-Added Candidates
    show_comparison: false
    listen:
      Date: recruiting_job_applications_fact.job_application_created_date
      Role: recruiting_jobs_dim.job_title
    row: 5
    col: 20
    width: 4
    height: 4

  # ── Applications (Teamtailor) ─────────────────────────────────────────────────

  - title: Applications by Month and Source
    name: applications_by_month
    model: analytics
    explore: recruitment_applications
    type: looker_column
    fields: [recruiting_job_applications_fact.job_application_created_month, recruiting_job_applications_fact.application_source,
      recruiting_job_applications_fact.total_applications]
    pivots: [recruiting_job_applications_fact.application_source]
    fill_fields: [recruiting_job_applications_fact.job_application_created_month]
    filters:
      recruiting_job_applications_fact.is_candidate_application: "Yes"
    sorts: [recruiting_job_applications_fact.job_application_created_month, recruiting_job_applications_fact.application_source]
    limit: 500
    stacking: normal
    show_value_labels: false
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    listen:
      Date: recruiting_job_applications_fact.job_application_created_date
      Role: recruiting_jobs_dim.job_title
    row: 9
    col: 0
    width: 14
    height: 8

  - title: Applications by Source
    name: applications_by_source
    model: analytics
    explore: recruitment_applications
    type: looker_bar
    fields: [recruiting_job_applications_fact.application_source, recruiting_job_applications_fact.total_applications]
    filters:
      recruiting_job_applications_fact.is_candidate_application: "Yes"
    sorts: [recruiting_job_applications_fact.total_applications desc]
    limit: 20
    show_value_labels: true
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    series_labels:
      recruiting_job_applications_fact.total_applications: Applications
    listen:
      Date: recruiting_job_applications_fact.job_application_created_date
      Role: recruiting_jobs_dim.job_title
    row: 9
    col: 14
    width: 10
    height: 8

  # ── Roles ─────────────────────────────────────────────────────────────────────

  - title: Applications by Role
    name: applications_by_role
    model: analytics
    explore: recruitment_applications
    type: looker_grid
    fields: [recruiting_jobs_dim.job_title, recruiting_job_applications_fact.total_applications,
      recruiting_job_applications_fact.total_recruiter_added_candidates]
    sorts: [recruiting_job_applications_fact.total_applications desc]
    limit: 50
    show_row_numbers: false
    show_totals: true
    show_view_names: false
    series_labels:
      recruiting_jobs_dim.job_title: Role
      recruiting_job_applications_fact.total_applications: Applications
      recruiting_job_applications_fact.total_recruiter_added_candidates: Recruiter-Added
    note_state: collapsed
    note_display: hover
    note_text: "From Teamtailor. Applications are candidates who applied themselves, by any route. Recruiter-Added are candidates a recruiter added to the job."
    listen:
      Date: recruiting_job_applications_fact.job_application_created_date
      Role: recruiting_jobs_dim.job_title
    row: 17
    col: 0
    width: 10
    height: 8

  - title: Job Page Conversion by Role
    name: job_page_conversion_by_role
    model: analytics
    explore: web_sessions_fact
    type: looker_grid
    fields: [careers_job.job_title, web_events_fact.total_job_detail_views, web_events_fact.total_job_page_viewers,
      web_events_fact.total_job_applicants, web_events_fact.job_page_application_rate, web_events_fact.total_job_applications]
    filters:
      careers_job.job_title: "-NULL"
    sorts: [web_events_fact.total_job_page_viewers desc]
    limit: 50
    show_row_numbers: false
    show_totals: true
    show_view_names: false
    series_labels:
      careers_job.job_title: Role
      web_events_fact.total_job_detail_views: Job Page Views
      web_events_fact.total_job_page_viewers: Job Page Viewers
      web_events_fact.total_job_applicants: Site Applicants
      web_events_fact.job_page_application_rate: Viewers Who Applied
      web_events_fact.total_job_applications: Site Applications
    note_state: collapsed
    note_display: hover
    note_text: "Job Page Viewers, Site Applicants and Viewers Who Applied cover visitors who accepted cookies. Site Applications also includes visitors who declined cookies. Applications via LinkedIn Easy Apply, Indeed or a recruiter are not on the careers site, so see Applications by Role for the full count."
    listen:
      Date: web_sessions_fact.session_start_ts_date
      Role: careers_job.job_title
    row: 17
    col: 10
    width: 14
    height: 8

  # ── Careers site ──────────────────────────────────────────────────────────────

  - title: Job Page Viewers and Site Applications by Month
    name: monthly_trend
    model: analytics
    explore: web_sessions_fact
    type: looker_column
    fields: [web_sessions_fact.session_start_ts_month, web_events_fact.total_job_page_viewers,
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
      web_events_fact.total_job_page_viewers: Job Page Viewers
      web_events_fact.total_job_applications: Site Applications
    y_axes:
    - label: Job Page Viewers
      orientation: left
      series:
      - id: web_events_fact.total_job_page_viewers
        name: Job Page Viewers
    - label: Site Applications
      orientation: right
      series:
      - id: web_events_fact.total_job_applications
        name: Site Applications
    listen:
      Date: web_sessions_fact.session_start_ts_date
      Role: careers_job.job_title
    row: 25
    col: 0
    width: 12
    height: 8

  - title: Careers Site Sessions and Site Applicants by Route
    name: applications_by_route
    model: analytics
    explore: web_sessions_fact
    type: looker_grid
    fields: [web_sessions_fact.careers_entry_route, web_sessions_fact.total_sessions,
      web_events_fact.total_careers_site_visitors, web_events_fact.total_job_applicants,
      web_events_fact.careers_site_application_rate]
    filters:
      web_sessions_fact.is_careers_site_session: "Yes"
      web_sessions_fact.is_cookie_declined_session: "No"
    sorts: [web_sessions_fact.total_sessions desc]
    limit: 20
    show_row_numbers: false
    show_totals: true
    show_view_names: false
    series_labels:
      web_sessions_fact.careers_entry_route: Route
      web_sessions_fact.total_sessions: Sessions
      web_events_fact.total_careers_site_visitors: Visitors
      web_events_fact.total_job_applicants: Site Applicants
      web_events_fact.careers_site_application_rate: Visitors Who Applied
    note_state: collapsed
    note_display: hover
    note_text: "How careers-site sessions arrived, for visitors who accepted cookies. With a Role selected, counts only sessions that included that role's job pages."
    listen:
      Date: web_sessions_fact.session_start_ts_date
      Role: careers_job.job_title
    row: 25
    col: 12
    width: 12
    height: 8

  # ── Company website (all roles) ───────────────────────────────────────────────

  - title: Website Recruitment Funnel (all roles)
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
    note_state: collapsed
    note_display: hover
    note_text: "Stages 1 to 4 are on the company website, 5 and 6 on the careers site. Stage 3 (Visage project click) is an optional side step: those visitors leave for the Visage site. The two sites give each person a different visitor ID, so each stage is counted on its own. Stage 6 includes visitors who declined cookies."
    listen:
      Date: web_sessions_fact.session_start_ts_date
    row: 33
    col: 0
    width: 12
    height: 8

  - title: Careers Page Views by Channel (all roles)
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
    row: 33
    col: 12
    width: 12
    height: 8

  - title: Clicks from the Careers Page (all roles)
    name: careers_page_clicks
    model: analytics
    explore: web_sessions_fact
    type: looker_bar
    fields: [web_events_fact.event_details, web_events_fact.total_recruitment_funnel_events]
    filters:
      web_events_fact.careers_funnel_stage: "3. Visage project click,4. Click to careers site"
    sorts: [web_events_fact.total_recruitment_funnel_events desc]
    limit: 10
    show_value_labels: true
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    series_labels:
      web_events_fact.event_details: Button
      web_events_fact.total_recruitment_funnel_events: Clicks
    note_state: collapsed
    note_display: hover
    note_text: "Buttons on rittmananalytics.com/careers. 'Open vacancies' and 'Enquire about the role' go to the careers site; 'More on Visage' opens the Visage hackathon project."
    listen:
      Date: web_sessions_fact.session_start_ts_date
    row: 41
    col: 0
    width: 16
    height: 6

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
    row: 41
    col: 16
    width: 8
    height: 6
