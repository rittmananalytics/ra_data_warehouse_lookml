- dashboard: example_report_untitled_page_2
  title: Example Report - Untitled Page 2
  layout: newspaper
  preferred_viewer: dashboards-next
  description: Migrated from Looker Studio report Example Report (ls_to_lookml 0.1.0, experimental)
  filters:
  - name: Web Sessions Fact Channel
    title: Web Sessions Fact Channel
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: looker_studio_migration
    explore: bigquery_custom_sql
    field: bigquery_custom_sql.web_sessions_fact_channel
  elements:
  - name: simple_piechart_cd_rud1l0157d
    model: looker_studio_migration
    explore: bigquery_custom_sql
    type: looker_pie
    fields:
    - bigquery_custom_sql.web_sessions_fact_channel
    - bigquery_custom_sql.count
    sorts:
    - bigquery_custom_sql.count desc
    limit: 10
    row: 2
    col: 6
    width: 8
    height: 6
    listen:
      Web Sessions Fact Channel: bigquery_custom_sql.web_sessions_fact_channel
