view: engagement_health_fact {
  sql_table_name: `ra-development.analytics.engagement_health_fact` ;;

  dimension: budget_hourly_rate_gbp {
    type: number
    label: "Budget Hourly Rate"
    group_label: "Commercial"
    description: "Fee divided by budgeted hours. What the work was sold at."
    value_format_name: gbp_0
    sql: ${TABLE}.budget_hourly_rate_gbp ;;
  }

  dimension: budget_hours {
    type: number
    label: "Budget Hours"
    group_label: "Delivery"
    description: "Budgeted hours across every sprint on the engagement. A whole-engagement figure."
    sql: ${TABLE}.budget_hours ;;
  }

  dimension: budget_hours_remaining {
    type: number
    label: "Budget Hours Remaining"
    group_label: "Delivery"
    sql: ${TABLE}.budget_hours_remaining ;;
  }

  dimension: budget_rate_signal {
    type: string
    label: "Budget Rate Signal"
    group_label: "Signals"
    sql: ${TABLE}.budget_rate_signal ;;
  }

  dimension: budget_used_pct {
    type: number
    label: "Budget Used %"
    group_label: "Delivery"
    value_format_name: decimal_0
    sql: ${TABLE}.budget_used_pct ;;
  }

  dimension: budget_used_signal {
    type: string
    label: "Budget Used Signal"
    group_label: "Signals"
    sql: ${TABLE}.budget_used_signal ;;
  }

  dimension: burn_variance_pts {
    type: number
    label: "Burn Variance (pts)"
    group_label: "Delivery"
    description: "Budget used percentage minus schedule elapsed percentage. Positive means budget is going faster than calendar."
    value_format_name: decimal_0
    sql: ${TABLE}.burn_variance_pts ;;
  }

  dimension: burn_variance_signal {
    type: string
    label: "Burn Variance Signal"
    group_label: "Signals"
    sql: ${TABLE}.burn_variance_signal ;;
  }

  dimension: catch_up_ratio {
    type: number
    label: "Catch-up Ratio"
    group_label: "Delivery"
    description: "How much faster the team would have to work to use the remaining budget hours in the time left. 1 means the current pace lands it. Amber from 1.2, red from 2."
    value_format_name: decimal_2
    sql: ${TABLE}.catch_up_ratio ;;
  }

  dimension: client_commentary {
    type: string
    label: "Client Commentary"
    group_label: "Commentary"
    sql: ${TABLE}.client_commentary ;;
  }

  dimension: client_context_basis {
    type: string
    label: "Client Context Basis"
    group_label: "Client"
    description: "Engagement where meetings were tied to this engagement. Client where the signal is shared with the client's other live engagements, in which case it does not set the overall status."
    sql: ${TABLE}.client_context_basis ;;
  }

  dimension: client_meetings_in_month {
    type: number
    label: "Client Meetings In Month"
    group_label: "Client"
    sql: ${TABLE}.client_meetings_in_month ;;
  }

  dimension: client_messages_in_month {
    type: number
    label: "Client Messages In Month"
    group_label: "Client"
    sql: ${TABLE}.client_messages_in_month ;;
  }

  dimension: client_status {
    type: string
    label: "Client Status"
    description: "Worst of contact gap and meeting sentiment. Read alongside Client Context Basis."
    sql: ${TABLE}.client_status ;;
  }

  dimension: client_status_block {
    label: "Client Status Block"
    group_label: "Status Blocks"
    sql: ${client_status} ;;
  }

  dimension: client_status_caption {
    label: "Client Caption"
    group_label: "Status Blocks"
    sql: CONCAT(CAST(${contact_meetings_in_month} AS STRING), ' meetings, last contact ',
                        IFNULL(CAST(${days_since_last_meeting} AS STRING), 'unknown'), ' days ago. ',
                        IF(${client_context_basis} = 'client',
                           'Client-level signal, shared with the client\'s other live engagements.',
                           'Attributed to this engagement.')) ;;
  }

  dimension: commentary_parsed_ok {
    type: yesno
    label: "Commentary Parsed"
    group_label: "Commentary"
    description: "No means the language model returned something unparseable. Metrics and statuses are unaffected."
    sql: ${TABLE}.commentary_parsed_ok ;;
  }

  dimension: commercial_commentary {
    type: string
    label: "Commercial Commentary"
    group_label: "Commentary"
    sql: ${TABLE}.commercial_commentary ;;
  }

  dimension: commercial_status {
    type: string
    label: "Commercial Status"
    description: "Worst of budget rate, realised rate, earned margin and overdue invoices."
    sql: ${TABLE}.commercial_status ;;
  }

  dimension: commercial_status_block {
    label: "Commercial Status Block"
    group_label: "Status Blocks"
    sql: ${commercial_status} ;;
  }

  dimension: commercial_status_caption {
    label: "Commercial Caption"
    group_label: "Status Blocks"
    sql: CONCAT('Realised rate £', CAST(CAST(${realised_hourly_rate_gbp} AS INT64) AS STRING),
                        ' against budget £', CAST(CAST(${budget_hourly_rate_gbp} AS INT64) AS STRING),
                        '. Earned margin ', CAST(${earned_margin_pct} AS STRING), '%.') ;;
  }

  dimension: company_name {
    type: string
    label: "Company Name"
    description: "The client this engagement belongs to."
    sql: ${TABLE}.company_name ;;
  }

  dimension: contact_gap_signal {
    type: string
    label: "Contact Gap Signal"
    group_label: "Signals"
    sql: ${TABLE}.contact_gap_signal ;;
  }

  dimension: contact_meetings_in_month {
    type: number
    label: "Meetings In Month"
    group_label: "Client"
    sql: ${TABLE}.contact_meetings_in_month ;;
  }

  dimension: contact_sentiment_score {
    type: number
    label: "Meeting Sentiment"
    group_label: "Client"
    description: "Average contribution sentiment in the month, from -1 to 1."
    value_format_name: decimal_2
    sql: ${TABLE}.contact_sentiment_score ;;
  }

  dimension: days_remaining {
    type: number
    label: "Days Remaining"
    group_label: "Delivery"
    sql: ${TABLE}.days_remaining ;;
  }

  dimension: days_since_last_meeting {
    type: number
    label: "Days Since Last Meeting"
    group_label: "Client"
    sql: ${TABLE}.days_since_last_meeting ;;
  }

  dimension: delivery_commentary {
    type: string
    label: "Delivery Commentary"
    group_label: "Commentary"
    sql: ${TABLE}.delivery_commentary ;;
  }

  dimension: delivery_cost_in_month_gbp {
    type: number
    label: "Delivery Cost In Month"
    group_label: "In Month"
    value_format_name: gbp_0
    sql: ${TABLE}.delivery_cost_in_month_gbp ;;
  }

  dimension: delivery_cost_to_date_gbp {
    type: number
    label: "Delivery Cost To Date"
    group_label: "Commercial"
    description: "Labour cost plus expenses."
    value_format_name: gbp_0
    sql: ${TABLE}.delivery_cost_to_date_gbp ;;
  }

  dimension: delivery_status {
    type: string
    label: "Delivery Status"
    description: "Worst of budget used, burn variance, sprint budget and sprint start."
    sql: ${TABLE}.delivery_status ;;
  }

  dimension: delivery_status_block {
    label: "Delivery Status Block"
    group_label: "Status Blocks"
    sql: ${delivery_status} ;;
  }

  dimension: delivery_status_caption {
    label: "Delivery Caption"
    group_label: "Status Blocks"
    sql: CONCAT(CAST(${budget_used_pct} AS STRING), '% of budget used against ',
                        CAST(${elapsed_pct} AS STRING), '% elapsed. ',
                        CAST(${sprints_over_budget} AS STRING), ' of ',
                        CAST(${sprints_with_budget} AS STRING), ' sprints over budget.') ;;
  }

  dimension: docs_published_in_month {
    type: number
    label: "Documents Published"
    group_label: "Client"
    sql: ${TABLE}.docs_published_in_month ;;
  }

  dimension: earned_margin_pct {
    type: number
    label: "Earned Margin %"
    group_label: "Commercial"
    description: "Revenue minus delivery cost over revenue, both to date. Earned, not projected on the full fee."
    value_format_name: decimal_0
    sql: ${TABLE}.earned_margin_pct ;;
  }

  dimension: elapsed_pct {
    type: number
    label: "Schedule Elapsed %"
    group_label: "Delivery"
    value_format_name: decimal_0
    sql: ${TABLE}.elapsed_pct ;;
  }

  dimension: engagement_code {
    type: string
    label: "Engagement Code"
    description: "Harvest engagement code. The key every engagement health tile filters on."
    sql: ${TABLE}.engagement_code ;;
  }

  dimension: engagement_description {
    type: string
    label: "Engagement Description"
    sql: ${TABLE}.engagement_description ;;
  }

  dimension: engagement_fk {
    type: string
    hidden: yes
    sql: ${TABLE}.engagement_fk ;;
  }

  dimension: engagement_health_pk {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.engagement_health_pk ;;
  }

  dimension: engagement_name {
    type: string
    label: "Engagement Name"
    description: "Engagement name as it reads on the deal."
    sql: ${TABLE}.engagement_name ;;
  }

  dimension: expense_cost_to_date_gbp {
    type: number
    label: "Expenses To Date"
    group_label: "Commercial"
    value_format_name: gbp_0
    sql: ${TABLE}.expense_cost_to_date_gbp ;;
  }

  dimension: fanout_meeting_count {
    type: number
    label: "Generic Client Meetings"
    group_label: "Client"
    description: "Meetings that named no engagement and were counted against every live engagement for the client."
    sql: ${TABLE}.fanout_meeting_count ;;
  }

  dimension: fee_amount_gbp {
    type: number
    label: "Engagement Fee"
    group_label: "Commercial"
    description: "Fee across every sprint on the engagement. A whole-engagement figure."
    value_format_name: gbp_0
    sql: ${TABLE}.fee_amount_gbp ;;
  }

  dimension: fee_at_risk_signal {
    type: string
    label: "Fee At Risk Signal"
    group_label: "Signals"
    sql: ${TABLE}.fee_at_risk_signal ;;
  }

  dimension: hours_in_month {
    type: number
    label: "Hours In Month"
    group_label: "In Month"
    sql: ${TABLE}.hours_in_month ;;
  }

  dimension: hours_to_date {
    type: number
    label: "Hours To Date"
    group_label: "Delivery"
    description: "Billable hours booked to the month end."
    sql: ${TABLE}.hours_to_date ;;
  }

  dimension: is_current_month {
    label: "Is Current Month"
    description: "Yes for the month in progress."
    sql: ${TABLE}.reporting_month = DATE_TRUNC(CURRENT_DATE(), MONTH) ;;
  }

  dimension: is_live_engagement {
    label: "Is Live"
    description: "Yes where the engagement window covers today."
    sql: CURRENT_DATE() BETWEEN ${engagement_start_date_raw} AND ${engagement_end_date_raw} ;;
  }

  dimension: labour_cost_to_date_gbp {
    type: number
    label: "Labour Cost To Date"
    group_label: "Commercial"
    value_format_name: gbp_0
    sql: ${TABLE}.labour_cost_to_date_gbp ;;
  }

  dimension: margin_signal {
    type: string
    label: "Margin Signal"
    group_label: "Signals"
    sql: ${TABLE}.margin_signal ;;
  }

  dimension: max_days_overdue {
    type: number
    label: "Oldest Days Past Due"
    group_label: "Commercial"
    sql: ${TABLE}.max_days_overdue ;;
  }

  dimension: max_sprint_days_late {
    type: number
    label: "Worst Sprint Days Late"
    group_label: "Delivery"
    sql: ${TABLE}.max_sprint_days_late ;;
  }

  dimension: messages_in_month {
    type: number
    label: "Messages Attributed"
    group_label: "Client"
    sql: ${TABLE}.messages_in_month ;;
  }

  dimension: open_invoice_amount_gbp {
    type: number
    label: "Invoiced Not Yet Due"
    group_label: "Commercial"
    description: "Issued invoices not yet due. Harvest draft billing schedules are excluded."
    value_format_name: gbp_0
    sql: ${TABLE}.open_invoice_amount_gbp ;;
  }

  dimension: overall_status {
    type: string
    label: "Overall Status"
    description: "Worst of the three, except that client-level context is excluded because it belongs to the client rather than this engagement."
    sql: ${TABLE}.overall_status ;;
  }

  dimension: overall_status_block {
    label: "Overall Status Block"
    group_label: "Status Blocks"
    sql: ${overall_status} ;;
  }

  dimension: overall_status_sort_order {
    hidden: yes
    sql: CASE ${overall_status} WHEN 'RED' THEN 1 WHEN 'AMBER' THEN 2 ELSE 3 END ;;
  }

  dimension: overdue_amount_gbp {
    type: number
    label: "Invoiced And Past Due"
    group_label: "Commercial"
    value_format_name: gbp_0
    sql: ${TABLE}.overdue_amount_gbp ;;
  }

  dimension: overdue_invoice_count {
    type: number
    label: "Overdue Invoices"
    group_label: "Commercial"
    sql: ${TABLE}.overdue_invoice_count ;;
  }

  dimension: overdue_signal {
    type: string
    label: "Overdue Signal"
    group_label: "Signals"
    sql: ${TABLE}.overdue_signal ;;
  }

  dimension: projected_delivery_pct {
    type: number
    label: "Projected Delivery %"
    group_label: "Delivery"
    description: "Hours projected at the current pace as a share of budget hours."
    value_format_name: decimal_0
    sql: ${TABLE}.projected_delivery_pct ;;
  }

  dimension: projected_delivery_signal {
    type: string
    label: "Projected Delivery Signal"
    group_label: "Signals"
    sql: ${TABLE}.projected_delivery_signal ;;
  }

  dimension: projected_total_hours {
    type: number
    label: "Projected Total Hours"
    group_label: "Delivery"
    description: "Hours to date plus the weekly pace across the days left in the window."
    sql: ${TABLE}.projected_total_hours ;;
  }

  dimension: realised_hourly_rate_gbp {
    type: number
    label: "Realised Hourly Rate"
    group_label: "Commercial"
    description: "Recognised revenue to date divided by hours to date. What it is averaging today."
    value_format_name: gbp_0
    sql: ${TABLE}.realised_hourly_rate_gbp ;;
  }

  dimension: realised_rate_signal {
    type: string
    label: "Realised Rate Signal"
    group_label: "Signals"
    sql: ${TABLE}.realised_rate_signal ;;
  }

  dimension: revenue_in_month_gbp {
    type: number
    label: "Revenue In Month"
    group_label: "In Month"
    value_format_name: gbp_0
    sql: ${TABLE}.revenue_in_month_gbp ;;
  }

  dimension: revenue_to_date_gbp {
    type: number
    label: "Recognised Revenue To Date"
    group_label: "Commercial"
    value_format_name: gbp_0
    sql: ${TABLE}.revenue_to_date_gbp ;;
  }

  dimension: runway_weeks {
    type: number
    label: "Runway (weeks)"
    group_label: "Delivery"
    description: "Budget hours left divided by the weekly pace. Zero where the budget is spent."
    value_format_name: decimal_1
    sql: ${TABLE}.runway_weeks ;;
  }

  dimension: sentiment_signal {
    type: string
    label: "Sentiment Signal"
    group_label: "Signals"
    sql: ${TABLE}.sentiment_signal ;;
  }

  dimension: sprint_budget_signal {
    type: string
    label: "Sprint Budget Signal"
    group_label: "Signals"
    sql: ${TABLE}.sprint_budget_signal ;;
  }

  dimension: sprint_start_signal {
    type: string
    label: "Sprint Start Signal"
    group_label: "Signals"
    sql: ${TABLE}.sprint_start_signal ;;
  }

  dimension: sprints_in_flight {
    type: number
    label: "Sprints In Flight"
    group_label: "Delivery"
    sql: ${TABLE}.sprints_in_flight ;;
  }

  dimension: sprints_late_start {
    type: number
    label: "Sprints Late To Start"
    group_label: "Delivery"
    sql: ${TABLE}.sprints_late_start ;;
  }

  dimension: sprints_over_budget {
    type: number
    label: "Sprints Over Budget"
    group_label: "Delivery"
    sql: ${TABLE}.sprints_over_budget ;;
  }

  dimension: sprints_over_budget_pct {
    type: number
    label: "Sprints Over Budget %"
    group_label: "Delivery"
    description: "Share of the engagement's budgeted sprints past 100 percent of their own budget. Amber at 50 percent, red at 75."
    value_format_name: decimal_0
    sql: ${TABLE}.sprints_over_budget_pct ;;
  }

  dimension: sprints_total {
    type: number
    label: "Sprints"
    group_label: "Delivery"
    sql: ${TABLE}.sprints_total ;;
  }

  dimension: sprints_with_budget {
    type: number
    label: "Sprints With A Budget"
    group_label: "Delivery"
    description: "A sprint with no budget cannot be over it, so it is left out of the over-budget share."
    sql: ${TABLE}.sprints_with_budget ;;
  }

  dimension: tasks_active_in_month {
    type: number
    label: "Delivery Tasks Active"
    group_label: "Client"
    sql: ${TABLE}.tasks_active_in_month ;;
  }

  dimension: weekly_pace_hours {
    type: number
    label: "Weekly Pace (hrs)"
    group_label: "Delivery"
    description: "Hours a week over the four weeks to the reporting date."
    value_format_name: decimal_1
    sql: ${TABLE}.weekly_pace_hours ;;
  }

  dimension: weeks_remaining {
    type: number
    label: "Weeks Remaining"
    group_label: "Delivery"
    value_format_name: decimal_1
    sql: ${TABLE}.weeks_remaining ;;
  }

  dimension_group: as_of_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    datatype: date
    label: "As At"
    description: "Month end, or today for the month in progress. Every to-date figure is measured to this date."
    sql: ${TABLE}.as_of_date ;;
  }

  dimension_group: budget_exhausted_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    datatype: date
    label: "Budget Exhausted On"
    group_label: "Delivery"
    description: "The day cumulative hours first reached the budget. Blank where the budget has not been reached."
    sql: ${TABLE}.budget_exhausted_date ;;
  }

  dimension_group: engagement_end_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    datatype: date
    label: "Engagement End"
    sql: ${TABLE}.engagement_end_date ;;
  }

  dimension_group: engagement_start_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    datatype: date
    label: "Engagement Start"
    sql: ${TABLE}.engagement_start_date ;;
  }

  dimension_group: reporting_month {
    type: time
    timeframes: [raw, date, month, quarter, year]
    datatype: date
    convert_tz: no
    label: "Reporting"
    description: "The month this row reports on."
    sql: ${TABLE}.reporting_month ;;
  }

  measure: amber_engagements {
    type: count_distinct
    label: "Amber Engagements"
    sql: ${engagement_code} ;;
    filters: [overall_status: "AMBER"]
  }

  measure: average_earned_margin_pct {
    type: average
    label: "Average Earned Margin %"
    group_label: "Portfolio"
    value_format_name: decimal_0
    sql: ${earned_margin_pct} ;;
  }

  measure: budget_hours_value {
    type: max
    label: "Budget Hours (value)"
    group_label: "Tile Values"
    sql: ${budget_hours} ;;
  }

  measure: budget_rate_value {
    type: max
    label: "Budget Rate (value)"
    group_label: "Tile Values"
    value_format_name: gbp_0
    sql: ${budget_hourly_rate_gbp} ;;
  }

  measure: budget_used_pct_value {
    type: max
    label: "Budget Used % (value)"
    group_label: "Tile Values"
    value_format_name: decimal_0
    sql: ${budget_used_pct} ;;
  }

  measure: burn_variance_pts_value {
    type: max
    label: "Burn Variance (value)"
    group_label: "Tile Values"
    value_format_name: decimal_0
    sql: ${burn_variance_pts} ;;
  }

  measure: earned_margin_pct_value {
    type: max
    label: "Earned Margin % (value)"
    group_label: "Tile Values"
    value_format_name: decimal_0
    sql: ${earned_margin_pct} ;;
  }

  measure: elapsed_pct_value {
    type: max
    label: "Schedule Elapsed % (value)"
    group_label: "Tile Values"
    value_format_name: decimal_0
    sql: ${elapsed_pct} ;;
  }

  measure: engagement_month_count {
    type: count
    label: "Engagement Months"
    drill_fields: [engagement_health_fact.company_name, engagement_health_fact.engagement_name, engagement_health_fact.reporting_month_month, engagement_health_fact.overall_status, engagement_health_fact.delivery_status, engagement_health_fact.commercial_status, engagement_health_fact.client_status, engagement_health_fact.budget_used_pct, engagement_health_fact.burn_variance_pts, engagement_health_fact.realised_hourly_rate_gbp, engagement_health_fact.earned_margin_pct, engagement_health_fact.overdue_amount_gbp]
  }

  measure: engagements_count {
    type: count_distinct
    label: "Engagements"
    sql: ${engagement_code} ;;
  }

  measure: green_engagements {
    type: count_distinct
    label: "Green Engagements"
    sql: ${engagement_code} ;;
    filters: [overall_status: "GREEN"]
  }

  measure: hours_to_date_value {
    type: max
    label: "Hours To Date (value)"
    group_label: "Tile Values"
    sql: ${hours_to_date} ;;
  }

  measure: overdue_amount_value {
    type: max
    label: "Past Due (value)"
    group_label: "Tile Values"
    value_format_name: gbp_0
    sql: ${overdue_amount_gbp} ;;
  }

  measure: realised_rate_value {
    type: max
    label: "Realised Rate (value)"
    group_label: "Tile Values"
    value_format_name: gbp_0
    sql: ${realised_hourly_rate_gbp} ;;
  }

  measure: red_engagements {
    type: count_distinct
    label: "Red Engagements"
    description: "Engagements whose overall status is RED."
    sql: ${engagement_code} ;;
    filters: [overall_status: "RED"]
  }

  measure: runway_weeks_value {
    type: max
    label: "Runway Weeks (value)"
    group_label: "Tile Values"
    value_format_name: decimal_1
    sql: ${runway_weeks} ;;
  }

  measure: total_delivery_cost_in_month_gbp {
    type: sum
    label: "Delivery Cost In Month"
    group_label: "Portfolio"
    value_format_name: gbp_0
    sql: ${delivery_cost_in_month_gbp} ;;
  }

  measure: total_hours_in_month {
    type: sum
    label: "Hours In Month"
    group_label: "Portfolio"
    sql: ${hours_in_month} ;;
  }

  measure: total_overdue_amount_gbp {
    type: sum
    label: "Invoiced And Past Due"
    group_label: "Portfolio"
    value_format_name: gbp_0
    sql: ${overdue_amount_gbp} ;;
  }

  measure: total_revenue_in_month_gbp {
    type: sum
    label: "Revenue In Month"
    group_label: "Portfolio"
    value_format_name: gbp_0
    sql: ${revenue_in_month_gbp} ;;
  }
}
