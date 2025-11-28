view: web_sessions_fact {
  sql_table_name: `{{ _user_attributes['dataset'] }}.web_sessions_fact`
    ;;

  dimension: retail_week {
    type: number
    sql: (select Retail_Week from ra-development.analytics_seed.retail_calendar c where c.`date` = date(${TABLE}.session_start_ts)) ;;
  }

  dimension: retail_month {
    type: number
    sql: (select Retail_Month from ra-development.analytics_seed.retail_calendar c where c.`date` = date(${TABLE}.session_start_ts)) ;;
  }

  dimension: retail_year {
    type: number
    sql: (select Retail_Year from ra-development.analytics_seed.retail_calendar c where c.`date` = date(${TABLE}.session_start_ts)) ;;
  }

  # --- POP HYBRID LOGIC START ---

  # 1. The Selector
  # This serves as the primary "Filter" for the user.
  parameter: period_selector {
    type: string
    label: "Period Selector"
    description: "Select a Retail Period or choose 'Custom Range' to pick specific dates."
    allowed_value: { label: "This Retail Week" value: "this_retail_week" }
    allowed_value: { label: "Last Retail Week" value: "last_retail_week" }
    allowed_value: { label: "Last Retail Month" value: "last_retail_month" }
    allowed_value: { label: "Last Retail Year" value: "last_retail_year" }
    allowed_value: { label: "Custom Range" value: "custom" }
    default_value: "this_retail_week"
  }

  # 2. The Custom Date Filter
  # Only used when period_selector = 'Custom Range'
  filter: date_filter {
    type: date
    label: "Custom Date Range"
    description: "Select dates here ONLY if 'Custom Range' is selected above."
  }

  # 3. The Logic Engine
  # Uses Liquid to generate different SQL based on the user's selection
  dimension: period {
    type: string
    description: "Categorizes rows into Current vs Prior based on the Selector."
    sql:
      CASE
        /* ---------------------------------------------------------
           SCENARIO 1: CUSTOM DATE RANGE
           (Uses standard Calendar Dates)
           --------------------------------------------------------- */
        {% if period_selector._parameter_value == "'custom'" %}

      -- Current Period (Calendar)
      WHEN ${session_start_ts_raw} >= {% date_start date_filter %}
      AND ${session_start_ts_raw} < {% date_end date_filter %}
      THEN 'Current Period'

      -- Prior Year (Calendar - Shifted back 1 Year)
      WHEN ${session_start_ts_raw} >= TIMESTAMP(DATETIME_SUB(DATETIME({% date_start date_filter %}), INTERVAL 1 YEAR))
      AND ${session_start_ts_raw} < TIMESTAMP(DATETIME_SUB(DATETIME({% date_end date_filter %}), INTERVAL 1 YEAR))
      THEN 'Prior Year'

      /* ---------------------------------------------------------
      SCENARIO 2: RETAIL PERIODS
      (Uses Retail Year/Month/Week Columns)
      --------------------------------------------------------- */
      {% else %}

      /* --- CURRENT PERIOD LOGIC --- */
      WHEN
      {% if period_selector._parameter_value == "'this_retail_week'" %}
      ${retail_year} = (SELECT Retail_Year FROM ra-development.analytics_seed.retail_calendar WHERE date = CURRENT_DATE)
      AND ${retail_week} = (SELECT Retail_Week FROM ra-development.analytics_seed.retail_calendar WHERE date = CURRENT_DATE)
      {% elsif period_selector._parameter_value == "'last_retail_week'" %}
      ${retail_year} = (SELECT Retail_Year FROM ra-development.analytics_seed.retail_calendar WHERE date = DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY))
      AND ${retail_week} = (SELECT Retail_Week FROM ra-development.analytics_seed.retail_calendar WHERE date = DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY))
      {% elsif period_selector._parameter_value == "'last_retail_month'" %}
      ${retail_year} = (SELECT Retail_Year FROM ra-development.analytics_seed.retail_calendar WHERE date = DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))
      AND ${retail_month} = (SELECT Retail_Month FROM ra-development.analytics_seed.retail_calendar WHERE date = DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))
      {% elsif period_selector._parameter_value == "'last_retail_year'" %}
      -- "Last Retail Year" usually means the full previous completed year.
      ${retail_year} = (SELECT Retail_Year FROM ra-development.analytics_seed.retail_calendar WHERE date = CURRENT_DATE) - 1
      {% endif %}
      THEN 'Current Period'

      /* --- PRIOR YEAR LOGIC --- */
      /* We match the exact same criteria as above, but subtract 1 from the Retail Year */
      WHEN
      {% if period_selector._parameter_value == "'this_retail_week'" %}
      ${retail_year} = (SELECT Retail_Year FROM ra-development.analytics_seed.retail_calendar WHERE date = CURRENT_DATE) - 1
      AND ${retail_week} = (SELECT Retail_Week FROM ra-development.analytics_seed.retail_calendar WHERE date = CURRENT_DATE)
      {% elsif period_selector._parameter_value == "'last_retail_week'" %}
      ${retail_year} = (SELECT Retail_Year FROM ra-development.analytics_seed.retail_calendar WHERE date = DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY)) - 1
      AND ${retail_week} = (SELECT Retail_Week FROM ra-development.analytics_seed.retail_calendar WHERE date = DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY))
      {% elsif period_selector._parameter_value == "'last_retail_month'" %}
      ${retail_year} = (SELECT Retail_Year FROM ra-development.analytics_seed.retail_calendar WHERE date = DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) - 1
      AND ${retail_month} = (SELECT Retail_Month FROM ra-development.analytics_seed.retail_calendar WHERE date = DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))
      {% elsif period_selector._parameter_value == "'last_retail_year'" %}
      ${retail_year} = (SELECT Retail_Year FROM ra-development.analytics_seed.retail_calendar WHERE date = CURRENT_DATE) - 2
      {% endif %}
      THEN 'Prior Year'

      {% endif %}

      ELSE NULL
      END ;;
  }

  # 4. Normalized Date (For Charting)
  # This works the same for both scenarios:
  # It takes whatever fell into the 'Prior Year' bucket and shifts it forward 1 year
  # so it overlays on the chart.
  dimension_group: period_normalized {
    label: "Chart Date"
    type: time
    timeframes: [date, week, month]
    sql:
      CASE
        WHEN ${period} = 'Current Period' THEN ${session_start_ts_raw}
        WHEN ${period} = 'Prior Year' THEN TIMESTAMP(DATETIME_ADD(DATETIME(${session_start_ts_raw}), INTERVAL 1 YEAR))
      END ;;
  }
  # --- POP HYBRID LOGIC END ---

  parameter: time_range {
    type: string
    description: "Select a predefined time period to filter the data. Values represent the number of past days to include."
    allowed_value: {
      label: "Last 7 Days"
      value: "7"
    }
    allowed_value: {
      label: "Last 30 Days"
      value: "30"
    }
    allowed_value: {
      label: "Last 90 Days"
      value: "90"
    }
    allowed_value: {
      label: "Last 180 days"
      value: "180"
    }
    allowed_value: {
      label: "Last 365 days"
      value: "365"
    }
  }



  dimension: blended_user_id {
    group_label: "  Audience"
    description: "A unique identifier for a user, potentially unified across different platforms or tracking mechanisms."
    hidden: no
    type: string
    sql: ${TABLE}.blended_user_id ;;
  }

  dimension: company_name {
    group_label: "  Audience"
    type: string
    sql: ${TABLE}.company_name ;;
  }

  dimension: device {
    group_label: "  Audience"
    description: "The specific type of device, operating system, and browser used to access the website (e.g., 'iPhone; CPU iPhone OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.5 Mobile/15E148 Safari/604.1')."
    type: string
    sql: ${TABLE}.device ;;
  }

  dimension: device_category {
    group_label: "  Audience"
    description: "The general type or brand of the device, such as 'iPhone', 'Android', 'iPad', or 'Windows'. This is a simplified version of the 'Device' field."
    type: string
    sql: ${TABLE}.device_category ;;
  }

  dimension: duration_in_s {
    group_label: "Behavior"
    description: "The total duration of the web session in seconds."
    type: number
    sql: ${TABLE}.duration_in_s ;;
  }

  dimension: duration_in_s_tier {
    group_label: "Behavior"
    description: "Categorizes session duration (in seconds) into predefined time buckets."
    type: string
    sql: ${TABLE}.duration_in_s_tier ;;
  }

  dimension: referrer {
    group_label: "    Acquisition"
    description: "The URL of the page that linked the user to the website, excluding any query parameters."
    type: string
    sql: split(${TABLE}.referrer, "?")[SAFE_OFFSET(0)] ;;
  }

  dimension: referrer_source {
    group_label: "    Acquisition"
    description: "The classified source of the referral traffic, based on the referrer URL or first page URL for certain internal sources. Categories include 'Medium', 'Github', 'LinkedIn', 'Organic Search', 'Twitter', 'Squarespace', 'Podcast', or 'Direct'."
    type: string
    sql: case when ${referrer} like '%blog.rittmananalytics.com%' or ${referrer} like '%medium.com/mark-rittman%' then 'Medium'
              when ${referrer_host} like '%github%' then 'Github'
              when ${referrer_host} like '%linkedin%' then 'LinkedIn'
              when ${referrer_host} like '%google%' or ${referrer_host} like '%bing%' or  ${referrer_host} like '%yahoo%' or ${referrer_host} like '%yandex%' then 'Organic Search'
              when ${referrer_host} like '%t.co%' or ${referrer_host} like '%twitter%' then 'Twitter'
              when ${first_page_url} like '%rittmananalytics.com/blog%'  then 'Squarespace'
              when ${first_page_url} like '%https://rittmananalytics.com/drilltodetail%'  then 'Podcast'
              else 'Direct'
    end;;
  }

  dimension: referrer_article_stub {
    group_label: "    Acquisition"
    description: "If the referrer or first page URL points to a known article (e.g., from Medium or the Rittman Analytics blog), this field provides a unique identifier or slug for that article."
    type: string
    sql: case when ${referrer_source} = 'Medium' and ${referrer_host} = 'blog.rittmananalytics.com' then split(${referrer},'/')[safe_offset(3)]
              when ${referrer_source} = 'Medium' and ${referrer_host} = 'medium.com' then split(${referrer},'/')[safe_offset(4)]
              when ${first_page_url} LIKE '%rittmananalytics.com/blog/2%' then SPLIT(first_page_url_path,'/')[safe_OFFSET(5)]
          end ;;
  }

  dimension: referrer_days_since_post {
    group_label: "    Acquisition"
    description: "The number of days between the first publication date of the referring content (if identified and linked to page_first_published) and the start of the current session."
    type: number
    sql: timestamp_diff(${session_start_ts_raw},${page_first_published.page_first_session_start_ts_raw},DAY)  ;;
  }

  dimension: referrer_days_since_post_tier {
    type: tier
    group_label: "    Acquisition"
    description: "Categorizes the 'Referrer Days Since Post' into predefined time intervals (1, 2, 3, 4, 5, 6, 7, 14, 28, 90, 180, 365, 730 days)."
    tiers: [1,2,3,4,5,6,7,14,28,90,180,365,730]
    sql: ${referrer_days_since_post} ;;
    style: interval
  }

  dimension: events {
    group_label: "Behavior"
    label: "Session Events"
    description: "The total count of tracked events (e.g., page views, clicks) that occurred during this specific session."
    type: number
    sql: ${TABLE}.events ;;
  }

  measure: count_of_events {
    description: "The total sum of all recorded events across the selected sessions."
    type: sum
    sql: ${events} ;;
  }

  dimension: first_page_title {
    label: "Entrance Page Title"
    group_label: "Behavior"
    description: "The title of the first page (entrance page) viewed by the user during this session."
    type: string
    sql: ${TABLE}.first_page_title ;;
  }

  dimension: first_page_category {
    label: "Entrance Page Category"
    group_label: "Behavior"
    description: "A predefined category for the first page (entrance page) viewed in the session, based on its URL or title. Examples include '01: Blog', '01: Podcast', '01: Home Page', '04: Service'."
    type: string
    sql:
              case when ${TABLE}.first_page_url like '%blog%' or ${TABLE}.first_page_url like '%rittmananalytics.com/202%' or  ${TABLE}.first_page_title like '%Videos — Rittman Analytics%' then '01: Blog'
                  when ${TABLE}.first_page_url like '%drilltodetail%' or ${TABLE}.first_page_url like '%podcast%' then '01: Podcast'
                  when ${TABLE}.first_page_url = '/' or ${TABLE}.first_page_url like '%home-index%' or ${TABLE}.first_page_title like '%Scale your Analytics — Rittman Analytics%' then '01: Home Page'
                  when ${TABLE}.first_page_url like '%/services/%' or ${TABLE}.first_page_url like '%/offers/%' or ${TABLE}.first_page_title like '%Project Discovery — Rittman Analytics%' or ${TABLE}.first_page_title like '%Looker GenAI — Rittman Analytics%' or ${TABLE}.first_page_title like '%Looker Jumpstart — Rittman Analytics%' or ${TABLE}.first_page_title like '%Generative AI — Rittman Analytics%' then '04: Service'
                  when ${TABLE}.first_page_url like '%/about/%' or ${TABLE}.first_page_url like '%/contact%' or ${TABLE}.first_page_url like '%/faqs/%' or ${TABLE}.first_page_url like '%scv-contact-us-form%' then '08: Contact'
                  when ${TABLE}.first_page_url like '%sidebar%' then 'Misc'
                  when ${TABLE}.first_page_url like '%/assistant%' then '06: Assistant'
                  when ${TABLE}.first_page_url like '%/pricing%' or ${TABLE}.first_page_url like '%/engagement-model%' or ${TABLE}.first_page_url like '%/how-we-work%' then '12: Commercials'
                  when ${TABLE}.first_page_url like '%scv-thank-you%' or ${TABLE}.first_page_url like '%/modern-data-stack-thank-you%' then '08: Goal Achieved'
                  when ${TABLE}.first_page_url like '%causal-analytics%' or ${TABLE}.first_page_url like '/scv-download-hubspot-form' then '02: Landing Page'
                  when ${TABLE}.first_page_url like '%causal-analytics-video%' or ${TABLE}.first_page_url like '%download-10-ways-your-modern-data-stack-can-fail%' or ${TABLE}.first_page_url like '%download-page%' then '04: Gated Content'
                  when ${TABLE}.first_page_url like '%industries%' or ${TABLE}.first_page_url like '%about%' or ${TABLE}.first_page_url like '%partners%' or ${TABLE}.first_page_title like '%Data Analytics Project Checklist — Rittman Analytics%' then '02: Marketing'
                  when ${TABLE}.first_page_url like '%case-studies%' then '03: Case Study'
                  when ${TABLE}.first_page_url like '%calendly%' then '06: Conversion'
              end
         ;;
  }

  dimension: first_page_url {
    label: "Entrance Page URL"
    group_label: "Behavior"
    description: "The full URL of the first page (entrance page) viewed by the user during this session, with any trailing slash removed."
    type: string
    sql: rtrim(${TABLE}.first_page_url,"/") ;;
  }

  dimension: first_page_url_host {
    hidden: yes
    group_label: "Behavior"
    description: "The hostname (e.g., 'www.example.com') of the first page (entrance page) viewed in the session. Hidden by default."
    type: string
    sql: ${TABLE}.first_page_url_host ;;
  }

  dimension: first_page_url_path {
    hidden: yes
    description: "The path (e.g., '/blog/article-name') of the first page (entrance page) viewed in the session, with any trailing slash removed. Hidden by default."
    type: string
    sql: rtrim(${TABLE}.first_page_url_path,"/") ;;
  }

  dimension: gclid {
    hidden: yes
    description: "Google Click Identifier (GCLID), used for tracking clicks from Google Ads. Hidden by default."
    type: string
    sql: ${TABLE}.gclid ;;
  }

  dimension: is_bounced_session {
    group_label: "Behavior"
    description: "Indicates whether the session was a bounce (Yes/No). A bounce is typically a session with only one page view or interaction."
    type: yesno
    sql: ${TABLE}.is_bounced_session ;;
  }

  dimension: last_page_title {
    group_label: "Behavior"
    label: "Exit Page Title"
    description: "The title of the last page (exit page) viewed by the user before the session ended."
    type: string
    sql: ${TABLE}.last_page_title ;;
  }

  dimension: last_page_url {
    group_label: "Behavior"
    label: "Exit Page URL"
    description: "The full URL of the last page (exit page) viewed by the user before the session ended, with any trailing slash removed."
    type: string
    sql: rtrim(${TABLE}.last_page_url,"/") ;;
  }

  dimension: last_page_category {
    label: "Exit Page Category"
    group_label: "Behavior"
    description: "A predefined category for the last page (exit page) viewed in the session, based on its URL. Examples include '01: Blog', '01: Podcast', '01: Home Page', '04: Service'."
    type: string
    sql:
              case when ${TABLE}.last_page_url like '%blog%' or ${TABLE}.last_page_url like '%rittmananalytics.com/202%' then '01: Blog'
                  when ${TABLE}.last_page_url like '%drilltodetail%' or ${TABLE}.last_page_url like '%podcast%' then '01: Podcast'
                  when ${TABLE}.last_page_url = '/' or ${TABLE}.last_page_url like '%home-index%' then '01: Home Page'
                  when ${TABLE}.last_page_url like '%/services/%' or ${TABLE}.last_page_url like '%/offers/%' then '04: Service'
                  when ${TABLE}.last_page_url like '%/about/%' or ${TABLE}.last_page_url like '%/contact%' or ${TABLE}.last_page_url like '%/faqs/%' or ${TABLE}.last_page_url like '%scv-contact-us-form%' then '08: Contact'
                  when ${TABLE}.last_page_url like '%sidebar%' then 'Misc'
                  when ${TABLE}.last_page_url like '%/assistant%' then '06: Assistant'
                  when ${TABLE}.last_page_url like '%/pricing%' or ${TABLE}.last_page_url like '%/engagement-model%' or ${TABLE}.last_page_url like '%/how-we-work%' then '12: Commercials'
                  when ${TABLE}.last_page_url like '%scv-thank-you%' or ${TABLE}.last_page_url like '%/modern-data-stack-thank-you%' then '08: Goal Achieved'
                  when ${TABLE}.last_page_url like '%causal-analytics%' or ${TABLE}.last_page_url like '/scv-download-hubspot-form' then '02: Landing Page'
                  when ${TABLE}.last_page_url like '%causal-analytics-video%' or ${TABLE}.last_page_url like '%download-10-ways-your-modern-data-stack-can-fail%' or ${TABLE}.last_page_url like '%download-page%' then '04: Gated Content'
                  when ${TABLE}.last_page_url like '%industries%' or ${TABLE}.last_page_url like '%about%' or ${TABLE}.last_page_url like '%partners%'then '02: Marketing'
                  when ${TABLE}.last_page_url like '%case-studies%' then '03: Case Study'
                  when ${TABLE}.last_page_url like '%calendly%' then '06: Conversion'
              end
         ;;
  }

  dimension: last_page_url_host {
    label: "Exit Page URL Host"
    group_label: "Behavior"
    description: "The hostname (e.g., 'www.example.com') of the last page (exit page) viewed in the session."
    type: string
    sql: ${TABLE}.last_page_url_host ;;
  }

  dimension: last_page_url_path {
    label: "Exit Page URL Path"
    group_label: "Behavior"
    description: "The path (e.g., '/contact-us') of the last page (exit page) viewed in the session, with any trailing slash removed."
    type: string
    sql: rtrim(${TABLE}.last_page_url_path,"/") ;;
  }

  dimension: mins_between_sessions {
    group_label: "Behavior"
    description: "The time in minutes between the start of this session and the end of the user's previous session. Null if this is the user's first session."
    type: number
    sql: ${TABLE}.mins_between_sessions ;;
  }

  dimension: referrer_host {
    group_label: "    Acquisition"
    description: "The hostname (e.g., 'google.com', 'linkedin.com') of the website that referred the user."
    type: string
    sql: ${TABLE}.referrer_host ;;
  }

  dimension: referrer_medium {
    group_label: "    Acquisition"
    description: "The medium of the referral source, often indicating how the user arrived (e.g., 'organic', 'cpc', 'referral', 'social'). This is typically the raw medium from the source data."
    type: string
    sql: ${TABLE}.referrer_medium ;;
  }

  dimension: search {
    group_label: "    Acquisition"
    description: "The search query or keywords used by the visitor if they arrived from a search engine. May be '(not provided)' or null for privacy reasons or non-search referrals."
    type: string
    sql: ${TABLE}.search ;;
  }

  dimension_group: session_end_ts {
    group_label: "Dates"
    label: "Session End"
    description: "The exact date and time when the user's session ended."
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
    sql: ${TABLE}.session_end_ts ;;
  }

  dimension: session_id {
    group_label: "Behavior"
    description: "A unique identifier for this specific web session."
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension_group: session_start_ts {
    group_label: "Dates"
    label: "Session Start"
    description: "The exact date and time when the user's session began."
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
    sql: ${TABLE}.session_start_ts ;;
  }

  dimension: periods_ago {
  type: number
  sql: FLOOR(DATE_DIFF(CURRENT_DATE(), DATE(${session_start_ts_raw}), DAY) / 30);;
  }

  measure: total_session_duration_in_s {
    description: "The average duration of user sessions, calculated in minutes from session start to session end. Displayed in mm:ss format."
    type: average
    label: "Avg Session Duration (mins)"
    value_format: "mm:ss"
    sql: timestamp_diff(${TABLE}.session_end_ts,${TABLE}.session_start_ts,MINUTE) ;;
  }

  measure: total_sessions {
    label: "Total Sessions"
    description: "The total number of unique web sessions based on the web_sessions_pk."
    type: count_distinct
    sql: ${web_sessions_pk} ;;
  }

  measure: bounced_session_rate {
    label: "Bounced Session Rate"
    description: "The percentage of sessions that were bounces, calculated as (bounced sessions / total sessions)."
    type: number
    value_format: "0.00%"
    sql: SAFE_DIVIDE(COUNT(DISTINCT(case when ${is_bounced_session} = TRUE then ${web_sessions_pk} end)),${total_sessions})  ;;
  }

  dimension: user_session_number {
    group_label: "  Audience"
    description: "A sequential number indicating which session this is for the user (e.g., 1 for the first session, 2 for the second)."
    type: number
    sql: ${TABLE}.user_session_number ;;
  }

  dimension: new_or_returning_user {
    group_label: "  Audience"
    description: "Classifies the user as 'New' (if this is their first session, user_session_number = 1) or 'Returning' (if they have had previous sessions)."
    type: string
    sql: case when ${TABLE}.user_session_number = 1 then 'New' else 'Returning' end ;;
  }

  dimension: web_sessions_pk {
    hidden: yes
    primary_key: yes
    description: "The primary key uniquely identifying each web session record. Hidden by default."
    type: string
    sql: ${TABLE}.web_sessions_pk ;;
  }

  dimension: is_converted_user {
    group_label: "Behavior"
    description: "Indicates (Yes/No) whether the user associated with this session (blended_user_id) has ever performed a defined conversion action."
    type: yesno
    sql: ${TABLE}.is_converting_blended_user_id ;;
  }

  dimension: is_converting_session {
    group_label: "Behavior"
    description: "Indicates (Yes/No) whether a defined conversion event occurred during this specific session."
    type: yesno
    sql: ${TABLE}.is_conversion_session ;;
  }

  dimension: channel {
    group_label: " Acquisition"
    description: "The marketing channel attributed to this session, determined by custom logic using UTM parameters and referrer information. Examples include 'Paid Social', 'Organic Social', 'Organic Search', 'Referral', 'Direct'."
    type: string
    sql: case when ${session_utm_source} in ('linkedin','facebook') and ${session_utm_medium} = 'paid' then 'Paid Social'
              when (${session_utm_source} = 'linkedin' or ${referrer_host} like '%linkedin%') and ${session_utm_medium} != 'paid' then 'Organic Social'
              when ${TABLE}.channel = 'Social' then 'Organic Social'
              when ${TABLE}.channel in ('facebook','linkedin') and ${session_utm_medium} = 'social' then 'Organic Social'
              when ${session_utm_medium} = 'social' and ${TABLE}.channel = 'Direct' then 'Organic Social'
              when ${session_utm_source} = 'substack' and ${session_utm_medium} != 'email' then 'Organic Social'
              when ${session_utm_source} like 'pocket_%' then 'Referral'
              when (${referrer_host} like '%rittmananalytics.com%' and ${referrer_host} not like '%blog.rittmananalytics.com%') or ${referrer_host} like 'calendly.com' then 'Direct'
              when ${referrer_host} like '%medium.com%' or ${referrer_host} like '%blog.rittmananalytics.com%'  then 'Organic Social'
              else ${TABLE}.channel end;;
  }

  dimension: channel_category {
    group_label: " Acquisition"
    description: "A higher-level grouping of the marketing channel. 'Paid' includes paid social and paid search; 'Organic' includes organic social, video, search, email, and referrals. Other channels retain their name."
    type: string
    sql: case when ${channel} in ('Paid Social','Paid Search') then 'Paid'
              when ${channel} in ('Organic Social','Organic Video','Organic Search','Email','Referral') then 'Organic'
              else ${channel} end;;
  }

  dimension: session_utm_campaign {
    group_label: " Acquisition"
    description: "The UTM campaign parameter associated with this session, used to identify a specific promotion or strategic campaign (e.g., 'summer_sale', 'newsletter_q3'). Values are lowercased."
    type: string
    label: "Session UTM Campaign"
    sql: lower(${TABLE}.utm_campaign) ;;
  }

  dimension: session_utm_content {
    group_label: " Acquisition"
    description: "The UTM content parameter associated with this session, used to differentiate ads or links that point to the same URL (e.g., 'logolink', 'textlink')."
    label: "Session UTM Content"
    type: string
    sql: ${TABLE}.utm_content ;;
  }

  dimension: session_utm_medium {
    group_label: " Acquisition"
    description: "The UTM medium parameter associated with this session, indicating the advertising or marketing medium (e.g., 'cpc', 'banner', 'email'). Values are lowercased."
    label: "Session UTM Medium"
    type: string
    sql: lower(${TABLE}.utm_medium) ;;
  }

  dimension: session_utm_source {
    group_label: " Acquisition"
    description: "The UTM source parameter associated with this session, indicating the referrer or origin of the traffic (e.g., 'google', 'newsletter', 'linkedin'). Values are lowercased and common suffixes like '.com' or slashes are removed."
    label: "Session UTM Source"
    type: string
    sql: replace(replace(lower(${TABLE}.utm_source),'/',''),'.com','') ;;
  }

  dimension: session_utm_term {
    group_label: " Acquisition"
    description: "The UTM term (keyword) parameter associated with this session, typically used to identify paid search keywords."
    type: string
    sql: ${TABLE}.utm_term ;;
  }
}
