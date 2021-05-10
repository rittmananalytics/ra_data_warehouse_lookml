view: cs_engagement_fact {
  sql_table_name: `ra-development.analytics.cs_engagement_fact`
    ;;

  dimension: client_contact {
    type: string
    sql: ${TABLE}.Client_Contact ;;
  }

  dimension: company {
    type: string
    sql: ${TABLE}.company ;;
  }

  dimension: primary_key {
    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension: meeting_count {
    type: number
    sql: ${TABLE}.meeting_count ;;
  }

  dimension: meeting_month {
    type: string
    sql: ${TABLE}.meeting_month ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
