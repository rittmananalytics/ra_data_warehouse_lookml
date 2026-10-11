view: engagement_burn_up_fact {
  sql_table_name: `ra-development.analytics.engagement_burn_up_fact` ;;

  dimension: company_name {
    type: string
    label: "Company Name"
    sql: ${TABLE}.company_name ;;
  }

  dimension: engagement_burn_up_pk {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.engagement_burn_up_pk ;;
  }

  dimension: engagement_code {
    type: string
    label: "Engagement Code"
    sql: ${TABLE}.engagement_code ;;
  }

  dimension: engagement_fk {
    type: string
    hidden: yes
    sql: ${TABLE}.engagement_fk ;;
  }

  dimension: engagement_name {
    type: string
    label: "Engagement Name"
    sql: ${TABLE}.engagement_name ;;
  }

  dimension: is_actual_week {
    type: yesno
    label: "Is Actual Week"
    description: "Yes up to the current week. No for weeks still to come, which carry the projection only."
    sql: ${TABLE}.is_actual_week ;;
  }

  dimension: total_weeks {
    type: number
    label: "Weeks In Window"
    sql: ${TABLE}.total_weeks ;;
  }

  dimension: week_number {
    type: number
    label: "Week Number"
    description: "Week 1 is the week the engagement started."
    sql: ${TABLE}.week_number ;;
  }

  dimension_group: week_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    datatype: date
    convert_tz: no
    label: "Week"
    sql: ${TABLE}.week_start_date ;;
  }

  measure: budget_hours {
    type: max
    label: "Budget Hours"
    value_format_name: decimal_1
    sql: ${TABLE}.budget_hours ;;
  }

  measure: budget_line_hours {
    type: max
    label: "Budget, Straight Line"
    description: "The engagement's budget spread evenly across the weeks in the window."
    value_format_name: decimal_1
    sql: ${TABLE}.budget_line_hours ;;
  }

  measure: cumulative_hours {
    type: max
    label: "Hours Billed, Cumulative"
    description: "Stops at the current week, so the actual line ends where the data ends."
    value_format_name: decimal_1
    sql: ${TABLE}.cumulative_hours ;;
  }

  measure: hours_in_week {
    type: sum
    label: "Hours In Week"
    value_format_name: decimal_1
    sql: ${TABLE}.hours_in_week ;;
  }

  measure: projected_cumulative_hours {
    type: max
    label: "Projected At Current Pace"
    description: "Picks up from the current week, so the actual and projected lines meet."
    value_format_name: decimal_1
    sql: ${TABLE}.projected_cumulative_hours ;;
  }

  measure: weekly_pace_hours {
    type: max
    label: "Weekly Pace (hrs)"
    value_format_name: decimal_1
    sql: ${TABLE}.weekly_pace_hours ;;
  }
}
