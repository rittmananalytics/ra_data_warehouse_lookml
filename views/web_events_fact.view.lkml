view: web_events_fact {
  derived_table: {
    sql: select * except(page_title),
              replace(page_title,'—','-') as page_title,
              min(event_ts) over (partition by replace(page_title,'—','-') order by event_ts) as page_title_published_at_ts,
              date_diff(date(event_ts),date(min(event_ts) over (partition by replace(page_title,'—','-') order by event_ts)), month) as months_since_page_title_published_at_ts,
              date_diff(date(event_ts),date(min(event_ts) over (partition by replace(page_title,'—','-') order by event_ts)), day) as days_since_page_title_published_at_ts,
              count(distinct case when event_type = 'Page View' then web_events_pk end) over (partition by replace(page_title,'—','-')) as total_page_views,
              count(distinct blended_user_id) over (partition by replace(page_title,'—','-')) as total_unique_viewers
       from web_events_fact;;
  }


  dimension: device {
    group_label: "  Audience"
    hidden:  yes
    description: "The specific type of device, operating system, and browser used when this event was recorded (e.g., 'iPhone; CPU iPhone OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.5 Mobile/15E148 Safari/604.1'). Hidden by default."
    type: string
    sql: ${TABLE}.device ;;
  }

  dimension: device_category {
    hidden: yes
    group_label: "  Audience"
    description: "The general type or brand of the device used when this event was recorded (e.g., 'iPhone', 'Android', 'iPad', 'Windows'). This is a simplified version of the 'Device' field. Hidden by default."
    type: string
    sql: ${TABLE}.device_category ;;
  }



  dimension: event_details {
    group_label: "Behavior"
    description: "Additional details or properties associated with the specific event, if any."
    type: string
    sql: ${TABLE}.event_details ;;
  }

  dimension: event_id {
    hidden: yes
    description: "A unique identifier for the individual event. Hidden by default."
    type: string
    sql: ${TABLE}.event_id ;;
  }

  dimension: event_in_session_seq {
    group_label: "Behavior"
    label: "Session Event Num"
    description: "The sequential number of this event within the current user session (e.g., 1st event in session, 2nd event in session)."
    type: number
    sql: ${TABLE}.event_in_session_seq ;;
  }

  dimension: event_number {
    group_label: "Behavior"
    hidden: yes
    description: "A sequential number for the event, potentially across all events for a user or globally. Refers to event_seq. Hidden by default."
    type: number
    sql: ${TABLE}.event_seq ;;
  }

  dimension_group: event_ts {
    group_label: "Dates"
    description: "The exact date and time when this specific web event occurred."
    type: time
    timeframes: [
      raw,
      time,
      week,
      month,
      date,
      day_of_week,
      day_of_month,
      hour_of_day,
      hour,
      hour3,
      quarter_of_year,
      quarter,
      year
    ]
    sql: ${TABLE}.event_ts ;;
  }

  dimension: event_type {
    group_label: "Behavior"
    description: "The type of user interaction or system event recorded (e.g., 'Page View', 'Click', 'Form Submission', 'Meeting Booked')."
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: map_location {
    group_label: "  Audience"
    description: "The geographical location (latitude and longitude) from which the event originated, suitable for map visualizations."
    type: location
    sql_latitude: ${TABLE}.latitude ;;
    sql_longitude: ${TABLE}.longitude ;;
  }

  dimension: locale_code {
    group_label: "  Audience"
    description: "The locale code (e.g., 'en-US', 'fr-FR') representing the language and regional settings of the user's browser or device at the time of the event."
    type: string
    sql: ${TABLE}.locale_code ;;
  }

  dimension: longitude {
    hidden: yes
    description: "The geographic longitude of the event's origin. Hidden by default, used by 'map_location'."
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: metro_code {
    group_label: "  Audience"
    description: "The designated market area (DMA) or metro code associated with the event's location, if available."
    type: string
    sql: ${TABLE}.metro_code ;;
  }

  dimension: network {
    hidden: yes
    description: "Information about the network (e.g., ISP, organization) from which the event originated. Hidden by default."
    type: string
    sql: ${TABLE}.network ;;
  }

  dimension: page_title {
    group_label: "Behavior"
    description: "The title of the web page on which the event occurred. Dashes ('—') are replaced with hyphens ('-') for consistency."
    type: string
    sql: ${TABLE}.page_title ;;
  }

  dimension_group: page_published {
    group_label: "Behavior"
    description: "The date and time when the content of this page (identified by its title) was first observed/published, based on the earliest event recorded for this page title."
    type: time
    timeframes: [date,month,quarter,year]
    sql: ${TABLE}.page_title_published_at_ts ;;
  }

  dimension: months_since_page_published {
    group_label: "Behavior"
    description: "The number of full months between when this page (identified by its title) was first published/observed and when this specific event occurred on it."
    type: number
    sql: ${TABLE}.months_since_page_title_published_at_ts ;;
  }

  dimension: page_total_page_views {
    group_label: "Behavior"
    description: "The total number of 'Page View' events ever recorded for this specific page title (across all users and sessions) up to the latest data point. Calculated in the derived table."
    type: number
    sql: ${TABLE}.total_page_views ;;
  }

  dimension: page_total_unique_viewers {
    group_label: "Behavior"
    description: "The total number of unique users (blended_user_id) who have ever generated a 'Page View' event for this specific page title up to the latest data point. Calculated in the derived table."
    type: number
    sql: ${TABLE}.total_unique_viewers ;;
  }

  dimension: page_url {
    group_label: "Behavior"
    description: "The full URL of the web page on which the event occurred."
    type: string
    sql: ${TABLE}.page_url ;;
  }

  dimension: page_url_host {
    group_label: "Behavior"
    description: "The hostname (e.g., 'www.example.com') of the web page on which the event occurred."
    type: string
    sql: ${TABLE}.page_url_host ;;
  }

  dimension: page_url_path {
    group_label: "Behavior"
    description: "The path component (e.g., '/products/item123') of the web page URL on which the event occurred."
    type: string
    sql: ${TABLE}.page_url_path ;;
  }

  dimension: page_category {
    group_label: "Behavior"
    description: "A predefined category assigned to the page where the event occurred, often based on URL structure or content type (e.g., '02: Blog', '08: Services')."
    type: string
    sql: ${TABLE}.computed_page_category;;
  }

  dimension: visit_value {
    type: number
    hidden: no
    description: "A numerical score assigned to the event. Conversion events ('Meeting Booked') receive a value of 16; other events are valued based on the numerical prefix of their page_category."
    sql: case when ${is_conversion_event} then 16 else safe_cast(split(${TABLE}.page_category,":")[SAFE_OFFSET(0)] as int64) end;;
  }

  dimension: is_conversion_event {
    type: yesno
    group_label: "Behavior"
    description: "Indicates (Yes/No) if this event is a 'Meeting Booked' event, which is considered a primary conversion."
    sql: ${TABLE}.event_type = 'Meeting Booked' ;;
  }

  dimension: is_goal_achieved {
    type: yesno
    group_label: "Behavior"
    description: "Indicates (Yes/No) if this event signifies the achievement of a predefined goal (based on the is_goal_achieved_event flag from the source table)."
    sql: ${TABLE}.is_goal_achieved_event;;
  }

  measure: total_conversions {
    description: "The total number of unique 'Meeting Booked' events."
    type: count_distinct
    value_format_name: decimal_0
    sql: ${web_events_pk} ;;
    filters: [is_conversion_event: "Yes"]
  }

  measure: total_goal_achieveds {
    description: "The total number of unique events where a predefined goal was achieved."
    value_format_name: decimal_0
    type: count_distinct
    sql: ${web_events_pk} ;;
    filters: [is_goal_achieved: "Yes"]
  }

  measure: total_session_conversions {
    description: "The total number of unique sessions that included at least one 'Meeting Booked' event."
    value_format_name: decimal_0
    type: count_distinct
    sql: ${session_id} ;;
    filters: [is_conversion_event: "Yes"]
  }

  measure: total_user_conversions {
    description: "The total number of unique users (blended_user_id) who performed at least one 'Meeting Booked' event."
    value_format_name: decimal_0
    type: count_distinct
    sql: ${blended_user_id} ;;
    filters: [is_conversion_event: "Yes"]
  }

  measure: total_session_goal_achieveds {
    description: "The total number of unique sessions that included at least one event where a predefined goal was achieved."
    value_format_name: decimal_0
    type: count_distinct
    sql: ${session_id} ;;
    filters: [is_goal_achieved: "Yes"]
  }

  measure: total_user_goal_achieveds {
    description: "The total number of unique users (blended_user_id) who had at least one event where a predefined goal was achieved."
    value_format_name: decimal_0
    type: count_distinct
    sql: ${blended_user_id} ;;
    filters: [is_goal_achieved: "Yes"]
  }

  measure: total_visitor_value {
    description: "The sum of 'Visit Value' for all events, providing a weighted measure of engagement and conversion."
    value_format_name: decimal_0
    type: sum
    sql: ${visit_value};;
  }

  measure: avg_session_value {
    description: "The average 'Visit Value' per session, calculated as Total Visitor Value divided by Total Sessions (from web_sessions_fact)."
    value_format_name: decimal_2
    type: number
    sql: ${total_visitor_value}/${web_sessions_fact.total_sessions} ;;
  }

  dimension: postal_code {
    map_layer_name: us_zipcode_tabulation_areas
    description: "The postal or ZIP code associated with the event's location. Configured for US zipcode map layer."
    type: string
    sql: ${TABLE}.postal_code ;;
  }

  dimension_group: prev_event_ts {
    group_label: "Dates"
    hidden: yes
    description: "The timestamp of the event that occurred immediately prior to this one for the same user. Hidden by default."
    type: time
    timeframes: [
      time,
      month,
      date
    ]
    sql: ${TABLE}.prev_event_ts ;;
  }

  dimension: prev_event_type {
    group_label: "Conversions"
    hidden: yes
    description: "The type of the event that occurred immediately prior to this one for the same user. Hidden by default."
    type: string
    sql: ${TABLE}.prev_event_type ;;
  }

  dimension: search {
    group_label: "    Acquisition"
    hidden: yes
    description: "The search query or keywords used by the visitor if they arrived from a search engine leading to this event or session. May be '(not provided)'. Hidden by default."
    type: string
    sql: ${TABLE}.search ;;
  }

  dimension: session_id {
    hidden: no
    description: "The unique identifier for the web session to which this event belongs."
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: site {
    group_label: "Behavior"
    description: "The website or domain on which the event occurred (e.g., 'rittmananalytics.com')."
    type: string
    sql: ${TABLE}.site ;;
  }

  measure: total_unique_users {
    label: "Total Unique Users"
    description: "The total number of distinct users (blended_user_id) who generated at least one event."
    value_format_name: decimal_0
    type: count_distinct
    sql: ${TABLE}.blended_user_id ;;
    drill_fields: [device, blended_user_id, device_category, subscription_fact.channel]
  }

  dimension: blended_user_id {
    hidden: yes
    description: "A unique identifier for a user, potentially unified across different platforms or tracking mechanisms, associated with this event. Hidden by default."
    type: string
    sql: ${TABLE}.blended_user_id ;;
  }

  measure: total_page_views {
    description: "The total number of unique 'Page View' events."
    value_format_name: decimal_0
    hidden: no
    type: count_distinct
    sql: case when ${TABLE}.event_type = 'Page View' then ${TABLE}.web_events_pk end;;
  }

  measure: total_marketing_page_views {
    description: "The total number of unique 'Page View' events that occurred on pages categorized as '04: Marketing'."
    value_format_name: decimal_0
    hidden: no
    type: count_distinct
    sql: case when ${TABLE}.event_type = 'Page View' then ${TABLE}.web_events_pk end ;;
    filters: [page_category: "04: Marketing"]
  }

  measure: total_case_study_page_views {
    description: "The total number of unique 'Page View' events that occurred on pages categorized as '06: Case Study'."
    value_format_name: decimal_0
    hidden: no
    type: count_distinct
    sql: case when ${TABLE}.event_type = 'Page View' then ${TABLE}.web_events_pk end ;;
    filters: [page_category: "06: Case Study"]
  }

  measure: total_services_page_views {
    description: "The total number of unique 'Page View' events that occurred on pages categorized as '08: Services'."
    value_format_name: decimal_0
    hidden: no
    type: count_distinct
    sql: case when ${TABLE}.event_type = 'Page View' then ${TABLE}.web_events_pk end ;;
    filters: [page_category: "08: Services"]
  }

  measure: total_blog_page_views {
    description: "The total number of unique 'Page View' events that occurred on pages categorized as '02: Social' (typically blog pages)."
    value_format_name: decimal_0
    hidden: no
    type: count_distinct
    sql: case when ${TABLE}.event_type = 'Page View' then ${TABLE}.web_events_pk end ;;
    filters: [page_category: "02: Social"]
  }

  dimension: time_on_page_secs {
    hidden: yes
    description: "The duration in seconds that the user spent on the page associated with this event before navigating away or triggering another event. Hidden by default."
    type: number
    sql: ${TABLE}.time_on_page_secs ;;
  }

  dimension: time_zone {
    hidden: yes
    description: "The time zone of the user when the event occurred (e.g., 'America/New_York'). Hidden by default."
    type: string
    sql: ${TABLE}.time_zone ;;
  }

  dimension: user_id {
    hidden: no
    description: "A user identifier, which might be specific to a certain platform or tracking system before blending (see blended_user_id)."
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: utm_campaign {
    group_label: "    Acquisition"
    label: "Event UTM Campaign"
    description: "The UTM campaign parameter value associated with the session or source that led to this event (e.g., 'summer_promo')."
    type: string
    sql: ${TABLE}.utm_campaign ;;
  }

  dimension: utm_content {
    group_label: "    Acquisition"
    label: "Event UTM Content"
    description: "The UTM content parameter value associated with the session or source that led to this event, used to differentiate ads or links (e.g., 'banner_ad_1')."
    type: string
    sql: ${TABLE}.utm_content ;;
  }

  dimension: utm_medium {
    group_label: "    Acquisition"
    label: "Event UTM Medium"
    description: "The UTM medium parameter value associated with the session or source that led to this event (e.g., 'cpc', 'email', 'social')."
    type: string
    sql: ${TABLE}.utm_medium ;;
  }

  dimension: utm_source {
    group_label: "    Acquisition"
    label: "Event UTM Source"
    description: "The UTM source parameter value associated with the session or source that led to this event (e.g., 'google', 'facebook', 'newsletter')."
    type: string
    sql: ${TABLE}.utm_source ;;
  }

  dimension: utm_term {
    group_label: "    Acquisition"
    label: "Event UTM Keyword"
    description: "The UTM term (keyword) parameter value associated with the session or source that led to this event, often used for paid search keywords."
    type: string
    sql: ${TABLE}.utm_term ;;
  }

  dimension: visitor_id {
    label: "Anonymous (Device) ID "
    hidden: no
    description: "An anonymous identifier, typically associated with a device or browser instance, used before a user is identified."
    type: string
    sql: ${TABLE}.visitor_id ;;
  }

  dimension: web_events_pk {
    group_label: "Behavior"
    hidden: no
    primary_key:  yes
    description: "The primary key uniquely identifying each web event record."
    type: string
    sql: ${TABLE}.web_events_pk ;;
  }

  dimension: event_seq {
    group_label: "Behavior"
    description: "A sequential number assigned to the event, potentially an overall sequence for the user or globally. This is the raw event_seq from the source."
    type: number
    sql: ${TABLE}.event_seq ;;
  }

  dimension: gclid {
    group_label: "  Audience"
    description: "Google Click Identifier (GCLID) captured for this event, used for tracking clicks from Google Ads."
    type: string
    sql: ${TABLE}.gclid ;;
  }

  dimension: ip {
    group_label: "  Audience"
    description: "The IP address from which the event originated. Note: IP addresses can be an approximation of location and may be anonymized."
    type: string
    sql: ${TABLE}.ip ;;
  }

  dimension: referrer_host {
    group_label: "    Acquisition"
    description: "The hostname (e.g., 'google.com') of the website that referred the user to the page where this event occurred, or to the start of the session."
    type: string
    sql: ${TABLE}.referrer_host ;;
  }

  dimension: referrer {
    group_label: "    Acquisition"
    description: "The full URL of the page that linked the user to the website for this event or session, excluding any query parameters."
    type: string
    sql: split(${TABLE}.referrer, "?")[SAFE_OFFSET(0)] ;;
  }

  dimension: referrer_source {
    group_label: "    Acquisition"
    description: "The classified source of the referral traffic for this event, specifically identifying 'Medium' if the referrer URL matches known Medium blog patterns."
    type: string
    sql: case when ${referrer} like '%blog.rittmananalytics.com%' or ${referrer} like '%medium.com/mark-rittman%' then 'Medium' end ;;
  }

  dimension: referrer_article_stub {
    group_label: "    Acquisition"
    description: "If the referrer is identified as 'Medium' (from blog.rittmananalytics.com or medium.com), this field extracts the article slug or identifier from the referrer URL."
    type: string
    sql: case when ${referrer_source} = 'Medium' and ${referrer_host} = 'blog.rittmananalytics.com' then split(${referrer},'/')[safe_offset(3)]
              when ${referrer_source} = 'Medium' and ${referrer_host} = 'medium.com' then split(${referrer},'/')[safe_offset(4)]
          end ;;
  }





  dimension: referrer_domain {
    type: string
    sql: ${TABLE}.referrer_domain ;;
  }

  dimension: screen_resolution {
    type: string
    sql: ${TABLE}.screen_resolution ;;
  }

  dimension: viewport_size {
    type: string
    sql: ${TABLE}.viewport_size ;;
  }

  dimension: partner {
    type: string
    sql: ${TABLE}.partner ;;
  }

  dimension: blog_post_author {
    type: string
    sql: ${TABLE}.blog_post_author ;;
  }

  dimension: blog_post_category {
    type: string
    sql: ${TABLE}.blog_post_category ;;
  }

  dimension: blog_post_id {
    type: string
    sql: ${TABLE}.blog_post_id ;;
  }

  dimension: blog_post_tags {
    type: string
    sql: ${TABLE}.blog_post_tags ;;
  }

  dimension: blog_post_title {
    type: string
    sql: ${TABLE}.blog_post_title ;;
  }

  dimension: page_type {
    type: string
    sql: ${TABLE}.page_type ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: country_code {
    type: string
    sql: ${TABLE}.country_code ;;
  }

  dimension: isp {
    type: string
    sql: ${TABLE}.isp ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }


  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: region_code {
    type: string
    sql: ${TABLE}.region_code ;;
  }

  dimension: timezone {
    type: string
    sql: ${TABLE}.timezone ;;
  }
}
