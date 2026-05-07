view: agentic_framework_aha_moment_fact {
  sql_table_name: `ra-development.analytics.agentic_framework_aha_moment_fact` ;;

  dimension: consultant_email {
    primary_key: yes
    label: "Consultant Email"
    group_label: "Identity"
    type: string
    sql: ${TABLE}.consultant_email ;;
  }

  dimension: consultant_name {
    label: "Consultant"
    group_label: "Identity"
    type: string
    sql: ${TABLE}.consultant_name ;;
  }

  dimension: first_active_week {
    label: "First Active Week"
    type: date
    sql: ${TABLE}.first_active_week ;;
  }

  dimension: aha_week_commencing {
    label: "Aha Week"
    type: date
    sql: ${TABLE}.aha_week_commencing ;;
  }

  dimension: did_hit_aha {
    label: "Hit Aha Moment"
    type: yesno
    sql: ${TABLE}.did_hit_aha ;;
  }

  dimension: days_to_aha {
    label: "Days to Aha"
    type: number
    sql: ${TABLE}.days_to_aha ;;
  }

  dimension: lifetime_active_days {
    label: "Lifetime Active Days"
    type: number
    sql: ${TABLE}.lifetime_active_days ;;
  }

  dimension: lifetime_distinct_phases {
    label: "Lifetime Phases Used"
    type: number
    sql: ${TABLE}.lifetime_distinct_phases ;;
  }

  dimension: lifetime_autopilot_commands {
    label: "Lifetime Autopilot Commands"
    type: number
    sql: ${TABLE}.lifetime_autopilot_commands ;;
  }

  dimension: weeks_active_after_aha {
    label: "Weeks Active After Aha"
    type: number
    sql: ${TABLE}.weeks_active_after_aha ;;
  }

  dimension: lifecycle_stage {
    label: "Lifecycle Stage"
    type: string
    sql: ${TABLE}.lifecycle_stage ;;
  }

  # Days-to-aha bucketed for distribution chart
  dimension: days_to_aha_tier {
    label: "Days to Aha (Tier)"
    type: tier
    sql: ${days_to_aha} ;;
    tiers: [7, 14, 30, 60, 90]
    style: integer
  }

  measure: count {
    type: count
    label: "Consultants"
  }

  measure: pct_hit_aha {
    type: number
    sql: SAFE_DIVIDE(COUNTIF(${did_hit_aha}), COUNT(*)) ;;
    label: "% Hit Aha Moment"
    value_format_name: percent_1
  }

  measure: avg_days_to_aha {
    type: average
    sql: ${days_to_aha} ;;
    label: "Avg Days to Aha"
    filters: [did_hit_aha: "Yes"]
    value_format_name: decimal_1
  }

  measure: median_days_to_aha {
    type: median
    sql: ${days_to_aha} ;;
    label: "Median Days to Aha"
    filters: [did_hit_aha: "Yes"]
    value_format_name: decimal_0
  }

  measure: avg_weeks_after_aha {
    type: average
    sql: ${weeks_active_after_aha} ;;
    label: "Avg Weeks Active After Aha"
    filters: [did_hit_aha: "Yes"]
    value_format_name: decimal_1
  }
}
