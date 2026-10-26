- dashboard: monthly_performance_report
  title: Monthly Performance Report
  layout: newspaper
  preferred_viewer: dashboards-next
  description: Migrated from Looker Studio report Monthly Performance Report (ls_to_lookml 0.1.0, experimental)
  elements:
  - name: text_cd_e7bg1jmbid
    type: text
    body_text: OVERALL COMPANY PERFORMANCE
    row: 0
    col: 5
    width: 19
    height: 1
  - name: kpi_metric_cd_12jivihbid
    model: looker_studio_migration
    explore: monthly_performance_fact
    type: single_value
    fields:
    - monthly_performance_fact.total_total_won_opportunity_amount_gbp
    limit: 500
    row: 2
    col: 1
    width: 4
    height: 2
  - name: kpi_metric_cd_e3of2qhbid
    model: analytics
    explore: monthly_performance_fact
    type: single_value
    fields:
    - monthly_performance_fact.total_revenue_gbp
    limit: 500
    row: 2
    col: 5
    width: 4
    height: 2
  - name: kpi_metric_cd_f3l0uphbid
    model: analytics
    explore: monthly_performance_fact
    type: single_value
    fields:
    - monthly_performance_fact.total_net_profit_gbp
    limit: 500
    row: 2
    col: 9
    width: 4
    height: 2
  - name: kpi_metric_cd_bilr4nlbid
    model: analytics
    explore: monthly_performance_fact
    type: single_value
    fields:
    - monthly_performance_fact.average_average_nps_survey_score
    limit: 500
    row: 2
    col: 13
    width: 3
    height: 2
  - name: kpi_metric_cd_iwmvdshbid
    model: analytics
    explore: monthly_performance_fact
    type: single_value
    fields:
    - monthly_performance_fact.total_website_sessions
    limit: 500
    row: 2
    col: 16
    width: 4
    height: 2
  - name: kpi_metric_cd_dq9akthbid
    model: analytics
    explore: monthly_performance_fact
    type: single_value
    fields:
    - monthly_performance_fact.total_delivery_tickets_completed
    limit: 500
    row: 2
    col: 20
    width: 4
    height: 2
  - name: simple_table_cd_axtwknpcid
    model: looker_studio_migration
    explore: performance_narrative_fact
    type: looker_grid
    fields:
    - performance_narrative_fact.overall_summary
    sorts:
    - performance_narrative_fact.overall_summary desc
    limit: 100
    row: 4
    col: 1
    width: 22
    height: 5
  - name: text_cd_9id95gmbid
    type: text
    body_text: SALES & MARKETING SUMMARY
    row: 10
    col: 1
    width: 11
    height: 1
  - name: text_cd_ua9i6ymbid
    type: text
    body_text: PROJECT DELIVERY SUMMARY
    row: 10
    col: 13
    width: 11
    height: 1
  - name: simple_barchart_cd_25metnmbid
    model: analytics
    explore: companies_dim
    type: looker_column
    fields:
    - deals_fact.pipeline_stage_label
    - deals_fact.count_oppportunity_deals
    sorts:
    - deals_fact.pipeline_stage_label asc
    limit: 10
    row: 11
    col: 2
    width: 11
    height: 5
  - name: simple_combochart_cd_e4k22rmbid
    model: analytics
    explore: monthly_performance_fact
    type: looker_column
    fields:
    - monthly_performance_fact.date_spine_dim_date_month
    - monthly_performance_fact.total_delivery_tickets_completed
    sorts:
    - monthly_performance_fact.date_spine_dim_date_month asc
    limit: 500
    row: 11
    col: 13
    width: 10
    height: 5
  - name: simple_table_cd_s69fkkmbid
    model: looker_studio_migration
    explore: performance_narrative_fact
    type: looker_grid
    fields:
    - performance_narrative_fact.sales_marketing_summary
    sorts:
    - performance_narrative_fact.sales_marketing_summary desc
    limit: 1
    row: 16
    col: 1
    width: 11
    height: 4
  - name: simple_table_cd_dwitmlmbid
    model: looker_studio_migration
    explore: performance_narrative_fact
    type: looker_grid
    fields:
    - performance_narrative_fact.delivery_summary
    sorts:
    - performance_narrative_fact.delivery_summary desc
    limit: 1
    row: 16
    col: 13
    width: 10
    height: 4
