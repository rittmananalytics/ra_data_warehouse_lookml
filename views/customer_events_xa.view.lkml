view: customer_events_xa {
  sql_table_name: `{{ _user_attributes['dataset'] }}.customer_events_xa`
    ;;

  dimension: client_event_seq {
    type: number
    sql: ${TABLE}.client_event_seq ;;
  }

  dimension: pk {
    type: string
    hidden: yes
    sql: concat(${company_pk},${client_event_seq}) ;;
  }

  dimension: company_pk {
    hidden: no
    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension: company_name {
    type: string
    sql: ${TABLE}.company_name ;;
  }

  dimension: event_contact_name {
    type: string
    sql: ${TABLE}.event_contact_name ;;
  }

  dimension: event_contact_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.event_contact_pk ;;
  }

  dimension: event_details {
    type: string
    sql: ${TABLE}.event_details ;;
  }

  dimension_group: event_ts {
    hidden: no
    label: "Event"
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

  dimension: months_since_client_created {
    type: number
    sql: ${TABLE}.months_since_client_created ;;
  }





  dimension: transaction_value {
    hidden: no

    type: number
    sql: ${TABLE}.total_ltv ;;
  }


 measure: total_days_billed {
   type: sum
   sql: case when ${event_type} = 'Delivery Cost' then safe_cast(${event_details} as float64) end ;;
 }

  measure: total_transaction_value {
    type: sum_distinct
    sql_distinct_key: ${pk} ;;
    sql: ${TABLE}.total_ltv ;;
  }


}