# The name of this view in Looker is "Sows Fact"
view: sows_fact {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics.sows_fact` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Company Fk" in Explore.

  dimension: company_fk {
    type: string
    hidden: yes
    sql: ${TABLE}.company_fk ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: deal_closed_ts {
    label: "SoW Signed"
    type: time
    timeframes: [raw, date]
    sql: ${TABLE}.deal_closed_ts ;;
  }

  dimension: deal_name {
    label: "SoW Name"
    type: string
    sql: ${TABLE}.deal_name ;;
  }

  dimension: deal_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.deal_pk ;;
  }

  dimension: project_code {
    label: "Project Code"
    type: string
    sql: ${TABLE}.project_code ;;
  }

  dimension_group: project_delivery_end_ts {
    label: "Sprint End"
    type: time
    timeframes: [date,month]
    sql: timestamp(${TABLE}.project_delivery_end_ts) ;;
  }

  dimension_group: project_delivery_start_ts {
    label: "Sprint Start"
    type: time
    timeframes: [date,month]
    sql: timestamp(${TABLE}.project_delivery_start_ts) ;;
  }

  dimension: project_fee_amount {
    label: "Sprint Fee Amount"
    type: number
    sql: ${TABLE}.project_fee_amount ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_project_fee_amount {
    label: "Total Sprint Fee Amount"
    type: sum
    sql: ${project_fee_amount} ;;  }


  dimension: project_name {
    label: "Sprint Name"
    type: string
    sql: ${TABLE}.project_name ;;
  }

  dimension_group: sow_end {
    label: "SoW Completion"
    type: time
    timeframes: [raw,date]
    sql: timestamp(${TABLE}.sow_end_ts) ;;
  }

  dimension: sow_fee_amount {
    type: number
    sql: ${TABLE}.sow_fee_amount ;;
  }

  dimension: sow_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.sow_pk ;;
  }

  dimension: sow_total_sprints {
    type: number
    sql: ${TABLE}.sow_sprints ;;
  }

  dimension_group: sow_start {
    type: time
    timeframes: [raw,date]
    sql: timestamp(${TABLE}.sow_start_ts) ;;
  }
  measure: count {
    label: "Total SoWs"
    type: count_distinct
    drill_fields: [project_name, deal_name]
  }
}
