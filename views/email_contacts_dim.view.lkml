view: email_contacts_dim {
  derived_table: {
    sql: select c.* except (all_contact_emails),
      contact_email
      from `ra-development.analytics.contacts_dim` c,
      unnest(all_contact_emails) as contact_email
       ;;
  }

  measure: count {
    type: count

  }

  dimension: contact_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_pk ;;
  }



  dimension: contact_name {
    type: string
    sql: ${TABLE}.contact_name ;;
  }

  dimension: contact_phone {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_phone ;;
  }

  dimension: contact_is_contractor {
    hidden: yes
    type: yesno
    sql: ${TABLE}.contact_is_contractor ;;
  }

  dimension: contact_is_staff {
    type: yesno
    sql: ${TABLE}.contact_is_staff ;;
  }

  dimension: contact_staff_job_title {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_staff_job_title ;;
  }

  dimension: contact_staff_contract_type {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_staff_contract_type ;;
  }



  dimension: contact_is_active {
    hidden: yes
    type: yesno
    sql: ${TABLE}.contact_is_active ;;
  }

  dimension_group: contact_created_date {
    type: time
    sql: ${TABLE}.contact_created_date ;;
  }

  dimension_group: contact_last_modified_date {
    hidden: yes
    type: time
    sql: ${TABLE}.contact_last_modified_date ;;
  }

  dimension: contact_friends_count {
    type: number
    sql: ${TABLE}.contact_friends_count ;;
  }

  dimension: contact_posts_count {
    type: number
    sql: ${TABLE}.contact_posts_count ;;
  }

  dimension: contact_is_following {
    type: yesno
    sql: ${TABLE}.contact_is_following ;;
  }

  dimension: contact_is_followed_by_us {
    type: yesno
    sql: ${TABLE}.contact_is_followed_by_us ;;
  }

  dimension: contact_school {
    type: string
    sql: ${TABLE}.contact_school ;;
  }

  dimension: contact_description {
    type: string
    sql: ${TABLE}.contact_description ;;
  }

  dimension: contact_subscribers {
    type: number
    sql: ${TABLE}.contact_subscribers ;;
  }

  dimension: contact_connection_degree {
    type: string
    sql: ${TABLE}.contact_connection_degree ;;
  }

  dimension: contact_connections_count {
    type: number
    sql: ${TABLE}.contact_connections_count ;;
  }

  dimension: contact_mutual_connections {
    type: string
    sql: ${TABLE}.contact_mutual_connections ;;
  }

  dimension: contact_mail_from_drop_contact {
    type: string
    sql: ${TABLE}.contact_mail_from_drop_contact ;;
  }

  dimension: contact_school_degree {
    type: string
    sql: ${TABLE}.contact_school_degree ;;
  }

  dimension: contact_school_description {
    type: string
    sql: ${TABLE}.contact_school_description ;;
  }

  dimension: contact_qualifications {
    type: string
    sql: ${TABLE}.contact_qualifications ;;
  }

  dimension: contact_skills {
    type: string
    sql: ${TABLE}.contact_skills ;;
  }

  dimension: contact_conversion_event_source {
    type: string
    sql: ${TABLE}.contact_conversion_event_source ;;
  }

  dimension: contact_source_type {

    type: string
    sql: ${TABLE}.contact_source_type ;;
  }

  dimension: contact_in_crm_workflow {
    type: string
    sql: ${TABLE}.contact_in_crm_workflow ;;
  }

  dimension: contact_crm_lifecycle_stage {
    type: string
    sql: ${TABLE}.contact_crm_lifecycle_stage ;;
  }

  dimension: contact_marketing_legal_basis {
    type: string
    sql: ${TABLE}.contact_marketing_legal_basis ;;
  }

  dimension: all_job_titles {
    hidden: yes
    type: string
    sql: ${TABLE}.all_job_titles ;;
  }


  dimension: all_contact_company_ids {
    hidden: yes
    type: string
    sql: ${TABLE}.all_contact_company_ids ;;
  }

  dimension: contact_bio {
    type: string
    sql: ${TABLE}.contact_bio ;;
  }

  dimension: is_dbt_slack_member {
    type: yesno
    sql: ${TABLE}.is_dbt_slack_member ;;
  }

  dimension_group: dbt_slack_created_at_ts {
    type: time
    sql: ${TABLE}.dbt_slack_created_at_ts ;;
  }

  dimension: all_dbt_slack_channels {
    type: string
    sql: ${TABLE}.all_dbt_slack_channels ;;
  }

  dimension: is_linkedin_interactor {
    type: yesno
    sql: ${TABLE}.is_linkedin_interactor ;;
  }

  dimension: is_medium_interactor {
    type: yesno
    sql: ${TABLE}.is_medium_interactor ;;
  }

  dimension: is_twitter_interactor {
    type: yesno
    sql: ${TABLE}.is_twitter_interactor ;;
  }

  dimension: is_crm_tracked {
    type: yesno
    sql: ${TABLE}.is_crm_tracked ;;
  }

  dimension: is_project_interactor {
    type: yesno
    sql: ${TABLE}.is_project_interactor ;;
  }

  dimension: is_github_interactor {
    type: yesno
    sql: ${TABLE}.is_github_interactor ;;
  }

  dimension: contact_email {
    primary_key: yes
    type: string
    sql: ${TABLE}.contact_email ;;
  }



}
