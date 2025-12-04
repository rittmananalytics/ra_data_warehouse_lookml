view: bp_completion_status_dim {
  sql_table_name: `ra-development.bp_analytics_bp_analytics.completion_status_dim` ;;

  # Primary Key
  dimension: completion_status_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.completion_status_pk ;;
    hidden: yes
  }

  # IDs
  dimension: completion_status_id {
    type: number
    sql: ${TABLE}.completion_status_id ;;
    label: "Completion Status ID"
  }

  dimension: completion_status_description {
    type: string
    sql: ${TABLE}.completion_status_description ;;
    label: "Completion Status"
  }

  # Flags
  dimension: is_completer {
    type: yesno
    sql: ${TABLE}.is_completer ;;
    label: "Is Completer"
    description: "Student completed their course"
  }

  # Timestamps
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_ts ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.updated_ts ;;
  }

  # Measures
  measure: total_completion_statuses {
    type: count
    label: "Total Completion Statuses"
  }
}
