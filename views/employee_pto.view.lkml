view: employee_pto {
  sql_table_name: `ra-development.analytics_seed.employee_pto` ;;

  dimension: first_name {
    type: string
    sql: ${TABLE}.First_name ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.Last_name ;;
  }

  dimension: employee_name {
    type: string
    label: "Team Member"
    sql: CONCAT(${TABLE}.First_name, ' ', ${TABLE}.Last_name) ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension_group: pto_start {
    type: time
    label: "PTO Start"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Start_date ;;
  }

  dimension_group: pto_end {
    type: time
    label: "PTO End"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.End_date ;;
  }

  dimension: pto_days {
    type: number
    label: "PTO Days"
    sql: ${TABLE}.Days ;;
  }

  dimension: pto_type {
    type: string
    label: "PTO Type"
    sql: ${TABLE}.Type ;;
  }

  measure: count {
    type: count
    label: "Count of PTO Records"
    drill_fields: [employee_name, pto_start_date, pto_end_date, pto_days, pto_type]
  }

  measure: total_pto_days {
    type: sum
    label: "Total PTO Days"
    sql: ${pto_days} ;;
    value_format_name: decimal_2
  }

  measure: average_pto_days {
    type: average
    label: "Average PTO Days Per Record"
    sql: ${pto_days} ;;
    value_format_name: decimal_2
  }
}
