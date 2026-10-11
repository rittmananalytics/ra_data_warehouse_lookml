view: web_sessions_fact {
  sql_table_name: `ra-development.analytics.web_sessions_fact` ;;

  dimension: blended_user_id {
    type: string
    group_label: "Audience"
    description: "A unique identifier for a user, potentially unified across different platforms or tracking mechanisms."
    sql: ${TABLE}.blended_user_id ;;
  }

  dimension: channel {
    type: string
    group_label: "Acquisition"
    description: "The marketing channel attributed to this session, determined by custom logic using UTM parameters and referrer information. Examples include 'Paid Social', 'Organic Social', 'Organic Search', 'Referral', 'Direct'."
    sql: case when ${session_utm_source} in ('linkedin','facebook') and ${session_utm_medium} = 'paid' then 'Paid Social'
              when (${session_utm_source} = 'linkedin' or ${referrer_host} like '%linkedin%') and ${session_utm_medium} != 'paid' then 'Organic Social'
              when ${TABLE}.channel = 'Social' then 'Organic Social'
              when ${TABLE}.channel in ('facebook','linkedin') and ${session_utm_medium} = 'social' then 'Organic Social'
              when ${session_utm_medium} = 'social' and ${TABLE}.channel = 'Direct' then 'Organic Social'
              when ${session_utm_source} = 'substack' and ${session_utm_medium} != 'email' then 'Organic Social'
              when ${session_utm_source} like 'pocket_%' then 'Referral'
              when (${referrer_host} like '%rittmananalytics.com%' and ${referrer_host} not like '%blog.rittmananalytics.com%') or ${referrer_host} like 'calendly.com' then 'Direct'
              when ${referrer_host} like '%medium.com%' or ${referrer_host} like '%blog.rittmananalytics.com%'  then 'Organic Social'
              else ${TABLE}.channel end ;;
  }

  dimension: channel_category {
    group_label: "Acquisition"
    description: "A higher-level grouping of the marketing channel. 'Paid' includes paid social and paid search; 'Organic' includes organic social, video, search, email, and referrals. Other channels retain their name."
    sql: case when ${channel} in ('Paid Social','Paid Search') then 'Paid'
              when ${channel} in ('Organic Social','Organic Video','Organic Search','Email','Referral') then 'Organic'
              else ${channel} end ;;
  }

  dimension: company_name {
    type: string
    group_label: "Audience"
    sql: ${TABLE}.company_name ;;
  }

  dimension: device {
    type: string
    group_label: "Audience"
    description: "The specific type of device, operating system, and browser used to access the website (e.g., 'iPhone; CPU iPhone OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.5 Mobile/15E148 Safari/604.1')."
    sql: ${TABLE}.device ;;
  }

  dimension: device_category {
    type: string
    group_label: "Audience"
    description: "The general type or brand of the device, such as 'iPhone', 'Android', 'iPad', or 'Windows'. This is a simplified version of the 'Device' field."
    sql: ${TABLE}.device_category ;;
  }

  dimension: duration_in_s {
    type: number
    group_label: "Behavior"
    description: "The total duration of the web session in seconds."
    sql: ${TABLE}.duration_in_s ;;
  }

  dimension: duration_in_s_tier {
    type: string
    group_label: "Behavior"
    description: "Categorizes session duration (in seconds) into predefined time buckets."
    sql: ${TABLE}.duration_in_s_tier ;;
  }

  dimension: events {
    type: number
    label: "Session Events"
    group_label: "Behavior"
    description: "The total count of tracked events (e.g., page views, clicks) that occurred during this specific session."
    sql: ${TABLE}.events ;;
  }

  dimension: first_page_category {
    type: string
    label: "Entrance Page Category"
    group_label: "Behavior"
    description: "A predefined category for the first page (entrance page) viewed in the session, based on its URL or title. Examples include '01: Blog', '01: Podcast', '01: Home Page', '04: Service'."
    sql: case when ${first_page_url} like '%blog%' or ${first_page_url} like '%rittmananalytics.com/202%' or  ${first_page_title} like '%Videos — Rittman Analytics%' then '01: Blog'
                  when ${first_page_url} like '%drilltodetail%' or ${first_page_url} like '%podcast%' then '01: Podcast'
                  when ${first_page_url} = '/' or ${first_page_url} like '%home-index%' or ${first_page_title} like '%Scale your Analytics — Rittman Analytics%' then '01: Home Page'
                  when ${first_page_url} like '%/services/%' or ${first_page_url} like '%/offers/%' or ${first_page_title} like '%Project Discovery — Rittman Analytics%' or ${first_page_title} like '%Looker GenAI — Rittman Analytics%' or ${first_page_title} like '%Looker Jumpstart — Rittman Analytics%' or ${first_page_title} like '%Generative AI — Rittman Analytics%' then '04: Service'
                  when ${first_page_url} like '%/about/%' or ${first_page_url} like '%/contact%' or ${first_page_url} like '%/faqs/%' or ${first_page_url} like '%scv-contact-us-form%' then '08: Contact'
                  when ${first_page_url} like '%sidebar%' then 'Misc'
                  when ${first_page_url} like '%/assistant%' then '06: Assistant'
                  when ${first_page_url} like '%/pricing%' or ${first_page_url} like '%/engagement-model%' or ${first_page_url} like '%/how-we-work%' then '12: Commercials'
                  when ${first_page_url} like '%scv-thank-you%' or ${first_page_url} like '%/modern-data-stack-thank-you%' then '08: Goal Achieved'
                  when ${first_page_url} like '%causal-analytics%' or ${first_page_url} like '/scv-download-hubspot-form' then '02: Landing Page'
                  when ${first_page_url} like '%causal-analytics-video%' or ${first_page_url} like '%download-10-ways-your-modern-data-stack-can-fail%' or ${first_page_url} like '%download-page%' then '04: Gated Content'
                  when ${first_page_url} like '%industries%' or ${first_page_url} like '%about%' or ${first_page_url} like '%partners%' or ${first_page_title} like '%Data Analytics Project Checklist — Rittman Analytics%' then '02: Marketing'
                  when ${first_page_url} like '%case-studies%' then '03: Case Study'
                  when ${first_page_url} like '%calendly%' then '06: Conversion'
              end ;;
  }

  dimension: first_page_title {
    type: string
    label: "Entrance Page Title"
    group_label: "Behavior"
    description: "The title of the first page (entrance page) viewed by the user during this session."
    sql: ${TABLE}.first_page_title ;;
  }

  dimension: first_page_url {
    type: string
    label: "Entrance Page URL"
    group_label: "Behavior"
    description: "The full URL of the first page (entrance page) viewed by the user during this session, with any trailing slash removed."
    sql: rtrim(${TABLE}.first_page_url,"/") ;;
  }

  dimension: first_page_url_host {
    type: string
    group_label: "Behavior"
    description: "The hostname (e.g., 'www.example.com') of the first page (entrance page) viewed in the session. Hidden by default."
    hidden: yes
    sql: ${TABLE}.first_page_url_host ;;
  }

  dimension: first_page_url_path {
    type: string
    description: "The path (e.g., '/blog/article-name') of the first page (entrance page) viewed in the session, with any trailing slash removed. Hidden by default."
    hidden: yes
    sql: rtrim(${TABLE}.first_page_url_path,"/") ;;
  }

  dimension: gclid {
    type: string
    description: "Google Click Identifier (GCLID), used for tracking clicks from Google Ads. Hidden by default."
    hidden: yes
    sql: ${TABLE}.gclid ;;
  }

  dimension: is_bounced_session {
    type: yesno
    group_label: "Behavior"
    description: "Indicates whether the session was a bounce (Yes/No). A bounce is typically a session with only one page view or interaction."
    sql: ${TABLE}.is_bounced_session ;;
  }

  dimension: is_converted_user {
    type: yesno
    group_label: "Behavior"
    description: "Indicates (Yes/No) whether the user associated with this session (blended_user_id) has ever performed a defined conversion action."
    sql: ${TABLE}.is_converting_blended_user_id ;;
  }

  dimension: is_converting_session {
    type: yesno
    group_label: "Behavior"
    description: "Indicates (Yes/No) whether a defined conversion event occurred during this specific session."
    sql: ${TABLE}.is_conversion_session ;;
  }

  dimension: last_page_category {
    type: string
    label: "Exit Page Category"
    group_label: "Behavior"
    description: "A predefined category for the last page (exit page) viewed in the session, based on its URL. Examples include '01: Blog', '01: Podcast', '01: Home Page', '04: Service'."
    sql: case when ${last_page_url} like '%blog%' or ${last_page_url} like '%rittmananalytics.com/202%' then '01: Blog'
                  when ${last_page_url} like '%drilltodetail%' or ${last_page_url} like '%podcast%' then '01: Podcast'
                  when ${last_page_url} = '/' or ${last_page_url} like '%home-index%' then '01: Home Page'
                  when ${last_page_url} like '%/services/%' or ${last_page_url} like '%/offers/%' then '04: Service'
                  when ${last_page_url} like '%/about/%' or ${last_page_url} like '%/contact%' or ${last_page_url} like '%/faqs/%' or ${last_page_url} like '%scv-contact-us-form%' then '08: Contact'
                  when ${last_page_url} like '%sidebar%' then 'Misc'
                  when ${last_page_url} like '%/assistant%' then '06: Assistant'
                  when ${last_page_url} like '%/pricing%' or ${last_page_url} like '%/engagement-model%' or ${last_page_url} like '%/how-we-work%' then '12: Commercials'
                  when ${last_page_url} like '%scv-thank-you%' or ${last_page_url} like '%/modern-data-stack-thank-you%' then '08: Goal Achieved'
                  when ${last_page_url} like '%causal-analytics%' or ${last_page_url} like '/scv-download-hubspot-form' then '02: Landing Page'
                  when ${last_page_url} like '%causal-analytics-video%' or ${last_page_url} like '%download-10-ways-your-modern-data-stack-can-fail%' or ${last_page_url} like '%download-page%' then '04: Gated Content'
                  when ${last_page_url} like '%industries%' or ${last_page_url} like '%about%' or ${last_page_url} like '%partners%'then '02: Marketing'
                  when ${last_page_url} like '%case-studies%' then '03: Case Study'
                  when ${last_page_url} like '%calendly%' then '06: Conversion'
              end ;;
  }

  dimension: last_page_title {
    type: string
    label: "Exit Page Title"
    group_label: "Behavior"
    description: "The title of the last page (exit page) viewed by the user before the session ended."
    sql: ${TABLE}.last_page_title ;;
  }

  dimension: last_page_url {
    type: string
    label: "Exit Page URL"
    group_label: "Behavior"
    description: "The full URL of the last page (exit page) viewed by the user before the session ended, with any trailing slash removed."
    sql: rtrim(${TABLE}.last_page_url,"/") ;;
  }

  dimension: last_page_url_host {
    type: string
    label: "Exit Page URL Host"
    group_label: "Behavior"
    description: "The hostname (e.g., 'www.example.com') of the last page (exit page) viewed in the session."
    sql: ${TABLE}.last_page_url_host ;;
  }

  dimension: last_page_url_path {
    type: string
    label: "Exit Page URL Path"
    group_label: "Behavior"
    description: "The path (e.g., '/contact-us') of the last page (exit page) viewed in the session, with any trailing slash removed."
    sql: rtrim(${TABLE}.last_page_url_path,"/") ;;
  }

  dimension: mins_between_sessions {
    type: number
    group_label: "Behavior"
    description: "The time in minutes between the start of this session and the end of the user's previous session. Null if this is the user's first session."
    sql: ${TABLE}.mins_between_sessions ;;
  }

  dimension: new_or_returning_user {
    group_label: "Audience"
    description: "Classifies the user as 'New' (if this is their first session, user_session_number = 1) or 'Returning' (if they have had previous sessions)."
    sql: case when ${user_session_number} = 1 then 'New' else 'Returning' end ;;
  }

  dimension: periods_ago {
    sql: FLOOR(DATE_DIFF(CURRENT_DATE(), DATE(${session_start_ts_raw}), DAY) / 30) ;;
  }

  dimension: referrer {
    type: string
    group_label: "Acquisition"
    description: "The URL of the page that linked the user to the website, excluding any query parameters."
    sql: split(${TABLE}.referrer, "?")[SAFE_OFFSET(0)] ;;
  }

  dimension: referrer_article_stub {
    group_label: "Acquisition"
    description: "If the referrer or first page URL points to a known article (e.g., from Medium or the Rittman Analytics blog), this field provides a unique identifier or slug for that article."
    sql: case when ${referrer_source} = 'Medium' and ${referrer_host} = 'blog.rittmananalytics.com' then split(${referrer},'/')[safe_offset(3)]
              when ${referrer_source} = 'Medium' and ${referrer_host} = 'medium.com' then split(${referrer},'/')[safe_offset(4)]
              when ${first_page_url} LIKE '%rittmananalytics.com/blog/2%' then SPLIT(${TABLE}.first_page_url_path,'/')[safe_OFFSET(5)]
          end ;;
  }

  dimension: referrer_days_since_post {
    group_label: "Acquisition"
    description: "The number of days between the first publication date of the referring content (if identified and linked to page_first_published) and the start of the current session."
    sql: timestamp_diff(${session_start_ts_raw},${page_first_published.page_first_session_start_ts_raw},DAY) ;;
  }

  dimension: referrer_days_since_post_tier {
    type: tier
    tiers: [1, 2, 3, 4, 5, 6, 7, 14, 28, 90, 180, 365, 730]
    style: integer
    group_label: "Acquisition"
    description: "Categorizes the 'Referrer Days Since Post' into predefined time intervals (1, 2, 3, 4, 5, 6, 7, 14, 28, 90, 180, 365, 730 days)."
    sql: ${web_sessions_fact.referrer_days_since_post} ;;
  }

  dimension: referrer_host {
    type: string
    group_label: "Acquisition"
    description: "The hostname (e.g., 'google.com', 'linkedin.com') of the website that referred the user."
    sql: ${TABLE}.referrer_host ;;
  }

  dimension: referrer_medium {
    type: string
    group_label: "Acquisition"
    description: "The medium of the referral source, often indicating how the user arrived (e.g., 'organic', 'cpc', 'referral', 'social'). This is typically the raw medium from the source data."
    sql: ${TABLE}.referrer_medium ;;
  }

  dimension: referrer_source {
    type: string
    group_label: "Acquisition"
    description: "The classified source of the referral traffic, based on the referrer URL or first page URL for certain internal sources. Categories include 'Medium', 'Github', 'LinkedIn', 'Organic Search', 'Twitter', 'Squarespace', 'Podcast', or 'Direct'."
    sql: case when ${referrer} like '%blog.rittmananalytics.com%' or ${referrer} like '%medium.com/mark-rittman%' then 'Medium'
              when ${referrer_host} like '%github%' then 'Github'
              when ${referrer_host} like '%linkedin%' then 'LinkedIn'
              when ${referrer_host} like '%google%' or ${referrer_host} like '%bing%' or  ${referrer_host} like '%yahoo%' or ${referrer_host} like '%yandex%' then 'Organic Search'
              when ${referrer_host} like '%t.co%' or ${referrer_host} like '%twitter%' then 'Twitter'
              when ${first_page_url} like '%rittmananalytics.com/blog%'  then 'Squarespace'
              when ${first_page_url} like '%https://rittmananalytics.com/drilltodetail%'  then 'Podcast'
              else 'Direct'
    end ;;
  }

  dimension: retail_month {
    sql: (select Retail_Month from ra-development.analytics_seed.retail_calendar c where c.`date` = date(session_start_ts)) ;;
  }

  dimension: retail_week {
    sql: (select Retail_Week from ra-development.analytics_seed.retail_calendar c where c.`date` = date(session_start_ts)) ;;
  }

  dimension: retail_year {
    sql: (select Retail_Year from ra-development.analytics_seed.retail_calendar c where c.`date` = date(session_start_ts)) ;;
  }

  dimension: search {
    type: string
    group_label: "Acquisition"
    description: "The search query or keywords used by the visitor if they arrived from a search engine. May be '(not provided)' or null for privacy reasons or non-search referrals."
    sql: ${TABLE}.search ;;
  }

  dimension: session_id {
    group_label: "Behavior"
    description: "A unique identifier for this specific web session."
    sql: ${TABLE}.session_id ;;
  }

  dimension: session_utm_campaign {
    label: "Session UTM Campaign"
    group_label: "Acquisition"
    description: "The UTM campaign parameter associated with this session, used to identify a specific promotion or strategic campaign (e.g., 'summer_sale', 'newsletter_q3'). Values are lowercased."
    sql: lower(${TABLE}.utm_campaign) ;;
  }

  dimension: session_utm_content {
    type: string
    label: "Session UTM Content"
    group_label: "Acquisition"
    description: "The UTM content parameter associated with this session, used to differentiate ads or links that point to the same URL (e.g., 'logolink', 'textlink')."
    sql: ${TABLE}.utm_content ;;
  }

  dimension: session_utm_medium {
    label: "Session UTM Medium"
    group_label: "Acquisition"
    description: "The UTM medium parameter associated with this session, indicating the advertising or marketing medium (e.g., 'cpc', 'banner', 'email'). Values are lowercased."
    sql: lower(${TABLE}.utm_medium) ;;
  }

  dimension: session_utm_source {
    label: "Session UTM Source"
    group_label: "Acquisition"
    description: "The UTM source parameter associated with this session, indicating the referrer or origin of the traffic (e.g., 'google', 'newsletter', 'linkedin'). Values are lowercased and common suffixes like '.com' or slashes are removed."
    sql: replace(replace(lower(${TABLE}.utm_source),'/',''),'.com','') ;;
  }

  dimension: session_utm_term {
    type: string
    group_label: "Acquisition"
    description: "The UTM term (keyword) parameter associated with this session, typically used to identify paid search keywords."
    sql: ${TABLE}.utm_term ;;
  }

  dimension: user_session_number {
    type: number
    group_label: "Audience"
    description: "A sequential number indicating which session this is for the user (e.g., 1 for the first session, 2 for the second)."
    sql: ${TABLE}.user_session_number ;;
  }

  dimension: web_sessions_pk {
    primary_key: yes
    type: string
    description: "The primary key uniquely identifying each web session record. Hidden by default."
    hidden: yes
    sql: ${TABLE}.web_sessions_pk ;;
  }

  dimension_group: session_end_ts {
    type: time
    timeframes: [raw, date, week, month, year, day_of_week, day_of_year, month_num]
    label: "Session End"
    group_label: "Dates"
    description: "The exact date and time when the user's session ended."
    sql: ${TABLE}.session_end_ts ;;
  }

  dimension_group: session_start_ts {
    type: time
    timeframes: [raw, date, week, month, year, day_of_week, day_of_year, month_num]
    label: "Session Start"
    group_label: "Dates"
    description: "The exact date and time when the user's session began."
    sql: ${TABLE}.session_start_ts ;;
  }

  measure: bounced_session_rate {
    type: number
    label: "Bounced Session Rate"
    description: "The percentage of sessions that were bounces, calculated as (bounced sessions / total sessions)."
    value_format_name: percent_2
    sql: SAFE_DIVIDE(COUNT(DISTINCT(case when ${is_bounced_session} = TRUE then ${web_sessions_pk} end)),${total_sessions}) ;;
  }

  measure: count_of_events {
    type: sum
    description: "The total sum of all recorded events across the selected sessions."
    sql: ${events} ;;
  }

  measure: total_session_duration_in_s {
    type: average
    label: "Avg Session Duration (mins)"
    description: "The average duration of user sessions, calculated in minutes from session start to session end. Displayed in mm:ss format."
    sql: timestamp_diff(${TABLE}.session_end_ts,${TABLE}.session_start_ts,MINUTE) ;;
  }

  measure: total_sessions {
    type: count_distinct
    label: "Total Sessions"
    description: "The total number of unique web sessions based on the web_sessions_pk."
    sql: ${web_sessions_pk} ;;
  }
}
