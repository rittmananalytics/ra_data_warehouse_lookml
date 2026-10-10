- dashboard: web_analytics
  title: Web Analytics
  layout: newspaper
  preferred_viewer: dashboards-next
  description: Migrated from Metabase dashboard Web Analytics (mb_to_lookml 0.1.0, experimental)
  elements:
  - name: bounced_session_rate_by_channel_133
    title: Bounced Session Rate by Channel
    model: metabase_migration
    explore: bounced_session_rate_by_channel
    type: looker_column
    fields:
    - bounced_session_rate_by_channel.web_sessions_fact_channel
    - bounced_session_rate_by_channel.web_sessions_fact_bounced_session_rate
    sorts:
    - bounced_session_rate_by_channel.web_sessions_fact_bounced_session_rate desc
    limit: 500
    row: 0
    col: 0
    width: 12
    height: 6
  - name: sessions_by_month_134
    title: Sessions by Month
    model: metabase_migration
    explore: sessions_by_month
    type: looker_line
    fields:
    - sessions_by_month.web_sessions_fact_session_start_ts_month
    - sessions_by_month.web_sessions_fact_total_sessions
    sorts:
    - sessions_by_month.web_sessions_fact_session_start_ts_month desc
    limit: 500
    row: 0
    col: 12
    width: 12
    height: 6
