# engagement_sprint_burn_fact.view.lkml
# Exposes the wh_engagement_sprint_burn_fact dbt model (alias: engagement_sprint_burn_fact)
# Table: ra-development.analytics.engagement_sprint_burn_fact
# Partitioned by reporting_month (MONTH), clustered by engagement_code + sprint_state
#
# One row per engagement sprint per reporting month. Feeds the sprint burn table and the
# sprint timeline. A sprint is a Harvest project inside the engagement.

view: engagement_sprint_burn_fact {
  sql_table_name: `ra-development.analytics.engagement_sprint_burn_fact` ;;

  dimension: engagement_sprint_burn_pk {
    primary_key: yes
    hidden:      yes
    type:        string
    sql:         ${TABLE}.engagement_sprint_burn_pk ;;
  }

  dimension: engagement_fk { hidden: yes type: string sql: ${TABLE}.engagement_fk ;; }
  dimension: sprint_fk     { hidden: yes type: string sql: ${TABLE}.sprint_fk ;; }

  dimension: engagement_code {
    label: "Engagement Code"
    type:  string
    sql:   ${TABLE}.engagement_code ;;
  }

  dimension: company_name {
    label: "Company Name"
    type:  string
    sql:   ${TABLE}.company_name ;;
  }

  dimension: engagement_name {
    label: "Engagement Name"
    type:  string
    sql:   ${TABLE}.engagement_name ;;
  }

  dimension_group: reporting_month {
    label:      "Reporting"
    type:       time
    timeframes: [month, quarter, year, date]
    datatype:   date
    convert_tz: no
    sql:        ${TABLE}.reporting_month ;;
  }

  dimension: sprint_name {
    label:       "Sprint"
    description: "Harvest project name inside the engagement."
    type:        string
    sql:         ${TABLE}.sprint_name ;;
  }

  dimension: sprint_start_date {
    label:      "Sprint Start"
    type:       date
    datatype:   date
    convert_tz: no
    sql:        ${TABLE}.sprint_start_date ;;
  }

  dimension: sprint_end_date {
    label:      "Sprint End"
    type:       date
    datatype:   date
    convert_tz: no
    sql:        ${TABLE}.sprint_end_date ;;
  }

  dimension: sprint_window {
    label:       "Delivery Window"
    description: "Sprint start and end, formatted for the sprint burn table."
    type:        string
    sql:         CONCAT(FORMAT_DATE('%e %b', ${TABLE}.sprint_start_date), ' to ',
      FORMAT_DATE('%e %b %Y', ${TABLE}.sprint_end_date)) ;;
  }

  dimension: sprint_state {
    label:       "Sprint State"
    description: "Scheduled, Not started, Not started late, In flight, At budget in flight, Over budget in flight, Closed on budget, or Closed over budget."
    type:        string
    sql:         ${TABLE}.sprint_state ;;
  }

  dimension: sprint_state_sort_order {
    hidden: yes
    type:   number
    sql:    CASE ${TABLE}.sprint_state
              WHEN 'Over budget, in flight' THEN 1
              WHEN 'Not started, late'      THEN 2
              WHEN 'Closed over budget'     THEN 3
              WHEN 'At budget, in flight'   THEN 4
              WHEN 'In flight'              THEN 5
              WHEN 'Closed on budget'       THEN 6
              WHEN 'Not started'            THEN 7
              ELSE 8 END ;;
  }

  dimension: sprint_is_closed       { label: "Sprint Is Closed"      type: yesno sql: ${TABLE}.sprint_is_closed ;; }
  dimension: sprint_is_over_budget  { label: "Sprint Is Over Budget" type: yesno sql: ${TABLE}.sprint_is_over_budget ;; }

  dimension: last_hours_booked_date {
    label:       "Last Hours Booked"
    type:        date
    datatype:    date
    convert_tz:  no
    sql:         ${TABLE}.last_hours_booked_date ;;
  }

  dimension: sprint_days_late_start {
    label:       "Days Late To Start"
    description: "Days past the sprint start date with no hours booked."
    type:        number
    sql:         ${TABLE}.sprint_days_late_start ;;
  }

  # ── Measures ──────────────────────────────────────────────────────────────────

  measure: sprint_count {
    label: "Sprints"
    type:  count
    drill_fields: [detail*]
  }

  measure: sprint_budget_hours {
    label: "Budget Hours"
    type:  sum
    value_format_name: decimal_1
    sql:   ${TABLE}.sprint_budget_hours ;;
  }

  measure: sprint_hours_to_date {
    label: "Hours Billed"
    type:  sum
    value_format_name: decimal_1
    sql:   ${TABLE}.sprint_hours_to_date ;;
  }

  measure: sprint_hours_in_month {
    label: "Hours In Month"
    type:  sum
    value_format_name: decimal_1
    sql:   ${TABLE}.sprint_hours_in_month ;;
  }

  measure: sprint_fee_amount_gbp {
    label: "Sprint Fee"
    type:  sum
    value_format_name: gbp_0
    sql:   ${TABLE}.sprint_fee_amount_gbp ;;
  }

  measure: sprint_budget_used_pct {
    label:       "Budget Used %"
    description: "Hours billed over budget hours, for the sprint rows in scope. Use with the data bar cell visualisation."
    type:        number
    value_format_name: decimal_0
    sql:         100 * SAFE_DIVIDE(${sprint_hours_to_date}, NULLIF(${sprint_budget_hours}, 0)) ;;
  }

  measure: sprints_over_budget {
    label:   "Sprints Over Budget"
    type:    count
    filters: [sprint_is_over_budget: "yes"]
  }

  set: detail {
    fields: [
      engagement_name, sprint_name, sprint_window, sprint_budget_hours,
      sprint_hours_to_date, sprint_budget_used_pct, sprint_state, last_hours_booked_date
    ]
  }
}
