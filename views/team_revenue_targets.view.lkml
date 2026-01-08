view: team_revenue_targets {
  sql_table_name: `ra-development.analytics_seed.team_revenue_targets` ;;

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
    sql: timestamp(${TABLE}.month) ;;
  }
  measure: revenue_target {
    type: sum_distinct
    value_format_name: gbp_0
    sql: ${TABLE}.revenue_target ;;
  }
  dimension: pk {
    type: string
    primary_key: yes
    hidden: yes
    sql: concat(${month_month},${contact_name}) ;;
  }
  measure: count {
    type: count
    drill_fields: [contact_name]
  }
}
