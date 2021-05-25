view: fy2019_accounts {
  sql_table_name: `{{ _user_attributes['dataset'] }}.xero_reports.fy2019_accounts`
    ;;

  dimension: account {
    type: string
    sql: case when ${TABLE}.account = 'Dividends' then 'Salaries' else ${TABLE}.account end;;
  }

  dimension: amount_gbp {
    type: number
    sql: ${TABLE}.amount_gbp ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension_group: month {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.month ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}