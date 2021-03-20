view: looker_usage_fact {
  sql_table_name: `{{ _user_attributes['dataset'] }}.looker_usage_fact`
    ;;
  drill_fields: [id]

  dimension: id {
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  measure: approximate_web_usage_in_minutes {
    group_label: "Looker"
    type: sum
    sql: ${TABLE}.approximate_web_usage_in_minutes ;;
  }

  measure: average_runtime_in_seconds {
    group_label: "Looker"

    type: average
    sql: ${TABLE}.average_runtime_in_seconds ;;
  }

  dimension: company_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension_group: created {
    group_label: "Looker"

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
    group_label: "Looker"

    type: string
    sql: ${TABLE}.dashboard_title ;;
  }

  dimension: dialect {
    group_label: "Looker"

    type: string
    sql: ${TABLE}.dialect ;;
  }

  dimension: explore {
    group_label: "Looker"

    type: string
    sql: ${TABLE}.explore ;;
  }

  dimension: issuer_source {
    group_label: "Looker"

    type: string
    sql: ${TABLE}.issuer_source ;;
  }

  dimension: looker_usage_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.looker_usage_pk ;;
  }

  dimension: name {
    group_label: "Looker"

    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: rebuild_pdts_yes_no_ {
    group_label: "Looker"

    type: string
    sql: ${TABLE}.rebuild_pdts_yes_no_ ;;
  }

  dimension: status {
    group_label: "Looker"

    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: title {
    group_label: "Looker"

    type: string
    sql: ${TABLE}.title ;;
  }

  measure: query_count {
    group_label: "Looker"

    type: count
    drill_fields: [id, name]
  }
}
