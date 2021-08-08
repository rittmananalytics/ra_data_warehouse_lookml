view: contacts_web_event_history_xa {
  sql_table_name: `{{ _user_attributes['dataset'] }}.contacts_web_event_history_xa`
    ;;

  dimension: contact_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_pk ;;
  }

  dimension: event_details {
    group_label: "      Contact Web Events"

    type: string
    sql: ${TABLE}.event_details ;;
  }

  dimension_group: event_ts {
    group_label: "      Contact Web Events"
    type: time
    timeframes: [
      raw,
      time
    ]
    sql: ${TABLE}.event_ts ;;
  }

  dimension: event_type {
    group_label: "      Contact Web Events"

    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: ip {
    group_label: "      Contact Web Events"

    type: string
    sql: ${TABLE}.ip ;;
  }

  dimension: page_title {
    group_label: "      Contact Web Events"

    type: string
    sql: ${TABLE}.page_title ;;
  }

  dimension: page_url {
    group_label: "      Contact Web Events"

    type: string
    sql: ${TABLE}.page_url ;;
  }

  dimension: web_event_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.web_event_pk ;;
  }


}
