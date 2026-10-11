view: has_viewed_pricing {
  derived_table: {
    sql: SELECT
                web_sessions_fact.blended_user_id  AS web_sessions_fact_blended_user_id
            FROM `analytics.web_sessions_fact`
                 AS web_sessions_fact
            LEFT JOIN `analytics.web_events_fact`
                 AS web_events_fact ON web_sessions_fact.session_id = web_events_fact.session_id
            WHERE (web_events_fact.page_url_path ) LIKE '%/about/pricing%'
            GROUP BY
                1
            ORDER BY
                1
            LIMIT 500 ;;
  }

  dimension: user_has_viewed_pricing {
    group_label: "Audience"
    sql: true ;;
  }

  dimension: web_sessions_fact_blended_user_id {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.web_sessions_fact_blended_user_id ;;
  }

  measure: count {
    type: count
  }
}
