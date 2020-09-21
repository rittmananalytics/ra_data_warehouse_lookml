view: campaign_explorer {
  derived_table: {
    sql: with entrance_events as (SELECT event_id as entrance_event_id, utm_medium, utm_source,  utm_campaign, blended_user_id, event_seq as entrance_event_seq, event_ts FROM `ra-development.analytics.web_events_fact`
      where utm_medium is not null),
      events as (select f.blended_user_id, f.event_id, event_type, event_seq,  event_details, page_title, page_url_path, ip, time_on_page_secs, session_id
      from ra-development.analytics.web_events_fact f
      where event_type = 'Page View'),
      post_campaign_events as (
      select e.blended_user_id, e.entrance_event_id, e.entrance_event_seq, e.utm_campaign, e.event_ts, t.event_id, t.event_seq, page_title, page_url_path, ip, session_id,
             row_number() over (partition by e.entrance_event_id order by t.event_seq) as pageview_seq_num
      from entrance_events e
      join events t
      on e.blended_user_id = t.blended_user_id
      where e.blended_user_id != '*|HTML:EMAIL|*'
      and entrance_event_seq <= event_seq)
SELECT blended_user_id, utm_campaign, event_ts,
MAX(IF(pageview_seq_num = 1, page_title, NULL)) as pageview_1,
MAX(IF(pageview_seq_num = 2, page_title, NULL)) as pageview_2,
MAX(IF(pageview_seq_num = 3, page_title, NULL)) as pageview_3,
MAX(IF(pageview_seq_num = 4, page_title, NULL)) as pageview_4,
MAX(IF(pageview_seq_num = 5, page_title, NULL)) as pageview_5,
MAX(IF(pageview_seq_num = 6, page_title, NULL)) as pageview_6,
MAX(IF(pageview_seq_num = 7, page_title, NULL)) as pageview_7,
MAX(IF(pageview_seq_num = 8, page_title, NULL)) as pageview_8,
MAX(IF(pageview_seq_num = 9, page_title, NULL)) as pageview_9,
MAX(IF(pageview_seq_num = 10, page_title, NULL)) as pageview_10,
MAX(IF(pageview_seq_num = 11, page_title, NULL)) as pageview_11,
MAX(IF(pageview_seq_num = 12, page_title, NULL)) as pageview_12,
MAX(IF(pageview_seq_num = 13, page_title, NULL)) as pageview_13,
MAX(IF(pageview_seq_num = 14, page_title, NULL)) as pageview_14,
MAX(IF(pageview_seq_num = 15, page_title, NULL)) as pageview_15,
MAX(IF(pageview_seq_num = 16, page_title, NULL)) as pageview_16,
MAX(IF(pageview_seq_num = 17, page_title, NULL)) as pageview_17,
MAX(IF(pageview_seq_num = 18, page_title, NULL)) as pageview_19,
MAX(IF(pageview_seq_num = 20, session_id, NULL)) as pageview_20
FROM post_campaign_events
group by 1,2,3;;
  }



  dimension: blended_user_id {
    type: string
    sql: ${TABLE}.blended_user_id ;;
  }



  dimension: utm_campaign {
    type: string
    sql: ${TABLE}.utm_campaign ;;
  }

  dimension_group: event_ts {
    type: time
    timeframes: [date,
                 week,
                 month]
    sql: ${TABLE}.event_ts ;;
  }





  dimension: pageview_1 {
    type: string
    sql: ${TABLE}.pageview_1 ;;
  }

  dimension: pageview_2 {
    type: string
    sql: ${TABLE}.pageview_2 ;;
  }

  dimension: pageview_3 {
    type: string
    sql: ${TABLE}.pageview_3 ;;
  }
  dimension: pageview_4 {
    type: string
    sql: ${TABLE}.pageview_4 ;;
  }
  dimension: pageview_5 {
    type: string
    sql: ${TABLE}.pageview_5 ;;
  }
  dimension: pageview_6 {
    type: string
    sql: ${TABLE}.pageview_6 ;;
  }
  dimension: pageview_7 {
    type: string
    sql: ${TABLE}.pageview_7 ;;
  }
  dimension: pageview_8 {
    type: string
    sql: ${TABLE}.pageview_8 ;;
  }
  dimension: pageview_9 {
    type: string
    sql: ${TABLE}.pageview_9 ;;
  }
  dimension: pageview_10 {
    type: string
    sql: ${TABLE}.pageview_10 ;;
  }
  dimension: pageview_11 {
    type: string
    sql: ${TABLE}.pageview_11 ;;
  }
  dimension: pageview_12 {
    type: string
    sql: ${TABLE}.pageview_12 ;;
  }
  dimension: pageview_13 {
    type: string
    sql: ${TABLE}.pageview_13 ;;
  }
  dimension: pageview_14 {
    type: string
    sql: ${TABLE}.pageview_14 ;;
  }
  dimension: pageview_15 {
    type: string
    sql: ${TABLE}.pageview_15 ;;
  }






}
