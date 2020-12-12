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
  join: ad_campaigns_dim {
    view_label: "Campaigns"
    sql_on: ${web_sessions_fact.ad_campaign_pk} = ${ad_campaigns_dim.ad_campaign_pk};;
    type: left_outer
    relationship: one_to_many
  }
  join: ad_campaign_performance_fact {
    view_label: "Campaign Performance"
    sql_on: ${ad_campaigns_dim.ad_campaign_pk} = ${ad_campaign_performance_fact.ad_campaign_pk}
       and  ${ad_campaign_performance_fact.campaign_date} = ${web_sessions_fact.session_start_ts_date};;
    type: left_outer
    relationship: one_to_one
  }

  }

explore: ad_campaigns_dim {
  label: "Marketing"
  view_label: "Campaigns"
  join: ad_campaign_performance_fact {
    view_label: "Campaign Performance"
    sql_on: ${ad_campaigns_dim.ad_campaign_pk} = ${ad_campaign_performance_fact.ad_campaign_pk};;
    type: left_outer
    relationship: one_to_many
  }
}

explore: attribution_fact {
  label: "Conversion Attribution"
  view_label: "Conversion Attribution"
}

explore: contacts_dim {
  label: "Contacts"
  view_label: "          Contacts"
  join: timesheets_fact {
    view_label: "Project Timesheets (Harvest)"
    sql_on: ${contacts_dim.contact_pk} = ${timesheets_fact.contact_pk}  ;;
    type: left_outer
    relationship: one_to_many
  }
  join: projects_delivered {
    view_label: "Project Timesheets (Harvest)"
    from: timesheet_projects_dim
    sql_on: ${timesheets_fact.timesheet_project_pk} = ${projects_delivered.timesheet_project_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: delivery_tasks_fact {
    view_label: " Project Management (Jira)"
    sql_on: ${contacts_dim.contact_pk} = ${delivery_tasks_fact.contact_pk};;
    type: left_outer
    relationship: one_to_many
  }
  join: projects_managed {
    view_label: " Project Management (Jira)"

    from: delivery_projects_dim
    sql_on: ${delivery_tasks_fact.delivery_project_pk} = ${projects_managed.delivery_project_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: conversations_fact {
    view_label: "      Engagements"
    sql_on: ${contacts_dim.contact_pk} = ${conversations_fact.contact_pk} ;;
    type: inner
    relationship: many_to_one
  }
  join: companies_dim {
    view_label: "       Companies"
    sql_on: ${contacts_dim.company_pk} = ${companies_dim.company_pk};;
    type: inner
    relationship: one_to_many
  }
  join: looker_usage_fact {
    view_label: "Looker Usage"
    sql_on: ${looker_usage_fact.contact_pk} = ${contacts_dim.contact_pk};;
    type: inner
    relationship: one_to_many
  }

}


explore: companies_dim {
  label: "Business Operations"
  view_label: "        Companies"

  join: projects_delivered {
    view_label: "Project Invoicing (Harvest)"
    from: timesheet_projects_dim
    sql_on: ${companies_dim.company_pk} = ${projects_delivered.company_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: projects_invoiced {
    view_label: "Project Invoicing (Harvest)"

    from: invoices_fact
    sql_on: ${projects_delivered.timesheet_project_pk} = ${projects_invoiced.timesheet_project_pk};;
    type: left_outer
    relationship: one_to_many
  }
  join: project_invoice_timesheets {
    view_label: "Project Invoicing (Harvest)"

    from: timesheets_fact
    sql_on: ${projects_delivered.timesheet_project_pk} = ${project_invoice_timesheets.timesheet_project_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: project_invoice_timesheet_users {
    view_label: "Project Invoicing (Harvest)"

    from: contacts_dim
    sql_on: ${project_invoice_timesheets.contact_pk} = ${project_invoice_timesheet_users.contact_pk} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: project_timesheets {
    view_label: "  Project Timesheets (Harvest)"
    from: timesheets_fact
    sql_on: ${projects_delivered.timesheet_project_pk} = ${project_timesheets.timesheet_project_pk};;
    type: left_outer
    relationship: one_to_many
  }
  join: project_timesheet_projects {
    view_label: "  Project Timesheets (Harvest)"

    from: timesheet_projects_dim
    sql_on: ${project_timesheets.timesheet_project_pk} = ${project_timesheet_projects.timesheet_project_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: project_timesheet_users {
    view_label: "  Project Timesheets (Harvest)"

    from: contacts_dim
    sql_on: ${project_timesheets.contact_pk}  = ${project_timesheet_users.contact_pk} ;;
    type: inner
    relationship: one_to_many
  }
  join: deals_fact {
    view_label: "   Sales (Hubspot)"
    sql_on: ${companies_dim.company_pk} = ${deals_fact.company_pk};;
    type: full_outer
    relationship: one_to_many
  }
  join: projects_managed {
    view_label: " Project Management (Jira)"

    from: delivery_projects_dim
    sql_on: ${companies_dim.company_pk} = ${projects_managed.company_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: delivery_tasks_fact {
    view_label: " Project Management (Jira)"

    sql_on: ${projects_managed.delivery_project_pk} = ${delivery_tasks_fact.delivery_project_pk};;
    type: left_outer
    relationship: one_to_many
  }
  join: delivery_task_history {
    view_label: " Project Management (Jira)"
    sql_on: ${delivery_tasks_fact.task_id} = ${delivery_task_history.task_id} ;;
    type: left_outer
    relationship: one_to_one
  }

  join: team_dim {
    from: contacts_dim
    view_label: "Project Teams"
    sql_on: ${delivery_tasks_fact.contact_pk} = ${team_dim.contact_pk};;
    type: left_outer
    relationship: many_to_one
  }

  join: contact_companies_fact {
    sql_on: ${companies_dim.company_pk} = ${contact_companies_fact.company_pk};;
    type: inner
    relationship: one_to_many
  }
  join: contacts_dim {
    view_label: "       Contacts"
    sql_on: ${contact_companies_fact.contact_pk} = ${contacts_dim.contact_pk} ;;
    type: inner
    relationship: many_to_one
  }
  join: conversations_fact {
    view_label: "       Contacts"
    sql_on: ${contacts_dim.contact_pk} = ${conversations_fact.contact_pk} ;;
    type: inner
    relationship: many_to_one
  }
  join: looker_usage_fact {
    view_label: "Looker Usage"
    sql_on: ${companies_dim.company_pk} = ${looker_usage_fact.company_pk} ;;
    type: inner
    relationship: one_to_many
  }
  join: looker_users_dim {
    from: contacts_dim
    view_label: "Looker Users"
    sql_on: ${looker_usage_fact.contact_pk} = ${looker_users_dim.contact_pk};;
    type: left_outer
    relationship: many_to_one
  }
}
