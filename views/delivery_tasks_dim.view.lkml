view: delivery_tasks_dim {
  sql_table_name: `analytics.delivery_tasks_dim`
    ;;

  dimension: parent_task_id {
    type: string
    sql: ${TABLE}.parent_task_id ;;
  }

  dimension: project_id {
    type: string
    sql: ${TABLE}.project_id ;;
  }

  dimension: task_assignee_user_id {
    type: string
    sql: ${TABLE}.task_assignee_user_id ;;
  }

  dimension_group: task_completed_ts {
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
    sql: ${TABLE}.task_completed_ts ;;
  }

  dimension_group: task_created_ts {
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
    sql: ${TABLE}.task_created_ts ;;
  }

  dimension: task_creator_user_id {
    type: string
    sql: ${TABLE}.task_creator_user_id ;;
  }

  dimension: task_description {
    type: string
    sql: ${TABLE}.task_description ;;
  }

  dimension: task_id {
    type: string
    sql: ${TABLE}.task_id ;;
  }

  dimension: task_is_completed {
    type: yesno
    sql: ${TABLE}.task_is_completed ;;
  }

  dimension_group: task_last_modified_ts {
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

  dimension: task_pk {
    type: string
    sql: ${TABLE}.task_pk ;;
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
    type: number
    sql: ${TABLE}.total_delivery_priority_low ;;
  }

  dimension: total_delivery_priority_medium {
    type: number
    sql: ${TABLE}.total_delivery_priority_medium ;;
  }

  dimension: total_delivery_subtasks {
    type: number
    sql: ${TABLE}.total_delivery_subtasks ;;
  }

  dimension: total_delivery_tasks {
    type: number
    sql: ${TABLE}.total_delivery_tasks ;;
  }

  dimension: total_delivery_tasks_completed {
    type: number
    sql: ${TABLE}.total_delivery_tasks_completed ;;
  }

  dimension: total_delivery_tasks_high {
    type: number
    sql: ${TABLE}.total_delivery_tasks_high ;;
  }

  dimension: total_delivery_tasks_in_progress {
    type: number
    sql: ${TABLE}.total_delivery_tasks_in_progress ;;
  }

  dimension: total_delivery_tasks_to_do {
    type: number
    sql: ${TABLE}.total_delivery_tasks_to_do ;;
  }

  dimension: total_issues {
    type: number
    sql: ${TABLE}.total_issues ;;
  }

  dimension: total_task_hours_to_complete {
    type: number
    sql: ${TABLE}.total_task_hours_to_complete ;;
  }

  measure: count {
    type: count
    drill_fields: [task_name]
  }
}
