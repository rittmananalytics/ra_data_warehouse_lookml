view: customer_events_rpt {
  sql_table_name: `{{ _user_attributes['dbt_dataset'] }}.customer_events_rpt`
    ;;

  dimension: company_name {
    type: string
    sql: ${TABLE}.company_name ;;
  }

  dimension: company_pk {
    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension: event_details {
    type: string
    sql: ${TABLE}.event_details ;;
  }

  dimension: event_pk {
    type: number
    sql: ${TABLE}.event_pk ;;
  }

  dimension_group: event_ts {
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
    sql: ${TABLE}.event_ts ;;
  }

  dimension: event_type {
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: event_value {
    type: number
    sql: ${TABLE}.event_value ;;
  }

  measure: count {
    type: count
    drill_fields: [company_name]
  }
}