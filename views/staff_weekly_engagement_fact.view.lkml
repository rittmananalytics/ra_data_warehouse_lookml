# staff_weekly_engagement_fact.view.lkml
# Exposes the mart_staff_engagement_weekly dbt table (alias: staff_weekly_engagement_fact)
# Table: ra-development.analytics.staff_weekly_engagement_fact
# Grain: one row per staff member per ISO week (week_commencing = Monday)

view: staff_weekly_engagement_fact {
  sql_table_name: `ra-development.analytics.staff_weekly_engagement_fact` ;;

  # ── Primary key ───────────────────────────────────────────────────────────────

  dimension: engagement_week_pk {
    primary_key: yes
    hidden:      yes
    type:        string
    sql:         ${TABLE}.engagement_week_pk ;;
  }

  # ── Foreign keys ──────────────────────────────────────────────────────────────

  dimension: contact_fk {
    hidden: yes
    type:   string
    sql:    ${TABLE}.contact_fk ;;
  }

  # ── Staff identity ────────────────────────────────────────────────────────────

  dimension: contact_name {
    label:       "Staff Name"
    description: "Full name of the staff member."
    type:        string
    sql:         ${TABLE}.contact_name ;;
    group_label: "Staff"
    drill_fields: [week_commencing_date, avg_activity_score_pct]
  }

  dimension: contact_email {
    label:       "Staff Email"
    description: "Work email address of the staff member."
    type:        string
    sql:         ${TABLE}.contact_email ;;
    group_label: "Staff"
  }

  dimension: is_delivery_staff {
    label:       "Is Delivery Staff"
    description: "Yes for consultants on client delivery; No for operations/admin."
    type:        yesno
    sql:         ${TABLE}.is_delivery_staff ;;
    group_label: "Staff"
  }

  # ── Time dimensions ───────────────────────────────────────────────────────────

  dimension_group: week_commencing {
    label:       "Week Commencing"
    description: "The Monday that opens the ISO work week this row covers."
    type:        time
    timeframes:  [date, week, month, quarter, year]
    datatype:    date
    sql:         ${TABLE}.week_commencing ;;
  }

  dimension: is_current_week {
    label:       "Is Current Week"
    description: "Yes for the week that contains today."
    type:        yesno
    sql:         ${TABLE}.week_commencing = DATE_TRUNC(CURRENT_DATE(), WEEK(MONDAY)) ;;
    group_label: "Week Commencing"
  }

  # ── Day classification ────────────────────────────────────────────────────────

  dimension: working_days {
    label:       "Working Days"
    description: "Count of week days in the week that were neither leave nor public holiday."
    type:        number
    sql:         ${TABLE}.working_days ;;
    group_label: "Days"
  }

  dimension: leave_days {
    label:       "Leave Days"
    description: "Count of days recorded as annual leave or absence during the week."
    type:        number
    sql:         ${TABLE}.leave_days ;;
    group_label: "Days"
  }

  # ── Work timing ───────────────────────────────────────────────────────────────

  dimension: avg_work_start {
    label:       "Avg Work Start"
    description: "Average time the staff member's first tracked activity began (HH:MM, 24-hr)."
    type:        string
    sql:         ${TABLE}.avg_work_start ;;
    group_label: "Timing"
  }

  dimension: avg_work_end {
    label:       "Avg Work End"
    description: "Average time of the last tracked activity in the day (HH:MM, 24-hr)."
    type:        string
    sql:         ${TABLE}.avg_work_end ;;
    group_label: "Timing"
  }

  dimension: avg_work_span_hrs {
    label:       "Avg Work Span (hrs)"
    description: "Average hours between first and last tracked signal on working days."
    type:        number
    sql:         ${TABLE}.avg_work_span_hrs ;;
    value_format: "0.0"
    group_label: "Timing"
  }

  dimension: avg_work_active_hours {
    label:       "Avg Active Hours"
    description: "Average daily distinct 10-minute active buckets (from GWS, Slack, GitHub, Okta, Fathom) converted to hours."
    type:        number
    sql:         ${TABLE}.avg_work_active_hours ;;
    value_format: "0.0"
    group_label: "Timing"
  }

  dimension: avg_work_active_hrs_pct {
    label:       "Active Hours % of Span"
    description: "Average active hours as a percentage of the total work span — a measure of density of activity within the working day."
    type:        number
    sql:         ${TABLE}.avg_work_active_hrs_pct ;;
    value_format: "0.0\"%\""
    group_label: "Timing"
  }

  # ── Effort ────────────────────────────────────────────────────────────────────

  dimension: total_harvest_hrs {
    label:       "Total Harvest Hours"
    description: "Total hours logged in Harvest for the week."
    type:        number
    sql:         ${TABLE}.total_harvest_hrs ;;
    value_format: "0.0"
    group_label: "Effort"
  }

  dimension: avg_harvest_hrs {
    label:       "Avg Daily Harvest Hours"
    description: "Average Harvest hours per working day."
    type:        number
    sql:         ${TABLE}.avg_harvest_hrs ;;
    value_format: "0.0"
    group_label: "Effort"
  }

  dimension: total_evidenced_hrs {
    label:       "Total Evidenced Hours"
    description: "Total hours corroborated by at least one digital signal (GWS, GitHub, Slack, etc.)."
    type:        number
    sql:         ${TABLE}.total_evidenced_hrs ;;
    value_format: "0.0"
    group_label: "Effort"
  }

  dimension: avg_evidenced_hrs {
    label:       "Avg Daily Evidenced Hours"
    description: "Average evidenced hours per working day."
    type:        number
    sql:         ${TABLE}.avg_evidenced_hrs ;;
    value_format: "0.0"
    group_label: "Effort"
  }

  dimension: total_meet_hrs {
    label:       "Total Meeting Hours"
    description: "Total Google Meet hours for the week."
    type:        number
    sql:         ${TABLE}.total_meet_hrs ;;
    value_format: "0.0"
    group_label: "Effort"
  }

  dimension: avg_meet_hrs {
    label:       "Avg Daily Meeting Hours"
    description: "Average Google Meet hours per working day."
    type:        number
    sql:         ${TABLE}.avg_meet_hrs ;;
    value_format: "0.0"
    group_label: "Effort"
  }

  # ── Rates ─────────────────────────────────────────────────────────────────────

  dimension: avg_harvest_utilisation_pct {
    label:       "Harvest Utilisation %"
    description: "Average daily Harvest hours as a % of the staff member's weekly capacity."
    type:        number
    sql:         ${TABLE}.avg_harvest_utilisation_pct ;;
    value_format: "0.0\"%\""
    group_label: "Rates"
  }

  dimension: avg_corroboration_pct {
    label:       "Corroboration %"
    description: "Percentage of Harvest hours that are corroborated by at least one digital evidence signal."
    type:        number
    sql:         ${TABLE}.avg_corroboration_pct ;;
    value_format: "0.0\"%\""
    group_label: "Rates"
  }

  # ── Google Workspace signals ───────────────────────────────────────────────────

  dimension: total_gws_active_hours {
    label:       "GWS Active Hours"
    description: "Total Google Workspace active hours for the week (GWS signals only)."
    type:        number
    sql:         ${TABLE}.total_gws_active_hours ;;
    value_format: "0.0"
    group_label: "Google Workspace"
  }

  dimension: total_drive_edits {
    label:       "Drive Edits"
    description: "Total Google Drive document edits for the week."
    type:        number
    sql:         ${TABLE}.total_drive_edits ;;
    value_format: "#,##0"
    group_label: "Google Workspace"
  }

  dimension: total_drive_creates {
    label:       "Drive Creates"
    description: "Total Google Drive documents created for the week."
    type:        number
    sql:         ${TABLE}.total_drive_creates ;;
    value_format: "#,##0"
    group_label: "Google Workspace"
  }

  dimension: total_emails_sent {
    label:       "Emails Sent"
    description: "Total Gmail messages sent for the week."
    type:        number
    sql:         ${TABLE}.total_emails_sent ;;
    value_format: "#,##0"
    group_label: "Google Workspace"
  }

  dimension: total_gws_chat_msgs {
    label:       "Google Chat Messages"
    description: "Total Google Chat messages sent for the week."
    type:        number
    sql:         ${TABLE}.total_gws_chat_msgs ;;
    value_format: "#,##0"
    group_label: "Google Workspace"
  }

  dimension: total_gemini_events {
    label:       "Gemini Events"
    description: "Total Google Gemini AI tool interactions for the week."
    type:        number
    sql:         ${TABLE}.total_gemini_events ;;
    value_format: "#,##0"
    group_label: "Google Workspace"
  }

  # ── Communications ────────────────────────────────────────────────────────────

  dimension: total_slack_msgs {
    label:       "Slack Messages"
    description: "Total Slack messages sent for the week."
    type:        number
    sql:         ${TABLE}.total_slack_msgs ;;
    value_format: "#,##0"
    group_label: "Communications"
  }

  # ── Code output ───────────────────────────────────────────────────────────────

  dimension: total_commits {
    label:       "GitHub Commits"
    description: "Total GitHub commits authored during the week."
    type:        number
    sql:         ${TABLE}.total_commits ;;
    value_format: "#,##0"
    group_label: "Code"
  }

  dimension: total_prs_merged {
    label:       "GitHub PRs Merged"
    description: "Total GitHub pull requests merged during the week."
    type:        number
    sql:         ${TABLE}.total_prs_merged ;;
    value_format: "#,##0"
    group_label: "Code"
  }

  # ── Wire Framework ────────────────────────────────────────────────────────────

  dimension: wire_adoption_score {
    label:       "Wire Adoption Score"
    description: "Wire Framework weekly adoption score for this staff member."
    type:        number
    sql:         ${TABLE}.wire_adoption_score ;;
    value_format: "0.0"
    group_label: "Wire"
  }

  # ── Composite engagement score ────────────────────────────────────────────────

  dimension: avg_activity_score_pct {
    label:       "Activity Score %"
    description: "Composite weekly engagement score (0–100) combining Harvest utilisation, digital corroboration, Wire adoption, meetings, code output, communications, and AI tool usage."
    type:        number
    sql:         ${TABLE}.avg_activity_score_pct ;;
    value_format: "0"
    group_label: "Score"
  }

  dimension: activity_score_band {
    label:       "Activity Score Band"
    description: "Score banded into LOW / MEDIUM / HIGH / EXCELLENT for quick filtering."
    type:        string
    sql: CASE
           WHEN ${TABLE}.avg_activity_score_pct >= 80 THEN 'EXCELLENT'
           WHEN ${TABLE}.avg_activity_score_pct >= 60 THEN 'HIGH'
           WHEN ${TABLE}.avg_activity_score_pct >= 40 THEN 'MEDIUM'
           WHEN ${TABLE}.avg_activity_score_pct IS NOT NULL THEN 'LOW'
           ELSE 'UNSCORED'
         END ;;
    group_label: "Score"
    suggestions: ["EXCELLENT", "HIGH", "MEDIUM", "LOW", "UNSCORED"]
    html:
      {% if value == 'EXCELLENT' %}
        <span style="color:#ffffff;background:#1e8a44;padding:2px 8px;border-radius:4px;font-weight:bold;">{{ value }}</span>
      {% elsif value == 'HIGH' %}
        <span style="color:#ffffff;background:#2e86c1;padding:2px 8px;border-radius:4px;font-weight:bold;">{{ value }}</span>
      {% elsif value == 'MEDIUM' %}
        <span style="color:#ffffff;background:#e08600;padding:2px 8px;border-radius:4px;font-weight:bold;">{{ value }}</span>
      {% elsif value == 'LOW' %}
        <span style="color:#ffffff;background:#c0392b;padding:2px 8px;border-radius:4px;font-weight:bold;">{{ value }}</span>
      {% else %}
        <span style="color:#555555;background:#e0e0e0;padding:2px 8px;border-radius:4px;font-weight:bold;">{{ value }}</span>
      {% endif %}
    ;;
  }

  dimension: activity_score_sort {
    hidden:      yes
    type:        number
    sql: CASE ${TABLE}.avg_activity_score_pct
           WHEN NULL THEN 0
           ELSE ${TABLE}.avg_activity_score_pct
         END ;;
  }

  # ── Measures ──────────────────────────────────────────────────────────────────

  measure: count_weeks {
    label:       "Count Weeks"
    description: "Number of staff-week rows."
    type:        count
    drill_fields: [contact_name, week_commencing_date, avg_activity_score_pct, total_harvest_hrs]
  }

  measure: count_staff {
    label:       "Count Staff"
    description: "Distinct staff members in the result."
    type:        count_distinct
    sql:         ${contact_fk} ;;
  }

  # -- Timing

  measure: avg_work_span_hrs_avg {
    label:       "Avg Work Span (hrs)"
    description: "Average work span across staff and weeks."
    type:        average
    sql:         ${TABLE}.avg_work_span_hrs ;;
    value_format: "0.0"
    group_label: "Timing"
  }

  measure: avg_active_hours_avg {
    label:       "Avg Active Hours"
    description: "Average daily active hours across staff and weeks."
    type:        average
    sql:         ${TABLE}.avg_work_active_hours ;;
    value_format: "0.0"
    group_label: "Timing"
  }

  measure: avg_active_hrs_pct_avg {
    label:       "Avg Active Hours % of Span"
    description: "Average active-hours-to-span ratio across staff and weeks."
    type:        average
    sql:         ${TABLE}.avg_work_active_hrs_pct ;;
    value_format: "0.0\"%\""
    group_label: "Timing"
  }

  # -- Effort

  measure: total_harvest_hrs_sum {
    label:       "Total Harvest Hours"
    description: "Sum of Harvest hours across the filtered rows."
    type:        sum
    sql:         ${TABLE}.total_harvest_hrs ;;
    value_format: "#,##0.0"
    group_label: "Effort"
    drill_fields: [contact_name, week_commencing_date, total_harvest_hrs]
  }

  measure: avg_harvest_hrs_avg {
    label:       "Avg Daily Harvest Hours"
    description: "Average of the per-week daily Harvest average."
    type:        average
    sql:         ${TABLE}.avg_harvest_hrs ;;
    value_format: "0.0"
    group_label: "Effort"
  }

  measure: total_evidenced_hrs_sum {
    label:       "Total Evidenced Hours"
    description: "Sum of digitally evidenced hours across the filtered rows."
    type:        sum
    sql:         ${TABLE}.total_evidenced_hrs ;;
    value_format: "#,##0.0"
    group_label: "Effort"
  }

  measure: total_meet_hrs_sum {
    label:       "Total Meeting Hours"
    description: "Sum of Google Meet hours across the filtered rows."
    type:        sum
    sql:         ${TABLE}.total_meet_hrs ;;
    value_format: "#,##0.0"
    group_label: "Effort"
  }

  # -- Rates

  measure: avg_harvest_utilisation {
    label:       "Avg Harvest Utilisation %"
    description: "Average Harvest utilisation across staff and weeks."
    type:        average
    sql:         ${TABLE}.avg_harvest_utilisation_pct ;;
    value_format: "0.0\"%\""
    group_label: "Rates"
    drill_fields: [contact_name, week_commencing_date, avg_harvest_utilisation_pct]
  }

  measure: avg_corroboration {
    label:       "Avg Corroboration %"
    description: "Average corroboration rate across staff and weeks."
    type:        average
    sql:         ${TABLE}.avg_corroboration_pct ;;
    value_format: "0.0\"%\""
    group_label: "Rates"
  }

  # -- Activity signals

  measure: total_drive_edits_sum {
    label:       "Total Drive Edits"
    type:        sum
    sql:         ${TABLE}.total_drive_edits ;;
    value_format: "#,##0"
    group_label: "Google Workspace"
  }

  measure: total_drive_creates_sum {
    label:       "Total Drive Creates"
    type:        sum
    sql:         ${TABLE}.total_drive_creates ;;
    value_format: "#,##0"
    group_label: "Google Workspace"
  }

  measure: total_emails_sent_sum {
    label:       "Total Emails Sent"
    type:        sum
    sql:         ${TABLE}.total_emails_sent ;;
    value_format: "#,##0"
    group_label: "Google Workspace"
  }

  measure: total_gws_chat_msgs_sum {
    label:       "Total Google Chat Messages"
    type:        sum
    sql:         ${TABLE}.total_gws_chat_msgs ;;
    value_format: "#,##0"
    group_label: "Google Workspace"
  }

  measure: total_gemini_events_sum {
    label:       "Total Gemini Events"
    type:        sum
    sql:         ${TABLE}.total_gemini_events ;;
    value_format: "#,##0"
    group_label: "Google Workspace"
  }

  measure: total_slack_msgs_sum {
    label:       "Total Slack Messages"
    type:        sum
    sql:         ${TABLE}.total_slack_msgs ;;
    value_format: "#,##0"
    group_label: "Communications"
  }

  measure: total_commits_sum {
    label:       "Total GitHub Commits"
    type:        sum
    sql:         ${TABLE}.total_commits ;;
    value_format: "#,##0"
    group_label: "Code"
  }

  measure: total_prs_merged_sum {
    label:       "Total PRs Merged"
    type:        sum
    sql:         ${TABLE}.total_prs_merged ;;
    value_format: "#,##0"
    group_label: "Code"
  }

  # -- Score

  measure: avg_activity_score {
    label:       "Avg Activity Score %"
    description: "Average composite engagement score across staff and weeks."
    type:        average
    sql:         ${TABLE}.avg_activity_score_pct ;;
    value_format: "0"
    group_label: "Score"
    drill_fields: [contact_name, week_commencing_date, avg_activity_score_pct, activity_score_band]
  }

  measure: max_activity_score {
    label:       "Max Activity Score %"
    type:        max
    sql:         ${TABLE}.avg_activity_score_pct ;;
    value_format: "0"
    group_label: "Score"
  }

  measure: min_activity_score {
    label:       "Min Activity Score %"
    type:        min
    sql:         ${TABLE}.avg_activity_score_pct ;;
    value_format: "0"
    group_label: "Score"
  }

  measure: avg_wire_adoption_score {
    label:       "Avg Wire Adoption Score"
    description: "Average Wire Framework adoption score across staff and weeks."
    type:        average
    sql:         ${TABLE}.wire_adoption_score ;;
    value_format: "0.0"
    group_label: "Wire"
  }
}
