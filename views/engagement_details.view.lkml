# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view

view: engagement_details {
  sql_table_name: `ra-development.analytics_docai_europe_west2.engagement_details` ;;

  dimension: background {
    group_label: "Engagement Background"
    type: string
    sql: ${TABLE}.background ;;
  }
  dimension: deal_id {
    type: number
    hidden: yes
    sql: ${TABLE}.deal_id ;;
  }
  dimension: deliverables {
    hidden: yes
    sql: ${TABLE}.deliverables ;;
  }
  dimension: deliverables_json {
    type: string
    hidden: yes
    sql: ${TABLE}.deliverables_json ;;
  }
  dimension: objectives {
    hidden: yes
    sql: ${TABLE}.objectives ;;
  }
  dimension: objectives_json {
    type: string
    hidden: yes
    sql: ${TABLE}.objectives_json ;;
  }
  dimension: requirements {
    group_label: "Engagement Background"

    type: string
    sql: ${TABLE}.requirements ;;
  }
  dimension: solution {
    group_label: "Engagement Background"

    type: string
    sql: ${TABLE}.solution ;;
  }

}

view: engagement_details__objectives {

  dimension: engagement_details__objectives {
    type: string
    hidden: yes
    sql: engagement_details__objectives ;;
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
  dimension: objective_number {
    group_label: "   Engagement Objectives"
    label: "     Objective #"
    type: string
    sql: objective_number ;;
  }
}

view: engagement_details__deliverables {

  dimension: acceptance_criteria {
    group_label: "  Engagement Deliverables"
    label: "Acceptance Criteria"

    type: string
    sql: acceptance_criteria ;;
  }
  dimension: deliverable_details {
    group_label: "  Engagement Deliverables"
    label: "  Deliverable Details"

    type: string
    sql: deliverable_details ;;
  }
  dimension: deliverable_format {
    group_label: "  Engagement Deliverables"
    label: "    Deliverable Format"

    type: string
    sql: deliverable_format ;;
  }
  dimension: deliverable_number {
    group_label: "  Engagement Deliverables"
    label: "     Deliverable #"

    type: string
    sql: deliverable_number ;;
  }
  dimension: engagement_details__deliverables {
    type: string
    hidden: yes
    sql: engagement_details__deliverables ;;
  }
}
