# =============================================================================
# PERSONAL DATA DASHBOARD - LookML Model
# Connection: ra_dw_prod
# Dataset: ra-development.pdd_analytics
# =============================================================================
# Explores aligned with dbt warehouse models
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
# EXPLORE: HEALTH & WELLBEING
# #############################################################################

explore: health_metrics {
  label: "Health Metrics"
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
  label: "Sleep"
  group_label: "Personal Data"
  description: "Analyze sleep episodes and patterns"

  from: fct_sleep_events

  join: pdd_dim_date {
    type: left_outer
    relationship: many_to_one
    sql_on: ${sleep_events.date_fk} = ${pdd_dim_date.date_key} ;;
  }
}

explore: monthly_health {
  label: "Monthly Health Summary"
  group_label: "Personal Data"
  description: "Pre-aggregated monthly health metrics for trend analysis"

  from: agg_monthly_health
}


# #############################################################################
# EXPLORE: PRODUCTIVITY
# #############################################################################

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
# EXPLORE: FINANCIAL
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


# #############################################################################
# EXPLORE: COMMUNICATIONS
# #############################################################################

explore: emails {
  label: "Communications"
  group_label: "Personal Data"
  description: "Analyze email and message patterns, volume, and correspondents"

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
  description: "Analyze messaging across platforms"

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

  join: dim_contact {
    type: left_outer
    relationship: many_to_one
    sql_on: ${messages.contact_fk} = ${dim_contact.contact_pk} ;;
  }
}


# #############################################################################
# EXPLORE: DIGITAL ACTIVITY
# #############################################################################

explore: youtube_activity {
  label: "Digital Activity"
  group_label: "Personal Data"
  description: "Analyze YouTube and digital activity patterns"

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
}


# #############################################################################
# EXPLORE: CROSS-DOMAIN INSIGHTS
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
