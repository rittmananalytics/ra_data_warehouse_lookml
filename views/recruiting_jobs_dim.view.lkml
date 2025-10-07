view: recruiting_jobs_dim {
  sql_table_name: `ra-development.analytics.recruiting_jobs_dim` ;;

  dimension: _dbt_source_relation {
    hidden: yes

    type: string
    sql: ${TABLE}._dbt_source_relation ;;
  }
  dimension_group: job_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.job_created_date ;;
  }
  dimension: job_id {
    hidden: yes

    type: string
    sql: ${TABLE}.job_id ;;
  }
  dimension: job_internal_name {
    type: string
    sql: ${TABLE}.job_internal_name ;;
  }
  dimension_group: job_last_modified {
    hidden: yes

    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.job_last_modified_date ;;
  }
  dimension: job_pitch {
    type: string
    sql: ${TABLE}.job_pitch ;;
  }
  dimension: job_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.job_pk ;;
  }
  dimension: job_resume_requirement {
    hidden: yes

    type: string
    sql: ${TABLE}.job_resume_requirement ;;
  }
  dimension: job_status {
    type: string
    sql: ${TABLE}.job_status ;;
  }
  dimension: job_title {
    type: string
    sql: ${TABLE}.job_title ;;
  }
  measure: count {
    hidden: yes

    type: count
    drill_fields: [job_internal_name]
  }
}
