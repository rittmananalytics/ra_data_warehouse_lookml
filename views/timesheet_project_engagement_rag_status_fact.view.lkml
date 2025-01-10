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

    type: string
    sql: ${TABLE}.engagement_name ;;
  }
  dimension: overall_rag_status {
    type: string
    sql: ${TABLE}.overall_rag_status ;;
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
  dimension: resourcing_rag_status {
    type: string
    sql: ${TABLE}.resourcing_status ;;
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
  dimension: financials_rag_status {
    type: string
    sql: ${TABLE}.financials_status ;;
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
  dimension: scope_rag_status {
    type: string
    sql: ${TABLE}.scope_status ;;
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
  dimension: data_quality_qa_rag_status {
    type: string
    sql: ${TABLE}.data_quality_qa_status ;;
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
    sql: ${TABLE}.schedule_status ;;
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
  dimension: sprint_name {
    type: string
    sql: ${TABLE}.sprint_name ;;
  }
  dimension: technology_rag_status_rationale {
    type: string
    sql: ${TABLE}.technology_rationale ;;
  }
  dimension: technology_rag_status {
    type: string
    sql: ${TABLE}.technology_status ;;
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

}
