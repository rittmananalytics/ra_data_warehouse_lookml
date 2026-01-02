# =============================================================================
# AGG_CROSS_DOMAIN_CORRELATIONS - Cross-Domain Analysis
# Pre-computed correlations for the Cross-Domain Insights dashboard
# Grain: One row per correlation pair per time period
# Source: markr-data-lake.mark_dw_warehouse.agg_cross_domain_correlations
# =============================================================================

view: agg_cross_domain_correlations {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.agg_cross_domain_correlations` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: correlation_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.correlation_pk ;;
    hidden: yes
    description: "Primary key"
  }

  # =============================================================================
  # CORRELATION DIMENSIONS
  # =============================================================================

  dimension: analysis_period {
    type: string
    sql: ${TABLE}.analysis_period ;;
    label: "Analysis Period"
    description: "Period: All Time, Last Year, Last 90 Days"
  }

  dimension: domain_pair {
    type: string
    sql: ${TABLE}.domain_pair ;;
    label: "Domain Pair"
    description: "Domain pair: Sleep-Productivity, Exercise-Focus, etc."
  }

  dimension: metric_1_name {
    type: string
    sql: ${TABLE}.metric_1_name ;;
    label: "Metric 1"
    group_label: "Metrics"
    description: "First metric name"
  }

  dimension: metric_2_name {
    type: string
    sql: ${TABLE}.metric_2_name ;;
    label: "Metric 2"
    group_label: "Metrics"
    description: "Second metric name"
  }

  dimension: correlation_coefficient {
    type: number
    sql: ${TABLE}.correlation_coefficient ;;
    label: "Correlation (r)"
    value_format_name: decimal_2
    description: "Pearson correlation coefficient"
  }

  dimension: correlation_strength {
    type: string
    sql: ${TABLE}.correlation_strength ;;
    label: "Strength"
    description: "Strong, Moderate, Weak"
  }

  dimension: correlation_direction {
    type: string
    sql: ${TABLE}.correlation_direction ;;
    label: "Direction"
    description: "Positive, Negative"
  }

  dimension: sample_size {
    type: number
    sql: ${TABLE}.sample_size ;;
    label: "Sample Size"
    value_format_name: decimal_0
    description: "Number of data points"
  }

  dimension: insight_text {
    type: string
    sql: ${TABLE}.insight_text ;;
    label: "Insight"
    description: "Human-readable insight"
  }

  dimension_group: last_calculated {
    type: time
    timeframes: [raw, time, date, week, month]
    datatype: timestamp
    sql: ${TABLE}.last_calculated_ts ;;
    label: "Last Calculated"
    description: "When correlation was last calculated"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Correlation Count"
    drill_fields: [domain_pair, metric_1_name, metric_2_name, correlation_coefficient, correlation_strength]
  }

  measure: avg_correlation {
    type: average
    sql: ABS(${correlation_coefficient}) ;;
    label: "Avg Correlation Strength"
    value_format_name: decimal_2
    description: "Average absolute correlation coefficient"
  }

  measure: strong_correlations {
    type: count
    filters: [correlation_strength: "Strong"]
    label: "Strong Correlations"
  }

  measure: positive_correlations {
    type: count
    filters: [correlation_direction: "Positive"]
    label: "Positive Correlations"
  }

  measure: negative_correlations {
    type: count
    filters: [correlation_direction: "Negative"]
    label: "Negative Correlations"
  }
}
