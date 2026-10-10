view: delivery_kpis {
  sql_table_name: `ra-development.analytics.delivery_kpis` ;;

  dimension: cost_of_delivery_pct {
    type: number
    label: "cost_of_delivery_pct"
    sql: ${TABLE}.cost_of_delivery_pct ;;
  }

  dimension: del_05_recognized_revenue_gbp {
    type: number
    label: "del_05_recognized_revenue_gbp"
    sql: ${TABLE}.del_05_recognized_revenue_gbp ;;
  }

  dimension: del_05_revenue_target {
    type: number
    label: "del_05_revenue_target"
    sql: ${TABLE}.del_05_revenue_target ;;
  }

  dimension: delivery_revenue_vs_target_pct {
    type: number
    label: "delivery_revenue_vs_target_pct"
    sql: ${TABLE}.delivery_revenue_vs_target_pct ;;
  }

  dimension: projects_delivered_ontime_pct {
    type: number
    label: "projects_delivered_ontime_pct"
    sql: ${TABLE}.projects_delivered_ontime_pct ;;
  }

  dimension: red_engagements_count {
    type: number
    label: "red_engagements_count"
    sql: ${TABLE}.red_engagements_count ;;
  }

  dimension: team_billable_utilisation_pct {
    type: number
    label: "team_billable_utilisation_pct"
    sql: ${TABLE}.team_billable_utilisation_pct ;;
  }

  dimension_group: report_month {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    datatype: date
    convert_tz: no
    label: "report_month"
    sql: ${TABLE}.report_month ;;
  }

  measure: total_cost_of_delivery_pct {
    type: sum
    label: "cost_of_delivery_pct (sum)"
    sql: ${cost_of_delivery_pct} ;;
  }
}
