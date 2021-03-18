view: timesheet_tasks_dim {
  sql_table_name: `{{ _user_attributes['dataset'] }}.timesheet_tasks_dim`
    ;;

  dimension: task_billable_by_default {
    type: yesno
    sql: ${TABLE}.task_billable_by_default ;;
  }

  dimension_group: task_created {
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
    sql: ${TABLE}.task_created_at ;;
  }

  dimension: task_default_hourly_rate {
    type: number
    sql: ${TABLE}.task_default_hourly_rate ;;
  }

  dimension: task_id {
    type: number
    sql: ${TABLE}.task_id ;;
  }

  dimension: task_is_active {
    type: yesno
    sql: ${TABLE}.task_is_active ;;
  }

  dimension: task_name {
    type: string
    sql: ${TABLE}.task_name ;;
  }

  dimension_group: task_updated {
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
    sql: ${TABLE}.task_updated_at ;;
  }

  dimension: timesheet_task_pk {
    type: string
    sql: ${TABLE}.timesheet_task_pk ;;
  }

  measure: count {
    type: count
    drill_fields: [task_name]
  }
}