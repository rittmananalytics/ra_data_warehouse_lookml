view: meeting_contact_lines_fact {
  sql_table_name: `ra-development.analytics.meeting_contact_lines_fact` ;;

  dimension: _dbt_source_relation {
    hidden: yes

    type: string
    sql: ${TABLE}._dbt_source_relation ;;
  }
  dimension: company_fk {
    hidden: yes

    type: string
    sql: ${TABLE}.company_fk ;;
  }
  dimension: company_name {
    type: string
    sql: ${TABLE}.company_name ;;
  }
  dimension: contact_fk {
    hidden: yes

    type: string
    sql: ${TABLE}.contact_fk ;;
  }
  dimension: contact_name {
    type: string
    sql: ${TABLE}.contact_name ;;
  }
  dimension: meeting_contact_line_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.meeting_contact_line_pk ;;
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
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.time ;;
  }
  measure: count {
    type: count
    drill_fields: [contact_name, company_name]
  }
}
