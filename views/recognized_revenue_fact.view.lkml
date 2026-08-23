# The name of this view in Looker is "Recognized Revenue Fact"
view: recognized_revenue_fact {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics.recognized_revenue_fact` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: billing_month {
    type: time
    timeframes: [raw, month, month_num,quarter, year, fiscal_month_num, fiscal_quarter,fiscal_quarter_of_year,fiscal_year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.billing_month ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Consultant Hours Billed" in Explore.

  dimension: pk {
    type: string
    primary_key: yes
    hidden: yes
    sql: concat(${billing_month_raw},${timesheet_project_pk},${contact_fk}) ;;
  }

  dimension: consultant_hours_billed {
    hidden: yes

    type: number
    sql: ${TABLE}.consultant_hours_billed ;;
  }

  dimension: consultant_hours_attributed {
    hidden: yes

    type: number
    sql: ${TABLE}.consultant_hours_attributed ;;
  }

  dimension: consultant_recognized_revenue_gbp {
    type: number
    hidden: yes
    sql: ${TABLE}.consultant_recognized_revenue_gbp ;;
  }

  dimension: consultant_recognized_attributed_revenue_gbp {
    type: number
    hidden: yes
    sql: ${TABLE}.consultant_recognized_attributed_revenue_gbp ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_hours_billed {
    type: sum
    description: "Total billable hours billed by consultant"
    value_format_name: decimal_0
    sql: ${consultant_hours_billed} ;;
  }

  measure: total_hours_attributed {
    type: sum
    description: "Total billable hours billed by consultant, modified by their grade modifier"
    value_format_name: decimal_0
    sql: ${consultant_hours_attributed} ;;
  }

  measure: total_recognized_revenue_gbp {
    type: sum
    value_format_name: gbp_0
    sql: ${consultant_recognized_revenue_gbp} ;;  }

  measure: total_recognized_revenue_attributed_gbp {
    type: sum
    value_format_name: gbp_0
    sql: ${consultant_recognized_attributed_revenue_gbp} ;;  }


  dimension: contact_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_fk ;;
  }

  dimension: project_name {
    hidden: yes
    type: string
    sql: ${TABLE}.project_name ;;
  }

  dimension: timesheet_project_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.timesheet_project_pk ;;
  }

  dimension: hours_billed {
    hidden: yes
    type: number
    sql: ${TABLE}.total_hours_billed ;;
  }

  dimension: hours_attributed {
    hidden: yes
    type: number
    sql: ${TABLE}.total_hours_attributed ;;
  }

# ---- Delivery cost (added) ----

  dimension: consultant_delivery_labour_cost_gbp {
    hidden: yes
    type: number
    sql: ${TABLE}.consultant_delivery_labour_cost_gbp ;;
  }

  dimension: expense_cost_gbp {
    # Project-month total, repeated on every consultant row for that
    # project month. Never sum this directly - use the sum_distinct
    # measure below.
    hidden: yes
    type: number
    sql: ${TABLE}.total_expense_cost_gbp ;;
  }

  dimension: project_month_key {
    hidden: yes
    type: string
    sql: concat(${billing_month_raw},${timesheet_project_pk}) ;;
  }

  measure: total_delivery_labour_cost_gbp {
    type: sum
    description: "Cost of billable hours logged: hours x the Harvest cost rate on each entry. Entries with no cost rate count as zero (contractor-staffed projects are costed through expenses instead)."
    value_format_name: gbp_0
    sql: ${consultant_delivery_labour_cost_gbp} ;;
  }

  measure: total_expense_cost_gbp {
    type: sum_distinct
    sql_distinct_key: ${project_month_key} ;;
    description: "Project expenses (billable and non-billable) spread evenly over the working days in the project's delivery window. Counted once per project month regardless of how many consultants worked on the project."
    value_format_name: gbp_0
    sql: ${expense_cost_gbp} ;;
  }

  measure: total_delivery_cost_gbp {
    type: number
    description: "Labour cost plus spread expenses"
    value_format_name: gbp_0
    sql: coalesce(${total_delivery_labour_cost_gbp},0) + coalesce(${total_expense_cost_gbp},0) ;;
  }

  measure: recognized_margin_gbp {
    type: number
    description: "Recognised revenue minus labour cost and spread expenses"
    value_format_name: gbp_0
    sql: coalesce(${total_recognized_revenue_gbp},0) - ${total_delivery_cost_gbp} ;;
  }





}
