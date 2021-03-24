view: rixo_load_errors {
  derived_table: {
    sql: SELECT table_name FROM `ra-development.alerts.rixo_load_errors`
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: table_name {
    type: string
    sql: ${TABLE}.table_name ;;
  }

  set: detail {
    fields: [table_name]
  }
}
