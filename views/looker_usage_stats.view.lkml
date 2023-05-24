view: looker_usage_stats {
  derived_table: {
    sql: select * from ra-development.fivetran_email.usage_stats
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }



  dimension_group: _fivetran_synced {
    type: time
    sql: ${TABLE}._fivetran_synced ;;
  }

  measure: approximate_web_usage_in_minutes {
    type: sum
    sql: ${TABLE}.approximate_web_usage_in_minutes ;;
  }

  measure: average_runtime_in_seconds {
    type: average_distinct
    sql: cast(replace(${TABLE}.average_runtime_in_seconds,',','') as float64) ;;
  }

  measure: median_runtime_in_seconds {
    type: median_distinct
    sql: cast(replace(${TABLE}.average_runtime_in_seconds,',','') as float64) ;;
  }

  measure: max_runtime_in_seconds {
    type: max
    sql: cast(replace(${TABLE}.average_runtime_in_seconds,',','') as float64) ;;
  }

  dimension: client {
    type: string
    sql: ${TABLE}.client ;;
  }

  dimension_group: created_time {
    type: time
    datatype: datetime
    sql: ${TABLE}.created_time ;;
  }

  dimension: dialect {
    type: string
    sql: ${TABLE}.dialect ;;
  }

  dimension: explore {
    type: string
    sql: ${TABLE}.explore ;;
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: issuer_source {
    type: string
    sql: ${TABLE}.issuer_source ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.pk ;;
  }

  dimension: rebuild_pdts_yes_no_ {
    type: string
    sql: ${TABLE}.rebuild_pdts_yes_no_ ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: dashboard_title {
    type: string
    sql: ${TABLE}.dashboard_title ;;
  }

  measure: history_approximate_web_usage_in_minutes {
    type: sum
    sql: ${TABLE}.history_approximate_web_usage_in_minutes ;;
  }

  measure: history_average_runtime_in_seconds {
    type: average
    sql: ${TABLE}.history_average_runtime_in_seconds ;;
  }

  measure: median_average_runtime_in_seconds {
    type: median_distinct
    sql: ${TABLE}.history_average_runtime_in_seconds ;;
  }

  measure: max_average_runtime_in_seconds {
    type: max
    sql: ${TABLE}.history_average_runtime_in_seconds ;;
  }

  dimension_group: history_created_time {
    type: time
    datatype: datetime
    sql: ${TABLE}.history_created_time ;;
  }

  dimension: history_dialect {
    type: string
    sql: ${TABLE}.history_dialect ;;
  }

  dimension: history_id {
    hidden: yes
    type: number
    sql: ${TABLE}.history_id ;;
  }

  dimension: history_issuer_source {
    type: string
    sql: ${TABLE}.history_issuer_source ;;
  }

  dimension: history_rebuild_pdts_yes_no_ {
    type: string
    sql: ${TABLE}.history_rebuild_pdts_yes_no_ ;;
  }

  dimension: history_source {
    type: string
    sql: ${TABLE}.history_source ;;
  }

  dimension: history_status {
    type: string
    sql: ${TABLE}.history_status ;;
  }

  dimension: look_title {
    type: string
    sql: ${TABLE}.look_title ;;
  }

  dimension: query_explore {
    type: string
    sql: ${TABLE}.query_explore ;;
  }

  dimension: user_name {
    type: string
    sql: ${TABLE}.user_name ;;
  }


}
