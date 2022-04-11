# The name of this view in Looker is "Timesheet Project Costs Fact"
view: timesheet_project_costs_fact {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics.timesheet_project_costs_fact`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Company ID" in Explore.



  dimension: company_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension: contact_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.contact_pk ;;
  }

  dimension: expense_amount_local {
    hidden: yes

    type: number
    sql: ${TABLE}.expense_amount_local ;;
  }

  dimension: expense_amount_gbp {
    hidden: yes

    type: number
    sql: ${TABLE}.expense_amount_local / ${expenses_exchange_rates.currency_rate};;
  }

  measure: total_cost_gbp {
    type: sum
    value_format_name: gbp
    sql: ${expense_amount_gbp} ;;
  }



  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.





  dimension: expense_category_name {
    type: string
    sql: ${TABLE}.expense_category_name ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: expense_created_at {
    type: time
    timeframes: [

      date,

    ]
    sql: ${TABLE}.expense_created_at_ts ;;
  }

  dimension: expense_currency_code {
    type: string
    sql: ${TABLE}.expense_currency_code ;;
  }



  dimension: expense_is_billable {
    type: yesno
    sql: ${TABLE}.expense_is_billable ;;
  }

  dimension: expense_is_billed {
    type: yesno
    sql: ${TABLE}.expense_is_billed ;;
  }

  dimension: expense_is_locked {
    type: yesno
    sql: ${TABLE}.expense_is_locked ;;
  }

  dimension: expense_notes {
    type: string
    sql: ${TABLE}.expense_notes ;;
  }

  dimension: expense_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.expense_pk ;;
  }

  dimension_group: expense_spent_at_ts {
    hidden: yes

    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.expense_spent_at_ts ;;
  }

  dimension: expense_unit_name {
    type: string
    sql: ${TABLE}.expense_unit_name ;;
  }

  dimension: expense_unit_price {
    type: number
    sql: ${TABLE}.expense_unit_price ;;
  }

  dimension: expense_units {
    type: number
    sql: ${TABLE}.expense_units ;;
  }

  dimension_group: expense_updated_at_ts {
    hidden: yes

    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.expense_updated_at_ts ;;
  }

  dimension: invoice_id {
    hidden: yes

    type: string
    sql: ${TABLE}.invoice_id ;;
  }

  dimension: source {
    hidden: yes

    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: timesheet_project_id {
    hidden: yes

    type: string
    sql: ${TABLE}.timesheet_project_id ;;
  }

  dimension: timesheet_project_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.timesheet_project_pk ;;
  }

  dimension: timesheet_users_id {
    hidden: yes

    type: string
    sql: ${TABLE}.timesheet_users_id ;;
  }


}
