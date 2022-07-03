view: staff_dim {
  derived_table: {
    sql: SELECT contact_pk, contact_name, contact_is_contractor, contact_is_staff, contact_weekly_capacity, contact_default_hourly_rate, contact_cost_rate, contact_is_active, contact_created_date FROM `ra-development.analytics.contacts_dim`
      where contact_is_staff or contact_name = 'Rob Bramwell'
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: contact_pk {
    type: string
    sql: ${TABLE}.contact_pk ;;
  }

  dimension: contact_name {
    type: string
    sql: ${TABLE}.contact_name ;;
  }

  dimension: job_title {
    type: string
    sql: cast(null as string);;
  }

  dimension: contact_is_contractor {
    type: yesno
    sql: ${TABLE}.contact_is_contractor ;;
  }

  dimension: contact_is_staff {
    type: yesno
    sql: ${TABLE}.contact_is_staff ;;
  }

  dimension: contact_weekly_capacity {
    type: number
    sql: ${TABLE}.contact_weekly_capacity ;;
  }

  dimension: contact_default_hourly_rate {
    type: number
    sql: ${TABLE}.contact_default_hourly_rate ;;
  }

  dimension: contact_cost_rate {
    type: number
    sql: ${TABLE}.contact_cost_rate ;;
  }

  dimension: contact_is_active {
    type: yesno
    sql: ${TABLE}.contact_is_active ;;
  }

  dimension_group: contact_created_date {
    type: time
    sql: ${TABLE}.contact_created_date ;;
  }

  set: detail {
    fields: [
      contact_pk,
      contact_name,
      job_title,
      contact_is_contractor,
      contact_is_staff,
      contact_weekly_capacity,
      contact_default_hourly_rate,
      contact_cost_rate,
      contact_is_active,
      contact_created_date_time
    ]
  }
}
