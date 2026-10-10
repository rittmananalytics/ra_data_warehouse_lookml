view: web_sessions_fact {
  sql_table_name: `ra-development.analytics.web_sessions_fact` ;;

  dimension: anonymous_id {
    type: string
    label: "Anonymous ID"
    sql: ${TABLE}.anonymous_id ;;
  }

  dimension: blended_user_id {
    type: string
    label: "Blended User ID"
    sql: ${TABLE}.blended_user_id ;;
  }

  dimension: blog_post_author {
    type: string
    label: "Blog Post Author"
    sql: ${TABLE}.blog_post_author ;;
  }

  dimension: blog_post_category {
    type: string
    label: "Blog Post Category"
    sql: ${TABLE}.blog_post_category ;;
  }

  dimension: blog_post_id {
    type: string
    label: "Blog Post ID"
    sql: ${TABLE}.blog_post_id ;;
  }

  dimension: blog_post_tags {
    type: string
    label: "Blog Post Tags"
    sql: ${TABLE}.blog_post_tags ;;
  }

  dimension: blog_post_title {
    type: string
    label: "Blog Post Title"
    sql: ${TABLE}.blog_post_title ;;
  }

  dimension: channel {
    type: string
    label: "Channel"
    sql: ${TABLE}.channel ;;
  }

  dimension: channel_from_sql {
    type: string
    label: "Channel"
    sql: CASE WHEN (replace(replace(lower(${TABLE}.utm_source), '/', ''), '.com', '')) IN ('linkedin', 'facebook') AND (lower(${TABLE}.utm_medium)) = 'paid' THEN 'Paid Social' WHEN ((replace(replace(lower(${TABLE}.utm_source), '/', ''), '.com', '')) = 'linkedin' OR ${TABLE}.referrer_host LIKE '%linkedin%') AND (lower(${TABLE}.utm_medium)) <> 'paid' THEN 'Organic Social' WHEN ${TABLE}.channel = 'Social' THEN 'Organic Social' WHEN ${TABLE}.channel IN ('facebook', 'linkedin') AND (lower(${TABLE}.utm_medium)) = 'social' THEN 'Organic Social' WHEN (lower(${TABLE}.utm_medium)) = 'social' AND ${TABLE}.channel = 'Direct' THEN 'Organic Social' WHEN (replace(replace(lower(${TABLE}.utm_source), '/', ''), '.com', '')) = 'substack' AND (lower(${TABLE}.utm_medium)) <> 'email' THEN 'Organic Social' WHEN (replace(replace(lower(${TABLE}.utm_source), '/', ''), '.com', '')) LIKE 'pocket_%' THEN 'Referral' WHEN (${TABLE}.referrer_host LIKE '%rittmananalytics.com%' AND ${TABLE}.referrer_host NOT LIKE '%blog.rittmananalytics.com%') OR ${TABLE}.referrer_host LIKE 'calendly.com' THEN 'Direct' WHEN ${TABLE}.referrer_host LIKE '%medium.com%' OR ${TABLE}.referrer_host LIKE '%blog.rittmananalytics.com%' THEN 'Organic Social' ELSE ${TABLE}.channel END ;;
  }

  dimension: city {
    type: string
    label: "City"
    sql: ${TABLE}.city ;;
  }

  dimension: company_fk {
    type: string
    label: "Company Fk"
    sql: ${TABLE}.company_fk ;;
  }

  dimension: company_name {
    type: string
    label: "Company Name"
    sql: ${TABLE}.company_name ;;
  }

  dimension: country {
    type: string
    label: "Country"
    sql: ${TABLE}.country ;;
  }

  dimension: country_code {
    type: string
    label: "Country Code"
    sql: ${TABLE}.country_code ;;
  }

  dimension: device {
    type: string
    label: "Device"
    sql: ${TABLE}.device ;;
  }

  dimension: device_category {
    type: string
    label: "Device Category"
    sql: ${TABLE}.device_category ;;
  }

  dimension: duration_in_s {
    type: number
    label: "Duration In S"
    sql: ${TABLE}.duration_in_s ;;
  }

  dimension: duration_in_s_tier {
    type: string
    label: "Duration In S Tier"
    sql: ${TABLE}.duration_in_s_tier ;;
  }

  dimension: events {
    type: number
    label: "Events"
    sql: ${TABLE}.events ;;
  }

  dimension: first_computed_page_category {
    type: string
    label: "First Computed Page Category"
    sql: ${TABLE}.first_computed_page_category ;;
  }

  dimension: first_page_category {
    type: string
    label: "First Page Category"
    sql: ${TABLE}.first_page_category ;;
  }

  dimension: first_page_title {
    type: string
    label: "First Page Title"
    sql: ${TABLE}.first_page_title ;;
  }

  dimension: first_page_url {
    type: string
    label: "First Page URL"
    sql: ${TABLE}.first_page_url ;;
  }

  dimension: first_page_url_host {
    type: string
    label: "First Page URL Host"
    sql: ${TABLE}.first_page_url_host ;;
  }

  dimension: first_page_url_path {
    type: string
    label: "First Page URL Path"
    sql: ${TABLE}.first_page_url_path ;;
  }

  dimension: gclid {
    type: string
    label: "Gclid"
    sql: ${TABLE}.gclid ;;
  }

  dimension: is_bounced_session {
    type: yesno
    label: "Is Bounced Session"
    sql: ${TABLE}.is_bounced_session ;;
  }

  dimension: is_conversion_session {
    type: yesno
    label: "Is Conversion Session"
    sql: ${TABLE}.is_conversion_session ;;
  }

  dimension: is_converting_blended_user_id {
    type: yesno
    label: "Is Converting Blended User ID"
    sql: ${TABLE}.is_converting_blended_user_id ;;
  }

  dimension: is_goal_achieved_session {
    type: yesno
    label: "Is Goal Achieved Session"
    sql: ${TABLE}.is_goal_achieved_session ;;
  }

  dimension: isp {
    type: string
    label: "Isp"
    sql: ${TABLE}.isp ;;
  }

  dimension: last_computed_page_category {
    type: string
    label: "Last Computed Page Category"
    sql: ${TABLE}.last_computed_page_category ;;
  }

  dimension: last_page_category {
    type: string
    label: "Last Page Category"
    sql: ${TABLE}.last_page_category ;;
  }

  dimension: last_page_title {
    type: string
    label: "Last Page Title"
    sql: ${TABLE}.last_page_title ;;
  }

  dimension: last_page_url {
    type: string
    label: "Last Page URL"
    sql: ${TABLE}.last_page_url ;;
  }

  dimension: last_page_url_host {
    type: string
    label: "Last Page URL Host"
    sql: ${TABLE}.last_page_url_host ;;
  }

  dimension: last_page_url_path {
    type: string
    label: "Last Page URL Path"
    sql: ${TABLE}.last_page_url_path ;;
  }

  dimension: latitude {
    type: number
    label: "Latitude"
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    label: "Longitude"
    sql: ${TABLE}.longitude ;;
  }

  dimension: mins_between_sessions {
    type: number
    label: "Mins Between Sessions"
    sql: ${TABLE}.mins_between_sessions ;;
  }

  dimension: page_type {
    type: string
    label: "Page Type"
    sql: ${TABLE}.page_type ;;
  }

  dimension: partner {
    type: string
    label: "Partner"
    sql: ${TABLE}.partner ;;
  }

  dimension: referrer {
    type: string
    label: "Referrer"
    sql: ${TABLE}.referrer ;;
  }

  dimension: referrer_domain {
    type: string
    label: "Referrer Domain"
    sql: ${TABLE}.referrer_domain ;;
  }

  dimension: referrer_host {
    type: string
    label: "Referrer Host"
    sql: ${TABLE}.referrer_host ;;
  }

  dimension: referrer_medium {
    type: string
    label: "Referrer Medium"
    sql: ${TABLE}.referrer_medium ;;
  }

  dimension: referrer_source {
    type: string
    label: "Referrer Source"
    sql: ${TABLE}.referrer_source ;;
  }

  dimension: region {
    type: string
    label: "Region"
    sql: ${TABLE}.region ;;
  }

  dimension: region_code {
    type: string
    label: "Region Code"
    sql: ${TABLE}.region_code ;;
  }

  dimension: screen_resolution {
    type: string
    label: "Screen Resolution"
    sql: ${TABLE}.screen_resolution ;;
  }

  dimension: search {
    type: string
    label: "Search"
    sql: ${TABLE}.search ;;
  }

  dimension: session_id {
    type: string
    label: "Session ID"
    sql: ${TABLE}.session_id ;;
  }

  dimension: session_start_ts_month {
    type: string
    label: "Session Start Ts Month"
    sql: (FORMAT_TIMESTAMP('%Y-%m', ${TABLE}.session_start_ts)) ;;
  }

  dimension: site {
    type: string
    label: "Site"
    sql: ${TABLE}.site ;;
  }

  dimension: timezone {
    type: string
    label: "Timezone"
    sql: ${TABLE}.timezone ;;
  }

  dimension: user_session_number {
    type: number
    label: "User Session Number"
    sql: ${TABLE}.user_session_number ;;
  }

  dimension: utm_campaign {
    type: string
    label: "Utm Campaign"
    sql: ${TABLE}.utm_campaign ;;
  }

  dimension: utm_content {
    type: string
    label: "Utm Content"
    sql: ${TABLE}.utm_content ;;
  }

  dimension: utm_medium {
    type: string
    label: "Utm Medium"
    sql: ${TABLE}.utm_medium ;;
  }

  dimension: utm_source {
    type: string
    label: "Utm Source"
    sql: ${TABLE}.utm_source ;;
  }

  dimension: utm_term {
    type: string
    label: "Utm Term"
    sql: ${TABLE}.utm_term ;;
  }

  dimension: viewport_size {
    type: string
    label: "Viewport Size"
    sql: ${TABLE}.viewport_size ;;
  }

  dimension: web_sessions_pk {
    type: string
    label: "Web Sessions Pk"
    sql: ${TABLE}.web_sessions_pk ;;
  }

  dimension_group: session_end_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Session End Ts"
    sql: ${TABLE}.session_end_ts ;;
  }

  dimension_group: session_start_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: timestamp
    label: "Session Start Ts"
    sql: ${TABLE}.session_start_ts ;;
  }

  measure: bounce_rate {
    type: number
    label: "Bounce rate"
    sql: (${count_where_4469da}) / NULLIF(${count}, 0) ;;
  }

  measure: bounced_session_rate {
    type: number
    label: "Bounced Session Rate"
    sql: SAFE_DIVIDE(COUNT(DISTINCT (CASE WHEN ${TABLE}.is_bounced_session = TRUE THEN ${TABLE}.web_sessions_pk END)), (COUNT(DISTINCT ${TABLE}.web_sessions_pk))) ;;
  }

  measure: count {
    type: count
    label: "Count"
  }

  measure: count_distinct_web_sessions_pk {
    type: count_distinct
    label: "Distinct of Web Sessions Pk"
    sql: ${web_sessions_pk} ;;
  }

  measure: count_where_4469da {
    type: count
    label: "Count where is bounced session is Yes"
    filters: [is_bounced_session: "Yes"]
  }

  measure: total_sessions {
    type: count_distinct
    label: "Total Sessions"
    sql: ${TABLE}.web_sessions_pk ;;
  }
}
