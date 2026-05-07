view: agentic_framework_engagement_decay_fact {
  sql_table_name: `ra-development.analytics.agentic_framework_engagement_decay_fact` ;;

  dimension: consultant_email {
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

  dimension: week_commencing {
    primary_key: yes
    label: "Week Commencing"
    type: date
    sql: ${TABLE}.week_commencing ;;
  }

  dimension: days_active_last_7 {
    label: "Active Days (Last 7)"
    type: number
    sql: ${TABLE}.days_active_last_7 ;;
  }

  dimension: days_active_last_28 {
    label: "Active Days (Last 28)"
    type: number
    sql: ${TABLE}.days_active_last_28 ;;
  }

  dimension: is_active_7d {
    label: "Active (7d)"
    type: yesno
    sql: ${TABLE}.is_active_7d ;;
  }

  dimension: is_active_28d {
    label: "Active (28d)"
    type: yesno
    sql: ${TABLE}.is_active_28d ;;
  }

  dimension: activity_band_28d {
    label: "Activity Band (28d)"
    type: string
    sql: ${TABLE}.activity_band_28d ;;
  }

  dimension: current_lifecycle_stage {
    label: "Lifecycle Stage"
    type: string
    sql: ${TABLE}.current_lifecycle_stage ;;
  }

  dimension: aha_week_commencing {
    label: "Aha Week"
    type: date
    sql: ${TABLE}.aha_week_commencing ;;
  }

  dimension: days_since_last_command {
    label: "Days Since Last Command"
    type: number
    sql: ${TABLE}.days_since_last_command ;;
  }

  measure: count {
    type: count
    label: "Consultant-Weeks"
  }

  measure: active_consultants_7d {
    type: count_distinct
    sql: CASE WHEN ${is_active_7d} THEN ${consultant_email} END ;;
    label: "Active Consultants (7d)"
  }

  measure: active_consultants_28d {
    type: count_distinct
    sql: CASE WHEN ${is_active_28d} THEN ${consultant_email} END ;;
    label: "Active Consultants (28d)"
  }

  measure: avg_days_since_last {
    type: average
    sql: ${days_since_last_command} ;;
    label: "Avg Days Since Last Command"
    value_format_name: decimal_1
  }
}
