connection: "ra_dw_prod"

include: "/omni_migration/views/*.view.lkml"
include: "/omni_migration/dashboards/*.dashboard.lookml"

explore: ad_campaign_performance_fact {
  label: "Campaign Performance"
  group_label: "Analysis"
  description: "Ad Campaigns and Website Performance"
  hidden: yes
  join: ad_campaigns_dim {
    type: left_outer
    relationship: many_to_one
    sql_on: ${ad_campaign_performance_fact.ad_campaign_fk} = ${ad_campaigns_dim.ad_campaign_pk} ;;
  }
}

explore: attribution {
  label: "Marketing Attribution (GA4 sample)"
  group_label: "Marketing Attribution"
  description: "Looker explore `attribution` (model attribution, project ga4_bq_rule-based_attribution_models). Public GA4 sample data, not Rittman Analytics data."
}

explore: bs_backlog_and_pipeline {
  label: "Booked backlog and weighted pipeline (tile 2805)"
  group_label: "Business Summary"
  description: "One-tile topic for Looker dashboard 267 tile 2805 (R-22)."
}

explore: bs_business_closed {
  label: "Business closed this year (tile 2898)"
  group_label: "Business Summary"
  description: "One-tile topic for Looker dashboard 267 tile 2898 (R-22)."
}

explore: bs_closed_deals {
  label: "Closed deals, last 6 months (tile 2536)"
  group_label: "Business Summary"
  description: "One-tile topic for Looker dashboard 267 tile 2536 (R-22)."
}

explore: bs_consultant_revenue_mtd {
  label: "Consultant revenue MTD (tile 2501)"
  group_label: "Business Summary"
  description: "One-tile topic for Looker dashboard 267 tile 2501 (R-22)."
}

explore: bs_cost_of_delivery {
  label: "Cost of delivery as a share of recognised revenue (tile 3043)"
  group_label: "Business Summary"
  description: "One-tile topic for Looker dashboard 267 tile 3043 (R-22)."
}

explore: bs_forecast_retained_income {
  label: "Forecast invoiced retained GBP (tile 2534)"
  group_label: "Business Summary"
  description: "One-tile topic for Looker dashboard 267 tile 2534 (R-22)."
}

explore: bs_profit_this_month {
  label: "Profit made and forecast this fiscal year (tile 2519)"
  group_label: "Business Summary"
  description: "One-tile topic for Looker dashboard 267 tile 2519 (R-22)."
}

explore: chart_of_accounts_dim {
  label: "Financials"
  group_label: "Core Analytics"
  join: bank_transactions_fact {
    type: left_outer
    relationship: one_to_many
    sql_on: ${chart_of_accounts_dim.account_id} = ${bank_transactions_fact.account_id} ;;
  }
  join: bank_account_details {
    type: inner
    relationship: many_to_one
    sql_on: ${bank_transactions_fact.bank_account_id} = ${bank_account_details.bank_account_id} ;;
  }
  join: general_ledger_fact {
    type: left_outer
    relationship: one_to_many
    sql_on: ${chart_of_accounts_dim.account_id} = ${general_ledger_fact.account_id} ;;
  }
  join: profit_and_loss_report_fact {
    type: left_outer
    relationship: one_to_many
    sql_on: ${chart_of_accounts_dim.account_id} = ${profit_and_loss_report_fact.account_id} ;;
  }
}

explore: companies_dim {
  label: "Business Operations"
  group_label: "Core Analytics"
  description: "Main explore used for reporting, starts with prospects and covers lifecycle through to projects and NPS"
  join: customer_meetings {
    type: inner
    relationship: one_to_many
    sql_on: ${companies_dim.company_pk} = ${customer_meetings.company_fk} ;;
  }
  join: deal_pipeline_history {
    type: left_outer
    relationship: one_to_many
    sql_on: ${companies_dim.company_pk} = ${deal_pipeline_history.company_pk} ;;
  }
  join: engagements {
    type: left_outer
    relationship: one_to_many
    sql_on: ${companies_dim.company_pk} = ${engagements.company_fk} ;;
  }
  join: engagement_projects {
    type: left_outer
    relationship: one_to_many
    sql_on: ${engagements.project_engagement_pk} = ${engagement_projects.project_engagement_pk} ;;
  }
  join: nps_survey_results_fact {
    type: left_outer
    relationship: one_to_many
    sql_on: ${nps_survey_results_fact.company_fk} = ${companies_dim.company_pk} ;;
  }
  join: projects_delivered {
    from: timesheet_projects_dim
    type: left_outer
    relationship: one_to_many
    sql_on: ${companies_dim.company_pk} = ${projects_delivered.company_fk} ;;
  }
  join: project_timesheets {
    from: timesheets_fact
    type: left_outer
    relationship: one_to_many
    sql_on: ${projects_delivered.timesheet_project_pk} = ${project_timesheets.timesheet_project_fk} ;;
  }
  join: project_timesheet_tasks {
    from: timesheet_tasks_dim
    type: left_outer
    relationship: many_to_one
    sql_on: ${project_timesheets.timesheet_task_fk} = ${project_timesheet_tasks.timesheet_task_pk} ;;
  }
  join: project_timesheet_users {
    from: contacts_dim
    type: left_outer
    relationship: many_to_one
    sql_on: ${project_timesheets.contact_pk} = ${project_timesheet_users.contact_pk} ;;
  }
  join: recognized_project_revenue {
    from: recognized_revenue_fact
    type: left_outer
    relationship: one_to_many
    sql_on: ${projects_delivered.timesheet_project_pk} = ${recognized_project_revenue.timesheet_project_pk} ;;
  }
  join: recognized_revenue_contact {
    from: contacts_dim
    type: left_outer
    relationship: many_to_one
    sql_on: ${recognized_project_revenue.contact_fk} = ${recognized_revenue_contact.contact_pk} ;;
  }
  join: team_revenue_targets {
    type: left_outer
    relationship: one_to_many
    sql_on: ${recognized_project_revenue.billing_month_month} = ${team_revenue_targets.month_month}
      and   ${recognized_revenue_contact.contact_name} = ${team_revenue_targets.contact_name} ;;
  }
}

explore: company_comparison {
  label: "Benchmarking"
  group_label: "Core Analytics"
  description: "Company benchmarking figures by year (Looker explore company_comparison, hidden in Looker)."
}

explore: contacts {
  view_name: contacts_dim
  label: "Delivery Team"
  description: "Utilisation and project activity for RA Delivery Team Members"
  hidden: yes
  sql_always_where: ${contacts_dim.contact_is_staff} or ${contacts_dim.contact_is_contractor} ;;
  join: customer_meetings {
    type: left_outer
    relationship: one_to_many
    sql_on: ${contacts_dim.contact_pk} = ${customer_meetings.person_fk} ;;
  }
  join: delivery_tasks_fact {
    type: left_outer
    relationship: one_to_many
    sql_on: ${contacts_dim.contact_pk} = ${delivery_tasks_fact.contact_pk} ;;
  }
  join: projects_managed {
    from: delivery_projects_dim
    type: left_outer
    relationship: one_to_many
    sql_on: ${delivery_tasks_fact.delivery_project_fk} = ${projects_managed.delivery_project_pk} ;;
  }
  join: meeting_contact_lines_fact {
    type: left_outer
    relationship: one_to_many
    sql_on: ${contacts_dim.contact_pk} = ${meeting_contact_lines_fact.person_fk} ;;
  }
  join: messages_fact {
    type: left_outer
    relationship: one_to_many
    sql_on: ${contacts_dim.contact_pk} = ${messages_fact.contact_fk} ;;
  }
  join: timesheets_fact {
    type: left_outer
    relationship: one_to_many
    sql_on: ${contacts_dim.contact_pk} = ${timesheets_fact.contact_pk} ;;
  }
  join: projects_delivered {
    from: timesheet_projects_dim
    type: left_outer
    relationship: one_to_many
    sql_on: ${timesheets_fact.timesheet_project_fk} = ${projects_delivered.timesheet_project_pk} ;;
  }
  join: delivered_companies_dim {
    from: companies_dim
    type: inner
    relationship: one_to_many
    sql_on: ${projects_delivered.company_fk} = ${delivered_companies_dim.company_pk}
      and ${timesheets_fact.company_fk} = ${delivered_companies_dim.company_pk} ;;
  }
  join: projects_invoiced {
    from: invoices_fact
    type: left_outer
    relationship: one_to_many
    sql_on: ${projects_delivered.timesheet_project_pk} = ${projects_invoiced.timesheet_project_fk} ;;
  }
  join: exchange_rates {
    type: left_outer
    relationship: many_to_one
    sql_on: ${projects_invoiced.invoice_currency} = ${exchange_rates.currency_code} ;;
  }
  join: payments_fact {
    type: left_outer
    relationship: one_to_many
    sql_on: ${projects_invoiced.invoice_pk} = ${payments_fact.payment_invoice_fk} ;;
  }
  join: projects_delivered_clients {
    from: companies_dim
    type: inner
    relationship: one_to_many
    sql_on: ${timesheets_fact.company_fk} = ${projects_delivered_clients.company_pk}
      and ${projects_delivered.company_fk} = ${projects_delivered_clients.company_pk} ;;
  }
  join: timesheet_tasks_dim {
    type: inner
    relationship: many_to_one
    sql_on: ${timesheets_fact.timesheet_task_fk} = ${timesheet_tasks_dim.timesheet_task_pk} ;;
  }
}

explore: engagement_actions_fact {
  label: "Engagement Actions"
  group_label: "Core Analytics"
  description: "One row per action for an engagement month. Only status areas that are not green produce actions."
}

explore: engagement_burn_up_fact {
  label: "Engagement Burn-up"
  group_label: "Core Analytics"
  description: "One row per engagement per week: hours booked, hours to date, the straight-line budget, and hours projected at the current pace. Feeds the budget burn-up chart."
}

explore: engagement_health_fact {
  label: "Engagement Health"
  group_label: "Core Analytics"
  description: "One row per engagement per month: delivery and commercial metrics, the three computed statuses, and the written commentary. The primary explore for the engagement health board."
}

explore: engagement_sprint_burn_fact {
  label: "Engagement Sprint Burn"
  group_label: "Core Analytics"
  description: "One row per sprint per month, with hours against that sprint's own budget and the state it was in. Feeds the sprint burn table and the sprint timeline."
}

explore: fa_costs_share_of_revenue {
  label: "Costs as Share of Revenue (409)"
  group_label: "Financial Analytics"
  description: "One-tile topic for Looker dashboard 409 tile 3851 (R-22)."
}

explore: fa_revenue_pipeline {
  label: "Revenue Pipeline (409)"
  group_label: "Financial Analytics"
  description: "One-tile topic for Looker dashboard 409 tile 3855 (R-22)."
}

explore: monthly_resource_revenue_forecast_fact {
  label: "Monthly Forecast"
  hidden: yes
}

explore: monzo_bank_transactions_enriched {
  label: "Banking"
  group_label: "Core Analytics"
  description: "Bank transactions and running balance (Looker explore monzo_bank_transactions_enriched, hidden in Looker)."
}

explore: nps_survey_results_fact {
  label: "NPS Surveys"
  group_label: "Core Analytics"
  hidden: yes
  join: companies_dim {
    type: left_outer
    relationship: many_to_one
    sql_on: ${nps_survey_results_fact.company_fk} = ${companies_dim.company_pk} ;;
  }
  join: engagements {
    type: left_outer
    relationship: one_to_many
    sql_on: ${companies_dim.company_pk} = ${engagements.company_fk} ;;
  }
  join: contacts_dim {
    type: left_outer
    relationship: many_to_one
    sql_on: ${nps_survey_results_fact.contact_fk} = ${contacts_dim.contact_pk} ;;
  }
}

explore: organic_posts_dim {
  label: "Content Marketing"
  join: organic_post_performance_fact {
    type: inner
    relationship: one_to_many
    sql_on: ${organic_posts_dim.organic_post_pk} = ${organic_post_performance_fact.organic_post_fk} ;;
  }
}

explore: project_engagements {
  hidden: yes
}

explore: revenue_and_forecast {
  description: "Explore that provides booked and forecast (high probability) revenue for past and upcoming months"
  hidden: yes
}

explore: targets {
  label: "Targets"
  join: sales_targets {
    type: left_outer
    relationship: one_to_one
    sql_on: ${targets.period_month} = ${sales_targets.period_month} ;;
  }
}

explore: ut_consultant_month {
  label: "Utilisation & Attributed Revenue"
  group_label: "Utilisation"
  description: "One-view topic for the merged tiles of Looker dashboard 389 (R-55). Consultant by month: attributed revenue, targets, hours."
}

explore: web_sessions_fact {
  label: "Web Analytics"
  group_label: "Core Analytics"
  description: "Website activity and visitor journey"
  join: has_viewed_pricing {
    type: inner
    relationship: one_to_one
    sql_on: ${web_sessions_fact.blended_user_id} = ${has_viewed_pricing.web_sessions_fact_blended_user_id} ;;
  }
  join: is_conversion_session {
    type: left_outer
    relationship: one_to_one
    sql_on: ${web_sessions_fact.session_id} = ${is_conversion_session.web_events_fact_session_id} ;;
  }
  join: page_first_published {
    type: left_outer
    relationship: one_to_one
    sql_on: ${web_sessions_fact.first_page_title} = ${page_first_published.web_sessions_fact_first_page_title} ;;
  }
  join: web_events_fact {
    type: left_outer
    relationship: one_to_many
    sql_on: ${web_sessions_fact.session_id} = ${web_events_fact.session_id} ;;
  }
  join: ips_enriched {
    type: left_outer
    relationship: many_to_one
    sql_on: ${web_events_fact.ip} = ${ips_enriched.ip} ;;
  }
  join: wh_sessions_attribution {
    type: left_outer
    relationship: one_to_one
    sql_on: ${web_sessions_fact.web_sessions_pk} = ${wh_sessions_attribution.web_session_fk} ;;
  }
}
