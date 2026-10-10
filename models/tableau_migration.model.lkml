connection: "ra_dw_prod"

include: "/tableau_migration/views/*.view.lkml"
include: "/tableau_migration/dashboards/*.dashboard.lookml"

explore: business_operations {
  label: "Business Operations"
  view_name: companies_dim
  join: deals_fact {
    type: left_outer
    relationship: many_to_many
    sql_on: ${companies_dim.company_pk} = ${deals_fact.company_fk} ;;
  }
  join: invoices_fact {
    type: left_outer
    relationship: many_to_many
    sql_on: ${companies_dim.company_pk} = ${invoices_fact.company_fk} ;;
  }
  join: timesheet_project_engagements_dim {
    type: left_outer
    relationship: many_to_many
    sql_on: ${companies_dim.company_pk} = ${timesheet_project_engagements_dim.company_fk} ;;
  }
  join: timesheet_projects_dim {
    type: left_outer
    relationship: many_to_many
    sql_on: ${companies_dim.company_pk} = ${timesheet_projects_dim.company_fk} ;;
  }
}
