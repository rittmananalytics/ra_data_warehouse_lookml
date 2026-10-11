view: company_comparison {
  derived_table: {
    sql: SELECT *, safe_divide(value-lag(value) over (partition by company_name, measure order by year),lag(value) over (partition by company_name, measure order by year)) as pct_chg_yoy from `ra-development.analytics_seed.company_benchmarking_data` ;;
  }
  label: "Company Comparison"

  dimension: alias {
    sql: ${TABLE}.alias ;;
  }

  dimension: company_name {
    sql: ${TABLE}.company_name ;;
  }

  dimension: metric_name {
    hidden: yes
    sql: ${TABLE}.measure ;;
  }

  dimension: pct_chg_yoy {
    sql: ${TABLE}.pct_chg_yoy ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${company_name}, CAST(${year} AS STRING), ${metric_name}) ;;
  }

  dimension: segment {
    sql: ${TABLE}.segment ;;
  }

  dimension: value {
    hidden: yes
    sql: ${TABLE}.value ;;
  }

  dimension: year {
    value_format_name: id
    sql: ${TABLE}.year ;;
  }

  measure: admin_expenses {
    type: sum
    label: "Admin Expenses"
    group_label: "Metrics"
    value_format_name: gbp_0
    sql: ${value} ;;
    filters: [metric_name: "Admin Expenses"]
  }

  measure: admin_expenses_pct {
    type: number
    group_label: "Derived Metrics"
    value_format_name: percent_0
    sql: SAFE_DIVIDE(${admin_expenses}, ${sales}) ;;
  }

  measure: amount {
    type: sum
    hidden: yes
    sql: ${value} ;;
  }

  measure: avg_admin_expenses {
    type: average
    label: "avg Admin Expenses"
    group_label: "Metrics"
    value_format_name: gbp_0
    sql: ${value} ;;
    filters: [metric_name: "Admin Expenses"]
  }

  measure: avg_cost_of_sales {
    type: average
    label: "avg Cost Of Sales"
    group_label: "Metrics"
    value_format_name: gbp_0
    sql: ${value} ;;
    filters: [metric_name: "Cost Of Sales"]
  }

  measure: avg_employee_cost {
    type: number
    group_label: "Derived Metrics"
    value_format_name: gbp_0
    sql: SAFE_DIVIDE(${employee_costs}, ${number_of_employees}) ;;
  }

  measure: avg_employee_costs {
    type: average
    label: "avg Employee Costs"
    group_label: "Metrics"
    value_format_name: gbp_0
    sql: ${value} ;;
    filters: [metric_name: "Employee Costs"]
  }

  measure: avg_gross_profit {
    type: average
    label: "avg Gross Profit"
    group_label: "Metrics"
    value_format_name: gbp_0
    sql: ${value} ;;
    filters: [metric_name: "Gross Profit"]
  }

  measure: avg_number_of_employees {
    type: average
    label: "avg Number Of Employees"
    group_label: "Metrics"
    value_format_name: decimal_0
    sql: ${value} ;;
    filters: [metric_name: "Number Of Employees"]
  }

  measure: avg_operating_profit {
    type: average
    label: "avg Operating Profit"
    group_label: "Metrics"
    value_format_name: gbp_0
    sql: ${value} ;;
    filters: [metric_name: "Operating Profit"]
  }

  measure: avg_pre_tax_profit {
    type: average
    label: "avg Pre Tax Profit"
    group_label: "Metrics"
    value_format_name: gbp_0
    sql: ${value} ;;
    filters: [metric_name: "Pre-Tax Profit"]
  }

  measure: avg_retained_profit {
    type: average
    label: "avg Retained Profit"
    group_label: "Metrics"
    value_format_name: gbp_0
    sql: ${value} ;;
    filters: [metric_name: "Retained Profit"]
  }

  measure: avg_revenue_per_employee {
    type: number
    label: "Avg Revenue per Employee"
    group_label: "Derived Metrics"
    value_format_name: gbp_0
    sql: SAFE_DIVIDE(${sales}, ${number_of_employees}) ;;
  }

  measure: avg_sales {
    type: average
    label: "avg Sales"
    group_label: "Metrics"
    value_format_name: gbp_0
    sql: ${value} ;;
    filters: [metric_name: "Sales"]
  }

  measure: cost_of_sales {
    type: sum
    label: "Cost Of Sales"
    group_label: "Metrics"
    value_format_name: gbp_0
    sql: ${value} ;;
    filters: [metric_name: "Cost Of Sales"]
  }

  measure: cost_of_sales_chg_pct_yoy {
    type: sum
    label: "Cost Of Sales chg pct yoy"
    group_label: "Metrics"
    value_format_name: gbp_0
    sql: ${pct_chg_yoy} ;;
    filters: [metric_name: "Cost Of Sales"]
  }

  measure: cost_of_sales_pct {
    type: number
    group_label: "Derived Metrics"
    value_format_name: percent_0
    sql: SAFE_DIVIDE(${cost_of_sales}, ${sales}) ;;
  }

  measure: dividends_paid {
    type: sum
    label: "Dividends Paid"
    group_label: "Metrics"
    hidden: yes
    value_format_name: gbp_0
    sql: ${value} ;;
    filters: [metric_name: "Dividends Paid"]
  }

  measure: ebitda {
    type: sum
    label: "EBITDA"
    group_label: "Metrics"
    hidden: yes
    value_format_name: gbp_0
    sql: ${value} ;;
    filters: [metric_name: "EBITDA"]
  }

  measure: ebitda_pct {
    type: number
    group_label: "Derived Metrics"
    hidden: yes
    value_format_name: percent_0
    sql: SAFE_DIVIDE(${ebitda}, ${sales}) ;;
  }

  measure: employee_costs {
    type: sum
    label: "Employee Costs"
    group_label: "Metrics"
    hidden: yes
    value_format_name: gbp_0
    sql: ${value} ;;
    filters: [metric_name: "Employee Costs"]
  }

  measure: gross_margin_pct {
    type: number
    group_label: "Derived Metrics"
    value_format_name: percent_0
    sql: SAFE_DIVIDE(${gross_profit}, ${sales}) ;;
  }

  measure: gross_profit {
    type: sum
    label: "Gross Profit"
    group_label: "Metrics"
    value_format_name: gbp_0
    sql: ${value} ;;
    filters: [metric_name: "Gross Profit"]
  }

  measure: interest_payable {
    type: sum
    label: "Interest Payable"
    group_label: "Metrics"
    hidden: yes
    value_format_name: gbp_0
    sql: ${value} ;;
    filters: [metric_name: "Interest Payable"]
  }

  measure: interest_receivable {
    type: sum
    label: "Interest Receivable"
    group_label: "Metrics"
    hidden: yes
    value_format_name: gbp_0
    sql: ${value} ;;
    filters: [metric_name: "Interest Receivable"]
  }

  measure: net_margin_pct {
    type: number
    group_label: "Derived Metrics"
    value_format_name: percent_0
    sql: SAFE_DIVIDE(${pre_tax_profit}, ${sales}) ;;
  }

  measure: number_of_employees {
    type: sum
    label: "Number Of Employees"
    group_label: "Metrics"
    hidden: yes
    value_format_name: decimal_0
    sql: ${value} ;;
    filters: [metric_name: "Number Of Employees"]
  }

  measure: operating_profit {
    type: sum
    label: "Operating Profit"
    group_label: "Metrics"
    value_format_name: gbp_0
    sql: ${value} ;;
    filters: [metric_name: "Operating Profit"]
  }

  measure: operating_profit_chg_pct_yoy {
    type: average
    label: "Operating Profit chg pct yoy"
    group_label: "Metrics"
    value_format_name: percent_0
    sql: ${pct_chg_yoy} ;;
    filters: [metric_name: "Operating Profit"]
  }

  measure: other_income_or_grants {
    type: sum
    label: "Other Income Or Grants"
    group_label: "Metrics"
    hidden: yes
    value_format_name: gbp_0
    sql: ${value} ;;
    filters: [metric_name: "Other Income Or Grants"]
  }

  measure: pre_tax_profit {
    type: sum
    label: "Pre Tax Profit"
    group_label: "Metrics"
    hidden: yes
    value_format_name: gbp_0
    sql: ${value} ;;
    filters: [metric_name: "Pre-Tax Profit"]
  }

  measure: pre_tax_profit_chg_pct_yoy {
    type: average
    label: "Pre Tax Profit chg pct yoy"
    group_label: "Metrics"
    hidden: yes
    value_format_name: gbp_0
    sql: ${pct_chg_yoy} ;;
    filters: [metric_name: "Pre-Tax Profit"]
  }

  measure: profit_after_tax {
    type: sum
    label: "Profit After Tax"
    group_label: "Metrics"
    hidden: yes
    value_format_name: gbp_0
    sql: ${value} ;;
    filters: [metric_name: "Profit After Tax"]
  }

  measure: retained_earnings_per_employee {
    type: number
    label: "Retained Earnings per Employee"
    group_label: "Derived Metrics"
    description: "Looker calculation retained_earnings_per_employee on dashboard 330 tile 3163"
    value_format_name: gbp_0
    sql: SAFE_DIVIDE(${avg_retained_profit}, ${avg_number_of_employees}) ;;
  }

  measure: retained_profit {
    type: sum
    label: "Retained Profit"
    group_label: "Metrics"
    hidden: yes
    value_format_name: gbp_0
    sql: ${value} ;;
    filters: [metric_name: "Retained Profit"]
  }

  measure: retained_profit_pct {
    type: number
    group_label: "Derived Metrics"
    value_format_name: percent_0
    sql: SAFE_DIVIDE(${retained_profit}, ${sales}) ;;
  }

  measure: revenue_per_employee {
    type: number
    group_label: "Derived Metrics"
    hidden: yes
    value_format_name: gbp_0
    sql: SAFE_DIVIDE(${sales}, ${number_of_employees}) ;;
  }

  measure: revenue_per_employee_avg_headcount {
    type: number
    label: "Revenue per Employee"
    group_label: "Derived Metrics"
    description: "Sales over average employees (Looker calculation revenue_per_employee on dashboard 330 tile 3163)"
    value_format_name: gbp_0
    sql: SAFE_DIVIDE(${sales}, ${avg_number_of_employees}) ;;
  }

  measure: sales {
    type: sum
    label: "Sales"
    group_label: "Metrics"
    value_format_name: gbp_0
    sql: ${value} ;;
    filters: [metric_name: "Sales"]
  }

  measure: sales_chg_pct_yoy {
    type: average
    label: "Sales chg pct yoy"
    group_label: "Metrics"
    value_format_name: percent_0
    sql: ${pct_chg_yoy} ;;
    filters: [metric_name: "Sales"]
  }

  measure: staff_revenue_to_cost_ratio {
    type: number
    group_label: "Derived Metrics"
    hidden: yes
    value_format_name: decimal_2
    sql: SAFE_DIVIDE(${revenue_per_employee}, ${avg_employee_cost}) ;;
  }

  measure: tax {
    type: sum
    label: "Tax"
    group_label: "Metrics"
    value_format_name: gbp_0
    sql: ${value} ;;
    filters: [metric_name: "Tax"]
  }
}
