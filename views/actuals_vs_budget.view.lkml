view: actuals_vs_budget {
  sql_table_name: `ra-development.xero_reports.actuals_vs_budget`
    ;;

  dimension: account {
    type: string
    sql: ${TABLE}.Account ;;
  }

  dimension: pk {
    type: string
    primary_key: yes
    hidden: yes
    sql: concat(${period_date},${description}) ;;
  }

  dimension: account_code {
    type: string
    sql: ${TABLE}.Account_Code ;;
  }

  dimension: actual_amount {
    type: number
    sql: ${TABLE}.report_amount ;;
  }

  measure: total_actual_amount {
    type: sum
    sql: ${actual_amount} ;;
  }

  measure: total_budget_amount {
    type: sum
    sql: ${budget} ;;
  }

  measure: total_variance {
    type: sum
    sql: ${budget_variance} ;;
  }

  dimension: actual_to_target_pct {
    type: number
    sql: ${TABLE}.actual_to_target_pct ;;
  }

  dimension: budget {
    type: number
    sql: ${TABLE}.report_budget ;;
  }

  dimension: budget_variance {
    type: number
    sql: ${TABLE}.budget_variance ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.Description ;;
  }

  dimension: organization_currency {
    type: string
    sql: ${TABLE}.Organization_Currency ;;
  }

  dimension: organization_name {
    type: string
    sql: ${TABLE}.Organization_Name ;;
  }

  dimension_group: period {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      month_num,
      fiscal_month_num,
      fiscal_quarter_of_year,
      fiscal_quarter,
      quarter_of_year,
      quarter,
      year,
      fiscal_year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Period ;;
  }

  dimension: report_amount {
    type: number
    sql: ${TABLE}.report_amount ;;
  }

  dimension: report_sort_order {
    type: number
    sql: ${TABLE}.report_sort_order ;;
  }

  dimension: reporting {
    type: string

    sql: ${TABLE}.Reporting ;;
  }

  dimension: reporting_code {
    type: string
    sql: ${TABLE}.Reporting_Code ;;
  }

  dimension: tracking_category1 {
    type: string
    sql: ${TABLE}.Tracking_Category1 ;;
  }

  dimension: tracking_category2 {
    type: string
    sql: ${TABLE}.Tracking_Category2 ;;
  }

  dimension: type {
    type: string
    order_by_field: report_sort_order

    sql: case when ${TABLE}.Type = 'REVENUE' then 'Sales'
              when ${TABLE}.type = 'DIRECTCOSTS' then 'Direct Costs'
              when ${TABLE}.type = 'OVERHEADS' then 'Operating Expenses'
              when ${TABLE}.type = 'EXPENSE' then 'Operating Expenses'
              end ;;
  }

  measure: count {
    type: count
    drill_fields: [organization_name]
  }
}
