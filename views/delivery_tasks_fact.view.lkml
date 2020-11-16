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
    type: string
    sql: ${TABLE}.task_description ;;
  }

  dimension: task_id {
    hidden: yes

    type: string
    sql: ${TABLE}.task_id ;;
  }

  dimension: task_is_completed {
    type: yesno
    sql: ${TABLE}.task_is_completed ;;
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
    type: string
    sql: ${TABLE}.task_name ;;
  }

  dimension: task_priority {
    type: string
    sql: ${TABLE}.task_priority ;;
  }

  dimension: task_status {
    type: string
    sql: ${TABLE}.task_status ;;
  }

  dimension: task_type {
    type: string
    sql: ${TABLE}.task_type ;;
  }

  dimension: total_delivery_priority_low {
    hidden: yes

    type: number
    sql: ${TABLE}.total_delivery_priority_low ;;
  }

  dimension: total_delivery_priority_medium {
    hidden: yes

    type: number
    sql: ${TABLE}.total_delivery_priority_medium ;;
  }

  dimension: total_delivery_subtasks {
    hidden: yes

    type: number
    sql: ${TABLE}.total_delivery_subtasks ;;
  }

  measure: total_delivery_tasks {
    hidden: no

    type: sum
    sql: ${TABLE}.total_delivery_tasks ;;
  }

  measure: total_delivery_tasks_completed {

    type: sum
    sql: ${TABLE}.total_delivery_tasks_completed ;;
  }

  dimension: total_delivery_tasks_high {
    hidden: yes

    type: number
    sql: ${TABLE}.total_delivery_tasks_high ;;
  }

  measure: total_delivery_tasks_in_progress {

    type: sum
    sql: ${TABLE}.total_delivery_tasks_in_progress ;;
  }

  measure: total_delivery_tasks_to_do {

    type: sum
    sql: ${TABLE}.total_delivery_tasks_to_do ;;
  }

  measure: total_issues {
    hidden: no

    type: sum
    sql: ${TABLE}.total_issues ;;
  }

  measure: total_task_hours_to_complete {
    type: sum
    sql: ${TABLE}.total_task_hours_to_complete ;;
  }

  measure: count {
    type: count
    drill_fields: [task_name]
  }
}