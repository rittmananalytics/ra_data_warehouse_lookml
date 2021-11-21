view: customer_events_xa {
  sql_table_name: `{{ _user_attributes['dataset'] }}.customer_events_xa`
    ;;

  dimension: client_event_seq {
    group_label: "Event Timeline"

    type: number
    sql: ${TABLE}.client_event_seq ;;
  }

  dimension: pk {
    type: string
    hidden: yes
    sql: concat(${company_pk},${client_event_seq}) ;;
  }

  dimension: company_pk {
    group_label: "Event Timeline"

    hidden: yes
    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension: company_name {
    hidden: no
    type: string
    sql: ${TABLE}.company_name ;;
  }

  dimension: event_contact_name {
    group_label: "Event Timeline"

    type: string
    sql: ${TABLE}.event_contact_name ;;
  }

  dimension: event_contact_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.event_contact_pk ;;
  }

  dimension: event_details {
    group_label: "Event Timeline"

    type: string
    sql: ${TABLE}.event_details ;;
  }

  dimension_group: event_ts {
    hidden: no
    group_label: "Event Timeline"

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
    group_label: "Event Timeline"
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: event_value {
    group_label: "Event Timeline"

    type: number
    sql: ${TABLE}.event_value ;;
  }

  dimension: months_since_client_created {
    group_label: "Event Timeline"

    type: number
    sql: ${TABLE}.months_since_client_created ;;
  }





  dimension: transaction_value {
    hidden: no
    group_label: "Event Timeline"

    type: number
    sql: ${TABLE}.total_ltv ;;
  }


 measure: total_days_billed {
  group_label: "Event Timeline"

   type: sum
   sql: case when ${event_type} = 'Delivery Cost' then safe_cast(${event_details} as float64) end ;;
 }

  measure: total_transaction_value {
    group_label: "Event Timeline"

    type: sum_distinct
    sql_distinct_key: ${pk} ;;
    sql: ${TABLE}.total_ltv ;;
  }


}
