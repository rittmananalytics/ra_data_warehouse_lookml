view: coding_agent_command_usage_fact {
  sql_table_name: `ra-development.analytics.coding_agent_command_usage_fact` ;;

  dimension: command_raw {
    primary_key: yes
    label: "Command (raw)"
    type: string
    sql: ${TABLE}.command_raw ;;
  }

  dimension: namespace {
    label: "Namespace"
    group_label: "Command"
    type: string
    sql: ${TABLE}.namespace ;;
  }

  dimension: command_name {
    label: "Command Name"
    group_label: "Command"
    type: string
    sql: ${TABLE}.command_name ;;
  }

  dimension: is_agentic_framework_command {
    label: "Is Wire Command"
    group_label: "Command"
    type: yesno
    sql: ${TABLE}.is_agentic_framework_command ;;
  }

  dimension: total_invocations {
    label: "Total Invocations"
    type: number
    sql: ${TABLE}.total_invocations ;;
  }

  dimension: distinct_users {
    label: "Distinct Users"
    type: number
    sql: ${TABLE}.distinct_users ;;
  }

  dimension: distinct_active_days {
    label: "Active Days"
    type: number
    sql: ${TABLE}.distinct_active_days ;;
  }

  dimension: distinct_active_weeks {
    label: "Active Weeks"
    type: number
    sql: ${TABLE}.distinct_active_weeks ;;
  }

  dimension_group: last_invoked {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.last_invoked_ts ;;
    label: "Last Invoked"
    datatype: timestamp
  }

  dimension: usage_rank {
    label: "Usage Rank"
    type: number
    sql: ${TABLE}.usage_rank ;;
  }

  measure: count {
    type: count
    label: "Commands"
  }

  measure: total_invocations_sum {
    type: sum
    sql: ${total_invocations} ;;
    label: "Total Invocations"
  }

  measure: total_distinct_users {
    type: max
    sql: ${distinct_users} ;;
    label: "Distinct Users"
  }
}
