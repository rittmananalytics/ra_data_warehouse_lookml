view: bigquery_custom_sql {
  derived_table: {
    sql: WITH web_events_fact AS (select * except(page_title),
                    replace(page_title,'—','-') as page_title,
                    min(event_ts) over (partition by site, replace(page_title,'—','-') order by event_ts) as page_title_published_at_ts,
                    date_diff(date(event_ts),date(min(event_ts) over (partition by site, replace(page_title,'—','-') order by event_ts)), month) as months_since_page_title_published_at_ts,
                    date_diff(date(event_ts),date(min(event_ts) over (partition by site, replace(page_title,'—','-') order by event_ts)), day) as days_since_page_title_published_at_ts,
                    count(distinct case when event_type = 'Page View' then web_events_pk end) over (partition by site, replace(page_title,'—','-')) as total_page_views,
                    count(distinct blended_user_id) over (partition by site, replace(page_title,'—','-')) as total_unique_viewers
             from analytics.web_events_fact)
      SELECT
          case when (replace(replace(lower(web_sessions_fact.utm_source),'/',''),'.com','')) in ('linkedin','facebook') and (lower(web_sessions_fact.utm_medium)) = 'paid' then 'Paid Social'
                    when ((replace(replace(lower(web_sessions_fact.utm_source),'/',''),'.com','')) = 'linkedin' or web_sessions_fact.referrer_host like '%linkedin%') and (lower(web_sessions_fact.utm_medium)) != 'paid' then 'Organic Social'
                    when web_sessions_fact.channel = 'Social' then 'Organic Social'
                    when web_sessions_fact.channel in ('facebook','linkedin') and (lower(web_sessions_fact.utm_medium)) = 'social' then 'Organic Social'
                    when (lower(web_sessions_fact.utm_medium)) = 'social' and web_sessions_fact.channel = 'Direct' then 'Organic Social'
                    when (replace(replace(lower(web_sessions_fact.utm_source),'/',''),'.com','')) = 'substack' and (lower(web_sessions_fact.utm_medium)) != 'email' then 'Organic Social'
                    when (replace(replace(lower(web_sessions_fact.utm_source),'/',''),'.com','')) like 'pocket_%' then 'Referral'
                    when (web_sessions_fact.referrer_host like '%rittmananalytics.com%' and web_sessions_fact.referrer_host not like '%blog.rittmananalytics.com%') or web_sessions_fact.referrer_host like 'calendly.com' then 'Direct'
                    when web_sessions_fact.referrer_host like '%medium.com%' or web_sessions_fact.referrer_host like '%blog.rittmananalytics.com%'  then 'Organic Social'
                    else web_sessions_fact.channel end AS web_sessions_fact_channel,
              (FORMAT_TIMESTAMP('%F', TIMESTAMP_TRUNC(web_sessions_fact.session_start_ts , WEEK(MONDAY)))) AS web_sessions_fact_session_start_ts_week,
          COALESCE(SUM(( case when (web_events_fact.site = 'careers.rittmananalytics.com') then null
                    when (web_events_fact.event_type = 'Meeting Booked') then 16
                    else safe_cast(split(web_events_fact.page_category,":")[SAFE_OFFSET(0)] as int64) end)), 0) AS web_events_fact_total_visitor_value,
          COUNT(DISTINCT case when web_events_fact.event_type = 'Page View' then web_events_fact.web_events_pk end) AS web_events_fact_total_page_views,
          COUNT(DISTINCT web_events_fact.blended_user_id ) AS web_events_fact_total_unique_users,
          COUNT(DISTINCT web_sessions_fact.web_sessions_pk ) AS web_sessions_fact_total_sessions
      FROM `analytics.web_sessions_fact`
           AS web_sessions_fact
      LEFT JOIN web_events_fact ON web_sessions_fact.session_id = web_events_fact.session_id
      WHERE ((( web_sessions_fact.session_start_ts  ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -89 DAY))) AND ( web_sessions_fact.session_start_ts  ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -89 DAY), INTERVAL 90 DAY)))))
      GROUP BY
          1,
          2
      LIMIT 30000 ;;
  }

  dimension: page_view_per_user {
    type: number
    label: "Page View per User"
    sql: SAFE_DIVIDE(${web_events_fact_total_page_views}, ${web_events_fact_total_unique_users}) ;;
  }

  dimension: web_events_fact_total_page_views {
    type: number
    label: "web_events_fact_total_page_views"
    sql: ${TABLE}.web_events_fact_total_page_views ;;
  }

  dimension: web_events_fact_total_unique_users {
    type: number
    label: "web_events_fact_total_unique_users"
    sql: ${TABLE}.web_events_fact_total_unique_users ;;
  }

  dimension: web_events_fact_total_visitor_value {
    type: number
    label: "web_events_fact_total_visitor_value"
    sql: ${TABLE}.web_events_fact_total_visitor_value ;;
  }

  dimension: web_sessions_fact_channel {
    type: string
    label: "web_sessions_fact_channel"
    sql: ${TABLE}.web_sessions_fact_channel ;;
  }

  dimension: web_sessions_fact_session_start_ts_week {
    type: string
    label: "web_sessions_fact_session_start_ts_week"
    sql: ${TABLE}.web_sessions_fact_session_start_ts_week ;;
  }

  dimension: web_sessions_fact_total_sessions {
    type: number
    label: "web_sessions_fact_total_sessions"
    sql: ${TABLE}.web_sessions_fact_total_sessions ;;
  }

  dimension_group: web_sessions_fact_session_start_ts_week_as_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    datatype: date
    convert_tz: no
    label: "web_sessions_fact_session_start_ts_week (as date)"
    sql: DATE(SAFE_CAST(${TABLE}.web_sessions_fact_session_start_ts_week AS TIMESTAMP)) ;;
  }

  measure: count {
    type: count
    label: "Record Count"
  }

  measure: total_page_view_per_user {
    type: sum
    label: "Page View per User (sum)"
    sql: ${page_view_per_user} ;;
  }

  measure: total_web_events_fact_total_unique_users {
    type: sum
    label: "web_events_fact_total_unique_users (sum)"
    sql: ${web_events_fact_total_unique_users} ;;
  }
}
