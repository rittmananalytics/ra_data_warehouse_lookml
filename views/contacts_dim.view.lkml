view: contacts_dim {
  derived_table: {
    sql: SELECT
        ct.*,
        hb.contact_id as hubspot_contact_id,
        ce.contact_email as contact_email,

      c.company_pk
      FROM (
      SELECT
      *
      FROM
      `{{ _user_attributes['dataset'] }}.contacts_dim`,
      UNNEST( all_contact_company_ids) AS company_id  ) ct
      JOIN (
      SELECT
      *
      FROM
      `{{ _user_attributes['dataset'] }}.companies_dim` c,
      UNNEST (all_company_ids) AS company_id ) c
      ON
      ct.company_id = c.company_id
      LEFT JOIN
      (SELECT
      contact_pk,
      contact_id
      FROM `{{ _user_attributes['dataset'] }}.contacts_dim`,
      UNNEST( all_contact_ids) as contact_id
      WHERE
      contact_id like '%hubspot%' ) hb
      ON ct.contact_pk = hb.contact_pk
      LEFT JOIN
      (SELECT
      contact_pk,
      contact_email
      FROM `{{ _user_attributes['dataset'] }}.contacts_dim`,
      UNNEST( all_contact_emails ) as contact_email
      ) ce
      ON ct.contact_pk = ce.contact_pk
      WHERE
      ct.company_id = c.company_id ;;
  }




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
    group_label: "Social Media"
    type: number
    sql: ${TABLE}.contact_friends_count ;;
  }

  dimension: contact_posts_count {
    group_label: "Social Media"
    type: number
    sql: ${TABLE}.contact_posts_count ;;
  }

  dimension: contact_is_following {
    group_label: "Social Media"
    type: yesno
    sql: ${TABLE}.contact_is_following ;;
  }

  dimension: contact_is_followed_by_us {
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
    group_label: "Social Media"
    type: string
    sql: ${TABLE}.contact_subscribers ;;
  }

  dimension: contact_connection_degree {
    group_label: "Social Media"
    type: string
    sql: ${TABLE}.contact_connection_degree ;;
  }

  dimension: contact_connections_count {
    group_label: "Social Media"
    type: number
    sql: ${TABLE}.contact_connections_count ;;
  }

  dimension: contact_mutual_connections {
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


  measure: count {
    hidden: yes
    type: count
    drill_fields: [contact_name]
  }
}
