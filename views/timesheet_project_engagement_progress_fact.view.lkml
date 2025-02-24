# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view

view: timesheet_project_engagement_progress_fact {
  sql_table_name: `ra-development.analytics.timesheet_project_engagement_progress_fact` ;;

  dimension: client_name {
    hidden: yes
    type: string
    sql: ${TABLE}.client_name ;;
  }
  dimension: deliverables {
    hidden: yes

    sql: ${TABLE}.deliverables ;;
  }
  dimension: engagement_description {
    hidden: yes

    type: string
    sql: ${TABLE}.engagement_description ;;
  }
  dimension: engagement_name {
    hidden: yes

    type: string
    sql: ${TABLE}.engagement_name ;;
  }

  dimension: deal_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.deal_id ;;
  }
  dimension: objectives {
    hidden: yes
    sql: ${TABLE}.objectives ;;
  }

}

view: timesheet_project_engagement_progress_fact__objectives {

  dimension: completion_score {
    group_label: "   Engagement Objectives"
    hidden: yes

    type: number
    sql: completion_score ;;
  }

  measure: avg_completion_score {
    group_label: "   Engagement Objectives"
    type: average
    value_format_name: decimal_1
    sql: cast(${completion_score} as numeric) ;;
  }
  dimension: objective_number {
    group_label: "   Engagement Objectives"
    primary_key: yes
    type: string
    sql: objective_number ;;
  }
  dimension: expected_benefit {
    group_label: "   Engagement Objectives"
    label: "    Expected Benefit"
    type: string
    sql: expected_benefit ;;
  }
  dimension: objective_details {
    group_label: "   Engagement Objectives"
    label: "  Objective Details"

    type: string
    sql: objective_details ;;
  }
  dimension: objective_metric {
    group_label: "   Engagement Objectives"
    label: "Objective Metric"

    type: string
    sql: objective_metric ;;
  }
  dimension: rationale {
    group_label: "   Engagement Objectives"

    type: string
    sql: rationale ;;
  }
  dimension: timesheet_project_engagement_progress_fact__objectives {
    type: string
    hidden: yes
    sql: timesheet_project_engagement_progress_fact__objectives ;;
  }
}

view: timesheet_project_engagement_progress_fact__deliverables {

  dimension: completion_score {
    type: string
    hidden: yes

    sql: completion_score ;;
  }
  measure: avg_completion_score {
    group_label: "   Engagement Deliverables"
    type: average
    value_format_name: decimal_1
    sql: cast(${completion_score} as numeric) ;;
  }
  dimension: deliverable_number {
    group_label: "   Engagement Deliverables"

    type: string
    sql: deliverable_number ;;
  }
  dimension: rationale {
    group_label: "   Engagement Deliverables"

    type: string
    sql: rationale ;;
  }
  dimension: timesheet_project_engagement_progress_fact__deliverables {
    type: string
    hidden: yes
    sql: timesheet_project_engagement_progress_fact__deliverables ;;
  }
}
