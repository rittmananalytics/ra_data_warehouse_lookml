view: delivery_project_docs_dim {
  sql_table_name: `ra-development.analytics.delivery_project_docs_dim` ;;


  dimension: company_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.company_fk ;;
  }
  dimension: company_id {
    hidden: yes

    type: string
    sql: ${TABLE}.company_id ;;
  }
  dimension: delivery_project_docs_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.delivery_project_docs_pk ;;
  }
  dimension: page_contents {
  group_label: "Project Docs"
    type: string
    sql: ${TABLE}.page_contents ;;
  }
  dimension_group: page_created {
    group_label: "Project Docs"

    type: time
    timeframes: [date]
    sql: timestamp(${TABLE}.page_created_at_ts) ;;
  }
  dimension: page_id {
    hidden: yes

    type: number
    sql: ${TABLE}.page_id ;;
  }
  dimension: page_summary {
    group_label: "Project Docs"

    type: string
    sql: ${TABLE}.page_summary ;;
  }
  dimension: page_title {
    group_label: "Project Docs"

    type: string
    sql: ${TABLE}.page_title ;;
  }
  dimension: page_version_number {
    group_label: "Project Docs"

    type: number
    sql: ${TABLE}.page_version_number ;;
  }
  dimension: space_name {
    group_label: "Project Docs"

    type: string
    sql: ${TABLE}.space_name ;;
  }
  measure: count {
    group_label: "Project Docs"

    type: count
    drill_fields: [space_name]
  }
}
