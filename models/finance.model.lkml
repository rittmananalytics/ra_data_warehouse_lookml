connection: "ra_dw_prod"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project


fiscal_month_offset: -3





explore: actuals_vs_budget {
  label: "Finance"
  hidden: no

}

explore: revenue_attribution {
  hidden: no
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



explore: actuals_v_targets {
  hidden: no

}
