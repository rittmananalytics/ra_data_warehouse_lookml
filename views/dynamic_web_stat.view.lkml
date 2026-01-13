
view: dynamic_web_stats {
  derived_table: {
    sql: with web_stats as (select * except(page_title),
                    replace(page_title,'—','-') as page_title,
                    min(event_ts) over (partition by replace(page_title,'—','-') order by event_ts) as page_title_published_at_ts,
                    date_diff(date(event_ts),date(min(event_ts) over (partition by replace(page_title,'—','-') order by event_ts)), month) as months_since_page_title_published_at_ts,
                    date_diff(date(event_ts),date(min(event_ts) over (partition by replace(page_title,'—','-') order by event_ts)), day) as days_since_page_title_published_at_ts,
                    count(distinct case when event_type = 'Page View' then web_events_pk end) over (partition by replace(page_title,'—','-')) as total_page_views,
                    count(distinct blended_user_id) over (partition by replace(page_title,'—','-')) as total_unique_viewers
             from analytics.web_events_fact)
      SELECT
          (FORMAT_TIMESTAMP('%F', TIMESTAMP_TRUNC(web_sessions_fact.session_start_ts , WEEK(MONDAY)))) AS web_sessions_fact_session_start_ts_week,
          (case when (case when (replace(replace(lower(web_sessions_fact.utm_source),'/',''),'.com','')) in ('linkedin','facebook') and (lower(web_sessions_fact.utm_medium)) = 'paid' then 'Paid Social'
                    when ((replace(replace(lower(web_sessions_fact.utm_source),'/',''),'.com','')) = 'linkedin' or web_sessions_fact.referrer_host like '%linkedin%') and (lower(web_sessions_fact.utm_medium)) != 'paid' then 'Organic Social'
                    when web_sessions_fact.channel = 'Social' then 'Organic Social'
                    when web_sessions_fact.channel in ('facebook','linkedin') and (lower(web_sessions_fact.utm_medium)) = 'social' then 'Organic Social'
                    when (lower(web_sessions_fact.utm_medium)) = 'social' and web_sessions_fact.channel = 'Direct' then 'Organic Social'
                    when (replace(replace(lower(web_sessions_fact.utm_source),'/',''),'.com','')) = 'substack' and (lower(web_sessions_fact.utm_medium)) != 'email' then 'Organic Social'
                    when (replace(replace(lower(web_sessions_fact.utm_source),'/',''),'.com','')) like 'pocket_%' then 'Referral'
                    when (web_sessions_fact.referrer_host like '%rittmananalytics.com%' and web_sessions_fact.referrer_host not like '%blog.rittmananalytics.com%') or web_sessions_fact.referrer_host like 'calendly.com' then 'Direct'
                    when web_sessions_fact.referrer_host like '%medium.com%' or web_sessions_fact.referrer_host like '%blog.rittmananalytics.com%'  then 'Organic Social'
                    else web_sessions_fact.channel end) in ('Paid Social','Paid Search') then 'Paid'
                    when (case when (replace(replace(lower(web_sessions_fact.utm_source),'/',''),'.com','')) in ('linkedin','facebook') and (lower(web_sessions_fact.utm_medium)) = 'paid' then 'Paid Social'
                    when ((replace(replace(lower(web_sessions_fact.utm_source),'/',''),'.com','')) = 'linkedin' or web_sessions_fact.referrer_host like '%linkedin%') and (lower(web_sessions_fact.utm_medium)) != 'paid' then 'Organic Social'
                    when web_sessions_fact.channel = 'Social' then 'Organic Social'
                    when web_sessions_fact.channel in ('facebook','linkedin') and (lower(web_sessions_fact.utm_medium)) = 'social' then 'Organic Social'
                    when (lower(web_sessions_fact.utm_medium)) = 'social' and web_sessions_fact.channel = 'Direct' then 'Organic Social'
                    when (replace(replace(lower(web_sessions_fact.utm_source),'/',''),'.com','')) = 'substack' and (lower(web_sessions_fact.utm_medium)) != 'email' then 'Organic Social'
                    when (replace(replace(lower(web_sessions_fact.utm_source),'/',''),'.com','')) like 'pocket_%' then 'Referral'
                    when (web_sessions_fact.referrer_host like '%rittmananalytics.com%' and web_sessions_fact.referrer_host not like '%blog.rittmananalytics.com%') or web_sessions_fact.referrer_host like 'calendly.com' then 'Direct'
                    when web_sessions_fact.referrer_host like '%medium.com%' or web_sessions_fact.referrer_host like '%blog.rittmananalytics.com%'  then 'Organic Social'
                    else web_sessions_fact.channel end) in ('Organic Social','Organic Video','Organic Search','Email','Referral') then 'Organic'
                    else (case when (replace(replace(lower(web_sessions_fact.utm_source),'/',''),'.com','')) in ('linkedin','facebook') and (lower(web_sessions_fact.utm_medium)) = 'paid' then 'Paid Social'
                    when ((replace(replace(lower(web_sessions_fact.utm_source),'/',''),'.com','')) = 'linkedin' or web_sessions_fact.referrer_host like '%linkedin%') and (lower(web_sessions_fact.utm_medium)) != 'paid' then 'Organic Social'
                    when web_sessions_fact.channel = 'Social' then 'Organic Social'
                    when web_sessions_fact.channel in ('facebook','linkedin') and (lower(web_sessions_fact.utm_medium)) = 'social' then 'Organic Social'
                    when (lower(web_sessions_fact.utm_medium)) = 'social' and web_sessions_fact.channel = 'Direct' then 'Organic Social'
                    when (replace(replace(lower(web_sessions_fact.utm_source),'/',''),'.com','')) = 'substack' and (lower(web_sessions_fact.utm_medium)) != 'email' then 'Organic Social'
                    when (replace(replace(lower(web_sessions_fact.utm_source),'/',''),'.com','')) like 'pocket_%' then 'Referral'
                    when (web_sessions_fact.referrer_host like '%rittmananalytics.com%' and web_sessions_fact.referrer_host not like '%blog.rittmananalytics.com%') or web_sessions_fact.referrer_host like 'calendly.com' then 'Direct'
                    when web_sessions_fact.referrer_host like '%medium.com%' or web_sessions_fact.referrer_host like '%blog.rittmananalytics.com%'  then 'Organic Social'
                    else web_sessions_fact.channel end) end) AS web_sessions_fact_channel_category,
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
          case when web_sessions_fact.user_session_number = 1 then 'New' else 'Returning' end  AS web_sessions_fact_new_or_returning_user,
          COUNT(DISTINCT web_sessions_fact.web_sessions_pk ) AS web_sessions_fact_total_web_sessions_pk,
          COUNT(DISTINCT web_events_fact.blended_user_id ) AS web_events_fact_total_blended_user_id,
          COUNT(DISTINCT case when web_events_fact.event_type = 'Page View' then web_events_fact.web_events_pk end) AS web_events_fact_total_page_views,
          COUNT(DISTINCT CASE WHEN (( web_events_fact.page_category ) = '02: Social') THEN case when web_events_fact.event_type = 'Page View' then web_events_fact.web_events_pk end  ELSE NULL END) AS web_events_fact_total_blog_page_views,
          COUNT(DISTINCT CASE WHEN (( web_events_fact.page_category ) = '06: Case Study') THEN case when web_events_fact.event_type = 'Page View' then web_events_fact.web_events_pk end  ELSE NULL END) AS web_events_fact_total_case_study_page_views,
          COUNT(DISTINCT CASE WHEN (( web_events_fact.page_category ) = '04: Marketing') THEN case when web_events_fact.event_type = 'Page View' then web_events_fact.web_events_pk end  ELSE NULL END) AS web_events_fact_total_marketing_page_views,
          COUNT(DISTINCT CASE WHEN (( web_events_fact.page_category ) = '08: Services') THEN case when web_events_fact.event_type = 'Page View' then web_events_fact.web_events_pk end  ELSE NULL END) AS web_events_fact_total_services_page_views,
          SAFE_DIVIDE(COUNT(DISTINCT(case when  web_sessions_fact.is_bounced_session   = TRUE then  web_sessions_fact.web_sessions_pk   end)),( COUNT(DISTINCT web_sessions_fact.web_sessions_pk ) ))   AS web_sessions_fact_bounced_session_rate
      FROM `analytics.web_sessions_fact`
           AS web_sessions_fact
      LEFT JOIN `analytics.web_events_fact` web_events_fact ON web_sessions_fact.session_id = web_events_fact.session_id
      WHERE {% condition channel_filter %} case when (replace(replace(lower(web_sessions_fact.utm_source),'/',''),'.com','')) in ('linkedin','facebook') and (lower(web_sessions_fact.utm_medium)) = 'paid' then 'Paid Social'
                    when ((replace(replace(lower(web_sessions_fact.utm_source),'/',''),'.com','')) = 'linkedin' or web_sessions_fact.referrer_host like '%linkedin%') and (lower(web_sessions_fact.utm_medium)) != 'paid' then 'Organic Social'
                    when web_sessions_fact.channel = 'Social' then 'Organic Social'
                    when web_sessions_fact.channel in ('facebook','linkedin') and (lower(web_sessions_fact.utm_medium)) = 'social' then 'Organic Social'
                    when (lower(web_sessions_fact.utm_medium)) = 'social' and web_sessions_fact.channel = 'Direct' then 'Organic Social'
                    when (replace(replace(lower(web_sessions_fact.utm_source),'/',''),'.com','')) = 'substack' and (lower(web_sessions_fact.utm_medium)) != 'email' then 'Organic Social'
                    when (replace(replace(lower(web_sessions_fact.utm_source),'/',''),'.com','')) like 'pocket_%' then 'Referral'
                    when (web_sessions_fact.referrer_host like '%rittmananalytics.com%' and web_sessions_fact.referrer_host not like '%blog.rittmananalytics.com%') or web_sessions_fact.referrer_host like 'calendly.com' then 'Direct'
                    when web_sessions_fact.referrer_host like '%medium.com%' or web_sessions_fact.referrer_host like '%blog.rittmananalytics.com%'  then 'Organic Social'
                    else web_sessions_fact.channel end {% endcondition %}
      GROUP BY
          1,
          2,
          3,
          4 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  filter: channel_filter {
    type: string
    default_value: "Direct"
    suggestions: ["Direct","Organic Search","Referral","Organic Social","Paid Search","Organic Video","Paid Social"]
    bypass_suggest_restrictions: no
  }

  parameter: channel_selector {
    allowed_value: {value: "All Channels" label: "All Channels"}
    allowed_value: {value: "Direct" label:"Direct"}
    allowed_value: {value: "Organic Search" label:"Organic Search"}
    allowed_value: {value: "Referral" label:"Referral"}
    allowed_value: {value: "Organic Social" label:"Organic Social"}
    allowed_value: {value: "Paid Search" label:"Paid Search"}
    allowed_value: {value: "Organic Video" label:"Organic Video"}
    allowed_value: {value: "Paid Social" label:"Paid Social"}
    default_value: "All Channels"
  }

  dimension: web_sessions_fact_session_start_ts_week {
    type: string
    sql: ${TABLE}.web_sessions_fact_session_start_ts_week ;;
  }

  dimension: web_sessions_fact_channel_category {
    type: string
    sql: ${TABLE}.web_sessions_fact_channel_category ;;
  }

  dimension: web_sessions_fact_channel {
    type: string
    sql: ${TABLE}.web_sessions_fact_channel ;;
  }

  dimension: web_sessions_fact_new_or_returning_user {
    type: string
    sql: ${TABLE}.web_sessions_fact_new_or_returning_user ;;
  }

  dimension: web_sessions_fact_total_web_sessions_pk {
    type: number
    sql: ${TABLE}.web_sessions_fact_total_web_sessions_pk ;;
  }

  dimension: web_events_fact_total_blended_user_id {
    type: number
    sql: ${TABLE}.web_events_fact_total_blended_user_id ;;
  }

  dimension: web_events_fact_total_page_views {
    type: number
    sql: ${TABLE}.web_events_fact_total_page_views ;;
  }

  dimension: web_events_fact_total_blog_page_views {
    type: number
    sql: ${TABLE}.web_events_fact_total_blog_page_views ;;
  }

  dimension: web_events_fact_total_case_study_page_views {
    type: number
    sql: ${TABLE}.web_events_fact_total_case_study_page_views ;;
  }

  dimension: web_events_fact_total_marketing_page_views {
    type: number
    sql: ${TABLE}.web_events_fact_total_marketing_page_views ;;
  }

  dimension: web_events_fact_total_services_page_views {
    type: number
    sql: ${TABLE}.web_events_fact_total_services_page_views ;;
  }

  dimension: web_sessions_fact_bounced_session_rate {
    type: number
    sql: ${TABLE}.web_sessions_fact_bounced_session_rate ;;
  }

  set: detail {
    fields: [
      web_sessions_fact_session_start_ts_week,
      web_sessions_fact_channel_category,
      web_sessions_fact_channel,
      web_sessions_fact_new_or_returning_user,
      web_sessions_fact_total_web_sessions_pk,
      web_events_fact_total_blended_user_id,
      web_events_fact_total_page_views,
      web_events_fact_total_blog_page_views,
      web_events_fact_total_case_study_page_views,
      web_events_fact_total_marketing_page_views,
      web_events_fact_total_services_page_views,
      web_sessions_fact_bounced_session_rate
    ]
  }
}
