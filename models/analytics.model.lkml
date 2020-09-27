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
  join: timesheets_fact {
    sql_on: ${companies_dim.company_pk} = ${timesheets_fact.company_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: timesheet_projects_dim {
    sql_on: ${timesheets_fact.timesheet_project_pk} = ${timesheet_projects_dim.timesheet_project_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: invoices_fact {
    sql_on: ${companies_dim.company_pk} = ${invoices_fact.company_pk};;
    type: left_outer
    relationship: one_to_many
  }
}
