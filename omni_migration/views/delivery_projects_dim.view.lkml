view: delivery_projects_dim {
  sql_table_name: `ra-development.analytics.delivery_projects_dim` ;;

  dimension: company_pk {
    hidden: yes
    sql: ${TABLE}.company_fk ;;
  }

  dimension: delivery_project_pk {
    hidden: yes
    sql: ${TABLE}.delivery_project_pk ;;
  }

  dimension: project_category_description {
    group_label: "Delivery Projects"
    sql: ${TABLE}.project_category_description ;;
  }

  dimension: project_category_name {
    group_label: "Delivery Projects"
    sql: ${TABLE}.project_category_name ;;
  }

  dimension: project_id {
    group_label: "Delivery Projects"
    sql: ${TABLE}.project_id ;;
  }

  dimension: project_name {
    group_label: "Delivery Projects"
    sql: ${TABLE}.project_name ;;
  }

  dimension: project_notes {
    group_label: "Delivery Projects"
    sql: ${TABLE}.project_notes ;;
  }

  dimension: project_status {
    group_label: "Delivery Projects"
    sql: ${TABLE}.project_status ;;
  }

  dimension: project_type {
    group_label: "Delivery Projects"
    sql: ${TABLE}.project_type ;;
  }

  dimension_group: project_created {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    group_label: "Delivery Projects"
    sql: date(${TABLE}.project_created_at_ts) ;;
  }

  dimension_group: project_modified_at_ts {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    hidden: yes
    sql: ${TABLE}.project_modified_at_ts ;;
  }
}
