view: delivery_sprint_issue_history_fact {
  sql_table_name: `analytics.delivery_sprint_issue_history_fact` ;;

  # -------------------------------------------------------
  # Primary Key
  # -------------------------------------------------------

  dimension: delivery_sprint_issue_history_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.delivery_sprint_issue_history_pk ;;
  }

  # -------------------------------------------------------
  # Foreign Keys
  # -------------------------------------------------------

  dimension: delivery_project_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.delivery_project_fk ;;
  }

  dimension: delivery_task_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.delivery_task_fk ;;
  }

  dimension: contact_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_fk ;;
  }

  # -------------------------------------------------------
  # Issue & Sprint Identifiers
  # -------------------------------------------------------

  dimension: task_id {
    hidden: yes
    type: string
    sql: ${TABLE}.task_id ;;
  }

  dimension: project_id {
    hidden: yes
    type: string
    sql: ${TABLE}.project_id ;;
  }

  dimension: sprint_issue_day_id {
    hidden: yes
    type: string
    sql: ${TABLE}.sprint_issue_day_id ;;
  }

  dimension: issue_key {
    label: "Issue Key"
    description: "Jira issue key, e.g. RA-123"
    type: string
    sql: ${TABLE}.issue_key ;;
  }

  dimension: sprint_id {
    hidden: yes
    type: string
    sql: ${TABLE}.sprint_id ;;
  }

  dimension: sprint_name {
    label: "Sprint"
    description: "Name of the sprint"
    type: string
    sql: ${TABLE}.sprint_name ;;
  }

  dimension: board_id {
    hidden: yes
    type: number
    sql: ${TABLE}.board_id ;;
  }

  dimension: team {
    label: "Team"
    type: string
    sql: ${TABLE}.team ;;
  }

  # -------------------------------------------------------
  # Status
  # -------------------------------------------------------

  dimension: task_status {
    label: "Status"
    description: "Board status of the issue on this day"
    type: string
    sql: ${TABLE}.task_status ;;
  }

  dimension: task_status_workflow_stage_number {
    label: "Status Stage Number"
    description: "Numeric position in the workflow (1 = To Do … 12 = Done)"
    type: number
    sql: ${TABLE}.task_status_workflow_stage_number ;;
  }

  dimension: is_issue_open {
    label: "Is Open"
    description: "Whether the issue was open on this day"
    type: yesno
    sql: ${TABLE}.is_issue_open ;;
  }

  dimension: is_issue_resolved_in_sprint {
    label: "Resolved In Sprint"
    description: "Whether the issue was resolved within its sprint"
    type: yesno
    sql: ${TABLE}.is_issue_resolved_in_sprint ;;
  }

  # -------------------------------------------------------
  # Sprint State
  # -------------------------------------------------------

  dimension: is_sprint_active {
    label: "Sprint Is Active"
    type: yesno
    sql: ${TABLE}.is_sprint_active ;;
  }

  dimension: is_sprint_completed {
    label: "Sprint Is Completed"
    type: yesno
    sql: ${TABLE}.is_sprint_completed ;;
  }

  dimension: days_left_in_sprint {
    label: "Days Left in Sprint"
    type: number
    sql: ${TABLE}.days_left_in_sprint ;;
  }

  # -------------------------------------------------------
  # Dates
  # -------------------------------------------------------

  dimension_group: date {
    label: "Date"
    description: "Calendar date of this issue status snapshot"
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_day ;;
  }

  dimension_group: sprint_started {
    label: "Sprint Started"
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    sql: ${TABLE}.sprint_started_at ;;
  }

  dimension_group: sprint_ended {
    label: "Sprint Ended"
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    sql: ${TABLE}.sprint_ended_at ;;
  }

  dimension_group: sprint_completed {
    label: "Sprint Completed"
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    sql: ${TABLE}.sprint_completed_at ;;
  }

  dimension_group: issue_created {
    label: "Issue Created"
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    sql: ${TABLE}.issue_created_at ;;
  }

  dimension_group: issue_resolved {
    label: "Issue Resolved"
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    sql: ${TABLE}.issue_resolved_at ;;
  }

  # -------------------------------------------------------
  # Assignee
  # -------------------------------------------------------

  dimension: assignee_name {
    label: "Assignee"
    type: string
    sql: ${TABLE}.assignee_name ;;
  }

  # -------------------------------------------------------
  # Measures — Story Points (core burndown metrics)
  # -------------------------------------------------------

  measure: total_story_points_committed {
    label: "Story Points Committed"
    description: "Total story points assigned to the sprint (scope line)"
    type: sum
    sql: ${TABLE}.story_points ;;
    value_format_name: decimal_1
  }

  measure: total_story_points_remaining {
    label: "Story Points Remaining"
    description: "Story points still open — the burndown line"
    type: sum
    sql: ${TABLE}.story_points_remaining ;;
    value_format_name: decimal_1
  }

  measure: total_story_points_completed {
    label: "Story Points Completed"
    description: "Story points resolved — the burn-up line"
    type: sum
    sql: ${TABLE}.story_points_completed ;;
    value_format_name: decimal_1
  }

  measure: pct_story_points_complete {
    label: "% Story Points Complete"
    description: "Proportion of sprint scope completed"
    type: number
    sql: safe_divide(${total_story_points_completed}, nullif(${total_story_points_committed}, 0)) ;;
    value_format_name: percent_1
  }

  # -------------------------------------------------------
  # Measures — Issue Counts (count-based burndown)
  # -------------------------------------------------------

  measure: total_issues {
    label: "Issues (Total)"
    description: "Total issues in scope on this day"
    type: count_distinct
    sql: ${delivery_sprint_issue_history_pk} ;;
  }

  measure: total_issues_open {
    label: "Issues Remaining"
    description: "Issues still open — count-based burndown line"
    type: sum
    sql: case when ${TABLE}.is_issue_open then 1 else 0 end ;;
  }

  measure: total_issues_resolved {
    label: "Issues Resolved"
    description: "Issues resolved — count-based burn-up line"
    type: sum
    sql: case when not ${TABLE}.is_issue_open then 1 else 0 end ;;
  }

  measure: total_issues_resolved_in_sprint {
    label: "Issues Resolved In Sprint"
    description: "Issues resolved within the bounds of their sprint"
    type: sum
    sql: case when ${TABLE}.is_issue_resolved_in_sprint then 1 else 0 end ;;
  }

  # -------------------------------------------------------
  # Measures — Time Estimates
  # -------------------------------------------------------

  measure: total_original_estimate_hours {
    label: "Original Estimate (hrs)"
    description: "Sum of original time estimates in hours"
    type: sum
    sql: ${TABLE}.original_estimate_seconds / 3600.0 ;;
    value_format_name: decimal_1
  }

  measure: total_remaining_estimate_hours {
    label: "Remaining Estimate (hrs)"
    description: "Sum of remaining time estimates in hours"
    type: sum
    sql: ${TABLE}.remaining_estimate_seconds / 3600.0 ;;
    value_format_name: decimal_1
  }

  measure: total_time_spent_hours {
    label: "Time Spent (hrs)"
    description: "Sum of time logged in hours"
    type: sum
    sql: ${TABLE}.time_spent_seconds / 3600.0 ;;
    value_format_name: decimal_1
  }

  measure: total_to_do {
    label: "To Do"
    group_label: "Issues by Status"
    type: sum
    sql: case when ${TABLE}.task_status = 'To Do' then 1 else 0 end ;;
  }

  measure: total_in_progress {
    label: "In Progress"
    group_label: "Issues by Status"
    type: sum
    sql: case when ${TABLE}.task_status = 'In Progress' then 1 else 0 end ;;
  }

  measure: total_blocked {
    label: "Blocked"
    group_label: "Issues by Status"
    type: sum
    sql: case when ${TABLE}.task_status = 'Blocked' then 1 else 0 end ;;
  }

  measure: total_in_qa {
    label: "In QA"
    group_label: "Issues by Status"
    type: sum
    sql: case when ${TABLE}.task_status = 'In QA' then 1 else 0 end ;;
  }

  measure: total_in_client_qa {
    label: "In Client QA"
    group_label: "Issues by Status"
    type: sum
    sql: case when ${TABLE}.task_status = 'In Client QA' then 1 else 0 end ;;
  }

  measure: total_in_design {
    label: "Design & Validation"
    group_label: "Issues by Status"
    type: sum
    sql: case when ${TABLE}.task_status = 'Design & Validation' then 1 else 0 end ;;
  }

  measure: total_revision_required {
    label: "Revision Required"
    group_label: "Issues by Status"
    type: sum
    sql: case when ${TABLE}.task_status = 'Revision Required' then 1 else 0 end ;;
  }

  measure: total_failed_internal_qa {
    label: "Failed Internal QA"
    group_label: "Issues by Status"
    type: sum
    sql: case when ${TABLE}.task_status = 'Failed Internal QA' then 1 else 0 end ;;
  }

  measure: total_failed_client_qa {
    label: "Failed Client QA"
    group_label: "Issues by Status"
    type: sum
    sql: case when ${TABLE}.task_status = 'Failed Client QA/QA Comment' then 1 else 0 end ;;
  }

  measure: total_done {
    label: "Done"
    group_label: "Issues by Status"
    type: sum
    sql: case when ${TABLE}.task_status in ('Done','Done/Passed Client QA','Published') then 1 else 0 end ;;
  }
}
