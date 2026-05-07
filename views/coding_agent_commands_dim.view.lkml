view: coding_agent_commands_dim {
  sql_table_name: `ra-development.analytics.coding_agent_commands_dim` ;;

  dimension: coding_agent_command_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.coding_agent_command_pk ;;
  }

  dimension: command_raw {
    label: "Command (raw)"
    type: string
    sql: ${TABLE}.command_raw ;;
  }

  dimension: namespace {
    label: "Namespace"
    group_label: "Command Breakdown"
    type: string
    sql: ${TABLE}.namespace ;;
  }

  dimension: command_name {
    label: "Command Name"
    group_label: "Command Breakdown"
    type: string
    sql: ${TABLE}.command_name ;;
  }

  dimension: is_agentic_framework_command {
    label: "Is Wire Command"
    type: yesno
    sql: ${TABLE}.is_agentic_framework_command ;;
  }

  dimension: is_builtin {
    label: "Is Built-In"
    type: yesno
    sql: ${TABLE}.is_builtin ;;
  }

  dimension_group: first_seen {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.first_seen_ts ;;
    label: "First Seen"
    datatype: timestamp
  }

  dimension_group: last_seen {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.last_seen_ts ;;
    label: "Last Seen"
    datatype: timestamp
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

  measure: count {
    type: count
    label: "Commands in Catalog"
  }

  measure: total_invocations_sum {
    type: sum
    sql: ${total_invocations} ;;
    label: "Total Invocations"
  }
}
