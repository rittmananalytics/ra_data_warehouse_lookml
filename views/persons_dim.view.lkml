# Unified Person Dimension
# A single dimension table that tracks every role a person plays across the business
# Replaces fragmented person tables (contacts, staff, candidates, etc.) with a unified approach

view: persons_dim {
  sql_table_name: `ra-development.analytics.persons_dim` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: person_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.person_pk ;;
  }

  # =============================================================================
  # CORE IDENTITY - Common to all persons regardless of role
  # =============================================================================

  dimension: person_name {
    group_label: "      Person Identity"
    label: "Name"
    type: string
    sql: ${TABLE}.person_name ;;
  }

  dimension: person_phone {
    group_label: "      Person Identity"
    label: "Phone"
    type: string
    sql: ${TABLE}.person_phone ;;
  }

  dimension: person_bio {
    group_label: "      Person Identity"
    label: "Bio"
    type: string
    sql: ${TABLE}.person_bio ;;
  }

  dimension: person_linkedin_url {
    group_label: "      Person Identity"
    label: "LinkedIn URL"
    type: string
    sql: ${TABLE}.person_linkedin_url ;;
    link: {
      label: "View LinkedIn Profile"
      url: "{{ value }}"
      icon_url: "https://linkedin.com/favicon.ico"
    }
  }

  dimension: person_primary_email {
    group_label: "      Person Identity"
    label: "Primary Email"
    type: string
    sql: ${TABLE}.person_primary_email ;;
  }

  # Array of all emails - hidden, use the flattened version
  dimension: all_emails {
    hidden: yes
    sql: ${TABLE}.all_emails ;;
  }

  dimension: all_emails_concatenated {
    group_label: "      Person Identity"
    label: "All Email Addresses"
    type: string
    sql: (SELECT STRING_AGG(email, ', ') FROM UNNEST(${TABLE}.all_emails) AS email WHERE email IS NOT NULL) ;;
  }

  # =============================================================================
  # ROLE FLAGS - Simple boolean filters for common queries
  # =============================================================================

  dimension: is_staff {
    group_label: "     Person Roles"
    label: "Is Staff Member"
    type: yesno
    sql: ${TABLE}.is_staff ;;
  }

  dimension: is_contractor {
    group_label: "     Person Roles"
    label: "Is Contractor"
    type: yesno
    sql: ${TABLE}.is_contractor ;;
  }

  dimension: is_client_contact {
    group_label: "     Person Roles"
    label: "Is Client Contact"
    type: yesno
    sql: ${TABLE}.is_client_contact ;;
  }

  dimension: is_partner_contact {
    group_label: "     Person Roles"
    label: "Is Partner Contact"
    type: yesno
    sql: ${TABLE}.is_partner_contact ;;
  }

  dimension: is_prospect {
    group_label: "     Person Roles"
    label: "Is Prospect"
    type: yesno
    sql: ${TABLE}.is_prospect ;;
  }

  dimension: is_candidate {
    group_label: "     Person Roles"
    label: "Is Job Candidate"
    type: yesno
    sql: ${TABLE}.is_candidate ;;
  }

  # =============================================================================
  # CURRENT ROLES - For multi-role queries
  # =============================================================================

  dimension: current_roles {
    hidden: yes
    sql: ${TABLE}.current_roles ;;
  }

  dimension: current_roles_list {
    group_label: "     Person Roles"
    label: "Current Roles"
    type: string
    sql: (SELECT STRING_AGG(role, ', ') FROM UNNEST(${TABLE}.current_roles) AS role) ;;
  }

  dimension: current_role_count {
    group_label: "     Person Roles"
    label: "Number of Roles"
    type: number
    sql: ARRAY_LENGTH(${TABLE}.current_roles) ;;
  }

  dimension: primary_role {
    group_label: "     Person Roles"
    label: "Primary Role"
    type: string
    sql: ${TABLE}.primary_role ;;
  }

  dimension: has_multiple_roles {
    group_label: "     Person Roles"
    label: "Has Multiple Roles"
    type: yesno
    sql: ARRAY_LENGTH(${TABLE}.current_roles) > 1 ;;
  }

  # =============================================================================
  # STAFF ATTRIBUTES STRUCT - Populated when is_staff = TRUE
  # =============================================================================

  dimension: staff_job_title {
    group_label: "    Staff Attributes"
    label: "Job Title"
    type: string
    sql: ${TABLE}.staff_attributes.job_title ;;
  }

  dimension: staff_team_name {
    group_label: "    Staff Attributes"
    label: "Team Name"
    type: string
    sql: ${TABLE}.staff_attributes.team_name ;;
  }

  dimension_group: staff_employment_start {
    group_label: "    Staff Attributes"
    label: "Employment Start"
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.staff_attributes.employment_start_date ;;
  }

  dimension_group: staff_employment_end {
    group_label: "    Staff Attributes"
    label: "Employment End"
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.staff_attributes.employment_end_date ;;
  }

  dimension: staff_weekly_capacity {
    group_label: "    Staff Attributes"
    label: "Weekly Capacity (Hours)"
    type: number
    sql: ${TABLE}.staff_attributes.weekly_capacity ;;
  }

  dimension: staff_default_hourly_rate {
    group_label: "    Staff Attributes"
    label: "Default Hourly Rate"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.staff_attributes.default_hourly_rate ;;
  }

  dimension: staff_cost_rate {
    group_label: "    Staff Attributes"
    label: "Cost Rate"
    type: number
    value_format_name: gbp
    sql: ${TABLE}.staff_attributes.cost_rate ;;
  }

  dimension: staff_contract_type {
    group_label: "    Staff Attributes"
    label: "Contract Type"
    type: string
    sql: ${TABLE}.staff_attributes.contract_type ;;
  }

  dimension: staff_location_city {
    group_label: "    Staff Attributes"
    label: "Location City"
    type: string
    sql: ${TABLE}.staff_attributes.location_city ;;
  }

  dimension: staff_location_country {
    group_label: "    Staff Attributes"
    label: "Location Country"
    type: string
    sql: ${TABLE}.staff_attributes.location_country ;;
  }

  dimension: staff_manager_person_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.staff_attributes.manager_person_fk ;;
  }

  # =============================================================================
  # CRM ATTRIBUTES STRUCT - Marketing and lifecycle data
  # =============================================================================

  dimension: crm_lifecycle_stage {
    group_label: "   CRM & Marketing"
    label: "Lifecycle Stage"
    type: string
    sql: ${TABLE}.crm_attributes.lifecycle_stage ;;
  }

  dimension: crm_lead_status {
    group_label: "   CRM & Marketing"
    label: "Lead Status"
    type: string
    sql: ${TABLE}.crm_attributes.lead_status ;;
  }

  dimension: crm_lead_source {
    group_label: "   CRM & Marketing"
    label: "Lead Source"
    type: string
    sql: ${TABLE}.crm_attributes.lead_source ;;
  }

  dimension: crm_initial_referrer {
    group_label: "   CRM & Marketing"
    label: "Initial Referrer"
    type: string
    sql: ${TABLE}.crm_attributes.initial_referrer ;;
  }

  dimension: crm_conversion_event_name {
    group_label: "   CRM & Marketing"
    label: "Conversion Event Name"
    type: string
    sql: ${TABLE}.crm_attributes.conversion_event_name ;;
  }

  dimension: crm_conversion_event_source {
    group_label: "   CRM & Marketing"
    label: "Conversion Event Source"
    type: string
    sql: ${TABLE}.crm_attributes.conversion_event_source ;;
  }

  dimension: crm_marketing_legal_basis {
    group_label: "   CRM & Marketing"
    label: "Marketing Legal Basis"
    type: string
    sql: ${TABLE}.crm_attributes.marketing_legal_basis ;;
  }

  dimension: crm_in_workflow {
    group_label: "   CRM & Marketing"
    label: "In CRM Workflow"
    type: yesno
    sql: ${TABLE}.crm_attributes.in_crm_workflow ;;
  }

  # =============================================================================
  # WEB ANALYTICS STRUCT - Website engagement metrics
  # =============================================================================

  dimension: web_total_page_views {
    group_label: "  Web Analytics"
    label: "Total Page Views"
    type: number
    sql: ${TABLE}.web_analytics.total_page_views ;;
  }

  dimension: web_page_views_last_30_days {
    group_label: "  Web Analytics"
    label: "Page Views (Last 30 Days)"
    type: number
    sql: ${TABLE}.web_analytics.page_views_last_30_days ;;
  }

  dimension: web_num_visits {
    group_label: "  Web Analytics"
    label: "Number of Visits"
    type: number
    sql: ${TABLE}.web_analytics.num_visits ;;
  }

  dimension: web_average_page_views {
    group_label: "  Web Analytics"
    label: "Average Page Views per Visit"
    type: number
    value_format_name: decimal_1
    sql: ${TABLE}.web_analytics.average_page_views ;;
  }

  dimension: web_first_referrer {
    group_label: "  Web Analytics"
    label: "First Referrer"
    type: string
    sql: ${TABLE}.web_analytics.first_referrer ;;
  }

  dimension: web_last_referrer {
    group_label: "  Web Analytics"
    label: "Last Referrer"
    type: string
    sql: ${TABLE}.web_analytics.last_referrer ;;
  }

  dimension: web_first_url {
    group_label: "  Web Analytics"
    label: "First URL Visited"
    type: string
    sql: ${TABLE}.web_analytics.first_url ;;
  }

  dimension: web_last_url {
    group_label: "  Web Analytics"
    label: "Last URL Visited"
    type: string
    sql: ${TABLE}.web_analytics.last_url ;;
  }

  dimension_group: web_first_visit {
    group_label: "  Web Analytics"
    label: "First Visit"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.web_analytics.first_visit_ts ;;
  }

  dimension_group: web_last_visit {
    group_label: "  Web Analytics"
    label: "Last Visit"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.web_analytics.last_visit_ts ;;
  }

  dimension: web_is_frequent_visitor {
    group_label: "  Web Analytics"
    label: "Is Frequent Visitor"
    type: yesno
    sql: ${TABLE}.web_analytics.is_frequent_visitor ;;
  }

  dimension: web_is_engaged_prospect {
    group_label: "  Web Analytics"
    label: "Is Engaged Prospect"
    type: yesno
    sql: ${TABLE}.web_analytics.is_engaged_prospect ;;
  }

  # =============================================================================
  # EMAIL ENGAGEMENT STRUCT - Email marketing metrics
  # =============================================================================

  dimension: email_delivered_count {
    group_label: "  Email Engagement"
    label: "Emails Delivered"
    type: number
    sql: ${TABLE}.email_engagement.delivered_count ;;
  }

  dimension: email_open_count {
    group_label: "  Email Engagement"
    label: "Emails Opened"
    type: number
    sql: ${TABLE}.email_engagement.open_count ;;
  }

  dimension: email_click_count {
    group_label: "  Email Engagement"
    label: "Email Clicks"
    type: number
    sql: ${TABLE}.email_engagement.click_count ;;
  }

  dimension: email_is_opted_out {
    group_label: "  Email Engagement"
    label: "Has Opted Out"
    type: yesno
    sql: ${TABLE}.email_engagement.is_opted_out ;;
  }

  dimension: email_hard_bounce_reason {
    group_label: "  Email Engagement"
    label: "Hard Bounce Reason"
    type: string
    sql: ${TABLE}.email_engagement.hard_bounce_reason ;;
  }

  dimension_group: email_first_open {
    group_label: "  Email Engagement"
    label: "First Email Open"
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.email_engagement.first_open_date ;;
  }

  dimension_group: email_last_open {
    group_label: "  Email Engagement"
    label: "Last Email Open"
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.email_engagement.last_open_date ;;
  }

  dimension_group: email_first_send {
    group_label: "  Email Engagement"
    label: "First Email Sent"
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.email_engagement.first_send_date ;;
  }

  dimension_group: email_last_send {
    group_label: "  Email Engagement"
    label: "Last Email Sent"
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.email_engagement.last_send_date ;;
  }

  # =============================================================================
  # SALES ATTRIBUTES STRUCT - Sales activity and deal metrics
  # =============================================================================

  dimension: sales_num_associated_deals {
    group_label: "  Sales Activity"
    label: "Associated Deals"
    type: number
    sql: ${TABLE}.sales_attributes.num_associated_deals ;;
  }

  dimension: sales_recent_deal_amount {
    group_label: "  Sales Activity"
    label: "Recent Deal Amount"
    type: number
    value_format_name: gbp_0
    sql: ${TABLE}.sales_attributes.recent_deal_amount ;;
  }

  dimension_group: sales_recent_deal_close {
    group_label: "  Sales Activity"
    label: "Recent Deal Close"
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.sales_attributes.recent_deal_close_date ;;
  }

  dimension_group: sales_last_activity {
    group_label: "  Sales Activity"
    label: "Last Sales Activity"
    type: time
    timeframes: [raw, time, date, week, month]
    sql: ${TABLE}.sales_attributes.last_sales_activity_ts ;;
  }

  dimension_group: sales_latest_meeting {
    group_label: "  Sales Activity"
    label: "Latest Meeting"
    type: time
    timeframes: [raw, time, date, week, month]
    sql: ${TABLE}.sales_attributes.latest_meeting_ts ;;
  }

  dimension_group: sales_last_meeting_booked {
    group_label: "  Sales Activity"
    label: "Last Meeting Booked"
    type: time
    timeframes: [raw, time, date, week, month]
    sql: ${TABLE}.sales_attributes.last_meeting_booked_ts ;;
  }

  dimension: sales_is_unworked {
    group_label: "  Sales Activity"
    label: "Is Unworked Lead"
    type: yesno
    sql: ${TABLE}.sales_attributes.is_unworked ;;
  }

  dimension: sales_num_notes {
    group_label: "  Sales Activity"
    label: "Number of Notes"
    type: number
    sql: ${TABLE}.sales_attributes.num_notes ;;
  }

  # =============================================================================
  # CANDIDATE ATTRIBUTES STRUCT - Recruiting data
  # =============================================================================

  dimension: candidate_resume {
    group_label: " Candidate Info"
    label: "Resume/CV"
    type: string
    sql: ${TABLE}.candidate_attributes.resume ;;
  }

  dimension: candidate_pitch {
    group_label: " Candidate Info"
    label: "Candidate Pitch"
    type: string
    sql: ${TABLE}.candidate_attributes.pitch ;;
  }

  dimension: candidate_is_referred {
    group_label: " Candidate Info"
    label: "Was Referred"
    type: yesno
    sql: ${TABLE}.candidate_attributes.is_referred ;;
  }

  dimension: candidate_referring_site {
    group_label: " Candidate Info"
    label: "Referring Site"
    type: string
    sql: ${TABLE}.candidate_attributes.referring_site ;;
  }

  dimension: candidate_current_application_stage {
    group_label: " Candidate Info"
    label: "Current Application Stage"
    type: string
    sql: ${TABLE}.candidate_attributes.current_application_stage ;;
  }

  # =============================================================================
  # PARTNER ATTRIBUTES STRUCT - Partner contact data
  # =============================================================================

  dimension: partner_company_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.partner_attributes.partner_company_fk ;;
  }

  dimension: partner_role_title {
    group_label: " Partner Info"
    label: "Role at Partner"
    type: string
    sql: ${TABLE}.partner_attributes.role_title ;;
  }

  dimension: partner_is_primary_contact {
    group_label: " Partner Info"
    label: "Is Primary Contact"
    type: yesno
    sql: ${TABLE}.partner_attributes.is_primary_contact ;;
  }

  dimension: partner_has_signatory_authority {
    group_label: " Partner Info"
    label: "Has Signatory Authority"
    type: yesno
    sql: ${TABLE}.partner_attributes.has_signatory_authority ;;
  }

  # =============================================================================
  # COMMUNITY ENGAGEMENT STRUCT - Social and community participation
  # =============================================================================

  dimension: community_is_dbt_slack_member {
    group_label: " Community & Social"
    label: "Is dbt Slack Member"
    type: yesno
    sql: ${TABLE}.community_engagement.is_dbt_slack_member ;;
  }

  dimension_group: community_dbt_slack_joined {
    group_label: " Community & Social"
    label: "dbt Slack Join Date"
    type: time
    timeframes: [raw, date, month, year]
    sql: ${TABLE}.community_engagement.dbt_slack_created_at_ts ;;
  }

  dimension: community_is_linkedin_interactor {
    group_label: " Community & Social"
    label: "Is LinkedIn Interactor"
    type: yesno
    sql: ${TABLE}.community_engagement.is_linkedin_interactor ;;
  }

  dimension: community_is_twitter_interactor {
    group_label: " Community & Social"
    label: "Is Twitter/X Interactor"
    type: yesno
    sql: ${TABLE}.community_engagement.is_twitter_interactor ;;
  }

  dimension: community_is_github_interactor {
    group_label: " Community & Social"
    label: "Is GitHub Interactor"
    type: yesno
    sql: ${TABLE}.community_engagement.is_github_interactor ;;
  }

  dimension: community_is_medium_interactor {
    group_label: " Community & Social"
    label: "Is Medium Interactor"
    type: yesno
    sql: ${TABLE}.community_engagement.is_medium_interactor ;;
  }

  dimension: community_twitter_bio {
    group_label: " Community & Social"
    label: "Twitter Bio"
    type: string
    sql: ${TABLE}.community_engagement.twitter_bio ;;
  }

  dimension: community_twitter_handle {
    group_label: " Community & Social"
    label: "Twitter Handle"
    type: string
    sql: ${TABLE}.community_engagement.twitter_handle ;;
  }

  # =============================================================================
  # NPS ATTRIBUTES STRUCT - Net Promoter Score data
  # =============================================================================

  dimension: nps_last_rating {
    group_label: " NPS Data"
    label: "Last NPS Rating"
    type: number
    sql: SAFE_CAST(${TABLE}.nps_attributes.last_nps_rating AS INT64) ;;
  }

  dimension: nps_last_follow_up {
    group_label: " NPS Data"
    label: "Last NPS Follow-up"
    type: string
    sql: ${TABLE}.nps_attributes.last_nps_follow_up ;;
  }

  dimension: nps_category {
    group_label: " NPS Data"
    label: "NPS Category"
    type: string
    sql: CASE
      WHEN SAFE_CAST(${TABLE}.nps_attributes.last_nps_rating AS INT64) >= 9 THEN 'Promoter'
      WHEN SAFE_CAST(${TABLE}.nps_attributes.last_nps_rating AS INT64) >= 7 THEN 'Passive'
      WHEN ${TABLE}.nps_attributes.last_nps_rating IS NOT NULL THEN 'Detractor'
      ELSE NULL
    END ;;
  }

  # =============================================================================
  # METADATA & TIMESTAMPS
  # =============================================================================

  dimension_group: person_created {
    group_label: "Record Metadata"
    label: "Person Created"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.person_created_ts ;;
  }

  dimension_group: person_last_modified {
    group_label: "Record Metadata"
    label: "Last Modified"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.person_last_modified_ts ;;
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    label: "Person Count"
    type: count
    drill_fields: [person_detail*]
  }

  measure: staff_count {
    label: "Staff Count"
    type: count
    filters: [is_staff: "Yes"]
    drill_fields: [person_detail*, staff_job_title, staff_team_name]
  }

  measure: contractor_count {
    label: "Contractor Count"
    type: count
    filters: [is_contractor: "Yes"]
    drill_fields: [person_detail*]
  }

  measure: client_contact_count {
    label: "Client Contact Count"
    type: count
    filters: [is_client_contact: "Yes"]
    drill_fields: [person_detail*]
  }

  measure: prospect_count {
    label: "Prospect Count"
    type: count
    filters: [is_prospect: "Yes"]
    drill_fields: [person_detail*, crm_lifecycle_stage, crm_lead_source]
  }

  measure: candidate_count {
    label: "Candidate Count"
    type: count
    filters: [is_candidate: "Yes"]
    drill_fields: [person_detail*, candidate_current_application_stage]
  }

  measure: multi_role_person_count {
    label: "Multi-Role Person Count"
    description: "Count of people with more than one role"
    type: count
    filters: [has_multiple_roles: "Yes"]
    drill_fields: [person_detail*, current_roles_list]
  }

  measure: average_weekly_capacity {
    label: "Average Weekly Capacity"
    type: average
    sql: ${staff_weekly_capacity} ;;
    value_format_name: decimal_1
    filters: [is_staff: "Yes"]
  }

  measure: total_weekly_capacity {
    label: "Total Weekly Capacity"
    type: sum
    sql: ${staff_weekly_capacity} ;;
    filters: [is_staff: "Yes"]
  }

  measure: average_page_views {
    label: "Average Total Page Views"
    type: average
    sql: ${web_total_page_views} ;;
    value_format_name: decimal_0
  }

  measure: average_deals_per_contact {
    label: "Average Deals per Contact"
    type: average
    sql: ${sales_num_associated_deals} ;;
    value_format_name: decimal_1
    filters: [is_client_contact: "Yes"]
  }

  # =============================================================================
  # DRILL SETS
  # =============================================================================

  set: person_detail {
    fields: [
      person_pk,
      person_name,
      person_primary_email,
      primary_role,
      current_roles_list
    ]
  }

  set: staff_detail {
    fields: [
      person_name,
      staff_job_title,
      staff_team_name,
      staff_weekly_capacity,
      staff_default_hourly_rate
    ]
  }
}

# =============================================================================
# UNNESTED VIEWS FOR ARRAYS
# =============================================================================

# View to unnest the all_emails array
view: persons_dim__all_emails {
  dimension: email {
    type: string
    sql: persons_dim__all_emails ;;
  }
}

# View to unnest the current_roles array
view: persons_dim__current_roles {
  dimension: role {
    type: string
    sql: persons_dim__current_roles ;;
  }
}

# View to unnest the all_addresses array (if it's an array of structs)
view: persons_dim__all_addresses {
  dimension: address {
    type: string
    sql: ${TABLE}.address ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: postcode_zip {
    type: string
    sql: ${TABLE}.postcode_zip ;;
  }
}
