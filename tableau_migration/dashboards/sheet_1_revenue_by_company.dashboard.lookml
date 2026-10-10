- dashboard: sheet_1_revenue_by_company
  title: Sheet 1 (Revenue by Company)
  layout: newspaper
  preferred_viewer: dashboards-next
  description: Migrated from Tableau worksheet Sheet 1 (Revenue by Company) (twb_to_lookml 0.1.0, experimental)
  elements:
  - name: sheet_1
    title: Sheet 1
    model: tableau_migration
    explore: business_operations
    type: looker_grid
    fields:
    - companies_dim.company_name
    - invoices_fact.total_total_gbp_amount
    sorts:
    - invoices_fact.total_total_gbp_amount desc
    filters:
      companies_dim.company_name: -NULL
      invoices_fact.total_total_gbp_amount: '>=50000'
    limit: 500
    row: 0
    col: 0
    width: 24
    height: 19
