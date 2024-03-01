# The name of this view in Looker is "Company Comparison"
view: company_comparison {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics_seed.company_comparison` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Company Name" in Explore.

  dimension: company_name {
    type: string
    sql: ${TABLE}.company_name ;;
  }

  dimension: pk {
    type: string
    primary_key: yes
    hidden: yes
    sql: concat(${company_name},${year},${measure}) ;;
  }

  dimension: total_years_operating {
    type: number
    value_format_name: id
    sql: ${TABLE}.total_years_operating ;;
  }

  dimension: year_founded {
    type: number
    value_format_name: id
    sql: ${TABLE}.year_founded ;;
  }

  dimension: measure {
    type: string
    sql: ${TABLE}.measure ;;
  }

  measure: amount {
    type: sum
    sql: ${TABLE}.value;;
  }

  dimension: value {
    type: number
    sql: ${TABLE}.value ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: Turnover {
    type: sum
    value_format_name: gbp_0

    group_label: "Metrics"
    sql: ${value} ;;
    filters: [measure: "Turnover"]
    }

  measure: Other_Income_Or_Grants {
    group_label: "Metrics"
    value_format_name: gbp_0

    type: sum
    sql: ${value} ;;
    filters: [measure: "Other Income Or Grants"]
  }

  measure: Cost_Of_Sales {
    group_label: "Metrics"
    value_format_name: gbp_0

    type: sum
    sql: ${value} ;;
    filters: [measure: "Cost Of Sales"]
  }

  measure: Gross_Profit {
    group_label: "Metrics"
    value_format_name: gbp_0

    type: sum
    sql: ${value} ;;
    filters: [measure: "Gross Profit"]
  }

  measure: Admin_Expenses {
    group_label: "Metrics"
    value_format_name: gbp_0

    type: sum
    sql: ${value} ;;
    filters: [measure: "Admin Expenses"]
  }

  measure: Operating_Profit {
    group_label: "Metrics"
    value_format_name: gbp_0

    type: sum
    sql: ${value} ;;
    filters: [measure: "Operating Profit"]
  }

  measure: Interest_Payable {
    group_label: "Metrics"
    value_format_name: gbp_0

    type: sum
    sql: ${value} ;;
    filters: [measure: "Interest Payable"]
  }

  measure: Interest_Receivable {
    group_label: "Metrics"
    value_format_name: gbp_0

    type: sum
    sql: ${value} ;;
    filters: [measure: "Interest Receivable"]
  }

  measure: Pre_Tax_Profit {
    group_label: "Metrics"
    value_format_name: gbp_0

    type: sum
    sql: ${value} ;;
    filters: [measure: "Pre-Tax Profit"]
  }

  measure: Tax {
    group_label: "Metrics"
    value_format_name: gbp_0

    type: sum
    sql: ${value} ;;
    filters: [measure: "Tax"]
  }

  measure: Profit_After_Tax {
    group_label: "Metrics"
    value_format_name: gbp_0

    type: sum
    sql: ${value} ;;
    filters: [measure: "Profit After Tax"]
  }

  measure: Dividends_Paid {
    group_label: "Metrics"
    value_format_name: gbp_0

    type: sum
    sql: ${value} ;;
    filters: [measure: "Dividends Paid"]
  }

  measure: Retained_Profit {
    group_label: "Metrics"
    value_format_name: gbp_0

    type: sum
    sql: ${value} ;;
    filters: [measure: "Retained Profit"]
  }

  measure: Employee_Costs {
    group_label: "Metrics"
    value_format_name: gbp_0
    type: sum
    sql: ${value} ;;
    filters: [measure: "Employee Costs"]
  }

  measure: Number_Of_Employees {
    group_label: "Metrics"

    type: sum
    sql: ${value} ;;
    filters: [measure: "Number Of Employees"]
  }

  measure: EBITDA {
    group_label: "Metrics"
    value_format_name: gbp_0

    type: sum
    sql: ${value} ;;
    filters: [measure: "EBITDA"]
  }

  measure: revenue_per_employee {
    group_label: "Derived Metrics"
    value_format_name: gbp_0
    type: number
    sql: ${Turnover}/${Number_Of_Employees} ;;
  }

  dimension: years_operating {
    type: number
    value_format_name: id
    sql: ${TABLE}.years_operating ;;
  }

  measure: gross_margin_pct {
    group_label: "Derived Metrics"

    type: number
    value_format_name: percent_0
    sql: ${Gross_Profit}/${Turnover} ;;
  }



  measure: cost_of_sales_pct {
    group_label: "Derived Metrics"
    value_format_name: percent_0

    type: number
    sql: ${Cost_Of_Sales}/${Turnover} ;;
  }

  measure: retained_profit_pct {
    group_label: "Derived Metrics"
    value_format_name: percent_0

    type: number
    sql: ${Retained_Profit}/${Turnover} ;;
  }

  measure: avg_employee_cost {
    group_label: "Derived Metrics"
    value_format_name: gbp_0

    type: number
    sql: ${Employee_Costs}/${Number_Of_Employees} ;;
  }

  measure: admin_expenses_pct {
    group_label: "Derived Metrics"
    value_format_name: percent_0

    type: number
    sql: ${Admin_Expenses}/${Turnover} ;;
  }

  measure: ebitda_pct {
    group_label: "Derived Metrics"
    value_format_name: percent_0

  type: number
  sql: ${EBITDA}/${Turnover} ;;
  }

  measure: net_margin_pct {
    group_label: "Derived Metrics"
    value_format_name: percent_0

    type: number
    sql: ${Pre_Tax_Profit}/${Turnover} ;;
  }

  measure: staff_revenue_to_cost_ratio {
    group_label: "Derived Metrics"
    value_format_name: decimal_2
    type: number
    sql: ${revenue_per_employee}/${avg_employee_cost} ;;
  }

  dimension: year {
    type: number
    value_format_name: id
    sql: ${TABLE}.year ;;
  }

}
