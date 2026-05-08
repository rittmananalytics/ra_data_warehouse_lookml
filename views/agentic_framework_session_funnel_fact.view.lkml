view: agentic_framework_session_funnel_fact {
  sql_table_name: `ra-development.analytics.agentic_framework_session_funnel_fact` ;;

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: CAST(${TABLE}.week_commencing AS STRING) ;;
  }

  # Cast DATE → TIMESTAMP so Looker's date_filter emits TIMESTAMP >= TIMESTAMP,
  # which BigQuery accepts. Without the cast BigQuery rejects DATE >= TIMESTAMP.
  dimension_group: week_commencing {
    type: time
    timeframes: [date, week, month, year]
    sql: CAST(${TABLE}.week_commencing AS TIMESTAMP) ;;
    label: "Week Commencing"
  }

  dimension: total_sessions {
    label: "Total Sessions"
    type: number
    sql: ${TABLE}.total_sessions ;;
  }

  dimension: reached_started {
    label: "Started"
    group_label: "Funnel Stages"
    type: number
    sql: ${TABLE}.reached_started ;;
  }

  dimension: reached_2nd_command {
    label: "Reached 2nd Command"
    group_label: "Funnel Stages"
    type: number
    sql: ${TABLE}.reached_2nd_command ;;
  }

  dimension: reached_3plus_phases {
    label: "Reached 3+ Phases"
    group_label: "Funnel Stages"
    type: number
    sql: ${TABLE}.reached_3plus_phases ;;
  }

  dimension: reached_autopilot {
    label: "Reached Autopilot"
    group_label: "Funnel Stages"
    type: number
    sql: ${TABLE}.reached_autopilot ;;
  }

  dimension: reached_pr_merged {
    label: "PR Merged"
    group_label: "Funnel Stages"
    type: number
    sql: ${TABLE}.reached_pr_merged ;;
  }

  dimension: pct_reached_2nd_command {
    label: "% Reached 2nd Command"
    group_label: "Funnel %"
    type: number
    sql: ${TABLE}.pct_reached_2nd_command ;;
    value_format_name: percent_1
  }

  dimension: pct_reached_3plus_phases {
    label: "% Reached 3+ Phases"
    group_label: "Funnel %"
    type: number
    sql: ${TABLE}.pct_reached_3plus_phases ;;
    value_format_name: percent_1
  }

  dimension: pct_reached_autopilot {
    label: "% Reached Autopilot"
    group_label: "Funnel %"
    type: number
    sql: ${TABLE}.pct_reached_autopilot ;;
    value_format_name: percent_1
  }

  dimension: pct_reached_pr_merged {
    label: "% Reached PR Merged"
    group_label: "Funnel %"
    type: number
    sql: ${TABLE}.pct_reached_pr_merged ;;
    value_format_name: percent_1
  }

  measure: avg_pct_2nd_command {
    type: average
    sql: ${pct_reached_2nd_command} ;;
    label: "Avg % → 2nd Command"
    value_format_name: percent_1
  }

  measure: avg_pct_autopilot {
    type: average
    sql: ${pct_reached_autopilot} ;;
    label: "Avg % → Autopilot"
    value_format_name: percent_1
  }

  measure: count {
    type: count
    label: "Weeks"
  }
}
