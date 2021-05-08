view: scv {
  sql_table_name: `ra-development.xero_reports.scv`
    ;;

  dimension: account_code {
    type: string
    sql: ${TABLE}.account_code;;
  }

  dimension: pk {
    type: string
    primary_key: yes
    hidden: yes
    sql: concat(${period_date},${description}) ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: amount {
    type: string
    sql: ${TABLE}.amount ;;
  }

  measure: total_amount {
    type: sum
    value_format_name: gbp
    sql: case when ${TABLE}.account_code = '478' then ${TABLE}.amount+3500
         when ${TABLE}.account_code = '320' and ${TABLE}.amount > 800 then (${TABLE}.amount * 1.11) + 109
         else ${TABLE}.amount end ;;
  }

  dimension_group: period {
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
    sql: ${TABLE}.date ;;
  }

  dimension: description {
    sql: ${TABLE}.description ;;
    type: string
  }

  dimension: category {
    type: string
    sql: case when ${TABLE}.account_code = '478' then "Mark (Pro-Rata)"
         when ${TABLE}.account_code = '320' and ${TABLE}.amount > 800 then "Employees (Fully Loaded)"
         when ${TABLE}.account_code = '320' and ${TABLE}.amount < 800 then "Employees (Below NI+PAYE Threshold)"
         when ${TABLE}.account_code = '412' then "Contractors"
        else "Other" end ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }

  measure: count {
    type: count
    drill_fields: [account_name]
  }
}
