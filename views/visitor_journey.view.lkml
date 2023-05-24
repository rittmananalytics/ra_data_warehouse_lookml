view: visitor_journey {
  derived_table: {
    persist_for: "4 hours"
    sql: with sessions as (SELECT
          web_sessions_fact.web_sessions_pk,
          row_number() over (partition by web_sessions_fact.web_sessions_pk order by event_ts) event_seq,
          web_events_fact.event_type  AS event_type,
          case when ${event_type} = 'Page View' or ${event_type} = "Meeting Booked" then
              case when ${TABLE}.page_url_path like '%blog%' or ${TABLE}.page_url_path like '%rittmananalytics.com/202%' then '01: Blog'
                  when ${TABLE}.page_url_path like '%drilltodetail%' or ${TABLE}.page_url_path like '%podcast%' then '01: Podcast'
                  when ${TABLE}.page_url_path = '/' or ${TABLE}.page_url_path like '%home-index%' then '01: Home Page'
                  when ${TABLE}.page_url_path like '%/services/%' or ${TABLE}.page_url_path like '%/offers/%' then '04: Service'
                  when ${TABLE}.page_url_path like '%/about/%' or ${TABLE}.page_url_path like '%/contact%' or ${TABLE}.page_url_path like '%/faqs/%' or ${TABLE}.page_url_path like '%scv-contact-us-form%' then '08: Contact'
                  when ${TABLE}.page_url_path like '%sidebar%' then 'Misc'
                  when ${TABLE}.page_url_path like '%/assistant%' then '06: Assistant'
                  when ${TABLE}.page_url_path like '%/pricing%' or ${TABLE}.page_url_path like '%/engagement-model%' or ${TABLE}.page_url_path like '%/how-we-work%' then '12: Commercials'
                  when ${TABLE}.page_url_path like '%scv-thank-you%' or ${TABLE}.page_url_path like '%/modern-data-stack-thank-you%' then '08: Goal Achieved'
                  when ${TABLE}.page_url_path like '%causal-analytics%' or ${TABLE}.page_url_path like '/scv-download-hubspot-form' then '02: Landing Page'
                  when ${TABLE}.page_url_path like '%causal-analytics-video%' or ${TABLE}.page_url_path like '%download-10-ways-your-modern-data-stack-can-fail%' or ${TABLE}.page_url_path like '%download-page%' then '04: Gated Content'
                  when ${TABLE}.page_url_path like '%case-studies%' or ${TABLE}.page_url_path like '%industries%' or ${TABLE}.page_url_path like '%about%' or ${TABLE}.page_url_path like '%partners%'then '02: Marketing'
                  when ${event_type} = "Meeting Booked" then '16: Conversion'
              end
         end AS page_category,

      web_events_fact.page_title  AS page_title,
      web_events_fact.event_details  AS event_details,
      web_events_fact.event_ts AS event_ts,





      (case when ${event_type} = 'Page View' or ${event_type} = "Meeting Booked" then
              case when ${TABLE}.page_url_path like '%blog%' or ${TABLE}.page_url_path like '%rittmananalytics.com/202%' then '01: Blog'
                  when ${TABLE}.page_url_path like '%drilltodetail%' or ${TABLE}.page_url_path like '%podcast%' then '01: Podcast'
                  when ${TABLE}.page_url_path = '/' or ${TABLE}.page_url_path like '%home-index%' then '01: Home Page'
                  when ${TABLE}.page_url_path like '%/services/%' or ${TABLE}.page_url_path like '%/offers/%' then '04: Service'
                  when ${TABLE}.page_url_path like '%/about/%' or ${TABLE}.page_url_path like '%/contact%' or ${TABLE}.page_url_path like '%/faqs/%' or ${TABLE}.page_url_path like '%scv-contact-us-form%' then '08: Contact'
                  when ${TABLE}.page_url_path like '%sidebar%' then 'Misc'
                  when ${TABLE}.page_url_path like '%/assistant%' then '06: Assistant'
                  when ${TABLE}.page_url_path like '%/pricing%' or ${TABLE}.page_url_path like '%/engagement-model%' or ${TABLE}.page_url_path like '%/how-we-work%' then '12: Commercials'
                  when ${TABLE}.page_url_path like '%scv-thank-you%' or ${TABLE}.page_url_path like '%/modern-data-stack-thank-you%' then '08: Goal Achieved'
                  when ${TABLE}.page_url_path like '%causal-analytics%' or ${TABLE}.page_url_path like '/scv-download-hubspot-form' then '02: Landing Page'
                  when ${TABLE}.page_url_path like '%causal-analytics-video%' or ${TABLE}.page_url_path like '%download-10-ways-your-modern-data-stack-can-fail%' or ${TABLE}.page_url_path like '%download-page%' then '04: Gated Content'
                  when ${TABLE}.page_url_path like '%case-studies%' or ${TABLE}.page_url_path like '%industries%' or ${TABLE}.page_url_path like '%about%' or ${TABLE}.page_url_path like '%partners%'then '02: Marketing'
                  when ${event_type} = "Meeting Booked" then '16: Conversion'
              end
         end) in ("1: Blog","1: Podcast") then 1
      when (case when ${event_type} = 'Page View' or ${event_type} = "Meeting Booked" then
              case when ${TABLE}.page_url_path like '%blog%' or ${TABLE}.page_url_path like '%rittmananalytics.com/202%' then '01: Blog'
                  when ${TABLE}.page_url_path like '%drilltodetail%' or ${TABLE}.page_url_path like '%podcast%' then '01: Podcast'
                  when ${TABLE}.page_url_path = '/' or ${TABLE}.page_url_path like '%home-index%' then '01: Home Page'
                  when ${TABLE}.page_url_path like '%/services/%' or ${TABLE}.page_url_path like '%/offers/%' then '04: Service'
                  when ${TABLE}.page_url_path like '%/about/%' or ${TABLE}.page_url_path like '%/contact%' or ${TABLE}.page_url_path like '%/faqs/%' or ${TABLE}.page_url_path like '%scv-contact-us-form%' then '08: Contact'
                  when ${TABLE}.page_url_path like '%sidebar%' then 'Misc'
                  when ${TABLE}.page_url_path like '%/assistant%' then '06: Assistant'
                  when ${TABLE}.page_url_path like '%/pricing%' or ${TABLE}.page_url_path like '%/engagement-model%' or ${TABLE}.page_url_path like '%/how-we-work%' then '12: Commercials'
                  when ${TABLE}.page_url_path like '%scv-thank-you%' or ${TABLE}.page_url_path like '%/modern-data-stack-thank-you%' then '08: Goal Achieved'
                  when ${TABLE}.page_url_path like '%causal-analytics%' or ${TABLE}.page_url_path like '/scv-download-hubspot-form' then '02: Landing Page'
                  when ${TABLE}.page_url_path like '%causal-analytics-video%' or ${TABLE}.page_url_path like '%download-10-ways-your-modern-data-stack-can-fail%' or ${TABLE}.page_url_path like '%download-page%' then '04: Gated Content'
                  when ${TABLE}.page_url_path like '%case-studies%' or ${TABLE}.page_url_path like '%industries%' or ${TABLE}.page_url_path like '%about%' or ${TABLE}.page_url_path like '%partners%'then '02: Marketing'
                  when ${event_type} = "Meeting Booked" then '16: Conversion'
              end
         end) = "1: Home Page" then 1
      when (case when ${event_type} = 'Page View' or ${event_type} = "Meeting Booked" then
              case when ${TABLE}.page_url_path like '%blog%' or ${TABLE}.page_url_path like '%rittmananalytics.com/202%' then '01: Blog'
                  when ${TABLE}.page_url_path like '%drilltodetail%' or ${TABLE}.page_url_path like '%podcast%' then '01: Podcast'
                  when ${TABLE}.page_url_path = '/' or ${TABLE}.page_url_path like '%home-index%' then '01: Home Page'
                  when ${TABLE}.page_url_path like '%/services/%' or ${TABLE}.page_url_path like '%/offers/%' then '04: Service'
                  when ${TABLE}.page_url_path like '%/about/%' or ${TABLE}.page_url_path like '%/contact%' or ${TABLE}.page_url_path like '%/faqs/%' or ${TABLE}.page_url_path like '%scv-contact-us-form%' then '08: Contact'
                  when ${TABLE}.page_url_path like '%sidebar%' then 'Misc'
                  when ${TABLE}.page_url_path like '%/assistant%' then '06: Assistant'
                  when ${TABLE}.page_url_path like '%/pricing%' or ${TABLE}.page_url_path like '%/engagement-model%' or ${TABLE}.page_url_path like '%/how-we-work%' then '12: Commercials'
                  when ${TABLE}.page_url_path like '%scv-thank-you%' or ${TABLE}.page_url_path like '%/modern-data-stack-thank-you%' then '08: Goal Achieved'
                  when ${TABLE}.page_url_path like '%causal-analytics%' or ${TABLE}.page_url_path like '/scv-download-hubspot-form' then '02: Landing Page'
                  when ${TABLE}.page_url_path like '%causal-analytics-video%' or ${TABLE}.page_url_path like '%download-10-ways-your-modern-data-stack-can-fail%' or ${TABLE}.page_url_path like '%download-page%' then '04: Gated Content'
                  when ${TABLE}.page_url_path like '%case-studies%' or ${TABLE}.page_url_path like '%industries%' or ${TABLE}.page_url_path like '%about%' or ${TABLE}.page_url_path like '%partners%'then '02: Marketing'
                  when ${event_type} = "Meeting Booked" then '16: Conversion'
              end
         end) in ("2: Marketing","2: Landing Page") then 2
      when (case when ${event_type} = 'Page View' or ${event_type} = "Meeting Booked" then
              case when ${TABLE}.page_url_path like '%blog%' or ${TABLE}.page_url_path like '%rittmananalytics.com/202%' then '01: Blog'
                  when ${TABLE}.page_url_path like '%drilltodetail%' or ${TABLE}.page_url_path like '%podcast%' then '01: Podcast'
                  when ${TABLE}.page_url_path = '/' or ${TABLE}.page_url_path like '%home-index%' then '01: Home Page'
                  when ${TABLE}.page_url_path like '%/services/%' or ${TABLE}.page_url_path like '%/offers/%' then '04: Service'
                  when ${TABLE}.page_url_path like '%/about/%' or ${TABLE}.page_url_path like '%/contact%' or ${TABLE}.page_url_path like '%/faqs/%' or ${TABLE}.page_url_path like '%scv-contact-us-form%' then '08: Contact'
                  when ${TABLE}.page_url_path like '%sidebar%' then 'Misc'
                  when ${TABLE}.page_url_path like '%/assistant%' then '06: Assistant'
                  when ${TABLE}.page_url_path like '%/pricing%' or ${TABLE}.page_url_path like '%/engagement-model%' or ${TABLE}.page_url_path like '%/how-we-work%' then '12: Commercials'
                  when ${TABLE}.page_url_path like '%scv-thank-you%' or ${TABLE}.page_url_path like '%/modern-data-stack-thank-you%' then '08: Goal Achieved'
                  when ${TABLE}.page_url_path like '%causal-analytics%' or ${TABLE}.page_url_path like '/scv-download-hubspot-form' then '02: Landing Page'
                  when ${TABLE}.page_url_path like '%causal-analytics-video%' or ${TABLE}.page_url_path like '%download-10-ways-your-modern-data-stack-can-fail%' or ${TABLE}.page_url_path like '%download-page%' then '04: Gated Content'
                  when ${TABLE}.page_url_path like '%case-studies%' or ${TABLE}.page_url_path like '%industries%' or ${TABLE}.page_url_path like '%about%' or ${TABLE}.page_url_path like '%partners%'then '02: Marketing'
                  when ${event_type} = "Meeting Booked" then '16: Conversion'
              end
         end) in ("4: Service","4: Gated Content") then 4
      when (case when ${event_type} = 'Page View' or ${event_type} = "Meeting Booked" then
              case when ${TABLE}.page_url_path like '%blog%' or ${TABLE}.page_url_path like '%rittmananalytics.com/202%' then '01: Blog'
                  when ${TABLE}.page_url_path like '%drilltodetail%' or ${TABLE}.page_url_path like '%podcast%' then '01: Podcast'
                  when ${TABLE}.page_url_path = '/' or ${TABLE}.page_url_path like '%home-index%' then '01: Home Page'
                  when ${TABLE}.page_url_path like '%/services/%' or ${TABLE}.page_url_path like '%/offers/%' then '04: Service'
                  when ${TABLE}.page_url_path like '%/about/%' or ${TABLE}.page_url_path like '%/contact%' or ${TABLE}.page_url_path like '%/faqs/%' or ${TABLE}.page_url_path like '%scv-contact-us-form%' then '08: Contact'
                  when ${TABLE}.page_url_path like '%sidebar%' then 'Misc'
                  when ${TABLE}.page_url_path like '%/assistant%' then '06: Assistant'
                  when ${TABLE}.page_url_path like '%/pricing%' or ${TABLE}.page_url_path like '%/engagement-model%' or ${TABLE}.page_url_path like '%/how-we-work%' then '12: Commercials'
                  when ${TABLE}.page_url_path like '%scv-thank-you%' or ${TABLE}.page_url_path like '%/modern-data-stack-thank-you%' then '08: Goal Achieved'
                  when ${TABLE}.page_url_path like '%causal-analytics%' or ${TABLE}.page_url_path like '/scv-download-hubspot-form' then '02: Landing Page'
                  when ${TABLE}.page_url_path like '%causal-analytics-video%' or ${TABLE}.page_url_path like '%download-10-ways-your-modern-data-stack-can-fail%' or ${TABLE}.page_url_path like '%download-page%' then '04: Gated Content'
                  when ${TABLE}.page_url_path like '%case-studies%' or ${TABLE}.page_url_path like '%industries%' or ${TABLE}.page_url_path like '%about%' or ${TABLE}.page_url_path like '%partners%'then '02: Marketing'
                  when ${event_type} = "Meeting Booked" then '16: Conversion'
              end
         end) = "8: Contact" then 8
      when web_events_fact.is_goal_achieved_event or (case when ${event_type} = 'Page View' or ${event_type} = "Meeting Booked" then
              case when ${TABLE}.page_url_path like '%blog%' or ${TABLE}.page_url_path like '%rittmananalytics.com/202%' then '01: Blog'
                  when ${TABLE}.page_url_path like '%drilltodetail%' or ${TABLE}.page_url_path like '%podcast%' then '01: Podcast'
                  when ${TABLE}.page_url_path = '/' or ${TABLE}.page_url_path like '%home-index%' then '01: Home Page'
                  when ${TABLE}.page_url_path like '%/services/%' or ${TABLE}.page_url_path like '%/offers/%' then '04: Service'
                  when ${TABLE}.page_url_path like '%/about/%' or ${TABLE}.page_url_path like '%/contact%' or ${TABLE}.page_url_path like '%/faqs/%' or ${TABLE}.page_url_path like '%scv-contact-us-form%' then '08: Contact'
                  when ${TABLE}.page_url_path like '%sidebar%' then 'Misc'
                  when ${TABLE}.page_url_path like '%/assistant%' then '06: Assistant'
                  when ${TABLE}.page_url_path like '%/pricing%' or ${TABLE}.page_url_path like '%/engagement-model%' or ${TABLE}.page_url_path like '%/how-we-work%' then '12: Commercials'
                  when ${TABLE}.page_url_path like '%scv-thank-you%' or ${TABLE}.page_url_path like '%/modern-data-stack-thank-you%' then '08: Goal Achieved'
                  when ${TABLE}.page_url_path like '%causal-analytics%' or ${TABLE}.page_url_path like '/scv-download-hubspot-form' then '02: Landing Page'
                  when ${TABLE}.page_url_path like '%causal-analytics-video%' or ${TABLE}.page_url_path like '%download-10-ways-your-modern-data-stack-can-fail%' or ${TABLE}.page_url_path like '%download-page%' then '04: Gated Content'
                  when ${TABLE}.page_url_path like '%case-studies%' or ${TABLE}.page_url_path like '%industries%' or ${TABLE}.page_url_path like '%about%' or ${TABLE}.page_url_path like '%partners%'then '02: Marketing'
                  when ${event_type} = "Meeting Booked" then '16: Conversion'
              end
         end) = "8: Goal Achieved" then 8
      when web_events_fact.is_conversion_event then 16 end) AS event_visit_value
      FROM `analytics.web_sessions_fact`
      AS web_sessions_fact
      LEFT JOIN `analytics.web_events_fact`
      AS web_events_fact ON web_sessions_fact.session_id = web_events_fact.session_id
      WHERE lower(web_events_fact.event_type) not like '%link%'
      )
      select
      web_sessions_pk,
      max(if(event_seq = 1,event_type,null)) as event_type_1,
      max(if(event_seq = 2,event_type,null)) as event_type_2,
      max(if(event_seq = 3,event_type,null)) as event_type_3,
      max(if(event_seq = 4,event_type,null)) as event_type_4,
      max(if(event_seq = 5,event_type,null)) as event_type_5,
      max(if(event_seq = 6,event_type,null)) as event_type_6,
      max(if(event_seq = 7,event_type,null)) as event_type_7,
      max(if(event_seq = 8,event_type,null)) as event_type_8,
      max(if(event_seq = 9,event_type,null)) as event_type_9,
      max(if(event_seq = 10,event_type,null)) as event_type_10,
      max(if(event_seq = 1,event_details,null)) as event_details_1,
      max(if(event_seq = 2,event_details,null)) as event_details_2,
      max(if(event_seq = 3,event_details,null)) as event_details_3,
      max(if(event_seq = 4,event_details,null)) as event_details_4,
      max(if(event_seq = 5,event_details,null)) as event_details_5,
      max(if(event_seq = 6,event_details,null)) as event_details_6,
      max(if(event_seq = 7,event_details,null)) as event_details_7,
      max(if(event_seq = 8,event_details,null)) as event_details_8,
      max(if(event_seq = 9,event_details,null)) as event_details_9,
      max(if(event_seq = 10,event_details,null)) as event_details_10,
      max(if(event_seq = 1,page_title,null)) as page_title_1,
      max(if(event_seq = 2,page_title,null)) as page_title_2,
      max(if(event_seq = 3,page_title,null)) as page_title_3,
      max(if(event_seq = 4,page_title,null)) as page_title_4,
      max(if(event_seq = 5,page_title,null)) as page_title_5,
      max(if(event_seq = 6,page_title,null)) as page_title_6,
      max(if(event_seq = 7,page_title,null)) as page_title_7,
      max(if(event_seq = 8,page_title,null)) as page_title_8,
      max(if(event_seq = 9,page_title,null)) as page_title_9,
      max(if(event_seq = 10,page_title,null)) as page_title_10,
      max(if(event_seq = 1,page_category,null)) as page_category_1,
      max(if(event_seq = 2,page_category,null)) as page_category_2,
      max(if(event_seq = 3,page_category,null)) as page_category_3,
      max(if(event_seq = 4,page_category,null)) as page_category_4,
      max(if(event_seq = 5,page_category,null)) as page_category_5,
      max(if(event_seq = 6,page_category,null)) as page_category_6,
      max(if(event_seq = 7,page_category,null)) as page_category_7,
      max(if(event_seq = 8,page_category,null)) as page_category_8,
      max(if(event_seq = 9,page_category,null)) as page_category_9,
      max(if(event_seq = 10,page_category,null)) as page_category_10,
      max(if(event_seq = 1,event_visit_value,null)) as event_visit_value_1,
      max(if(event_seq = 2,event_visit_value,null)) as event_visit_value_2,
      max(if(event_seq = 3,event_visit_value,null)) as event_visit_value_3,
      max(if(event_seq = 4,event_visit_value,null)) as event_visit_value_4,
      max(if(event_seq = 5,event_visit_value,null)) as event_visit_value_5,
      max(if(event_seq = 6,event_visit_value,null)) as event_visit_value_6,
      max(if(event_seq = 7,event_visit_value,null)) as event_visit_value_7,
      max(if(event_seq = 8,event_visit_value,null)) as event_visit_value_8,
      max(if(event_seq = 9,event_visit_value,null)) as event_visit_value_9,
      max(if(event_seq = 10,event_visit_value,null)) as event_visit_value_10,
      max(if(event_seq = 11,event_type,null)) as event_type_11,
      max(if(event_seq = 12,event_type,null)) as event_type_12,
      max(if(event_seq = 13,event_type,null)) as event_type_13,
      max(if(event_seq = 14,event_type,null)) as event_type_14,
      max(if(event_seq = 15,event_type,null)) as event_type_15,
      max(if(event_seq = 16,event_type,null)) as event_type_16,
      max(if(event_seq = 17,event_type,null)) as event_type_17,
      max(if(event_seq = 18,event_type,null)) as event_type_18,
      max(if(event_seq = 19,event_type,null)) as event_type_19,
      max(if(event_seq = 20,event_type,null)) as event_type_20,
      max(if(event_seq = 11,event_details,null)) as event_details_11,
      max(if(event_seq = 12,event_details,null)) as event_details_12,
      max(if(event_seq = 13,event_details,null)) as event_details_13,
      max(if(event_seq = 14,event_details,null)) as event_details_14,
      max(if(event_seq = 15,event_details,null)) as event_details_15,
      max(if(event_seq = 16,event_details,null)) as event_details_16,
      max(if(event_seq = 17,event_details,null)) as event_details_17,
      max(if(event_seq = 18,event_details,null)) as event_details_18,
      max(if(event_seq = 19,event_details,null)) as event_details_19,
      max(if(event_seq = 20,event_details,null)) as event_details_20,
      max(if(event_seq = 11,page_title,null)) as page_title_11,
      max(if(event_seq = 12,page_title,null)) as page_title_12,
      max(if(event_seq = 13,page_title,null)) as page_title_13,
      max(if(event_seq = 14,page_title,null)) as page_title_14,
      max(if(event_seq = 15,page_title,null)) as page_title_15,
      max(if(event_seq = 16,page_title,null)) as page_title_16,
      max(if(event_seq = 17,page_title,null)) as page_title_17,
      max(if(event_seq = 18,page_title,null)) as page_title_18,
      max(if(event_seq = 19,page_title,null)) as page_title_19,
      max(if(event_seq = 20,page_title,null)) as page_title_20,
      max(if(event_seq = 11,page_category,null)) as page_category_11,
      max(if(event_seq = 12,page_category,null)) as page_category_12,
      max(if(event_seq = 13,page_category,null)) as page_category_13,
      max(if(event_seq = 14,page_category,null)) as page_category_14,
      max(if(event_seq = 15,page_category,null)) as page_category_15,
      max(if(event_seq = 16,page_category,null)) as page_category_16,
      max(if(event_seq = 17,page_category,null)) as page_category_17,
      max(if(event_seq = 18,page_category,null)) as page_category_18,
      max(if(event_seq = 19,page_category,null)) as page_category_19,
      max(if(event_seq = 20,page_category,null)) as page_category_20,
      max(if(event_seq = 11,event_visit_value,null)) as event_visit_value_11,
      max(if(event_seq = 12,event_visit_value,null)) as event_visit_value_12,
      max(if(event_seq = 13,event_visit_value,null)) as event_visit_value_13,
      max(if(event_seq = 14,event_visit_value,null)) as event_visit_value_14,
      max(if(event_seq = 15,event_visit_value,null)) as event_visit_value_15,
      max(if(event_seq = 16,event_visit_value,null)) as event_visit_value_16,
      max(if(event_seq = 17,event_visit_value,null)) as event_visit_value_17,
      max(if(event_seq = 18,event_visit_value,null)) as event_visit_value_18,
      max(if(event_seq = 19,event_visit_value,null)) as event_visit_value_19,
      max(if(event_seq = 20,event_visit_value,null)) as event_visit_value_20,
      max(if(event_seq = 1,event_ts,null)) as event_ts_1,
      max(if(event_seq = 2,event_ts,null)) as event_ts_2,
      max(if(event_seq = 3,event_ts,null)) as event_ts_3,
      max(if(event_seq = 4,event_ts,null)) as event_ts_4,
      max(if(event_seq = 5,event_ts,null)) as event_ts_5,
      max(if(event_seq = 6,event_ts,null)) as event_ts_6,
      max(if(event_seq = 7,event_ts,null)) as event_ts_7,
      max(if(event_seq = 8,event_ts,null)) as event_ts_8,
      max(if(event_seq = 9,event_ts,null)) as event_ts_9,
      max(if(event_seq = 10,event_ts,null)) as event_ts_10,
      max(if(event_seq = 11,event_ts,null)) as event_ts_11,
      max(if(event_seq = 12,event_ts,null)) as event_ts_12,
      max(if(event_seq = 13,event_ts,null)) as event_ts_13,
      max(if(event_seq = 14,event_ts,null)) as event_ts_14,
      max(if(event_seq = 15,event_ts,null)) as event_ts_15,
      max(if(event_seq = 16,event_ts,null)) as event_ts_16,
      max(if(event_seq = 17,event_ts,null)) as event_ts_17,
      max(if(event_seq = 18,event_ts,null)) as event_ts_18,
      max(if(event_seq = 19,event_ts,null)) as event_ts_19,
      max(if(event_seq = 20,event_ts,null)) as event_ts_20
      from sessions ss
      group by 1
      ;;
  }



  dimension: web_sessions_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.web_sessions_pk ;;
  }

  dimension: event_type_1 {
    group_label: "Event Type"
    type: string
    sql: ${TABLE}.event_type_1 ;;
  }

  dimension: event_type_2 {
    group_label: "Event Type"

    type: string
    sql: ${TABLE}.event_type_2 ;;
  }

  dimension: event_type_3 {
    group_label: "Event Type"

    type: string
    sql: ${TABLE}.event_type_3 ;;
  }

  dimension: event_type_4 {
    group_label: "Event Type"

    type: string
    sql: ${TABLE}.event_type_4 ;;
  }

  dimension: event_type_5 {
    group_label: "Event Type"

    type: string
    sql: ${TABLE}.event_type_5 ;;
  }

  dimension: event_type_6 {
    group_label: "Event Type"

    type: string
    sql: ${TABLE}.event_type_6 ;;
  }

  dimension: event_type_7 {
    group_label: "Event Type"

    type: string
    sql: ${TABLE}.event_type_7 ;;
  }

  dimension: event_type_8 {
    group_label: "Event Type"

    type: string
    sql: ${TABLE}.event_type_8 ;;
  }

  dimension: event_type_9 {
    group_label: "Event Type"

    type: string
    sql: ${TABLE}.event_type_9 ;;
  }

  dimension: event_type_10 {
    group_label: "Event Type"

    type: string
    sql: ${TABLE}.event_type_10 ;;
  }

  dimension: event_details_1 {
    group_label: "Event Details"

    type: string
    sql: ${TABLE}.event_details_1 ;;
  }

  dimension: event_details_2 {
    group_label: "Event Details"

    type: string
    sql: ${TABLE}.event_details_2 ;;
  }

  dimension: event_details_3 {
    group_label: "Event Details"

    type: string
    sql: ${TABLE}.event_details_3 ;;
  }

  dimension: event_details_4 {
    group_label: "Event Details"

    type: string
    sql: ${TABLE}.event_details_4 ;;
  }

  dimension: event_details_5 {
    group_label: "Event Details"

    type: string
    sql: ${TABLE}.event_details_5 ;;
  }

  dimension: event_details_6 {
    group_label: "Event Details"

    type: string
    sql: ${TABLE}.event_details_6 ;;
  }

  dimension: event_details_7 {
    group_label: "Event Details"

    type: string
    sql: ${TABLE}.event_details_7 ;;
  }

  dimension: event_details_8 {
    group_label: "Event Details"

    type: string
    sql: ${TABLE}.event_details_8 ;;
  }

  dimension: event_details_9 {
    group_label: "Event Details"

    type: string
    sql: ${TABLE}.event_details_9 ;;
  }

  dimension: event_details_10 {
    group_label: "Event Details"

    type: string
    sql: ${TABLE}.event_details_10 ;;
  }

  dimension: page_title_1 {
    group_label: "Page Title"

    type: string
    sql: ${TABLE}.page_title_1 ;;
  }

  dimension: page_title_2 {
    group_label: "Page Title"

    type: string
    sql: ${TABLE}.page_title_2 ;;
  }

  dimension: page_title_3 {
    group_label: "Page Title"

    type: string
    sql: ${TABLE}.page_title_3 ;;
  }

  dimension: page_title_4 {
    group_label: "Page Title"

    type: string
    sql: ${TABLE}.page_title_4 ;;
  }

  dimension: page_title_5 {
    group_label: "Page Title"

    type: string
    sql: ${TABLE}.page_title_5 ;;
  }

  dimension: page_title_6 {
    group_label: "Page Title"

    type: string
    sql: ${TABLE}.page_title_6 ;;
  }

  dimension: page_title_7 {
    group_label: "Page Title"

    type: string
    sql: ${TABLE}.page_title_7 ;;
  }

  dimension: page_title_8 {
    group_label: "Page Title"

    type: string
    sql: ${TABLE}.page_title_8 ;;
  }

  dimension: page_title_9 {
    group_label: "Page Title"

    type: string
    sql: ${TABLE}.page_title_9 ;;
  }

  dimension: page_title_10 {
    group_label: "Page Title"

    type: string
    sql: ${TABLE}.page_title_10 ;;
  }

  dimension: page_category_1 {
    group_label: "Page Category"

    type: string
    sql: ${TABLE}.page_category_1 ;;
  }

  dimension: page_category_2 {
    group_label: "Page Category"

    type: string
    sql: ${TABLE}.page_category_2 ;;
  }

  dimension: page_category_3 {
    group_label: "Page Category"

    type: string
    sql: ${TABLE}.page_category_3 ;;
  }

  dimension: page_category_4 {
    group_label: "Page Category"

    type: string
    sql: ${TABLE}.page_category_4 ;;
  }

  dimension: page_category_5 {
    group_label: "Page Category"

    type: string
    sql: ${TABLE}.page_category_5 ;;
  }

  dimension: page_category_6 {
    group_label: "Page Category"

    type: string
    sql: ${TABLE}.page_category_6 ;;
  }

  dimension: page_category_7 {
    group_label: "Page Category"

    type: string
    sql: ${TABLE}.page_category_7 ;;
  }

  dimension: page_category_8 {
    group_label: "Page Category"

    type: string
    sql: ${TABLE}.page_category_8 ;;
  }

  dimension: page_category_9 {
    group_label: "Page Category"

    type: string
    sql: ${TABLE}.page_category_9 ;;
  }

  dimension: page_category_10 {
    group_label: "Page Category"

    type: string
    sql: ${TABLE}.page_category_10 ;;
  }

  dimension: event_visit_value_1 {
    group_label: "Event Value"

    type: number
    sql: ${TABLE}.event_visit_value_1 ;;
  }

  dimension: event_visit_value_2 {
    group_label: "Event Value"

    type: number
    sql: ${TABLE}.event_visit_value_2 ;;
  }

  dimension: event_visit_value_3 {
    group_label: "Event Value"

    type: number
    sql: ${TABLE}.event_visit_value_3 ;;
  }

  dimension: event_visit_value_4 {
    group_label: "Event Value"

    type: number
    sql: ${TABLE}.event_visit_value_4 ;;
  }

  dimension: event_visit_value_5 {
    group_label: "Event Value"

    type: number
    sql: ${TABLE}.event_visit_value_5 ;;
  }

  dimension: event_visit_value_6 {
    group_label: "Event Value"

    type: number
    sql: ${TABLE}.event_visit_value_6 ;;
  }

  dimension: event_visit_value_7 {
    group_label: "Event Value"

    type: number
    sql: ${TABLE}.event_visit_value_7 ;;
  }

  dimension: event_visit_value_8 {
    group_label: "Event Value"

    type: number
    sql: ${TABLE}.event_visit_value_8 ;;
  }

  dimension: event_visit_value_9 {
    group_label: "Event Value"

    type: number
    sql: ${TABLE}.event_visit_value_9 ;;
  }

  dimension: event_visit_value_10 {
    group_label: "Event Value"

    type: number
    sql: ${TABLE}.event_visit_value_10 ;;
  }

  dimension: event_type_11 {
    group_label: "Event Type"

    type: string
    sql: ${TABLE}.event_type_11 ;;
  }

  dimension: event_type_12 {
    group_label: "Event Type"

    type: string
    sql: ${TABLE}.event_type_12 ;;
  }

  dimension: event_type_13 {
    group_label: "Event Type"

    type: string
    sql: ${TABLE}.event_type_13 ;;
  }

  dimension: event_type_14 {
    group_label: "Event Type"

    type: string
    sql: ${TABLE}.event_type_14 ;;
  }

  dimension: event_type_15 {
    group_label: "Event Type"

    type: string
    sql: ${TABLE}.event_type_15 ;;
  }

  dimension: event_type_16 {
    group_label: "Event Type"

    type: string
    sql: ${TABLE}.event_type_16 ;;
  }

  dimension: event_type_17 {
    group_label: "Event Type"

    type: string
    sql: ${TABLE}.event_type_17 ;;
  }

  dimension: event_type_18 {
    group_label: "Event Type"

    type: string
    sql: ${TABLE}.event_type_18 ;;
  }

  dimension: event_type_19 {
    group_label: "Event Type"

    type: string
    sql: ${TABLE}.event_type_19 ;;
  }

  dimension: event_type_20 {
    group_label: "Event Type"

    type: string
    sql: ${TABLE}.event_type_20 ;;
  }

  dimension: event_details_11 {
    group_label: "Event Details"

    type: string
    sql: ${TABLE}.event_details_11 ;;
  }

  dimension: event_details_12 {
    group_label: "Event Details"

    type: string
    sql: ${TABLE}.event_details_12 ;;
  }

  dimension: event_details_13 {
    group_label: "Event Details"

    type: string
    sql: ${TABLE}.event_details_13 ;;
  }

  dimension: event_details_14 {
    group_label: "Event Details"

    type: string
    sql: ${TABLE}.event_details_14 ;;
  }

  dimension: event_details_15 {
    group_label: "Event Details"

    type: string
    sql: ${TABLE}.event_details_15 ;;
  }

  dimension: event_details_16 {
    group_label: "Event Details"

    type: string
    sql: ${TABLE}.event_details_16 ;;
  }

  dimension: event_details_17 {
    group_label: "Event Details"

    type: string
    sql: ${TABLE}.event_details_17 ;;
  }

  dimension: event_details_18 {
    group_label: "Event Details"

    type: string
    sql: ${TABLE}.event_details_18 ;;
  }

  dimension: event_details_19 {
    group_label: "Event Details"

    type: string
    sql: ${TABLE}.event_details_19 ;;
  }

  dimension: event_details_20 {
    group_label: "Event Details"

    type: string
    sql: ${TABLE}.event_details_20 ;;
  }

  dimension: page_title_11 {
    group_label: "Page Title"

    type: string
    sql: ${TABLE}.page_title_11 ;;
  }

  dimension: page_title_12 {
    group_label: "Page Title"

    type: string
    sql: ${TABLE}.page_title_12 ;;
  }

  dimension: page_title_13 {
    group_label: "Page Title"

    type: string
    sql: ${TABLE}.page_title_13 ;;
  }

  dimension: page_title_14 {
    group_label: "Page Title"

    type: string
    sql: ${TABLE}.page_title_14 ;;
  }

  dimension: page_title_15 {
    group_label: "Page Title"

    type: string
    sql: ${TABLE}.page_title_15 ;;
  }

  dimension: page_title_16 {
    group_label: "Page Title"

    type: string
    sql: ${TABLE}.page_title_16 ;;
  }

  dimension: page_title_17 {
    group_label: "Page Title"

    type: string
    sql: ${TABLE}.page_title_17 ;;
  }

  dimension: page_title_18 {
    group_label: "Page Title"

    type: string
    sql: ${TABLE}.page_title_18 ;;
  }

  dimension: page_title_19 {
    group_label: "Page Title"

    type: string
    sql: ${TABLE}.page_title_19 ;;
  }

  dimension: page_title_20 {
    group_label: "Page Title"

    type: string
    sql: ${TABLE}.page_title_20 ;;
  }

  dimension: page_category_11 {
    group_label: "Page Category"

    type: string
    sql: ${TABLE}.page_category_11 ;;
  }

  dimension: page_category_12 {
    group_label: "Page Category"

    type: string
    sql: ${TABLE}.page_category_12 ;;
  }

  dimension: page_category_13 {
    group_label: "Page Category"

    type: string
    sql: ${TABLE}.page_category_13 ;;
  }

  dimension: page_category_14 {
    group_label: "Page Category"

    type: string
    sql: ${TABLE}.page_category_14 ;;
  }

  dimension: page_category_15 {
    group_label: "Page Category"

    type: string
    sql: ${TABLE}.page_category_15 ;;
  }

  dimension: page_category_16 {
    group_label: "Page Category"

    type: string
    sql: ${TABLE}.page_category_16 ;;
  }

  dimension: page_category_17 {
    group_label: "Page Category"

    type: string
    sql: ${TABLE}.page_category_17 ;;
  }

  dimension: page_category_18 {
    group_label: "Page Category"

    type: string
    sql: ${TABLE}.page_category_18 ;;
  }

  dimension: page_category_19 {
    group_label: "Page Category"

    type: string
    sql: ${TABLE}.page_category_19 ;;
  }

  dimension: page_category_20 {
    group_label: "Page Category"

    type: string
    sql: ${TABLE}.page_category_20 ;;
  }

  dimension: event_visit_value_11 {
    group_label: "Event Value"

    type: number
    sql: ${TABLE}.event_visit_value_11 ;;
  }

  dimension: event_visit_value_12 {
    group_label: "Event Value"

    type: number
    sql: ${TABLE}.event_visit_value_12 ;;
  }

  dimension: event_visit_value_13 {
    group_label: "Event Value"

    type: number
    sql: ${TABLE}.event_visit_value_13 ;;
  }

  dimension: event_visit_value_14 {
    group_label: "Event Value"

    type: number
    sql: ${TABLE}.event_visit_value_14 ;;
  }

  dimension: event_visit_value_15 {
    group_label: "Event Value"

    type: number
    sql: ${TABLE}.event_visit_value_15 ;;
  }

  dimension: event_visit_value_16 {
    group_label: "Event Value"

    type: number
    sql: ${TABLE}.event_visit_value_16 ;;
  }

  dimension: event_visit_value_17 {
    group_label: "Event Value"

    type: number
    sql: ${TABLE}.event_visit_value_17 ;;
  }

  dimension: event_visit_value_18 {
    group_label: "Event Value"

    type: number
    sql: ${TABLE}.event_visit_value_18 ;;
  }

  dimension: event_visit_value_19 {
    group_label: "Event Value"

    type: number
    sql: ${TABLE}.event_visit_value_19 ;;
  }

  dimension: event_visit_value_20 {
    group_label: "Event Value"

    type: number
    sql: ${TABLE}.event_visit_value_20 ;;
  }

  dimension_group: event_ts_1 {
    group_label: "Event Time"

    type: time
    sql: ${TABLE}.event_ts_1 ;;
  }

  dimension_group: event_ts_2 {
    group_label: "Event Time"

    type: time
    sql: ${TABLE}.event_ts_2 ;;
  }

  dimension_group: event_ts_3 {
    group_label: "Event Time"

    type: time
    sql: ${TABLE}.event_ts_3 ;;
  }

  dimension_group: event_ts_4 {
    group_label: "Event Time"

    type: time
    sql: ${TABLE}.event_ts_4 ;;
  }

  dimension_group: event_ts_5 {
    group_label: "Event Time"

    type: time
    sql: ${TABLE}.event_ts_5 ;;
  }

  dimension_group: event_ts_6 {
    group_label: "Event Time"

    type: time
    sql: ${TABLE}.event_ts_6 ;;
  }

  dimension_group: event_ts_7 {
    group_label: "Event Time"

    type: time
    sql: ${TABLE}.event_ts_7 ;;
  }

  dimension_group: event_ts_8 {
    group_label: "Event Time"

    type: time
    sql: ${TABLE}.event_ts_8 ;;
  }

  dimension_group: event_ts_9 {
    group_label: "Event Time"

    type: time
    sql: ${TABLE}.event_ts_9 ;;
  }

  dimension_group: event_ts_10 {
    group_label: "Event Time"

    type: time
    sql: ${TABLE}.event_ts_10 ;;
  }

  dimension_group: event_ts_11 {
    group_label: "Event Time"

    type: time
    sql: ${TABLE}.event_ts_11 ;;
  }

  dimension_group: event_ts_12 {
    group_label: "Event Time"

    type: time
    sql: ${TABLE}.event_ts_12 ;;
  }

  dimension_group: event_ts_13 {
    group_label: "Event Time"

    type: time
    sql: ${TABLE}.event_ts_13 ;;
  }

  dimension_group: event_ts_14 {
    group_label: "Event Time"

    type: time
    sql: ${TABLE}.event_ts_14 ;;
  }

  dimension_group: event_ts_15 {
    group_label: "Event Time"

    type: time
    sql: ${TABLE}.event_ts_15 ;;
  }

  dimension_group: event_ts_16 {
    group_label: "Event Time"

    type: time
    sql: ${TABLE}.event_ts_16 ;;
  }

  dimension_group: event_ts_17 {
    group_label: "Event Time"

    type: time
    sql: ${TABLE}.event_ts_17 ;;
  }

  dimension_group: event_ts_18 {
    group_label: "Event Time"

    type: time
    sql: ${TABLE}.event_ts_18 ;;
  }

  dimension_group: event_ts_19 {
    group_label: "Event Time"

    type: time
    sql: ${TABLE}.event_ts_19 ;;
  }

  dimension_group: event_ts_20 {
    group_label: "Event Time"

    type: time
    sql: ${TABLE}.event_ts_20 ;;
  }

  set: detail {
    fields: [
      web_sessions_pk,
      event_type_1,
      event_type_2,
      event_type_3,
      event_type_4,
      event_type_5,
      event_type_6,
      event_type_7,
      event_type_8,
      event_type_9,
      event_type_10,
      event_details_1,
      event_details_2,
      event_details_3,
      event_details_4,
      event_details_5,
      event_details_6,
      event_details_7,
      event_details_8,
      event_details_9,
      event_details_10,
      page_title_1,
      page_title_2,
      page_title_3,
      page_title_4,
      page_title_5,
      page_title_6,
      page_title_7,
      page_title_8,
      page_title_9,
      page_title_10,
      page_category_1,
      page_category_2,
      page_category_3,
      page_category_4,
      page_category_5,
      page_category_6,
      page_category_7,
      page_category_8,
      page_category_9,
      page_category_10,
      event_visit_value_1,
      event_visit_value_2,
      event_visit_value_3,
      event_visit_value_4,
      event_visit_value_5,
      event_visit_value_6,
      event_visit_value_7,
      event_visit_value_8,
      event_visit_value_9,
      event_visit_value_10,
      event_type_11,
      event_type_12,
      event_type_13,
      event_type_14,
      event_type_15,
      event_type_16,
      event_type_17,
      event_type_18,
      event_type_19,
      event_type_20,
      event_details_11,
      event_details_12,
      event_details_13,
      event_details_14,
      event_details_15,
      event_details_16,
      event_details_17,
      event_details_18,
      event_details_19,
      event_details_20,
      page_title_11,
      page_title_12,
      page_title_13,
      page_title_14,
      page_title_15,
      page_title_16,
      page_title_17,
      page_title_18,
      page_title_19,
      page_title_20,
      page_category_11,
      page_category_12,
      page_category_13,
      page_category_14,
      page_category_15,
      page_category_16,
      page_category_17,
      page_category_18,
      page_category_19,
      page_category_20,
      event_visit_value_11,
      event_visit_value_12,
      event_visit_value_13,
      event_visit_value_14,
      event_visit_value_15,
      event_visit_value_16,
      event_visit_value_17,
      event_visit_value_18,
      event_visit_value_19,
      event_visit_value_20,
      event_ts_1_time,
      event_ts_2_time,
      event_ts_3_time,
      event_ts_4_time,
      event_ts_5_time,
      event_ts_6_time,
      event_ts_7_time,
      event_ts_8_time,
      event_ts_9_time,
      event_ts_10_time,
      event_ts_11_time,
      event_ts_12_time,
      event_ts_13_time,
      event_ts_14_time,
      event_ts_15_time,
      event_ts_16_time,
      event_ts_17_time,
      event_ts_18_time,
      event_ts_19_time,
      event_ts_20_time
    ]
  }
}
