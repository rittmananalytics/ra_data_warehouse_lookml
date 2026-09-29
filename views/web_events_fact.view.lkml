view: web_events_fact {
  derived_table: {
    sql: select * except(page_title),
              replace(page_title,'—','-') as page_title,
              min(event_ts) over (partition by site, replace(page_title,'—','-') order by event_ts) as page_title_published_at_ts,
              date_diff(date(event_ts),date(min(event_ts) over (partition by site, replace(page_title,'—','-') order by event_ts)), month) as months_since_page_title_published_at_ts,
              date_diff(date(event_ts),date(min(event_ts) over (partition by site, replace(page_title,'—','-') order by event_ts)), day) as days_since_page_title_published_at_ts,
              count(distinct case when event_type = 'Page View' then web_events_pk end) over (partition by site, replace(page_title,'—','-')) as total_page_views,
              count(distinct blended_user_id) over (partition by site, replace(page_title,'—','-')) as total_unique_viewers
       from web_events_fact;;
  }


  dimension: device {
    group_label: "  Audience"
    hidden:  yes
    description: "The operating system or device family used when this event was recorded (e.g., 'Macintosh', 'Windows', 'iPhone', 'Android', 'X11' for Linux and Chrome OS). Hidden by default."
    type: string
    sql: ${TABLE}.device ;;
  }

  dimension: device_category {
    hidden: yes
    group_label: "  Audience"
    description: "The general class of device used when this event was recorded: 'Desktop', 'iPhone', 'Android', 'Tablet' or 'Uncategorized'. Derived from the 'Device' field. Hidden by default."
    type: string
    sql: ${TABLE}.device_category ;;
  }



  dimension: event_details {
    group_label: "Behavior"
    description: "Additional details for the event, if any. For clicks this is the link or menu item text; for careers-site job applications it is the role applied for."
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
    description: "The type of user interaction or system event recorded (e.g., 'Page View', 'Navigation Clicked', 'Outbound Link Clicked', 'Meeting Booked'). Careers-site form submissions are 'Job Application Submitted', 'Talent Community Joined', 'Candidate Profile Updated', 'Candidate Logged In' or 'Candidate Data Removal Requested'."
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

  dimension: longitude {
    hidden: yes
    description: "The geographic longitude of the event's origin. Hidden by default, used by 'map_location'."
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: page_title {
    group_label: "Behavior"
    description: "The title of the web page on which the event occurred. Dashes ('—') are replaced with hyphens ('-') for consistency."
    type: string
    sql: ${TABLE}.page_title ;;
  }

  dimension_group: page_published {
    group_label: "Behavior"
    description: "The date and time when the content of this page (identified by its site and title) was first observed/published, based on the earliest event recorded for this page title."
    type: time
    timeframes: [date,month,quarter,year]
    sql: ${TABLE}.page_title_published_at_ts ;;
  }

  dimension: months_since_page_published {
    group_label: "Behavior"
    description: "The number of full months between when this page (identified by its site and title) was first published/observed and when this specific event occurred on it."
    type: number
    sql: ${TABLE}.months_since_page_title_published_at_ts ;;
  }

  dimension: page_total_page_views {
    group_label: "Behavior"
    description: "The total number of 'Page View' events ever recorded for this page title on this site (across all users and sessions) up to the latest data point. Calculated in the derived table."
    type: number
    sql: ${TABLE}.total_page_views ;;
  }

  dimension: page_total_unique_viewers {
    group_label: "Behavior"
    description: "The total number of unique users (blended_user_id) who have ever generated an event for this page title on this site up to the latest data point. Calculated in the derived table."
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
    description: "A predefined category assigned to the page where the event occurred, based on URL structure or content type (e.g., '02: Social', '08: Services'). All careers-site pages are '18: Careers'."
    type: string
    sql: ${TABLE}.computed_page_category;;
  }

  dimension: visit_value {
    type: number
    hidden: no
    description: "A numerical score assigned to the event. Conversion events ('Meeting Booked') receive a value of 16; other events are valued based on the numerical prefix of their page_category. Careers-site events have no value."
    sql: case when ${is_careers_site} then null
              when ${is_conversion_event} then 16
              else safe_cast(split(${TABLE}.page_category,":")[SAFE_OFFSET(0)] as int64) end;;
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

  measure: total_sessions {
    value_format_name: decimal_0
    type: count_distinct
    sql: ${session_id} ;;
  }

  measure: total_session_conversions {
    description: "The total number of unique sessions that included at least one 'Meeting Booked' event."
    value_format_name: decimal_0
    type: count_distinct
    sql: ${session_id} ;;
    filters: [is_conversion_event: "Yes"]
  }

  measure: total_blended_user_id {
    value_format_name: decimal_0
    type: count_distinct
    sql: ${blended_user_id} ;;
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

  dimension: search {
    group_label: "    Acquisition"
    hidden: yes
    description: "The query string of the page URL for this event (e.g., '?utm_source=linkedin'). Hidden by default."
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
    description: "The website on which the event occurred: 'rittmananalytics.com' for the company website, 'careers.rittmananalytics.com' for the Teamtailor careers site."
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
    description: "A unique identifier for a user, potentially unified across different platforms or tracking mechanisms, associated with this event. Hidden by default. Careers-site visitors have a separate ID from the company website."
    type: string
    sql: ${TABLE}.blended_user_id ;;
  }

  measure: total_careers_link_clicks {
    hidden: no
    group_label: "Recruitment"
    label: "Total Careers Menu Clicks"
    description: "Clicks on the Careers link in the company website menu, footer or mobile menu. Recorded as 'Navigation Clicked' until Aug 2026 and from 25 Sep 2026 (menu links to /careers), and as 'Outbound Link Clicked' from 25 Aug to 25 Sep 2026 (menu linked to the careers site)."
    type: count_distinct
    value_format_name: decimal_0
    sql: ${web_events_pk} ;;
    filters: [careers_funnel_stage: "1. Careers menu click"]
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

  dimension: user_id {
    hidden: no
    description: "A user identifier, which might be specific to a certain platform or tracking system before blending (see blended_user_id)."
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: utm_campaign {
    group_label: "    Acquisition"
    label: "Event UTM Campaign"
    description: "The UTM campaign parameter value on the page URL for this event (e.g., 'careers_page')."
    type: string
    sql: ${TABLE}.utm_campaign ;;
  }

  dimension: utm_content {
    group_label: "    Acquisition"
    label: "Event UTM Content"
    description: "The UTM content parameter value on the page URL for this event, used to tell links apart (e.g., 'open_vacancies')."
    type: string
    sql: ${TABLE}.utm_content ;;
  }

  dimension: utm_medium {
    group_label: "    Acquisition"
    label: "Event UTM Medium"
    description: "The UTM medium parameter value on the page URL for this event (e.g., 'cpc', 'email', 'referral', 'paid_social')."
    type: string
    sql: ${TABLE}.utm_medium ;;
  }

  dimension: utm_source {
    group_label: "    Acquisition"
    label: "Event UTM Source"
    description: "The UTM source parameter value on the page URL for this event (e.g., 'google', 'linkedin', 'rittmananalytics.com')."
    type: string
    sql: ${TABLE}.utm_source ;;
  }

  dimension: utm_term {
    group_label: "    Acquisition"
    label: "Event UTM Keyword"
    description: "The UTM term (keyword) parameter value on the page URL for this event, often used for paid search keywords."
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
    description: "The IP address from which the event originated. Note: IP addresses can be an approximation of location and may be anonymized. Not available for careers-site events."
    type: string
    sql: ${TABLE}.ip ;;
  }

  dimension: referrer_host {
    group_label: "    Acquisition"
    description: "The hostname (e.g., 'google.com') of the website that referred the user to the page where this event occurred, with 'www.' removed."
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

  # ---------------------------------------------------------------------------
  # Recruitment
  #
  # The company website (Segment) and the careers site (GA4) give the same person
  # different visitor IDs, so these fields count each funnel stage separately.
  # They cannot follow one person from menu click to application.
  # ---------------------------------------------------------------------------

  dimension: is_careers_site {
    group_label: "Recruitment"
    description: "Yes if the event happened on the Teamtailor careers site (careers.rittmananalytics.com)."
    type: yesno
    sql: ${TABLE}.site = 'careers.rittmananalytics.com' ;;
  }

  dimension: careers_funnel_stage {
    group_label: "Recruitment"
    description: "The recruitment funnel stage this event represents, if any: 1. Careers menu click, 2. Careers page view (rittmananalytics.com/careers), 3. Visage project click ('More on Visage' button on /careers, which leaves for the Visage site), 4. Click to careers site ('Open vacancies' and 'Enquire about the role' buttons on /careers), 5. Job listing view (careers site job list and job detail pages), 6. Job application (application confirmation page). Stages 1 to 4 are on the company website and have no role."
    type: string
    sql: case
      when ${TABLE}.site = 'rittmananalytics.com'
           and ${TABLE}.event_type in ('Navigation Clicked','Outbound Link Clicked')
           and ${TABLE}.event_details in ('Careers','CareersJoin our team') then '1. Careers menu click'
      when ${TABLE}.site = 'rittmananalytics.com' and ${TABLE}.event_type = 'Page View'
           and rtrim(${TABLE}.page_url_path,'/') = '/careers' then '2. Careers page view'
      when ${TABLE}.site = 'rittmananalytics.com' and ${TABLE}.event_type = 'Outbound Link Clicked'
           and ${TABLE}.event_details = 'More on Visage' then '3. Visage project click'
      when ${TABLE}.site = 'rittmananalytics.com' and ${TABLE}.event_type = 'Outbound Link Clicked'
           and ${TABLE}.event_details in ('Open vacancies','Enquire about the role') then '4. Click to careers site'
      when ${TABLE}.event_type = 'Page View' and ${job_page_type} in ('Job list','Job details') then '5. Job listing view'
      when ${TABLE}.event_type = 'Page View' and ${job_page_type} = 'Application confirmation' then '6. Job application'
    end ;;
  }

  dimension: job_id {
    group_label: "Recruitment"
    description: "The Teamtailor job ID, taken from careers-site /jobs/{id}-{role} page paths. Joins to Teamtailor's job list (Careers Job) for the role name."
    type: string
    sql: case when ${TABLE}.site = 'careers.rittmananalytics.com'
              then regexp_extract(${TABLE}.page_url_path, r'^/jobs/(\d+)') end ;;
  }

  dimension: job_page_type {
    group_label: "Recruitment"
    description: "The kind of careers-site job page: 'Job list' (/jobs), 'Job details' (/jobs/{id}-{role}), 'Application form', 'Application confirmation' (shown after an application is submitted), or 'Other job page'."
    type: string
    sql: case when ${TABLE}.site != 'careers.rittmananalytics.com' then null
      when regexp_contains(${TABLE}.page_url_path, r'^/jobs/?$') then 'Job list'
      when regexp_contains(${TABLE}.page_url_path, r'^/jobs/\d+[^/]*/applications/[^/]+/thanks') then 'Application confirmation'
      when regexp_contains(${TABLE}.page_url_path, r'^/jobs/\d+[^/]*/applications/new') then 'Application form'
      when regexp_contains(${TABLE}.page_url_path, r'^/jobs/\d+[^/]*/?$') then 'Job details'
      when regexp_contains(${TABLE}.page_url_path, r'^/jobs/') then 'Other job page'
    end ;;
  }

  dimension: is_cookie_declined_visitor {
    group_label: "Recruitment"
    description: "Yes for careers-site application confirmations from visitors who declined cookies. The warehouse keeps only these pages for such visitors, each under its own stand-in visitor ID, so they are left out of visitor counts and rates."
    type: yesno
    sql: starts_with(${TABLE}.visitor_id, 'ga4-cookieless-') ;;
  }

  dimension: application_id {
    group_label: "Recruitment"
    hidden: yes
    description: "The Teamtailor application ID, taken from the application confirmation page path."
    type: string
    sql: case when ${TABLE}.site = 'careers.rittmananalytics.com'
              then regexp_extract(${TABLE}.page_url_path, r'^/jobs/\d+[^/]*/applications/([^/]+)/thanks') end ;;
  }

  measure: total_recruitment_funnel_events {
    group_label: "Recruitment"
    description: "Events at any recruitment funnel stage. Use with Careers Funnel Stage."
    type: count_distinct
    value_format_name: decimal_0
    sql: case when ${careers_funnel_stage} is not null then ${web_events_pk} end ;;
  }

  measure: total_recruitment_funnel_people {
    group_label: "Recruitment"
    description: "Distinct visitors (one per browser, per site) at any recruitment funnel stage. Use with Careers Funnel Stage."
    type: count_distinct
    value_format_name: decimal_0
    sql: case when ${careers_funnel_stage} is not null then ${blended_user_id} end ;;
  }

  measure: total_careers_page_views {
    group_label: "Recruitment"
    description: "Page views of the careers page on the company website (rittmananalytics.com/careers)."
    type: count_distinct
    value_format_name: decimal_0
    sql: ${web_events_pk} ;;
    filters: [careers_funnel_stage: "2. Careers page view"]
  }

  measure: total_careers_page_clicks_to_careers_site {
    group_label: "Recruitment"
    description: "Clicks on the 'Open vacancies' and 'Enquire about the role' buttons on rittmananalytics.com/careers. Tracked from 25 Sep 2026."
    type: count_distinct
    value_format_name: decimal_0
    sql: ${web_events_pk} ;;
    filters: [careers_funnel_stage: "4. Click to careers site"]
  }

  measure: total_visage_clicks {
    group_label: "Recruitment"
    description: "Clicks on the 'More on Visage' button on rittmananalytics.com/careers, which opens Alex's Visage hackathon project. Tracked from 25 Sep 2026."
    type: count_distinct
    value_format_name: decimal_0
    sql: ${web_events_pk} ;;
    filters: [careers_funnel_stage: "3. Visage project click"]
  }

  measure: total_visage_clickers {
    group_label: "Recruitment"
    description: "Distinct company website visitors who clicked the 'More on Visage' button on the careers page."
    type: count_distinct
    value_format_name: decimal_0
    sql: case when ${careers_funnel_stage} = '3. Visage project click' then ${blended_user_id} end ;;
  }

  measure: total_job_listing_views {
    group_label: "Recruitment"
    description: "Page views of the careers-site job list (/jobs) and job details pages."
    type: count_distinct
    value_format_name: decimal_0
    sql: ${web_events_pk} ;;
    filters: [careers_funnel_stage: "5. Job listing view"]
  }

  measure: total_job_applications {
    group_label: "Recruitment"
    label: "Total Site Applications"
    description: "Applications made on the careers site, counted from application confirmation pages, including visitors who declined cookies. Teamtailor (Recruitment Applications explore) holds the full count, including LinkedIn, Indeed and recruiter-added candidates."
    type: count_distinct
    value_format_name: decimal_0
    sql: ${application_id} ;;
  }

  measure: total_job_applicants {
    group_label: "Recruitment"
    label: "Total Site Applicants"
    description: "Distinct careers-site visitors (one per browser) who reached an application confirmation page. Excludes visitors who declined cookies, so it can be compared with job page viewers."
    type: count_distinct
    value_format_name: decimal_0
    sql: case when ${application_id} is not null and not ${is_cookie_declined_visitor} then ${blended_user_id} end ;;
  }

  measure: total_job_page_viewers {
    group_label: "Recruitment"
    description: "Distinct careers-site visitors (one per browser) who viewed a job details page."
    type: count_distinct
    value_format_name: decimal_0
    sql: case when ${TABLE}.event_type = 'Page View' and ${job_page_type} = 'Job details' then ${blended_user_id} end ;;
  }

  measure: total_job_detail_views {
    group_label: "Recruitment"
    description: "Page views of job details pages on the careers site (excludes the job list, application form and confirmation pages)."
    type: count_distinct
    value_format_name: decimal_0
    sql: case when ${TABLE}.event_type = 'Page View' and ${job_page_type} = 'Job details' then ${web_events_pk} end ;;
  }

  measure: job_page_application_rate {
    group_label: "Recruitment"
    description: "Site applicants as a share of visitors who viewed a job details page."
    type: number
    value_format_name: percent_1
    sql: ${total_job_applicants} / nullif(${total_job_page_viewers}, 0) ;;
  }

  measure: total_talent_community_joins {
    group_label: "Recruitment"
    description: "Sign-ups to the Teamtailor talent community (Connect) on the careers site."
    type: count_distinct
    value_format_name: decimal_0
    sql: ${web_events_pk} ;;
    filters: [event_type: "Talent Community Joined"]
  }

  measure: total_careers_site_visitors {
    group_label: "Recruitment"
    description: "Distinct visitors (one per browser) to the careers site. Excludes visitors who declined cookies."
    type: count_distinct
    value_format_name: decimal_0
    sql: ${blended_user_id} ;;
    filters: [is_careers_site: "Yes", is_cookie_declined_visitor: "No"]
  }

  measure: total_careers_site_sessions {
    group_label: "Recruitment"
    description: "Distinct sessions on the careers site. Excludes visitors who declined cookies."
    type: count_distinct
    value_format_name: decimal_0
    sql: ${session_id} ;;
    filters: [is_careers_site: "Yes", is_cookie_declined_visitor: "No"]
  }

  measure: careers_site_application_rate {
    group_label: "Recruitment"
    description: "Site applicants as a share of careers-site visitors."
    type: number
    value_format_name: percent_1
    sql: ${total_job_applicants} / nullif(${total_careers_site_visitors}, 0) ;;
  }

  measure: careers_page_click_through_rate {
    group_label: "Recruitment"
    description: "Clicks to the careers site as a share of careers page views on the company website. Only meaningful from 25 Sep 2026."
    type: number
    value_format_name: percent_1
    sql: ${total_careers_page_clicks_to_careers_site} / nullif(${total_careers_page_views}, 0) ;;
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
