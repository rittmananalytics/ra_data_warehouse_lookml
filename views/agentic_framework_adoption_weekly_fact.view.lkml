view: agentic_framework_adoption_weekly_fact {
  sql_table_name: `ra-development.analytics.agentic_framework_adoption_weekly_fact` ;;

  dimension: week_commencing {
    primary_key: yes
    label: "Week Commencing"
    type: date
    sql: ${TABLE}.week_commencing ;;
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

  dimension: active_days {
    label: "Active Days"
    type: number
    sql: ${TABLE}.active_days ;;
  }

  dimension: adoption_score {
    label: "Adoption Score"
    description: "Composite 0–100 score for Wire adoption in the week"
    type: number
    sql: ${TABLE}.adoption_score ;;
    value_format_name: decimal_1
  }

  dimension: score_active_days {
    label: "Score: Active Days"
    group_label: "Score Components"
    type: number
    sql: ${TABLE}.score_active_days ;;
    value_format_name: decimal_1
  }

  dimension: score_command_volume {
    label: "Score: Command Volume"
    group_label: "Score Components"
    type: number
    sql: ${TABLE}.score_command_volume ;;
    value_format_name: decimal_1
  }

  dimension: score_phase_breadth {
    label: "Score: Phase Breadth"
    group_label: "Score Components"
    type: number
    sql: ${TABLE}.score_phase_breadth ;;
    value_format_name: decimal_1
  }

  dimension: score_autopilot {
    label: "Score: Autopilot"
    group_label: "Score Components"
    type: number
    sql: ${TABLE}.score_autopilot ;;
    value_format_name: decimal_1
  }

  dimension: score_prs_merged {
    label: "Score: PRs Merged"
    group_label: "Score Components"
    type: number
    sql: ${TABLE}.score_prs_merged ;;
    value_format_name: decimal_1
  }

  dimension: score_supplement {
    label: "Score: Supplement"
    group_label: "Score Components"
    type: number
    sql: ${TABLE}.score_supplement ;;
    value_format_name: decimal_1
  }

  measure: avg_adoption_score {
    type: average
    sql: ${adoption_score} ;;
    label: "Avg Adoption Score"
    value_format_name: decimal_1
  }

  measure: max_adoption_score {
    type: max
    sql: ${adoption_score} ;;
    label: "Max Adoption Score"
    value_format_name: decimal_1
  }

  measure: avg_active_days {
    type: average
    sql: ${active_days} ;;
    label: "Avg Active Days"
    value_format_name: decimal_1
  }

  measure: count {
    type: count
    label: "Consultant-Weeks"
  }
}
