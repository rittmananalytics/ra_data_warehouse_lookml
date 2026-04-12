# kpi_scorecard.view.lkml
# Exposes the mart_kpi_scorecard dbt table (alias: kpi_scorecard)
# Table: ra-development.analytics.kpi_scorecard
# Partitioned by report_month (MONTH), clustered by kpi_domain + kpi_code

view: kpi_scorecard {
  sql_table_name: `ra-development.analytics.kpi_scorecard` ;;

  # ── Primary key ───────────────────────────────────────────────────────────────

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${kpi_code}, '|', CAST(${report_month_date} AS STRING)) ;;
  }

  # ── Time dimensions ───────────────────────────────────────────────────────────

  dimension_group: report_month {
    label:       "Report"
    description: "The month this KPI row covers."
    type:        time
    timeframes:  [month, quarter, year, date]
    datatype:    date
    sql:         ${TABLE}.report_month ;;
  }

  dimension: is_current_month {
    label:       "Is Current Month"
    description: "Yes for the most recent (current/partial) month."
    type:        yesno
    sql:         ${TABLE}.report_month = DATE_TRUNC(CURRENT_DATE(), MONTH) ;;
  }

  dimension: is_complete_month {
    label:       "Is Complete Month"
    description: "Yes for fully elapsed months only (excludes the current partial month)."
    type:        yesno
    sql:         ${TABLE}.report_month < DATE_TRUNC(CURRENT_DATE(), MONTH) ;;
  }

  dimension_group: scored_at {
    label:       "Scored At"
    description: "When this row was last computed."
    type:        time
    timeframes:  [time, date, month]
    sql:         ${TABLE}.scored_at ;;
  }

  # ── KPI identity ──────────────────────────────────────────────────────────────

  dimension: kpi_code {
    label:       "KPI Code"
    description: "Short code identifying the KPI, e.g. FIN_01, DEL_03."
    type:        string
    sql:         ${TABLE}.kpi_code ;;
    tags:        ["kpi_code"]
  }

  dimension: kpi_name {
    label:       "KPI Name"
    description: "Full display name of the KPI."
    type:        string
    sql:         ${TABLE}.kpi_name ;;
  }

  dimension: kpi_domain {
    label:       "KPI Domain"
    description: "The five top-level performance domains."
    type:        string
    sql:         ${TABLE}.kpi_domain ;;
    suggestions: [
      "Financial Health",
      "Commercial Pipeline",
      "Delivery Engine",
      "People & Capacity",
      "Market & Brand"
    ]
  }

  dimension: kpi_unit {
    label:       "KPI Unit"
    description: "Unit of measurement for kpi_value: %, days, weeks, count, score."
    type:        string
    sql:         ${TABLE}.kpi_unit ;;
  }

  dimension: higher_is_better {
    label:       "Higher Is Better"
    description: "Whether a higher KPI value is desirable (true) or lower is better (false)."
    type:        yesno
    sql:         ${TABLE}.higher_is_better ;;
  }

  # ── KPI values ────────────────────────────────────────────────────────────────

  dimension: kpi_value {
    label:       "KPI Value"
    description: "The computed KPI result for the reporting month."
    type:        number
    sql:         ${TABLE}.kpi_value ;;
    value_format: "#,##0.00"
  }

  dimension: kpi_value_formatted {
    label:       "KPI Value (Formatted)"
    description: "KPI value with its unit appended (e.g. '87.3 %', '28 days')."
    type:        string
    sql: CASE
           WHEN ${TABLE}.kpi_value IS NULL THEN '—'
           WHEN ${TABLE}.kpi_unit = '%'
             THEN CONCAT(ROUND(${TABLE}.kpi_value, 1), ' %')
           WHEN ${TABLE}.kpi_unit IN ('days','weeks','count','score')
             THEN CONCAT(ROUND(${TABLE}.kpi_value, 1), ' ', ${TABLE}.kpi_unit)
           ELSE CAST(ROUND(${TABLE}.kpi_value, 2) AS STRING)
         END ;;
  }

  dimension: kpi_input_value {
    label:       "KPI Input Value"
    description: "The raw numerator or input quantity feeding kpi_value (e.g. actual £ for financial KPIs)."
    type:        number
    sql:         ${TABLE}.kpi_input_value ;;
    value_format: "#,##0.00"
  }

  dimension: kpi_target_value {
    label:       "KPI Target Value (Pro-Rated)"
    description: "The target for this period, pro-rated MTD/QTD for the current incomplete period."
    type:        number
    sql:         ${TABLE}.kpi_target_value ;;
    value_format: "#,##0.00"
  }

  dimension: kpi_target {
    label:       "KPI Target (Full Period)"
    description: "The full-period static target (not pro-rated)."
    type:        number
    sql:         ${TABLE}.kpi_target ;;
    value_format: "#,##0.00"
  }

  dimension: pct_of_target {
    label:       "% of Target"
    description: "KPI value as a percentage of the full-period target. NULL when target or value is missing."
    type:        number
    sql: SAFE_DIVIDE(${TABLE}.kpi_value, NULLIF(${TABLE}.kpi_target, 0)) * 100 ;;
    value_format: "0.00"
  }

  # ── Thresholds ────────────────────────────────────────────────────────────────

  dimension: green_threshold {
    label:       "Green Threshold"
    description: "The threshold at which this KPI scores GREEN."
    type:        number
    sql:         ${TABLE}.green_threshold ;;
    value_format: "#,##0.00"
  }

  dimension: amber_threshold {
    label:       "Amber Threshold"
    description: "The threshold at which this KPI scores AMBER (below this = RED)."
    type:        number
    sql:         ${TABLE}.amber_threshold ;;
    value_format: "#,##0.00"
  }

  # ── Fractions ─────────────────────────────────────────────────────────────────

  dimension: mtd_fraction {
    label:       "MTD Fraction"
    description: "Days elapsed in the current month / days in month. 1.0 for complete months."
    type:        number
    sql:         ${TABLE}.mtd_fraction ;;
    value_format: "0.0000"
  }

  dimension: qtd_fraction {
    label:       "QTD Fraction"
    description: "Days elapsed in the current quarter / days in quarter. 1.0 for complete quarters."
    type:        number
    sql:         ${TABLE}.qtd_fraction ;;
    value_format: "0.0000"
  }

  # ── RAG Status ────────────────────────────────────────────────────────────────

  dimension: kpi_rag_status {
    label:       "RAG Status"
    description: "GREEN / AMBER / RED / UNSCORED based on kpi_value vs thresholds."
    type:        string
    sql:         ${TABLE}.kpi_rag_status ;;
    suggestions: ["GREEN", "AMBER", "RED", "UNSCORED"]
    html:
      {% if value == 'GREEN' %}
        <span style="color:#ffffff;background:#1e8a44;padding:2px 8px;border-radius:4px;font-weight:bold;">{{ value }}</span>
      {% elsif value == 'AMBER' %}
        <span style="color:#ffffff;background:#e08600;padding:2px 8px;border-radius:4px;font-weight:bold;">{{ value }}</span>
      {% elsif value == 'RED' %}
        <span style="color:#ffffff;background:#c0392b;padding:2px 8px;border-radius:4px;font-weight:bold;">{{ value }}</span>
      {% else %}
        <span style="color:#555555;background:#e0e0e0;padding:2px 8px;border-radius:4px;font-weight:bold;">{{ value }}</span>
      {% endif %}
    ;;
  }

  dimension: kpi_rag_sort_order {
    label:       "RAG Sort Order"
    description: "Numeric sort key for RAG status: RED=1, AMBER=2, GREEN=3, UNSCORED=4."
    hidden:      yes
    type:        number
    sql: CASE ${TABLE}.kpi_rag_status
           WHEN 'RED'      THEN 1
           WHEN 'AMBER'    THEN 2
           WHEN 'GREEN'    THEN 3
           ELSE 4
         END ;;
  }

  # ── Measures ──────────────────────────────────────────────────────────────────

  measure: count {
    label:       "Count KPIs"
    description: "Number of KPI rows (one per KPI per month)."
    type:        count
    drill_fields: [kpi_code, kpi_name, kpi_domain, report_month_month, kpi_value_formatted, kpi_rag_status]
  }

  measure: count_green {
    label:       "Count GREEN"
    description: "Number of KPI months with GREEN RAG status."
    type:        count
    filters:     [kpi_rag_status: "GREEN"]
    drill_fields: [kpi_code, kpi_name, report_month_month, kpi_value_formatted]
  }

  measure: count_amber {
    label:       "Count AMBER"
    description: "Number of KPI months with AMBER RAG status."
    type:        count
    filters:     [kpi_rag_status: "AMBER"]
    drill_fields: [kpi_code, kpi_name, report_month_month, kpi_value_formatted]
  }

  measure: count_red {
    label:       "Count RED"
    description: "Number of KPI months with RED RAG status."
    type:        count
    filters:     [kpi_rag_status: "RED"]
    drill_fields: [kpi_code, kpi_name, report_month_month, kpi_value_formatted]
  }

  measure: count_unscored {
    label:       "Count UNSCORED"
    description: "Number of KPI months where kpi_value was NULL."
    type:        count
    filters:     [kpi_rag_status: "UNSCORED"]
  }

  measure: pct_green {
    label:       "% GREEN"
    description: "Percentage of scored KPI months that are GREEN."
    type:        number
    sql: SAFE_DIVIDE(${count_green}, NULLIF(${count_green} + ${count_amber} + ${count_red}, 0)) * 100 ;;
    value_format: "0.00"
  }

  measure: latest_kpi_value {
    label:       "Latest KPI Value"
    description: "Maximum kpi_value across the filtered rows — use with a single KPI filter to get its most recent value."
    type:        max
    sql:         ${TABLE}.kpi_value ;;
    value_format: "#,##0.00"
  }

  measure: avg_kpi_value {
    label:       "Avg KPI Value"
    description: "Average kpi_value across the filtered rows."
    type:        average
    sql:         ${TABLE}.kpi_value ;;
    value_format: "#,##0.00"
  }

  measure: max_kpi_value {
    label:       "Max KPI Value"
    type:        max
    sql:         ${TABLE}.kpi_value ;;
    value_format: "#,##0.00"
  }

  measure: min_kpi_value {
    label:       "Min KPI Value"
    type:        min
    sql:         ${TABLE}.kpi_value ;;
    value_format: "#,##0.00"
  }
}
