view: is_conversion_session {
  derived_table: {
    sql: SELECT
          web_events_fact.session_id  AS web_events_fact_session_id,
          COUNT(DISTINCT CASE WHEN ( lower(web_events_fact.event_type) like '%meeting%' ) THEN web_events_fact.web_event_pk  ELSE NULL END)>0 AS is_conversion_session,
          COUNT(DISTINCT CASE WHEN ( lower(web_events_fact.event_type) like '%cta%' ) THEN web_events_fact.web_event_pk  ELSE NULL END)>0 AS is_goal_achieved_session,
      FROM `analytics.web_events_fact`
           AS web_events_fact
      GROUP BY
          1
       ;;
  }



  dimension: web_events_fact_session_id {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.web_events_fact_session_id ;;
  }

  dimension: is_conversion_session {
    group_label: "Behavior"
    hidden: yes
    type: yesno
    sql: ${TABLE}.is_conversion_session ;;
  }

  dimension: is_goal_achieved_session {
    group_label: "Behavior"
    hidden: yes

    type: yesno
    sql: ${TABLE}.is_conversion_session ;;
  }


}
