view: meeting_contact_lines_fact {
  sql_table_name: `ra-development.analytics.meeting_contact_lines_fact` ;;

  dimension: company_fk {
    type: string
    hidden: yes
    sql: ${TABLE}.company_fk ;;
  }

  dimension: company_name {
    type: string
    sql: ${TABLE}.company_name ;;
  }

  dimension: contact_name {
    type: string
    sql: ${TABLE}.contact_name ;;
  }

  dimension: dbt_source_relation {
    type: string
    hidden: yes
    sql: ${TABLE}._dbt_source_relation ;;
  }

  dimension: meeting_contact_line_pk {
    type: string
    hidden: yes
    sql: ${TABLE}.meeting_contact_line_pk ;;
  }

  dimension: person_fk {
    type: string
    hidden: yes
    sql: ${TABLE}.person_fk ;;
  }

  dimension: recording_url {
    type: string
    sql: ${TABLE}.recording_url ;;
  }

  dimension: text {
    type: string
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
