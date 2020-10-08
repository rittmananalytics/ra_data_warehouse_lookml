connection: "ra_dw_prod"

# include all the views
include: "/views/**/*.view"

datagroup: analytics_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: analytics_default_datagroup

explore: campaign_explorer {}

explore: fy2019_accounts {}

explore: web_sessions_fact {
  #sql_always_where: ${web_sessions_fact.site} = 'www.switcherstudio.com' ;;
  label: "Web Analytics"
  view_label: "  Sessions"

  join: web_events_fact {
    view_label: " Events"
    sql_on: ${web_sessions_fact.session_id} = ${web_events_fact.session_id} ;;
    type: left_outer
    relationship: one_to_many
  }

  }

explore: companies_dim {

  join: projects_delivered {
    from: timesheet_projects_dim
    sql_on: ${companies_dim.company_pk} = ${projects_delivered.company_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: company_hubspot_id {
    sql_on: ${companies_dim.company_pk} = ${company_hubspot_id.company_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: projects_invoiced {
    from: invoices_fact
    sql_on: ${projects_delivered.timesheet_project_pk} = ${projects_invoiced.timesheet_project_pk};;
    type: left_outer
    relationship: one_to_many
  }
  join: project_invoice_timesheets {
    from: timesheets_fact
    sql_on: ${projects_delivered.timesheet_project_pk} = ${project_invoice_timesheets.timesheet_project_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: project_invoice_timesheet_users {
    from: users_dim
    sql_on: ${project_invoice_timesheets.user_pk} = ${project_invoice_timesheet_users.user_pk} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: project_timesheets {
    from: timesheets_fact
    sql_on: ${projects_delivered.timesheet_project_pk} = ${project_timesheets.timesheet_project_pk};;
    type: left_outer
    relationship: one_to_many
  }
  join: project_timesheet_projects {
    from: timesheet_projects_dim
    sql_on: ${project_timesheets.timesheet_project_pk} = ${project_timesheet_projects.timesheet_project_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: project_timesheet_users {
    from: users_dim
    sql_on: ${project_timesheets.user_pk}  = ${project_timesheet_users.user_pk} ;;
    type: inner
    relationship: one_to_many
  }
  join: deals_fact {
    sql_on: ${companies_dim.company_pk} = ${deals_fact.company_pk};;
    type: full_outer
    relationship: one_to_many
  }
}
