# =============================================================================
# PERSONAL DATA DASHBOARD - LookML Model
# Connection: ra_dw_prod
# Dataset: markr-data-lake.mark_dw_warehouse
# =============================================================================
# This model supports 8 dashboards with explores for:
# - Health & Wellbeing
# - Productivity
# - Financial
# - Communications
# - Location & Travel
# - Entertainment
# - Smart Home
# - Cross-Domain Insights
# =============================================================================

connection: "ra_dw_prod"

# Include all views
include: "/views/**/**/*.view.lkml"


# =============================================================================
# DATAGROUPS - Data Refresh Triggers
# =============================================================================

datagroup: daily_refresh {
  sql_trigger: SELECT CURRENT_DATE() ;;
  max_cache_age: "24 hours"
  label: "Daily Refresh"
  description: "Refreshes daily at midnight"
}

datagroup: hourly_refresh {
  sql_trigger: SELECT TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), HOUR) ;;
  max_cache_age: "1 hour"
  label: "Hourly Refresh"
  description: "Refreshes every hour"
}


# #############################################################################
# EXPLORE 1: HEALTH & WELLBEING
# Dashboard: Health & Wellbeing
# Questions: Weight trends, sleep quality, exercise consistency, cycling, BP
# #############################################################################

explore: health_metrics {
  label: "Health & Wellbeing"
  group_label: "Personal Data"
  description: "Track weight, sleep, body composition, blood pressure, and activity metrics"

  from: fct_daily_health_metrics

  join: pdd_dim_date {
    type: left_outer
    relationship: many_to_one
    sql_on: ${health_metrics.date_fk} = ${pdd_dim_date.date_key} ;;
  }
}

explore: workouts {
  label: "Workouts"
  group_label: "Personal Data"
  description: "Analyze workout frequency, duration, distance, and performance"

  from: fct_workouts

  join: pdd_dim_date {
    type: left_outer
    relationship: many_to_one
    sql_on: ${workouts.date_fk} = ${pdd_dim_date.date_key} ;;
  }

  join: dim_workout_type {
    type: left_outer
    relationship: many_to_one
    sql_on: ${workouts.workout_type_fk} = ${dim_workout_type.workout_type_pk} ;;
  }
}

explore: sleep_events {
  label: "Sleep Events"
  group_label: "Personal Data"
  description: "Analyze individual sleep episodes and patterns"

  from: fct_sleep_events

  join: pdd_dim_date {
    type: left_outer
    relationship: many_to_one
    sql_on: ${sleep_events.date_fk} = ${pdd_dim_date.date_key} ;;
  }
}

explore: daily_activity {
  label: "Daily Activity"
  group_label: "Personal Data"
  description: "Track daily steps, active minutes, and calories"

  from: fct_daily_activity

  join: pdd_dim_date {
    type: left_outer
    relationship: many_to_one
    sql_on: ${daily_activity.date_fk} = ${pdd_dim_date.date_key} ;;
  }
}

explore: monthly_health {
  label: "Monthly Health Summary"
  group_label: "Personal Data"
  description: "Pre-aggregated monthly health metrics for trend analysis"

  from: agg_monthly_health
}


# #############################################################################
# EXPLORE 2: PRODUCTIVITY
# Dashboard: Productivity
# Questions: Productive hours, focus ratio, app usage, distractions, deep work
# #############################################################################

explore: daily_productivity {
  label: "Daily Productivity"
  group_label: "Personal Data"
  description: "Track daily productivity metrics, focus ratio, and deep work blocks"

  from: fct_daily_productivity

  join: pdd_dim_date {
    type: left_outer
    relationship: many_to_one
    sql_on: ${daily_productivity.date_fk} = ${pdd_dim_date.date_key} ;;
  }
}

explore: application_usage {
  label: "Application Usage"
  group_label: "Personal Data"
  description: "Analyze time spent on applications and websites"

  from: fct_application_usage

  join: pdd_dim_date {
    type: left_outer
    relationship: many_to_one
    sql_on: ${application_usage.date_fk} = ${pdd_dim_date.date_key} ;;
  }

  join: dim_time_of_day {
    type: left_outer
    relationship: many_to_one
    sql_on: ${application_usage.time_fk} = ${dim_time_of_day.time_key} ;;
  }

  join: dim_application {
    type: left_outer
    relationship: many_to_one
    sql_on: ${application_usage.application_fk} = ${dim_application.application_pk} ;;
  }
}

explore: weekly_productivity {
  label: "Weekly Productivity Summary"
  group_label: "Personal Data"
  description: "Pre-aggregated weekly productivity metrics for trend analysis"

  from: agg_weekly_productivity
}


# #############################################################################
# EXPLORE 3: FINANCIAL
# Dashboard: Financial
# Questions: Monthly spending, category breakdown, Amazon/Uber, subscriptions
# #############################################################################

explore: transactions {
  label: "Financial Transactions"
  group_label: "Personal Data"
  description: "Analyze all financial transactions across accounts"

  from: fct_transactions

  join: pdd_dim_date {
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.date_fk} = ${pdd_dim_date.date_key} ;;
  }

  join: dim_merchant {
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.merchant_fk} = ${dim_merchant.merchant_pk} ;;
  }

  join: dim_spending_category {
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.category_fk} = ${dim_spending_category.category_pk} ;;
  }

  join: dim_bank_account {
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.account_fk} = ${dim_bank_account.account_pk} ;;
  }
}

explore: monthly_spending {
  label: "Monthly Spending by Category"
  group_label: "Personal Data"
  description: "Pre-aggregated monthly spending by category"

  from: agg_monthly_spending

  join: dim_spending_category {
    type: left_outer
    relationship: many_to_one
    sql_on: ${monthly_spending.category_fk} = ${dim_spending_category.category_pk} ;;
  }
}

explore: monthly_spending_total {
  label: "Monthly Spending Total"
  group_label: "Personal Data"
  description: "Pre-aggregated monthly total spending with breakdowns"

  from: agg_monthly_spending_total
}


# #############################################################################
# EXPLORE 4: COMMUNICATIONS
# Dashboard: Communications
# Questions: Email volume, correspondents, platform distribution, response time
# #############################################################################

explore: emails {
  label: "Emails"
  group_label: "Personal Data"
  description: "Analyze email patterns, volume, and correspondents"

  from: fct_emails

  join: pdd_dim_date {
    type: left_outer
    relationship: many_to_one
    sql_on: ${emails.date_fk} = ${pdd_dim_date.date_key} ;;
  }

  join: dim_time_of_day {
    type: left_outer
    relationship: many_to_one
    sql_on: ${emails.time_fk} = ${dim_time_of_day.time_key} ;;
  }

  join: contact_from {
    from: dim_contact
    type: left_outer
    relationship: many_to_one
    sql_on: ${emails.contact_from_fk} = ${contact_from.contact_pk} ;;
  }

  join: contact_to {
    from: dim_contact
    type: left_outer
    relationship: many_to_one
    sql_on: ${emails.contact_to_fk} = ${contact_to.contact_pk} ;;
  }
}

explore: messages {
  label: "Messages"
  group_label: "Personal Data"
  description: "Analyze messaging across platforms (iMessage, Slack, WhatsApp)"

  from: fct_messages

  join: pdd_dim_date {
    type: left_outer
    relationship: many_to_one
    sql_on: ${messages.date_fk} = ${pdd_dim_date.date_key} ;;
  }

  join: dim_time_of_day {
    type: left_outer
    relationship: many_to_one
    sql_on: ${messages.time_fk} = ${dim_time_of_day.time_key} ;;
  }

  join: dim_platform {
    type: left_outer
    relationship: many_to_one
    sql_on: ${messages.platform_fk} = ${dim_platform.platform_pk} ;;
  }

  join: dim_contact {
    type: left_outer
    relationship: many_to_one
    sql_on: ${messages.contact_fk} = ${dim_contact.contact_pk} ;;
  }
}

explore: daily_communication {
  label: "Daily Communication Summary"
  group_label: "Personal Data"
  description: "Pre-aggregated daily communication metrics"

  from: agg_daily_communication

  join: pdd_dim_date {
    type: left_outer
    relationship: many_to_one
    sql_on: ${daily_communication.date_fk} = ${pdd_dim_date.date_key} ;;
  }
}

explore: weekly_communication {
  label: "Weekly Communication Summary"
  group_label: "Personal Data"
  description: "Pre-aggregated weekly communication metrics"

  from: agg_weekly_communication
}


# #############################################################################
# EXPLORE 5: LOCATION & TRAVEL
# Dashboard: Location & Travel
# Questions: Home vs away time, places visited, travel patterns, Uber usage
# #############################################################################

explore: location_visits {
  label: "Location Visits"
  group_label: "Personal Data"
  description: "Analyze location visits, home/away time, and travel patterns"

  from: fct_location_visits

  join: pdd_dim_date {
    type: left_outer
    relationship: many_to_one
    sql_on: ${location_visits.date_fk} = ${pdd_dim_date.date_key} ;;
  }

  join: dim_location {
    type: left_outer
    relationship: many_to_one
    sql_on: ${location_visits.location_fk} = ${dim_location.location_pk} ;;
  }
}

explore: uber_rides {
  label: "Uber Rides"
  group_label: "Personal Data"
  description: "Analyze Uber ride patterns, cities, and spending"

  from: fct_uber_rides

  join: pdd_dim_date {
    type: left_outer
    relationship: many_to_one
    sql_on: ${uber_rides.date_fk} = ${pdd_dim_date.date_key} ;;
  }

  join: pickup_location {
    from: dim_location
    type: left_outer
    relationship: many_to_one
    sql_on: ${uber_rides.pickup_location_fk} = ${pickup_location.location_pk} ;;
  }

  join: dropoff_location {
    from: dim_location
    type: left_outer
    relationship: many_to_one
    sql_on: ${uber_rides.dropoff_location_fk} = ${dropoff_location.location_pk} ;;
  }
}

explore: monthly_location {
  label: "Monthly Location Summary"
  group_label: "Personal Data"
  description: "Pre-aggregated monthly location and travel metrics"

  from: agg_monthly_location
}


# #############################################################################
# EXPLORE 6: ENTERTAINMENT
# Dashboard: Entertainment
# Questions: Music library, genres, YouTube watching, search interests
# #############################################################################

explore: music_library {
  label: "Music Library"
  group_label: "Personal Data"
  description: "Analyze music library composition, artists, and genres"

  from: fct_music_library

  join: dim_artist {
    type: left_outer
    relationship: many_to_one
    sql_on: ${music_library.artist_fk} = ${dim_artist.artist_pk} ;;
  }

  join: dim_genre {
    type: left_outer
    relationship: many_to_one
    sql_on: ${music_library.genre_fk} = ${dim_genre.genre_pk} ;;
  }

  join: pdd_dim_date {
    type: left_outer
    relationship: many_to_one
    sql_on: ${music_library.date_added_fk} = ${pdd_dim_date.date_key} ;;
  }
}

explore: music_plays {
  label: "Music Plays"
  group_label: "Personal Data"
  description: "Analyze music listening history and patterns"

  from: fct_music_plays

  join: pdd_dim_date {
    type: left_outer
    relationship: many_to_one
    sql_on: ${music_plays.date_fk} = ${pdd_dim_date.date_key} ;;
  }

  join: dim_time_of_day {
    type: left_outer
    relationship: many_to_one
    sql_on: ${music_plays.time_fk} = ${dim_time_of_day.time_key} ;;
  }

  join: dim_artist {
    type: left_outer
    relationship: many_to_one
    sql_on: ${music_plays.artist_fk} = ${dim_artist.artist_pk} ;;
  }
}

explore: youtube_activity {
  label: "YouTube Activity"
  group_label: "Personal Data"
  description: "Analyze YouTube watching and search patterns"

  from: fct_youtube_activity

  join: pdd_dim_date {
    type: left_outer
    relationship: many_to_one
    sql_on: ${youtube_activity.date_fk} = ${pdd_dim_date.date_key} ;;
  }

  join: dim_time_of_day {
    type: left_outer
    relationship: many_to_one
    sql_on: ${youtube_activity.time_fk} = ${dim_time_of_day.time_key} ;;
  }

  join: dim_youtube_channel {
    type: left_outer
    relationship: many_to_one
    sql_on: ${youtube_activity.channel_fk} = ${dim_youtube_channel.channel_pk} ;;
  }
}

explore: searches {
  label: "Web Searches"
  group_label: "Personal Data"
  description: "Analyze web and YouTube search patterns"

  from: fct_searches

  join: pdd_dim_date {
    type: left_outer
    relationship: many_to_one
    sql_on: ${searches.date_fk} = ${pdd_dim_date.date_key} ;;
  }

  join: dim_time_of_day {
    type: left_outer
    relationship: many_to_one
    sql_on: ${searches.time_fk} = ${dim_time_of_day.time_key} ;;
  }
}

explore: monthly_entertainment {
  label: "Monthly Entertainment Summary"
  group_label: "Personal Data"
  description: "Pre-aggregated monthly entertainment and media consumption"

  from: agg_monthly_entertainment
}


# #############################################################################
# EXPLORE 7: SMART HOME
# Dashboard: Smart Home
# Questions: Temperature patterns, home presence, heating efficiency
# #############################################################################

explore: smart_home {
  label: "Smart Home Events"
  group_label: "Personal Data"
  description: "Analyze temperature, humidity, heating, and presence patterns"

  from: fct_smart_home

  join: pdd_dim_date {
    type: left_outer
    relationship: many_to_one
    sql_on: ${smart_home.date_fk} = ${pdd_dim_date.date_key} ;;
  }

  join: dim_time_of_day {
    type: left_outer
    relationship: many_to_one
    sql_on: ${smart_home.time_fk} = ${dim_time_of_day.time_key} ;;
  }
}

explore: daily_smart_home {
  label: "Daily Smart Home Summary"
  group_label: "Personal Data"
  description: "Pre-aggregated daily smart home metrics"

  from: agg_daily_smart_home

  join: pdd_dim_date {
    type: left_outer
    relationship: many_to_one
    sql_on: ${daily_smart_home.date_fk} = ${pdd_dim_date.date_key} ;;
  }
}


# #############################################################################
# EXPLORE 8: CROSS-DOMAIN INSIGHTS
# Dashboard: Cross-Domain Insights
# Questions: Sleep-productivity correlation, exercise patterns, life phases
# #############################################################################

explore: cross_domain_correlations {
  label: "Cross-Domain Correlations"
  group_label: "Personal Data"
  description: "Pre-computed correlations between life domains"

  from: agg_cross_domain_correlations
}

explore: life_phase_metrics {
  label: "Life Phase Comparison"
  group_label: "Personal Data"
  description: "Compare metrics across life phases (Pre/During/Post Pandemic)"

  from: agg_life_phase_metrics
}


# #############################################################################
# ADDITIONAL EXPLORES: SOCIAL MEDIA
# #############################################################################

explore: social_posts {
  label: "Social Posts"
  group_label: "Personal Data"
  description: "Analyze social media posts and check-ins"

  from: fct_social_posts

  join: pdd_dim_date {
    type: left_outer
    relationship: many_to_one
    sql_on: ${social_posts.date_fk} = ${pdd_dim_date.date_key} ;;
  }

  join: dim_location {
    type: left_outer
    relationship: many_to_one
    sql_on: ${social_posts.location_fk} = ${dim_location.location_pk} ;;
  }
}
