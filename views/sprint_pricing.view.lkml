view: sprint_pricing {
  derived_table: {
    sql: SELECT * FROM `ra-development.analytics_seed.sprint_pricing`
      ;;
  }



  dimension: company_name {
    type: string
    sql: ${TABLE}.company_name ;;
  }

  dimension: sprint_type {
    type: string
    sql: ${TABLE}.sprint_type ;;
  }

  dimension: total_sprints {
    type: number
    sql: ${TABLE}.total_sprints ;;
  }

  dimension_group : proposal_ts {
    type: time
    timeframes: [month,quarter,year]
    datatype: date
    sql: ${TABLE}.proposal_ts ;;
  }

  dimension: amount_gbp {
    type: number
    sql: ${TABLE}.amount_gbp ;;
  }

  dimension: is_accepted {
    type: yesno
    sql: ${TABLE}.is_accepted ;;
  }

  set: detail {
    fields: [
      company_name,
      sprint_type,
      total_sprints,
      proposal_ts,
      amount_gbp,
      is_accepted
    ]
  }
}
