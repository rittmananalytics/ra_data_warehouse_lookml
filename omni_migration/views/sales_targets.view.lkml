view: sales_targets {
  sql_table_name: `ra-development.analytics_seed.sales_targets` ;;

  dimension: client_meetings_target_number {
    type: number
    hidden: yes
    sql: ${TABLE}.client_meetings_target_number ;;
  }

  dimension: closed_deals_new_clients_target_number {
    type: number
    hidden: yes
    sql: ${TABLE}.closed_deals_new_clients_target_number ;;
  }

  dimension: closed_deals_renewal_clients_target_number {
    type: number
    hidden: yes
    sql: ${TABLE}.closed_deals_renewal_clients_target_number ;;
  }

  dimension: closed_won_target_revenue {
    type: number
    hidden: yes
    sql: ${TABLE}.closed_won_target_revenue ;;
  }

  dimension: closed_won_target_revenue_ben {
    type: number
    hidden: yes
    sql: ${TABLE}.closed_won_target_revenue_ben ;;
  }

  dimension: closed_won_target_revenue_others {
    type: number
    hidden: yes
    sql: ${TABLE}.closed_won_target_revenue_others ;;
  }

  dimension: deals_target_revenue {
    type: number
    hidden: yes
    sql: ${TABLE}.deals_target_revenue ;;
  }

  dimension: new_deals_target_number {
    type: number
    hidden: yes
    sql: ${TABLE}.new_deals_target_number ;;
  }

  dimension: new_mqls_target_number {
    type: number
    hidden: yes
    sql: ${TABLE}.new_mqls_target_number ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: ${period_date} ;;
  }

  dimension: target_revenue {
    type: number
    hidden: yes
    sql: ${TABLE}.target_revenue ;;
  }

  dimension_group: period {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    datatype: date
    convert_tz: no
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  measure: total_client_meetings_target_number {
    type: sum
    sql: ${client_meetings_target_number} ;;
  }

  measure: total_closed_deals_new_clients_target_number {
    type: sum
    sql: ${closed_deals_new_clients_target_number} ;;
  }

  measure: total_closed_deals_renewal_clients_target_number {
    type: sum
    sql: ${closed_deals_renewal_clients_target_number} ;;
  }

  measure: total_closed_won_target_revenue {
    type: sum
    sql: ${closed_won_target_revenue} ;;
  }

  measure: total_closed_won_target_revenue_ben {
    type: sum
    sql: ${closed_won_target_revenue_ben} ;;
  }

  measure: total_closed_won_target_revenue_others {
    type: sum
    sql: ${closed_won_target_revenue_others} ;;
  }

  measure: total_deals_target_revenue {
    type: sum
    sql: ${deals_target_revenue} ;;
  }

  measure: total_new_deals_target_number {
    type: sum
    sql: ${new_deals_target_number} ;;
  }

  measure: total_new_mqls_target_number {
    type: sum
    sql: ${new_mqls_target_number} ;;
  }

  measure: total_target_revenue {
    type: sum
    hidden: yes
    sql: ${target_revenue} ;;
  }
}
