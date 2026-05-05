# staff_event_timeline_fact.view.lkml
# Exposes the fct_staff_event_timeline dbt table (alias: staff_event_timeline_fact)
# Table: ra-development.analytics.staff_event_timeline_fact
# Grain: one row per event per staff member; rolling 90-day window.
# Partitioned by event_date (DAY), clustered by contact_fk.

view: staff_event_timeline_fact {
  sql_table_name: `ra-development.analytics.staff_event_timeline_fact` ;;

  # ── Primary key ───────────────────────────────────────────────────────────────

  dimension: event_pk {
    primary_key: yes
    hidden:      yes
    type:        string
    sql:         ${TABLE}.event_pk ;;
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
    description: "Name of the staff member from contacts_dim."
    type:        string
    sql:         ${TABLE}.contact_name ;;
    group_label: "Event"
  }

  # ── Time ──────────────────────────────────────────────────────────────────────

  dimension_group: event {
    label:       "Event"
    description: "Exact timestamp of the event (UTC)."
    type:        time
    timeframes:  [time, time_of_day, hour, hour_of_day, date, day_of_week, week, month]
    sql:         ${TABLE}.event_ts ;;
  }

  dimension: event_date_dim {
    label:       "Event Date (partition)"
    description: "Date the event occurred — partition key on the underlying table; use this for date filters to get partition pruning."
    type:        date
    sql:         ${TABLE}.event_date ;;
    group_label: "Event"
  }

  dimension: event_time_of_day_str {
    label:       "Time of Day (HH:MM:SS)"
    description: "Wall-clock time of the event as a string. Filter to constrain to a window of the day."
    type:        string
    sql:         CAST(${TABLE}.event_time_of_day AS STRING) ;;
    group_label: "Event"
  }

  dimension: event_hour_num {
    label:       "Hour of Day (0-23)"
    description: "Hour of day for the event timestamp."
    type:        number
    sql:         EXTRACT(HOUR FROM ${TABLE}.event_ts) ;;
    group_label: "Event"
  }

  # ── Event classification ──────────────────────────────────────────────────────

  dimension: event_source {
    label:       "Source"
    description: "Which system the event came from."
    type:        string
    sql:         ${TABLE}.event_source ;;
    group_label: "Event"
    suggestions: [
      "gws_drive", "gws_gmail", "gws_meet", "gws_calendar",
      "gws_chat", "gws_gemini_for_workspace", "gws_login", "gws_token",
      "okta", "slack", "fathom", "github_commit"
    ]
    html:
      {% if value contains 'gws' %}
        <span style="color:#ffffff;background:#4285f4;padding:2px 6px;border-radius:4px;">{{ value }}</span>
      {% elsif value == 'okta' %}
        <span style="color:#ffffff;background:#007dc1;padding:2px 6px;border-radius:4px;">{{ value }}</span>
      {% elsif value == 'slack' %}
        <span style="color:#ffffff;background:#4a154b;padding:2px 6px;border-radius:4px;">{{ value }}</span>
      {% elsif value == 'fathom' %}
        <span style="color:#ffffff;background:#00a3ff;padding:2px 6px;border-radius:4px;">{{ value }}</span>
      {% elsif value == 'github_commit' %}
        <span style="color:#ffffff;background:#24292e;padding:2px 6px;border-radius:4px;">{{ value }}</span>
      {% else %}
        {{ value }}
      {% endif %}
    ;;
  }

  dimension: event_type {
    label:       "Event Type"
    description: "Source-specific type, e.g. 'edit', 'commit', 'login_success'."
    type:        string
    sql:         ${TABLE}.event_type ;;
    group_label: "Event"
  }

  dimension: event_summary {
    label:       "Event"
    description: "Human-readable description of what happened (channel name, file type, repo + commit message, etc.)."
    type:        string
    sql:         ${TABLE}.event_summary ;;
    group_label: "Event"
  }

  dimension: event_url {
    label:       "Link"
    description: "Clickable link where one is available (Fathom recording URL)."
    type:        string
    sql:         ${TABLE}.event_url ;;
    group_label: "Event"
    html:
      {% if value %}
        <a href="{{ value }}" target="_blank">open</a>
      {% else %}—{% endif %}
    ;;
  }

  # ── Measures ──────────────────────────────────────────────────────────────────

  measure: count {
    label:       "Count Events"
    type:        count
  }

  measure: count_sources {
    label:       "Distinct Sources"
    type:        count_distinct
    sql:         ${TABLE}.event_source ;;
  }
}
