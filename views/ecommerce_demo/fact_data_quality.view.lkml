view: fact_data_quality {
  sql_table_name: `ra-development.analytics_ecommerce_ecommerce.fact_data_quality` ;;

  # Primary Key
  dimension: data_quality_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.data_quality_key ;;
    description: "Data quality surrogate key"
  }

  # Foreign Keys
  dimension: report_date_key {
    type: string
    sql: ${TABLE}.report_date_key ;;
    description: "Report date key (YYYYMMDD)"
    hidden: yes
  }

  # Data Source Information
  dimension: data_source {
    type: string
    sql: ${TABLE}.data_source ;;
    description: "Data source name (Shopify, Google Ads, etc.)"
  }

  dimension: data_layer {
    type: string
    sql: ${TABLE}.data_layer ;;
    description: "Data layer (source, staging, integration, warehouse)"
  }

  dimension: table_name {
    type: string
    sql: ${TABLE}.table_name ;;
    description: "Table name"
  }

  dimension: source_layer_combination {
    type: string
    sql: CONCAT(${data_source}, ' - ', ${data_layer}) ;;
    description: "Data source and layer combination"
  }

  # Data Volume Metrics
  dimension: total_rows {
    type: number
    sql: ${TABLE}.total_rows ;;
    description: "Total number of rows"
  }

  dimension: table_count {
    type: number
    sql: ${TABLE}.table_count ;;
    description: "Number of tables in this data source/layer"
  }

  # Data Quality Test Results
  dimension: tests_run {
    type: number
    sql: ${TABLE}.tests_run ;;
    description: "Number of data quality tests executed"
  }

  dimension: tests_passed {
    type: number
    sql: ${TABLE}.tests_passed ;;
    description: "Number of tests that passed"
  }

  dimension: tests_failed {
    type: number
    sql: ${TABLE}.tests_failed ;;
    description: "Number of tests that failed"
  }

  dimension: test_pass_rate {
    type: number
    sql: ${TABLE}.test_pass_rate ;;
    description: "Test pass rate percentage"
    value_format_name: percent_1
  }

  # Data Flow Metrics
  dimension: source_to_staging_flow_pct {
    type: number
    sql: ${TABLE}.source_to_staging_flow_pct ;;
    description: "Percentage of source data flowing to staging"
    value_format_name: percent_1
  }

  dimension: staging_to_integration_flow_pct {
    type: number
    sql: ${TABLE}.staging_to_integration_flow_pct ;;
    description: "Percentage of staging data flowing to integration"
    value_format_name: percent_1
  }

  dimension: integration_to_warehouse_flow_pct {
    type: number
    sql: ${TABLE}.integration_to_warehouse_flow_pct ;;
    description: "Percentage of integration data flowing to warehouse"
    value_format_name: percent_1
  }

  dimension: end_to_end_flow_pct {
    type: number
    sql: ${TABLE}.end_to_end_flow_pct ;;
    description: "End-to-end data flow percentage"
    value_format_name: percent_1
  }

  # Pipeline Health Metrics
  dimension: pipeline_health_score {
    type: number
    sql: ${TABLE}.pipeline_health_score ;;
    description: "Overall pipeline health score"
    value_format_name: decimal_1
  }

  dimension: data_freshness_hours {
    type: number
    sql: ${TABLE}.data_freshness_hours ;;
    description: "Data freshness in hours"
    value_format_name: decimal_1
  }

  dimension: data_completeness_pct {
    type: number
    sql: ${TABLE}.data_completeness_pct ;;
    description: "Data completeness percentage"
    value_format_name: percent_1
  }

  # Data Quality Categories
  dimension: quality_tier {
    type: string
    sql: CASE
      WHEN ${test_pass_rate} >= 0.95 THEN 'Excellent'
      WHEN ${test_pass_rate} >= 0.90 THEN 'Good'
      WHEN ${test_pass_rate} >= 0.80 THEN 'Fair'
      ELSE 'Poor'
    END ;;
    description: "Data quality tier based on test pass rate"
  }

  dimension: flow_efficiency {
    type: string
    sql: CASE
      WHEN ${end_to_end_flow_pct} >= 0.90 THEN 'Highly Efficient'
      WHEN ${end_to_end_flow_pct} >= 0.75 THEN 'Efficient'
      WHEN ${end_to_end_flow_pct} >= 0.50 THEN 'Moderate'
      ELSE 'Inefficient'
    END ;;
    description: "Data flow efficiency category"
  }

  dimension: health_status {
    type: string
    sql: CASE
      WHEN ${pipeline_health_score} >= 8.0 THEN 'Healthy'
      WHEN ${pipeline_health_score} >= 6.0 THEN 'Warning'
      WHEN ${pipeline_health_score} >= 4.0 THEN 'Critical'
      ELSE 'Failed'
    END ;;
    description: "Pipeline health status"
  }

  dimension: freshness_status {
    type: string
    sql: CASE
      WHEN ${data_freshness_hours} <= 2 THEN 'Very Fresh'
      WHEN ${data_freshness_hours} <= 6 THEN 'Fresh'
      WHEN ${data_freshness_hours} <= 24 THEN 'Acceptable'
      ELSE 'Stale'
    END ;;
    description: "Data freshness status"
  }

  dimension: completeness_status {
    type: string
    sql: CASE
      WHEN ${data_completeness_pct} >= 0.95 THEN 'Complete'
      WHEN ${data_completeness_pct} >= 0.85 THEN 'Mostly Complete'
      WHEN ${data_completeness_pct} >= 0.70 THEN 'Partial'
      ELSE 'Incomplete'
    END ;;
    description: "Data completeness status"
  }

  # Data Source Performance
  dimension: volume_tier {
    type: tier
    tiers: [0, 100, 1000, 10000, 100000, 1000000]
    style: relational
    sql: ${total_rows} ;;
    description: "Data volume tier"
  }

  dimension: is_critical_source {
    type: yesno
    sql: ${data_source} IN ('Shopify', 'Google Analytics 4', 'Google Ads') ;;
    description: "Critical data source indicator"
  }

  dimension: has_quality_issues {
    type: yesno
    sql: ${test_pass_rate} < 0.90 OR ${end_to_end_flow_pct} < 0.75 ;;
    description: "Has data quality issues"
  }

  dimension: requires_attention {
    type: yesno
    sql: ${pipeline_health_score} < 7.0 OR ${data_freshness_hours} > 12 ;;
    description: "Requires immediate attention"
  }

  # Time Dimensions
  dimension_group: report {
    type: time
    timeframes: [raw, date, week, month, quarter, year, day_of_week]
    sql: ${TABLE}.report_date ;;
    description: "Report date"
  }

  dimension_group: last_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_updated ;;
    description: "Last update timestamp"
  }

  dimension_group: data_load {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.data_load_timestamp ;;
    description: "Data load timestamp"
  }

  # Issue Tracking
  dimension: error_count {
    type: number
    sql: ${TABLE}.error_count ;;
    description: "Number of errors encountered"
  }

  dimension: warning_count {
    type: number
    sql: ${TABLE}.warning_count ;;
    description: "Number of warnings generated"
  }

  dimension: has_errors {
    type: yesno
    sql: ${error_count} > 0 ;;
    description: "Has errors"
  }

  dimension: has_warnings {
    type: yesno
    sql: ${warning_count} > 0 ;;
    description: "Has warnings"
  }

  # Measures
  measure: count {
    type: count
    description: "Number of data quality records"
    drill_fields: [report_date, data_source, data_layer, total_rows, test_pass_rate, pipeline_health_score]
  }

  measure: count_data_sources {
    type: count_distinct
    sql: ${data_source} ;;
    description: "Number of unique data sources"
  }

  measure: total_data_volume {
    type: sum
    sql: ${total_rows} ;;
    description: "Total data volume (rows)"
    drill_fields: [data_source, data_layer, total_rows]
  }

  measure: total_tests_run {
    type: sum
    sql: ${tests_run} ;;
    description: "Total tests executed"
  }

  measure: total_tests_passed {
    type: sum
    sql: ${tests_passed} ;;
    description: "Total tests passed"
  }

  measure: total_tests_failed {
    type: sum
    sql: ${tests_failed} ;;
    description: "Total tests failed"
  }

  measure: overall_test_pass_rate {
    type: number
    sql: ${total_tests_passed} / NULLIF(${total_tests_run}, 0) ;;
    description: "Overall test pass rate"
    value_format_name: percent_1
  }

  measure: average_pipeline_health {
    type: average
    sql: ${pipeline_health_score} ;;
    description: "Average pipeline health score"
    value_format_name: decimal_1
  }

  measure: average_flow_efficiency {
    type: average
    sql: ${end_to_end_flow_pct} ;;
    description: "Average end-to-end flow percentage"
    value_format_name: percent_1
  }

  measure: average_data_freshness {
    type: average
    sql: ${data_freshness_hours} ;;
    description: "Average data freshness (hours)"
    value_format_name: decimal_1
  }

  measure: sources_with_issues {
    type: count
    filters: [has_quality_issues: "yes"]
    description: "Number of sources with quality issues"
  }

  measure: sources_requiring_attention {
    type: count
    filters: [requires_attention: "yes"]
    description: "Number of sources requiring attention"
  }

  measure: critical_sources_healthy {
    type: count
    filters: [is_critical_source: "yes", health_status: "Healthy"]
    description: "Number of healthy critical sources"
  }

  measure: data_quality_score {
    type: number
    sql: (${overall_test_pass_rate} * 0.4) +
         (${average_flow_efficiency} * 0.3) +
         (${average_pipeline_health} / 10 * 0.3) ;;
    description: "Composite data quality score"
    value_format_name: percent_1
  }

  measure: total_errors {
    type: sum
    sql: ${error_count} ;;
    description: "Total error count"
  }

  measure: total_warnings {
    type: sum
    sql: ${warning_count} ;;
    description: "Total warning count"
  }

  measure: error_rate {
    type: number
    sql: ${total_errors} / NULLIF(${total_data_volume}, 0) ;;
    description: "Error rate (errors per row)"
    value_format_name: percent_4
  }
}
