# engagement_actions_fact.view.lkml
# Exposes the wh_engagement_actions_fact dbt model (alias: engagement_actions_fact)
# Table: ra-development.analytics.engagement_actions_fact
# Partitioned by reporting_month (MONTH), clustered by engagement_code + status_area
#
# One row per action for an engagement month. Only status areas that are not green
# produce actions. Feeds the actions table.

view: engagement_actions_fact {
  sql_table_name: `ra-development.analytics.engagement_actions_fact` ;;

  dimension: engagement_action_pk {
    primary_key: yes
    hidden:      yes
    type:        string
    sql:         ${TABLE}.engagement_action_pk ;;
  }
  dimension: engagement_fk { hidden: yes type: string sql: ${TABLE}.engagement_fk ;; }

  dimension: engagement_code {
    label: "Engagement Code"
    type:  string
    sql:   ${TABLE}.engagement_code ;;
  }

  dimension: company_name {
    label: "Company Name"
    type:  string
    sql:   ${TABLE}.company_name ;;
  }

  dimension: engagement_name {
    label: "Engagement Name"
    type:  string
    sql:   ${TABLE}.engagement_name ;;
  }

  dimension_group: reporting_month {
    label:      "Reporting"
    type:       time
    timeframes: [month, quarter, year, date]
    datatype:   date
    convert_tz: no
    sql:        ${TABLE}.reporting_month ;;
  }

  dimension: status_area {
    label:       "Status Area"
    description: "Delivery, Commercial or Client."
    type:        string
    sql:         ${TABLE}.status_area ;;
  }

  dimension: status_area_status {
    label:       "Status"
    description: "The status of the area this action belongs to. Colour the row by this."
    type:        string
    sql:         ${TABLE}.status_area_status ;;
  }

  dimension: status_sort_order {
    hidden: yes
    type:   number
    sql:    ${TABLE}.status_sort_order ;;
  }

  dimension: priority {
    label:       "Priority"
    description: "Priority within the status area, starting at 1."
    type:        number
    sql:         ${TABLE}.priority ;;
  }

  dimension: owner {
    label:       "Owner"
    description: "Delivery lead, Engagement director, Finance, or Client sponsor."
    type:        string
    sql:         ${TABLE}.owner ;;
  }

  dimension: action {
    label: "Action"
    type:  string
    sql:   ${TABLE}.action ;;
  }

  dimension: triggered_by {
    label:       "Triggered By"
    description: "The figure or date that produced this action."
    type:        string
    sql:         ${TABLE}.triggered_by ;;
  }

  measure: action_count {
    label: "Actions"
    type:  count
    drill_fields: [status_area, priority, owner, action, triggered_by]
  }

  measure: red_action_count {
    label:   "Actions On Red Areas"
    type:    count
    filters: [status_area_status: "RED"]
  }

}
