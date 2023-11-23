
view: page_first_published {
  derived_table: {
    sql: SELECT
          web_sessions_fact.first_page_title  AS web_sessions_fact_first_page_title,
              (MIN(web_sessions_fact.session_start_ts )) AS page_first_session_start_ts
      FROM `analytics.web_sessions_fact`
           AS web_sessions_fact
      GROUP BY
          1 ;;
  }



  dimension: web_sessions_fact_first_page_title {
    primary_key:yes
    type: string
    sql: ${TABLE}.web_sessions_fact_first_page_title ;;
  }

  dimension_group: page_first_session_start_ts {
    type: time
    timeframes: [
      raw,
      time,
      hour4,
      day_of_week,
      date,
      day_of_year,
      week,
      month,
      month_num,
      week_of_year,
      year
    ]
    sql: ${TABLE}.page_first_session_start_ts ;;
  }



}
