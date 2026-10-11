- dashboard: organic_leads_analysis
  title: Organic Leads Analysis
  layout: newspaper
  preferred_viewer: dashboards-next
  description: Migrated from Omni document Organic Leads Analysis (omni_to_lookml 0.1.0, experimental)
  elements:
  - name: organic_traffic_trend_by_channel_1
    title: Organic Traffic Trend by Channel
    model: omni_migration
    explore: web_sessions_fact
    type: looker_line
    fields:
    - web_sessions_fact.session_start_ts_month
    - web_sessions_fact.channel
    - web_sessions_fact.total_sessions
    pivots:
    - web_sessions_fact.channel
    filters:
      web_sessions_fact.channel_category: Organic
      web_sessions_fact.session_start_ts_date: 12 months
    sorts:
    - web_sessions_fact.session_start_ts_month
    limit: 500
    row: 0
    col: 0
    width: 12
    height: 7
  - name: organic_search_traffic_by_landing_page_category_2
    title: Organic Search Traffic by Landing Page Category
    model: omni_migration
    explore: web_sessions_fact
    type: looker_area
    fields:
    - web_sessions_fact.session_start_ts_month
    - web_sessions_fact.first_page_category
    - web_sessions_fact.total_sessions
    pivots:
    - web_sessions_fact.first_page_category
    filters:
      web_sessions_fact.channel: Organic Search
      web_sessions_fact.session_start_ts_date: 12 months
    sorts:
    - web_sessions_fact.session_start_ts_month
    limit: 500
    row: 0
    col: 12
    width: 12
    height: 7
  - name: content_performance_sessions_vs_conversions_by_category_3
    title: 'Content Performance: Sessions vs Conversions by Category'
    model: omni_migration
    explore: web_sessions_fact
    type: looker_bar
    fields:
    - web_sessions_fact.first_page_category
    - web_sessions_fact.total_sessions
    - web_events_fact.total_conversions
    - web_sessions_fact.bounced_session_rate
    filters:
      web_sessions_fact.channel_category: Organic
      web_sessions_fact.session_start_ts_date: 12 months
    sorts:
    - web_sessions_fact.total_sessions desc
    limit: 10
    row: 7
    col: 0
    width: 12
    height: 7
  - name: top_organic_landing_pages_12_months_4
    title: Top Organic Landing Pages (12 Months)
    model: omni_migration
    explore: web_sessions_fact
    type: looker_grid
    fields:
    - web_sessions_fact.first_page_title
    - web_sessions_fact.total_sessions
    - web_events_fact.total_conversions
    - web_sessions_fact.bounced_session_rate
    filters:
      web_sessions_fact.channel: Organic Search
      web_sessions_fact.session_start_ts_date: 12 months
    sorts:
    - web_sessions_fact.total_sessions desc
    limit: 15
    row: 7
    col: 12
    width: 12
    height: 7
  - name: referrer_sources_sessions_conversions_5
    title: 'Referrer Sources: Sessions & Conversions'
    model: omni_migration
    explore: web_sessions_fact
    type: looker_grid
    fields:
    - web_sessions_fact.referrer_host
    - web_sessions_fact.total_sessions
    - web_events_fact.total_conversions
    filters:
      web_sessions_fact.channel_category: Organic
      web_sessions_fact.session_start_ts_date: 12 months
    sorts:
    - web_sessions_fact.total_sessions desc
    limit: 15
    row: 13
    col: 0
    width: 12
    height: 7
  - name: monthly_conversions_by_channel_category_6
    title: Monthly Conversions by Channel Category
    model: omni_migration
    explore: web_sessions_fact
    type: looker_column
    fields:
    - web_sessions_fact.session_start_ts_month
    - web_sessions_fact.channel_category
    - web_events_fact.total_conversions
    pivots:
    - web_sessions_fact.channel_category
    filters:
      web_sessions_fact.session_start_ts_date: 12 months
    sorts:
    - web_sessions_fact.session_start_ts_month
    limit: 500
    stacking: normal
    row: 13
    col: 12
    width: 12
    height: 7
  - name: new_vs_returning_visitors_organic_7
    title: New vs Returning Visitors (Organic)
    model: omni_migration
    explore: web_sessions_fact
    type: looker_bar
    fields:
    - web_sessions_fact.new_or_returning_user
    - web_sessions_fact.total_sessions
    - web_events_fact.total_conversions
    - web_sessions_fact.bounced_session_rate
    filters:
      web_sessions_fact.channel_category: Organic
      web_sessions_fact.session_start_ts_date: 12 months
    sorts:
    - web_sessions_fact.total_sessions desc
    limit: 500
    row: 20
    col: 0
    width: 12
    height: 7
  - name: pages_that_actually_convert_organic_8
    title: Pages That Actually Convert (Organic)
    model: omni_migration
    explore: web_sessions_fact
    type: looker_grid
    fields:
    - web_sessions_fact.first_page_title
    - web_sessions_fact.total_sessions
    - web_events_fact.total_conversions
    filters:
      web_events_fact.total_conversions: '>0'
      web_sessions_fact.channel_category: Organic
      web_sessions_fact.session_start_ts_date: 12 months
    sorts:
    - web_events_fact.total_conversions desc
    limit: 10
    row: 20
    col: 12
    width: 12
    height: 7
  - name: organic_sessions_last_3_months_9
    title: Organic Sessions (Last 3 Months)
    model: omni_migration
    explore: web_sessions_fact
    type: single_value
    fields:
    - web_sessions_fact.total_sessions
    filters:
      web_sessions_fact.channel_category: Organic
      web_sessions_fact.session_start_ts_date: 3 months
    limit: 500
    row: 27
    col: 0
    width: 8
    height: 3
  - name: organic_conversions_last_3_months_10
    title: Organic Conversions (Last 3 Months)
    model: omni_migration
    explore: web_sessions_fact
    type: single_value
    fields:
    - web_events_fact.total_conversions
    filters:
      web_sessions_fact.channel_category: Organic
      web_sessions_fact.session_start_ts_date: 3 months
    limit: 500
    row: 27
    col: 8
    width: 8
    height: 3
  - name: organic_bounce_rate_last_3_months_11
    title: Organic Bounce Rate (Last 3 Months)
    model: omni_migration
    explore: web_sessions_fact
    type: single_value
    fields:
    - web_sessions_fact.bounced_session_rate
    filters:
      web_sessions_fact.channel_category: Organic
      web_sessions_fact.session_start_ts_date: 3 months
    limit: 500
    row: 27
    col: 16
    width: 8
    height: 3
  - name: organic_traffic_mix_12_months_12
    title: Organic Traffic Mix (12 Months)
    model: omni_migration
    explore: web_sessions_fact
    type: looker_pie
    fields:
    - web_sessions_fact.channel
    - web_sessions_fact.total_sessions
    filters:
      web_sessions_fact.channel_category: Organic
      web_sessions_fact.session_start_ts_date: 12 months
    sorts:
    - web_sessions_fact.total_sessions desc
    limit: 500
    row: 30
    col: 0
    width: 12
    height: 7
  - name: top_blog_posts_0_conversions_opportunity_gap_13
    title: Top Blog Posts (0 Conversions - Opportunity Gap)
    model: omni_migration
    explore: web_sessions_fact
    type: looker_grid
    fields:
    - web_sessions_fact.first_page_title
    - web_sessions_fact.total_sessions
    - web_sessions_fact.bounced_session_rate
    filters:
      web_sessions_fact.channel: Organic Search
      web_sessions_fact.first_page_category: '01: Blog'
      web_sessions_fact.session_start_ts_date: 12 months
    sorts:
    - web_sessions_fact.total_sessions desc
    limit: 10
    row: 30
    col: 12
    width: 12
    height: 7
  - name: emerging_ai_search_referrals_chatgpt_perplexity_gemini_14
    title: 'Emerging: AI Search Referrals (ChatGPT, Perplexity, Gemini)'
    model: omni_migration
    explore: web_sessions_fact
    type: looker_line
    fields:
    - web_sessions_fact.session_start_ts_month
    - web_sessions_fact.referrer_host
    - web_sessions_fact.total_sessions
    pivots:
    - web_sessions_fact.referrer_host
    filters:
      web_sessions_fact.referrer_host: chatgpt.com,perplexity.ai,gemini.google.com
      web_sessions_fact.session_start_ts_date: 12 months
    sorts:
    - web_sessions_fact.session_start_ts_month
    limit: 500
    row: 37
    col: 0
    width: 12
    height: 7
