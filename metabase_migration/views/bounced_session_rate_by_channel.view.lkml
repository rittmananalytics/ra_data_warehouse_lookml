view: bounced_session_rate_by_channel {
  derived_table: {
    sql: SELECT
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
          SAFE_DIVIDE(COUNT(DISTINCT(case when  web_sessions_fact.is_bounced_session   = TRUE then  web_sessions_fact.web_sessions_pk   end)),( COUNT(DISTINCT web_sessions_fact.web_sessions_pk ) ))   AS web_sessions_fact_bounced_session_rate
      FROM `analytics.web_sessions_fact`
           AS web_sessions_fact
      WHERE ((( web_sessions_fact.session_start_ts  ) >= ((TIMESTAMP(DATETIME_ADD(DATETIME(TIMESTAMP_TRUNC(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), MONTH)), INTERVAL -11 MONTH)))) AND ( web_sessions_fact.session_start_ts  ) < ((TIMESTAMP(DATETIME_ADD(DATETIME(TIMESTAMP(DATETIME_ADD(DATETIME(TIMESTAMP_TRUNC(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), MONTH)), INTERVAL -11 MONTH))), INTERVAL 12 MONTH))))))
      GROUP BY
          1
      ORDER BY
          2 DESC
      LIMIT 500 ;;
  }

  dimension: web_sessions_fact_bounced_session_rate {
    type: number
    label: "web_sessions_fact_bounced_session_rate"
    sql: ${TABLE}.web_sessions_fact_bounced_session_rate ;;
  }

  dimension: web_sessions_fact_channel {
    type: string
    label: "web_sessions_fact_channel"
    sql: ${TABLE}.web_sessions_fact_channel ;;
  }
}
