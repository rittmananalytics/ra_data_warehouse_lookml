view: looker_usage_stats {
  derived_table: {
    sql: select * from ra-development.fivetran_email.usage_stats
      ;;
  }

  measure: count {
    type: count

  }



  dimension_group: _fivetran_synced {
    type: time
    sql: ${TABLE}._fivetran_synced ;;
  }

  measure: approximate_web_usage_in_minutes {
    type: sum
    sql: coalesce(${TABLE}.approximate_web_usage_in_minutes,${TABLE}.history_approximate_web_usage_in_minutes) ;;
  }

  measure: average_runtime_in_seconds {
    type: average_distinct
    value_format_name: decimal_0
    sql: coalesce(cast(replace(${TABLE}.average_runtime_in_seconds,',','') as float64),${TABLE}.history_average_runtime_in_seconds) ;;
  }

  measure: median_runtime_in_seconds {
    value_format_name: decimal_0

    type: median_distinct
    sql: coalesce(cast(replace(${TABLE}.average_runtime_in_seconds,',','') as float64),${TABLE}.history_average_runtime_in_seconds) ;;
  }

  measure: max_runtime_in_seconds {
    value_format_name: decimal_0

    type: max
    sql: coalesce(cast(replace(${TABLE}.average_runtime_in_seconds,',','') as float64),${TABLE}.history_average_runtime_in_seconds) ;;
  }

  dimension: client {
    type: string
    sql: ${TABLE}.client ;;
  }

  dimension_group: created_time {
    type: time
    datatype: datetime
    sql: coalesce(${TABLE}.created_time,${TABLE}.history_created_time) ;;
  }

  dimension: dialect {
    type: string
    sql: coalesce(${TABLE}.dialect,${TABLE}.history_dialect) ;;
  }

  dimension: explore {
    type: string
    sql: coalesce(${TABLE}.explore,${TABLE}.query_explore) ;;
  }

  dimension: id {
    type: number
    sql: coalesce(${TABLE}.id,${TABLE}.history_id ) ;;
  }

  dimension: issuer_source {
    type: string
    sql: coalesce(${TABLE}.issuer_source,sql: ${TABLE}.history_issuer_source) ;;
  }

  dimension: name {
    type: string
    sql: coalesce(${TABLE}.name,${TABLE}.user_name) ;;
  }

  dimension: pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.pk ;;
  }

  dimension: rebuild_pdts_yes_no_ {
    type: string
    sql: coalesce(${TABLE}.rebuild_pdts_yes_no_,${TABLE}.history_rebuild_pdts_yes_no_) ;;
  }

  dimension: source {
    type: string
    sql: coalesce(${TABLE}.source,${TABLE}.history_source) ;;
  }

  dimension: status {
    type: string
    sql: coalesce(${TABLE}.status,${TABLE}.history_status) ;;
  }

  dimension: title {
    type: string
    sql: coalesce(${TABLE}.title,${TABLE}.look_title) ;;
  }

  dimension: dashboard_title {
    type: string
    sql: ${TABLE}.dashboard_title ;;
  }











}
