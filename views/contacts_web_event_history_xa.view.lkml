view: contacts_web_event_history_xa {
  sql_table_name: `{{ _user_attributes['dataset'] }}.contacts_web_event_history_xa`
    ;;

  dimension: contact_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_pk ;;
  }

  dimension: event_details {
    type: string
    sql: ${TABLE}.event_details ;;
  }

  dimension_group: event_ts {
    group_label: "Event"
    type: time
    timeframes: [
      raw,
      time
    ]
    sql: ${TABLE}.event_ts ;;
  }

  dimension: event_type {
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: ip {
    type: string
    sql: ${TABLE}.ip ;;
  }

  dimension: page_title {
    type: string
    sql: ${TABLE}.page_title ;;
  }

  dimension: page_url {
    type: string
    sql: ${TABLE}.page_url ;;
  }

  dimension: web_event_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.web_event_pk ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}