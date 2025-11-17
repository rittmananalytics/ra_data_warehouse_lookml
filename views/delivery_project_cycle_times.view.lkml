view: delivery_project_cycle_times {
  sql_table_name: ra-development.analytics.cycle_times_all ;;


measure: count {
  type: count
  drill_fields: [detail*]
}

dimension: issue_key {
  type: string
  primary_key: yes
  sql: ${TABLE}.issue_key ;;
}

dimension: issue_id {
  type: number
  sql: ${TABLE}.issue_id ;;
}

dimension: client_name {
  type: string
  sql: ${project_name} ;;
}

dimension: assignee_name {
  type: string
  sql: ${TABLE}.assignee_name ;;
}

dimension: sprint_id {
  type: string
  sql: ${TABLE}.sprint_id ;;
}

dimension: sprint_name {
  type: string
  sql: ${TABLE}.sprint_name ;;
}

dimension: project_name {
  type: string
  sql: ${TABLE}.project_name ;;
}

dimension_group: issue_created_at {
  type: time
  sql: ${TABLE}.issue_created_at ;;
}

dimension: first_issue_status {
  type: string
  sql: ${TABLE}.first_issue_status ;;
}

dimension: story_points_cycle_start {
  type: number
  sql: ${TABLE}.story_points_cycle_start ;;
}

dimension: story_point_estimate_cycle_start {
  type: number
  sql: ${TABLE}.story_point_estimate_cycle_start ;;
}

dimension_group: cycle_start_day {
  type: time
  datatype: timestamp
  sql: timestamp(${TABLE}.cycle_start_day) ;;
}

dimension: cycle_start_status {
  type: string
  sql: ${TABLE}.cycle_start_status ;;
}

dimension: cycle_complete_day {
  type: date
  datatype: date
  sql: ${TABLE}.cycle_complete_day ;;
}

dimension: cycle_complete_status {
  type: string
  sql: ${TABLE}.cycle_complete_status ;;
}

dimension: total_cycle_days {
  type: number
  hidden: yes

  sql: ${TABLE}.total_cycle_days ;;
}

measure: avg_cycle_days {
  type: average
  value_format_name: decimal_1

  sql: ${total_cycle_days} ;;
}

dimension: cycle_days_per_story_point {
  type: number
  hidden: yes

  sql: ${TABLE}.cycle_days_per_story_point ;;
}

measure: avg_cycle_days_per_story_point {
  type: average
  value_format_name: decimal_1
  sql: ${cycle_days_per_story_point} ;;
}

dimension: is_unpointed_issue {
  type: number
  hidden: yes

  sql: ${TABLE}.is_unpointed_issue ;;
}

measure: total_unpointed_issues {
  type: sum
  sql: ${is_unpointed_issue} ;;
}

dimension: is_notstarted_issue {
  type: number
  hidden: yes
  sql: ${TABLE}.is_notstarted_issue ;;
}

measure: total_assigned_not_started_issues {
  type: sum
  sql: ${is_notstarted_issue} ;;
}

dimension: is_incomplete_issue {
  type: number
  hidden: yes
  sql: ${TABLE}.is_incomplete_issue ;;
}

measure: total_started_incomplete_issues {
  type: sum
  sql: ${is_incomplete_issue} ;;
}

dimension: is_complete_issue {
  type: number
  hidden: yes
  sql: ${TABLE}.is_complete_issue ;;
}

measure: total_started_complete_issues {
  type: sum
  sql: ${is_complete_issue} ;;
}

measure: total_issues {
  type: count_distinct
  sql: ${issue_key} ;;
}



set: detail {
  fields: [
    issue_key,
    issue_id,
    assignee_name,
    sprint_id,
    sprint_name,
    project_name,
    issue_created_at_time,
    first_issue_status,
    story_points_cycle_start,
    story_point_estimate_cycle_start,
    cycle_start_status,
    cycle_complete_day,
    cycle_complete_status,
    total_cycle_days,
    cycle_days_per_story_point,
    is_unpointed_issue,
    is_notstarted_issue,
    is_incomplete_issue
  ]
}
}
