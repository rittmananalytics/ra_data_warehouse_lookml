view: team_revenue_targets {
  sql_table_name: `ra-development.analytics_seed.consultant_targets_grades` ;;

  dimension: consultant_grade {
    type: string
    sql: ${TABLE}.consultant_grade ;;
  }

  dimension: consultant_hours_multiplier {
    type: number
    sql: ${TABLE}.consultant_hours_multiplier ;;
  }

  dimension: contact_name {
    type: string
    sql: ${TABLE}.contact_name ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: concat(${month_month},${contact_name}) ;;
  }

  dimension_group: month {
    type: time
    timeframes: [raw, date, month, quarter, year]
    convert_tz: no
    description: "%m-%d-%E4Y"
    sql: TIMESTAMP(PARSE_DATE('%d-%m-%Y', month)) ;;
  }

  measure: count {
    type: count
    drill_fields: [team_revenue_targets.contact_name]
  }

  measure: revenue_target {
    type: sum_distinct
    value_format_name: gbp_0
    sql: ${TABLE}.revenue_target ;;
    sql_distinct_key: ${pk} ;;
  }

  measure: utilisation_target {
    type: average_distinct
    value_format_name: percent_0
    sql: ${TABLE}.utilisation_target ;;
    sql_distinct_key: ${pk} ;;
  }
}
