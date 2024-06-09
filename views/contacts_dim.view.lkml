
view: contacts_dim {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics.contacts_dim` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # This field is hidden, which means it will not show up in Explore.
  # If you want this field to be displayed, remove "hidden: yes".

  dimension: all_contact_addresses {
    hidden: yes
    sql: ${TABLE}.all_contact_addresses ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "All Contact Company Ids" in Explore.

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

  dimension: contact_emails {
    hidden: no
    group_label: "      Contact Details"

    type: string
    sql: (SELECT string_agg(contact_email) contact_email FROM UNNEST(all_contact_emails) contact_email where contact_email is not null) ;;
  }

  dimension: hubspot_contact_id {
    hidden: yes
    type: string
    sql: (SELECT contact_id FROM UNNEST(all_contact_ids) contact_id WHERE contact_id like "%hubspot%" limit 1) ;;
  }

  dimension: contact_anonymousid {
    group_label: "      Contact Marketing"


    type: string
    sql: ${TABLE}.contact_anonymousid ;;
  }

  dimension: contact_average_page_views {
    group_label: "      Contact Marketing"

    type: number
    sql: ${TABLE}.contact_average_page_views ;;
  }

  dimension: contact_bio {
    group_label: "      Contact Details"

    type: string
    sql: ${TABLE}.contact_bio ;;
  }

  dimension: contact_calendly_answer_1 {
    group_label: "      Contact Sales Activity"

    type: string
    sql: ${TABLE}.contact_calendly_answer_1 ;;
  }

  dimension: contact_calendly_answer_2 {
    group_label: "      Contact Sales Activity"

    type: string
    sql: ${TABLE}.contact_calendly_answer_2 ;;
  }

  dimension: contact_conversion_event_name {
    group_label: "      Contact Sales Activity"

    type: string
    sql: ${TABLE}.contact_conversion_event_name ;;
  }

  dimension: contact_conversion_event_source {
    group_label: "      Contact Sales Activity"

    type: string
    sql: ${TABLE}.contact_conversion_event_source ;;
  }

  dimension: contact_cost_rate {
    group_label: "      Contact Staff"

    type: number
    sql: ${TABLE}.contact_cost_rate ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.


  measure: average_contact_cost_rate {
    group_label: "      Contact Staff"

    type: average
    sql: ${contact_cost_rate} ;;  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: contact_created {
    group_label: "      Contact Details"

    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.contact_created_date ;;
  }

  dimension: contact_crm_lifecycle_stage {
    group_label: "      Contact Marketing"

    type: string
    sql: ${TABLE}.contact_crm_lifecycle_stage ;;
  }

  dimension: contact_date_of_birth {
    group_label: "      Contact Details"

    type: string
    sql: ${TABLE}.contact_date_of_birth ;;
  }

  dimension: contact_default_hourly_rate {
    group_label: "      Contact Staff"


    type: number
    sql: ${TABLE}.contact_default_hourly_rate ;;
  }

  dimension: contact_email_delivered {
    group_label: "      Contact Marketing"

    type: number
    sql: ${TABLE}.contact_email_delivered ;;
  }

  dimension: contact_email_domain {
    group_label: "      Contact Marketing"

    type: string
    sql: ${TABLE}.contact_email_domain ;;
  }

  dimension_group: contact_email_first_click {
    group_label: "      Contact Marketing"

    type: time
    timeframes: [raw, time, date]
    sql: ${TABLE}.contact_email_first_click_date ;;
  }

  dimension_group: contact_email_first_open {
    group_label: "      Contact Marketing"

    type: time
    timeframes: [raw, time, date]
    sql: ${TABLE}.contact_email_first_open_date ;;
  }

  dimension_group: contact_email_first_send {
    group_label: "      Contact Marketing"

    type: time
    timeframes: [raw, time, date]
    sql: ${TABLE}.contact_email_first_send_date ;;
  }

  dimension: contact_email_hard_bounce_reason {
    group_label: "      Contact Marketing"

    type: string
    sql: ${TABLE}.contact_email_hard_bounce_reason ;;
  }

  dimension_group: contact_email_last_click {
    group_label: "      Contact Marketing"

    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.contact_email_last_click_date ;;
  }

  dimension: contact_email_open {
    group_label: "      Contact Marketing"

    type: number
    sql: ${TABLE}.contact_email_open ;;
  }

  dimension: contact_email_optout {
    group_label: "      Contact Marketing"

    type: yesno
    sql: ${TABLE}.contact_email_optout ;;
  }

  dimension: contact_first_referrer {
    group_label: "      Contact Marketing"

    type: string
    sql: ${TABLE}.contact_first_referrer ;;
  }

  dimension_group: contact_first_ts {
    group_label: "      Contact Marketing"

    type: time
    timeframes: [raw, time, date]
    sql: ${TABLE}.contact_first_ts ;;
  }

  dimension: contact_first_url {
    group_label: "      Contact Marketing"

    type: string
    sql: ${TABLE}.contact_first_url ;;
  }

  dimension_group: contact_first_visit_ts {
    group_label: "      Contact Marketing"

    type: time
    timeframes: [raw, time, date]
    sql: ${TABLE}.contact_first_visit_ts ;;
  }

  dimension: contact_in_crm_workflow {
    group_label: "      Contact Marketing"

    type: string
    sql: ${TABLE}.contact_in_crm_workflow ;;
  }

  dimension: contact_industry {
    group_label: "      Contact Details"

    type: string
    sql: ${TABLE}.contact_industry ;;
  }

  dimension: contact_influencer_score {
    group_label: "      Contact Marketing"

    type: number
    sql: ${TABLE}.contact_influencer_score ;;
  }

  dimension: contact_influencer_type {
    group_label: "      Contact Marketing"

    type: string
    sql: ${TABLE}.contact_influencer_type ;;
  }

  dimension: contact_ip_city {
    group_label: "      Contact Derived Data"

    type: string
    sql: ${TABLE}.contact_ip_city ;;
  }

  dimension: contact_ip_country {
    group_label: "      Contact Derived Data"

    type: string
    sql: ${TABLE}.contact_ip_country ;;
  }

  dimension: contact_ip_country_code {
    group_label: "      Contact Derived Data"

    type: string
    sql: ${TABLE}.contact_ip_country_code ;;
  }

  dimension: contact_ip_state {
    group_label: "      Contact Derived Data"

    type: string
    sql: ${TABLE}.contact_ip_state ;;
  }

  dimension: contact_ip_state_code {
    group_label: "      Contact Derived Data"

    type: string
    sql: ${TABLE}.contact_ip_state_code ;;
  }

  dimension: contact_ip_timezone {
    group_label: "      Contact Derived Data"

    type: string
    sql: ${TABLE}.contact_ip_timezone ;;
  }



  dimension: contact_is_contractor {
    group_label: "      Contact Staff"

    type: yesno
    sql: ${TABLE}.contact_is_contractor ;;
  }

  dimension: contact_is_staff {
    group_label: "      Contact Staff"

    type: yesno
    sql: ${TABLE}.contact_is_staff ;;
  }

  dimension: contact_is_unworked {
    group_label: "      Contact Marketing"

    type: yesno
    sql: ${TABLE}.contact_is_unworked ;;
  }

  dimension: contact_last_email_name {
    group_label: "      Contact Marketing"

    type: string
    sql: ${TABLE}.contact_last_email_name ;;
  }

  dimension_group: contact_last_meeting_booked {
    group_label: "      Contact Sales Activity"

    type: time
    timeframes: [raw, time, date]
    sql: ${TABLE}.contact_last_meeting_booked ;;
  }

  dimension_group: contact_last_modified {
    group_label: "      Contact Marketing"

    type: time
    timeframes: [raw, date]
    sql: ${TABLE}.contact_last_modified_date ;;
  }

  dimension: contact_last_nps_follow_up {
    group_label: "      Contact Marketing"

    type: string
    sql: ${TABLE}.contact_last_nps_follow_up ;;
  }

  dimension: contact_last_nps_rating {
    group_label: "      Contact Marketing"

    type: string
    sql: ${TABLE}.contact_last_nps_rating ;;
  }

  dimension_group: contact_last_open {
    group_label: "      Contact Marketing"

    type: time
    timeframes: [raw, time, date]
    sql: ${TABLE}.contact_last_open_date ;;
  }

  dimension: contact_last_referrer {
    group_label: "      Contact Marketing"

    type: string
    sql: ${TABLE}.contact_last_referrer ;;
  }



  dimension_group: contact_last_sales_activity {
    group_label: "      Contact Sales Activity"

    type: time
    timeframes: [raw, time, date]
    sql: ${TABLE}.contact_last_sales_activity_ts ;;
  }

  dimension_group: contact_last_send {
    group_label: "      Contact Marketing"

    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.contact_last_send_date ;;
  }

  dimension_group: contact_last_timestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.contact_last_timestamp ;;
  }

  dimension: contact_last_url {
    group_label: "      Contact Marketing"

    type: string
    sql: ${TABLE}.contact_last_url ;;
  }

  dimension_group: contact_last_visit {
    group_label: "      Contact Marketing"

    type: time
    timeframes: [raw, time, date]
    sql: ${TABLE}.contact_last_visit_ts ;;
  }

  dimension_group: contact_latest_meeting_activity {
    group_label: "      Contact Sales Activity"

    type: time
    timeframes: [raw, time, date]
    sql: ${TABLE}.contact_latest_meeting_activity ;;
  }

  dimension: contact_lead_status {
    group_label: "      Contact Marketing"

    type: string
    sql: ${TABLE}.contact_lead_status ;;
  }



  dimension: contact_marketable_reason_type {
    group_label: "      Contact Marketing"

    type: string
    sql: ${TABLE}.contact_marketable_reason_type ;;
  }

  dimension: contact_marketable_status {
    group_label: "      Contact Marketing"

    type: string
    sql: ${TABLE}.contact_marketable_status ;;
  }

  dimension: contact_marketing_legal_basis {
    group_label: "      Contact Marketing"

    type: string
    sql: ${TABLE}.contact_marketing_legal_basis ;;
  }

  dimension: contact_message {
    group_label: "      Contact Marketing"

    type: string
    sql: ${TABLE}.contact_message ;;
  }

  dimension: contact_name {
    group_label: "      Contact Details"

    type: string
    sql: ${TABLE}.contact_name ;;
  }

  dimension_group: contact_notes_last_contacted {
    group_label: "      Contact Sales Activity"

    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.contact_notes_last_contacted ;;
  }

  dimension_group: contact_notes_last_updated {
    group_label: "      Contact Sales Activity"

    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.contact_notes_last_updated ;;
  }

  dimension: contact_num_associated_deals {
    group_label: "      Contact Sales Activity"

    type: number
    sql: ${TABLE}.contact_num_associated_deals ;;
  }

  dimension: contact_num_contacted_notes {
    group_label: "      Contact Marketing"

    type: number
    sql: ${TABLE}.contact_num_contacted_notes ;;
  }

  dimension: contact_num_event_completions {
    group_label: "      Contact Sales Activity"

    type: number
    sql: ${TABLE}.contact_num_event_completions ;;
  }

  dimension: contact_num_notes {
    group_label: "      Contact Sales Activity"

    type: number
    sql: ${TABLE}.contact_num_notes ;;
  }

  dimension: contact_num_page_views {
    group_label: "      Contact Sales Activity"

    type: number
    sql: ${TABLE}.contact_num_page_views ;;
  }

  dimension: contact_num_visits {
    group_label: "      Contact Sales Activity"

    type: number
    sql: ${TABLE}.contact_num_visits ;;
  }

  dimension: contact_phone {
    group_label: "      Contact Details"

    type: string
    sql: ${TABLE}.contact_phone ;;
  }

  dimension: contact_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.contact_pk ;;
  }

  dimension: contact_recent_deal_amount {
    group_label: "      Contact Sales Activity"

    type: number
    sql: ${TABLE}.contact_recent_deal_amount ;;
  }

  dimension_group: contact_recent_deal_close {
    group_label: "      Contact Sales Activity"

    type: time
    timeframes: [raw, time, date]
    sql: ${TABLE}.contact_recent_deal_close_date ;;
  }

  dimension_group: contact_sales_email_last_opened {
    group_label: "      Contact Sales Activity"

    type: time
    timeframes: [raw, time, date]
    sql: ${TABLE}.contact_sales_email_last_opened ;;
  }

  dimension_group: contact_sales_email_last_replied {
    group_label: "      Contact Sales Activity"

    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.contact_sales_email_last_replied ;;
  }

  dimension: contact_seniority {
    group_label: "      Contact Details"

    type: string
    sql: ${TABLE}.contact_seniority ;;
  }

  dimension_group: contact_social_last_engagement {
    group_label: "      Contact Social Media"

    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.contact_social_last_engagement ;;
  }

  dimension: contact_social_linkedin_clicks {
    group_label: "      Contact Social Media"

    type: number
    sql: ${TABLE}.contact_social_linkedin_clicks ;;
  }

  dimension: contact_source_data_1 {
    group_label: "      Contact Details"

    type: string
    sql: ${TABLE}.contact_source_data_1 ;;
  }

  dimension: contact_source_data_2 {
    group_label: "      Contact Details"

    type: string
    sql: ${TABLE}.contact_source_data_2 ;;
  }

  dimension: contact_source_type {
    group_label: "      Contact Details"

    type: string
    sql: ${TABLE}.contact_source_type ;;
  }

  dimension: contact_staff_contract_type {
    group_label: "      Contact Staff"

    type: string
    sql: ${TABLE}.contact_staff_contract_type ;;
  }

  dimension_group: contact_staff_employment_start {
    group_label: "      Contact Staff"

    type: time
    timeframes: [raw, date]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.contact_staff_employment_start_ts ;;
  }

  dimension: contact_staff_gender {
    group_label: "      Contact Staff"

    type: string
    sql: ${TABLE}.contact_staff_gender ;;
  }

  dimension: contact_staff_job_title {
    group_label: "      Contact Staff"

    type: string
    sql: ${TABLE}.contact_staff_job_title ;;
  }

  dimension: contact_staff_location_city {
    group_label: "      Contact Staff"

    type: string
    sql: ${TABLE}.contact_staff_location_city ;;
  }

  dimension: contact_staff_location_country {
    group_label: "      Contact Staff"

    type: string
    sql: ${TABLE}.contact_staff_location_country ;;
  }

  dimension: contact_staff_nationality {
    group_label: "      Contact Staff"

    type: string
    sql: ${TABLE}.contact_staff_nationality ;;
  }

  dimension_group: contact_staff_probation_end {
    group_label: "      Contact Staff"

    type: time
    timeframes: [raw, date]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.contact_staff_probation_end_ts ;;
  }

  dimension: contact_staff_team_name {
    group_label: "      Contact Staff"

    type: string
    sql: ${TABLE}.contact_staff_team_name ;;
  }

  dimension_group: contact_staff_working_start {
    group_label: "      Contact Staff"

    type: time
    timeframes: [raw, date]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.contact_staff_working_start_ts ;;
  }

  dimension: contact_twitterbio {
    group_label: "      Contact Social Media"

    type: string
    sql: ${TABLE}.contact_twitterbio ;;
  }

  dimension: contact_twitterhandle {
    group_label: "      Contact Social Media"

    type: string
    sql: ${TABLE}.contact_twitterhandle ;;
  }

  dimension: contact_weekly_capacity {
    group_label: "      Contact Staff"

    type: number
    sql: ${TABLE}.contact_weekly_capacity ;;
  }

  dimension: contact_zip {
    group_label: "      Contact Details"

    type: string
    sql: ${TABLE}.contact_zip ;;
  }

  dimension: contact_zoom_webinar_attendance_average_duration {
    group_label: "      Contact Sales Activity"

    type: number
    sql: ${TABLE}.contact_zoom_webinar_attendance_average_duration ;;
  }

  dimension: contact_zoom_webinar_attendance_count {
    group_label: "      Contact Sales Activity"

    type: number
    sql: ${TABLE}.contact_zoom_webinar_attendance_count ;;
  }

  dimension: contact_zoom_webinar_registration_count {
    group_label: "      Contact Sales Activity"

    type: number
    sql: ${TABLE}.contact_zoom_webinar_registration_count ;;
  }

  dimension_group: dbt_slack_created_at {
    group_label: "      Contact Social Media"

    type: time
    timeframes: [raw, date, ]
    sql: ${TABLE}.dbt_slack_created_at_ts ;;
  }

  dimension: is_crm_tracked {
    group_label: "      Contact Staff"

    type: yesno
    sql: ${TABLE}.is_crm_tracked ;;
  }

  dimension: is_dbt_slack_member {
    group_label: "      Contact Social Media"

    type: yesno
    sql: ${TABLE}.is_dbt_slack_member ;;
  }

  dimension: is_github_interactor {
    group_label: "      Contact Social Media"

    type: yesno
    sql: ${TABLE}.is_github_interactor ;;
  }

  dimension: is_linkedin_interactor {
    group_label: "      Contact Social Media"

    type: yesno
    sql: ${TABLE}.is_linkedin_interactor ;;
  }

  dimension: is_medium_interactor {
    group_label: "      Contact Social Media"

    type: yesno
    sql: ${TABLE}.is_medium_interactor ;;
  }

  dimension: is_project_interactor {
    group_label: "      Contact Details"

    type: yesno
    sql: ${TABLE}.is_project_interactor ;;
  }

  dimension: is_twitter_interactor {
    group_label: "      Contact Social Media"

    type: yesno
    sql: ${TABLE}.is_twitter_interactor ;;
  }
  measure: count {
    type: count
    drill_fields: [contact_conversion_event_name, contact_name, contact_staff_team_name, contact_last_email_name]
  }
}

# The name of this view in Looker is "Contacts Dim All Job Titles"
