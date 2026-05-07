view: coding_agent_user_retention_cohorts_fact {
  sql_table_name: `ra-development.analytics.coding_agent_user_retention_cohorts_fact` ;;

  dimension: cohort_week {
    label: "Cohort Week"
    type: date
    sql: ${TABLE}.cohort_week ;;
  }

  dimension: active_week {
    label: "Active Week"
    type: date
    sql: ${TABLE}.active_week ;;
  }

  dimension: weeks_since_cohort {
    label: "Weeks Since Cohort"
    type: number
    sql: ${TABLE}.weeks_since_cohort ;;
  }

  dimension: cohort_size {
    label: "Cohort Size"
    type: number
    sql: ${TABLE}.cohort_size ;;
  }

  dimension: active_users {
    label: "Active Users"
    type: number
    sql: ${TABLE}.active_users ;;
  }

  dimension: pct_retained {
    label: "% Retained"
    type: number
    sql: ${TABLE}.pct_retained ;;
    value_format_name: percent_1
  }

  measure: count {
    type: count
    label: "Cohort-Week Records"
  }

  measure: avg_retention_pct {
    type: average
    sql: ${pct_retained} ;;
    label: "Avg Retention %"
    value_format_name: percent_1
  }

  measure: total_cohort_size {
    type: max
    sql: ${cohort_size} ;;
    label: "Cohort Size"
  }
}
