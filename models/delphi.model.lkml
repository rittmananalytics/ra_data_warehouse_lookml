connection: "ra_dw_prod"

# include all the views
include: "/views/**/*.view"
include: "/dashboards/**.*"

datagroup: analytics_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

fiscal_month_offset: +3
week_start_day: monday

explore: clients {
  from: companies_dim
  label: "Client Operations"
  group_label: "   Operations"
  hidden: no








  view_label: "        Organizations"
  join: client_prospect_status_dim {
    view_label: "        Organizations"
    sql_on: ${clients.company_pk} = ${client_prospect_status_dim.company_pk} ;;
    type: left_outer
    relationship: one_to_one
  }


  join: projects {
    view_label: "    Invoicing"
    from: timesheet_projects_dim
    sql_on: ${clients.company_pk} = ${projects.company_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: invoices {
    view_label: "    Invoicing"

    from: invoices_fact
    sql_on: ${projects.timesheet_project_pk} = ${invoices.timesheet_project_pk};;
    type: left_outer
    relationship: one_to_many
  }
  join: exchange_rates {
    sql_on: ${invoices.invoice_currency} = ${exchange_rates.currency_code} ;;
    type: left_outer
    relationship: many_to_one
  }


  join: project_timesheets {
    view_label: "      Timesheets"
    from: timesheets_fact
    sql_on: ${projects.timesheet_project_pk} = ${project_timesheets.timesheet_project_pk};;
    type: left_outer
    relationship: one_to_many
  }
  join: project_timesheet_projects {
    view_label: "      Timesheets"

    from: timesheet_projects_dim
    sql_on: ${project_timesheets.timesheet_project_pk} = ${project_timesheet_projects.timesheet_project_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: staff {
    view_label: "      Timesheets"

    from: contacts_dim
    sql_on: ${project_timesheets.contact_pk}  = ${staff.contact_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: sales {
    from: deals_fact

    view_label: "        Sales"
    sql_on: ${clients.company_pk} = ${sales.company_pk};;
    type: full_outer
    relationship: one_to_many
  }

















}
