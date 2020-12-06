view: looker_usage {
  derived_table: {
    sql: select * except(_file, _line, _directory, _fivetran_synced) from (
      select *, max(_fivetran_synced) over (partition by pk) as max_fivetran_synced,
                min(history_created_time) over (partition by client) as first_history_time,
                date_diff(min(date(history_created_time)) over (partition by client), date(history_created_time),WEEK)
      from ra-development.fivetran_email.usage_stats)
      where _fivetran_synced = max_fivetran_synced
       ;;
  }



  dimension_group: _modified {
    type: time
    sql: ${TABLE}._modified ;;
  }

  measure: average_web_usage_in_minutes {
    type: sum
    value_format_name: decimal_0

    sql: ${TABLE}.approximate_web_usage_in_minutes ;;
  }

  measure: average_runtime_in_seconds {
    type: average
    value_format_name: decimal_0
    sql: safe_cast(${TABLE}.average_runtime_in_seconds as float64) ;;
  }

  dimension: client {
    type: string
    sql: ${TABLE}.client ;;
  }

  dimension: contact_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_pk ;;
  }


  dimension_group: created_time {
    type: time
    datatype: date
    sql: timestamp(${TABLE}.created_time) ;;
  }

  dimension_group: client_first_created_time {
    type: time
    datatype: date
    sql: timestamp(${TABLE}.first_history_time) ;;
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

  measure: total_queries {
    type: count_distinct
    sql: ${id} ;;
  }

  dimension: issuer_source {
    type: string
    sql: ${TABLE}.issuer_source ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  measure: total_users {
    type: count_distinct
    sql: ${name} ;;
  }

  dimension: pk {
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
    value_format_name: decimal_0

    type: sum
    sql: ${TABLE}.history_approximate_web_usage_in_minutes ;;
  }

  dimension: history_average_runtime_in_seconds {
    type: number
    sql: ${TABLE}.history_average_runtime_in_seconds ;;
  }

  dimension_group: history_created_time {
    type: time
    datatype: date
    sql: timestamp(${TABLE}.history_created_time) ;;
  }



  dimension: history_dialect {
    type: string
    sql: ${TABLE}.history_dialect ;;
  }

  dimension: history_id {
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

  dimension_group: max_fivetran_synced {
    type: time
    sql: ${TABLE}.max_fivetran_synced ;;
  }

  set: detail {
    fields: [
      _modified_time,
      average_runtime_in_seconds,
      client,
      created_time_time,
      dialect,
      explore,
      id,
      issuer_source,
      name,
      pk,
      rebuild_pdts_yes_no_,
      source,
      status,
      title,
      dashboard_title,
      average_runtime_in_seconds,
      history_created_time_time,
      history_dialect,
      history_id,
      history_issuer_source,
      history_rebuild_pdts_yes_no_,
      history_source,
      history_status,
      look_title,
      query_explore,
      user_name,
      max_fivetran_synced_time
    ]
  }
}
