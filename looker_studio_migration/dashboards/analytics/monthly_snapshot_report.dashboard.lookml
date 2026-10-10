- dashboard: monthly_snapshot_report
  title: Monthly Snapshot Report
  layout: newspaper
  preferred_viewer: dashboards-next
  description: Migrated from Looker Studio report Monthly Snapshot Report (ls_to_lookml 0.1.0, experimental)
  filters:
  - name: Date range
    title: Date range
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: analytics
    explore: companies_dim
    field: deals_fact.deal_closed_month
  elements:
  - name: kpi_metric_cd_p5un76gt4c
    model: analytics
    explore: revenue_and_forecast
    type: single_value
    fields:
    - revenue_and_forecast.booked_and_forecast_revenue
    limit: 500
    row: 1
    col: 0
    width: 3
    height: 2
    listen:
      Date range: revenue_and_forecast.period_month
  - name: kpi_metric_cd_meme89gt4c
    model: analytics
    explore: revenue_and_forecast
    type: single_value
    fields:
    - revenue_and_forecast.actual_net_margin
    limit: 500
    row: 1
    col: 4
    width: 3
    height: 2
    listen:
      Date range: revenue_and_forecast.period_month
  - name: simple_linechart_cd_jvj6rdht4c
    model: analytics
    explore: companies_dim
    type: looker_line
    fields:
    - projects_invoiced.invoice_issued_month
    - projects_invoiced.total_net_amount_gbp
    sorts:
    - projects_invoiced.invoice_issued_month asc
    limit: 500
    row: 3
    col: 0
    width: 3
    height: 2
    filters:
      projects_invoiced.invoice_issued_date: 13 months
  - name: simple_linechart_cd_fawtvght4c
    model: analytics
    explore: chart_of_accounts_dim
    type: looker_line
    fields:
    - profit_and_loss_report_fact.period_month
    - profit_and_loss_report_fact.amount
    sorts:
    - profit_and_loss_report_fact.period_month asc
    limit: 500
    row: 3
    col: 4
    width: 3
    height: 2
    filters:
      profit_and_loss_report_fact.period_month: 13 months
  - name: kpi_metric_cd_y042wliu4c
    model: analytics
    explore: companies_dim
    type: single_value
    fields:
    - deals_fact.total_closed_won_deal_amount
    limit: 500
    row: 5
    col: 0
    width: 3
    height: 2
    listen:
      Date range: deals_fact.deal_closed_month
  - name: kpi_metric_cd_htfuql057d
    model: analytics
    explore: companies_dim
    type: single_value
    fields:
    - deals_fact.total_closed_won_deal_amount
    limit: 500
    row: 5
    col: 4
    width: 3
    height: 2
    listen:
      Date range: deals_fact.deal_closed_month
  - name: simple_barchart_cd_99ntt3hu4c
    model: analytics
    explore: companies_dim
    type: looker_column
    fields:
    - deals_fact.deal_closed_month
    - companies_dim.company_name
    - deals_fact.total_closed_won_deal_amount
    sorts:
    - deals_fact.deal_closed_month asc
    pivots:
    - companies_dim.company_name
    limit: 1000
    row: 7
    col: 0
    width: 7
    height: 5
    filters:
      deals_fact.deal_closed_month: 13 months
  - name: text_cd_sg46v5iu4c
    type: text
    body_text: Closed Won Last 12 Months
    row: 7
    col: 1
    width: 5
    height: 1
