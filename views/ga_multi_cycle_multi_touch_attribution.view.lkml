view: ga_multi_cycle_multi_touch_attribution {
  derived_table: {
    persist_for: "1 hour"
    sql: WITH
          events AS (
        SELECT
          TIMESTAMP_MICROS(event_timestamp) as event_ts,
          CONCAT(user_pseudo_id,'-',event_name,'-',CAST(event_timestamp AS STRING)) as event_id,
          user_pseudo_id AS user_pseudo_id,
          user_id,
          traffic_source.name as utm_channel,
          traffic_source.medium as utm_medium,
          traffic_source.source as utm_source,
          event_name as event_type,
          (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS session_id,
          (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_number') AS session_number,
          (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'page_referrer') AS referrer_host,
          (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'page_location') AS page_path,
          (SELECT value.string_value FROM UNNEST(event_params) WHERE event_name = 'page_view' AND key = 'page_title') AS page_title,
          ecommerce.purchase_revenue AS order_value,
          ecommerce.transaction_id AS order_id,
          platform as channel,
          device.category as device_category,
          device.operating_system,
          device.language,
          device.is_limited_ad_tracking,
          null as browser,
          null as hostname,
          geo.continent,
          geo.country,
          geo.region,
          geo.city
        FROM
          `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131` -- modify to your project
          ),
        id_stitching as (
        SELECT
          DISTINCT user_pseudo_id as user_pseudo_id,
          LAST_VALUE(user_id ignore nulls) OVER (
                  partition by user_pseudo_id
                  order by event_ts
                  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) AS user_id,
          MIN(event_ts) OVER (
                  PARTITION BY user_pseudo_id
              ) AS first_seen_at,
          MAX(event_ts) OVER (
                  PARTITION BY user_pseudo_id
              ) AS last_seen_at
         FROM
          events),
        sessions AS (
          SELECT
            user_pseudo_id,
            TIMESTAMP_MICROS(event_timestamp) AS session_start_ts,
            CAST(LEAD(TIMESTAMP_MICROS(event_timestamp),1) OVER (PARTITION BY CONCAT(user_pseudo_id)
              ORDER BY
                event_timestamp) AS timestamp) AS session_end_ts,
            (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS session_id,
            (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_number') AS session_number,
            (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'page_referrer') AS referrer_host,
            (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'page_location') AS landing_page_path,
            (SELECT value.string_value FROM UNNEST(event_params) WHERE event_name = 'page_view' AND key = 'page_title') AS landing_page_title,
            traffic_source.name as utm_campaign,
            traffic_source.medium as utm_medium,
            traffic_source.source as utm_source,
            platform as channel,
            CASE
            WHEN device.category = "desktop" THEN "desktop"
            WHEN device.category = "tablet" AND app_info.id IS NULL THEN "tablet-web"
            WHEN device.category = "mobile" AND app_info.id IS NULL THEN "mobile-web"
            WHEN device.category = "tablet" AND app_info.id IS NOT NULL THEN "tablet-app"
            WHEN device.category = "mobile" AND app_info.id IS NOT NULL THEN "mobile-app"
            END AS device,
            device.mobile_brand_name mobile_brand_name,
            device.mobile_model_name mobile_model_name,
            device.mobile_marketing_name mobile_marketing_name,
            device.mobile_os_hardware_model mobile_os_hardware_model,
            device.operating_system operating_system,
            device.operating_system_version operating_system_version,
            device.vendor_id vendor_id,
            device.advertising_id advertising_id,
            device.language language,
            device.is_limited_ad_tracking is_limited_ad_tracking,
            device.time_zone_offset_seconds,
            null as browser ,
            null as browser_version,
            null as browser,
            device.web_info.browser_version,
            null as hostname,
            geo.continent continent,
            geo.country country,
            geo.region region,
            geo.city city,
            count(distinct CONCAT(user_pseudo_id,'-',event_name,'-',CAST(event_timestamp AS STRING))) over (partition by (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id')) as events
          FROM
            `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131` s -- modify to your project
          WHERE
            event_name = 'session_start'

      ),
      user_stitched_sessions as (
      SELECT
      sessions.*,
      coalesce(id_stitching.user_id, sessions.user_pseudo_id) as stitched_user_id
      FROM sessions
      LEFT JOIN id_stitching using (user_pseudo_id)
      ),
      user_stitched_events as (
      SELECT
      events.*,
      coalesce(id_stitching.user_id, events.user_pseudo_id) as stitched_user_id
      FROM events
      LEFT JOIN id_stitching using (user_pseudo_id)
      ),
      events_filtered as
      (select
      *
      from (
      select
      *,
      first_value(case when event_type = 'add_payment_info' then event_id end ignore nulls) over (
      partition by stitched_user_id
      order by event_ts
      rows between unbounded preceding and unbounded following
      ) as first_registration_event_id,
      first_value(case when event_type='purchase' then event_id end ignore nulls) over (
      partition by stitched_user_id
      order by event_ts
      rows between unbounded preceding and unbounded following
      ) as first_order_event_id
      from
      user_stitched_events
      )
      where
      event_type = 'purchase' or (event_type='add_payment_info' and event_id = first_registration_event_id)
      ),
      converting_events AS (
      SELECT
      e.stitched_user_id,
      session_id,
      event_type,
      order_id AS order_id,
      order_value AS first_order_revenue,
      order_value AS repeat_order_revenue,
      CASE
      WHEN event_type IN ('purchase' ) THEN 1
      ELSE
      0
      END
      AS count_conversions,
      CASE
      WHEN event_type='purchase' AND event_id = first_order_event_id THEN 1
      ELSE
      0
      END
      AS count_first_order_conversions,
      CASE
      WHEN event_type='purchase' AND event_id != first_order_event_id THEN 1
      ELSE
      0
      END
      AS count_repeat_order_conversions,
      CASE
      WHEN event_type = 'purchase' THEN 1
      ELSE
      0
      END
      AS count_order_conversions,
      case when
      event_type='add_payment_info' and event_id = first_registration_event_id
      then 1 else 0 end

      as  count_registration_conversions,
      event_ts AS converted_ts
      FROM
      events_filtered e ),

      /* Now we aggregate those events into sessions (and per-user sub sessions, see above note about session_id), with session_id sourced from either the Snowplow session_id (domain_session_id)
      or the order_id/user_id as session id substitute when the order/account opening happened outside a Snowplow session.
      See the stg_custom_events_order_events.sql and stg_custom_events_registration_events.sql models for the logic for those "dbt_generated" sessions */

      converting_sessions_deduped AS (
      SELECT
      session_id AS session_id,
      MAX(stitched_user_id) AS stitched_user_id,

      /* note that because a session could in-theory contain account opening, first order and multiple repeat order events (conversions) within the same session, we have to aggregate the
      value of those conversions when working at the session level */

      SUM(first_order_revenue) AS first_order_revenue,
      SUM(repeat_order_revenue) AS repeat_order_revenue,
      SUM(count_first_order_conversions) AS count_first_order_conversions,
      SUM(count_repeat_order_conversions) AS count_repeat_order_conversions,
      SUM(count_order_conversions) AS count_order_conversions,
      SUM(count_registration_conversions) AS count_registration_conversions,
      SUM(count_registration_conversions) + SUM(count_first_order_conversions) + SUM(count_repeat_order_conversions) AS count_conversions,
      MAX(converted_ts) AS converted_ts,
      -- actually the max_converted_ts
      MIN(converted_ts) AS min_converted_ts
      FROM
      converting_events
      GROUP BY
      1 ),

      /* Combine (join) those conversion sessions with all of the sessions that led-up to those conversions */ touchpoint_and_converting_sessions_labelled AS (

      SELECT
      *
      FROM (
      SELECT
      *,
      FIRST_VALUE(converted_ts IGNORE NULLS) OVER (PARTITION BY stitched_user_id ORDER BY session_start_ts ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS conversion_cycle_conversion_ts,
      -- used later on to calculate days to conversion
      ROW_NUMBER() OVER (PARTITION BY stitched_user_id ORDER BY session_start_ts) AS session_seq
      FROM (
      SELECT
      s.stitched_user_id AS stitched_user_id,
      s.session_id AS session_id,
      s.session_start_ts AS session_start_ts,
      s.session_end_ts AS session_end_ts,
      c.converted_ts AS converted_ts,
      c.min_converted_ts AS min_converted_ts,
      COALESCE(SUM(c.count_conversions),0) AS count_conversions,
      COALESCE(SUM(c.count_order_conversions),0) AS count_order_conversions,
      COALESCE(SUM(c.count_first_order_conversions),0) AS count_first_order_conversions,
      COALESCE(SUM(c.count_repeat_order_conversions),0) AS count_repeat_order_conversions,
      COALESCE(SUM(c.count_registration_conversions),0) AS count_registration_conversions,
      COALESCE(CASE
      WHEN c.count_conversions >0 THEN TRUE
      ELSE
      FALSE
      END
      ,FALSE) AS conversion_session,
      COALESCE(CASE
      WHEN c.count_conversions >0 THEN 1
      ELSE
      0
      END
      ,0) AS conversion_event, --used when calculating the conversion cycle number
      COALESCE(CASE
      WHEN c.count_order_conversions>0 THEN 1
      ELSE
      0
      END
      ,0) AS order_conversion_event,--used when calculating the order converion cycle number
      COALESCE(CASE
      WHEN c.count_registration_conversions>0 THEN 1
      ELSE
      0
      END
      ,0) AS registration_conversion_event,
      -- see above
      COALESCE(CASE
      WHEN c.count_first_order_conversions>0 THEN 1
      ELSE
      0
      END
      ,0) AS first_order_conversion_event,
      -- ditto
      COALESCE(CASE
      WHEN c.count_repeat_order_conversions>0 THEN 1
      ELSE
      0
      END
      ,0) AS repeat_order_conversion_event,
      -- ditto
      utm_source AS utm_source,
      cast(null as string) AS utm_content,
      utm_medium AS utm_medium,
      utm_campaign AS utm_campaign,
      referrer_host AS referrer_host,
      channel AS channel,
      CASE
      WHEN LOWER(utm_source) = '(direct)' THEN FALSE
      ELSE
      TRUE
      END
      AS is_non_direct_channel,
      CASE
      WHEN LOWER(utm_medium) LIKE '%paid%' THEN TRUE
      ELSE
      FALSE
      END
      AS is_paid_channel,
      events AS events,
      c.first_order_revenue,
      c.repeat_order_revenue,
      city,
      continent,
      country,
      region
      FROM
      user_stitched_sessions s
      LEFT JOIN
      converting_sessions_deduped c
      ON
      s.session_id = c.session_id
      GROUP BY
      1,
      2,
      3,
      4,
      5,
      6,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25,
      26,
      27,
      28,
      29,
      30,
      31,
      32) )
      WHERE
      conversion_cycle_conversion_ts >= session_start_ts ),
      /* This is a multi-cycle attribution model which means that we attribute the value of each order placed by a user to the sessions that led to that order, starting with the session after the last order
      We therefore need to split each users' sessions into "conversion cycles", the sessions leading-up to and potentially including the session in which the conversion happened. This next CTE starts this
      process of calculating those conversion cycles by first calculating, for each session for each user, how many conversions of each type have been recorded for that user at the time the session started
      by summing the number of conversions recorded in the rows (sessions) up to and including the current row (session) */ touchpoint_and_converting_sessions_labelled_with_conversion_number AS (
      SELECT
      *,
      SUM(conversion_event) OVER (PARTITION BY stitched_user_id ORDER BY session_start_ts ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS user_total_conversions,
      SUM(count_order_conversions) OVER (PARTITION BY stitched_user_id ORDER BY session_start_ts ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS user_total_order_conversions,
      SUM(count_registration_conversions) OVER (PARTITION BY stitched_user_id ORDER BY session_start_ts ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS user_total_registration_conversions,
      SUM(count_first_order_conversions) OVER (PARTITION BY stitched_user_id ORDER BY session_start_ts ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS user_total_first_order_conversions,
      SUM(count_repeat_order_conversions) OVER (PARTITION BY stitched_user_id ORDER BY session_start_ts ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS user_total_repeat_order_conversions
      FROM
      touchpoint_and_converting_sessions_labelled /* A conversion cycle is defined as all sessions (rows) leading up-to and including the conversion session (conversion cycle #1), with the conversion cycle then incrementing to conversion cycle #2 for the rows
      leading up to the next conversion, then we're on to conversion cycle #3, and so on.
      There can only be one conversion cycle for user registration conversions, and the same is true for first order conversions. Repeat order conversions start at conversion cycle #1 (if the user has made their second order)
      and then increment to #2 for the users' third order, etc. This block of code calculates which conversion cycle each row (session) is within for each of the conversion cycle types */ ),
      touchpoint_and_converting_sessions_labelled_with_conversion_number_and_conversion_cycles AS (
      SELECT
      *,
      CASE
      WHEN registration_conversion_event = 0 THEN MAX(COALESCE(user_total_registration_conversions,0)) OVER (PARTITION BY stitched_user_id ORDER BY session_start_ts ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) + 1
      ELSE
      MAX(user_total_registration_conversions) OVER (PARTITION BY stitched_user_id ORDER BY session_start_ts ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW )
      END
      AS user_registration_conversion_cycle,
      CASE
      WHEN conversion_event = 0 THEN MAX(COALESCE(user_total_conversions,0)) OVER (PARTITION BY stitched_user_id ORDER BY session_start_ts ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) + 1
      ELSE
      MAX(user_total_conversions) OVER (PARTITION BY stitched_user_id ORDER BY session_start_ts ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW )
      END
      AS user_conversion_cycle,
      CASE
      WHEN first_order_conversion_event = 0 THEN MAX(COALESCE(user_total_first_order_conversions,0)) OVER (PARTITION BY stitched_user_id ORDER BY session_start_ts ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) + 1
      ELSE
      MAX(user_total_first_order_conversions) OVER (PARTITION BY stitched_user_id ORDER BY session_start_ts ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW )
      END
      AS user_first_order_conversion_cycle,
      CASE
      WHEN repeat_order_conversion_event = 0 THEN MAX(COALESCE(user_total_repeat_order_conversions,0)) OVER (PARTITION BY stitched_user_id ORDER BY session_start_ts ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) + 1
      ELSE
      MAX(user_total_repeat_order_conversions) OVER (PARTITION BY stitched_user_id ORDER BY session_start_ts ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW )
      END
      AS user_repeat_order_conversion_cycle
      FROM
      touchpoint_and_converting_sessions_labelled_with_conversion_number ),
      /* As we only consider rows (sessions) within a certain number of days before each conversion happened (the "lookback window") we first have to calculate a day number for each row.
      We do this by reference to a set starting date, arbitrarily chosen (2018-01-01) with the assumption that it's earlier than any conversion we need to attribute value for;
      we could also achieve the same result (turning date into a number) via the Unix date or a similar date>integer transformation */ touchpoint_and_converting_sessions_labelled_with_conversion_number_and_conversion_cycles_and_day_number AS (
      SELECT
      *,
      (DATE_DIFF(DATE(session_start_ts),DATE('2018-01-01'),DAY)) AS session_day_number
      FROM
      touchpoint_and_converting_sessions_labelled_with_conversion_number_and_conversion_cycles ),
      /* now we calculate how many days before the next conversion each row (session) is,
      and then determine, based on a variable set in the dbt_project.yml file, whether the row (session) is within
      the regular attribution, and time decay attribution, look-back windows */ days_to_each_conversion AS (
      SELECT
      *,
      MAX(session_day_number) OVER (PARTITION BY stitched_user_id, user_conversion_cycle) - session_day_number AS days_before_conversion,
      (MAX(session_day_number) OVER (PARTITION BY stitched_user_id, user_conversion_cycle) - session_day_number )<= 30 AS is_within_attribution_lookback_window,
      (MAX(session_day_number) OVER (PARTITION BY stitched_user_id, user_conversion_cycle) - session_day_number ) <= 7 AS is_within_attribution_time_decay_days_window
      FROM
      touchpoint_and_converting_sessions_labelled_with_conversion_number_and_conversion_cycles_and_day_number ),
      /* Time-decay attribution is a multi-touch attribution model that gives some credit to all the channels that led to your customer converting,
      with that amount of credit being less (decaying) the further back in time the channel was interacted with.
      This CTE calculates the various numbers we need as inputs to the time decay calculation */ add_time_decay_score AS (
      SELECT
      *,
      IF
      (is_within_attribution_time_decay_days_window, POW(2,days_before_conversion-1)/NULLIF(7,0),NULL) AS time_decay_score,
      IF
      (conversion_session,1,POW(2, (days_before_conversion - 1))) AS weighting,
      IF
      (conversion_session,1,(COUNT(CASE
      WHEN NOT conversion_session OR TRUE THEN session_id
      END
      ) OVER (PARTITION BY stitched_user_id, DATE_TRUNC(CAST(session_start_ts AS date),DAY)))) AS sessions_within_day_to_conversion,
      IF
      (conversion_session,1,safe_divide (POW(2, (days_before_conversion - 1)),
      COUNT(CASE
      WHEN NOT conversion_session OR TRUE THEN session_id
      END
      ) OVER (PARTITION BY stitched_user_id, DATE_TRUNC(CAST(session_start_ts AS date),DAY)))) AS weighting_split_by_days_sessions
      FROM
      days_to_each_conversion ),
      /* Because time-decay attribution adjusts the attributed value of the conversion by looking at the DAYS before the conversion happened and not the rows (sessions) before the conversion,
      the time decay attribution score calculated in the CTE above will end-up assigning the value of that days attributed conversions to all of the rows (sessions) recorded for that day,
      of which there may well be more than one for each day. So we then split the value of that day's conversion across the sessions within that day, equally, so we don't end-up over-counting time decay conversions */ split_time_decay_score_across_days_sessions AS (
      SELECT
      *,
      time_decay_score/NULLIF(sessions_within_day_to_conversion,0) AS apportioned_time_decay_score
      FROM
      add_time_decay_score ),
      /* Calculate the first/last non-direct/paid sessions in each conversion cycle
      and all conversion cycles that include non-direct and paid channel sessions.
      These flags are used in the actual session attribution calculations in the next CTE */ /* "and not True" excludes the session from any attribution of the conversion.
      Option is set via the "attribution_include_conversion_session: true" variable definition in the dbt_project.yml config file.
      Default value of "true" has the effect of including the actual session that the conversion happened in within the set of sessions eligable for attribution.
      Reason for including this option is because for sessions generated by dbt (for the custom transactions and account openings that couldn't be linked to a session)
      you might want to exclude these from having conversions all or partly attributed to them as they couldn't possibly have marketing channel information recorded for them.
      However the option to exclude them (setting this variable to "false") has not been enabled, so they are included in-scope for attribution (unless subsequently it's set to "false")  */ attrib_calc_flags AS (
      SELECT
      *,
      IF
      (FIRST_VALUE(CASE
      WHEN is_within_attribution_lookback_window AND (NOT conversion_session OR TRUE) AND is_non_direct_channel = TRUE THEN session_id
      END
      IGNORE NULLS) OVER (PARTITION BY stitched_user_id, user_conversion_cycle ORDER BY session_start_ts )=session_id,TRUE,FALSE) AS is_first_non_direct_channel_in_conversion_cycle,
      IF
      (LAST_VALUE(CASE
      WHEN is_within_attribution_lookback_window AND (NOT conversion_session OR TRUE) AND is_non_direct_channel = TRUE THEN session_id
      END
      IGNORE NULLS) OVER (PARTITION BY stitched_user_id, user_conversion_cycle ORDER BY session_start_ts )=session_id,TRUE,FALSE) AS is_last_non_direct_channel_in_conversion_cycle,
      IF
      (SUM(CASE
      WHEN is_within_attribution_lookback_window AND (NOT conversion_session OR TRUE) AND is_non_direct_channel = TRUE THEN 1
      END
      ) OVER (PARTITION BY stitched_user_id, user_conversion_cycle ORDER BY session_start_ts ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)>0,TRUE,FALSE) AS is_conversion_cycle_with_non_direct,
      IF
      (FIRST_VALUE(CASE
      WHEN is_within_attribution_lookback_window AND (NOT conversion_session OR TRUE) AND is_paid_channel = TRUE THEN session_id
      END
      IGNORE NULLS) OVER (PARTITION BY stitched_user_id, user_conversion_cycle ORDER BY session_start_ts )=session_id,TRUE,FALSE) AS is_first_paid_channel_in_conversion_cycle,
      IF
      (LAST_VALUE(CASE
      WHEN is_within_attribution_lookback_window AND (NOT conversion_session OR TRUE) AND is_paid_channel = TRUE THEN session_id
      END
      IGNORE NULLS) OVER (PARTITION BY stitched_user_id, user_conversion_cycle ORDER BY session_start_ts )=session_id,TRUE,FALSE) AS is_last_paid_channel_in_conversion_cycle,
      IF
      (SUM(CASE
      WHEN is_within_attribution_lookback_window AND (NOT conversion_session OR TRUE) AND is_paid_channel = TRUE THEN 1
      END
      ) OVER (PARTITION BY stitched_user_id, user_conversion_cycle ORDER BY session_start_ts ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)>0,TRUE,FALSE) AS is_conversion_cycle_with_paid
      FROM
      split_time_decay_score_across_days_sessions ),
      session_attrib_pct AS (
      SELECT
      *,
      IF
      (conversion_session
      AND NOT TRUE,0,
      CASE
      WHEN session_id = LAST_VALUE( IF (is_within_attribution_lookback_window AND (NOT conversion_session OR TRUE),session_id,NULL) IGNORE NULLS) OVER (PARTITION BY stitched_user_id, user_conversion_cycle ORDER BY session_start_ts ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) THEN 1
      ELSE
      0
      END
      ) AS last_click_attrib_pct,
      IF
      (conversion_session
      AND NOT TRUE,0,
      CASE
      WHEN is_last_non_direct_channel_in_conversion_cycle THEN 1 -- if the session is the last qualifying session in the conversion cycle, i.e. last non-direct session, then allocate 100% of conversion to it
      WHEN
      IF
      (NOT is_conversion_cycle_with_non_direct
      AND session_id = LAST_VALUE(
      IF
      (is_within_attribution_lookback_window,session_id,NULL) IGNORE NULLS) OVER (PARTITION BY stitched_user_id, user_conversion_cycle ORDER BY session_start_ts ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),TRUE,FALSE) = TRUE THEN 1 -- else if there are no non-direct channel sessions in the conversion cycle AND this the last session in that conversion cycle, allocate 100% of the conversion to it
      ELSE
      0 -- else allocate 0%
      END
      ) AS last_non_direct_click_attrib_pct,
      IF
      (conversion_session
      AND NOT TRUE,0,
      CASE
      WHEN is_last_paid_channel_in_conversion_cycle THEN 1 -- if the session is the last qualifying session in the conversion cycle, i.e. last paid session, then allocate 100% of conversion to it
      WHEN
      IF
      (NOT is_conversion_cycle_with_paid
      AND session_id = LAST_VALUE(
      IF
      (is_within_attribution_lookback_window,session_id,NULL) IGNORE NULLS) OVER (PARTITION BY stitched_user_id, user_conversion_cycle ORDER BY session_start_ts ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),TRUE,FALSE) = TRUE THEN 1 -- else if there are no paid channel sessions in the conversion cycle AND this the last session in that conversion cycle, allocate 100% of the conversion to it
      ELSE
      0 -- else allocate 0%
      END
      ) AS last_paid_click_attrib_pct,
      IF
      (conversion_session
      AND NOT TRUE,0,
      CASE
      WHEN session_id = FIRST_VALUE( IF (is_within_attribution_lookback_window,session_id,NULL) IGNORE NULLS) OVER (PARTITION BY stitched_user_id, user_conversion_cycle ORDER BY session_start_ts ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) THEN 1
      ELSE
      0
      END
      ) AS first_click_attrib_pct,
      IF
      (conversion_session
      AND NOT TRUE,0,
      CASE
      WHEN is_first_non_direct_channel_in_conversion_cycle THEN 1 -- if the session is the first qualifying session in the conversion cycle, i.e. first non-direct session, then allocate 100% of conversion to it
      WHEN
      IF
      (NOT is_conversion_cycle_with_non_direct
      AND session_id = FIRST_VALUE(
      IF
      (is_within_attribution_lookback_window,session_id,NULL) IGNORE NULLS) OVER (PARTITION BY stitched_user_id, user_conversion_cycle ORDER BY session_start_ts ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),TRUE,FALSE) = TRUE THEN 1 -- else if there are no non-direct channel sessions in the conversion cycle AND this the first session in that conversion cycle, allocate 100% of the conversion to it
      ELSE
      0 -- else allocate 0%
      END
      ) AS first_non_direct_click_attrib_pct,
      IF
      (conversion_session
      AND NOT TRUE,0,
      CASE
      WHEN is_first_paid_channel_in_conversion_cycle THEN 1 -- if the session is the first qualifying session in the conversion cycle, i.e. first paid session, then allocate 100% of conversion to it
      WHEN
      IF
      (NOT is_conversion_cycle_with_paid
      AND session_id = FIRST_VALUE(
      IF
      (is_within_attribution_lookback_window,session_id,NULL) IGNORE NULLS) OVER (PARTITION BY stitched_user_id, user_conversion_cycle ORDER BY session_start_ts ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),TRUE,FALSE) = TRUE THEN 1 -- else if there are no paid channel sessions in the conversion cycle AND this the first session in that conversion cycle, allocate 100% of the conversion to it
      ELSE
      0 -- else allocate 0%
      END
      ) AS first_paid_click_attrib_pct,
      IF
      (conversion_session
      AND NOT TRUE,0,
      IF
      (is_within_attribution_lookback_window,(safe_divide (1,
      (COUNT(
      IF
      (is_within_attribution_lookback_window,session_id,NULL)) OVER (PARTITION BY stitched_user_id, user_conversion_cycle ORDER BY session_start_ts ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) + 0))),0) ) AS even_click_attrib_pct,
      IF
      (conversion_session
      AND NOT TRUE,0,CASE
      WHEN is_within_attribution_time_decay_days_window THEN apportioned_time_decay_score / NULLIF((SUM(apportioned_time_decay_score) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)),0)
      END
      ) AS time_decay_attrib_pct
      FROM
      attrib_calc_flags ),
      /* Now calculate the actual account opening, first order, repeat order and LTV conversion numbers based on the attribution percentages calculated for the session */ /* Max() aggregations are used to find the conversion value that each session-level percentage attribution is then applied to */ final AS (
      SELECT
      'Last Click' as model,
      (MAX(count_registration_conversions) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* last_click_attrib_pct) AS user_registration_conversions,
      (MAX(count_first_order_conversions) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* last_click_attrib_pct) as first_order_conversions,
      (MAX(count_repeat_order_conversions) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* last_click_attrib_pct) as repeat_order_conversions,
      (MAX(first_order_revenue) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* last_click_attrib_pct) as first_order_revenue,
      (MAX(repeat_order_revenue) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* last_click_attrib_pct) as repeat_order_revenue,
      stitched_user_id,
      session_start_ts,
      session_end_ts,
      session_seq,
      user_conversion_cycle,
      conversion_session as is_conversion_session,
      utm_source,
      utm_medium,
      utm_campaign,
      referrer_host,
      channel,
      city,
      continent,
      country,
      region
      FROM
      session_attrib_pct a
      UNION ALL
      SELECT
      'First Click' as model, (MAX(count_registration_conversions) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* first_click_attrib_pct) AS user_registration_conversions,
      (MAX(count_first_order_conversions) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* first_click_attrib_pct) as first_order_conversions,
      (MAX(count_repeat_order_conversions) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* first_click_attrib_pct) as repeat_order_conversions,
      (MAX(first_order_revenue) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* first_click_attrib_pct) as first_order_revenue,
      (MAX(repeat_order_revenue) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* first_click_attrib_pct) as repeat_order_revenue,
      stitched_user_id,
      session_start_ts,
      session_end_ts,
      session_seq,
      user_conversion_cycle,
      conversion_session as is_conversion_session,
      utm_source,
      utm_medium,
      utm_campaign,
      referrer_host,
      channel,
      city,
      continent,
      country,
      region
      FROM
      session_attrib_pct a
      UNION ALL
      SELECT
      'Last Non-Direct Click' as model,
      (MAX(count_registration_conversions) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* last_non_direct_click_attrib_pct) AS user_registration_conversions,
      (MAX(count_first_order_conversions) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* last_non_direct_click_attrib_pct) as first_order_conversions,
      (MAX(count_repeat_order_conversions) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* last_non_direct_click_attrib_pct) as repeat_order_conversions,
      (MAX(first_order_revenue) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* last_non_direct_click_attrib_pct) as first_order_revenue,
      (MAX(repeat_order_revenue) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* last_non_direct_click_attrib_pct) as repeat_order_revenue,
      stitched_user_id,
      session_start_ts,
      session_end_ts,
      session_seq,
      user_conversion_cycle,
      conversion_session as is_conversion_session,
      utm_source,
      utm_medium,
      utm_campaign,
      referrer_host,
      channel,
      city,
      continent,
      country,
      region
      FROM
      session_attrib_pct a
      UNION ALL
      SELECT
      'First Paid Click' as model,
      (MAX(count_registration_conversions) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* first_paid_click_attrib_pct) AS user_registration_conversions,
      (MAX(count_first_order_conversions) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* first_paid_click_attrib_pct) as first_order_conversions,
      (MAX(count_repeat_order_conversions) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* first_paid_click_attrib_pct) as repeat_order_conversions,
      (MAX(first_order_revenue) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* first_paid_click_attrib_pct) as first_order_revenue,
      (MAX(repeat_order_revenue) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* first_paid_click_attrib_pct) as repeat_order_revenue,
      stitched_user_id,
      session_start_ts,
      session_end_ts,
      session_seq,
      user_conversion_cycle,
      conversion_session as is_conversion_session,
      utm_source,
      utm_medium,
      utm_campaign,
      referrer_host,
      channel,
      city,
      continent,
      country,
      region
      FROM
      session_attrib_pct a
      UNION ALL
      SELECT
      'Last Paid Click' as model,
      (MAX(count_registration_conversions) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* last_paid_click_attrib_pct) AS user_registration_conversions,
      (MAX(count_first_order_conversions) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* last_paid_click_attrib_pct) as first_order_conversions,
      (MAX(count_repeat_order_conversions) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* last_paid_click_attrib_pct) as repeat_order_conversions,
      (MAX(first_order_revenue) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* last_paid_click_attrib_pct) as first_order_revenue,
      (MAX(repeat_order_revenue) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* last_paid_click_attrib_pct) as repeat_order_revenue,
      stitched_user_id,
      session_start_ts,
      session_end_ts,
      session_seq,
      user_conversion_cycle,
      conversion_session as is_conversion_session,
      utm_source,
      utm_medium,
      utm_campaign,
      referrer_host,
      channel,
      city,
      continent,
      country,
      region
      FROM
      session_attrib_pct a
      UNION ALL
      SELECT
      'Linear' as model, (MAX(count_registration_conversions) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* even_click_attrib_pct) AS user_registration_conversions,
      (MAX(count_first_order_conversions) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* even_click_attrib_pct) as first_order_conversions,
      (MAX(count_repeat_order_conversions) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* even_click_attrib_pct) as repeat_order_conversions,
      (MAX(first_order_revenue) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* even_click_attrib_pct) as first_order_revenue,
      (MAX(repeat_order_revenue) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* even_click_attrib_pct) as repeat_order_revenue,
      stitched_user_id,
      session_start_ts,
      session_end_ts,
      session_seq,
      user_conversion_cycle,
      conversion_session as is_conversion_session,
      utm_source,
      utm_medium,
      utm_campaign,
      referrer_host,
      channel,
      city,
      continent,
      country,
      region
      FROM
      session_attrib_pct a
      UNION ALL
      SELECT
      'Time Decay' as model,
      (MAX(count_registration_conversions) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* time_decay_attrib_pct) AS user_registration_conversions,
      (MAX(count_first_order_conversions) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* time_decay_attrib_pct) as first_order_conversions,
      (MAX(count_repeat_order_conversions) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* time_decay_attrib_pct) as repeat_order_conversions,
      (MAX(first_order_revenue) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* time_decay_attrib_pct) as first_order_revenue,
      (MAX(repeat_order_revenue) OVER (PARTITION BY stitched_user_id, user_conversion_cycle)* time_decay_attrib_pct) as repeat_order_revenue,
      stitched_user_id,
      session_start_ts,
      session_end_ts,
      session_seq,
      user_conversion_cycle,
      conversion_session as is_conversion_session,
      utm_source,
      utm_medium,
      utm_campaign,
      referrer_host,
      channel,
      city,
      continent,
      country,
      region
      FROM
      session_attrib_pct a
      ),
      pivoted as (
      SELECT
      model,
      stitched_user_id,
      session_start_ts,
      session_end_ts,
      session_seq,
      user_conversion_cycle,
      utm_source,
      utm_medium,
      utm_campaign,
      referrer_host,
      channel,
      city,
      continent,
      country,
      region,
      user_registration_conversions,
      first_order_conversions,
      repeat_order_conversions,
      first_order_revenue,
      repeat_order_revenue
      FROM
      final)
      SELECT
      *
      FROM
      pivoted
      ;;
  }

 dimension: pk {
   type: string
   hidden: yes
   primary_key: yes
   sql: concat(${model},${stitched_user_id},${session_seq}) ;;
 }


  dimension: model {
    type: string
    sql: ${TABLE}.model ;;
  }

  dimension: stitched_user_id {
    type: string
    sql: ${TABLE}.stitched_user_id ;;
  }

  dimension_group: session_start_ts {
    type: time
    sql: ${TABLE}.session_start_ts ;;
  }

  dimension_group: session_end_ts {
    type: time
    sql: ${TABLE}.session_end_ts ;;
  }

  dimension: session_seq {
    type: number
    sql: ${TABLE}.session_seq ;;
  }

  dimension: user_conversion_cycle {
    type: number
    sql: ${TABLE}.user_conversion_cycle ;;
  }

  dimension: utm_source {
    type: string
    sql: ${TABLE}.utm_source ;;
  }

  dimension: utm_medium {
    type: string
    sql: ${TABLE}.utm_medium ;;
  }

  dimension: utm_campaign {
    type: string
    sql: ${TABLE}.utm_campaign ;;
  }

  dimension: referrer_host {
    type: string
    sql: ${TABLE}.referrer_host ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: continent {
    type: string
    sql: ${TABLE}.continent ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: user_registration_conversions {
    hidden: yes
    type: number
    sql: ${TABLE}.user_registration_conversions ;;
  }

  dimension: first_order_conversions {
    hidden: yes

    type: number
    sql: ${TABLE}.first_order_conversions ;;
  }

  dimension: repeat_order_conversions {
    hidden: yes

    type: number
    sql: ${TABLE}.repeat_order_conversions ;;
  }

  dimension: first_order_revenue {
    hidden: yes

    type: number
    sql: ${TABLE}.first_order_revenue ;;
  }

  dimension: repeat_order_revenue {
    hidden: yes

    type: number
    sql: ${TABLE}.repeat_order_revenue ;;
  }

  measure: total_payment_method_added {
    type: sum
    sql: ${TABLE}.user_registration_conversions ;;
  }

  measure: total_first_order_conversions {
    type: sum
    sql: ${TABLE}.first_order_conversions ;;
  }

  measure: total_repeat_order_conversions {
    type: sum
    sql: ${TABLE}.repeat_order_conversions ;;
  }

  measure: total_first_order_revenue {
    type: number
    sql: ${TABLE}.first_order_revenue ;;
  }

  measure: total_repeat_order_revenue {
    type: sum
    sql: ${TABLE}.repeat_order_revenue ;;
  }

  set: detail {
    fields: [
      model,
      stitched_user_id,
      session_start_ts_time,
      session_end_ts_time,
      session_seq,
      user_conversion_cycle,
      utm_source,
      utm_medium,
      utm_campaign,
      referrer_host,
      channel,
      city,
      continent,
      country,
      region,
      user_registration_conversions,
      first_order_conversions,
      repeat_order_conversions,
      first_order_revenue,
      repeat_order_revenue
    ]
  }
}
