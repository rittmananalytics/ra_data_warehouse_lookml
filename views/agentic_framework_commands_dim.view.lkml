view: agentic_framework_commands_dim {
  sql_table_name: `ra-development.analytics.agentic_framework_commands_dim` ;;

  dimension: agentic_framework_command_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.agentic_framework_command_pk ;;
  }

  dimension: command_name {
    label: "Command"
    type: string
    sql: ${TABLE}.command_name ;;
  }

  dimension: artifact_name {
    label: "Artifact"
    group_label: "Command Breakdown"
    type: string
    sql: ${TABLE}.artifact_name ;;
  }

  dimension: action_name {
    label: "Action"
    group_label: "Command Breakdown"
    type: string
    sql: ${TABLE}.action_name ;;
  }

  dimension: phase_name {
    label: "Phase"
    group_label: "Command Breakdown"
    type: string
    sql: ${TABLE}.phase_name ;;
  }

  dimension: is_autopilot_command {
    label: "Is Autopilot Command"
    type: yesno
    sql: ${TABLE}.is_autopilot_command ;;
  }

  dimension: command_category {
    label: "Category"
    type: string
    sql: ${TABLE}.command_category ;;
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
