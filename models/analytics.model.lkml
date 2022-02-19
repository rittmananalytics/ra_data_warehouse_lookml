connection: "ra_dw_prod"

# include all the views
include: "/views/**/*.view"

datagroup: analytics_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

fiscal_month_offset: -3

explore: actuals_targets_yago {}



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


  }

explore: sales_funnel_xa {
  label: "Sales Funnel"
  view_label: "        Sales Funnel"
  join: companies_dim{
    view_label: "    Companies"
    sql_on: ${sales_funnel_xa.blended_id} = ${companies_dim.company_pk} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: contacts_dim {
    view_label: "   Contacts"
    sql_on: ${sales_funnel_xa.contact_pk} = ${contacts_dim.contact_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: contacts_influencer_list_xa {
    view_label: "   Contacts"
    sql_on: ${contacts_dim.hubspot_contact_id} = ${contacts_influencer_list_xa.hubspot_contact_id} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: contacts_web_interests_xa {
    view_label: "   Contacts"
    sql_on: ${contacts_dim.contact_pk} = ${contacts_web_interests_xa.contact_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: dynamic_company_attributes {
    view_label: "    Companies"
    sql_on: ${companies_dim.company_pk} = ${dynamic_company_attributes.company_pk} ;;
    relationship: one_to_one
    type: left_outer
  }
  join: rfm_model {
    view_label: "    Companies"
    sql_on: ${companies_dim.company_pk} = ${rfm_model.company_pk} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: client_prospect_status_dim {
    view_label: "    Companies"
    sql_on: ${companies_dim.company_pk} = ${client_prospect_status_dim.company_pk} ;;
    type: left_outer
    relationship: one_to_one
  }
}




explore: actuals_vs_budget {
  label: "Actuals vs Budget"
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
  join: client_prospect_status_dim {
    view_label: "        Companies"
    sql_on: ${companies_dim.company_pk} = ${client_prospect_status_dim.company_pk} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: companies_dim__all_company_addresses {
    view_label: "        Companies"
    sql: LEFT JOIN UNNEST(${companies_dim.all_company_addresses}) as companies_dim__all_company_addresses ;;
    relationship: one_to_many
  }
  join: dynamic_company_attributes {
    view_label: "        Companies"
    sql_on: ${companies_dim.company_pk} = ${dynamic_company_attributes.company_pk} ;;
    relationship: one_to_one
    type: left_outer
  }
  join: rfm_model {
    view_label: "        Companies"
    sql_on: ${companies_dim.company_pk} = ${rfm_model.company_pk} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: company_deal_value_attribute {
    view_label: "        Companies"
    sql_on: ${companies_dim.company_pk} = ${company_deal_value_attribute.company_pk} ;;
    type: left_outer
    relationship: one_to_one

  }
  join: projects_delivered {
    view_label: "    Project Invoicing (Harvest)"
    from: timesheet_projects_dim
    sql_on: ${companies_dim.company_pk} = ${projects_delivered.company_pk} ;;
    type: left_outer
    relationship: one_to_many
  }

  join: project_invoice_timesheets {
    view_label: "    Project Invoicing (Harvest)"

    from: timesheets_fact
    sql_on: ${projects_delivered.timesheet_project_pk} = ${project_invoice_timesheets.timesheet_project_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: project_invoice_timesheet_users {
    view_label: "    Project Invoicing (Harvest)"

    from: contacts_dim
    sql_on: ${project_invoice_timesheets.contact_pk} = ${project_invoice_timesheet_users.contact_pk} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: delivery_team_fact_xa {
    view_label: "Project Stats"
    sql_on: ${project_timesheet_users.contact_pk} = ${delivery_team_fact_xa.contact_pk} ;;
    type: left_outer
    relationship: one_to_one
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
    type: left_outer
    relationship: one_to_many
  }
  join: deals_fact {
    view_label: "     Sales (Hubspot)"
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
    view_label: " Project Management (Jira)"
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
  join: contact_contracts {
    from: contracts_fact
    view_label: "Contracts Signed"
    sql_on: ${contacts.contact_pk} = ${contact_contracts.contact_pk} ;;
    type: inner
    relationship: one_to_many
  }
  join: contact_deals_fact {
    view_label: "       Contacts"
    sql_on: ${contacts.contact_pk} = ${contact_deals_fact.contact_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: contact_deals_dim {
    view_label: "       Contacts"
    from: deals_fact
    sql_on: ${contact_deals_fact.deal_pk} = ${contact_deals_dim.deal_pk} ;;
    type: inner
    relationship: many_to_one
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

  join: customer_events_xa {
    view_label: "        Companies"
    sql_on: ${companies_dim.company_pk} = ${customer_events_xa.company_pk} ;;
    type: inner
    relationship: one_to_many
  }
  join: product_usage_fact {
    view_label: "Products"
    sql_on: ${companies_dim.company_pk} = ${product_usage_fact.company_pk} ;;
    type: inner
    relationship: one_to_many
  }
  join: product_usage_contacts {
    from: contacts_dim
    view_label: "Products"
    sql_on: ${product_usage_fact.contact_pk} = ${product_usage_contacts.contact_pk};;

    type: left_outer
    relationship: one_to_many
  }
  join: products_dim {
    view_label: "Products"
    sql_on: ${product_usage_fact.product_pk} = ${products_dim.product_pk} ;;
    type: inner
    relationship: many_to_one
  }
  join: contracts_fact {
    view_label: "   Contracts"
    sql_on: ${companies_dim.company_pk} = ${contracts_fact.company_pk} ;;
    type: inner
    relationship: one_to_many
  }
  join: contact_nps_survey_fact {
    sql_on: ${contacts.contact_pk} = ${contact_nps_survey_fact.contact_pk} ;;
    view_label: "       Contacts"
    type: inner
    relationship: one_to_many
  }
  join: cs_engagement_fact {
    sql_on: ${cs_engagement_fact.primary_key} = ${companies_dim.company_pk} ;;
    view_label: "Customer Success Engagements"
    type: inner
    relationship: one_to_many
  }

  join: contacts_influencer_list_xa {
    view_label: "       Contacts"
    sql_on: ${contacts.hubspot_contact_id} = ${contacts_influencer_list_xa.hubspot_contact_id} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: contacts_web_event_history_xa {
    view_label: "       Contacts"
    sql_on: ${contacts.contact_pk} = ${contacts_web_event_history_xa.contact_pk} ;;
    type: inner
    relationship: one_to_many
  }
  join: contacts_web_interests_xa {
    view_label: "       Contacts"
    sql_on: ${contacts.contact_pk} = ${contacts_web_interests_xa.contact_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
}

explore: chart_of_accounts_dim {
  label: "P&L"
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
}



explore: actuals_v_targets {
  hidden: no

}

explore: customer_events_xa {
  label: "Customer Timeline"
  view_label: "Customer Events"
  hidden: no

}

explore: client_concentration {
  label: "Client Concentration"
  view_label: "Monthly Concentration"
}

explore: ad_campaigns_dim {
  hidden: yes

  label: "Marketing Campaigns"
  view_label: "Campaigns"
  join: ad_campaign_performance_fact {
    view_label: "Campaign Performance"
    sql_on: ${ad_campaigns_dim.ad_campaign_pk} = ${ad_campaign_performance_fact.ad_campaign_pk};;
    type: left_outer
    relationship: one_to_many
  }
  join: web_sessions_fact {
    view_label: "Sessions"
    sql_on: ${ad_campaign_performance_fact.ad_campaign_pk} = ${web_sessions_fact.ad_campaign_pk}
       and. ${ad_campaign_performance_fact.campaign_date} = ${web_sessions_fact.session_start_ts_date};;
      type: left_outer
      relationship: one_to_many
  }
  join: web_events_fact {
    view_label: " Events"
    sql_on: ${web_sessions_fact.session_id} = ${web_events_fact.session_id} ;;
    type: left_outer
    relationship: one_to_many
  }

}



explore: contacts {
  from: contacts_dim
  label: "       Contacts"
  view_label: "          Contacts"
  join: timesheets_fact {
    view_label: "Project Timesheets (Harvest)"
    sql_on: ${contacts.contact_pk} = ${timesheets_fact.contact_pk}  ;;
    type: left_outer
    relationship: one_to_many
  }
  join: simulated_daily_timesheet_billing_target {
    view_label: "Project Timesheets Targets"
    sql_on: ${timesheets_fact.timesheet_billing_date} = ${simulated_daily_timesheet_billing_target.calendar_date_date} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: projects_delivered {
    view_label: "Project Timesheets (Harvest)"
    from: timesheet_projects_dim
    sql_on: ${timesheets_fact.timesheet_project_pk} = ${projects_delivered.timesheet_project_pk} ;;
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
  join: delivery_tasks_fact {
    view_label: " Project Management (Jira)"
    sql_on: ${contacts.contact_pk} = ${delivery_tasks_fact.contact_pk};;
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
  join: delivery_team_fact_xa {
    view_label: "Project Stats"
    sql_on: ${contacts.contact_pk} = ${delivery_team_fact_xa.contact_pk} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: contact_engagements_fact {
    view_label: "      Engagements"
    sql_on: ${contacts.contact_pk} = ${contact_engagements_fact.from_contact_pk} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: contact_engagement_deal_fact {
    from: deals_fact
    view_label: "  Engagement Deals"
    sql_on: ${contact_engagements_fact.deal_pk} = ${contact_engagement_deal_fact.deal_pk};;
    type: left_outer
    relationship: many_to_one
  }
  join: contacts_engaged_dim {
    from: contacts_dim
    view_label: " Contacts Engaged"
    sql_on: ${contact_engagements_fact.to_contact_pk} = ${contacts_engaged_dim.contact_pk} ;;
    relationship: many_to_one
    type: left_outer
  }
  join: companies_engaged_dim {
    from: companies_dim
    view_label: "   Companies Engaged"
    sql_on: ${companies_engaged_dim.company_pk} = ${companies_dim.company_pk};;
    type: inner
    relationship: one_to_many
  }
  join: companies_dim {
    view_label: "       Companies"
    sql_on: ${contacts.company_pk} = ${companies_dim.company_pk};;
    type: inner
    relationship: one_to_many
  }
  join: looker_usage_fact {
    view_label: "Looker Usage"
    sql_on: ${looker_usage_fact.contact_pk} = ${contacts.contact_pk};;
    type: left_outer
    relationship: one_to_many
  }
  join: contact_deals_fact {
    sql_on: ${contacts.contact_pk} = ${contact_deals_fact.contact_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: deals_fact {
    view_label: "   Sales (Hubspot)"
    sql_on: ${contact_deals_fact.deal_pk} = ${deals_fact.deal_pk} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: contacts_influencer_list_xa {
    view_label: "          Contacts"
    sql_on: ${contacts.hubspot_contact_id} = ${contacts_influencer_list_xa.hubspot_contact_id} ;;
    type: left_outer
    relationship: one_to_one
    }
  join: contacts_web_event_history_xa {
    view_label: "Web History"
    sql_on: ${contacts.contact_pk} = ${contacts_web_event_history_xa.contact_pk} ;;
    type: inner
    relationship: one_to_many
  }
  join: contacts_web_interests_xa {
    view_label: "          Contacts"
    sql_on: ${contacts.contact_pk} = ${contacts_web_interests_xa.contact_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: contact_contracts {
    from: contracts_fact
    view_label: "Contracts Signed"
    sql_on: ${contacts.contact_pk} = ${contact_contracts.contact_pk} ;;
    type: inner
    relationship: one_to_many
  }
  join: contact_nps_survey_fact {
    sql_on: ${contacts.contact_pk} = ${contact_nps_survey_fact.contact_pk} ;;
    view_label: "NPS Scores"
    type: inner
    relationship: one_to_many
  }
  join: dynamic_company_attributes {
    view_label: "        Companies"
    sql_on: ${companies_dim.company_pk} = ${dynamic_company_attributes.company_pk} ;;
    relationship: one_to_one
    type: left_outer
  }
  join: rfm_model {
    view_label: "        Companies"
    sql_on: ${companies_dim.company_pk} = ${rfm_model.company_pk} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: company_deal_value_attribute {
    view_label: "        Companies"
    sql_on: ${companies_dim.company_pk} = ${company_deal_value_attribute.company_pk} ;;
    type: left_outer
    relationship: one_to_one

  }
  join: client_prospect_status_dim {
    view_label: "        Companies"
    sql_on: ${companies_dim.company_pk} = ${client_prospect_status_dim.company_pk} ;;
    type: left_outer
    relationship: one_to_one
  }

}
 explore: projects_delivered {
  hidden: yes

   view_label: "Projects"
  from: timesheet_projects_dim
  join: project_timesheets {
    view_label: "  Project Timesheets (Harvest)"
    from: timesheets_fact
    sql_on: ${projects_delivered.timesheet_project_pk} = ${project_timesheets.timesheet_project_pk};;
    type: left_outer
    relationship: one_to_many
  }


  join: project_timesheet_users {
    view_label: "  Project Timesheets (Harvest)"

    from: contacts_dim
    sql_on: ${project_timesheets.contact_pk}  = ${project_timesheet_users.contact_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: delivery_team_fact_xa {
    view_label: "Project Stats"
    sql_on: ${project_timesheet_users.contact_pk}.contact_pk} = ${delivery_team_fact_xa.contact_pk} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: companies_dim {
    view_label: "Clients"
    sql_on: ${projects_delivered.company_pk} = ${companies_dim.company_pk} ;;
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



 }

explore: project_metrics {}

explore: companies_dim {
  query: FTE_forecast {
    description: "Forecast FTE requirement from scheduled projects"
    dimensions: [company_name, projects_delivered.project_delivery_end_ts_month]
    measures: [projects_delivered.project_fte_budget]
    filters: [
      companies_dim.company_name: "-RevenueRoll",
      projects_delivered.is_project_active: "Yes",
      projects_delivered.project_delivery_start_ts_date: "after this month"
    ]
  }
  query: qualified_sales_pipeline {
      description: "Details of current sales pipeline"
      dimensions: [
        company_name,
        deals_fact.assigned_consultant,
        deals_fact.deal_currency_code,
        deals_fact.deal_name,
        deals_fact.deal_type,
        deals_fact.number_of_sprints,
        deals_fact.pipeline_stage_label,
        deals_fact.pricing_model,
        deals_fact.sprint_type
      ]
      measures: [deals_fact.total_deal_amount]
      filters: [
        companies_dim.company_name: "-Apex Auctions",
        deals_fact.pipeline_stage_label: "Meeting and Sales Qualified,Awaiting Proposal,Deal Agreed & Awaiting Sign-off"
      ]
    }
  label: "     Business Operations"
  view_label: "        Companies"
  join: client_prospect_status_dim {
    view_label: "        Companies"
    sql_on: ${companies_dim.company_pk} = ${client_prospect_status_dim.company_pk} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: companies_dim__all_company_addresses {
    view_label: "        Companies"
    sql: LEFT JOIN UNNEST(${companies_dim.all_company_addresses}) as companies_dim__all_company_addresses ;;
    relationship: one_to_many
  }
  join: dynamic_company_attributes {
    view_label: "        Companies"
    sql_on: ${companies_dim.company_pk} = ${dynamic_company_attributes.company_pk} ;;
    relationship: one_to_one
    type: left_outer
    }
  join: rfm_model {
    view_label: "        Companies"
    sql_on: ${companies_dim.company_pk} = ${rfm_model.company_pk} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: company_deal_value_attribute {
    view_label: "        Companies"
    sql_on: ${companies_dim.company_pk} = ${company_deal_value_attribute.company_pk} ;;
    type: left_outer
    relationship: one_to_one

  }
  join: projects_delivered {
    view_label: "    Project Invoicing (Harvest)"
    from: timesheet_projects_dim
    sql_on: ${companies_dim.company_pk} = ${projects_delivered.company_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: projects_invoiced {
    view_label: "    Project Invoicing (Harvest)"

    from: invoices_fact
    sql_on: ${projects_delivered.timesheet_project_pk} = ${projects_invoiced.timesheet_project_pk};;
    type: left_outer
    relationship: one_to_many
  }
  join: project_invoice_timesheets {
    view_label: "    Project Invoicing (Harvest)"

    from: timesheets_fact
    sql_on: ${projects_delivered.timesheet_project_pk} = ${project_invoice_timesheets.timesheet_project_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: project_invoice_timesheet_users {
    view_label: "    Project Invoicing (Harvest)"

    from: contacts_dim
    sql_on: ${project_invoice_timesheets.contact_pk} = ${project_invoice_timesheet_users.contact_pk} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: delivery_team_fact_xa {
    view_label: "Project Stats"
    sql_on: ${project_timesheet_users.contact_pk} = ${delivery_team_fact_xa.contact_pk} ;;
    type: left_outer
    relationship: one_to_one
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
    type: left_outer
    relationship: one_to_many
  }
  join: deals_fact {
    view_label: "     Sales (Hubspot)"
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
    view_label: " Project Management (Jira)"
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
  join: contact_contracts {
    from: contracts_fact
    view_label: "Contracts Signed"
    sql_on: ${contacts.contact_pk} = ${contact_contracts.contact_pk} ;;
    type: inner
    relationship: one_to_many
  }
  join: contact_deals_fact {
    view_label: "       Contacts"
    sql_on: ${contacts.contact_pk} = ${contact_deals_fact.contact_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: contact_deals_dim {
    view_label: "       Contacts"
    from: deals_fact
    sql_on: ${contact_deals_fact.deal_pk} = ${contact_deals_dim.deal_pk} ;;
    type: inner
    relationship: many_to_one
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

  join: customer_events_xa {
    view_label: "        Companies"
    sql_on: ${companies_dim.company_pk} = ${customer_events_xa.company_pk} ;;
    type: inner
    relationship: one_to_many
  }
  join: product_usage_fact {
    view_label: "Products"
    sql_on: ${companies_dim.company_pk} = ${product_usage_fact.company_pk} ;;
    type: inner
    relationship: one_to_many
  }
  join: product_usage_contacts {
    from: contacts_dim
    view_label: "Products"
    sql_on: ${product_usage_fact.contact_pk} = ${product_usage_contacts.contact_pk};;

    type: left_outer
    relationship: one_to_many
  }
  join: products_dim {
    view_label: "Products"
    sql_on: ${product_usage_fact.product_pk} = ${products_dim.product_pk} ;;
    type: inner
    relationship: many_to_one
  }
  join: contracts_fact {
    view_label: "   Contracts"
    sql_on: ${companies_dim.company_pk} = ${contracts_fact.company_pk} ;;
    type: inner
    relationship: one_to_many
  }
  join: contact_nps_survey_fact {
    sql_on: ${contacts.contact_pk} = ${contact_nps_survey_fact.contact_pk} ;;
    view_label: "       Contacts"
    type: inner
    relationship: one_to_many
  }
  join: cs_engagement_fact {
    sql_on: ${cs_engagement_fact.primary_key} = ${companies_dim.company_pk} ;;
    view_label: "Customer Success Engagements"
    type: inner
    relationship: one_to_many
  }

  join: contacts_influencer_list_xa {
    view_label: "       Contacts"
    sql_on: ${contacts.hubspot_contact_id} = ${contacts_influencer_list_xa.hubspot_contact_id} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: contacts_web_event_history_xa {
    view_label: "       Contacts"
    sql_on: ${contacts.contact_pk} = ${contacts_web_event_history_xa.contact_pk} ;;
    type: inner
    relationship: one_to_many
  }
  join: contacts_web_interests_xa {
    view_label: "       Contacts"
    sql_on: ${contacts.contact_pk} = ${contacts_web_interests_xa.contact_pk} ;;
    type: left_outer
    relationship: one_to_many
  }




}
