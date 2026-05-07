view: agentic_framework_user_retention_cohorts_fact {
  sql_table_name: `ra-development.analytics.agentic_framework_user_retention_cohorts_fact` ;;

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

  dimension: active_consultants {
    label: "Active Consultants"
    type: number
    sql: ${TABLE}.active_consultants ;;
  }

  measure: count {
    type: count
    label: "Cohort-Week Records"
  }

  # max is equivalent to the value itself at (cohort_week, weeks_since_cohort) grain;
  # must be a measure so Looker can use it as a pivot cell value.
  measure: pct_retained {
    type: max
    sql: ${TABLE}.pct_retained ;;
    label: "% Retained"
    value_format_name: percent_1
  }

  measure: avg_retention_pct {
    type: average
    sql: ${TABLE}.pct_retained ;;
    label: "Avg Retention %"
    value_format_name: percent_1
  }

  measure: total_cohort_size {
    type: max
    sql: ${cohort_size} ;;
    label: "Cohort Size"
  }
}
