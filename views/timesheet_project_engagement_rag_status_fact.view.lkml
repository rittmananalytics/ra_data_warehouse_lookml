view: timesheet_project_engagement_rag_status_fact {
  sql_table_name: `ra-development.analytics.timesheet_project_engagement_rag_status_fact` ;;

  dimension: client_name {
    hidden: yes
    type: string
    sql: ${TABLE}.client_name ;;
  }
  dimension: engagement_description {
    hidden: no

    type: string
    sql: ${TABLE}.engagement_description ;;
  }
  dimension: engagement_name {
    hidden: no
    link: {label: "View Project Dashboard" url: "/dashboards/311?Engagement+Name={{ value }}" icon_url: "https://rittman.eu.looker.com/favicon.ico"}
    type: string
    sql: ${TABLE}.engagement_name ;;
  }
  dimension: overall_rag_status {
    type: string
    sql: UPPER(${TABLE}.overall_rag_status) ;;
    html:
    {% if value == 'RED' %}
    <p style="color: white; background-color: red; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% elsif value == 'AMBER' %}
    <p style="color: white; background-color: orange; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color: white; background-color: green; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% endif %}
    ;;
  }
  dimension: overall_rag_status_rationale {
    type: string
    sql: ${TABLE}.overall_rag_status_reason ;;
  }
  dimension: overall_rag_status_rationale_evidence {
    type: string
    sql: ${TABLE}.overall_status_rationale_evidence ;;
  }
  dimension_group: reporting {
    type: time
    timeframes: [month]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.reporting_month ;;
  }
  dimension: resourcing_status_rationale {
    type: string
    sql: ${TABLE}.resourcing_rationale ;;
  }
  dimension: resourcing_status_rationale_evidence {
    type: string
    sql: ${TABLE}.resourcing_status_rationale_evidence ;;
  }
  dimension: resourcing_rag_status {
    type: string
    sql: UPPER(${TABLE}.resourcing_status) ;;
    html:
    {% if value == 'RED' %}
    <p style="color: white; background-color: red; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% elsif value == 'AMBER' %}
    <p style="color: white; background-color: orange; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color: white; background-color: green; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% endif %}
    ;;
  }

  dimension: financials_status_rationale {
    type: string
    sql: ${TABLE}.financials_status_rationale ;;
  }
  dimension: financials_status_rationale_evidence {
    type: string
    sql: ${TABLE}.financials_status_rationale_evidence ;;
  }
  dimension: financials_rag_status {
    type: string
    sql: UPPER(${TABLE}.financials_status) ;;
    html:
    {% if value == 'RED' %}
    <p style="color: white; background-color: red; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% elsif value == 'AMBER' %}
    <p style="color: white; background-color: orange; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color: white; background-color: green; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% endif %}
    ;;
  }

  dimension: scope_status_rationale {
    type: string
    sql: ${TABLE}.scope_status_rationale ;;
  }
  dimension: scope_status_rationale_evidence {
    type: string
    sql: ${TABLE}.scope_status_rationale_evidence ;;
  }
  dimension: scope_rag_status {
    type: string
    sql: UPPER(${TABLE}.scope_status) ;;
    html:
    {% if value == 'RED' %}
    <p style="color: white; background-color: red; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% elsif value == 'AMBER' %}
    <p style="color: white; background-color: orange; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color: white; background-color: green; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% endif %}
    ;;
  }

  dimension: data_quality_qa_status_rationale {
    type: string
    sql: ${TABLE}.data_quality_qa_rationale ;;
  }
  dimension: data_quality_qa_status_rationale_evidence {
    type: string
    sql: ${TABLE}.data_quality_qa_status_rationale_evidence ;;
  }
  dimension: data_quality_qa_rag_status {
    type: string
    sql: UPPER(${TABLE}.data_quality_qa_status) ;;
    html:
    {% if value == 'RED' %}
    <p style="color: white; background-color: red; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% elsif value == 'AMBER' %}
    <p style="color: white; background-color: orange; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color: white; background-color: green; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% endif %}
    ;;
  }

  dimension: schedule_rag_status {
    type: string
    sql: UPPER(${TABLE}.schedule_status) ;;
    html:
    {% if value == 'RED' %}
    <p style="color: white; background-color: red; font-size:100%; text-align:center; vertical-align: middle;">{{ rendered_value }}</p>
    {% elsif value == 'AMBER' %}
    <p style="color: white; background-color: orange; font-size:100%; text-align:center; vertical-align: middle">{{ rendered_value }}</p>
    {% else %}
    <p style="color: white; background-color: green; font-size:100%; text-align:center; vertical-align: middle">{{ rendered_value }}</p>
    {% endif %}
    ;;
  }
  dimension: schedule_rag_status_rationale {
    type: string
    sql: ${TABLE}.schedule_status_rationale ;;
  }
  dimension: schedule_rag_status_rationale_evidence {
    type: string
    sql: ${TABLE}.schedule_status_rationale_evidence ;;
  }
  dimension: sprint_name {
    type: string
    sql: ${TABLE}.sprint_name ;;
  }
  dimension: technology_rag_status_rationale {
    type: string
    sql: ${TABLE}.technology_rationale ;;
  }
  dimension: technology_rag_status_rationale_evidence {
    type: string
    sql: ${TABLE}.technology_status_rationale_evidence ;;
  }
  dimension: technology_rag_status {
    type: string
    sql: UPPER(${TABLE}.technology_status) ;;
    html:
    {% if value == 'RED' %}
    <p style="color: white; background-color: red; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% elsif value == 'AMBER' %}
    <p style="color: white; background-color: orange; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color: white; background-color: green; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% endif %}
    ;;
  }

  dimension: month_timeline_events {
    hidden: yes
    sql: ${TABLE}.month_timeline_events ;;
  }

  dimension: ra_action_points {
    hidden: yes
    sql: ${TABLE}.ra_action_points ;;
  }

  dimension: client_action_points {
    hidden: yes
    sql: ${TABLE}.client_action_points ;;
  }

}

view: timesheet_project_engagement_rag_status_fact__ra_action_points {

  dimension: action_number {
    group_label: "RA Action Points"
    label: "Action Point Number"
    type: number
    sql: action_number ;;
  }
  dimension: action_point {
    group_label: "RA Action Points"
    order_by_field: action_number
    type: string
    sql: action_point ;;
  }
  dimension: timesheet_project_engagement_rag_status_fact__ra_action_points {
    type: string
    hidden: yes
    sql: timesheet_project_engagement_rag_status_fact__ra_action_points ;;
  }
}

view: timesheet_project_engagement_rag_status_fact__client_action_points {

  dimension: action_number {
    group_label: "Client Action Points"
    label: "Action Point Number"
    type: number
    sql: action_number ;;
  }
  dimension: action_point {
    group_label: "Client Action Points"
    order_by_field: action_number
    type: string
    sql: action_point ;;
  }
  dimension: timesheet_project_engagement_rag_status_fact__client_action_points {
    type: string
    hidden: yes
    sql: timesheet_project_engagement_rag_status_fact__client_action_points ;;
  }
}

view: timesheet_project_engagement_rag_status_fact__month_timeline_events {

  dimension_group: event_date {
    group_label: "Engagement Timeline"
    label: "Event"
    type: time
    timeframes: [date]
    sql: timestamp(event_date) ;;
  }
  dimension: event_description {
    group_label: "Engagement Timeline"

    type: string
    sql: event_description ;;
  }
  dimension: timesheet_project_engagement_rag_status_fact__month_timeline_events {
    type: string
    hidden: yes
    sql: timesheet_project_engagement_rag_status_fact__month_timeline_events ;;
  }
}
