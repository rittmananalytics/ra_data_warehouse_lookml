view: recruiting_application_stages_dim {
  sql_table_name: `ra-development.analytics.recruiting_application_stages_dim` ;;

  dimension: _dbt_source_relation {
    hidden: yes

    type: string
    sql: ${TABLE}._dbt_source_relation ;;
  }
  dimension: application_stage_id {
    hidden: yes

    type: string
    sql: ${TABLE}.application_stage_id ;;
  }
  dimension: application_stage_name {
    type: string
    sql: ${TABLE}.application_stage_name ;;
  }
  dimension: application_stage_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.application_stage_pk ;;
  }
  dimension: application_stage_rejected_count {
    type: number
    sql: ${TABLE}.application_stage_rejected_count ;;
  }
  measure: count {
    type: count
    drill_fields: [application_stage_name]
  }
}
