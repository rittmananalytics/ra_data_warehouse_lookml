connection: "ra_dw_prod"

# include all the views
include: "/views/**/*.view"

datagroup: analytics_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

fiscal_month_offset: +3
week_start_day: monday



explore: revenue_and_forecast {
  group_label: "   Production"

  hidden: no
  description: "Explore that provides booked and forecast (high probability) revenue for past and upcoming months"


}

explore: ad_campaign_performance_fact {
  label: "Campaign Performance"
  view_label: "     Campaign Performance"
  join: ad_campaigns_dim {
    view_label: "      Campaigns"
    sql_on: ${ad_campaign_performance_fact.ad_campaign_fk} = ${ad_campaigns_dim.ad_campaign_pk} ;;
    type: left_outer
    relationship: many_to_one
  }
}

explore: site_report_by_site {
  hidden: yes
  group_label: "Experimental"
}



explore: organic_posts_dim {
  label: "Organic Marketing"
  view_label: "    Organic Posts"
  join: organic_post_performance_fact {
    view_label: " Organic Post Performance"
    sql_on: ${organic_posts_dim.organic_post_pk} = ${organic_post_performance_fact.organic_post_fk} ;;
    type: left_outer
    relationship: one_to_one
  }
}

explore: looker_usage_stats {}

explore: contacts {
  hidden: no
  from: contacts_dim
  label: "       Contacts"
  view_label: "          Contacts"
  group_label: "   Production"
  join: timesheets_fact {
    view_label: "Project Timesheets (Harvest)"
    sql_on: ${contacts.contact_pk} = ${timesheets_fact.contact_pk}  ;;
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
  join: projects_delivered_clients {
    from: companies_dim
    view_label: "Project Timesheets (Harvest)"
    sql_on: ${timesheets_fact.company_pk} = ${projects_delivered_clients.company_pk}
      and ${projects_delivered.company_pk} = ${projects_delivered_clients.company_pk};;
    type: inner
    relationship: one_to_many
  }
  join: timesheet_tasks_dim {
    view_label: "Project Timesheets (Harvest)"
    sql_on: ${timesheets_fact.timesheet_task_pk} = ${timesheet_tasks_dim.timesheet_task_pk} ;;
    type: inner
    relationship: many_to_one
  }
  join: projects_invoiced {
    view_label: "Project Invoicing (Harvest)"
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
  join: contact_meetings_fact {
    view_label: "  Contact Meetings"
    sql_on: ${contacts.contact_pk} = ${contact_meetings_fact.meeting_host_contact_pk};;
    type: left_outer
    relationship: one_to_many
  }
  join: contact_meetings_fact__all_attendee_contact_pk {
    view_label: "Contact Meetings Fact: All Attendee Contact Pk"
    sql: LEFT JOIN UNNEST(${contact_meetings_fact.all_attendee_contact_pk}) as contact_meetings_fact__all_attendee_contact_pk ;;
    relationship: one_to_many
  }
  join: contacts_attended_dim {
    from: contacts_dim
    view_label: "  Contact Meeting Attendees"
    sql_on: ${contact_meetings_fact__all_attendee_contact_pk.contact_meetings_fact__all_attendee_contact_pk} = ${contacts_attended_dim.contact_pk} ;;
    relationship: many_to_one
    type: inner
  }
  join: contact_meeting_deal {
    view_label: "  Contact Meeting Deal"
    from: deals_fact
    sql_on: ${contact_meetings_fact.deal_pk} = ${contact_meeting_deal.deal_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: contacts_engaged_dim {
    from: contacts_dim
    view_label: " Contacts Engaged"
    sql_on: ${contact_engagements_fact.to_contact_pk} = ${contacts_engaged_dim.contact_pk} ;;
    relationship: many_to_one
    type: left_outer
  }
  join: delivered_companies_dim {
    from: companies_dim
    view_label: "       Companies"
    sql_on: ${projects_delivered.company_pk} = ${delivered_companies_dim.company_pk}
      and ${timesheets_fact.company_pk} = ${delivered_companies_dim.company_pk};;
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
  join: marketing_interactions_fact {
    view_label: "Content Marketing"
    sql_on: ${contacts.contact_pk} = ${marketing_interactions_fact.contact_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: marketing_content_dim{
    view_label: "Content Marketing"
    sql_on: ${marketing_interactions_fact.marketing_content_pk} = ${marketing_content_dim.marketing_content_pk} ;;
    type: left_outer
    relationship: many_to_one
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
  join: payments_fact {
    view_label: " Payments"
    type: left_outer
    sql_on: ${projects_invoiced.invoice_pk} = ${payments_fact.payment_invoice_fk};;
    relationship: one_to_many
  }
  }

explore: projects_delivered {
  hidden: yes
  label: "Projects"
  group_label: "   Production"
  view_label: "         Projects"
  from: timesheet_projects_dim
  join: project_timesheets {
    view_label: "     Timesheets"
    from: timesheets_fact
    sql_on: ${projects_delivered.timesheet_project_pk} = ${project_timesheets.timesheet_project_pk};;
    type: left_outer
    relationship: one_to_many
  }
  join: projects_delivered_is_ontime {
    view_label: "         Projects"
    sql_on: ${projects_delivered.timesheet_project_pk} = ${projects_delivered_is_ontime.timesheet_project_pk} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: project_timesheet_users {
    view_label: "     Timesheets"
    from: staff_dim
    sql_on: ${project_timesheets.contact_pk}  = ${project_timesheet_users.contact_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: consultant_revenue_attribution {
    view_label: "    Consultant Contribution"
    sql_on: ${project_timesheets.contact_pk} = ${consultant_revenue_attribution.contact_pk}
      and ${project_timesheets.timesheet_project_pk} = ${consultant_revenue_attribution.timesheet_project_pk};;
      relationship: one_to_one
      type: left_outer
  }
  join: companies_dim {
    view_label: "         Projects"
    sql_on: ${projects_delivered.company_pk} = ${companies_dim.company_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: projects_invoiced {
    view_label: "   Invoices"
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
  join: payments_fact {
    view_label: " Payments"
    type: left_outer
    sql_on: ${projects_invoiced.invoice_pk} = ${payments_fact.payment_invoice_fk};;
    relationship: one_to_many
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
  join: timesheet_project_costs_fact {
    view_label: "  Other Costs"
    sql_on: ${projects_delivered.timesheet_project_pk} = ${timesheet_project_costs_fact.timesheet_project_pk};;
    type: left_outer
    relationship: many_to_one
  }
  join: expenses_exchange_rates {
    from: exchange_rates
    sql_on: ${timesheet_project_costs_fact.expense_currency_code} = ${expenses_exchange_rates.currency_code} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: deals_fact {
    view_label: "Sales Deals"
    sql_on: ${companies_dim.company_pk} = ${deals_fact.company_pk};;
    type: full_outer
    relationship: one_to_many
  }
}



explore: nps_survey_results_fact {
  label: "NPS Surveys"
  group_label: "   Production"
  view_label: "    NPS Surveys"
  join: contacts_dim {
    view_label: "Survey Respondents"
    sql_on: ${nps_survey_results_fact.contact_fk} = ${contacts_dim.contact_pk} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: companies_dim {
    view_label: "  Companies Surveyed"
    sql_on: ${nps_survey_results_fact.company_fk} = ${companies_dim.company_pk} ;;
    type: left_outer
    relationship: many_to_one

  }
}

explore: hr_survey_results_fact {
  hidden: yes
  label: "Team"
  view_label: "Staff Satisfaction"
  group_label: "Experimental"
}

explore: website_leads {
  hidden: no
  group_label: "Experimental"
}

explore: targets {
  label: "Targets"
  hidden: no
  view_label: "Targets"
  join: sales_targets {
    view_label: "Targets"
    sql_on: ${targets.period_month} = ${sales_targets.period_month} ;;
    type: left_outer
    relationship: one_to_one
  }
}







explore: contact_utilization_fact {
  hidden: no

  label: "Utilization"
  group_label: "Experimental"

  view_label: "Utilization"
  join: staff_dim {
    view_label: "   Delivery Team"
    sql_on: ${contact_utilization_fact.contact_pk} = ${staff_dim.contact_pk} ;;
    type: left_outer
    relationship: many_to_one
  }
}

explore: web_sessions_fact {
  #sql_always_where: ${web_sessions_fact.site} = 'www.switcherstudio.com' ;;
  label: "Web Analytics"
  view_label: "  Sessions"
  group_label: "   Production"
  join: wh_sessions_attribution {
    view_label: "  Sessions"
    sql_on: ${web_sessions_fact.web_sessions_pk} = ${wh_sessions_attribution.web_session_fk} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: page_first_published {
    view_label: "  Sessions"
    sql_on: ${web_sessions_fact.first_page_title} = ${page_first_published.web_sessions_fact_first_page_title} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: web_events_fact {
    view_label: " Events"
    sql_on: ${web_sessions_fact.session_id} = ${web_events_fact.session_id} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: visitor_details {
    from: email_contacts_dim
    sql_on: ${web_sessions_fact.blended_user_id} = ${visitor_details.contact_email};;
    type: left_outer
    relationship: one_to_one
  }
  join: has_viewed_pricing {
    view_label: "  Sessions"
    sql_on: ${web_sessions_fact.blended_user_id} = ${has_viewed_pricing.web_sessions_fact_blended_user_id} ;;
    type: inner
    relationship: one_to_one
  }
  join: visitor_companies {
    from: contact_companies_fact
      sql_on: ${visitor_details.contact_pk} = ${visitor_companies.contact_pk};;
      type: inner
      relationship: one_to_many
    }
  join: visitor_organisations {
    from: companies_dim
    sql_on: ${visitor_companies.company_pk} = ${visitor_organisations.company_pk};;
    type: inner
    relationship: many_to_one
  }
  join: visitor_journey {
    view_label: "Visitor Journey"
    sql_on: ${web_sessions_fact.web_sessions_pk} = ${visitor_journey.web_sessions_pk} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: is_conversion_session {
    view_label: "  Sessions"
    type: left_outer
    sql_on: ${web_sessions_fact.session_id} = ${is_conversion_session.web_events_fact_session_id} ;;
    relationship: one_to_one
    }
  join: ad_campaigns_dim {
    view_label: "Campaigns"
    sql_on: ${web_sessions_fact.ad_campaign_pk} = ${ad_campaigns_dim.ad_campaign_pk};;
    type: left_outer
    relationship: one_to_many
  }
  join: marketing_content_dim {
    view_label: "Content"
    sql_on: ${web_sessions_fact.referrer_article_stub} = ${marketing_content_dim.article_stub} ;;
    type: left_outer
    relationship: many_to_one
  }
}

explore: companies_dim {
  label: "Companies"
  view_label: "        Companies"

  group_label: "   Production"
  hidden: no
  join: client_concentration {
    view_label: "Monthly Concentration"
    sql_on: ${projects_invoiced.invoice_sent_at_ts_month} = ${client_concentration.invoice_month_month} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: companies_dim__all_company_ids {
    view_label: "        Companies"
    sql: LEFT JOIN UNNEST(${companies_dim__all_company_ids.companies_dim__all_company_ids}) as  companies_dim__all_company_ids;;
    relationship: one_to_many
  }
  join: nps_survey_results_fact {
    view_label: "    NPS Surveys"
    sql_on: ${companies_dim.company_pk} = ${nps_survey_results_fact.company_fk}  ;;
    relationship: one_to_many
    type: left_outer
    }
  join: client_prospect_status_dim {
    view_label: "        Companies"
    sql_on: ${companies_dim.company_pk} = ${client_prospect_status_dim.company_pk} ;;
    type: left_outer
    relationship: one_to_one
  }

  join: customer_first_order_segments {
    view_label: "        Companies"
    sql_on: ${companies_dim.company_pk} = ${customer_first_order_segments.companies_dim_company_pk} ;;
    type: left_outer
    relationship: one_to_one
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
  join: projects_invoiced {
    view_label: "    Invoicing"
    from: invoices_fact
    sql_on: ${projects_delivered.timesheet_project_pk} = ${projects_invoiced.timesheet_project_pk};;
    type: left_outer
    relationship: one_to_many
  }
  join: projects_delivered {
    view_label: "    Invoicing"
    from: timesheet_projects_dim
    sql_on: ${companies_dim.company_pk} = ${projects_delivered.company_pk} ;;
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
  join: projects_delivered_is_ontime {
    view_label: "      Timesheets"
    sql_on: ${projects_delivered.timesheet_project_pk} = ${projects_delivered_is_ontime.timesheet_project_pk} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: project_timesheet_users {
    view_label: "      Timesheets"
    from: contacts_dim
    sql_on: ${project_timesheets.contact_pk}  = ${project_timesheet_users.contact_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: consultant_revenue_attribution {
    view_label: "    Consultant Contribution"
    sql_on: ${project_timesheets.contact_pk} = ${consultant_revenue_attribution.contact_pk}
      and ${project_timesheets.timesheet_project_pk} = ${consultant_revenue_attribution.timesheet_project_pk};;
      type: left_outer
      relationship: one_to_one
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
  join: timesheet_project_costs_fact {
    view_label: "      Timesheets"
    sql_on: ${projects_delivered.timesheet_project_pk} = ${timesheet_project_costs_fact.timesheet_project_pk};;
    type: left_outer
    relationship: many_to_one
  }
  join: expenses_exchange_rates {
    from: exchange_rates
    sql_on: ${timesheet_project_costs_fact.expense_currency_code} = ${expenses_exchange_rates.currency_code} ;;
    type: left_outer
    relationship: many_to_one
  }
}

  explore: project_attribution {
    hidden: no
    label: "Attribution"
    view_label: "Project Attribution"
    group_label: "Experimental"

    join: staff_dim {
      view_label: "Team"
      sql_on: ${project_attribution.contact_pk} = ${staff_dim.contact_pk} ;;
      type: inner
      relationship: many_to_one
    }
    join: timesheet_projects_dim {
      view_label: "Projects"
      sql_on: ${project_attribution.timesheet_project_pk} = ${timesheet_projects_dim.timesheet_project_pk} ;;
      type: inner
      relationship: many_to_one
    }
    join: projects_invoiced {
      view_label: "    Invoicing"
      from: invoices_fact
      sql_on: ${project_attribution.timesheet_project_pk} = ${projects_invoiced.timesheet_project_pk};;
      type: left_outer
      relationship: one_to_many
    }
    join: payments_fact {
      view_label: " Finance"
      type: left_outer
      sql_on: ${projects_invoiced.invoice_pk} = ${payments_fact.payment_invoice_fk};;
      relationship: one_to_many
    }
    join: exchange_rates {
      sql_on: ${projects_invoiced.invoice_currency} = ${exchange_rates.currency_code} ;;
      type: left_outer
      relationship: many_to_one
    }
  }

  explore: timesheets_forecast_fact {
    hidden: no
    label: "Resource Forecast"
    group_label: "Experimental"

    view_label: "Resource Forecast"
    join: staff_dim {
      view_label: "Project Resources"
      sql_on: ${timesheets_forecast_fact.contact_pk} = ${staff_dim.contact_pk};;
      type: inner
      relationship: many_to_one
    }
    join: timesheet_projects_dim {
      view_label: "Projects"
      sql_on: ${timesheets_forecast_fact.timesheet_project_pk} = ${timesheet_projects_dim.timesheet_project_pk} ;;
      type: inner
      relationship: many_to_one
    }
    join: projects_invoiced {
      view_label: "    Invoicing"
      from: invoices_fact
      sql_on: ${timesheets_forecast_fact.timesheet_project_pk} = ${projects_invoiced.timesheet_project_pk};;
      type: left_outer
      relationship: one_to_many
    }
    join: payments_fact {
      view_label: " Finance"
      type: left_outer
      sql_on: ${projects_invoiced.invoice_pk} = ${payments_fact.payment_invoice_fk};;
      relationship: one_to_many
    }
    join: exchange_rates {
      sql_on: ${projects_invoiced.invoice_currency} = ${exchange_rates.currency_code} ;;
      type: left_outer
      relationship: many_to_one
    }
  }





  explore: chart_of_accounts_dim {
    group_label: "   Production"

    label: "Finance"
    hidden: no
    view_label: "Accounts"
    join: general_ledger_fact {
      view_label: "General Ledger"
      sql_on: ${chart_of_accounts_dim.account_id} = ${general_ledger_fact.account_id};;
      type: left_outer
      relationship: one_to_many
    }
    join: profit_and_loss_report_fact {
      view_label: "Profit & Loss Report"
      sql_on: ${chart_of_accounts_dim.account_id} = ${profit_and_loss_report_fact.account_id};;
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
