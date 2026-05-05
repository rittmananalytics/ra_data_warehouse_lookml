# staff_event_timeline.view.lkml
#
# Per-event timeline across all signal sources for a single staff member.
# Use this view to drill from the daily fact into the actual ordered
# sequence of events for one person on one day (or hour range).
#
# REQUIRED FILTERS — the derived table will not return useful results without
# both of these set, and Looker will surface an error if they are missing
# (because the SQL CTEs won't filter to a partition):
#   - staff_event_timeline.event_date         (any date filter)
#   - staff_event_timeline.contact_name       (single staff name)
#
# Optional:
#   - staff_event_timeline.event_time_of_day  (HH:MM:SS range)
#
# Sources unioned:
#   - Google Workspace activity events (Drive, Gmail, Meet, Calendar, Chat, Gemini, Login)
#   - Okta successful auth events
#   - Slack messages
#   - Fathom transcript lines
#   - GitHub commits

view: staff_event_timeline {
  derived_table: {
    sql:
      with staff_emails as (
          select
              contact_pk,
              contact_name,
              lower(email) as staff_email
          from `ra-development.analytics.contacts_dim`,
          unnest(all_contact_emails) as email
          where contact_is_staff = true
            and contact_is_active = true
            and lower(email) like '%@rittmananalytics.com'
            and {% condition contact_name %} contact_name {% endcondition %}
      ),

      -- ── Google Workspace events ────────────────────────────────────────
      gws as (
          select
              e.contact_pk                                          as contact_fk,
              e.contact_name                                        as contact_name,
              g.event_ts                                            as event_ts,
              date(g.event_ts)                                      as event_date,
              time(g.event_ts)                                      as event_time_of_day,
              concat('gws_', g.record_type)                         as event_source,
              g.event_name                                          as event_type,
              case
                  when g.is_meet_call_ended
                      then concat('Meet call ended (', cast(round(g.meet_duration_secs / 60.0) as string), ' mins)')
                  when g.is_drive_edit or g.is_drive_create
                      then concat(g.event_name, ' ', coalesce(g.drive_doc_type, 'file'))
                  when g.is_gmail_sent
                      then concat('Email sent from ', g.gmail_from_address)
                  when g.is_gmail_delivery
                      then concat('Email received from ', coalesce(g.gmail_from_address, '(unknown)'))
                  when g.is_calendar_create
                      then 'Calendar event created'
                  when g.is_calendar_rsvp
                      then 'Calendar RSVP'
                  when g.is_chat_message
                      then 'Google Chat message'
                  when g.is_gemini_event
                      then 'Gemini for Workspace'
                  when g.is_login_success
                      then 'Google Workspace login'
                  else g.event_name
              end                                                   as event_summary,
              cast(null as string)                                  as event_url
          from `ra-development.analytics_staging.google_workspace_activity_events` g
          join staff_emails e on lower(g.email) = e.staff_email
          where g.event_ts is not null
            and g.is_substantive_event
            and {% condition event_date %} date(g.event_ts) {% endcondition %}
      ),

      -- ── Okta successful auth ───────────────────────────────────────────
      okta as (
          select
              o.contact_fk                                          as contact_fk,
              e.contact_name                                        as contact_name,
              o.event_ts                                            as event_ts,
              date(o.event_ts)                                      as event_date,
              time(o.event_ts)                                      as event_time_of_day,
              'okta'                                                as event_source,
              o.event_type                                          as event_type,
              concat(
                  o.event_display_message,
                  case when o.client_browser is not null
                      then concat(' (', o.client_browser,
                                  case when o.client_os is not null then concat(' on ', o.client_os) else '' end,
                                  case when o.geo_city is not null then concat(', ', o.geo_city) else '' end,
                                  ')')
                      else ''
                  end
              )                                                     as event_summary,
              cast(null as string)                                  as event_url
          from `ra-development.analytics.authentication_events_fact` o
          join staff_emails e on o.contact_fk = e.contact_pk
          where o.is_success = true
            and o.event_ts is not null
            and {% condition event_date %} date(o.event_ts) {% endcondition %}
      ),

      -- ── Slack messages ─────────────────────────────────────────────────
      slack as (
          select
              m.contact_fk                                          as contact_fk,
              e.contact_name                                        as contact_name,
              m.message_ts                                          as event_ts,
              date(m.message_ts)                                    as event_date,
              time(m.message_ts)                                    as event_time_of_day,
              'slack'                                               as event_source,
              concat('message_', coalesce(m.message_type, 'post'))  as event_type,
              concat(
                  '#', coalesce(m.channel_name, '(dm)'), ': ',
                  substr(coalesce(m.message_text, ''), 1, 120),
                  case when length(coalesce(m.message_text, '')) > 120 then '…' else '' end
              )                                                     as event_summary,
              cast(null as string)                                  as event_url
          from `ra-development.analytics.messages_fact` m
          join staff_emails e on m.contact_fk = e.contact_pk
          where m.message_ts is not null
            and {% condition event_date %} date(m.message_ts) {% endcondition %}
      ),

      -- ── Fathom transcript lines ────────────────────────────────────────
      fathom as (
          select
              ml.person_fk                                          as contact_fk,
              e.contact_name                                        as contact_name,
              ml.time                                               as event_ts,
              date(ml.time)                                         as event_date,
              time(ml.time)                                         as event_time_of_day,
              'fathom'                                              as event_source,
              'transcript_line'                                     as event_type,
              concat(
                  substr(coalesce(ml.text, ''), 1, 120),
                  case when length(coalesce(ml.text, '')) > 120 then '…' else '' end
              )                                                     as event_summary,
              ml.recording_url                                      as event_url
          from `ra-development.analytics.meeting_contact_lines_fact` ml
          join staff_emails e on ml.person_fk = e.contact_pk
          where ml.time is not null
            and {% condition event_date %} date(ml.time) {% endcondition %}
      ),

      -- ── GitHub commits ─────────────────────────────────────────────────
      github as (
          select
              e.contact_pk                                          as contact_fk,
              e.contact_name                                        as contact_name,
              c.commit_author_date                                  as event_ts,
              date(c.commit_author_date)                            as event_date,
              time(c.commit_author_date)                            as event_time_of_day,
              'github_commit'                                       as event_source,
              'commit'                                              as event_type,
              concat(
                  c.repo_name, ': ',
                  substr(split(coalesce(c.commit_message, ''), '\n')[safe_offset(0)], 1, 120),
                  case when length(split(coalesce(c.commit_message, ''), '\n')[safe_offset(0)]) > 120 then '…' else '' end
              )                                                     as event_summary,
              cast(null as string)                                  as event_url
          from `ra-development.analytics_staging.stg_github_activity_commits` c
          join staff_emails e on lower(c.commit_author_email) = e.staff_email
          where c.commit_author_date is not null
            and {% condition event_date %} date(c.commit_author_date) {% endcondition %}
      ),

      all_events as (
          select * from gws
          union all select * from okta
          union all select * from slack
          union all select * from fathom
          union all select * from github
      )

      select
          to_hex(md5(concat(
              cast(event_ts as string), '||',
              coalesce(contact_fk, ''), '||',
              coalesce(event_source, ''), '||',
              coalesce(event_type, ''), '||',
              cast(farm_fingerprint(coalesce(event_summary, '')) as string)
          )))                                                       as event_pk,
          contact_fk,
          contact_name,
          event_ts,
          event_date,
          event_time_of_day,
          event_source,
          event_type,
          event_summary,
          event_url
      from all_events
    ;;
  }

  # ── Required filters ──────────────────────────────────────────────────────────
  # These power the {% condition %} blocks above so the SQL filters down at the
  # source CTEs (partition pruning, fewer bytes scanned). They are not real columns.

  filter: contact_name {
    label:       "Staff Name (filter)"
    description: "Required. The staff member to pull events for. Single value."
    type:        string
    suggest_explore: staff_daily_engagement_fact
    suggest_dimension: staff_daily_engagement_fact.contact_name
  }

  filter: event_date {
    label:       "Event Date (filter)"
    description: "Required. Date or date range to pull events for."
    type:        date
  }

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

  dimension: staff_name {
    label:       "Staff Name"
    description: "Name of the staff member from contacts_dim."
    type:        string
    sql:         ${TABLE}.contact_name ;;
  }

  # ── Time ──────────────────────────────────────────────────────────────────────

  dimension: event_ts {
    label:       "Event Timestamp"
    description: "Exact timestamp of the event (UTC)."
    type:        date_time
    sql:         ${TABLE}.event_ts ;;
  }

  dimension: event_date_dim {
    label:       "Event Date"
    description: "Date the event occurred."
    type:        date
    sql:         ${TABLE}.event_date ;;
  }

  dimension: event_time_of_day {
    label:       "Time of Day"
    description: "Wall-clock time of the event, HH:MM:SS. Filter to constrain to a window of the day."
    type:        string
    sql:         CAST(${TABLE}.event_time_of_day AS STRING) ;;
  }

  dimension: event_hour {
    label:       "Hour of Day"
    description: "0-23 hour the event fired."
    type:        number
    sql:         EXTRACT(HOUR FROM ${TABLE}.event_ts) ;;
  }

  # ── Event classification ──────────────────────────────────────────────────────

  dimension: event_source {
    label:       "Source"
    description: "Which system the event came from."
    type:        string
    sql:         ${TABLE}.event_source ;;
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
  }

  dimension: event_summary {
    label:       "Event"
    description: "Human-readable description of what happened (channel name, file type, repo + commit message, etc.)."
    type:        string
    sql:         ${TABLE}.event_summary ;;
  }

  dimension: event_url {
    label:       "Link"
    description: "Clickable link where one is available (Fathom recording URL)."
    type:        string
    sql:         ${TABLE}.event_url ;;
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
