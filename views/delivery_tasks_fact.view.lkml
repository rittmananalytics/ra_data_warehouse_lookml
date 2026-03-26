view: delivery_tasks_fact {
  derived_table: {
    sql:
      SELECT
        *,
        MIN(task_start_ts) OVER (PARTITION BY delivery_project_fk, epic_name) AS epic_start_ts,
        MAX(task_end_ts)   OVER (PARTITION BY delivery_project_fk, epic_name) AS epic_end_ts
      FROM analytics.delivery_tasks_fact ;;
  }

  dimension: delivery_project_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.delivery_project_fk ;;
  }

  dimension: delivery_task_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.delivery_task_pk ;;
  }

  dimension: task_is_latest_sprint_version {
    type: yesno
    sql: ${TABLE}.is_latest_task_version ;;
  }

  dimension: parent_task_id {
    hidden: yes
    type: string
    sql: ${TABLE}.parent_task_id ;;
  }

  dimension: task_assignee_user_id {
    hidden: yes
    type: string
    sql: ${TABLE}.task_assignee_user_id ;;
  }

  dimension: task_url {
    hidden: yes
    type: string
    sql: ${TABLE}.task_url ;;
  }

  dimension_group: sprint_start {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.sprint_started_ts ;;

  }

  dimension_group: sprint_end {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.start_end_ts ;;
  }

  dimension: sprint_board_url {
    hidden: yes
    type: string
    sql: ${TABLE}.sprint_board_url ;;
  }

  dimension: contact_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_fk ;;
  }

  dimension_group: task_completed_ts {
    label: "Task Completed"
    type: time
    timeframes: [time, date, month]
    sql: ${TABLE}.task_completed_ts ;;
  }

  dimension_group: task_created_ts {
    label: "Task Created"
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.task_created_ts ;;
  }

  dimension: task_creator_user_id {
    hidden: yes
    type: string
    sql: ${TABLE}.task_creator_user_id ;;
  }

  dimension: task_description {
    group_label: "Project Tasks"
    type: string
    sql: ${TABLE}.task_description ;;
  }

  dimension: task_id {
    type: string
    sql: ${TABLE}.task_id ;;
  }

  dimension: task_is_completed {
    group_label: "Project Tasks"
    type: yesno
    sql: ${TABLE}.task_is_completed ;;
  }

  dimension: deliverable_id {
    group_label: "Project Tasks"
    type: string
    sql: ${TABLE}.deliverable_id ;;
  }

  dimension: deliverable_type {
    group_label: "Project Tasks"
    type: string
    sql: ${TABLE}.deliverable_type ;;
  }

  dimension: sprint_name {
    group_label: "Project Tasks"
    type: string
    sql: ${TABLE}.sprint_name ;;
    link: {
      url: "https://{{ delivery_tasks_fact.sprint_board_url._value }}"
      label: "View Sprint in Jira"
    }
  }

  dimension_group: task_end_ts {
    group_label: "Project Tasks"
    type: time
    timeframes: [date, time, week, month, month_num, year]
    sql: ${TABLE}.task_end_ts ;;
  }

  dimension: user_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.user_fk ;;
  }

  dimension_group: task_start_ts {
    group_label: "Project Tasks"
    type: time
    hidden: yes
    timeframes: [date, time, week, month, month_num]
    sql: ${TABLE}.task_start_ts ;;
  }

  dimension_group: task_due {
    group_label: "Project Tasks"
    type: time
    hidden: yes
    timeframes: [date]
    sql: ${TABLE}.task_due_ts ;;
  }

  dimension_group: task_work_started {
    group_label: "Project Tasks"
    type: time
    timeframes: [date, time, week, month, month_num]
    sql: ${TABLE}.task_work_started_ts ;;
  }

  dimension_group: epic_start {
    group_label: "Project Tasks"
    type: time
    timeframes: [date, time, week, month, month_num]
    sql: ${TABLE}.epic_start_ts ;;
  }

  dimension_group: epic_end {
    group_label: "Project Tasks"
    type: time
    timeframes: [date, time, week, month, month_num]
    sql: ${TABLE}.epic_end_ts ;;
  }

  dimension: task_sprint_day {
    type: number
    hidden: yes
    sql: TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), ${TABLE}.task_start_ts, DAY) ;;
  }

  dimension: task_target_status_delivery_day_target {
    group_label: "Project Tasks"
    type: number
    sql:
      CASE
        WHEN ${TABLE}.task_status = 'Design & Validation' THEN 1
        WHEN ${TABLE}.task_status = 'Blocked' THEN 3
        WHEN ${TABLE}.task_status = 'In Progress' THEN 6
        WHEN ${TABLE}.task_status = 'In QA' THEN 7
        WHEN ${TABLE}.task_status = 'Add to Looker' THEN 7
        WHEN ${TABLE}.task_status = 'Looker Internal QA' THEN 7
        WHEN ${TABLE}.task_status = 'Failed Client QA/QA Comment' THEN 8
        WHEN ${TABLE}.task_status = 'Client QA' THEN 8
      END ;;
  }

  dimension_group: task_target_ts {
    group_label: "Project Tasks"
    type: time
    timeframes: [date, time]
    sql: TIMESTAMP_ADD(${TABLE}.task_start_ts, INTERVAL ${task_target_status_delivery_day_target} DAY) ;;
  }

  dimension: task_days_open {
    group_label: "Project Tasks"
    type: number
    sql:
      CASE
        WHEN ${TABLE}.task_status != 'Done'
          THEN TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), ${TABLE}.task_start_ts, DAY)
      END ;;
  }

  measure: avg_task_days_open {
    group_label: "Project Tasks"
    type: average
    sql: ${task_days_open} ;;
  }

  dimension: deliverable_category {
    group_label: "Project Tasks"
    type: string
    sql:
      CASE
        WHEN ${TABLE}.deliverable_category IS NULL
         AND SUBSTR(${TABLE}.deliverable_id, LENGTH(${TABLE}.deliverable_id) - 2, 1) = 'a'
          THEN 'Historical'
        WHEN ${TABLE}.deliverable_category IS NULL
         AND SAFE_CAST(SUBSTR(${TABLE}.deliverable_id, LENGTH(${TABLE}.deliverable_id) - 2, 1) AS INT64) IS NOT NULL
          THEN 'NetSuite'
        WHEN ${TABLE}.deliverable_category IN ('Historical Data', 'Historic')
          THEN 'Historical'
        WHEN LOWER(${TABLE}.task_name) LIKE '%historic%'
          THEN 'Historical'
        ELSE 'NetSuite'
      END ;;
  }

  dimension_group: task_last_modified_ts {
    hidden: yes
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.task_last_modified_ts ;;
  }

  dimension: task_name {
    group_label: "Project Tasks"
    type: string
    sql: ${TABLE}.task_name ;;
    link: {
      url: "https://{{ delivery_tasks_fact.task_url._value }}"
      label: "View Task in Jira"
    }
  }

  dimension: epic_name {
    group_label: "Project Tasks"
    type: string
    sql: ${TABLE}.epic_name ;;
  }

  dimension: task_status_workflow_stage_number {
    group_label: "Project Tasks"
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.task_status_workflow_stage_number, 8) ;;
  }

  dimension: task_status {
    group_label: "Project Tasks"
    type: string
    sql: ${TABLE}.task_status ;;
    order_by_field: task_status_workflow_stage_number
  }

  dimension: task_type {
    group_label: "Project Tasks"
    type: string
    sql: ${TABLE}.task_type ;;
  }

  dimension: task_status_colour {
    group_label: "Project Tasks"
    type: string
    sql: ${TABLE}.task_status_colour ;;
  }

  dimension: total_delivery_subtasks {
    hidden: yes
    group_label: "Project Tasks"
    type: number
    sql: ${TABLE}.total_delivery_subtasks ;;
  }

  dimension: task_story_points {
    group_label: "Project Tasks"
    type: number
    sql: ${TABLE}.task_story_points ;;
  }

  measure: total_task_story_points {
    group_label: "Project Tasks"
    type: sum
    sql: COALESCE(${TABLE}.task_story_points, 0) ;;
  }

  measure: total_delivery_tasks {
    group_label: "Project Tasks"
    type: sum
    sql:
      COALESCE(${TABLE}.total_to_do, 0)
      + COALESCE(${TABLE}.total_in_add_to_looker, 0)
      + COALESCE(${TABLE}.total_in_design, 0)
      + COALESCE(${TABLE}.total_completed, 0)
      + COALESCE(${TABLE}.total_in_progress, 0)
      + COALESCE(${TABLE}.total_blocked, 0)
      + COALESCE(${TABLE}.total_in_client_qa, 0) ;;
  }

  measure: total_delivery_tasks_completed {
    group_label: "Project Tasks"
    type: sum
    sql: COALESCE(${TABLE}.total_completed, 0) ;;
  }

  measure: total_started_and_completed {
    group_label: "Project Tasks"
    type: sum
    description: "Count of tasks that were started and completed in the same sprint"
    sql: COALESCE(${TABLE}.total_completed_within_same_sprint, 0) ;;
  }

  measure: total_started_but_not_completed {
    group_label: "Project Tasks"
    type: sum
    description: "Count of tasks that were started but not completed"
    sql: COALESCE(${TABLE}.total_started_but_not_completed, 0) ;;
  }

  measure: total_started {
    group_label: "Project Tasks"
    type: sum
    description: "Count of tasks that were started"
    sql: COALESCE(${TABLE}.total_completed_within_same_sprint, 0) + COALESCE(${TABLE}.total_started_but_not_completed, 0) ;;
  }

  measure: total_delivery_tasks_in_progress {
    group_label: "Project Tasks"
    type: sum
    sql: COALESCE(${TABLE}.total_in_progress, 0) ;;
  }

  measure: total_delivery_tasks_to_do {
    group_label: "Project Tasks"
    type: sum
    sql: COALESCE(${TABLE}.total_to_do, 0) ;;
  }

  measure: total_failed_client_qa_comment {
    group_label: "Project Tasks"
    label: "Total Failed Client QA/QA Comment"
    hidden: yes
    type: sum
    sql: CASE WHEN ${TABLE}.task_status = 'Failed Client QA/QA Comment' THEN 1 END ;;
  }

  measure: total_delivery_tasks_blocked {
    group_label: "Project Tasks"
    type: sum
    sql: COALESCE(${TABLE}.total_blocked, 0) ;;
  }

  measure: total_delivery_tasks_in_qa {
    group_label: "Project Tasks"
    hidden: yes
    type: sum
    sql: COALESCE(${TABLE}.total_in_qa, 0) ;;
  }

  measure: total_delivery_tasks_in_client_qa {
    group_label: "Project Tasks"
    hidden: yes
    type: sum
    sql: COALESCE(${TABLE}.total_in_client_qa, 0) ;;
  }

  measure: total_delivery_tasks_in_add_to_looker {
    group_label: "Project Tasks"
    hidden: yes
    type: sum
    sql: COALESCE(${TABLE}.total_in_add_to_looker, 0) ;;
  }

  measure: total_delivery_tasks_in_design {
    group_label: "Project Tasks"
    hidden: yes
    type: sum
    sql: COALESCE(${TABLE}.total_in_design, 0) ;;
  }

  measure: total_delivery_tasks_in_looker_qa {
    group_label: "Project Tasks"
    hidden: yes
    type: sum
    sql: COALESCE(${TABLE}.total_in_looker_qa, 0) ;;
  }

  measure: total_delivery_tasks_failed_client_qa {
    group_label: "Project Tasks"
    hidden: yes
    type: sum
    sql: COALESCE(${TABLE}.total_failed_client_qa, 0) ;;
  }

  measure: total_revision_required {
    group_label: "Project Tasks"
    hidden: yes
    type: sum
    sql: COALESCE(${TABLE}.total_revision_required, 0) ;;
  }

  measure: total_failed_internal_qa {
    group_label: "Project Tasks"
    hidden: yes
    type: sum
    sql: COALESCE(${TABLE}.total_failed_internal_qa, 0) ;;
  }

  measure: total_issues {
    group_label: "Project Tasks"
    type: sum
    sql: ${TABLE}.total_issues ;;
  }

  measure: total_task_hours_to_complete {
    group_label: "Project Tasks"
    type: sum
    sql: ${TABLE}.total_task_hours_to_complete ;;
  }

  measure: avg_task_hours_to_complete {
    group_label: "Project Tasks"
    type: average
    sql: ${TABLE}.total_task_hours_to_complete ;;
  }

  measure: count {
    type: count
    drill_fields: [task_name]
  }
}
