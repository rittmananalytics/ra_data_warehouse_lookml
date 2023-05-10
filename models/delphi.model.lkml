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

explore: companies_dim {
  label: "Client Operations"
  group_label: "   Operations"
  hidden: no



  join: client_concentration{
    view_label: "Monthly Concentration"
    sql_on: ${projects_invoiced.invoice_sent_at_ts_month} = ${client_concentration.invoice_month_month} ;;
    type: left_outer
    relationship: one_to_one
  }




  view_label: "        Organizations"
  join: client_prospect_status_dim {
    view_label: "        Organizations"
    sql_on: ${companies_dim.company_pk} = ${client_prospect_status_dim.company_pk} ;;
    type: left_outer
    relationship: one_to_one
  }

  join: customer_first_order_segments {
    view_label: "        Organizations"
    sql_on: ${companies_dim.company_pk} = ${customer_first_order_segments.companies_dim_company_pk} ;;
    type: left_outer
    relationship: one_to_one
  }

  join: rfm_model {
    view_label: "        Organizations"
    sql_on: ${companies_dim.company_pk} = ${rfm_model.company_pk} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: company_deal_value_attribute {
    view_label: "        Organizations"
    sql_on: ${companies_dim.company_pk} = ${company_deal_value_attribute.company_pk} ;;
    type: left_outer
    relationship: one_to_one

  }
  join: projects_delivered {
    view_label: "    Invoicing"
    from: timesheet_projects_dim
    sql_on: ${companies_dim.company_pk} = ${projects_delivered.company_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: projects_invoiced {
    view_label: "    Invoicing"

    from: invoices_fact
    sql_on: ${projects_delivered.timesheet_project_pk} = ${projects_invoiced.timesheet_project_pk};;
    type: left_outer
    relationship: one_to_many
  }
  join: exchange_rates {
    sql_on: ${projects_invoiced.invoice_currency} = ${exchange_rates.currency_code} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: project_invoice_timesheets {
    view_label: "    Invoicing"

    from: timesheets_fact
    sql_on: ${projects_delivered.timesheet_project_pk} = ${project_invoice_timesheets.timesheet_project_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: project_invoice_timesheet_users {
    view_label: "    Invoicing"

    from: contacts_dim
    sql_on: ${project_invoice_timesheets.contact_pk} = ${project_invoice_timesheet_users.contact_pk} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: project_timesheets {
    view_label: "      Timesheets"
    from: timesheets_fact
    sql_on: ${projects_delivered.timesheet_project_pk} = ${project_timesheets.timesheet_project_pk};;
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
  join: project_timesheet_users {
    view_label: "      Timesheets"

    from: contacts_dim
    sql_on: ${project_timesheets.contact_pk}  = ${project_timesheet_users.contact_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: deals_fact {
    view_label: "        Sales"
    sql_on: ${companies_dim.company_pk} = ${deals_fact.company_pk};;
    type: full_outer
    relationship: one_to_many
  }



  join: customer_first_deal_cohorts {
    view_label: "        Sales"
    sql_on: ${deals_fact.deal_pk} = ${customer_first_deal_cohorts.deal_pk};;
    type: inner
    relationship: one_to_one
  }
  join: projects_managed {
    view_label: "    Project Management"

    from: delivery_projects_dim
    sql_on: ${companies_dim.company_pk} = ${projects_managed.company_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: delivery_tasks_fact {
    view_label: "    Project Management"

    sql_on: ${projects_managed.delivery_project_pk} = ${delivery_tasks_fact.delivery_project_pk};;
    type: left_outer
    relationship: one_to_many
  }
  join: delivery_task_history {
    view_label: "    Project Management"
    sql_on: ${delivery_tasks_fact.task_id} = ${delivery_task_history.task_id} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: payments_fact {
    view_label: " Finance"
    type: left_outer
    sql_on: ${projects_invoiced.invoice_pk} = ${payments_fact.payment_invoice_fk};;
    relationship: one_to_many
  }

  join: team_dim {
    from: contacts_dim
    view_label: "    Project Management"
    sql_on: ${delivery_tasks_fact.contact_pk} = ${team_dim.contact_pk};;
    type: left_outer
    relationship: many_to_one
  }

  join: contact_companies_fact {
    sql_on: ${companies_dim.company_pk} = ${contact_companies_fact.company_pk};;
    type: inner
    relationship: one_to_many
  }
  join: contacts {
    from: contacts_dim
    view_label: "       Contacts"
    sql_on: ${contact_companies_fact.contact_pk} = ${contacts.contact_pk} ;;
    type: inner
    relationship: many_to_one
  }

  join: contact_meetings_fact {
    view_label: "       Meetings"
    sql_on: ${contacts.contact_pk} = ${contact_meetings_fact.meeting_host_contact_pk};;
    type: left_outer
    relationship: one_to_many
  }




  join: contact_engagements_fact {
    view_label: "       Contacts"
    sql_on: ${contacts.contact_pk} = ${contact_engagements_fact.to_contact_pk} ;;
    type: inner
    relationship: many_to_one
  }

  join: contacts_engaged_dim {
    from: contacts_dim
    view_label: "       Contacts"
    sql_on: ${contact_engagements_fact.to_contact_pk} = ${contacts_engaged_dim.contact_pk} ;;
    relationship: many_to_one
    type: left_outer
  }
  join: companies_engaged_dim {
    from: companies_dim
    view_label: "       Contacts"
    sql_on: ${companies_engaged_dim.company_pk} = ${companies_dim.company_pk};;
    type: inner
    relationship: one_to_many
  }



  join: contracts_fact {
    view_label: "Legal"
    sql_on: ${companies_dim.company_pk} = ${contracts_fact.company_pk} ;;
    type: inner
    relationship: one_to_many
  }

}
