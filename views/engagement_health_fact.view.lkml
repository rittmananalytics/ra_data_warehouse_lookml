# engagement_health_fact.view.lkml
# Exposes the wh_engagement_health_fact dbt model (alias: engagement_health_fact)
# Table: ra-development.analytics.engagement_health_fact
# Partitioned by reporting_month (MONTH), clustered by company_name + overall_status
#
# One row per engagement per reporting month. Every status is computed in SQL from the
# engagement_health_thresholds seed; the language model writes the commentary only.

view: engagement_health_fact {
  sql_table_name: `ra-development.analytics.engagement_health_fact` ;;

  # ── Keys ──────────────────────────────────────────────────────────────────────

  dimension: engagement_health_pk {
    primary_key: yes
    hidden:      yes
    type:        string
    sql:         ${TABLE}.engagement_health_pk ;;
  }

  dimension: engagement_fk {
    hidden: yes
    type:   string
    sql:    ${TABLE}.engagement_fk ;;
  }

  dimension: engagement_code {
    label:       "Engagement Code"
    description: "Harvest engagement code. The key every engagement health tile filters on."
    type:        string
    sql:         ${TABLE}.engagement_code ;;
  }

  # ── Identity ──────────────────────────────────────────────────────────────────

  dimension: company_name {
    label:       "Company Name"
    description: "The client this engagement belongs to."
    type:        string
    sql:         ${TABLE}.company_name ;;
  }

  dimension: engagement_name {
    label:       "Engagement Name"
    description: "Engagement name as it reads on the deal."
    type:        string
    sql:         ${TABLE}.engagement_name ;;
  }

  dimension: engagement_description {
    label: "Engagement Description"
    type:  string
    sql:   ${TABLE}.engagement_description ;;
  }

  dimension_group: reporting_month {
    label:       "Reporting"
    description: "The month this row reports on."
    type:        time
    timeframes:  [month, quarter, year, date]
    datatype:    date
    convert_tz:  no
    sql:         ${TABLE}.reporting_month ;;
  }

  dimension: as_of_date {
    label:       "As At"
    description: "Month end, or today for the month in progress. Every to-date figure is measured to this date."
    type:        date
    datatype:    date
    convert_tz:  no
    sql:         ${TABLE}.as_of_date ;;
  }

  dimension: engagement_start_date {
    label:      "Engagement Start"
    type:       date
    datatype:   date
    convert_tz: no
    sql:        ${TABLE}.engagement_start_date ;;
  }

  dimension: engagement_end_date {
    label:      "Engagement End"
    type:       date
    datatype:   date
    convert_tz: no
    sql:        ${TABLE}.engagement_end_date ;;
  }

  dimension: is_current_month {
    label:       "Is Current Month"
    description: "Yes for the month in progress."
    type:        yesno
    sql:         ${TABLE}.reporting_month = DATE_TRUNC(CURRENT_DATE(), MONTH) ;;
  }

  dimension: is_live_engagement {
    label:       "Is Live"
    description: "Yes where the engagement window covers today."
    type:        yesno
    sql:         CURRENT_DATE() BETWEEN ${TABLE}.engagement_start_date AND ${TABLE}.engagement_end_date ;;
  }

  # ── Statuses ──────────────────────────────────────────────────────────────────
  # Each is the worst individual signal in its area, so several ambers stay amber.

  dimension: delivery_status {
    label:       "Delivery Status"
    description: "Worst of budget used, burn variance, sprint budget and sprint start."
    type:        string
    sql:         ${TABLE}.delivery_status ;;
  }

  dimension: commercial_status {
    label:       "Commercial Status"
    description: "Worst of budget rate, realised rate, earned margin and overdue invoices."
    type:        string
    sql:         ${TABLE}.commercial_status ;;
  }

  dimension: client_status {
    label:       "Client Status"
    description: "Worst of contact gap and meeting sentiment. Read alongside Client Context Basis."
    type:        string
    sql:         ${TABLE}.client_status ;;
  }

  dimension: overall_status {
    label:       "Overall Status"
    description: "Worst of the three, except that client-level context is excluded because it belongs to the client rather than this engagement."
    type:        string
    sql:         ${TABLE}.overall_status ;;
  }

  # Coloured status blocks for the dashboard tiles. Looker's own conditional formatting
  # only applies to numbers, and these are words, so the colour is set in html. The fills
  # match the existing RAG board.
  dimension: delivery_status_block {
    group_label: "Status Blocks"
    label:       "Delivery Status Block"
    type:        string
    sql:         ${delivery_status} ;;
    html:        {% if value == 'RED' %}<div style="background:#E8402A;color:#fff;text-align:center;padding:10px 0;border-radius:3px">RED</div>
                 {% elsif value == 'AMBER' %}<div style="background:#E9A33A;color:#fff;text-align:center;padding:10px 0;border-radius:3px">AMBER</div>
                 {% else %}<div style="background:#2E7031;color:#fff;text-align:center;padding:10px 0;border-radius:3px">GREEN</div>{% endif %} ;;
  }

  dimension: commercial_status_block {
    group_label: "Status Blocks"
    label:       "Commercial Status Block"
    type:        string
    sql:         ${commercial_status} ;;
    html:        {% if value == 'RED' %}<div style="background:#E8402A;color:#fff;text-align:center;padding:10px 0;border-radius:3px">RED</div>
                 {% elsif value == 'AMBER' %}<div style="background:#E9A33A;color:#fff;text-align:center;padding:10px 0;border-radius:3px">AMBER</div>
                 {% else %}<div style="background:#2E7031;color:#fff;text-align:center;padding:10px 0;border-radius:3px">GREEN</div>{% endif %} ;;
  }

  dimension: client_status_block {
    group_label: "Status Blocks"
    label:       "Client Status Block"
    type:        string
    sql:         ${client_status} ;;
    html:        {% if value == 'RED' %}<div style="background:#E8402A;color:#fff;text-align:center;padding:10px 0;border-radius:3px">RED</div>
                 {% elsif value == 'AMBER' %}<div style="background:#E9A33A;color:#fff;text-align:center;padding:10px 0;border-radius:3px">AMBER</div>
                 {% else %}<div style="background:#2E7031;color:#fff;text-align:center;padding:10px 0;border-radius:3px">GREEN</div>{% endif %} ;;
  }

  dimension: overall_status_block {
    group_label: "Status Blocks"
    label:       "Overall Status Block"
    type:        string
    sql:         ${overall_status} ;;
    html:        {% if value == 'RED' %}<div style="background:#E8402A;color:#fff;text-align:center;padding:10px 0;border-radius:3px">RED</div>
                 {% elsif value == 'AMBER' %}<div style="background:#E9A33A;color:#fff;text-align:center;padding:10px 0;border-radius:3px">AMBER</div>
                 {% else %}<div style="background:#2E7031;color:#fff;text-align:center;padding:10px 0;border-radius:3px">GREEN</div>{% endif %} ;;
  }

  # Captions under the status blocks, so a reader can see what drove the colour without
  # opening the commentary.
  dimension: delivery_status_caption {
    group_label: "Status Blocks"
    label:       "Delivery Caption"
    type:        string
    sql:         CONCAT(CAST(${TABLE}.budget_used_pct AS STRING), '% of budget used against ',
                        CAST(${TABLE}.elapsed_pct AS STRING), '% elapsed. ',
                        CAST(${TABLE}.sprints_over_budget AS STRING), ' of ',
                        CAST(${TABLE}.sprints_with_budget AS STRING), ' sprints over budget.') ;;
  }

  dimension: commercial_status_caption {
    group_label: "Status Blocks"
    label:       "Commercial Caption"
    type:        string
    sql:         CONCAT('Realised rate £', CAST(CAST(${TABLE}.realised_hourly_rate_gbp AS INT64) AS STRING),
                        ' against budget £', CAST(CAST(${TABLE}.budget_hourly_rate_gbp AS INT64) AS STRING),
                        '. Earned margin ', CAST(${TABLE}.earned_margin_pct AS STRING), '%.') ;;
  }

  dimension: client_status_caption {
    group_label: "Status Blocks"
    label:       "Client Caption"
    type:        string
    sql:         CONCAT(CAST(${TABLE}.contact_meetings_in_month AS STRING), ' meetings, last contact ',
                        IFNULL(CAST(${TABLE}.days_since_last_meeting AS STRING), 'unknown'), ' days ago. ',
                        IF(${TABLE}.client_context_basis = 'client',
                           'Client-level signal, shared with the client\'s other live engagements.',
                           'Attributed to this engagement.')) ;;
  }

  dimension: overall_status_sort_order {
    hidden: yes
    type:   number
    sql:    CASE ${TABLE}.overall_status WHEN 'RED' THEN 1 WHEN 'AMBER' THEN 2 ELSE 3 END ;;
  }

  # Individual signals, so a tile can show what drove a colour.
  dimension: budget_used_signal    { group_label: "Signals" label: "Budget Used Signal"    type: string sql: ${TABLE}.budget_used_signal ;; }
  dimension: burn_variance_signal  { group_label: "Signals" label: "Burn Variance Signal"  type: string sql: ${TABLE}.burn_variance_signal ;; }
  dimension: sprint_budget_signal  { group_label: "Signals" label: "Sprint Budget Signal"  type: string sql: ${TABLE}.sprint_budget_signal ;; }
  dimension: sprint_start_signal   { group_label: "Signals" label: "Sprint Start Signal"   type: string sql: ${TABLE}.sprint_start_signal ;; }
  dimension: budget_rate_signal    { group_label: "Signals" label: "Budget Rate Signal"    type: string sql: ${TABLE}.budget_rate_signal ;; }
  dimension: realised_rate_signal  { group_label: "Signals" label: "Realised Rate Signal"  type: string sql: ${TABLE}.realised_rate_signal ;; }
  dimension: margin_signal         { group_label: "Signals" label: "Margin Signal"         type: string sql: ${TABLE}.margin_signal ;; }
  dimension: overdue_signal        { group_label: "Signals" label: "Overdue Signal"        type: string sql: ${TABLE}.overdue_signal ;; }
  dimension: contact_gap_signal    { group_label: "Signals" label: "Contact Gap Signal"    type: string sql: ${TABLE}.contact_gap_signal ;; }
  dimension: sentiment_signal      { group_label: "Signals" label: "Sentiment Signal"      type: string sql: ${TABLE}.sentiment_signal ;; }

  # ── Commentary ────────────────────────────────────────────────────────────────

  dimension: delivery_commentary {
    group_label: "Commentary"
    label:       "Delivery Commentary"
    type:        string
    sql:         ${TABLE}.delivery_commentary ;;
  }

  dimension: commercial_commentary {
    group_label: "Commentary"
    label:       "Commercial Commentary"
    type:        string
    sql:         ${TABLE}.commercial_commentary ;;
  }

  dimension: client_commentary {
    group_label: "Commentary"
    label:       "Client Commentary"
    type:        string
    sql:         ${TABLE}.client_commentary ;;
  }

  dimension: commentary_parsed_ok {
    group_label: "Commentary"
    label:       "Commentary Parsed"
    description: "No means the language model returned something unparseable. Metrics and statuses are unaffected."
    type:        yesno
    sql:         ${TABLE}.commentary_parsed_ok ;;
  }

  # ── Delivery dimensions ───────────────────────────────────────────────────────

  dimension: budget_hours {
    group_label: "Delivery"
    label:       "Budget Hours"
    description: "Budgeted hours across every sprint on the engagement. A whole-engagement figure."
    type:        number
    sql:         ${TABLE}.budget_hours ;;
  }

  dimension: hours_to_date {
    group_label: "Delivery"
    label:       "Hours To Date"
    description: "Billable hours booked to the month end."
    type:        number
    sql:         ${TABLE}.hours_to_date ;;
  }

  dimension: budget_used_pct {
    group_label: "Delivery"
    label:       "Budget Used %"
    type:        number
    value_format_name: decimal_0
    sql:         ${TABLE}.budget_used_pct ;;
  }

  dimension: elapsed_pct {
    group_label: "Delivery"
    label:       "Schedule Elapsed %"
    type:        number
    value_format_name: decimal_0
    sql:         ${TABLE}.elapsed_pct ;;
  }

  dimension: burn_variance_pts {
    group_label: "Delivery"
    label:       "Burn Variance (pts)"
    description: "Budget used percentage minus schedule elapsed percentage. Positive means budget is going faster than calendar."
    type:        number
    value_format_name: decimal_0
    sql:         ${TABLE}.burn_variance_pts ;;
  }

  dimension: budget_hours_remaining {
    group_label: "Delivery"
    label:       "Budget Hours Remaining"
    type:        number
    sql:         ${TABLE}.budget_hours_remaining ;;
  }

  dimension: budget_exhausted_date {
    group_label: "Delivery"
    label:       "Budget Exhausted On"
    description: "The day cumulative hours first reached the budget. Blank where the budget has not been reached."
    type:        date
    datatype:    date
    convert_tz:  no
    sql:         ${TABLE}.budget_exhausted_date ;;
  }

  dimension: weekly_pace_hours {
    group_label: "Delivery"
    label:       "Weekly Pace (hrs)"
    description: "Hours a week over the four weeks to the reporting date."
    type:        number
    value_format_name: decimal_1
    sql:         ${TABLE}.weekly_pace_hours ;;
  }

  dimension: runway_weeks {
    group_label: "Delivery"
    label:       "Runway (weeks)"
    description: "Budget hours left divided by the weekly pace. Zero where the budget is spent."
    type:        number
    value_format_name: decimal_1
    sql:         ${TABLE}.runway_weeks ;;
  }

  dimension: weeks_remaining {
    group_label: "Delivery"
    label:       "Weeks Remaining"
    type:        number
    value_format_name: decimal_1
    sql:         ${TABLE}.weeks_remaining ;;
  }

  dimension: days_remaining {
    group_label: "Delivery"
    label:       "Days Remaining"
    type:        number
    sql:         ${TABLE}.days_remaining ;;
  }

  dimension: projected_total_hours {
    group_label: "Delivery"
    label:       "Projected Total Hours"
    description: "Hours to date plus the weekly pace across the days left in the window."
    type:        number
    sql:         ${TABLE}.projected_total_hours ;;
  }

  dimension: catch_up_ratio {
    group_label: "Delivery"
    label:       "Catch-up Ratio"
    description: "How much faster the team would have to work to use the remaining budget hours in the time left. 1 means the current pace lands it. Amber from 1.2, red from 2."
    type:        number
    value_format_name: decimal_2
    sql:         ${TABLE}.catch_up_ratio ;;
  }

  dimension: projected_delivery_pct {
    group_label: "Delivery"
    label:       "Projected Delivery %"
    description: "Hours projected at the current pace as a share of budget hours."
    type:        number
    value_format_name: decimal_0
    sql:         ${TABLE}.projected_delivery_pct ;;
  }

  dimension: projected_delivery_signal { group_label: "Signals" label: "Projected Delivery Signal" type: string sql: ${TABLE}.projected_delivery_signal ;; }
  dimension: fee_at_risk_signal        { group_label: "Signals" label: "Fee At Risk Signal"        type: string sql: ${TABLE}.fee_at_risk_signal ;; }

  dimension: sprints_total          { group_label: "Delivery" label: "Sprints"                type: number sql: ${TABLE}.sprints_total ;; }
  dimension: sprints_with_budget    { group_label: "Delivery" label: "Sprints With A Budget"  type: number sql: ${TABLE}.sprints_with_budget ;;
    description: "A sprint with no budget cannot be over it, so it is left out of the over-budget share." }
  dimension: sprints_over_budget_pct {
    group_label: "Delivery"
    label:       "Sprints Over Budget %"
    description: "Share of the engagement's budgeted sprints past 100 percent of their own budget. Amber at 50 percent, red at 75."
    type:        number
    value_format_name: decimal_0
    sql:         ${TABLE}.sprints_over_budget_pct ;;
  }
  dimension: sprints_in_flight      { group_label: "Delivery" label: "Sprints In Flight"      type: number sql: ${TABLE}.sprints_in_flight ;; }
  dimension: sprints_over_budget    { group_label: "Delivery" label: "Sprints Over Budget"    type: number sql: ${TABLE}.sprints_over_budget ;; }
  dimension: sprints_late_start     { group_label: "Delivery" label: "Sprints Late To Start"  type: number sql: ${TABLE}.sprints_late_start ;; }
  dimension: max_sprint_days_late   { group_label: "Delivery" label: "Worst Sprint Days Late" type: number sql: ${TABLE}.max_sprint_days_late ;; }

  # ── Commercial dimensions ─────────────────────────────────────────────────────

  dimension: fee_amount_gbp {
    group_label: "Commercial"
    label:       "Engagement Fee"
    description: "Fee across every sprint on the engagement. A whole-engagement figure."
    type:        number
    value_format_name: gbp_0
    sql:         ${TABLE}.fee_amount_gbp ;;
  }

  dimension: revenue_to_date_gbp {
    group_label: "Commercial"
    label:       "Recognised Revenue To Date"
    type:        number
    value_format_name: gbp_0
    sql:         ${TABLE}.revenue_to_date_gbp ;;
  }

  dimension: labour_cost_to_date_gbp {
    group_label: "Commercial"
    label:       "Labour Cost To Date"
    type:        number
    value_format_name: gbp_0
    sql:         ${TABLE}.labour_cost_to_date_gbp ;;
  }

  dimension: expense_cost_to_date_gbp {
    group_label: "Commercial"
    label:       "Expenses To Date"
    type:        number
    value_format_name: gbp_0
    sql:         ${TABLE}.expense_cost_to_date_gbp ;;
  }

  dimension: delivery_cost_to_date_gbp {
    group_label: "Commercial"
    label:       "Delivery Cost To Date"
    description: "Labour cost plus expenses."
    type:        number
    value_format_name: gbp_0
    sql:         ${TABLE}.delivery_cost_to_date_gbp ;;
  }

  dimension: budget_hourly_rate_gbp {
    group_label: "Commercial"
    label:       "Budget Hourly Rate"
    description: "Fee divided by budgeted hours. What the work was sold at."
    type:        number
    value_format_name: gbp_0
    sql:         ${TABLE}.budget_hourly_rate_gbp ;;
  }

  dimension: realised_hourly_rate_gbp {
    group_label: "Commercial"
    label:       "Realised Hourly Rate"
    description: "Recognised revenue to date divided by hours to date. What it is averaging today."
    type:        number
    value_format_name: gbp_0
    sql:         ${TABLE}.realised_hourly_rate_gbp ;;
  }

  dimension: earned_margin_pct {
    group_label: "Commercial"
    label:       "Earned Margin %"
    description: "Revenue minus delivery cost over revenue, both to date. Earned, not projected on the full fee."
    type:        number
    value_format_name: decimal_0
    sql:         ${TABLE}.earned_margin_pct ;;
  }

  dimension: overdue_invoice_count   { group_label: "Commercial" label: "Overdue Invoices"      type: number sql: ${TABLE}.overdue_invoice_count ;; }
  dimension: max_days_overdue        { group_label: "Commercial" label: "Oldest Days Past Due"  type: number sql: ${TABLE}.max_days_overdue ;; }

  dimension: overdue_amount_gbp {
    group_label: "Commercial"
    label:       "Invoiced And Past Due"
    type:        number
    value_format_name: gbp_0
    sql:         ${TABLE}.overdue_amount_gbp ;;
  }

  dimension: open_invoice_amount_gbp {
    group_label: "Commercial"
    label:       "Invoiced Not Yet Due"
    description: "Issued invoices not yet due. Harvest draft billing schedules are excluded."
    type:        number
    value_format_name: gbp_0
    sql:         ${TABLE}.open_invoice_amount_gbp ;;
  }

  # ── In month, for the trend tiles ─────────────────────────────────────────────

  dimension: hours_in_month {
    group_label: "In Month"
    label:       "Hours In Month"
    type:        number
    sql:         ${TABLE}.hours_in_month ;;
  }

  dimension: revenue_in_month_gbp {
    group_label: "In Month"
    label:       "Revenue In Month"
    type:        number
    value_format_name: gbp_0
    sql:         ${TABLE}.revenue_in_month_gbp ;;
  }

  dimension: delivery_cost_in_month_gbp {
    group_label: "In Month"
    label:       "Delivery Cost In Month"
    type:        number
    value_format_name: gbp_0
    sql:         ${TABLE}.delivery_cost_in_month_gbp ;;
  }

  # ── Client context ────────────────────────────────────────────────────────────

  dimension: client_context_basis {
    group_label: "Client"
    label:       "Client Context Basis"
    description: "Engagement where meetings were tied to this engagement. Client where the signal is shared with the client's other live engagements, in which case it does not set the overall status."
    type:        string
    sql:         ${TABLE}.client_context_basis ;;
  }

  dimension: contact_meetings_in_month {
    group_label: "Client"
    label:       "Meetings In Month"
    type:        number
    sql:         ${TABLE}.contact_meetings_in_month ;;
  }

  dimension: contact_sentiment_score {
    group_label: "Client"
    label:       "Meeting Sentiment"
    description: "Average contribution sentiment in the month, from -1 to 1."
    type:        number
    value_format_name: decimal_2
    sql:         ${TABLE}.contact_sentiment_score ;;
  }

  dimension: days_since_last_meeting {
    group_label: "Client"
    label:       "Days Since Last Meeting"
    type:        number
    sql:         ${TABLE}.days_since_last_meeting ;;
  }

  dimension: docs_published_in_month  { group_label: "Client" label: "Documents Published"        type: number sql: ${TABLE}.docs_published_in_month ;; }
  dimension: tasks_active_in_month    { group_label: "Client" label: "Delivery Tasks Active"      type: number sql: ${TABLE}.tasks_active_in_month ;; }
  dimension: messages_in_month        { group_label: "Client" label: "Messages Attributed"        type: number sql: ${TABLE}.messages_in_month ;; }
  dimension: fanout_meeting_count     { group_label: "Client" label: "Generic Client Meetings"    type: number sql: ${TABLE}.fanout_meeting_count ;;
    description: "Meetings that named no engagement and were counted against every live engagement for the client." }
  dimension: client_meetings_in_month { group_label: "Client" label: "Client Meetings In Month"   type: number sql: ${TABLE}.client_meetings_in_month ;; }
  dimension: client_messages_in_month { group_label: "Client" label: "Client Messages In Month"   type: number sql: ${TABLE}.client_messages_in_month ;; }

  # ── Measures ──────────────────────────────────────────────────────────────────
  # One row per engagement month, so the single-value tiles use MAX over a filtered
  # single row. Portfolio tiles use the counts and averages.

  measure: engagement_month_count {
    label: "Engagement Months"
    type:  count
    drill_fields: [detail*]
  }

  measure: engagements_count {
    label: "Engagements"
    type:  count_distinct
    sql:   ${engagement_code} ;;
  }

  measure: red_engagements {
    label:       "Red Engagements"
    description: "Engagements whose overall status is RED."
    type:        count_distinct
    sql:         ${engagement_code} ;;
    filters:     [overall_status: "RED"]
  }

  measure: amber_engagements {
    label:   "Amber Engagements"
    type:    count_distinct
    sql:     ${engagement_code} ;;
    filters: [overall_status: "AMBER"]
  }

  measure: green_engagements {
    label:   "Green Engagements"
    type:    count_distinct
    sql:     ${engagement_code} ;;
    filters: [overall_status: "GREEN"]
  }

  measure: budget_used_pct_value        { group_label: "Tile Values" label: "Budget Used % (value)"        type: max value_format_name: decimal_0 sql: ${budget_used_pct} ;; }
  measure: elapsed_pct_value            { group_label: "Tile Values" label: "Schedule Elapsed % (value)"   type: max value_format_name: decimal_0 sql: ${elapsed_pct} ;; }
  measure: burn_variance_pts_value      { group_label: "Tile Values" label: "Burn Variance (value)"        type: max value_format_name: decimal_0 sql: ${burn_variance_pts} ;; }
  measure: runway_weeks_value           { group_label: "Tile Values" label: "Runway Weeks (value)"         type: max value_format_name: decimal_1 sql: ${runway_weeks} ;; }
  measure: realised_rate_value          { group_label: "Tile Values" label: "Realised Rate (value)"        type: max value_format_name: gbp_0 sql: ${realised_hourly_rate_gbp} ;; }
  measure: budget_rate_value            { group_label: "Tile Values" label: "Budget Rate (value)"          type: max value_format_name: gbp_0 sql: ${budget_hourly_rate_gbp} ;; }
  measure: earned_margin_pct_value      { group_label: "Tile Values" label: "Earned Margin % (value)"      type: max value_format_name: decimal_0 sql: ${earned_margin_pct} ;; }
  measure: overdue_amount_value         { group_label: "Tile Values" label: "Past Due (value)"             type: max value_format_name: gbp_0 sql: ${overdue_amount_gbp} ;; }
  measure: hours_to_date_value          { group_label: "Tile Values" label: "Hours To Date (value)"        type: max sql: ${hours_to_date} ;; }
  measure: budget_hours_value           { group_label: "Tile Values" label: "Budget Hours (value)"         type: max sql: ${budget_hours} ;; }

  # Portfolio-level rollups
  measure: total_hours_in_month {
    group_label: "Portfolio"
    label: "Hours In Month"
    type:  sum
    sql:   ${hours_in_month} ;;
  }

  measure: total_revenue_in_month_gbp {
    group_label: "Portfolio"
    label: "Revenue In Month"
    type:  sum
    value_format_name: gbp_0
    sql:   ${revenue_in_month_gbp} ;;
  }

  measure: total_delivery_cost_in_month_gbp {
    group_label: "Portfolio"
    label: "Delivery Cost In Month"
    type:  sum
    value_format_name: gbp_0
    sql:   ${delivery_cost_in_month_gbp} ;;
  }

  measure: total_overdue_amount_gbp {
    group_label: "Portfolio"
    label: "Invoiced And Past Due"
    type:  sum
    value_format_name: gbp_0
    sql:   ${overdue_amount_gbp} ;;
  }

  measure: average_earned_margin_pct {
    group_label: "Portfolio"
    label: "Average Earned Margin %"
    type:  average
    value_format_name: decimal_0
    sql:   ${earned_margin_pct} ;;
  }

  set: detail {
    fields: [
      company_name, engagement_name, reporting_month_month, overall_status,
      delivery_status, commercial_status, client_status,
      budget_used_pct, burn_variance_pts, realised_hourly_rate_gbp, earned_margin_pct,
      overdue_amount_gbp
    ]
  }
}
