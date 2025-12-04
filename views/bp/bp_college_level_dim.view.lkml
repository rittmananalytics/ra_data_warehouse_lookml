view: bp_college_level_dim {
  sql_table_name: `ra-development.bp_analytics_bp_analytics.college_level_dim` ;;

  # Primary Key
  dimension: college_level_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.college_level_pk ;;
    hidden: yes
  }

  # IDs
  dimension: college_level_id {
    type: number
    sql: ${TABLE}.college_level_id ;;
    label: "College Level ID"
  }

  dimension: college_level_code {
    type: string
    sql: ${TABLE}.college_level_code ;;
    label: "College Level Code"
  }

  dimension: college_level_name {
    type: string
    sql: ${TABLE}.college_level_name ;;
    label: "College Level"
  }

  # Manager Information
  dimension: manager_id {
    type: number
    sql: ${TABLE}.manager_id ;;
    label: "Manager ID"
  }

  dimension: manager_first_name {
    type: string
    sql: ${TABLE}.manager_first_name ;;
    label: "Manager First Name"
  }

  dimension: manager_surname {
    type: string
    sql: ${TABLE}.manager_surname ;;
    label: "Manager Surname"
  }

  dimension: manager_full_name {
    type: string
    sql: ${TABLE}.manager_full_name ;;
    label: "Manager"
  }

  # Timestamps
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_ts ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.updated_ts ;;
  }

  # Measures
  measure: total_college_levels {
    type: count
    label: "Total College Levels"
    drill_fields: [college_level_code, college_level_name, manager_full_name]
  }
}
