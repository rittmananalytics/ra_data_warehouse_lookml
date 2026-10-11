- dashboard: financial_analytics_2026
  title: Financial Analytics 2026
  layout: newspaper
  preferred_viewer: dashboards-next
  description: Migrated from Omni document Financial Analytics 2026 (omni_to_lookml 0.1.0, experimental)
  elements:
  - name: sales_vs_target_5
    title: Sales vs. Target %
    model: omni_migration
    explore: chart_of_accounts_dim
    type: single_value
    fields:
    - profit_and_loss_report_fact.sales_vs_budget_pct
    limit: 500
    row: 0
    col: 0
    width: 6
    height: 3
  - name: cost_of_delivery_vs_target_3
    title: Cost of Delivery % vs Target
    model: omni_migration
    explore: chart_of_accounts_dim
    type: single_value
    fields:
    - profit_and_loss_report_fact.cost_of_delivery_pct_of_revenue
    - profit_and_loss_report_fact.cost_of_delivery_budget_pct_of_revenue
    limit: 500
    row: 0
    col: 6
    width: 6
    height: 3
  - name: overheads_as_of_target_4
    title: Overheads as % of Target
    model: omni_migration
    explore: chart_of_accounts_dim
    type: single_value
    fields:
    - profit_and_loss_report_fact.overheads_pct_of_revenue
    - profit_and_loss_report_fact.overheads_budget_pct_of_revenue
    limit: 500
    row: 0
    col: 12
    width: 6
    height: 3
  - name: retained_earnings_as_of_sales_vs_target_6
    title: Retained Earnings as % of Sales vs Target
    model: omni_migration
    explore: chart_of_accounts_dim
    type: single_value
    fields:
    - profit_and_loss_report_fact.retained_earnings_pct_of_revenue
    - profit_and_loss_report_fact.retained_earnings_budget_pct_of_revenue
    limit: 500
    row: 0
    col: 18
    width: 6
    height: 3
  - name: text_ti_text_3858
    type: text
    body_text: '# How profitable has the business been over the year?'
    row: 3
    col: 0
    width: 24
    height: 2
  - name: actuals_ytd_vs_budget_2
    title: Actuals YTD Vs Budget
    model: omni_migration
    explore: chart_of_accounts_dim
    type: looker_grid
    fields:
    - profit_and_loss_report_fact.account_report_category
    - profit_and_loss_report_fact.period_year
    - profit_and_loss_report_fact.amount
    - profit_and_loss_report_fact.budget
    - profit_and_loss_report_fact.variance
    - profit_and_loss_report_fact.variance_pct
    pivots:
    - profit_and_loss_report_fact.period_year
    sorts:
    - profit_and_loss_report_fact.period_year
    - profit_and_loss_report_fact.account_report_category
    limit: 500
    row: 5
    col: 0
    width: 24
    height: 4
  - name: profit_loss_report_ytd_1
    title: Profit & Loss Report YTD
    model: omni_migration
    explore: chart_of_accounts_dim
    type: looker_grid
    fields:
    - profit_and_loss_report_fact.period_month
    - profit_and_loss_report_fact.account_report_category
    - profit_and_loss_report_fact.account_report_group
    - profit_and_loss_report_fact.account_name
    - profit_and_loss_report_fact.amount
    pivots:
    - profit_and_loss_report_fact.period_month
    sorts:
    - profit_and_loss_report_fact.period_month
    - profit_and_loss_report_fact.account_report_category
    - profit_and_loss_report_fact.account_report_group
    - profit_and_loss_report_fact.account_name
    limit: 500
    row: 9
    col: 0
    width: 24
    height: 19
  - name: text_ti_text_3856
    type: text
    body_text: '# What revenue have we earned over the year-to-date?'
    row: 28
    col: 0
    width: 24
    height: 2
  - name: revenue_vs_retained_earnings_10
    title: Revenue vs Retained Earnings %
    model: omni_migration
    explore: chart_of_accounts_dim
    type: looker_column
    fields:
    - profit_and_loss_report_fact.period_month
    - profit_and_loss_report_fact.account_report_category
    - profit_and_loss_report_fact.amount
    pivots:
    - profit_and_loss_report_fact.account_report_category
    sorts:
    - profit_and_loss_report_fact.account_report_category
    - profit_and_loss_report_fact.period_month
    limit: 500
    row: 30
    col: 0
    width: 8
    height: 8
  - name: revenue_pipeline_12
    title: Revenue Pipeline
    model: omni_migration
    explore: fa_revenue_pipeline
    type: looker_column
    fields:
    - fa_revenue_pipeline.booking_month_month
    - fa_revenue_pipeline.total_booked_revenue
    - fa_revenue_pipeline.total_weighted_pipeline_gbp
    sorts:
    - fa_revenue_pipeline.booking_month_month
    limit: 500
    stacking: normal
    row: 30
    col: 8
    width: 8
    height: 8
  - name: cumulative_revenue_vs_last_5_years_11
    title: Cumulative Revenue vs Last 5 Years
    model: omni_migration
    explore: chart_of_accounts_dim
    type: looker_line
    fields:
    - profit_and_loss_report_fact.period_month_num
    - profit_and_loss_report_fact.period_year
    - profit_and_loss_report_fact.revenue
    pivots:
    - profit_and_loss_report_fact.period_year
    filters:
      profit_and_loss_report_fact.period_date: 5 years ago for 5 years
    sorts:
    - profit_and_loss_report_fact.period_year
    - profit_and_loss_report_fact.period_month_num
    limit: 500
    row: 30
    col: 16
    width: 8
    height: 8
  - name: text_ti_text_3857
    type: text
    body_text: '# How well have we controlled costs this year?'
    row: 38
    col: 0
    width: 24
    height: 2
  - name: cash_balance_7
    title: Cash Balance
    model: omni_migration
    explore: monzo_bank_transactions_enriched
    type: looker_line
    fields:
    - monzo_bank_transactions_enriched.transaction_date_week
    - monzo_bank_transactions_enriched.average_of_balance
    - monzo_bank_transactions_enriched.min_of_balance
    - monzo_bank_transactions_enriched.max_of_balance
    filters:
      monzo_bank_transactions_enriched.transaction_date_date: 1 year ago for 1 year
    sorts:
    - monzo_bank_transactions_enriched.transaction_date_week
    limit: 500
    row: 39
    col: 0
    width: 8
    height: 6
  - name: revenue_forecast_next_6mths_9
    title: Revenue Forecast Next 6Mths
    model: omni_migration
    explore: chart_of_accounts_dim
    type: looker_line
    fields:
    - profit_and_loss_report_fact.period_month
    - profit_and_loss_report_fact.revenue
    sorts:
    - profit_and_loss_report_fact.period_month desc
    limit: 500
    row: 39
    col: 8
    width: 8
    height: 6
  - name: costs_as_share_of_revenue_8
    title: Costs as Share of Revenue
    model: omni_migration
    explore: fa_costs_share_of_revenue
    type: looker_area
    fields:
    - fa_costs_share_of_revenue.period_month_month
    - fa_costs_share_of_revenue.total_taxation_pct
    - fa_costs_share_of_revenue.total_dividends_pct
    - fa_costs_share_of_revenue.total_overheads_pct
    - fa_costs_share_of_revenue.total_cost_of_delivery_pct
    - fa_costs_share_of_revenue.total_retained_income_pct
    sorts:
    - fa_costs_share_of_revenue.period_month_month desc
    limit: 500
    row: 39
    col: 16
    width: 8
    height: 6
