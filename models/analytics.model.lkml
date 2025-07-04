connection: "ra_dw_prod"

# include all the views
include: "/views/**/*.view"

datagroup: analytics_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

fiscal_month_offset: +3
week_start_day: monday

explore: monthly_performance_fact {
  hidden: yes
}

explore: marketing_email_sends {
  from: email_sends_dim
  label: "Marketing Emails"
  join: email_send_outcomes_fact {
    view_label: "Send Outcomes"
    sql_on: ${marketing_email_sends.send_pk} = ${email_send_outcomes_fact.send_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
}

explore: keyword_page_report {}

explore: customers_dim {

  from: companies_dim
  label: "                    Customer Operations"
  view_label: "           Customers"
  description: "Customer Operations Reporting on Sales and Delivery"
  hidden: no
  join: customer_meetings {
    view_label: "       Project Meetings"
    sql_on: ${customers_dim.company_pk} = ${customer_meetings.company_fk};;
    type: inner
    relationship: one_to_many
  }
  join: customer_meeting_attendees {
    view_label: "       Project Meetings"

    from: contacts_dim
    fields: [customer_meeting_attendees.contact_name,customer_meeting_attendees.contact_bio]
    sql_on: ${customer_meetings.contact_fk} = ${customer_meeting_attendees.contact_pk} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: engagements {
    view_label: "        Engagements (SoWs)"
    sql_on: ${customers_dim.company_pk} = ${engagements.company_fk};;
    type: left_outer
    relationship: one_to_many
  }
  join: engagement_details {
    view_label: "        Engagements (SoWs)"
    sql_on: ${engagements.deal_id} = ${engagement_details.deal_id} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: engagement_details__objectives {
    view_label: "        Engagements (SoWs)"
    sql: LEFT JOIN UNNEST(${engagement_details.objectives}) as engagement_details__objectives ;;
    relationship: one_to_many

  }
  join: engagement_details__deliverables {
    view_label: "        Engagements (SoWs)"
    sql: LEFT JOIN UNNEST(${engagement_details.deliverables}) as engagement_details__deliverables ;;
    relationship: one_to_many
  }
  join: timesheet_project_engagements_dim__projects {
    view_label: "       Engagement Sprints"
    sql: LEFT JOIN UNNEST(${engagements.projects}) as timesheet_project_engagements_dim__projects ;;
    relationship: one_to_many
  }
  join: timesheet_project_engagements_projects_invoiced {
    view_label: "       Engagement Sprints"
    from: invoices_fact
    fields: [timesheet_project_engagements_projects_invoiced.total_invoiced_net_amount_gbp,timesheet_project_engagements_projects_invoiced.invoice_paid_date,timesheet_project_engagements_projects_invoiced.invoice_sent_at_ts_date,timesheet_project_engagements_projects_invoiced.invoice_sent_at_ts_month,timesheet_project_engagements_projects_invoiced.invoice_sent_at_ts_quarter,timesheet_project_engagements_projects_invoiced.invoice_sent_at_ts_year,timesheet_project_engagements_projects_invoiced.invoice_currency,timesheet_project_engagements_projects_invoiced.total_local_amount,timesheet_project_engagements_projects_invoiced.expected_payment_date,timesheet_project_engagements_projects_invoiced.invoice_due_date,timesheet_project_engagements_projects_invoiced.invoice_total_days_overdue,timesheet_project_engagements_projects_invoiced.invoice_tax_rate_pct,total_invoice_net_amount_local,total_invoice_tax_local,invoice_issued_date,invoice_seq,invoice_subject,invoice_number,avg_invoice_days_overdue,avg_invoice_days_to_pay,total_invoice_gross_amount_local,total_invoice_tax_local]
    sql_on: ${timesheet_project_engagements_dim__projects.timesheet_project_pk} = ${timesheet_project_engagements_projects_invoiced.timesheet_project_fk};;
    type: left_outer
    relationship: one_to_many
  }

  join: timesheet_project_engagement_timesheets {
    view_label: "       Engagement Sprints"
    fields: [timesheet_project_engagement_timesheets.total_timesheet_cost_amount_gbp,timesheet_project_engagement_timesheets.timesheet_billing_date,timesheet_project_engagement_timesheets.timesheet_billing_week,timesheet_project_engagement_timesheets.timesheet_billing_month,timesheet_project_engagement_timesheets.total_timesheet_nonbillable_hours_billed,timesheet_project_engagement_timesheets.total_timesheet_billable_hours_billed]
    from: timesheets_fact
    sql_on: ${timesheet_project_engagements_dim__projects.timesheet_project_pk} = ${timesheet_project_engagement_timesheets.timesheet_project_fk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: timesheet_project_engagement_timesheet_users {
    view_label: "       Engagement Sprints"
    from: contacts_dim
    fields: [timesheet_project_engagement_timesheet_users.contact_name]
    sql_on: ${timesheet_project_engagement_timesheets.contact_pk}  = ${timesheet_project_engagement_timesheet_users.contact_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: timesheet_project_engagement_timesheet_tasks {
    view_label: "       Engagement Sprints"
    from: timesheet_tasks_dim
    fields: [timesheet_project_engagement_timesheet_tasks.task_name]
    sql_on: ${timesheet_project_engagement_timesheets.timesheet_task_fk}  = ${timesheet_project_engagement_timesheet_tasks.timesheet_task_pk} ;;
    type: left_outer
    relationship: one_to_many
  }

  join: timesheet_project_engagement_project_costs_fact {
    from: timesheet_project_costs_fact
    view_label: "       Engagement Sprints"
    fields: [timesheet_project_engagement_project_costs_fact.total_cost_gbp]
    sql_on: ${timesheet_project_engagements_dim__projects.timesheet_project_pk} = ${timesheet_project_engagement_project_costs_fact.timesheet_project_pk};;
    type: left_outer
    relationship: many_to_one
  }
  join: timesheet_project_engagement_timesheets_projects_dim {
    from: timesheet_projects_dim
    fields: [timesheet_project_engagement_timesheets_projects_dim.project_name,timesheet_project_engagement_timesheets_projects_dim.project_delivery_start_ts_date,timesheet_project_engagement_timesheets_projects_dim.project_delivery_end_ts_date, timesheet_project_engagement_timesheets_projects_dim.total_project_fee_amount,project_hours_budget]
    view_label: "       Engagement Sprints"
    sql_on: ${timesheet_project_engagement_timesheets.timesheet_project_fk} = ${timesheet_project_engagement_timesheets_projects_dim.timesheet_project_pk} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: deals_fact {
    view_label: "        Sales"
    sql_on: ${customers_dim.company_pk} = ${deals_fact.company_pk};;
    type: full_outer
    relationship: one_to_many
  }
  join: deal_targets {
    from: targets
    fields: [total_deals_closed_revenue_target]
    view_label: "        Sales"
    sql_on: ${deals_fact.deal_closed_month} = ${deal_targets.period_month} ;;
    type: left_outer
    relationship: many_to_one
  }


}


explore: contacts {
  hidden: yes
  from: contacts_dim
  label: "         Delivery Team"
  view_label: "          Staff Member"
  sql_always_where: ${contact_is_staff} or ${contact_is_contractor} ;;
  description: "Utilisation and project activity for RA Delivery Team Members"
  join: timesheets_fact {
    view_label: "Project Timesheets (Harvest)"
    sql_on: ${contacts.contact_pk} = ${timesheets_fact.contact_pk}  ;;
    type: left_outer
    relationship: one_to_many
  }
  join: messages_fact {
    view_label: "Messages"
    sql_on: ${contacts.contact_pk} = ${messages_fact.contact_fk} ;;
    type: left_outer
    relationship: one_to_many
  }

  join: customer_meetings {
    view_label: "Customer Meetings"
    sql_on: ${contacts.contact_pk} = ${customer_meetings.contact_fk} ;;
    type: left_outer
    relationship: one_to_many
  }

  join: meeting_contact_lines_fact {
    view_label: "Meeting Transcript Lines"
    sql_on: ${contacts.contact_pk} = ${meeting_contact_lines_fact.contact_fk} ;;
    type: left_outer
    relationship: one_to_many
  }

  join: projects_delivered {
    view_label: "Project Timesheets (Harvest)"
    from: timesheet_projects_dim
    sql_on: ${timesheets_fact.timesheet_project_fk} = ${projects_delivered.timesheet_project_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: projects_delivered_clients {
    from: companies_dim
    view_label: "Project Timesheets (Harvest)"
    sql_on: ${timesheets_fact.company_fk} = ${projects_delivered_clients.company_pk}
      and ${projects_delivered.company_fk} = ${projects_delivered_clients.company_pk};;
    type: inner
    relationship: one_to_many
  }

  join: timesheet_tasks_dim {
    view_label: "Project Timesheets (Harvest)"
    sql_on: ${timesheets_fact.timesheet_task_fk} = ${timesheet_tasks_dim.timesheet_task_pk} ;;
    type: inner
    relationship: many_to_one
  }
  join: projects_invoiced {
    view_label: "Project Invoicing (Harvest)"
    from: invoices_fact
    sql_on: ${projects_delivered.timesheet_project_pk} = ${projects_invoiced.timesheet_project_fk};;
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
    sql_on: ${delivery_tasks_fact.delivery_project_fk} = ${projects_managed.delivery_project_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  #join: delivery_team_fact_xa {
  #  view_label: "Project Stats"
  #  sql_on: ${contacts.contact_pk} = ${delivery_team_fact_xa.contact_pk} ;;
  #  type: left_outer
  #  relationship: one_to_one
  #}
  join: delivered_companies_dim {
    from: companies_dim
    view_label: "       Clients"
    sql_on: ${projects_delivered.company_fk} = ${delivered_companies_dim.company_pk}
      and ${timesheets_fact.company_fk} = ${delivered_companies_dim.company_pk};;
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

explore: monzo_bank_transactions_enriched {
  view_label: "Bank Transactions"
  label: "Banking"
}

explore: icp_lookalike_audience_uk_ie_eu_only {
  label: "ICP Target List"
}


explore: monthly_resource_revenue_forecast_fact {
  hidden: yes
  label: "Monthly Forecast"
}

explore: timesheet_project_monthly_forecast_billing_fact {
  hidden: yes
}

explore: linkedin_company_pages {}

explore: looker_usage_stats {}


explore: performance_narrative_fact {
  hidden: yes

}

explore: fathom_meetings {
  hidden: no
  view_label: "Meetings"
  join: fathom_meeting_actions {
    sql_on: ${fathom_meetings.recording_url} = ${fathom_meeting_actions.recording_url} ;;
    type: left_outer
    relationship: one_to_many
  }


}

explore: pl_reports {
  hidden: yes

}

explore: project_engagements {
  hidden: yes

}

explore: dynamic_web_stats {
  hidden: yes

}







explore: people {
  hidden: no
  from: contacts_dim
  label: "     Contacts"
  view_label: "Client and Marketing Contacts"
  description: "Client contacts, leads and contacts and their related marketing and sales activity"

  join: contact_engagements_fact {
    view_label: "Meetings"
    sql_on: ${people.contact_pk} = ${contact_engagements_fact.from_contact_pk} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: contact_engagement_deal_fact {
    from: deals_fact
    view_label: "Engagement Related Deal"
    sql_on: ${contact_engagements_fact.deal_pk} = ${contact_engagement_deal_fact.deal_pk};;
    type: left_outer
    relationship: many_to_one
  }
  join: contact_bio {
    view_label: "     Contacts"
    sql_on: ${people.contact_pk} = ${contact_bio.contact_pk} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: contact_meetings_fact {
    view_label: "Meetings"
    sql_on: ${people.contact_pk} = ${contact_meetings_fact.meeting_host_contact_pk};;
    type: left_outer
    relationship: one_to_many
  }
  join: contact_meetings_fact__all_attendee_contact_pk {
    view_label: "Sales Meeting Attendees"
    sql: LEFT JOIN UNNEST(${contact_meetings_fact.all_attendee_contact_pk}) as contact_meetings_fact__all_attendee_contact_pk ;;
    relationship: one_to_many
  }
  join: contacts_attended_dim {
    from: contacts_dim
    view_label: "Sales Meeting Attendees"
    sql_on: ${contact_meetings_fact__all_attendee_contact_pk.contact_meetings_fact__all_attendee_contact_pk} = ${contacts_attended_dim.contact_pk} ;;
    relationship: many_to_one
    type: inner
  }

  join: contacts_engaged_dim {
    from: contacts_dim
    view_label: "Sales Meeting Attendees"
    sql_on: ${contact_engagements_fact.to_contact_pk} = ${contacts_engaged_dim.contact_pk} ;;
    relationship: many_to_one
    type: left_outer
  }
  join: looker_usage_fact {
    view_label: "Looker Usage"
    sql_on: ${looker_usage_fact.contact_pk} = ${people.contact_pk};;
    type: left_outer
    relationship: one_to_many
  }
  join: contact_deals_fact {
    sql_on: ${people.contact_pk} = ${contact_deals_fact.contact_pk} ;;
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
    sql_on: ${people.hubspot_contact_id} = ${contacts_influencer_list_xa.hubspot_contact_id} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: contacts_web_event_history_xa {
    view_label: "Web History"
    sql_on: ${people.contact_pk} = ${contacts_web_event_history_xa.contact_pk} ;;
    type: inner
    relationship: one_to_many
  }
  join: contacts_web_interests_xa {
    view_label: "          Contacts"
    sql_on: ${people.contact_pk} = ${contacts_web_interests_xa.contact_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: marketing_interactions_fact {
    view_label: "Content Marketing"
    sql_on: ${people.contact_pk} = ${marketing_interactions_fact.contact_pk} ;;
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
    sql_on: ${people.contact_pk} = ${contact_contracts.contact_pk} ;;
    type: inner
    relationship: one_to_many
  }
  join: contact_nps_survey_fact {
    sql_on: ${people.contact_pk} = ${contact_nps_survey_fact.contact_pk} ;;
    view_label: "NPS Scores"
    type: inner
    relationship: one_to_many
  }

}

explore: company_comparison {}



explore: revenue_and_forecast {

  hidden: yes
  description: "Explore that provides booked and forecast (high probability) revenue for past and upcoming months"


}










explore: ad_campaign_performance_fact {
  label: "Campaign Performance"
  description: "Ad Campaigns and Website Performance"
  view_label: "     Campaign Performance"
  hidden: yes
  group_label: "    Analysis"

  join: ad_campaigns_dim {
    view_label: "      Campaigns"
    sql_on: ${ad_campaign_performance_fact.ad_campaign_fk} = ${ad_campaigns_dim.ad_campaign_pk} ;;
    type: left_outer
    relationship: many_to_one
  }
}

explore: site_report_by_site {
  hidden: no
}







explore: projects_delivered {
  hidden: yes
  label: "           Projects"
  view_label: "      Project Delivery"
  group_label: "        Core Analytics"

  from: timesheet_projects_dim
  join: project_timesheets {
    view_label: "     Timesheets"
    from: timesheets_fact
    sql_on: ${projects_delivered.timesheet_project_pk} = ${project_timesheets.timesheet_project_fk};;
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
      and ${project_timesheets.timesheet_project_fk} = ${consultant_revenue_attribution.timesheet_project_pk};;
      relationship: one_to_one
      type: left_outer
  }
  join: companies_dim {
    view_label: "         Projects"
    sql_on: ${projects_delivered.company_fk} = ${companies_dim.company_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: projects_invoiced {
    view_label: "   Invoices"
    from: invoices_fact
    sql_on: ${projects_delivered.timesheet_project_pk} = ${projects_invoiced.timesheet_project_fk};;
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
  join: deal_projects_dim {
    view_label: "        Sales"
    from: timesheet_projects_dim
    sql_on: ${deals_fact.deal_id} = ${deal_projects_dim.deal_id} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: deal_project_timesheets_fact {
    view_label: "        Sales"

    from: timesheets_fact
    sql_on: ${deal_projects_dim.timesheet_project_pk} = ${deal_project_timesheets_fact.timesheet_project_fk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: deal_project_invoices_fact {
    view_label: "        Sales"

    from: invoices_fact
    sql_on: ${deal_projects_dim.timesheet_project_pk} = ${deal_project_invoices_fact.timesheet_project_fk};;
    type: left_outer
    relationship: one_to_many
  }
}



explore: nps_survey_results_fact {
  label: "NPS Surveys"
  group_label: "        Core Analytics"

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
  join: engagements {
    view_label: " Engagements"
    sql_on: ${companies_dim.company_pk} = ${engagements.company_fk} ;;
    type: inner
    relationship: one_to_many
  }
}



explore: website_leads {
  group_label: "        Core Analytics"

  hidden: no
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

  label: "    Utilization"
  description: "Team Member utilisation reporting"
  group_label: "        Core Analytics"

  view_label: "Utilization"
  join: staff_dim {
    view_label: "   Delivery Team"
    sql_on: ${contact_utilization_fact.contact_pk} = ${staff_dim.contact_pk} ;;
    type: left_outer
    relationship: many_to_one
  }
}

explore: web_sessions_fact {
  label: "    Web Analytics"
  group_label: "        Core Analytics"

  view_label: "  Sessions"
  description: "Website activity and visitor journey"
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
  join: ips_enriched {
    view_label: " Events"
    sql_on: ${web_events_fact.ip} = ${ips_enriched.ip} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: has_viewed_pricing {
    view_label: "  Sessions"
    sql_on: ${web_sessions_fact.blended_user_id} = ${has_viewed_pricing.web_sessions_fact_blended_user_id} ;;
    type: inner
    relationship: one_to_one
  }

  join: is_conversion_session {
    view_label: "  Sessions"
    type: left_outer
    sql_on: ${web_sessions_fact.session_id} = ${is_conversion_session.web_events_fact_session_id} ;;
    relationship: one_to_one
    }

}

explore: client_projects {
  from: companies_dim
  hidden: yes
  group_label: "        Core Analytics"
  view_label: "Client Accounts"
  join: engagements {
    view_label: "        Engagements (SoWs)"
    sql_on: ${client_projects.company_pk} = ${engagements.company_fk};;
    type: left_outer
    relationship: one_to_many
  }
  join: engagement_details {
    view_label: "        Engagements (SoWs)"
    sql_on: ${engagements.deal_id} = ${engagement_details.deal_id} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: engagement_details__objectives {
    view_label: "        Engagements (SoWs)"
    sql: LEFT JOIN UNNEST(${engagement_details.objectives}) as engagement_details__objectives ;;
    relationship: one_to_many

  }
  join: engagement_details__deliverables {
    view_label: "        Engagements (SoWs)"
    sql: LEFT JOIN UNNEST(${engagement_details.deliverables}) as engagement_details__deliverables ;;
    relationship: one_to_many
  }
  join: project_engagements {
    view_label: "        Engagements (SoWs) Pipeline History"
    sql_on: ${engagements.engagement_code} = ${project_engagements.engagement_code} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: timesheet_project_engagements_dim__projects {
    view_label: "        Engagements (SoWs)"
    sql: LEFT JOIN UNNEST(${engagements.projects}) as timesheet_project_engagements_dim__projects ;;
    relationship: one_to_many
  }
  join: timesheet_project_engagements_projects_invoiced {
    view_label: "        Engagements (SoWs)"
    from: invoices_fact
    fields: [timesheet_project_engagements_projects_invoiced.total_invoiced_net_amount_gbp,timesheet_project_engagements_projects_invoiced.invoice_paid_date,timesheet_project_engagements_projects_invoiced.invoice_sent_at_ts_date,timesheet_project_engagements_projects_invoiced.invoice_currency,timesheet_project_engagements_projects_invoiced.total_local_amount,timesheet_project_engagements_projects_invoiced.expected_payment_date,timesheet_project_engagements_projects_invoiced.invoice_due_date,timesheet_project_engagements_projects_invoiced.invoice_total_days_overdue,timesheet_project_engagements_projects_invoiced.invoice_tax_rate_pct,total_invoice_net_amount_local,total_invoice_tax_local,invoice_issued_date,invoice_seq,invoice_subject,invoice_number,avg_invoice_days_overdue,avg_invoice_days_to_pay,total_invoice_gross_amount_local,total_invoice_tax_local]
    sql_on: ${timesheet_project_engagements_dim__projects.timesheet_project_pk} = ${timesheet_project_engagements_projects_invoiced.timesheet_project_fk};;
    type: left_outer
    relationship: one_to_many
  }

  join: timesheet_project_engagement_timesheets {
    view_label: "        Engagements (SoWs)"
    fields: [timesheet_project_engagement_timesheets.total_timesheet_cost_amount_gbp,timesheet_project_engagement_timesheets.timesheet_billing_date,timesheet_project_engagement_timesheets.timesheet_billing_week,timesheet_project_engagement_timesheets.timesheet_billing_month,timesheet_project_engagement_timesheets.total_timesheet_nonbillable_hours_billed,timesheet_project_engagement_timesheets.total_timesheet_billable_hours_billed]
    from: timesheets_fact
    sql_on: ${timesheet_project_engagements_dim__projects.timesheet_project_pk} = ${timesheet_project_engagement_timesheets.timesheet_project_fk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: timesheet_project_engagement_timesheet_users {
    view_label: "        Engagements (SoWs)"
    from: contacts_dim
    fields: [timesheet_project_engagement_timesheet_users.contact_name]
    sql_on: ${timesheet_project_engagement_timesheets.contact_pk}  = ${timesheet_project_engagement_timesheet_users.contact_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: timesheet_project_engagement_timesheet_tasks {
    view_label: "        Engagements (SoWs)"
    from: timesheet_tasks_dim
    fields: [timesheet_project_engagement_timesheet_tasks.task_name]
    sql_on: ${timesheet_project_engagement_timesheets.timesheet_task_fk}  = ${timesheet_project_engagement_timesheet_tasks.timesheet_task_pk} ;;
    type: left_outer
    relationship: one_to_many
  }

  join: timesheet_project_engagement_project_costs_fact {
    from: timesheet_project_costs_fact
    view_label: "        Engagements (SoWs)"
    fields: [timesheet_project_engagement_project_costs_fact.total_cost_gbp]
    sql_on: ${timesheet_project_engagements_dim__projects.timesheet_project_pk} = ${timesheet_project_engagement_project_costs_fact.timesheet_project_pk};;
    type: left_outer
    relationship: many_to_one
  }
  join: timesheet_project_engagement_timesheets_projects_dim {
    from: timesheet_projects_dim
    fields: [timesheet_project_engagement_timesheets_projects_dim.total_project_fee_amount,project_hours_budget]
    view_label: "        Engagements (SoWs)"
    sql_on: ${timesheet_project_engagement_timesheets.timesheet_project_fk} = ${timesheet_project_engagement_timesheets_projects_dim.timesheet_project_pk} ;;
    type: left_outer
    relationship: many_to_one
  }

}

explore: companies_dim {
  access_filter: {
    field: companies_dim.company_name
    user_attribute: company_name
  }
  label: "                    Business Operations"
  group_label: "        Core Analytics"
  view_label: "           Companies"
  description: "Main explore used for reporting, starts with prospects and covers lifecycle through to projects and NPS"
  hidden: no

  join: ideal_customer_2025 {
    view_label: "           Companies"
    sql_on: ${ideal_customer_2025.company_name} = ${companies_dim.company_name} ;;
    type: inner
    relationship: one_to_one
  }
  join: delivery_project_docs_dim {
    view_label: "      Project Timesheets"
    sql_on: ${delivery_project_docs_dim.company_fk} = ${companies_dim.company_pk} ;;
    type: inner
    relationship: many_to_one
  }

  join: timesheet_project_engagement_rag_status_fact {
    view_label: "         Client RAG Status History"
    sql_on: ${companies_dim.company_name} = ${timesheet_project_engagement_rag_status_fact.client_name} ;;
    type: left_outer
    relationship: one_to_many
  }

  join: timesheet_project_engagement_rag_status_fact__month_timeline_events {
    view_label: "         Client RAG Status History"
    sql: LEFT JOIN UNNEST(${timesheet_project_engagement_rag_status_fact.month_timeline_events}) as timesheet_project_engagement_rag_status_fact__month_timeline_events ;;
    relationship: one_to_many
  }

  join: timesheet_project_engagement_rag_status_fact__ra_action_points {
    view_label: "         Client RAG Status History"
    sql: LEFT JOIN UNNEST(${timesheet_project_engagement_rag_status_fact.ra_action_points}) as timesheet_project_engagement_rag_status_fact__ra_action_points ;;
    relationship: one_to_many
  }

  join: timesheet_project_engagement_rag_status_fact__client_action_points {
    view_label: "         Client RAG Status History"
    sql: LEFT JOIN UNNEST(${timesheet_project_engagement_rag_status_fact.client_action_points}) as timesheet_project_engagement_rag_status_fact__client_action_points ;;
    relationship: one_to_many
  }



  join: customer_meetings {
    view_label: "       Project Meetings"
    sql_on: ${companies_dim.company_pk} = ${customer_meetings.company_fk};;
    type: inner
    relationship: one_to_many
  }
  join: timesheet_project_stakeholder_jtbd_fact {
    view_label: "       Project Meetings"
    sql_on: ${customer_meetings.contact_fk} = ${timesheet_project_stakeholder_jtbd_fact.contact_fk} ;;
    relationship: one_to_one
    type: left_outer
  }
  join: customer_meeting_attendees {
    view_label: "       Project Meetings"

    from: contacts_dim
    fields: [customer_meeting_attendees.contact_name,customer_meeting_attendees.contact_bio]
    sql_on: ${customer_meetings.contact_fk} = ${customer_meeting_attendees.contact_pk} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: timesheet_project_stakeholder_jtbd_fact__keywords {
    view_label: "       Project Meetings"
    sql: LEFT JOIN UNNEST(${timesheet_project_stakeholder_jtbd_fact.keywords}) as timesheet_project_stakeholder_jtbd_fact__keywords ;;
    relationship: one_to_many
  }
  join: timesheet_project_stakeholder_jtbd_fact__identified_jtbds {
    view_label: "       Project Meetings"
    sql: LEFT JOIN UNNEST(${timesheet_project_stakeholder_jtbd_fact.identified_jtbds}) as timesheet_project_stakeholder_jtbd_fact__identified_jtbds ;;
    relationship: one_to_many
  }

  join: messages_fact {
    view_label: "      Project Messages"
    sql_on: ${companies_dim.company_pk} = ${messages_fact.company_fk};;
    type: inner
    relationship: one_to_many
  }
  join: message_contacts {
    view_label: "      Project Messages"
    from: contacts_dim
    fields: [message_contacts.contact_name]
    sql_on: ${messages_fact.contact_fk} = ${message_contacts.contact_pk} ;;
    relationship: many_to_one

  }

  join: engagements {
    view_label: "        Engagements (SoWs)"
    sql_on: ${companies_dim.company_pk} = ${engagements.company_fk};;
    type: left_outer
    relationship: one_to_many
  }
  join: engagement_details {
    view_label: "        Engagements (SoWs)"
    sql_on: ${engagements.deal_id} = ${engagement_details.deal_id} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: engagement_details__objectives {
    view_label: "        Engagements (SoWs)"
    sql: LEFT JOIN UNNEST(${engagement_details.objectives}) as engagement_details__objectives ;;
    relationship: one_to_many

  }
  join: engagement_details__deliverables {
    view_label: "        Engagements (SoWs)"
    sql: LEFT JOIN UNNEST(${engagement_details.deliverables}) as engagement_details__deliverables ;;
    relationship: one_to_many
  }
  join: project_engagements {
    view_label: "        Engagements (SoWs) Pipeline History"
    sql_on: ${engagements.engagement_code} = ${project_engagements.engagement_code} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: timesheet_project_engagements_dim__projects {
    view_label: "        Engagements (SoWs)"
    sql: LEFT JOIN UNNEST(${engagements.projects}) as timesheet_project_engagements_dim__projects ;;
    relationship: one_to_many
  }
  join: timesheet_project_engagements_projects_invoiced {
    view_label: "        Engagements (SoWs)"
    from: invoices_fact
    fields: [timesheet_project_engagements_projects_invoiced.total_invoiced_net_amount_gbp,timesheet_project_engagements_projects_invoiced.invoice_paid_date,timesheet_project_engagements_projects_invoiced.invoice_sent_at_ts_date,timesheet_project_engagements_projects_invoiced.invoice_currency,timesheet_project_engagements_projects_invoiced.total_local_amount,timesheet_project_engagements_projects_invoiced.expected_payment_date,timesheet_project_engagements_projects_invoiced.invoice_due_date,timesheet_project_engagements_projects_invoiced.invoice_total_days_overdue,timesheet_project_engagements_projects_invoiced.invoice_tax_rate_pct,total_invoice_net_amount_local,total_invoice_tax_local,invoice_issued_date,invoice_seq,invoice_subject,invoice_number,avg_invoice_days_overdue,avg_invoice_days_to_pay,total_invoice_gross_amount_local,total_invoice_tax_local]
    sql_on: ${timesheet_project_engagements_dim__projects.timesheet_project_pk} = ${timesheet_project_engagements_projects_invoiced.timesheet_project_fk};;
    type: left_outer
    relationship: one_to_many
  }

  join: timesheet_project_engagement_timesheets {
    view_label: "        Engagements (SoWs)"
    fields: [timesheet_project_engagement_timesheets.total_timesheet_cost_amount_gbp,timesheet_project_engagement_timesheets.timesheet_billing_date,timesheet_project_engagement_timesheets.timesheet_billing_week,timesheet_project_engagement_timesheets.timesheet_billing_month,timesheet_project_engagement_timesheets.total_timesheet_nonbillable_hours_billed,timesheet_project_engagement_timesheets.total_timesheet_billable_hours_billed]
    from: timesheets_fact
    sql_on: ${timesheet_project_engagements_dim__projects.timesheet_project_pk} = ${timesheet_project_engagement_timesheets.timesheet_project_fk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: timesheet_project_engagement_timesheet_users {
    view_label: "        Engagements (SoWs)"
    from: contacts_dim
    fields: [timesheet_project_engagement_timesheet_users.contact_name]
    sql_on: ${timesheet_project_engagement_timesheets.contact_pk}  = ${timesheet_project_engagement_timesheet_users.contact_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: timesheet_project_engagement_timesheet_tasks {
    view_label: "        Engagements (SoWs)"
    from: timesheet_tasks_dim
    fields: [timesheet_project_engagement_timesheet_tasks.task_name]
    sql_on: ${timesheet_project_engagement_timesheets.timesheet_task_fk}  = ${timesheet_project_engagement_timesheet_tasks.timesheet_task_pk} ;;
    type: left_outer
    relationship: one_to_many
  }

  join: timesheet_project_engagement_project_costs_fact {
    from: timesheet_project_costs_fact
    view_label: "        Engagements (SoWs)"
    fields: [timesheet_project_engagement_project_costs_fact.total_cost_gbp]
    sql_on: ${timesheet_project_engagements_dim__projects.timesheet_project_pk} = ${timesheet_project_engagement_project_costs_fact.timesheet_project_pk};;
    type: left_outer
    relationship: many_to_one
  }
  join: timesheet_project_engagement_timesheets_projects_dim {
    from: timesheet_projects_dim
    fields: [timesheet_project_engagement_timesheets_projects_dim.project_name,timesheet_project_engagement_timesheets_projects_dim.project_delivery_start_ts_date,timesheet_project_engagement_timesheets_projects_dim.project_delivery_end_ts_date, timesheet_project_engagement_timesheets_projects_dim.total_project_fee_amount,project_hours_budget]
    view_label: "        Engagements (SoWs)"
    sql_on: ${timesheet_project_engagement_timesheets.timesheet_project_fk} = ${timesheet_project_engagement_timesheets_projects_dim.timesheet_project_pk} ;;
    type: left_outer
    relationship: many_to_one
  }


  join: companies_dim__all_company_ids {
    view_label: "           Companies"
    sql: LEFT JOIN UNNEST(${companies_dim__all_company_ids.companies_dim__all_company_ids}) as  companies_dim__all_company_ids;;
    relationship: one_to_many
  }
  join: nps_survey_results_fact {
    view_label: "   NPS Surveys"
    sql_on: ${companies_dim.company_pk} = ${nps_survey_results_fact.company_fk}  ;;
    relationship: one_to_many
    type: left_outer
    }
  join: client_prospect_status_dim {
    view_label: "           Companies"
    sql_on: ${companies_dim.company_pk} = ${client_prospect_status_dim.company_pk} ;;
    type: left_outer
    relationship: one_to_one
  }

  join: customer_first_order_segments {
    view_label: "           Companies"
    sql_on: ${companies_dim.company_pk} = ${customer_first_order_segments.companies_dim_company_pk} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: rfm_model {
    view_label: "           Companies"
    sql_on: ${companies_dim.company_pk} = ${rfm_model.company_pk} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: company_deal_value_attribute {
    view_label: "           Companies"
    sql_on: ${companies_dim.company_pk} = ${company_deal_value_attribute.company_pk} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: projects_invoiced {
    view_label: "      Project Invoicing"
    from: invoices_fact
    sql_on: ${projects_delivered.timesheet_project_pk} = ${projects_invoiced.timesheet_project_fk};;
    type: left_outer
    relationship: one_to_many
  }
  join: projects_delivered {
    view_label: "      Project Invoicing"
    from: timesheet_projects_dim
    sql_on: ${companies_dim.company_pk} = ${projects_delivered.company_fk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: exchange_rates {
    sql_on: ${projects_invoiced.invoice_currency} = ${exchange_rates.currency_code} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: recognized_project_revenue {
    from: recognized_revenue_fact
    view_label: "     Recognised Revenue"
    sql_on: ${projects_delivered.timesheet_project_pk} = ${recognized_project_revenue.timesheet_project_pk}
       ;;
    type: left_outer
    relationship: one_to_many
  }
  join: revenue_target {
    from: targets
    view_label: "      Project Invoicing"
    fields: [revenue_target.total_revenue_target]
    sql_on: ${projects_invoiced.invoice_issued_month} = ${revenue_target.period_month} ;;
    type: left_outer
    relationship: one_to_many
    }
  join: recognized_revenue_contact {
    from: contacts_dim
    view_label: "     Recognised Revenue"
    fields: [contact_name]
    sql_on: ${recognized_project_revenue.contact_fk} = ${recognized_revenue_contact.contact_pk} ;;
    type: left_outer
    relationship: many_to_one

  }


  join: project_invoice_timesheets {
    view_label: "      Project Invoicing"
    from: timesheets_fact
    sql_on: ${projects_delivered.timesheet_project_pk} = ${project_invoice_timesheets.timesheet_project_fk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: project_invoice_timesheet_users {
    view_label: "      Project Invoicing"
    from: contacts_dim
    sql_on: ${project_invoice_timesheets.contact_pk} = ${project_invoice_timesheet_users.contact_pk} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: project_timesheets {
    view_label: "      Project Timesheets"
    from: timesheets_fact
    sql_on: ${projects_delivered.timesheet_project_pk} = ${project_timesheets.timesheet_project_fk};;
    type: left_outer
    relationship: one_to_many
  }
  join: project_timesheet_projects {
    view_label: "      Project Timesheets"
    from: timesheet_projects_dim
    sql_on: ${project_timesheets.timesheet_project_fk} = ${project_timesheet_projects.timesheet_project_pk} ;;
    type: left_outer
    relationship: one_to_many
  }



  join: projects_delivered_is_ontime {
    view_label: "      Project Timesheets"
    sql_on: ${projects_delivered.timesheet_project_pk} = ${projects_delivered_is_ontime.timesheet_project_pk} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: project_timesheet_users {
    view_label: "      Project Timesheets"
    from: contacts_dim
    fields: [project_timesheet_users.contact_name]
    sql_on: ${project_timesheets.contact_pk}  = ${project_timesheet_users.contact_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: project_timesheet_tasks {
    view_label: "      Project Timesheets"
    from: timesheet_tasks_dim
    fields: [project_timesheet_tasks.task_name]
    sql_on: ${project_timesheets.timesheet_task_fk}  = ${project_timesheet_tasks.timesheet_task_pk} ;;
    type: left_outer
    relationship: one_to_many
  }

  join: deals_fact {
    view_label: "        Sales"
    sql_on: ${companies_dim.company_pk} = ${deals_fact.company_pk};;
    type: full_outer
    relationship: one_to_many
  }
  join: deal_targets {
    from: targets
    fields: [total_deals_closed_revenue_target]
    view_label: "        Sales"
    sql_on: ${deals_fact.deal_closed_month} = ${deal_targets.period_month} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: deal_pipeline_history {
    view_label: "         Sales Pipeline History"
    sql_on: ${deals_fact.deal_id} = ${deal_pipeline_history.deal_id} ;;
    type: inner
    relationship: one_to_many
    }



  join: customer_first_deal_cohorts {
    view_label: "        Sales"
    sql_on: ${deals_fact.deal_pk} = ${customer_first_deal_cohorts.deal_pk};;
    type: inner
    relationship: one_to_one
  }
  join: projects_managed {
    view_label: "     Project Delivery"
    from: delivery_projects_dim
    sql_on: ${companies_dim.company_pk} = ${projects_managed.company_pk} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: delivery_tasks_fact {
    view_label: "     Project Delivery"
    sql_on: ${projects_managed.delivery_project_pk} = ${delivery_tasks_fact.delivery_project_fk};;
    type: left_outer
    relationship: one_to_many
  }
  join: delivery_task_history {
    view_label: "     Project Delivery"
    sql_on: ${delivery_tasks_fact.task_id} = ${delivery_task_history.task_id} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: payments_fact {
    view_label: "      Project Invoicing"
    type: left_outer
    sql_on: ${projects_invoiced.invoice_pk} = ${payments_fact.payment_invoice_fk};;
    relationship: one_to_many
  }
  join: team_dim {
    from: contacts_dim
    fields: [team_dim.contact_name,team_dim.contact_is_staff,team_dim.contact_is_contractor]
    view_label: "     Project Delivery"
    sql_on: ${delivery_tasks_fact.contact_pk} = ${team_dim.contact_pk};;
    type: left_outer
    relationship: many_to_one
  }
  join: contact_companies_fact {
    view_label: "         Contacts"

    sql_on: ${companies_dim.company_pk} = ${contact_companies_fact.company_fk};;
    type: left_outer
    relationship: one_to_many
  }

  join: contact_meetings_fact {
    view_label: "        Sales"
    sql_on: ${companies_dim.company_pk} = ${contact_meetings_fact.company_fk}
       and ${deals_fact.deal_pk} = ${contact_meetings_fact.deal_fk};;
      type: left_outer
      relationship: one_to_many
  }
  join: contacts {

    from: contacts_dim

    view_label: "         Contacts"
    sql_on: ${contact_companies_fact.contact_fk} = ${contacts.contact_pk} ;;
    type: left_outer
    relationship: many_to_one
  }


  join: contracts_fact {
    view_label: "Legal"
    sql_on: ${companies_dim.company_pk} = ${contracts_fact.company_pk} ;;
    type: inner
    relationship: one_to_many
  }
  join: timesheet_project_costs_fact {
    view_label: "      Project Invoicing"
    fields: [timesheet_project_costs_fact.expense_amount_gbp,total_cost_gbp,timesheet_project_costs_fact.expense_category_name]
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
    group_label: "        Core Analytics"

    label: "Delivery Team Contribution"
    view_label: "Project Attribution"
    description: "Attribution model that attributes revenue from projects to team members based on grade and billable hours"

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
      sql_on: ${project_attribution.timesheet_project_pk} = ${projects_invoiced.timesheet_project_fk};;
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
      sql_on: ${timesheets_forecast_fact.timesheet_project_pk} = ${projects_invoiced.timesheet_project_fk};;
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

    label: "GL & Profit & Loss"
    hidden: no
    group_label: "        Core Analytics"

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
    join: profit_and_loss_report_targets {
      from: targets
      view_label: "Profit & Loss Report"
      fields: [profit_and_loss_report_targets.total_revenue_target,profit_and_loss_report_targets.retained_earnings_target]
      sql_on: ${profit_and_loss_report_fact.period_month} = ${profit_and_loss_report_targets.period_month} ;;
      type: left_outer
      relationship: one_to_many
    }
    aggregate_table: profit_and_loss_by_category_quarter {
      query: {
        dimensions: [profit_and_loss_report_fact.account_report_category, profit_and_loss_report_fact.period_quarter]
        measures: [profit_and_loss_report_fact.amount, profit_and_loss_report_fact.budget,profit_and_loss_report_fact.budget_variance]
      }
      materialization: {
        sql_trigger_value: SELECT CURRENT-DATE;;
      }
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
