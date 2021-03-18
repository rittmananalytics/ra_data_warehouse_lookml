view: payment_summary {
  sql_table_name: `{{ _user_attributes['dataset'] }}.ra-development.rob_training.payment_summary`
    ;;

  dimension: interest_rate {
    type: number
    sql: ${TABLE}.interest_rate ;;
  }

  dimension: overpayment_percent {
    type: number
    sql: ${TABLE}.overpayment_percent ;;
  }

  dimension: max_balance {
    type: number
    value_format_name: "gbp"
    sql: ${TABLE}.max_balance ;;
  }

  dimension: principal_amount {
    type: number
    sql: ${TABLE}.principal_amount ;;
  }

  dimension: salary {
    type: number
    value_format_name: "gbp"
    sql: ${TABLE}.salary ;;
  }

  dimension: salary_progression_type {
    type: string
    sql: ${TABLE}.salary_progression_type ;;
  }

  dimension: scenario_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.scenario_id ;;
  }

  dimension: payment_strategy {
    type: string
    sql: ${TABLE}.payment_strategy ;;
  }

  measure: total_interest_paid {
    type: sum
    value_format_name: "gbp"
    sql: ${TABLE}.total_interest_paid ;;
  }

  measure: total_paid {
    type: sum
    value_format_name: "gbp"
    sql: ${TABLE}.total_paid ;;
  }

  measure: avg_total_paid {
    type: average
    value_format_name: "gbp"
    sql: ${TABLE}.total_paid ;;
  }

  measure: total_years_till_paid_off {
    type: sum
    sql: ${TABLE}.years_till_paid_off ;;
  }

  measure: avg_years_till_paid_off {
    type: average
    sql: ${TABLE}.years_till_paid_off ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}