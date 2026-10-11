view: engagement_sprint_burn_fact {
  sql_table_name: `ra-development.analytics.engagement_sprint_burn_fact` ;;

  dimension: company_name {
    label: "Company Name"
    sql: ${TABLE}.company_name ;;
  }

  dimension: engagement_code {
    label: "Engagement Code"
    sql: ${TABLE}.engagement_code ;;
  }

  dimension: engagement_fk {
    hidden: yes
    sql: ${TABLE}.engagement_fk ;;
  }

  dimension: engagement_name {
    label: "Engagement Name"
    sql: ${TABLE}.engagement_name ;;
  }

  dimension: engagement_sprint_burn_pk {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.engagement_sprint_burn_pk ;;
  }

  dimension: sprint_days_late_start {
    label: "Days Late To Start"
    description: "Days past the sprint start date with no hours booked."
    sql: ${TABLE}.sprint_days_late_start ;;
  }

  dimension: sprint_fk {
    hidden: yes
    sql: ${TABLE}.sprint_fk ;;
  }

  dimension: sprint_is_closed {
    label: "Sprint Is Closed"
    sql: ${TABLE}.sprint_is_closed ;;
  }

  dimension: sprint_is_over_budget {
    type: yesno
    label: "Sprint Is Over Budget"
    sql: ${TABLE}.sprint_is_over_budget ;;
  }

  dimension: sprint_name {
    label: "Sprint"
    description: "Harvest project name inside the engagement."
    sql: ${TABLE}.sprint_name ;;
  }

  dimension: sprint_state {
    label: "Sprint State"
    description: "Scheduled, Not started, Not started late, In flight, At budget in flight, Over budget in flight, Closed on budget, or Closed over budget."
    sql: ${TABLE}.sprint_state ;;
  }

  dimension: sprint_state_sort_order {
    hidden: yes
    sql: CASE ${sprint_state}
              WHEN 'Over budget, in flight' THEN 1
              WHEN 'Not started, late'      THEN 2
              WHEN 'Closed over budget'     THEN 3
              WHEN 'At budget, in flight'   THEN 4
              WHEN 'In flight'              THEN 5
              WHEN 'Closed on budget'       THEN 6
              WHEN 'Not started'            THEN 7
              ELSE 8 END ;;
  }

  dimension: sprint_window {
    label: "Delivery Window"
    description: "Sprint start and end, formatted for the sprint burn table."
    sql: CONCAT(FORMAT_DATE('%e %b', ${sprint_start_date_raw}), ' to ',
      FORMAT_DATE('%e %b %Y', ${sprint_end_date_raw})) ;;
  }

  dimension_group: last_hours_booked_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    label: "Last Hours Booked"
    sql: ${TABLE}.last_hours_booked_date ;;
  }

  dimension_group: reporting_month {
    type: time
    timeframes: [raw, date, month, quarter, year]
    convert_tz: no
    label: "Reporting"
    sql: ${TABLE}.reporting_month ;;
  }

  dimension_group: sprint_end_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    label: "Sprint End"
    sql: ${TABLE}.sprint_end_date ;;
  }

  dimension_group: sprint_start_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    label: "Sprint Start"
    sql: ${TABLE}.sprint_start_date ;;
  }

  measure: sprint_budget_hours {
    type: sum
    label: "Budget Hours"
    value_format_name: decimal_1
    sql: ${TABLE}.sprint_budget_hours ;;
  }

  measure: sprint_budget_used_pct {
    type: number
    label: "Budget Used %"
    description: "Hours billed over budget hours, for the sprint rows in scope. Use with the data bar cell visualisation."
    value_format_name: decimal_0
    sql: 100 * SAFE_DIVIDE(${sprint_hours_to_date}, NULLIF(${sprint_budget_hours}, 0)) ;;
  }

  measure: sprint_count {
    type: count
    label: "Sprints"
    drill_fields: [engagement_sprint_burn_fact.engagement_name, engagement_sprint_burn_fact.sprint_name, engagement_sprint_burn_fact.sprint_window, engagement_sprint_burn_fact.sprint_budget_hours, engagement_sprint_burn_fact.sprint_hours_to_date, engagement_sprint_burn_fact.sprint_budget_used_pct, engagement_sprint_burn_fact.sprint_state, engagement_sprint_burn_fact.last_hours_booked_date_time]
  }

  measure: sprint_fee_amount_gbp {
    type: sum
    label: "Sprint Fee"
    value_format_name: gbp_0
    sql: ${TABLE}.sprint_fee_amount_gbp ;;
  }

  measure: sprint_hours_in_month {
    type: sum
    label: "Hours In Month"
    value_format_name: decimal_1
    sql: ${TABLE}.sprint_hours_in_month ;;
  }

  measure: sprint_hours_to_date {
    type: sum
    label: "Hours Billed"
    value_format_name: decimal_1
    sql: ${TABLE}.sprint_hours_to_date ;;
  }

  measure: sprints_over_budget {
    type: count
    label: "Sprints Over Budget"
    filters: [sprint_is_over_budget: "Yes"]
  }
}
