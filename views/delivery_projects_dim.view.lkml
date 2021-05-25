view: delivery_projects_dim {
  sql_table_name: `{{ _user_attributes['dbt_dataset'] }}.delivery_projects_dim`
    ;;

  dimension: company_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension: delivery_project_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.delivery_project_pk ;;
  }

  measure: count_delivery_projects {
    type: count_distinct
    sql: ${TABLE}.delivery_project_pk ;;
  }

  dimension: project_category_description {
  group_label: "Delivery Projects"

    type: string
    sql: ${TABLE}.project_category_description ;;
  }

  dimension: project_category_name {
    group_label: "Delivery Projects"

    type: string
    sql: ${TABLE}.project_category_name ;;
  }

  dimension: project_created {
    group_label: "Delivery Projects"

    type: date

    sql: date(${TABLE}.project_created_at_ts) ;;
  }

  dimension: project_id {
    group_label: "Delivery Projects"

    type: string
    sql: ${TABLE}.project_id ;;
  }

  dimension_group: project_modified_at_ts {
    hidden: yes
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
    sql: ${TABLE}.project_modified_at_ts ;;
  }

  dimension: project_name {
    group_label: "Delivery Projects"

    type: string
    sql: ${TABLE}.project_name ;;
  }

  dimension: project_notes {
    group_label: "Delivery Projects"

    type: string
    sql: ${TABLE}.project_notes ;;
  }

  dimension: project_status {
    group_label: "Delivery Projects"

    type: string
    sql: ${TABLE}.project_status ;;
  }

  dimension: project_type {
    group_label: "Delivery Projects"

    type: string
    sql: ${TABLE}.project_type ;;
  }


}