view: contacts_dim {
  sql_table_name: analytics.contacts_dim;;

  dimension: company_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.company_pk ;;
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

  dimension: contact_conversion_event {
    group_label: "      Contact Details"
    type: string
    sql: ${TABLE}.contact_conversion_event_source ;;
  }

  dimension: contact_source_type {
    group_label: "      Contact Details"
    type: string
    sql: ${TABLE}.contact_source_type ;;
  }

  dimension: is_contact_in_crm_workflow {
    group_label: "      Contact Details"
    type: yesno
    sql: ${TABLE}.contact_in_crm_workflow ;;
  }

  dimension: contact_crm_lifecycle_stage {
    group_label: "      Contact Details"
    type: string
    sql: ${TABLE}.contact_crm_lifecycle_stage ;;
  }




  dimension: contact_cost_rate {
    group_label: "Staff Details"

    hidden: no
    value_format_name: gbp

    type: number
    sql: ${TABLE}.contact_cost_rate ;;
  }

  dimension_group: contact_created {
    hidden: yes

    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.contact_created_date ;;
  }

  dimension: contact_default_hourly_rate {
    group_label: "Staff Details"
    value_format_name: gbp

    hidden: no
    type: number
    sql: ${TABLE}.contact_default_hourly_rate ;;
  }

  dimension: contact_is_active {
    group_label: "Staff Details"

    hidden: no

    type: yesno
    sql: ${TABLE}.contact_is_active ;;
  }

  dimension: contact_is_contractor {
    group_label: "Staff Details"

    type: yesno
    sql: ${TABLE}.contact_is_contractor ;;
  }

  dimension: contact_is_staff {
    group_label: "Staff Details"

    type: yesno
    sql: ${TABLE}.contact_is_staff ;;
  }

  dimension: contact_staff_job_title {
    group_label: "Staff Details"
    type: string
    sql: ${TABLE}.contact_staff_job_title ;;
  }

  dimension_group: contact_last_modified {
    hidden: yes

    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.contact_last_modified_date ;;
  }



  dimension: contact_name {
    label: "        Contact Name"
    group_label: "      Contact Details"

    type: string
    sql: ${TABLE}.contact_name ;;
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

  measure: count_contacts {
    group_label: "        {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}"

    type: count_distinct
    sql: ${TABLE}.contact_pk ;;
  }

  dimension: contact_weekly_capacity {
    group_label: "Staff Details"

    hidden: no
    type: number
    sql: ${TABLE}.contact_weekly_capacity/60/60 ;;
  }

  dimension: job_titles {
    group_label: "      Contact Details"

    type: string
    sql: (SELECT string_agg(job_title) job_title FROM UNNEST(all_job_titles) job_title) ;;
  }



  dimension: contact_staff_contract_type {
    group_label: "Staff Details"
    type: string
    sql: ${TABLE}.contact_staff_contract_type ;;
  }

  dimension: contact_staff_employment_start_ts {
    group_label: "Staff Details"
    type: date
    datatype: date
    sql: ${TABLE}.contact_staff_employment_start_ts ;;
  }

  dimension: contact_staff_working_start_ts {
    group_label: "Staff Details"
    type: date
    datatype: date
    sql: ${TABLE}.contact_staff_working_start_ts ;;
  }

  dimension: contact_staff_location_city {
    group_label: "Staff Details"
    type: string
    sql: ${TABLE}.contact_staff_location_city ;;
  }

  dimension: contact_staff_location_country {
    group_label: "Staff Details"
    type: string
    sql: ${TABLE}.contact_staff_location_country ;;
  }

  dimension: contact_staff_gender {
    group_label: "Staff Details"
    type: string
    sql: ${TABLE}.contact_staff_gender ;;
  }

  dimension: contact_staff_nationality {
    group_label: "Staff Details"
    type: string
    sql: ${TABLE}.contact_staff_nationality ;;
  }

  dimension: contact_staff_probation_end_ts {
    group_label: "Staff Details"
    type: date
    datatype: date
    sql: ${TABLE}.contact_staff_probation_end_ts ;;
  }

  dimension: contact_staff_team_name {
    group_label: "Staff Details"
    type: string
    sql: ${TABLE}.contact_staff_team_name ;;
  }



  dimension: contact_friends_count {
    hidden: yes
    group_label: "Social Media"
    type: number
    sql: ${TABLE}.contact_friends_count ;;
  }

  dimension: contact_posts_count {
    hidden: yes

    group_label: "Social Media"
    type: number
    sql: ${TABLE}.contact_posts_count ;;
  }

  dimension: contact_is_following {
    hidden: yes

    group_label: "Social Media"
    type: yesno
    sql: ${TABLE}.contact_is_following ;;
  }

  dimension: contact_is_followed_by_us {
    hidden: yes

    group_label: "Social Media"
    type: yesno
    sql: ${TABLE}.contact_is_followed_by_us ;;
  }

  dimension: contact_job_description {
    group_label: "      Contact Details"
    type: string
    sql: ${TABLE}.contact_job_description ;;
  }

  dimension: contact_school {
    group_label: "      Contact Details"
    type: string
    sql: ${TABLE}.contact_school ;;
  }

  dimension: contact_description {
    group_label: "      Contact Details"
    type: string
    sql: ${TABLE}.contact_description ;;
  }

  dimension: contact_subscribers {
    hidden: yes

    group_label: "Social Media"
    type: string
    sql: ${TABLE}.contact_subscribers ;;
  }

  dimension: contact_connection_degree {
    hidden: yes

    group_label: "Social Media"
    type: string
    sql: ${TABLE}.contact_connection_degree ;;
  }

  dimension: contact_connections_count {
    hidden: yes

    group_label: "Social Media"
    type: number
    sql: ${TABLE}.contact_connections_count ;;
  }

  dimension: contact_mutual_connections {
    hidden: yes

    group_label: "Social Media"

    type: string
    sql: ${TABLE}.contact_mutual_connections ;;
  }

  dimension: contact_school_degree {
    group_label: "      Contact Details"

    type: string
    sql: ${TABLE}.contact_school_degree ;;
  }

  dimension: contact_school_description {
    group_label: "      Contact Details"

    type: string
    sql: ${TABLE}.contact_school_description ;;
  }

  dimension: contact_qualifications {
    group_label: "      Contact Details"

    type: string
    sql: ${TABLE}.contact_qualifications ;;
  }

  dimension: contact_skills {
    group_label: "      Contact Details"

    type: string
    sql: ${TABLE}.contact_skills ;;
  }

  dimension: dbt_slack_channels {
    hidden: yes

    group_label: "Social Media"
    type: string
    sql: ${TABLE}.dbt_slack_channels ;;
  }

  dimension: is_dbt_slack_member {
    hidden: yes

    group_label: "Social Media"
    type: yesno
    sql: ${TABLE}.is_dbt_slack_member ;;
  }


  measure: count {
    hidden: yes
    type: count
    drill_fields: [contact_name]
  }
}
