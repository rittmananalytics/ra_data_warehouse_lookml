view: timesheet_tasks_dim {
  sql_table_name: `ra-development.analytics.timesheet_tasks_dim` ;;

  dimension: task_billable_by_default {
    type: yesno
    hidden: yes
    sql: ${TABLE}.task_billable_by_default ;;
  }

  dimension: task_default_hourly_rate {
    type: number
    hidden: yes
    sql: ${TABLE}.task_default_hourly_rate ;;
  }

  dimension: task_id {
    type: string
    hidden: yes
    sql: ${TABLE}.task_id ;;
  }

  dimension: task_is_active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.task_is_active ;;
  }

  dimension: task_name {
    type: string
    group_label: "Timesheet Details"
    sql: ${TABLE}.task_name ;;
  }

  dimension: timesheet_task_pk {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.timesheet_task_pk ;;
  }

  dimension_group: task_created {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    hidden: yes
    sql: ${TABLE}.task_created_at ;;
  }

  dimension_group: task_updated {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    hidden: yes
    sql: ${TABLE}.task_updated_at ;;
  }
}
