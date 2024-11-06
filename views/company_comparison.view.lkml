# The name of this view in Looker is "Company Comparison"
view: company_comparison {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  derived_table: {
    sql: select *, safe_divide(value-lag(value) over (partition by company_name, measure order by year),lag(value) over (partition by company_name, measure order by year)) as pct_chg_yoy from `ra-development.analytics_seed.company_benchmarking_data` ;;
    }


  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Company Name" in Explore.

  dimension: company_name {
    type: string
    hidden: no
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

  dimension: alias {
    type: string
    sql: ${TABLE}.alias ;;
    }

  dimension: segment {
    type: string
    sql: ${TABLE}.segment ;;
  }

  dimension: measure {
    hidden: yes

    type: string
    sql: ${TABLE}.measure ;;
  }

  dimension: pct_chg_yoy {
    hidden: no
    type: number
    sql: ${TABLE}.pct_chg_yoy ;;
  }

  measure: amount {
    hidden: yes

    type: sum
    sql: ${TABLE}.value;;
  }

  dimension: value {
    hidden: yes
    type: number
    sql: ${TABLE}.value ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: Sales {
    type: sum
    value_format_name: gbp_0

    group_label: "Metrics"
    sql: ${value} ;;
    filters: [measure: "Sales"]
    }

  measure: Sales_chg_pct_yoy {
    type: average
    value_format_name: percent_0

    group_label: "Metrics"
    sql: ${pct_chg_yoy} ;;
    filters: [measure: "Sales"]
  }



  measure: avg_Sales {
    type: average
    value_format_name: gbp_0

    group_label: "Metrics"
    sql: ${value} ;;
    filters: [measure: "Sales"]
  }

  measure: Other_Income_Or_Grants {
    group_label: "Metrics"
    value_format_name: gbp_0
    hidden: yes

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

  measure: Cost_Of_Sales_chg_pct_yoy {
    group_label: "Metrics"
    value_format_name: gbp_0

    type: sum
    sql: ${pct_chg_yoy} ;;
    filters: [measure: "Cost Of Sales"]
  }

  measure: avg_Cost_Of_Sales {
    group_label: "Metrics"
    value_format_name: gbp_0

    type: average
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

  measure: avg_Gross_Profit {
    group_label: "Metrics"
    value_format_name: gbp_0

    type: average
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

  measure: avg_Admin_Expenses {
    group_label: "Metrics"
    value_format_name: gbp_0

    type: average
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

  measure: Operating_Profit_chg_pct_yoy {
    group_label: "Metrics"
    value_format_name: percent_0

    type: average
    sql: ${pct_chg_yoy} ;;
    filters: [measure: "Operating Profit"]
  }

  measure: avg_Operating_Profit {
    group_label: "Metrics"
    value_format_name: gbp_0

    type: average
    sql: ${value} ;;
    filters: [measure: "Operating Profit"]
  }

  measure: Interest_Payable {
    group_label: "Metrics"
    value_format_name: gbp_0
    hidden: yes

    type: sum
    sql: ${value} ;;
    filters: [measure: "Interest Payable"]
  }

  measure: Interest_Receivable {
    group_label: "Metrics"
    value_format_name: gbp_0
    hidden: yes

    type: sum
    sql: ${value} ;;
    filters: [measure: "Interest Receivable"]
  }

  measure: Pre_Tax_Profit {
    group_label: "Metrics"
    value_format_name: gbp_0
    hidden: yes

    type: sum
    sql: ${value} ;;
    filters: [measure: "Pre-Tax Profit"]
  }

  measure: Pre_Tax_Profit_chg_pct_yoy {
    group_label: "Metrics"
    value_format_name: gbp_0
    hidden: yes

    type: average
    sql: ${pct_chg_yoy} ;;
    filters: [measure: "Pre-Tax Profit"]
  }

  measure: avg_Pre_Tax_Profit {
    group_label: "Metrics"
    value_format_name: gbp_0
    hidden: no

    type: average
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
    hidden: yes

    type: sum
    sql: ${value} ;;
    filters: [measure: "Profit After Tax"]
  }

  measure: Dividends_Paid {
    group_label: "Metrics"
    value_format_name: gbp_0
    hidden: yes

    type: sum
    sql: ${value} ;;
    filters: [measure: "Dividends Paid"]
  }

  measure: Retained_Profit {
    group_label: "Metrics"
    value_format_name: gbp_0
    hidden: yes

    type: sum
    sql: ${value} ;;
    filters: [measure: "Retained Profit"]
  }

  measure: avg_Retained_Profit {
    group_label: "Metrics"
    value_format_name: gbp_0
    hidden: no

    type: average
    sql: ${value} ;;
    filters: [measure: "Retained Profit"]
  }

  measure: Employee_Costs {
    group_label: "Metrics"
    value_format_name: gbp_0
    hidden: yes

    type: sum
    sql: ${value} ;;
    filters: [measure: "Employee Costs"]
  }

  measure: avg_Employee_Costs {
    group_label: "Metrics"
    value_format_name: gbp_0
    hidden: no

    type: average
    sql: ${value} ;;
    filters: [measure: "Employee Costs"]
  }

  measure: Number_Of_Employees {
    group_label: "Metrics"
    hidden: yes

    type: sum
    sql: ${value} ;;
    value_format_name: decimal_0
    filters: [measure: "Number Of Employees"]
  }

  measure: avg_Number_Of_Employees {
    group_label: "Metrics"
    hidden: no
    value_format_name: decimal_0

    type: average
    sql: ${value} ;;
    filters: [measure: "Number Of Employees"]
  }

  measure: EBITDA {
    group_label: "Metrics"
    value_format_name: gbp_0
    hidden: yes

    type: sum
    sql: ${value} ;;
    filters: [measure: "EBITDA"]
  }

  measure: revenue_per_employee {
    group_label: "Derived Metrics"
    value_format_name: gbp_0
    hidden: yes

    type: number
    sql: ${Sales}/${Number_Of_Employees} ;;
  }

  measure: avg_evenue_per_employee {
    group_label: "Derived Metrics"
    value_format_name: gbp_0
    hidden: no

    type: average
    sql: ${Sales}/${Number_Of_Employees} ;;
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
    sql: ${Gross_Profit}/${Sales} ;;
  }





  measure: cost_of_sales_pct {
    group_label: "Derived Metrics"
    value_format_name: percent_0

    type: number
    sql: ${Cost_Of_Sales}/${Sales} ;;
  }

  measure: retained_profit_pct {
    group_label: "Derived Metrics"
    value_format_name: percent_0
    hidden: no

    type: number
    sql: ${Retained_Profit}/${Sales} ;;
  }

  measure: avg_employee_cost {
    group_label: "Derived Metrics"
    value_format_name: gbp_0
    hidden: no

    type: number
    sql: ${Employee_Costs}/${Number_Of_Employees} ;;
  }

  measure: admin_expenses_pct {
    group_label: "Derived Metrics"
    value_format_name: percent_0

    type: number
    sql: ${Admin_Expenses}/${Sales} ;;
  }

  measure: ebitda_pct {
    group_label: "Derived Metrics"
    value_format_name: percent_0
    hidden: yes

  type: number
  sql: ${EBITDA}/${Sales} ;;
  }

  measure: net_margin_pct {
    group_label: "Derived Metrics"
    value_format_name: percent_0
    hidden: no

    type: number
    sql: ${Pre_Tax_Profit}/${Sales} ;;
  }

  measure: staff_revenue_to_cost_ratio {
    group_label: "Derived Metrics"
    value_format_name: decimal_2
    type: number
    hidden: yes

    sql: ${revenue_per_employee}/${avg_employee_cost} ;;
  }

  dimension: year {
    type: number
    value_format_name: id
    sql: ${TABLE}.year ;;
  }

}
