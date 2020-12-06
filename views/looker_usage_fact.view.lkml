view: looker_usage_fact {
  sql_table_name: `ra-development.analytics.looker_usage_fact`
    ;;
  drill_fields: [id]

  dimension: id {
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  measure: approximate_web_usage_in_minutes {
    type: sum
    sql: ${TABLE}.approximate_web_usage_in_minutes ;;
  }

  measure: average_runtime_in_seconds {
    type: sum
    sql: ${TABLE}.average_runtime_in_seconds ;;
  }

  dimension: company_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension_group: created {
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
    sql: timestamp(${TABLE}.created_time) ;;
  }

  dimension: contact_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_pk ;;
  }

  dimension: dashboard_title {
    type: string
    sql: ${TABLE}.dashboard_title ;;
  }

  dimension: dialect {
    type: string
    sql: ${TABLE}.dialect ;;
  }

  dimension: explore {
    type: string
    sql: ${TABLE}.explore ;;
  }

  dimension: issuer_source {
    type: string
    sql: ${TABLE}.issuer_source ;;
  }

  dimension: looker_usage_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.looker_usage_pk ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: rebuild_pdts_yes_no_ {
    type: string
    sql: ${TABLE}.rebuild_pdts_yes_no_ ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  measure: query_count {
    type: count
    drill_fields: [id, name]
  }
}
