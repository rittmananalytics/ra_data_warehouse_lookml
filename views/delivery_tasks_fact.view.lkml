view: delivery_tasks_fact {
  sql_table_name: `ra-development.analytics.delivery_tasks_fact`
    ;;

  dimension: delivery_project_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.delivery_project_pk ;;
  }

  dimension: delivery_task_pk {
    primary_key: yes
    hidden: yes

    type: string
    sql: ${TABLE}.delivery_task_pk ;;
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

  dimension_group: task_completed_ts {
    label: "Task Completed"
    type: time
    timeframes: [
      time,
      date
    ]
    sql: ${TABLE}.task_completed_ts ;;
  }

  dimension_group: task_created_ts {
    label: "Task Created"

    type: time
    timeframes: [
      time,
      date,
      week,
      month
    ]
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
    hidden: yes

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
  }

  dimension_group: task_end_ts {
    group_label: "Project Tasks"
    type: time
    timeframes: [date,time]
    sql: ${TABLE}.task_end_ts ;;
  }

  dimension_group: task_start_ts {
    group_label: "Project Tasks"
    type: time
    timeframes: [date,time]
    sql: ${TABLE}.task_start_ts ;;
  }

  dimension: task_days_open {
    group_label: "Project Tasks"
    type: number
    sql: case when task_status != 'Done' then timestamp_diff(current_timestamp,${TABLE}.task_start_ts,  DAY) end;;
  }

  measure: avg_task_days_open {
    group_label: "Project Tasks"
    type: average
    sql: ${task_days_open};;
  }

  dimension: deliverable_category {
    group_label: "Project Tasks"
    type: string
    sql: case when ${TABLE}.deliverable_category is null and substr(${TABLE}.deliverable_id,length(${TABLE}.deliverable_id)-2,1)  = 'a' then 'Historical'
              when ${TABLE}.deliverable_category is null and safe_cast(substr(${TABLE}.deliverable_id,length(${TABLE}.deliverable_id)-2,1) as int64) is not null then 'NetSuite'
              else ${TABLE}.deliverable_category end;;
  }

  dimension_group: task_last_modified_ts {
    hidden: yes

    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.task_last_modified_ts ;;
  }

  dimension: task_name {
    group_label: "Project Tasks"

    type: string
    sql: ${TABLE}.task_name ;;
  }

  dimension: task_priority {
    group_label: "Project Tasks"

    type: string
    sql: ${TABLE}.task_priority ;;
  }

  dimension: task_status {
    group_label: "Project Tasks"
    type: string
    sql: ${TABLE}.task_status ;;
  }

  dimension: task_type {
    group_label: "Project Tasks"

    type: string
    sql: ${TABLE}.task_type ;;
  }

  dimension: task_resolution_type {
    group_label: "Project Tasks"

    type: string
    sql: ${TABLE}.task_resolution_type ;;
  }

  dimension: task_status_colour {
    group_label: "Project Tasks"

    type: string
    sql: ${TABLE}.task_status_colour ;;
  }

  dimension: total_delivery_priority_low {
    hidden: yes
    group_label: "Project Tasks"

    type: number
    sql: ${TABLE}.total_priority_low ;;
  }

  dimension: total_delivery_priority_medium {
    hidden: yes
    group_label: "Project Tasks"

    type: number
    sql: ${TABLE}.total_priority_medium ;;
  }

  dimension: total_delivery_subtasks {
    hidden: yes
    group_label: "Project Tasks"

    type: number
    sql: ${TABLE}.total_delivery_subtasks ;;
  }

  measure: total_delivery_tasks {
    hidden: no
    group_label: "Project Tasks"

    type: sum
    sql: ${TABLE}.total_delivery_tasks ;;
  }

  measure: total_delivery_tasks_completed {
    group_label: "Project Tasks"

    type: sum
    sql: ${TABLE}.total_completed ;;
  }

  dimension: total_delivery_tasks_high {
    hidden: yes
    group_label: "Project Tasks"

    type: number
    sql: ${TABLE}.total_priority_high ;;
  }

  measure: total_delivery_tasks_in_progress {
    group_label: "Project Tasks"

    type: sum
    sql: ${TABLE}.total_in_progress ;;
  }

  measure: total_delivery_tasks_to_do {
    group_label: "Project Tasks"

    type: sum
    sql: ${TABLE}.total_to_do ;;
  }

  measure: total_delivery_tasks_blocked {
    group_label: "Project Tasks"

    type: sum
    sql: ${TABLE}.total_blocked ;;
  }

  measure: total_delivery_tasks_in_qa {
    group_label: "Project Tasks"

    type: sum
    sql: ${TABLE}.total_in_qa ;;
  }

  measure: total_delivery_tasks_in_client_qa {
    group_label: "Project Tasks"

    type: sum
    sql: ${TABLE}.total_in_client_qa ;;
  }

  measure: total_delivery_tasks_in_add_to_looker {
    group_label: "Project Tasks"

    type: sum
    sql: ${TABLE}.total_in_add_to_looker ;;
  }

  measure: total_delivery_tasks_in_design {
    group_label: "Project Tasks"

    type: sum
    sql: ${TABLE}.total_in_design;;
  }

  measure: total_issues {
    hidden: no
    group_label: "Project Tasks"

    type: sum
    sql: ${TABLE}.total_issues ;;
  }

  measure: total_task_hours_to_complete {
    type: sum
    sql: ${TABLE}.total_task_hours_to_complete ;;
  }

  measure: avg_task_hours_to_complete {
    type: average
    sql: ${TABLE}.total_task_hours_to_complete ;;
  }

  measure: count {
    type: count
    drill_fields: [task_name]
  }
}
