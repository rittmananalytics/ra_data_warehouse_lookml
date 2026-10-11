view: delivery_tasks_fact {
  derived_table: {
    sql: SELECT
              *,
              MIN(task_start_ts) OVER (PARTITION BY delivery_project_fk, epic_name) AS epic_start_ts,
              MAX(task_end_ts)   OVER (PARTITION BY delivery_project_fk, epic_name) AS epic_end_ts
            FROM analytics.delivery_tasks_fact ;;
  }

  dimension: contact_pk {
    hidden: yes
    sql: ${TABLE}.contact_fk ;;
  }

  dimension: days_to_complete {
    group_label: "Project Tasks"
    sql: CASE
        WHEN ${task_status} not in ('Done','Completed','DONE')
          THEN TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), ${TABLE}.task_start_ts, DAY)
        ELSE
          TIMESTAMP_DIFF(${TABLE}.task_completed_ts, ${TABLE}.task_start_ts, DAY)
      END ;;
  }

  dimension: deliverable_category {
    group_label: "Project Tasks"
    sql: CASE
        WHEN ${TABLE}.deliverable_category IS NULL
         AND SUBSTR(${deliverable_id}, LENGTH(${deliverable_id}) - 2, 1) = 'a'
          THEN 'Historical'
        WHEN ${TABLE}.deliverable_category IS NULL
         AND SAFE_CAST(SUBSTR(${deliverable_id}, LENGTH(${deliverable_id}) - 2, 1) AS INT64) IS NOT NULL
          THEN 'NetSuite'
        WHEN ${TABLE}.deliverable_category IN ('Historical Data', 'Historic')
          THEN 'Historical'
        WHEN LOWER(${task_name}) LIKE '%historic%'
          THEN 'Historical'
        ELSE 'NetSuite'
      END ;;
  }

  dimension: deliverable_id {
    group_label: "Project Tasks"
    sql: ${TABLE}.deliverable_id ;;
  }

  dimension: deliverable_type {
    group_label: "Project Tasks"
    sql: ${TABLE}.deliverable_type ;;
  }

  dimension: delivery_project_fk {
    hidden: yes
    sql: ${TABLE}.delivery_project_fk ;;
  }

  dimension: delivery_task_pk {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.delivery_task_pk ;;
  }

  dimension: epic_name {
    group_label: "Project Tasks"
    sql: ${TABLE}.epic_name ;;
  }

  dimension: parent_task_id {
    hidden: yes
    sql: ${TABLE}.parent_task_id ;;
  }

  dimension: sprint_board_url {
    hidden: yes
    sql: ${TABLE}.sprint_board_url ;;
  }

  dimension: sprint_name {
    group_label: "Project Tasks"
    sql: ${TABLE}.sprint_name ;;
  }

  dimension: task_assignee_user_id {
    hidden: yes
    sql: ${TABLE}.task_assignee_user_id ;;
  }

  dimension: task_creator_user_id {
    hidden: yes
    sql: ${TABLE}.task_creator_user_id ;;
  }

  dimension: task_days_open {
    group_label: "Project Tasks"
    sql: CASE
        WHEN ${task_status} != 'Done'
          THEN TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), ${TABLE}.task_start_ts, DAY)
      END ;;
  }

  dimension: task_description {
    group_label: "Project Tasks"
    sql: ${TABLE}.task_description ;;
  }

  dimension: task_id {
    sql: ${TABLE}.task_id ;;
  }

  dimension: task_is_completed {
    group_label: "Project Tasks"
    sql: ${TABLE}.task_is_completed ;;
  }

  dimension: task_is_latest_sprint_version {
    sql: ${TABLE}.is_latest_task_version ;;
  }

  dimension: task_name {
    group_label: "Project Tasks"
    sql: ${TABLE}.task_name ;;
  }

  dimension: task_sprint_day {
    hidden: yes
    sql: TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), ${TABLE}.task_start_ts, DAY) ;;
  }

  dimension: task_status {
    group_label: "Project Tasks"
    sql: ${TABLE}.task_status ;;
    order_by_field: task_status_workflow_stage_number
  }

  dimension: task_status_colour {
    group_label: "Project Tasks"
    sql: ${TABLE}.task_status_colour ;;
  }

  dimension: task_status_workflow_stage_number {
    group_label: "Project Tasks"
    hidden: yes
    sql: COALESCE(${TABLE}.task_status_workflow_stage_number, 8) ;;
  }

  dimension: task_story_points {
    group_label: "Project Tasks"
    sql: ${TABLE}.task_story_points ;;
  }

  dimension: task_target_status_delivery_day_target {
    group_label: "Project Tasks"
    sql: CASE
        WHEN ${task_status} = 'Design & Validation' THEN 1
        WHEN ${task_status} = 'Blocked' THEN 3
        WHEN ${task_status} = 'In Progress' THEN 6
        WHEN ${task_status} = 'In QA' THEN 7
        WHEN ${task_status} = 'Add to Looker' THEN 7
        WHEN ${task_status} = 'Looker Internal QA' THEN 7
        WHEN ${task_status} = 'Failed Client QA/QA Comment' THEN 8
        WHEN ${task_status} = 'Client QA' THEN 8
      END ;;
  }

  dimension: task_type {
    group_label: "Project Tasks"
    sql: ${TABLE}.task_type ;;
  }

  dimension: task_url {
    hidden: yes
    sql: ${TABLE}.task_url ;;
  }

  dimension: total_delivery_subtasks {
    group_label: "Project Tasks"
    hidden: yes
    sql: ${TABLE}.total_delivery_subtasks ;;
  }

  dimension_group: epic_end {
    type: time
    timeframes: [raw, date, week, month, month_num]
    group_label: "Project Tasks"
    sql: ${TABLE}.epic_end_ts ;;
  }

  dimension_group: epic_start {
    type: time
    timeframes: [raw, date, week, month, month_num]
    group_label: "Project Tasks"
    sql: ${TABLE}.epic_start_ts ;;
  }

  dimension_group: sprint_start {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.sprint_started_ts ;;
  }

  dimension_group: task_completed_ts {
    type: time
    timeframes: [raw, date, month]
    label: "Task Completed"
    sql: ${TABLE}.task_completed_ts ;;
  }

  dimension_group: task_created_ts {
    type: time
    timeframes: [raw, date, week, month]
    label: "Task Created"
    sql: ${TABLE}.task_created_ts ;;
  }

  dimension_group: task_due {
    type: time
    timeframes: [raw, date]
    group_label: "Project Tasks"
    sql: ${TABLE}.task_due_ts ;;
  }

  dimension_group: task_end_ts {
    type: time
    timeframes: [raw, date, week, month, year, month_num]
    group_label: "Project Tasks"
    sql: ${TABLE}.task_end_ts ;;
  }

  dimension_group: task_last_modified_ts {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    hidden: yes
    sql: ${TABLE}.task_last_modified_ts ;;
  }

  dimension_group: task_start_ts {
    type: time
    timeframes: [raw, date, week, month, month_num]
    group_label: "Project Tasks"
    hidden: yes
    sql: ${TABLE}.task_start_ts ;;
  }

  dimension_group: task_target_ts {
    type: time
    timeframes: [raw, date]
    group_label: "Project Tasks"
    sql: TIMESTAMP_ADD(${TABLE}.task_start_ts, INTERVAL ${task_target_status_delivery_day_target} DAY) ;;
  }

  dimension_group: task_work_started {
    type: time
    timeframes: [raw, date, week, month, month_num]
    group_label: "Project Tasks"
    sql: ${TABLE}.task_work_started_ts ;;
  }

  measure: avg_task_days_open {
    type: average
    group_label: "Project Tasks"
    sql: ${task_days_open} ;;
  }

  measure: avg_task_hours_to_complete {
    type: average
    group_label: "Project Tasks"
    sql: (${TABLE}.total_task_hours_to_complete) ;;
  }

  measure: count {
    type: count
    drill_fields: [delivery_tasks_fact.task_name]
  }

  measure: total_delivery_tasks {
    type: sum
    group_label: "Project Tasks"
    sql: COALESCE(${TABLE}.total_to_do, 0)
      + COALESCE(${TABLE}.total_in_add_to_looker, 0)
      + COALESCE(${TABLE}.total_in_design, 0)
      + COALESCE(${TABLE}.total_completed, 0)
      + COALESCE(${TABLE}.total_in_progress, 0)
      + COALESCE(${TABLE}.total_blocked, 0)
      + COALESCE(${TABLE}.total_in_client_qa, 0) ;;
  }

  measure: total_delivery_tasks_blocked {
    type: sum
    group_label: "Project Tasks"
    sql: COALESCE(${TABLE}.total_blocked, 0) ;;
  }

  measure: total_delivery_tasks_completed {
    type: sum
    group_label: "Project Tasks"
    sql: COALESCE(${TABLE}.total_completed, 0) ;;
  }

  measure: total_delivery_tasks_failed_client_qa {
    type: sum
    group_label: "Project Tasks"
    hidden: yes
    sql: COALESCE(${TABLE}.total_failed_client_qa, 0) ;;
  }

  measure: total_delivery_tasks_in_add_to_looker {
    type: sum
    group_label: "Project Tasks"
    hidden: yes
    sql: COALESCE(${TABLE}.total_in_add_to_looker, 0) ;;
  }

  measure: total_delivery_tasks_in_client_qa {
    type: sum
    group_label: "Project Tasks"
    hidden: yes
    sql: COALESCE(${TABLE}.total_in_client_qa, 0) ;;
  }

  measure: total_delivery_tasks_in_design {
    type: sum
    group_label: "Project Tasks"
    hidden: yes
    sql: COALESCE(${TABLE}.total_in_design, 0) ;;
  }

  measure: total_delivery_tasks_in_looker_qa {
    type: sum
    group_label: "Project Tasks"
    hidden: yes
    sql: COALESCE(${TABLE}.total_in_looker_qa, 0) ;;
  }

  measure: total_delivery_tasks_in_progress {
    type: sum
    group_label: "Project Tasks"
    sql: COALESCE(${TABLE}.total_in_progress, 0) ;;
  }

  measure: total_delivery_tasks_in_qa {
    type: sum
    group_label: "Project Tasks"
    hidden: yes
    sql: COALESCE(${TABLE}.total_in_qa, 0) ;;
  }

  measure: total_delivery_tasks_to_do {
    type: sum
    group_label: "Project Tasks"
    sql: COALESCE(${TABLE}.total_to_do, 0) ;;
  }

  measure: total_failed_client_qa_comment {
    type: sum
    label: "Total Failed Client QA/QA Comment"
    group_label: "Project Tasks"
    hidden: yes
    sql: CASE WHEN ${task_status} = 'Failed Client QA/QA Comment' THEN 1 END ;;
  }

  measure: total_failed_internal_qa {
    type: sum
    group_label: "Project Tasks"
    hidden: yes
    sql: COALESCE(${TABLE}.total_failed_internal_qa, 0) ;;
  }

  measure: total_issues {
    type: sum
    group_label: "Project Tasks"
    sql: ${TABLE}.total_issues ;;
  }

  measure: total_issues_recent_or_open {
    type: sum
    sql: CASE
      WHEN ${task_completed_ts_date} IS NULL
        OR ${task_completed_ts_date} >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
      THEN 1
      ELSE NULL
    END ;;
  }

  measure: total_revision_required {
    type: sum
    group_label: "Project Tasks"
    hidden: yes
    sql: COALESCE(${TABLE}.total_revision_required, 0) ;;
  }

  measure: total_started {
    type: sum
    group_label: "Project Tasks"
    description: "Count of tasks that were started"
    sql: COALESCE(${TABLE}.total_completed_within_same_sprint, 0) + COALESCE((COALESCE(${TABLE}.total_started_but_not_completed, 0)), 0) ;;
  }

  measure: total_started_and_completed {
    type: sum
    group_label: "Project Tasks"
    description: "Count of tasks that were started and completed in the same sprint"
    sql: COALESCE(${TABLE}.total_completed_within_same_sprint, 0) ;;
  }

  measure: total_started_but_not_completed {
    type: sum
    group_label: "Project Tasks"
    description: "Count of tasks that were started but not completed"
    sql: COALESCE(${TABLE}.total_started_but_not_completed, 0) ;;
  }

  measure: total_task_hours_to_complete {
    type: sum
    group_label: "Project Tasks"
    sql: ${TABLE}.total_task_hours_to_complete ;;
  }

  measure: total_task_story_points {
    type: sum
    group_label: "Project Tasks"
    sql: COALESCE(${task_story_points}, 0) ;;
  }
}
