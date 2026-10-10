- dashboard: wire_test_web_analytics_query_builder
  title: 'Wire test: Web Analytics (query builder)'
  layout: newspaper
  preferred_viewer: dashboards-next
  description: 'Migrated from Metabase dashboard Wire test: Web Analytics (query builder) (mb_to_lookml 0.1.0, experimental)'
  filters:
  - name: Channel
    title: Channel
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: metabase_migration
    explore: web_sessions_fact
    field: web_sessions_fact.channel
  elements:
  - name: bounce_rate_by_channel_query_builder_135
    title: Bounce rate by channel (query builder)
    model: metabase_migration
    explore: web_sessions_fact
    type: looker_column
    fields:
    - web_sessions_fact.channel
    - web_sessions_fact.bounce_rate
    filters:
      web_sessions_fact.session_start_ts_date: 12 months
    sorts:
    - web_sessions_fact.bounce_rate desc
    limit: 500
    row: 0
    col: 0
    width: 12
    height: 6
    listen:
      Channel: web_sessions_fact.channel
  - name: sessions_by_month_query_builder_136
    title: Sessions by month (query builder)
    model: metabase_migration
    explore: web_sessions_fact
    type: looker_line
    fields:
    - web_sessions_fact.session_start_ts_month
    - web_sessions_fact.count_distinct_web_sessions_pk
    filters:
      web_sessions_fact.session_start_ts_date: 12 months ago for 12 months
    sorts:
    - web_sessions_fact.session_start_ts_month asc
    limit: 500
    row: 0
    col: 12
    width: 12
    height: 6
    listen:
      Channel: web_sessions_fact.channel
