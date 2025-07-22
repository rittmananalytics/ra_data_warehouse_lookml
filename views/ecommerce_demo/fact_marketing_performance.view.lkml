view: fact_marketing_performance {
  sql_table_name: `ra-development.analytics_ecommerce_ecommerce.fact_marketing_performance` ;;


  # Primary Key
  dimension: marketing_key {
    primary_key: yes
    type: string
    sql: ${TABLE}.marketing_key ;;
    description: "Marketing activity surrogate key"
  }

  # Date dimension
  dimension_group: activity {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.activity_date ;;
    description: "Activity date"
  }

  dimension: activity_date_key {
    type: number
    sql: CAST(FORMAT_DATE('%Y%m%d', ${TABLE}.activity_date) AS INT64) ;;
    description: "Activity date key for joins"
    hidden: yes
  }

  # Marketing identifiers
  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
    description: "Marketing platform (Google, Facebook, Instagram, etc.)"
  }

  dimension: marketing_type {
    type: string
    sql: ${TABLE}.marketing_type ;;
    description: "Type of marketing (paid_advertising, organic_social, email_marketing)"
  }

  dimension: content_type {
    type: string
    sql: ${TABLE}.content_type ;;
    description: "Type of content (campaign, post, email, etc.)"
  }

  dimension: content_name {
    type: string
    sql: ${TABLE}.content_name ;;
    description: "Name of the content/campaign"
  }

  dimension: utm_source {
    type: string
    sql: ${TABLE}.utm_source ;;
    description: "UTM source parameter"
  }

  dimension: utm_medium {
    type: string
    sql: ${TABLE}.utm_medium ;;
    description: "UTM medium parameter"
  }

  dimension: source_medium {
    type: string
    sql: CONCAT(${utm_source}, ' / ', ${utm_medium}) ;;
    description: "Source/Medium combination"
  }

  # Performance metrics
  dimension: spend_amount {
    type: number
    sql: ${TABLE}.spend_amount ;;
    description: "Advertising spend"
    value_format_name: usd
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
    description: "Number of clicks"
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
    description: "Number of impressions"
  }

  dimension: conversions {
    type: number
    sql: ${TABLE}.conversions ;;
    description: "Number of conversions"
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
    description: "Revenue attributed"
    value_format_name: usd
  }

  dimension: cost_per_click {
    type: number
    sql: ${TABLE}.cost_per_click ;;
    description: "Cost per click"
    value_format_name: usd
  }

  dimension: click_through_rate {
    type: number
    sql: ${TABLE}.click_through_rate ;;
    description: "Click-through rate"
    value_format_name: percent_2
  }

  dimension: return_on_ad_spend {
    type: number
    sql: ${TABLE}.return_on_ad_spend ;;
    description: "Return on ad spend (ROAS)"
    value_format_name: decimal_2
  }

  dimension: cost_per_acquisition {
    type: number
    sql: ${TABLE}.cost_per_acquisition ;;
    description: "Cost per acquisition (CPA)"
    value_format_name: usd
  }

  # Social engagement metrics
  dimension: likes {
    type: number
    sql: ${TABLE}.likes ;;
    description: "Number of likes (social posts)"
  }

  dimension: comments {
    type: number
    sql: ${TABLE}.comments ;;
    description: "Number of comments (social posts)"
  }

  dimension: shares {
    type: number
    sql: ${TABLE}.shares ;;
    description: "Number of shares (social posts)"
  }

  dimension: saves {
    type: number
    sql: ${TABLE}.saves ;;
    description: "Number of saves (social posts)"
  }

  dimension: engagement_rate {
    type: number
    sql: ${TABLE}.engagement_rate ;;
    description: "Engagement rate (social posts)"
    value_format_name: percent_2
  }

  dimension: performance_tier {
    type: string
    sql: ${TABLE}.performance_tier ;;
    description: "Performance tier classification"
  }

  # Metadata
  dimension: source_table {
    type: string
    sql: ${TABLE}.source_table ;;
    description: "Source table for this record"
  }

  # Measures
  measure: count {
    type: count
    description: "Number of marketing activities"
    drill_fields: [marketing_detail*]
  }

  measure: total_spend {
    type: sum
    sql: ${spend_amount} ;;
    description: "Total advertising spend"
    value_format_name: usd
  }

  measure: total_clicks {
    type: sum
    sql: ${clicks} ;;
    description: "Total clicks"
  }

  measure: total_impressions {
    type: sum
    sql: ${impressions} ;;
    description: "Total impressions"
  }

  measure: total_conversions {
    type: sum
    sql: ${conversions} ;;
    description: "Total conversions"
  }

  measure: total_revenue {
    type: sum
    sql: ${revenue} ;;
    description: "Total attributed revenue"
    value_format_name: usd
  }

  measure: overall_roas {
    type: number
    sql: ${total_revenue} / NULLIF(${total_spend}, 0) ;;
    description: "Overall return on ad spend"
    value_format_name: decimal_2
  }

  measure: overall_cpa {
    type: number
    sql: ${total_spend} / NULLIF(${total_conversions}, 0) ;;
    description: "Overall cost per acquisition"
    value_format_name: usd
  }

  measure: overall_ctr {
    type: number
    sql: ${total_clicks} / NULLIF(${total_impressions}, 0) ;;
    description: "Overall click-through rate"
    value_format_name: percent_2
  }

  measure: average_cpc {
    type: number
    sql: ${total_spend} / NULLIF(${total_clicks}, 0) ;;
    description: "Average cost per click"
    value_format_name: usd
  }

  # Social engagement measures
  measure: total_engagements {
    type: number
    sql: COALESCE(${likes}, 0) + COALESCE(${comments}, 0) + COALESCE(${shares}, 0) + COALESCE(${saves}, 0) ;;
    description: "Total social engagements"
  }

  measure: average_engagement_rate {
    type: average
    sql: ${engagement_rate} ;;
    description: "Average engagement rate"
    value_format_name: percent_2
  }

  # Sets
  set: marketing_detail {
    fields: [
      activity_date,
      platform,
      marketing_type,
      content_name,
      spend_amount,
      clicks,
      conversions,
      revenue,
      return_on_ad_spend
    ]
  }
}
