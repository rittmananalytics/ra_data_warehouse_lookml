# staff_daily_engagement_fact.view.lkml
# Exposes the fct_staff_engagement_daily dbt table (alias: staff_daily_engagement_fact)
# Table: ra-development.analytics.staff_daily_engagement_fact
# One row per staff member per day, rolling 90-day window.
# Partitioned by engagement_date (DAY).

view: staff_daily_engagement_fact {
  sql_table_name: `ra-development.analytics.staff_daily_engagement_fact` ;;

  # ── Primary key ───────────────────────────────────────────────────────────────

  dimension: engagement_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.engagement_pk ;;
  }

  # ── Identity ──────────────────────────────────────────────────────────────────

  dimension: contact_fk {
    label:       "Contact FK"
    hidden:      yes
    type:        string
    sql:         ${TABLE}.contact_fk ;;
  }

  dimension: contact_name {
    label:       "Staff Name"
    description: "Full name of the staff member."
    type:        string
    sql:         ${TABLE}.contact_name ;;
  }

  dimension: contact_email {
    label:       "Staff Email"
    description: "Display email for the staff member (one of their @rittmananalytics.com aliases)."
    type:        string
    sql:         ${TABLE}.contact_email ;;
  }

  dimension: is_delivery_staff {
    label:       "Is Delivery Staff"
    description: "Yes for delivery staff (those with a Harvest weekly capacity); No for non-delivery."
    type:        yesno
    sql:         ${TABLE}.is_delivery_staff ;;
  }

  # ── Time dimensions ───────────────────────────────────────────────────────────

  dimension_group: engagement {
    label:       "Engagement"
    description: "The day this engagement row covers."
    type:        time
    timeframes:  [date, day_of_week, day_of_week_index, week, month, quarter, year]
    datatype:    date
    convert_tz:  no
    sql:         ${TABLE}.engagement_date ;;
  }

  dimension: week_commencing {
    label:       "Week Commencing (Mon)"
    description: "Monday of the week containing engagement_date — used to drill from the weekly mart."
    type:        date
    sql:         DATE_TRUNC(${TABLE}.engagement_date, WEEK(MONDAY)) ;;
  }

  dimension_group: work_start {
    label:       "Work Start"
    description: "Earliest digital signal of the day across GWS / Okta / Slack."
    type:        time
    timeframes:  [time, time_of_day, hour_of_day, hour, date]
    sql:         ${TABLE}.work_start_ts ;;
  }

  dimension_group: work_end {
    label:       "Work End"
    description: "Latest digital signal of the day across GWS / Okta / Slack."
    type:        time
    timeframes:  [time, time_of_day, hour_of_day, hour, date]
    sql:         ${TABLE}.work_end_ts ;;
  }

  # ── Day classification ────────────────────────────────────────────────────────

  dimension: is_weekend {
    label:       "Is Weekend"
    description: "Yes if engagement_date falls on Saturday or Sunday."
    type:        yesno
    sql:         ${TABLE}.is_weekend ;;
  }

  dimension: is_leave_day {
    label:       "Is Leave Day"
    description: "Yes if Harvest shows a leave / holiday / sickness task entry on this date."
    type:        yesno
    sql:         ${TABLE}.is_leave_day ;;
  }

  dimension: is_working_day {
    label:       "Is Working Day"
    description: "Yes if the day is a weekday, not on leave, and shows any Harvest hours / GWS substantive event / multi-source active hour. Drives all weekly averages."
    type:        yesno
    sql:         ${TABLE}.is_working_day ;;
  }

  # ── Effort & capacity ─────────────────────────────────────────────────────────

  dimension: hours_effort {
    label:       "Harvest Hours"
    description: "Hours logged against Harvest tasks on this date."
    type:        number
    sql:         ${TABLE}.hours_effort ;;
    value_format: "0.00"
  }

  dimension: hours_capacity {
    label:       "Daily Capacity (hrs)"
    description: "Daily capacity derived from contact_weekly_capacity (seconds) / 5."
    type:        number
    sql:         ${TABLE}.hours_capacity ;;
    value_format: "0.00"
  }

  dimension: harvest_utilisation_pct {
    label:       "Harvest Utilisation %"
    description: "hours_effort / hours_capacity * 100. Capped at 150% in the score component."
    type:        number
    sql:         ${TABLE}.harvest_utilisation_pct ;;
    value_format: "0.0"
  }

  dimension: work_span_hrs {
    label:       "Work Span (hrs)"
    description: "Hours between earliest and latest digital signal of the day."
    type:        number
    sql:         ${TABLE}.work_span_hrs ;;
    value_format: "0.00"
  }

  # ── Evidenced & corroboration ─────────────────────────────────────────────────

  dimension: evidenced_active_hours {
    label:       "Evidenced Active Hours"
    description: "Distinct hours with substantive GWS activity + meeting hours, capped at 16."
    type:        number
    sql:         ${TABLE}.evidenced_active_hours ;;
    value_format: "0.00"
  }

  dimension: corroboration_pct {
    label:       "Corroboration %"
    description: "Evidenced hours / Harvest hours * 100. NULL if no Harvest hours logged."
    type:        number
    sql:         ${TABLE}.corroboration_pct ;;
    value_format: "0.0"
  }

  # ── Wire adoption ─────────────────────────────────────────────────────────────

  dimension: wire_adoption_score {
    label:       "Wire Adoption Score"
    description: "Weekly Wire Framework adoption score (0-100). NULL for non-delivery staff."
    type:        number
    sql:         ${TABLE}.wire_adoption_score ;;
    value_format: "0.0"
  }

  # ── Multi-source active hours ─────────────────────────────────────────────────

  dimension: active_hourly_buckets {
    label:       "Active Hours (multi-source)"
    description: "Distinct clock hours with any signal across GWS / Okta / Slack / Fathom / GitHub."
    type:        number
    sql:         ${TABLE}.active_hourly_buckets ;;
  }

  dimension: gws_active_hours {
    label:       "GWS Active Hours"
    description: "Distinct hours with at least one substantive Google Workspace event."
    type:        number
    sql:         ${TABLE}.gws_active_hours ;;
  }

  dimension: gws_active_hourly_buckets {
    label:       "GWS Active Hourly Buckets"
    hidden:      yes
    type:        number
    sql:         ${TABLE}.gws_active_hourly_buckets ;;
  }

  dimension: gws_is_substantive_day {
    label:       "GWS Substantive Day"
    description: "Yes if any human-initiated GWS event fired on this date."
    type:        yesno
    sql:         ${TABLE}.gws_is_substantive_day ;;
  }

  # ── Activity signal counts (per day) ──────────────────────────────────────────

  dimension: gws_meet_hours {
    label:       "Meeting Hours"
    type:        number
    sql:         ${TABLE}.gws_meet_hours ;;
    value_format: "0.00"
  }

  dimension: gws_drive_edits {
    label:       "Drive Edits"
    type:        number
    sql:         ${TABLE}.gws_drive_edits ;;
  }

  dimension: gws_drive_creates {
    label:       "Drive Creates"
    type:        number
    sql:         ${TABLE}.gws_drive_creates ;;
  }

  dimension: gws_gmail_sent {
    label:       "Emails Sent"
    type:        number
    sql:         ${TABLE}.gws_gmail_sent ;;
  }

  dimension: gws_gmail_deliveries {
    label:       "Emails Delivered"
    hidden:      yes
    type:        number
    sql:         ${TABLE}.gws_gmail_deliveries ;;
  }

  dimension: gws_calendar_creates {
    label:       "Calendar Events Created"
    type:        number
    sql:         ${TABLE}.gws_calendar_creates ;;
  }

  dimension: gws_chat_messages {
    label:       "Google Chat Messages"
    type:        number
    sql:         ${TABLE}.gws_chat_messages ;;
  }

  dimension: gws_gemini_events {
    label:       "Gemini Events"
    type:        number
    sql:         ${TABLE}.gws_gemini_events ;;
  }

  dimension: gws_login_events {
    label:       "GWS Login Events"
    hidden:      yes
    type:        number
    sql:         ${TABLE}.gws_login_events ;;
  }

  dimension: slack_messages {
    label:       "Slack Messages"
    type:        number
    sql:         ${TABLE}.slack_messages ;;
  }

  dimension: github_commits {
    label:       "GitHub Commits"
    type:        number
    sql:         ${TABLE}.github_commits ;;
  }

  dimension: github_prs_merged {
    label:       "GitHub PRs Merged"
    type:        number
    sql:         ${TABLE}.github_prs_merged ;;
  }

  dimension: okta_logins {
    label:       "Okta Logins"
    type:        number
    sql:         ${TABLE}.okta_logins ;;
  }

  # ── Score components ──────────────────────────────────────────────────────────

  dimension: score_harvest_utilisation {
    label:       "Score: Harvest Utilisation"
    description: "0-35 (delivery) or 0-55 (non-delivery)."
    type:        number
    sql:         ${TABLE}.score_harvest_utilisation ;;
    value_format: "0.00"
  }

  dimension: score_corroboration {
    label:       "Score: Corroboration"
    description: "0-15."
    type:        number
    sql:         ${TABLE}.score_corroboration ;;
    value_format: "0.00"
  }

  dimension: score_wire_adoption {
    label:       "Score: Wire Adoption"
    description: "0-20 (delivery only)."
    type:        number
    sql:         ${TABLE}.score_wire_adoption ;;
    value_format: "0.00"
  }

  dimension: score_meeting_engagement {
    label:       "Score: Meeting Engagement"
    description: "0-10."
    type:        number
    sql:         ${TABLE}.score_meeting_engagement ;;
    value_format: "0.00"
  }

  dimension: score_code_output {
    label:       "Score: Code Output"
    description: "0-10."
    type:        number
    sql:         ${TABLE}.score_code_output ;;
    value_format: "0.00"
  }

  dimension: score_communications {
    label:       "Score: Communications"
    description: "0-5 (delivery) or 0-10 (non-delivery)."
    type:        number
    sql:         ${TABLE}.score_communications ;;
    value_format: "0.00"
  }

  dimension: score_ai_tool_usage {
    label:       "Score: AI Tool Usage"
    description: "0-5 (delivery) or 0-10 (non-delivery)."
    type:        number
    sql:         ${TABLE}.score_ai_tool_usage ;;
    value_format: "0.00"
  }

  dimension: activity_score_pct {
    label:       "Activity Score %"
    description: "Composite 0-100 weighted score across all 7 components."
    type:        number
    sql:         ${TABLE}.activity_score_pct ;;
    value_format: "0.0"
  }

  # ── Measures ──────────────────────────────────────────────────────────────────

  measure: count {
    label:       "Count Days"
    description: "Number of staff-day rows."
    type:        count
    drill_fields: [drill_to_day*]
  }

  measure: count_working_days {
    label:       "Working Days"
    description: "Days where is_working_day = Yes."
    type:        count
    filters:     [is_working_day: "Yes"]
    drill_fields: [drill_to_day*]
  }

  measure: count_leave_days {
    label:       "Leave Days"
    type:        count
    filters:     [is_leave_day: "Yes"]
    drill_fields: [drill_to_day*]
  }

  measure: total_harvest_hrs {
    label:       "Total Harvest Hours"
    type:        sum
    sql:         ${TABLE}.hours_effort ;;
    value_format: "0.0"
    drill_fields: [drill_to_day*]
  }

  measure: avg_harvest_hrs {
    label:       "Avg Harvest Hours / Working Day"
    type:        average
    sql:         ${TABLE}.hours_effort ;;
    filters:     [is_working_day: "Yes"]
    value_format: "0.0"
  }

  measure: total_evidenced_hrs {
    label:       "Total Evidenced Hours"
    type:        sum
    sql:         ${TABLE}.evidenced_active_hours ;;
    value_format: "0.0"
    drill_fields: [drill_to_day*]
  }

  measure: total_meet_hrs {
    label:       "Total Meeting Hours"
    type:        sum
    sql:         ${TABLE}.gws_meet_hours ;;
    value_format: "0.0"
    drill_fields: [drill_to_day*]
  }

  measure: total_active_hours {
    label:       "Total Active Hours (multi-source)"
    description: "Sum of distinct active hours across the period."
    type:        sum
    sql:         ${TABLE}.active_hourly_buckets ;;
    drill_fields: [drill_to_day*]
  }

  measure: avg_active_hours {
    label:       "Avg Active Hours / Working Day"
    type:        average
    sql:         ${TABLE}.active_hourly_buckets ;;
    filters:     [is_working_day: "Yes"]
    value_format: "0.0"
  }

  measure: avg_work_span_hrs {
    label:       "Avg Work Span (hrs)"
    type:        average
    sql:         ${TABLE}.work_span_hrs ;;
    filters:     [is_working_day: "Yes"]
    value_format: "0.0"
  }

  measure: avg_harvest_utilisation_pct {
    label:       "Avg Harvest Utilisation %"
    type:        average
    sql:         ${TABLE}.harvest_utilisation_pct ;;
    filters:     [is_working_day: "Yes"]
    value_format: "0.0"
  }

  measure: avg_corroboration_pct {
    label:       "Avg Corroboration %"
    type:        average
    sql:         ${TABLE}.corroboration_pct ;;
    filters:     [is_working_day: "Yes"]
    value_format: "0.0"
  }

  measure: avg_activity_score {
    label:       "Avg Activity Score %"
    type:        average
    sql:         ${TABLE}.activity_score_pct ;;
    filters:     [is_working_day: "Yes"]
    value_format: "0.0"
    drill_fields: [drill_to_day*]
  }

  measure: max_activity_score {
    label:       "Max Activity Score %"
    type:        max
    sql:         ${TABLE}.activity_score_pct ;;
    value_format: "0.0"
  }

  measure: min_activity_score {
    label:       "Min Activity Score %"
    type:        min
    sql:         ${TABLE}.activity_score_pct ;;
    filters:     [is_working_day: "Yes"]
    value_format: "0.0"
  }

  measure: latest_wire_adoption_score {
    label:       "Latest Wire Adoption Score"
    description: "Most recent (per day) Wire adoption score across the filtered rows."
    type:        max
    sql:         ${TABLE}.wire_adoption_score ;;
    value_format: "0.0"
  }

  measure: total_commits {
    label:       "Total GitHub Commits"
    type:        sum
    sql:         ${TABLE}.github_commits ;;
    drill_fields: [drill_to_day*]
  }

  measure: total_prs_merged {
    label:       "Total PRs Merged"
    type:        sum
    sql:         ${TABLE}.github_prs_merged ;;
    drill_fields: [drill_to_day*]
  }

  measure: total_slack_messages {
    label:       "Total Slack Messages"
    type:        sum
    sql:         ${TABLE}.slack_messages ;;
    drill_fields: [drill_to_day*]
  }

  measure: total_drive_edits {
    label:       "Total Drive Edits"
    type:        sum
    sql:         ${TABLE}.gws_drive_edits ;;
    drill_fields: [drill_to_day*]
  }

  measure: total_drive_creates {
    label:       "Total Drive Creates"
    type:        sum
    sql:         ${TABLE}.gws_drive_creates ;;
    drill_fields: [drill_to_day*]
  }

  measure: total_emails_sent {
    label:       "Total Emails Sent"
    type:        sum
    sql:         ${TABLE}.gws_gmail_sent ;;
    drill_fields: [drill_to_day*]
  }

  measure: total_chat_messages {
    label:       "Total Google Chat Messages"
    type:        sum
    sql:         ${TABLE}.gws_chat_messages ;;
    drill_fields: [drill_to_day*]
  }

  measure: total_gemini_events {
    label:       "Total Gemini Events"
    type:        sum
    sql:         ${TABLE}.gws_gemini_events ;;
    drill_fields: [drill_to_day*]
  }

  measure: total_calendar_creates {
    label:       "Total Calendar Events Created"
    type:        sum
    sql:         ${TABLE}.gws_calendar_creates ;;
    drill_fields: [drill_to_day*]
  }

  measure: total_okta_logins {
    label:       "Total Okta Logins"
    type:        sum
    sql:         ${TABLE}.okta_logins ;;
    drill_fields: [drill_to_day*]
  }

  # ── Drill set ─────────────────────────────────────────────────────────────────
  # Used by drill_fields on every measure to give a uniform per-day breakdown.

  set: drill_to_day {
    fields: [
      contact_name,
      engagement_date,
      is_working_day,
      hours_effort,
      active_hourly_buckets,
      evidenced_active_hours,
      gws_meet_hours,
      slack_messages,
      github_commits,
      github_prs_merged,
      gws_drive_edits,
      gws_drive_creates,
      gws_gmail_sent,
      gws_gemini_events,
      activity_score_pct
    ]
  }
}
