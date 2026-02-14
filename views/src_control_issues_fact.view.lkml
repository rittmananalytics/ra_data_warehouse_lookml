view: src_control_issues_fact {
  sql_table_name: `ra-development.analytics.src_control_issues_fact` ;;

  dimension: _dbt_source_relation {
    type: string
    sql: ${TABLE}._dbt_source_relation ;;
  }
  dimension: contact_fk {
    type: string
    sql: ${TABLE}.contact_fk ;;
  }
  dimension: issue_assignees {
    type: string
    sql: ${TABLE}.issue_assignees ;;
  }
  dimension: issue_body {
    type: string
    sql: ${TABLE}.issue_body ;;
  }
  dimension_group: issue_closed {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.issue_closed_at ;;
  }
  dimension_group: issue_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.issue_created_at ;;
  }
  dimension: issue_creator_login_name {
    type: string
    sql: ${TABLE}.issue_creator_login_name ;;
  }
  dimension: issue_creator_name {
    type: string
    sql: ${TABLE}.issue_creator_name ;;
  }
  dimension: issue_creator_user_id {
    type: string
    sql: ${TABLE}.issue_creator_user_id ;;
  }
  dimension: issue_days_open {
    type: number
    sql: ${TABLE}.issue_days_open ;;
  }
  dimension: issue_id {
    type: string
    sql: ${TABLE}.issue_id ;;
  }
  dimension: issue_labels {
    type: string
    sql: ${TABLE}.issue_labels ;;
  }
  dimension: issue_number {
    type: number
    sql: ${TABLE}.issue_number ;;
  }
  dimension: issue_number_of_comments {
    type: number
    sql: ${TABLE}.issue_number_of_comments ;;
  }
  dimension: issue_number_of_times_reopened {
    type: number
    sql: ${TABLE}.issue_number_of_times_reopened ;;
  }
  dimension: issue_state {
    type: string
    sql: ${TABLE}.issue_state ;;
  }
  dimension: issue_title {
    type: string
    sql: ${TABLE}.issue_title ;;
  }
  dimension_group: issue_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.issue_updated_at ;;
  }
  dimension: issue_url {
    type: string
    sql: ${TABLE}.issue_url ;;
  }
  dimension: repo_id {
    type: string
    sql: ${TABLE}.repo_id ;;
  }
  dimension: repo_name {
    type: string
    sql: ${TABLE}.repo_name ;;
  }
  dimension: src_control_issue_pk {
    type: string
    sql: ${TABLE}.src_control_issue_pk ;;
  }
  dimension: src_control_repo_fk {
    type: string
    sql: ${TABLE}.src_control_repo_fk ;;
  }
  measure: count {
    type: count
    drill_fields: [issue_creator_login_name, issue_creator_name, repo_name]
  }
}
