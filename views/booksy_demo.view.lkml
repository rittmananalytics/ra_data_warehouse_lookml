# Provider Revenue Dashboard — LookML Views & Explore
# =====================================================
# This file defines the LookML views and explore required to power
# the Provider Revenue Dashboard. All calculations, joins and derived
# measures are defined in LookML rather than relying on SQL views.

# -------------------------------------------------------------------
# VIEW: fct_boost_transactions
# -------------------------------------------------------------------
view: fct_boost_transactions {
  sql_table_name: booksy_analytics.fct_boost_transactions ;;

  dimension: transaction_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.transaction_id ;;
  }

  dimension_group: transaction {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.transaction_date ;;
  }

  dimension: provider_id {
    type: string
    sql: ${TABLE}.provider_id ;;
  }

  dimension: country_code {
    type: string
    sql: ${TABLE}.country_code ;;
  }

  dimension: acquisition_channel {
    type: string
    sql: ${TABLE}.acquisition_channel ;;
  }

  dimension: business_category {
    type: string
    sql: ${TABLE}.business_category ;;
  }

  dimension: boost_revenue_usd {
    type: number
    sql: ${TABLE}.boost_revenue_usd ;;
    hidden: yes
  }

  dimension: gmv_usd {
    type: number
    sql: ${TABLE}.gmv_usd ;;
    hidden: yes
  }

  # --- Measures ---

  measure: sum_boost_revenue {
    type: sum
    sql: ${boost_revenue_usd} ;;
    value_format_name: usd
    label: "Total Boost Revenue"
    description: "Sum of all Boost revenue in USD"
  }

  measure: sum_gmv {
    type: sum
    sql: ${gmv_usd} ;;
    value_format_name: usd
    label: "Total GMV"
    description: "Gross Merchandise Value of bookings associated with Boost"
  }

  measure: average_take_rate {
    type: number
    sql: SAFE_DIVIDE(${sum_boost_revenue}, ${sum_gmv}) * 100 ;;
    value_format: "0.0\"%\""
    label: "Avg Take Rate"
    description: "Boost revenue as a percentage of GMV"
  }

  measure: count_distinct_active_providers {
    type: count_distinct
    sql: ${provider_id} ;;
    label: "Active Providers"
    description: "Count of distinct providers with at least one Boost transaction"
  }

  measure: average_revenue_per_provider {
    type: number
    sql: SAFE_DIVIDE(${sum_boost_revenue}, ${count_distinct_active_providers}) ;;
    value_format_name: usd
    label: "ARPP"
    description: "Average Revenue Per Provider — total Boost revenue divided by distinct active providers"
  }

  measure: count_transactions {
    type: count
    label: "Transaction Count"
  }

  # --- Period-over-period measures for KPI comparisons ---

  filter: current_period_filter {
    type: date
    description: "Select the current analysis period"
  }

  dimension: is_current_period {
    type: yesno
    sql: ${transaction_date} >= {% date_start current_period_filter %}
      AND ${transaction_date} < {% date_end current_period_filter %} ;;
    hidden: yes
  }

  measure: current_period_boost_revenue {
    type: sum
    sql: ${boost_revenue_usd} ;;
    filters: [is_current_period: "Yes"]
    value_format_name: usd
    label: "Current Period Boost Revenue"
    hidden: yes
  }

  measure: previous_period_boost_revenue {
    type: sum
    sql: ${boost_revenue_usd} ;;
    filters: [is_current_period: "No"]
    value_format_name: usd
    label: "Previous Period Boost Revenue"
    hidden: yes
  }

  measure: revenue_period_change_pct {
    type: number
    sql: SAFE_DIVIDE(${current_period_boost_revenue} - ${previous_period_boost_revenue},
      ${previous_period_boost_revenue}) * 100 ;;
    value_format: "0.0\"%\""
    label: "Revenue Change %"
    description: "Percentage change in Boost revenue between current and previous period"
  }
}


# -------------------------------------------------------------------
# VIEW: dim_providers
# -------------------------------------------------------------------
view: dim_providers {
  sql_table_name: booksy_analytics.dim_providers ;;

  dimension: provider_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.provider_id ;;
  }

  dimension: provider_name {
    type: string
    sql: ${TABLE}.provider_name ;;
  }

  dimension: country_code {
    type: string
    sql: ${TABLE}.country_code ;;
    label: "Provider Country"
  }

  dimension: business_category {
    type: string
    sql: ${TABLE}.business_category ;;
    label: "Provider Business Category"
  }

  dimension: acquisition_channel {
    type: string
    sql: ${TABLE}.acquisition_channel ;;
    label: "Provider Acquisition Channel"
  }

  dimension: subscription_tier {
    type: string
    sql: ${TABLE}.subscription_tier ;;
  }

  dimension: is_active {
    type: yesno
    sql: ${TABLE}.is_active ;;
    label: "Is Active Provider"
  }

  dimension_group: signup {
    type: time
    timeframes: [date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.signup_date ;;
  }

  dimension_group: activation {
    type: time
    timeframes: [date, week, month]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.activation_date ;;
  }

  dimension_group: first_boost {
    type: time
    timeframes: [date, week, month]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.first_boost_date ;;
  }

  measure: total_providers {
    type: count_distinct
    sql: ${provider_id} ;;
    label: "Total Providers"
  }
}


# -------------------------------------------------------------------
# VIEW: dim_countries
# -------------------------------------------------------------------
view: dim_countries {
  sql_table_name: booksy_analytics.dim_countries ;;

  dimension: country_code {
    primary_key: yes
    type: string
    sql: ${TABLE}.country_code ;;
  }

  dimension: country_name {
    type: string
    sql: ${TABLE}.country_name ;;
    label: "Country"
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: currency_code {
    type: string
    sql: ${TABLE}.currency_code ;;
  }
}


# -------------------------------------------------------------------
# VIEW: dim_dates
# -------------------------------------------------------------------
view: dim_dates {
  sql_table_name: booksy_analytics.dim_dates ;;

  dimension: date_key {
    primary_key: yes
    type: date
    sql: ${TABLE}.date_key ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  dimension: quarter {
    type: number
    sql: ${TABLE}.quarter ;;
  }

  dimension: month {
    type: number
    sql: ${TABLE}.month ;;
  }

  dimension: week_of_year {
    type: number
    sql: ${TABLE}.week_of_year ;;
  }

  dimension: iso_week_start {
    type: date
    sql: ${TABLE}.iso_week_start ;;
    label: "Week Starting"
  }

  dimension: iso_week_label {
    type: string
    sql: ${TABLE}.iso_week_label ;;
    label: "Week Label"
    description: "Human-readable week label e.g. W1 (Feb 3)"
    order_by_field: iso_week_start
  }

  dimension: month_label {
    type: string
    sql: ${TABLE}.month_label ;;
    label: "Month Label"
    description: "e.g. Feb 2026"
  }

  dimension: is_current_week {
    type: yesno
    sql: ${TABLE}.is_current_week ;;
  }

  dimension: is_previous_week {
    type: yesno
    sql: ${TABLE}.is_previous_week ;;
  }

  dimension: is_current_month {
    type: yesno
    sql: ${TABLE}.is_current_month ;;
  }

  dimension: is_previous_month {
    type: yesno
    sql: ${TABLE}.is_previous_month ;;
  }

  dimension: weeks_ago {
    type: number
    sql: ${TABLE}.weeks_ago ;;
    description: "0 = current week, 1 = last week, etc."
  }
}


# -------------------------------------------------------------------
# EXPLORE: boost_revenue
# -------------------------------------------------------------------
# Single explore powering all Provider Revenue Dashboard tiles.
# Dashboard elements use filters and pivots to slice this one explore
# rather than requiring separate explores per visualisation.
# -------------------------------------------------------------------
