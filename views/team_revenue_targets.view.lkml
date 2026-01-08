view: team_revenue_targets {
  sql_table_name: `ra-development.analytics_seed.consultant_targets_grades` ;;

  dimension: contact_name {
    type: string
    sql: ${TABLE}.contact_name ;;
  }
  dimension_group: month {
    type: time
    description: "%m-%d-%E4Y"
    timeframes: [raw,month, quarter, year]
    convert_tz: no
    datatype: timestamp
    sql: TIMESTAMP(PARSE_DATE('%d-%m-%Y', month)) ;;
  }
  measure: revenue_target {
    type: sum_distinct
    value_format_name: gbp_0
    sql: ${TABLE}.revenue_target ;;
  }
  measure: utilisation_target {
    type: average_distinct
    value_format_name: percent_0
    sql: ${TABLE}.utilisation_target ;;
  }
  dimension: pk {
    type: string
    primary_key: yes
    hidden: yes
    sql: concat(${month_month},${contact_name}) ;;
  }
  dimension: consultant_grade {
    type: string
    sql: ${TABLE}.consultant_grade ;;
  }
  dimension: consultant_hours_multiplier {
    type: number
    sql: ${TABLE}.consultant_hours_multiplier ;;
  }
  measure: count {
    type: count
    drill_fields: [contact_name]
  }
}
