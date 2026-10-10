- dashboard: example_report_untitled_page
  title: Example Report - Untitled Page
  layout: newspaper
  preferred_viewer: dashboards-next
  description: Migrated from Looker Studio report Example Report (ls_to_lookml 0.1.0, experimental)
  filters:
  - name: Date range
    title: Date range
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: looker_studio_migration
    explore: bigquery_custom_sql
    field: bigquery_custom_sql.web_sessions_fact_session_start_ts_week_as_date_date
  elements:
  - name: kpi_metric_cd_vsi31e057d
    model: looker_studio_migration
    explore: bigquery_custom_sql
    type: single_value
    fields:
    - bigquery_custom_sql.total_web_events_fact_total_unique_users
    limit: 500
    row: 1
    col: 2
    width: 3
    height: 2
    listen:
      Date range: bigquery_custom_sql.web_sessions_fact_session_start_ts_week_as_date_date
  - name: kpi_metric_cd_l9tzqz157d
    model: looker_studio_migration
    explore: bigquery_custom_sql
    type: single_value
    fields:
    - bigquery_custom_sql.total_page_view_per_user
    limit: 500
    row: 1
    col: 16
    width: 3
    height: 2
    listen:
      Date range: bigquery_custom_sql.web_sessions_fact_session_start_ts_week_as_date_date
  - name: simple_barchart_cd_ucoccu057d
    model: looker_studio_migration
    explore: delivery_kpis
    type: looker_column
    fields:
    - delivery_kpis.report_month_date
    - delivery_kpis.total_cost_of_delivery_pct
    sorts:
    - delivery_kpis.total_cost_of_delivery_pct desc
    limit: 10
    row: 4
    col: 1
    width: 11
    height: 6
    listen:
      Date range: delivery_kpis.report_month_date
