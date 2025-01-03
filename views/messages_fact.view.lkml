view: messages_fact {
  sql_table_name: `ra-development.analytics.messages_fact` ;;

  dimension: _dbt_source_relation {
    hidden: yes

    type: string
    sql: ${TABLE}._dbt_source_relation ;;
  }
  dimension: channel_id {
    hidden: yes
    type: string
    sql: ${TABLE}.channel_id ;;
  }
  dimension: channel_name {
    type: string
    sql: ${TABLE}.channel_name ;;
  }
  dimension: company_fk {
    hidden: yes

    type: string
    sql: ${TABLE}.company_fk ;;
  }
  dimension: contact_fk {
    hidden: yes

    type: string
    sql: ${TABLE}.contact_fk ;;
  }
  dimension: looked_up_user_name_1 {
    hidden: yes

    type: string
    sql: ${TABLE}.looked_up_user_name_1 ;;
  }
  dimension: looked_up_user_name_2 {
    hidden: yes

    type: string
    sql: ${TABLE}.looked_up_user_name_2 ;;
  }
  dimension: looked_up_user_name_3 {
    hidden: yes

    type: string
    sql: ${TABLE}.looked_up_user_name_3 ;;
  }
  dimension: message_id {
    hidden: yes

    type: string
    sql: ${TABLE}.message_id ;;
  }
  dimension: message_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.message_pk ;;
  }
  dimension: message_subtype {
    type: string
    sql: ${TABLE}.message_subtype ;;
  }
  dimension: message_text {
    type: string
    sql: ${TABLE}.message_text ;;
  }
  dimension_group: message {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.message_ts ;;
  }
  dimension: message_type {
    type: string
    sql: ${TABLE}.message_type ;;
  }
  dimension: message_uuid {
    hidden: yes

    type: number
    value_format_name: id
    sql: ${TABLE}.message_uuid ;;
  }
  dimension: parent_message_id {
    hidden: yes

    type: string
    sql: ${TABLE}.parent_message_id ;;
  }
  measure: count {
    type: count
    drill_fields: [channel_name]
  }
}
