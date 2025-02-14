view: email_send_outcomes_fact {
  sql_table_name: `{{ _user_attributes['dataset'] }}.email_send_outcomes_fact`
    ;;

  dimension: action {
    type: string
    sql: ${TABLE}.action ;;
  }

  dimension: contact_bounced {
    type: string
    sql: ${TABLE}.contact_bounced ;;
  }

  dimension: contact_clicked {
    type: string
    sql: ${TABLE}.contact_clicked ;;
  }

  dimension: contact_opened {
    type: string
    sql: ${TABLE}.contact_opened ;;
  }

  dimension: contact_pk {
    type: string
    sql: ${TABLE}.contact_pk ;;
  }

  dimension: email_address {
    type: string
    sql: ${TABLE}.email_address ;;
  }

  dimension: list_pk {
    type: string
    sql: ${TABLE}.list_pk ;;
  }

  dimension: send_outcome_pk {
    type: string
    sql: ${TABLE}.send_outcome_pk ;;
  }

  dimension: send_pk {
    type: string
    sql: ${TABLE}.send_pk ;;
  }

  dimension_group: timestamp {
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
    sql: ${TABLE}.timestamp ;;
  }

  dimension: bounces {
    type: number
    sql: ${TABLE}.total_bounces ;;
  }

  measure: total_bounces {
    type: sum
    sql: ${bounces} ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.total_clicks ;;
  }

  measure: total_clicks {
    type: sum
    sql: ${clicks} ;;
  }

  dimension: opens {
    type: number
    sql: ${TABLE}.total_opens ;;
  }

  measure: total_opens {
    type: sum
    sql: ${opens} ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  measure: total_sends {
    type: count_distinct
    sql: ${send_pk} ;;
    drill_fields: []
  }
}
