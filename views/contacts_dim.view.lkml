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

  dimension: contact_email {
    hidden: no
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}"

    type: string
    sql: ${TABLE}.contact_email ;;
  }



  dimension: hubspot_contact_id {
    hidden: no
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}"

    type: string
    sql: ${TABLE}.hubspot_contact_id ;;
  }

  dimension: contact_cost_rate {
    hidden: yes

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
    hidden: yes
    type: number
    sql: ${TABLE}.contact_default_hourly_rate ;;
  }

  dimension: contact_is_active {
    hidden: yes

    type: yesno
    sql: ${TABLE}.contact_is_active ;;
  }

  dimension: contact_is_contractor {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}"

    type: yesno
    sql: ${TABLE}.contact_is_contractor ;;
  }

  dimension: contact_is_staff {
    group_label: "{{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}"

    type: yesno
    sql: ${TABLE}.contact_is_staff ;;
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
    group_label: "        {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}"

    type: string
    sql: ${TABLE}.contact_name ;;
  }

  dimension: contact_phone {
    group_label: "        {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}"

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
    hidden: yes
    type: number
    sql: ${TABLE}.contact_weekly_capacity ;;
  }

  dimension: job_title {
    label: "      Contact Role"
    group_label: "        {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}"

    type: string
    sql: ${TABLE}.job_title ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [contact_name]
  }
}
