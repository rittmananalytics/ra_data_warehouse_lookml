view: messages_fact {
  sql_table_name: `ra-development.analytics.messages_fact` ;;

  dimension: channel_id {
    hidden: yes
    sql: ${TABLE}.channel_id ;;
  }

  dimension: channel_name {
    sql: ${TABLE}.channel_name ;;
  }

  dimension: company_fk {
    hidden: yes
    sql: ${TABLE}.company_fk ;;
  }

  dimension: contact_fk {
    hidden: yes
    sql: ${TABLE}.contact_fk ;;
  }

  dimension: dbt_source_relation {
    hidden: yes
    sql: ${TABLE}._dbt_source_relation ;;
  }

  dimension: looked_up_user_name_1 {
    hidden: yes
    sql: ${TABLE}.looked_up_user_name_1 ;;
  }

  dimension: looked_up_user_name_2 {
    hidden: yes
    sql: ${TABLE}.looked_up_user_name_2 ;;
  }

  dimension: looked_up_user_name_3 {
    hidden: yes
    sql: ${TABLE}.looked_up_user_name_3 ;;
  }

  dimension: message_id {
    hidden: yes
    sql: ${TABLE}.message_id ;;
  }

  dimension: message_pk {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.message_pk ;;
  }

  dimension: message_subtype {
    sql: ${TABLE}.message_subtype ;;
  }

  dimension: message_text {
    sql: ${TABLE}.message_text ;;
  }

  dimension: message_type {
    sql: ${TABLE}.message_type ;;
  }

  dimension: message_uuid {
    hidden: yes
    value_format_name: id
    sql: ${TABLE}.message_uuid ;;
  }

  dimension: parent_message_id {
    hidden: yes
    sql: ${TABLE}.parent_message_id ;;
  }

  dimension_group: message {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.message_ts ;;
  }

  measure: count {
    type: count
    drill_fields: [messages_fact.channel_name]
  }
}
