view: developer_users_dim {
  sql_table_name: `ra-development.analytics.developer_users_dim` ;;

  dimension: developer_user_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.developer_user_pk ;;
  }

  dimension: consultant_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.consultant_fk ;;
  }

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

  # Wire (Agentic Framework) stats
  dimension: agentic_framework_first_active_week {
    label: "Wire First Active Week"
    group_label: "Wire Activity"
    type: date
    sql: ${TABLE}.agentic_framework_first_active_week ;;
  }

  dimension: agentic_framework_last_active_week {
    label: "Wire Last Active Week"
    group_label: "Wire Activity"
    type: date
    sql: ${TABLE}.agentic_framework_last_active_week ;;
  }

  dimension: agentic_framework_days_since_last {
    label: "Wire Days Since Last"
    group_label: "Wire Activity"
    type: number
    sql: ${TABLE}.agentic_framework_days_since_last ;;
  }

  dimension: agentic_framework_lifetime_active_days {
    label: "Wire Lifetime Active Days"
    group_label: "Wire Activity"
    type: number
    sql: ${TABLE}.agentic_framework_lifetime_active_days ;;
  }

  dimension: agentic_framework_lifetime_commands {
    label: "Wire Lifetime Commands"
    group_label: "Wire Activity"
    type: number
    sql: ${TABLE}.agentic_framework_lifetime_commands ;;
  }

  dimension: agentic_framework_aha_week_commencing {
    label: "Wire Aha Week"
    group_label: "Wire Activity"
    type: date
    sql: ${TABLE}.agentic_framework_aha_week_commencing ;;
  }

  dimension: agentic_framework_days_to_aha {
    label: "Wire Days to Aha"
    group_label: "Wire Activity"
    type: number
    sql: ${TABLE}.agentic_framework_days_to_aha ;;
  }

  dimension: agentic_framework_lifecycle_stage {
    label: "Wire Lifecycle Stage"
    group_label: "Wire Activity"
    type: string
    sql: ${TABLE}.agentic_framework_lifecycle_stage ;;
  }

  # Claude Code stats
  dimension: coding_agent_first_active_week {
    label: "Claude Code First Active Week"
    group_label: "Claude Code Activity"
    type: date
    sql: ${TABLE}.coding_agent_first_active_week ;;
  }

  dimension: coding_agent_last_active_week {
    label: "Claude Code Last Active Week"
    group_label: "Claude Code Activity"
    type: date
    sql: ${TABLE}.coding_agent_last_active_week ;;
  }

  dimension: coding_agent_days_since_last {
    label: "Claude Code Days Since Last"
    group_label: "Claude Code Activity"
    type: number
    sql: ${TABLE}.coding_agent_days_since_last ;;
  }

  dimension: coding_agent_lifetime_active_days {
    label: "Claude Code Lifetime Active Days"
    group_label: "Claude Code Activity"
    type: number
    sql: ${TABLE}.coding_agent_lifetime_active_days ;;
  }

  dimension: coding_agent_lifetime_prompts {
    label: "Claude Code Lifetime Prompts"
    group_label: "Claude Code Activity"
    type: number
    sql: ${TABLE}.coding_agent_lifetime_prompts ;;
  }

  dimension: coding_agent_lifetime_slash_commands {
    label: "Claude Code Lifetime Slash Commands"
    group_label: "Claude Code Activity"
    type: number
    sql: ${TABLE}.coding_agent_lifetime_slash_commands ;;
  }

  dimension: coding_agent_lifetime_agentic_framework_slash_commands {
    label: "Wire Slash Commands via Claude Code"
    group_label: "Claude Code Activity"
    type: number
    sql: ${TABLE}.coding_agent_lifetime_agentic_framework_slash_commands ;;
  }

  # Cross-tool
  dimension: cross_tool_stage {
    label: "Cross-Tool Stage"
    description: "Combined lifecycle stage across Wire and Claude Code (e.g. wire_active_cc_active, wire_dormant_cc_active)"
    type: string
    sql: ${TABLE}.cross_tool_stage ;;
  }

  measure: count {
    type: count
    label: "Consultants"
  }

  measure: avg_wire_active_days {
    type: average
    sql: ${agentic_framework_lifetime_active_days} ;;
    label: "Avg Wire Active Days"
    value_format_name: decimal_1
  }

  measure: avg_cc_active_days {
    type: average
    sql: ${coding_agent_lifetime_active_days} ;;
    label: "Avg Claude Code Active Days"
    value_format_name: decimal_1
  }

  measure: avg_cc_lifetime_prompts {
    type: average
    sql: ${coding_agent_lifetime_prompts} ;;
    label: "Avg Lifetime Prompts"
    value_format_name: decimal_0
  }
}
