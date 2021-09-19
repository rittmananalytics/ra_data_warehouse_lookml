connection: "ra_dw_prod"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project


fiscal_month_offset: -3





explore: actuals_vs_budget {
  label: "Budgets"
  hidden: yes

}

explore: revenue_attribution {
  hidden: yes
  label: "Attribution"
  view_label: "Revenue Attribution"
  join: timesheet_projects_dim {
    sql_on: ${revenue_attribution.project_code} = ${timesheet_projects_dim.project_code} ;;
    type: inner
    relationship: many_to_one
  }
  join: companies_dim {
    view_label: "Clients"
    sql_on: ${timesheet_projects_dim.company_pk} = ${companies_dim.company_pk} ;;
    type: inner
    relationship: many_to_one
  }
  join: projects_invoiced {
    view_label: "Project Invoicing (Harvest)"

    from: invoices_fact
    sql_on: ${timesheet_projects_dim.timesheet_project_pk} = ${projects_invoiced.timesheet_project_pk};;
    type: left_outer
    relationship: one_to_many
  }
}

explore: chart_of_accounts_dim {
  label: "Finance"
  hidden: yes
  view_label: "Accounts"
  join: general_ledger_fact {
    view_label: "General Ledger"
    sql_on: ${chart_of_accounts_dim.account_id} = ${general_ledger_fact.account_id};;
    type: left_outer
    relationship: one_to_many
  }
  join: profit_and_loss_report_fact {
    view_label: "Profit & Loss Report"
    sql_on: ${chart_of_accounts_dim.account_id} = ${profit_and_loss_report_fact.account_id} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: bank_transactions_fact {
    view_label: "Bank Transactions"
    sql_on: ${chart_of_accounts_dim.account_id} = ${bank_transactions_fact.account_id} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: bank_account_details {
    view_label: "Bank Transactions"
    sql_on: ${bank_transactions_fact.bank_account_id} = ${bank_account_details.bank_account_id} ;;
    type: inner
    relationship: many_to_one
  }
}



explore: actuals_v_targets {
  hidden: yes

}
