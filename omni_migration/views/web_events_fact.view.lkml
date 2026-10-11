view: web_events_fact {
  derived_table: {
    sql: select * except(page_title),
                    replace(page_title,'—','-') as page_title,
                    min(event_ts) over (partition by replace(page_title,'—','-') order by event_ts) as page_title_published_at_ts,
                    date_diff(date(event_ts),date(min(event_ts) over (partition by replace(page_title,'—','-') order by event_ts)), month) as months_since_page_title_published_at_ts,
                    date_diff(date(event_ts),date(min(event_ts) over (partition by replace(page_title,'—','-') order by event_ts)), day) as days_since_page_title_published_at_ts,
                    count(distinct case when event_type = 'Page View' then web_events_pk end) over (partition by replace(page_title,'—','-')) as total_page_views,
                    count(distinct blended_user_id) over (partition by replace(page_title,'—','-')) as total_unique_viewers
             from web_events_fact ;;
  }

  dimension: blended_user_id {
    description: "A unique identifier for a user, potentially unified across different platforms or tracking mechanisms, associated with this event. Hidden by default."
    hidden: yes
    sql: ${TABLE}.blended_user_id ;;
  }

  dimension: blog_post_author {
    sql: ${TABLE}.blog_post_author ;;
  }

  dimension: blog_post_category {
    sql: ${TABLE}.blog_post_category ;;
  }

  dimension: blog_post_id {
    sql: ${TABLE}.blog_post_id ;;
  }

  dimension: blog_post_tags {
    sql: ${TABLE}.blog_post_tags ;;
  }

  dimension: blog_post_title {
    sql: ${TABLE}.blog_post_title ;;
  }

  dimension: city {
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    sql: ${TABLE}.country ;;
  }

  dimension: country_code {
    sql: ${TABLE}.country_code ;;
  }

  dimension: device {
    group_label: "Audience"
    description: "The specific type of device, operating system, and browser used when this event was recorded (e.g., 'iPhone; CPU iPhone OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.5 Mobile/15E148 Safari/604.1'). Hidden by default."
    hidden: yes
    sql: ${TABLE}.device ;;
  }

  dimension: device_category {
    group_label: "Audience"
    description: "The general type or brand of the device used when this event was recorded (e.g., 'iPhone', 'Android', 'iPad', 'Windows'). This is a simplified version of the 'Device' field. Hidden by default."
    hidden: yes
    sql: ${TABLE}.device_category ;;
  }

  dimension: event_details {
    group_label: "Behavior"
    description: "Additional details or properties associated with the specific event, if any."
    sql: ${TABLE}.event_details ;;
  }

  dimension: event_id {
    description: "A unique identifier for the individual event. Hidden by default."
    hidden: yes
    sql: ${TABLE}.event_id ;;
  }

  dimension: event_in_session_seq {
    label: "Session Event Num"
    group_label: "Behavior"
    description: "The sequential number of this event within the current user session (e.g., 1st event in session, 2nd event in session)."
    sql: ${TABLE}.event_in_session_seq ;;
  }

  dimension: event_number {
    group_label: "Behavior"
    description: "A sequential number for the event, potentially across all events for a user or globally. Refers to event_seq. Hidden by default."
    hidden: yes
    sql: ${event_seq} ;;
  }

  dimension: event_seq {
    group_label: "Behavior"
    description: "A sequential number assigned to the event, potentially an overall sequence for the user or globally. This is the raw event_seq from the source."
    sql: ${TABLE}.event_seq ;;
  }

  dimension: event_type {
    group_label: "Behavior"
    description: "The type of user interaction or system event recorded (e.g., 'Page View', 'Click', 'Form Submission', 'Meeting Booked')."
    sql: ${TABLE}.event_type ;;
  }

  dimension: gclid {
    group_label: "Audience"
    description: "Google Click Identifier (GCLID) captured for this event, used for tracking clicks from Google Ads."
    sql: ${TABLE}.gclid ;;
  }

  dimension: ip {
    group_label: "Audience"
    description: "The IP address from which the event originated. Note: IP addresses can be an approximation of location and may be anonymized."
    sql: ${TABLE}.ip ;;
  }

  dimension: is_conversion_event {
    type: yesno
    group_label: "Behavior"
    description: "Indicates (Yes/No) if this event is a 'Meeting Booked' event, which is considered a primary conversion."
    sql: ${event_type} = 'Meeting Booked' ;;
  }

  dimension: is_goal_achieved {
    type: yesno
    group_label: "Behavior"
    description: "Indicates (Yes/No) if this event signifies the achievement of a predefined goal (based on the is_goal_achieved_event flag from the source table)."
    sql: ${TABLE}.is_goal_achieved_event ;;
  }

  dimension: isp {
    sql: ${TABLE}.isp ;;
  }

  dimension: latitude {
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    description: "The geographic longitude of the event's origin. Hidden by default, used by 'map_location'."
    hidden: yes
    sql: ${TABLE}.longitude ;;
  }

  dimension: months_since_page_published {
    group_label: "Behavior"
    description: "The number of full months between when this page (identified by its title) was first published/observed and when this specific event occurred on it."
    sql: ${TABLE}.months_since_page_title_published_at_ts ;;
  }

  dimension: page_category {
    group_label: "Behavior"
    description: "A predefined category assigned to the page where the event occurred, often based on URL structure or content type (e.g., '02: Blog', '08: Services')."
    sql: ${TABLE}.computed_page_category ;;
  }

  dimension: page_title {
    group_label: "Behavior"
    description: "The title of the web page on which the event occurred. Dashes ('—') are replaced with hyphens ('-') for consistency."
    sql: ${TABLE}.page_title ;;
  }

  dimension: page_total_page_views {
    group_label: "Behavior"
    description: "The total number of 'Page View' events ever recorded for this specific page title (across all users and sessions) up to the latest data point. Calculated in the derived table."
    sql: ${total_page_views} ;;
  }

  dimension: page_total_unique_viewers {
    group_label: "Behavior"
    description: "The total number of unique users (blended_user_id) who have ever generated a 'Page View' event for this specific page title up to the latest data point. Calculated in the derived table."
    sql: ${TABLE}.total_unique_viewers ;;
  }

  dimension: page_type {
    sql: ${TABLE}.page_type ;;
  }

  dimension: page_url {
    group_label: "Behavior"
    description: "The full URL of the web page on which the event occurred."
    sql: ${TABLE}.page_url ;;
  }

  dimension: page_url_host {
    group_label: "Behavior"
    description: "The hostname (e.g., 'www.example.com') of the web page on which the event occurred."
    sql: ${TABLE}.page_url_host ;;
  }

  dimension: page_url_path {
    group_label: "Behavior"
    description: "The path component (e.g., '/products/item123') of the web page URL on which the event occurred."
    sql: ${TABLE}.page_url_path ;;
  }

  dimension: partner {
    sql: ${TABLE}.partner ;;
  }

  dimension: referrer {
    group_label: "Acquisition"
    description: "The full URL of the page that linked the user to the website for this event or session, excluding any query parameters."
    sql: split(${TABLE}.referrer, "?")[SAFE_OFFSET(0)] ;;
  }

  dimension: referrer_article_stub {
    group_label: "Acquisition"
    description: "If the referrer is identified as 'Medium' (from blog.rittmananalytics.com or medium.com), this field extracts the article slug or identifier from the referrer URL."
    sql: case when ${referrer_source} = 'Medium' and ${referrer_host} = 'blog.rittmananalytics.com' then split(${referrer},'/')[safe_offset(3)]
              when ${referrer_source} = 'Medium' and ${referrer_host} = 'medium.com' then split(${referrer},'/')[safe_offset(4)]
          end ;;
  }

  dimension: referrer_domain {
    sql: ${TABLE}.referrer_domain ;;
  }

  dimension: referrer_host {
    group_label: "Acquisition"
    description: "The hostname (e.g., 'google.com') of the website that referred the user to the page where this event occurred, or to the start of the session."
    sql: ${TABLE}.referrer_host ;;
  }

  dimension: referrer_source {
    group_label: "Acquisition"
    description: "The classified source of the referral traffic for this event, specifically identifying 'Medium' if the referrer URL matches known Medium blog patterns."
    sql: case when ${referrer} like '%blog.rittmananalytics.com%' or ${referrer} like '%medium.com/mark-rittman%' then 'Medium' end ;;
  }

  dimension: region {
    sql: ${TABLE}.region ;;
  }

  dimension: region_code {
    sql: ${TABLE}.region_code ;;
  }

  dimension: screen_resolution {
    sql: ${TABLE}.screen_resolution ;;
  }

  dimension: search {
    group_label: "Acquisition"
    description: "The search query or keywords used by the visitor if they arrived from a search engine leading to this event or session. May be '(not provided)'. Hidden by default."
    hidden: yes
    sql: ${TABLE}.search ;;
  }

  dimension: session_id {
    description: "The unique identifier for the web session to which this event belongs."
    sql: ${TABLE}.session_id ;;
  }

  dimension: site {
    group_label: "Behavior"
    description: "The website or domain on which the event occurred (e.g., 'rittmananalytics.com')."
    sql: ${TABLE}.site ;;
  }

  dimension: time_on_page_secs {
    description: "The duration in seconds that the user spent on the page associated with this event before navigating away or triggering another event. Hidden by default."
    hidden: yes
    sql: ${TABLE}.time_on_page_secs ;;
  }

  dimension: timezone {
    sql: ${TABLE}.timezone ;;
  }

  dimension: user_id {
    description: "A user identifier, which might be specific to a certain platform or tracking system before blending (see blended_user_id)."
    sql: ${TABLE}.user_id ;;
  }

  dimension: utm_campaign {
    label: "Event UTM Campaign"
    group_label: "Acquisition"
    description: "The UTM campaign parameter value associated with the session or source that led to this event (e.g., 'summer_promo')."
    sql: ${TABLE}.utm_campaign ;;
  }

  dimension: utm_content {
    label: "Event UTM Content"
    group_label: "Acquisition"
    description: "The UTM content parameter value associated with the session or source that led to this event, used to differentiate ads or links (e.g., 'banner_ad_1')."
    sql: ${TABLE}.utm_content ;;
  }

  dimension: utm_medium {
    label: "Event UTM Medium"
    group_label: "Acquisition"
    description: "The UTM medium parameter value associated with the session or source that led to this event (e.g., 'cpc', 'email', 'social')."
    sql: ${TABLE}.utm_medium ;;
  }

  dimension: utm_source {
    label: "Event UTM Source"
    group_label: "Acquisition"
    description: "The UTM source parameter value associated with the session or source that led to this event (e.g., 'google', 'facebook', 'newsletter')."
    sql: ${TABLE}.utm_source ;;
  }

  dimension: utm_term {
    label: "Event UTM Keyword"
    group_label: "Acquisition"
    description: "The UTM term (keyword) parameter value associated with the session or source that led to this event, often used for paid search keywords."
    sql: ${TABLE}.utm_term ;;
  }

  dimension: viewport_size {
    sql: ${TABLE}.viewport_size ;;
  }

  dimension: visit_value {
    description: "A numerical score assigned to the event. Conversion events ('Meeting Booked') receive a value of 16; other events are valued based on the numerical prefix of their page_category."
    sql: case when ${is_conversion_event} then 16 else safe_cast(split(${page_category},":")[SAFE_OFFSET(0)] as int64) end ;;
  }

  dimension: visitor_id {
    label: "Anonymous (Device) ID"
    description: "An anonymous identifier, typically associated with a device or browser instance, used before a user is identified."
    sql: ${TABLE}.visitor_id ;;
  }

  dimension: web_events_pk {
    primary_key: yes
    group_label: "Behavior"
    description: "The primary key uniquely identifying each web event record."
    sql: ${TABLE}.web_events_pk ;;
  }

  dimension_group: event_ts {
    type: time
    timeframes: [raw, date, week, month, quarter, year, hour, day_of_week, day_of_month, hour_of_day, quarter_of_year]
    group_label: "Dates"
    description: "The exact date and time when this specific web event occurred."
    sql: ${TABLE}.event_ts ;;
  }

  dimension_group: page_published {
    type: time
    timeframes: [raw, date, month, quarter, year]
    group_label: "Behavior"
    description: "The date and time when the content of this page (identified by its title) was first observed/published, based on the earliest event recorded for this page title."
    sql: ${TABLE}.page_title_published_at_ts ;;
  }

  measure: average_session_value {
    type: number
    label: "Average Session Value"
    description: "Visitor value per session (Looker table calculation average_session_value)"
    value_format_name: decimal_2
    sql: safe_divide(${total_visitor_value}, ${total_sessions}) ;;
  }

  measure: avg_session_value {
    type: number
    description: "The average 'Visit Value' per session, calculated as Total Visitor Value divided by Total Sessions (from web_sessions_fact)."
    value_format_name: decimal_2
    sql: ${total_visitor_value}/${web_sessions_fact.total_sessions} ;;
  }

  measure: total_blended_user_id {
    type: count_distinct
    value_format_name: decimal_0
    sql: ${blended_user_id} ;;
  }

  measure: total_blog_page_views {
    type: count_distinct
    description: "The total number of unique 'Page View' events that occurred on pages categorized as '02: Social' (typically blog pages)."
    value_format_name: decimal_0
    sql: case when ${event_type} = 'Page View' then ${web_events_pk} end ;;
    filters: [page_category: "02: Social"]
  }

  measure: total_case_study_page_views {
    type: count_distinct
    description: "The total number of unique 'Page View' events that occurred on pages categorized as '06: Case Study'."
    value_format_name: decimal_0
    sql: case when ${event_type} = 'Page View' then ${web_events_pk} end ;;
    filters: [page_category: "06: Case Study"]
  }

  measure: total_commercial_page_views {
    type: number
    label: "Commercial Page Views"
    description: "Services, marketing and case-study page views (Looker tile 2411 table calculation commercial_page_views)"
    value_format_name: decimal_0
    sql: coalesce(${total_services_page_views},0) + coalesce(${total_marketing_page_views},0) + coalesce(${total_case_study_page_views},0) ;;
  }

  measure: total_conversions {
    type: count_distinct
    description: "The total number of unique 'Meeting Booked' events."
    value_format_name: decimal_0
    sql: ${web_events_pk} ;;
    filters: [is_conversion_event: "Yes"]
  }

  measure: total_goal_achieveds {
    type: count_distinct
    description: "The total number of unique events where a predefined goal was achieved."
    value_format_name: decimal_0
    sql: ${web_events_pk} ;;
    filters: [is_goal_achieved: "Yes"]
  }

  measure: total_marketing_page_views {
    type: count_distinct
    description: "The total number of unique 'Page View' events that occurred on pages categorized as '04: Marketing'."
    value_format_name: decimal_0
    sql: case when ${event_type} = 'Page View' then ${web_events_pk} end ;;
    filters: [page_category: "04: Marketing"]
  }

  measure: total_page_views {
    type: count_distinct
    description: "The total number of unique 'Page View' events."
    value_format_name: decimal_0
    sql: case when ${event_type} = 'Page View' then ${web_events_pk} end ;;
  }

  measure: total_services_page_views {
    type: count_distinct
    description: "The total number of unique 'Page View' events that occurred on pages categorized as '08: Services'."
    value_format_name: decimal_0
    sql: case when ${event_type} = 'Page View' then ${web_events_pk} end ;;
    filters: [page_category: "08: Services"]
  }

  measure: total_session_conversions {
    type: count_distinct
    description: "The total number of unique sessions that included at least one 'Meeting Booked' event."
    value_format_name: decimal_0
    sql: ${session_id} ;;
    filters: [is_conversion_event: "Yes"]
  }

  measure: total_session_goal_achieveds {
    type: count_distinct
    description: "The total number of unique sessions that included at least one event where a predefined goal was achieved."
    value_format_name: decimal_0
    sql: ${session_id} ;;
    filters: [is_goal_achieved: "Yes"]
  }

  measure: total_sessions {
    type: count_distinct
    value_format_name: decimal_0
    sql: ${session_id} ;;
  }

  measure: total_unique_users {
    type: count_distinct
    label: "Total Unique Users"
    description: "The total number of distinct users (blended_user_id) who generated at least one event."
    value_format_name: decimal_0
    drill_fields: [web_events_fact.device, web_events_fact.blended_user_id, web_events_fact.device_category]
    sql: ${blended_user_id} ;;
  }

  measure: total_user_conversions {
    type: count_distinct
    description: "The total number of unique users (blended_user_id) who performed at least one 'Meeting Booked' event."
    value_format_name: decimal_0
    sql: ${blended_user_id} ;;
    filters: [is_conversion_event: "Yes"]
  }

  measure: total_user_goal_achieveds {
    type: count_distinct
    description: "The total number of unique users (blended_user_id) who had at least one event where a predefined goal was achieved."
    value_format_name: decimal_0
    sql: ${blended_user_id} ;;
    filters: [is_goal_achieved: "Yes"]
  }

  measure: total_visitor_value {
    type: sum
    description: "The sum of 'Visit Value' for all events, providing a weighted measure of engagement and conversion."
    value_format_name: decimal_0
    sql: ${visit_value} ;;
  }

  measure: user_conversion_rate {
    type: number
    label: "CR"
    description: "Users with a Meeting Booked event as a share of all users (Looker tile 2358 table calculation user_conversion_rate)"
    value_format_name: percent_2
    sql: safe_divide(${total_user_conversions}, ${total_blended_user_id}) ;;
  }
}
