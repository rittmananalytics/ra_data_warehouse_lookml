view: campaign_explorer {
  derived_table: {
    sql: with entrance_events as (SELECT event_id as entrance_event_id, referrer_host, utm_medium, utm_source,  utm_campaign, blended_user_id, event_seq as entrance_event_seq, event_ts FROM `ra-development.analytics.web_events_fact`
      ),
      events as (select f.blended_user_id, f.event_id, event_type, event_seq,  event_details, replace(page_title, ' — Rittman Analytics','') as page_title, page_url_path, ip, time_on_page_secs, session_id
      from ra-development.analytics.web_events_fact f
      where event_type = 'Page View'),
      post_campaign_events as (
      select e.blended_user_id, e.referrer_host, e.entrance_event_id, e.entrance_event_seq, e.utm_campaign, e.event_ts, t.event_id, t.event_seq, page_title, case when page_url_path like '%blog%' then 'Blog'
              when page_url_path like '%drilltodetail%' or page_url_path like '%podcast%' then 'Podcast'
              when page_url_path = '/' or page_url_path like '%home-index%' then 'Home Page'
              else 'Marketing' end as page_category, page_url_path, ip, session_id,
             row_number() over (partition by e.entrance_event_id order by t.event_seq) as pageview_seq_num
      from entrance_events e
      join events t
      on e.blended_user_id = t.blended_user_id
      where e.blended_user_id != '*|HTML:EMAIL|*'
      and entrance_event_seq <= event_seq
      and e.utm_campaign not like '%EMAIL_CAMPAIGN%')
SELECT entrance_event_id, blended_user_id, utm_campaign, referrer_host, event_ts,
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
MAX(IF(pageview_seq_num = 1, page_category, NULL)) as page_category_1,
MAX(IF(pageview_seq_num = 2, page_category, NULL)) as page_category_2,
MAX(IF(pageview_seq_num = 3, page_category, NULL)) as page_category_3,
MAX(IF(pageview_seq_num = 4, page_category, NULL)) as page_category_4,
MAX(IF(pageview_seq_num = 5, page_category, NULL)) as page_category_5,
MAX(IF(pageview_seq_num = 6, page_category, NULL)) as page_category_6,
MAX(IF(pageview_seq_num = 7, page_category, NULL)) as page_category_7,
MAX(IF(pageview_seq_num = 8, page_category, NULL)) as page_category_8,
MAX(IF(pageview_seq_num = 9, page_category, NULL)) as page_category_9,
MAX(IF(pageview_seq_num = 10, page_category, NULL)) as page_category_10
FROM post_campaign_events
group by 1,2,3,4,5;;
  }



  dimension: blended_user_id {
    type: string
    sql: ${TABLE}.blended_user_id ;;
  }

  dimension: entrance_event_id {
    type: string
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.entrance_event_id ;;
  }

  measure: count_users {
    type: count_distinct
    sql: ${TABLE}.blended_user_id ;;
  }

  measure: count_entrances {
    type: count
  }


  dimension: utm_campaign {
    type: string
    sql: ${TABLE}.utm_campaign ;;
  }

  dimension: referrer_host {
    type: string
    sql: ${TABLE}.referrer_host ;;
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
  dimension: page_category_1 {
    type: string
    sql: ${TABLE}.page_category_1 ;;
  }

  dimension: page_category_2 {
    type: string
    sql: ${TABLE}.page_category_2 ;;
  }

  dimension: page_category_3 {
    type: string
    sql: ${TABLE}.page_category_3 ;;
  }
  dimension: page_category_4 {
    type: string
    sql: ${TABLE}.page_category_4 ;;
  }
  dimension: page_category_5 {
    type: string
    sql: ${TABLE}.page_category_5 ;;
  }
  dimension: page_category_6 {
    type: string
    sql: ${TABLE}.page_category_6 ;;
  }
  dimension: page_category_7 {
    type: string
    sql: ${TABLE}.page_category_7 ;;
  }
  dimension: page_category_8 {
    type: string
    sql: ${TABLE}.page_category_8 ;;
  }
  dimension: page_category_9 {
    type: string
    sql: ${TABLE}.page_category_9 ;;
  }
  dimension: page_category_10 {
    type: string
    sql: ${TABLE}.page_category_10 ;;
  }







}
