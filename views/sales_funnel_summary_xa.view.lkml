view: sales_funnel_summary_xa {
  sql_table_name: `ra-development.analytics.sales_funnel_summary_xa`
    ;;

  dimension: company_pk {
    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension: event_type {
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: funnel_stage {
    type: number
    sql: ${TABLE}.funnel_stage ;;
  }

  dimension_group: funnel_stage_enter_ts {
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
    sql: ${TABLE}.funnel_stage_enter_ts ;;
  }

  dimension: hours_from_last_stage {
    type: number
    sql: ${TABLE}.hours_from_last_stage ;;
  }

  measure: avg_hours_from_last_stage {
    type: average
    sql: ${TABLE}.hours_from_last_stage ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
