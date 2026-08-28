# engagement_burn_up_fact.view.lkml
# Exposes the wh_engagement_burn_up_fact dbt model (alias: engagement_burn_up_fact)
# Table: ra-development.analytics.engagement_burn_up_fact
# Partitioned by week_start_date (MONTH), clustered by engagement_code
#
# One row per engagement per week across the delivery window. Feeds the budget burn-up
# tile: three series on one line chart, actual, projected and budget.

view: engagement_burn_up_fact {
  sql_table_name: `ra-development.analytics.engagement_burn_up_fact` ;;

  dimension: engagement_burn_up_pk {
    primary_key: yes
    hidden:      yes
    type:        string
    sql:         ${TABLE}.engagement_burn_up_pk ;;
  }

  dimension: engagement_fk { hidden: yes type: string sql: ${TABLE}.engagement_fk ;; }

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

  dimension_group: week_start {
    label:      "Week"
    type:       time
    timeframes: [date, week, month, quarter, year]
    datatype:   date
    convert_tz: no
    sql:        ${TABLE}.week_start_date ;;
  }

  dimension: week_number {
    label:       "Week Number"
    description: "Week 1 is the week the engagement started."
    type:        number
    sql:         ${TABLE}.week_number ;;
  }

  dimension: total_weeks {
    label: "Weeks In Window"
    type:  number
    sql:   ${TABLE}.total_weeks ;;
  }

  dimension: is_actual_week {
    label:       "Is Actual Week"
    description: "Yes up to the current week. No for weeks still to come, which carry the projection only."
    type:        yesno
    sql:         ${TABLE}.is_actual_week ;;
  }

  # ── Measures: the three chart series ──────────────────────────────────────────

  measure: hours_in_week {
    label: "Hours In Week"
    type:  sum
    value_format_name: decimal_1
    sql:   ${TABLE}.hours_in_week ;;
  }

  measure: cumulative_hours {
    label:       "Hours Billed, Cumulative"
    description: "Stops at the current week, so the actual line ends where the data ends."
    type:        max
    value_format_name: decimal_1
    sql:         ${TABLE}.cumulative_hours ;;
  }

  measure: projected_cumulative_hours {
    label:       "Projected At Current Pace"
    description: "Picks up from the current week, so the actual and projected lines meet."
    type:        max
    value_format_name: decimal_1
    sql:         ${TABLE}.projected_cumulative_hours ;;
  }

  measure: budget_line_hours {
    label:       "Budget, Straight Line"
    description: "The engagement's budget spread evenly across the weeks in the window."
    type:        max
    value_format_name: decimal_1
    sql:         ${TABLE}.budget_line_hours ;;
  }

  measure: budget_hours {
    label: "Budget Hours"
    type:  max
    value_format_name: decimal_1
    sql:   ${TABLE}.budget_hours ;;
  }

  measure: weekly_pace_hours {
    label: "Weekly Pace (hrs)"
    type:  max
    value_format_name: decimal_1
    sql:   ${TABLE}.weekly_pace_hours ;;
  }
}
