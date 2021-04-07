view: targets {
  sql_table_name: `ra-development.analytics_seed.targets`
    ;;

  dimension: deals_closed_target {
    type: number
    sql: ${TABLE}.deals_closed_target ;;
  }

  dimension: deals_target {
    type: number
    sql: ${TABLE}.deals_target ;;
  }

  dimension: month {
    type: string
    sql: date_trunc(date(projects_invoiced.invoice_created_at_ts),${TABLE}.month) ;;
  }

  dimension: revenue_target {
    type: number
    sql: ${TABLE}.revenue_target ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
