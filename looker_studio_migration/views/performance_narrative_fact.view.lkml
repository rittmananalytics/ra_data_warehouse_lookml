view: performance_narrative_fact {
  sql_table_name: `ra-development.analytics.performance_narrative_fact` ;;

  dimension: delivery_summary {
    type: string
    label: "delivery_summary"
    sql: ${TABLE}.delivery_summary ;;
  }

  dimension: finance_summary {
    type: string
    label: "finance_summary"
    sql: ${TABLE}.finance_summary ;;
  }

  dimension: overall_summary {
    type: string
    label: "overall_summary"
    sql: ${TABLE}.overall_summary ;;
  }

  dimension: sales_marketing_summary {
    type: string
    label: "sales_marketing_summary"
    sql: ${TABLE}.sales_marketing_summary ;;
  }

  dimension_group: analysis_month {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    datatype: date
    convert_tz: no
    label: "analysis_month"
    sql: ${TABLE}.analysis_month ;;
  }
}
