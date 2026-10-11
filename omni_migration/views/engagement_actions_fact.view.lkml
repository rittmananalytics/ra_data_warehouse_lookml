view: engagement_actions_fact {
  sql_table_name: `ra-development.analytics.engagement_actions_fact` ;;

  dimension: action {
    type: string
    label: "Action"
    sql: ${TABLE}.action ;;
  }

  dimension: company_name {
    type: string
    label: "Company Name"
    sql: ${TABLE}.company_name ;;
  }

  dimension: engagement_action_pk {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.engagement_action_pk ;;
  }

  dimension: engagement_code {
    type: string
    label: "Engagement Code"
    sql: ${TABLE}.engagement_code ;;
  }

  dimension: engagement_fk {
    type: string
    hidden: yes
    sql: ${TABLE}.engagement_fk ;;
  }

  dimension: engagement_name {
    type: string
    label: "Engagement Name"
    sql: ${TABLE}.engagement_name ;;
  }

  dimension: owner {
    type: string
    label: "Owner"
    description: "Delivery lead, Engagement director, Finance, or Client sponsor."
    sql: ${TABLE}.owner ;;
  }

  dimension: priority {
    type: number
    label: "Priority"
    description: "Priority within the status area, starting at 1."
    sql: ${TABLE}.priority ;;
  }

  dimension: status_area {
    type: string
    label: "Status Area"
    description: "Delivery, Commercial or Client."
    sql: ${TABLE}.status_area ;;
  }

  dimension: status_area_status {
    type: string
    label: "Status"
    description: "The status of the area this action belongs to. Colour the row by this."
    sql: ${TABLE}.status_area_status ;;
  }

  dimension: status_sort_order {
    type: number
    hidden: yes
    sql: ${TABLE}.status_sort_order ;;
  }

  dimension: triggered_by {
    type: string
    label: "Triggered By"
    description: "The figure or date that produced this action."
    sql: ${TABLE}.triggered_by ;;
  }

  dimension_group: reporting_month {
    type: time
    timeframes: [raw, date, month, quarter, year]
    datatype: date
    convert_tz: no
    label: "Reporting"
    sql: ${TABLE}.reporting_month ;;
  }

  measure: action_count {
    type: count
    label: "Actions"
    drill_fields: [engagement_actions_fact.status_area, engagement_actions_fact.priority, engagement_actions_fact.owner, engagement_actions_fact.action, engagement_actions_fact.triggered_by]
  }

  measure: red_action_count {
    type: count
    label: "Actions On Red Areas"
    filters: [status_area_status: "RED"]
  }
}
