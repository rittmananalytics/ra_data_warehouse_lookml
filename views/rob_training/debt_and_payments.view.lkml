view: debt_and_payments {
  sql_table_name: `ra-development.rob_training.debt_and_payments`
    ;;

  dimension: conditional_interest_rate {
    type: number
    sql: ${TABLE}.conditional_interest_rate ;;
  }

  dimension_group: date_year {
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
    sql: ${TABLE}.date_year ;;
  }

  dimension: interest_rate {
    type: number
    sql: ${TABLE}.interest_rate ;;
  }

  dimension: outstanding_balance {
    type: number
    sql: ${TABLE}.outstanding_balance ;;
  }

  dimension: paid_this_year {
    type: number
    sql: ${TABLE}.paid_this_year ;;
  }

  dimension: principal_amount {
    type: number
    sql: ${TABLE}.principal_amount ;;
  }

  dimension: salary {
    type: number
    sql: ${TABLE}.salary ;;
  }

  dimension: salary_scenario_id {
    type: string
    sql: ${TABLE}.salary_scenario_id ;;
  }

  dimension: scenario_id {
    type: string
    sql: ${TABLE}.scenario_id ;;
  }

  dimension: years_since_start {
    type: number
    sql: ${TABLE}.years_since_start ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
