view: sessions_by_month {
  derived_table: {
    sql: SELECT
          (FORMAT_TIMESTAMP('%Y-%m', web_sessions_fact.session_start_ts )) AS web_sessions_fact_session_start_ts_month,
          COUNT(DISTINCT web_sessions_fact.web_sessions_pk ) AS web_sessions_fact_total_sessions
      FROM `analytics.web_sessions_fact`
           AS web_sessions_fact
      WHERE ((( web_sessions_fact.session_start_ts  ) >= ((TIMESTAMP(DATETIME_ADD(DATETIME(TIMESTAMP_TRUNC(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), MONTH)), INTERVAL -11 MONTH)))) AND ( web_sessions_fact.session_start_ts  ) < ((TIMESTAMP(DATETIME_ADD(DATETIME(TIMESTAMP(DATETIME_ADD(DATETIME(TIMESTAMP_TRUNC(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), MONTH)), INTERVAL -11 MONTH))), INTERVAL 12 MONTH))))))
      GROUP BY
          1
      ORDER BY
          1 DESC
      LIMIT 500 ;;
  }

  dimension: web_sessions_fact_session_start_ts_month {
    type: string
    label: "web_sessions_fact_session_start_ts_month"
    sql: ${TABLE}.web_sessions_fact_session_start_ts_month ;;
  }

  dimension: web_sessions_fact_total_sessions {
    type: number
    label: "web_sessions_fact_total_sessions"
    sql: ${TABLE}.web_sessions_fact_total_sessions ;;
  }
}
