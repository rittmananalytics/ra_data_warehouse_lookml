view: contacts_dim {
  sql_table_name: `ra-development.analytics.contacts_dim` ;;

  dimension: all_contact_addresses {
    hidden: yes
    sql: ${TABLE}.all_contact_addresses ;;
  }

  dimension: all_contact_company_ids {
    hidden: yes
    sql: ${TABLE}.all_contact_company_ids ;;
  }

  dimension: all_contact_emails {
    hidden: yes
    sql: ${TABLE}.all_contact_emails ;;
  }

  dimension: all_contact_ids {
    hidden: yes
    sql: ${TABLE}.all_contact_ids ;;
  }

  dimension: all_dbt_slack_channels {
    hidden: yes
    sql: ${TABLE}.all_dbt_slack_channels ;;
  }

  dimension: all_job_titles {
    hidden: yes
    sql: ${TABLE}.all_job_titles ;;
  }

  dimension: contact_anonymousid {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_anonymousid ;;
  }

  dimension: contact_average_page_views {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_average_page_views ;;
  }

  dimension: contact_bio {
    group_label: "Contact Details"
    sql: ${TABLE}.contact_bio ;;
  }

  dimension: contact_calendly_answer_1 {
    group_label: "Contact Sales Activity"
    sql: ${TABLE}.contact_calendly_answer_1 ;;
  }

  dimension: contact_calendly_answer_2 {
    group_label: "Contact Sales Activity"
    sql: ${TABLE}.contact_calendly_answer_2 ;;
  }

  dimension: contact_challenge {
    group_label: "Contact Sales Activity"
    sql: ${TABLE}.contact_challenge ;;
  }

  dimension: contact_conversion_event_name {
    group_label: "Contact Sales Activity"
    sql: ${TABLE}.contact_conversion_event_name ;;
  }

  dimension: contact_conversion_event_source {
    group_label: "Contact Sales Activity"
    sql: ${TABLE}.contact_conversion_event_source ;;
  }

  dimension: contact_cost_rate {
    group_label: "Contact Staff"
    sql: case when ${contact_name} like '%Bailey%' then 45 else ${TABLE}.contact_cost_rate end ;;
  }

  dimension: contact_crm_lifecycle_stage {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_crm_lifecycle_stage ;;
  }

  dimension: contact_date_of_birth {
    group_label: "Contact Details"
    sql: ${TABLE}.contact_date_of_birth ;;
  }

  dimension: contact_default_hourly_rate {
    group_label: "Contact Staff"
    sql: ${TABLE}.contact_default_hourly_rate ;;
  }

  dimension: contact_email_delivered {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_email_delivered ;;
  }

  dimension: contact_email_domain {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_email_domain ;;
  }

  dimension: contact_email_hard_bounce_reason {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_email_hard_bounce_reason ;;
  }

  dimension: contact_email_open {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_email_open ;;
  }

  dimension: contact_email_optout {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_email_optout ;;
  }

  dimension: contact_emails {
    group_label: "Contact Details"
    sql: (SELECT string_agg(contact_email) contact_email FROM UNNEST(all_contact_emails) contact_email where contact_email is not null) ;;
  }

  dimension: contact_first_episode_played {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_first_episode_played ;;
  }

  dimension: contact_first_referrer {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_first_referrer ;;
  }

  dimension: contact_first_url {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_first_url ;;
  }

  dimension: contact_in_crm_workflow {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_in_crm_workflow ;;
  }

  dimension: contact_industry {
    group_label: "Contact Details"
    sql: ${TABLE}.contact_industry ;;
  }

  dimension: contact_influencer_score {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_influencer_score ;;
  }

  dimension: contact_influencer_type {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_influencer_type ;;
  }

  dimension: contact_initial_referrer {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_initial_referrer ;;
  }

  dimension: contact_ip_city {
    group_label: "Contact Derived Data"
    sql: ${TABLE}.contact_ip_city ;;
  }

  dimension: contact_ip_country {
    group_label: "Contact Derived Data"
    sql: ${TABLE}.contact_ip_country ;;
  }

  dimension: contact_ip_country_code {
    group_label: "Contact Derived Data"
    sql: ${TABLE}.contact_ip_country_code ;;
  }

  dimension: contact_ip_state {
    group_label: "Contact Derived Data"
    sql: ${TABLE}.contact_ip_state ;;
  }

  dimension: contact_ip_state_code {
    group_label: "Contact Derived Data"
    sql: ${TABLE}.contact_ip_state_code ;;
  }

  dimension: contact_ip_timezone {
    group_label: "Contact Derived Data"
    sql: ${TABLE}.contact_ip_timezone ;;
  }

  dimension: contact_is_contractor {
    group_label: "Contact Staff"
    sql: ${TABLE}.contact_is_contractor ;;
  }

  dimension: contact_is_engaged_prospect_visitor {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_is_engaged_prospect_visitor ;;
  }

  dimension: contact_is_frequent_visitor {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_is_frequent_visitor ;;
  }

  dimension: contact_is_staff {
    group_label: "Contact Staff"
    sql: ${TABLE}.contact_is_staff ;;
  }

  dimension: contact_is_unworked {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_is_unworked ;;
  }

  dimension: contact_last_email_name {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_last_email_name ;;
  }

  dimension: contact_last_episode_played {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_last_episode_played ;;
  }

  dimension: contact_last_nps_follow_up {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_last_nps_follow_up ;;
  }

  dimension: contact_last_nps_rating {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_last_nps_rating ;;
  }

  dimension: contact_last_referrer {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_last_referrer ;;
  }

  dimension: contact_last_url {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_last_url ;;
  }

  dimension: contact_lead_status {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_lead_status ;;
  }

  dimension: contact_list_of_episodes_played_on_site {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_list_of_episodes_played_on_site ;;
  }

  dimension: contact_marketable_reason_type {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_marketable_reason_type ;;
  }

  dimension: contact_marketable_status {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_marketable_status ;;
  }

  dimension: contact_marketing_legal_basis {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_marketing_legal_basis ;;
  }

  dimension: contact_message {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_message ;;
  }

  dimension: contact_most_frequent_blog_post_viewed {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_most_frequent_blog_post_viewed ;;
  }

  dimension: contact_most_frequent_page_viewed {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_most_frequent_page_viewed ;;
  }

  dimension: contact_name {
    group_label: "Contact Details"
    sql: ${TABLE}.contact_name ;;
  }

  dimension: contact_num_associated_deals {
    group_label: "Contact Sales Activity"
    sql: ${TABLE}.contact_num_associated_deals ;;
  }

  dimension: contact_num_contacted_notes {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_num_contacted_notes ;;
  }

  dimension: contact_num_event_completions {
    group_label: "Contact Sales Activity"
    sql: ${TABLE}.contact_num_event_completions ;;
  }

  dimension: contact_num_notes {
    group_label: "Contact Sales Activity"
    sql: ${TABLE}.contact_num_notes ;;
  }

  dimension: contact_num_page_views {
    group_label: "Contact Sales Activity"
    sql: ${TABLE}.contact_num_page_views ;;
  }

  dimension: contact_num_visits {
    group_label: "Contact Sales Activity"
    sql: ${TABLE}.contact_num_visits ;;
  }

  dimension: contact_page_views_last_30_days {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_page_views_last_30_days ;;
  }

  dimension: contact_phone {
    group_label: "Contact Details"
    sql: ${TABLE}.contact_phone ;;
  }

  dimension: contact_pk {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.contact_pk ;;
  }

  dimension: contact_recent_deal_amount {
    group_label: "Contact Sales Activity"
    sql: ${TABLE}.contact_recent_deal_amount ;;
  }

  dimension: contact_recruitment_referring_site {
    group_label: "Contact Recruitment"
    sql: ${TABLE}.contact_referred ;;
  }

  dimension: contact_seniority {
    group_label: "Contact Details"
    sql: ${TABLE}.contact_seniority ;;
  }

  dimension: contact_social_linkedin_clicks {
    group_label: "Contact Social Media"
    sql: ${TABLE}.contact_social_linkedin_clicks ;;
  }

  dimension: contact_source {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_source ;;
  }

  dimension: contact_source_data_1 {
    group_label: "Contact Details"
    sql: ${TABLE}.contact_source_data_1 ;;
  }

  dimension: contact_source_data_2 {
    group_label: "Contact Details"
    sql: ${TABLE}.contact_source_data_2 ;;
  }

  dimension: contact_source_type {
    group_label: "Contact Details"
    sql: ${TABLE}.contact_source_type ;;
  }

  dimension: contact_staff_contract_type {
    group_label: "Contact Staff"
    sql: ${TABLE}.contact_staff_contract_type ;;
  }

  dimension: contact_staff_gender {
    group_label: "Contact Staff"
    sql: ${TABLE}.contact_staff_gender ;;
  }

  dimension: contact_staff_job_title {
    group_label: "Contact Staff"
    sql: ${TABLE}.contact_staff_job_title ;;
  }

  dimension: contact_staff_location_city {
    group_label: "Contact Staff"
    sql: ${TABLE}.contact_staff_location_city ;;
  }

  dimension: contact_staff_location_country {
    group_label: "Contact Staff"
    sql: ${TABLE}.contact_staff_location_country ;;
  }

  dimension: contact_staff_nationality {
    group_label: "Contact Staff"
    sql: ${TABLE}.contact_staff_nationality ;;
  }

  dimension: contact_staff_team_name {
    group_label: "Contact Staff"
    sql: ${TABLE}.contact_staff_team_name ;;
  }

  dimension: contact_titles_of_pages_viewed {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_titles_of_pages_viewed ;;
  }

  dimension: contact_total_page_views {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_total_page_views ;;
  }

  dimension: contact_twitterbio {
    group_label: "Contact Social Media"
    sql: ${TABLE}.contact_twitterbio ;;
  }

  dimension: contact_twitterhandle {
    group_label: "Contact Social Media"
    sql: ${TABLE}.contact_twitterhandle ;;
  }

  dimension: contact_views_of_customer_testimonial_pages_last_30_days {
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_views_of_customer_testimonial_pages_last_30_days ;;
  }

  dimension: contact_weekly_capacity {
    group_label: "Contact Staff"
    sql: ${TABLE}.contact_weekly_capacity ;;
  }

  dimension: contact_zip {
    group_label: "Contact Details"
    sql: ${TABLE}.contact_zip ;;
  }

  dimension: contact_zoom_webinar_attendance_average_duration {
    group_label: "Contact Sales Activity"
    sql: ${TABLE}.contact_zoom_webinar_attendance_average_duration ;;
  }

  dimension: contact_zoom_webinar_attendance_count {
    group_label: "Contact Sales Activity"
    sql: ${TABLE}.contact_zoom_webinar_attendance_count ;;
  }

  dimension: contact_zoom_webinar_registration_count {
    group_label: "Contact Sales Activity"
    sql: ${TABLE}.contact_zoom_webinar_registration_count ;;
  }

  dimension: hubspot_contact_id {
    hidden: yes
    sql: (SELECT contact_id FROM UNNEST(all_contact_ids) contact_id WHERE contact_id like "%hubspot%" limit 1) ;;
  }

  dimension: is_crm_tracked {
    group_label: "Contact Staff"
    sql: ${TABLE}.is_crm_tracked ;;
  }

  dimension: is_dbt_slack_member {
    group_label: "Contact Social Media"
    sql: ${TABLE}.is_dbt_slack_member ;;
  }

  dimension: is_github_interactor {
    group_label: "Contact Social Media"
    sql: ${TABLE}.is_github_interactor ;;
  }

  dimension: is_linkedin_interactor {
    group_label: "Contact Social Media"
    sql: ${TABLE}.is_linkedin_interactor ;;
  }

  dimension: is_medium_interactor {
    group_label: "Contact Social Media"
    sql: ${TABLE}.is_medium_interactor ;;
  }

  dimension: is_project_interactor {
    group_label: "Contact Details"
    sql: ${TABLE}.is_project_interactor ;;
  }

  dimension: is_twitter_interactor {
    group_label: "Contact Social Media"
    sql: ${TABLE}.is_twitter_interactor ;;
  }

  dimension: was_contact_recruitment_referred {
    group_label: "Contact Recruitment"
    sql: ${TABLE}.contact_referred ;;
  }

  dimension: was_contact_recruitment_sourced {
    group_label: "Contact Recruitment"
    sql: ${TABLE}.contact_sourced ;;
  }

  dimension_group: contact_created {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    group_label: "Contact Details"
    sql: ${TABLE}.contact_created_date ;;
  }

  dimension_group: contact_email_first_click {
    type: time
    timeframes: [raw, date]
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_email_first_click_date ;;
  }

  dimension_group: contact_email_first_open {
    type: time
    timeframes: [raw, date]
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_email_first_open_date ;;
  }

  dimension_group: contact_email_first_send {
    type: time
    timeframes: [raw, date]
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_email_first_send_date ;;
  }

  dimension_group: contact_email_last_click {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_email_last_click_date ;;
  }

  dimension_group: contact_first_ts {
    type: time
    timeframes: [raw, date]
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_first_ts ;;
  }

  dimension_group: contact_first_visit_ts {
    type: time
    timeframes: [raw, date]
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_first_visit_ts ;;
  }

  dimension_group: contact_last_meeting_booked {
    type: time
    timeframes: [raw, date]
    group_label: "Contact Sales Activity"
    sql: ${TABLE}.contact_last_meeting_booked ;;
  }

  dimension_group: contact_last_modified {
    type: time
    timeframes: [raw, date]
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_last_modified_date ;;
  }

  dimension_group: contact_last_open {
    type: time
    timeframes: [raw, date]
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_last_open_date ;;
  }

  dimension_group: contact_last_sales_activity {
    type: time
    timeframes: [raw, date]
    group_label: "Contact Sales Activity"
    sql: ${TABLE}.contact_last_sales_activity_ts ;;
  }

  dimension_group: contact_last_send {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_last_send_date ;;
  }

  dimension_group: contact_last_timestamp {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.contact_last_timestamp ;;
  }

  dimension_group: contact_last_visit {
    type: time
    timeframes: [raw, date]
    group_label: "Contact Marketing"
    sql: ${TABLE}.contact_last_visit_ts ;;
  }

  dimension_group: contact_latest_meeting_activity {
    type: time
    timeframes: [raw, date]
    group_label: "Contact Sales Activity"
    sql: ${TABLE}.contact_latest_meeting_activity ;;
  }

  dimension_group: contact_notes_last_contacted {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    group_label: "Contact Sales Activity"
    sql: ${TABLE}.contact_notes_last_contacted ;;
  }

  dimension_group: contact_notes_last_updated {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    group_label: "Contact Sales Activity"
    sql: ${TABLE}.contact_notes_last_updated ;;
  }

  dimension_group: contact_recent_deal_close {
    type: time
    timeframes: [raw, date]
    group_label: "Contact Sales Activity"
    sql: ${TABLE}.contact_recent_deal_close_date ;;
  }

  dimension_group: contact_sales_email_last_opened {
    type: time
    timeframes: [raw, date]
    group_label: "Contact Sales Activity"
    sql: ${TABLE}.contact_sales_email_last_opened ;;
  }

  dimension_group: contact_sales_email_last_replied {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    group_label: "Contact Sales Activity"
    sql: ${TABLE}.contact_sales_email_last_replied ;;
  }

  dimension_group: contact_social_last_engagement {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    group_label: "Contact Social Media"
    sql: ${TABLE}.contact_social_last_engagement ;;
  }

  dimension_group: contact_staff_employment_start {
    type: time
    timeframes: [raw, date]
    convert_tz: no
    group_label: "Contact Staff"
    sql: ${TABLE}.contact_staff_employment_start_ts ;;
  }

  dimension_group: contact_staff_probation_end {
    type: time
    timeframes: [raw, date]
    convert_tz: no
    group_label: "Contact Staff"
    sql: ${TABLE}.contact_staff_probation_end_ts ;;
  }

  dimension_group: contact_staff_working_start {
    type: time
    timeframes: [raw, date]
    convert_tz: no
    group_label: "Contact Staff"
    sql: ${TABLE}.contact_staff_working_start_ts ;;
  }

  dimension_group: dbt_slack_created_at {
    type: time
    timeframes: [raw, date]
    group_label: "Contact Social Media"
    sql: ${TABLE}.dbt_slack_created_at_ts ;;
  }

  measure: average_contact_cost_rate {
    type: average
    group_label: "Contact Staff"
    sql: ${contact_cost_rate} ;;
  }

  measure: count {
    type: count
    drill_fields: [contacts_dim.contact_conversion_event_name, contacts_dim.contact_name, contacts_dim.contact_staff_team_name, contacts_dim.contact_last_email_name]
  }
}
