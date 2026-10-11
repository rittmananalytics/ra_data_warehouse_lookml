view: meeting_contact_lines_fact {
  sql_table_name: `ra-development.analytics.meeting_contact_lines_fact` ;;

  dimension: company_fk {
    hidden: yes
    sql: ${TABLE}.company_fk ;;
  }

  dimension: company_name {
    sql: ${TABLE}.company_name ;;
  }

  dimension: contact_name {
    sql: ${TABLE}.contact_name ;;
  }

  dimension: dbt_source_relation {
    hidden: yes
    sql: ${TABLE}._dbt_source_relation ;;
  }

  dimension: meeting_contact_line_pk {
    hidden: yes
    sql: ${TABLE}.meeting_contact_line_pk ;;
  }

  dimension: person_fk {
    hidden: yes
    sql: ${TABLE}.person_fk ;;
  }

  dimension: recording_url {
    sql: ${TABLE}.recording_url ;;
  }

  dimension: text {
    sql: ${TABLE}.text ;;
  }

  dimension_group: time {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.time ;;
  }

  measure: count {
    type: count
    drill_fields: [meeting_contact_lines_fact.contact_name, meeting_contact_lines_fact.company_name]
  }
}
