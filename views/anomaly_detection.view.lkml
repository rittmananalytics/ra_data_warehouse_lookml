view: anomaly_detection {
  view_label: "Daily Anomaly Detection - Web Events"
    derived_table: {
      sql: WITH base_events AS (
          SELECT
              event_type,
              event_ts,
              DATE(event_ts) AS event_date
          FROM `ra-development.analytics.web_events_fact`
          WHERE event_type IN (
              'Page View',
              'Button Clicked',
              'Contact Us',
              'Icp Modal Displayed',
              'Displayed Popup'
            )
          ),

        event_counts AS (
        SELECT
        event_date,
        event_type,
        COUNT(*) AS event_count
        FROM base_events
        GROUP BY event_date, event_type
        ),

        pivoted_counts AS (
        SELECT
        event_date,
        COALESCE(MAX(CASE WHEN event_type = 'Page View' THEN event_count END), 0) AS page_view_count,
        COALESCE(MAX(CASE WHEN event_type = 'Button Clicked' THEN event_count END), 0) AS button_clicked_count,
        COALESCE(MAX(CASE WHEN event_type = 'Contact Us' THEN event_count END), 0) AS contact_us_count,
        COALESCE(MAX(CASE WHEN event_type = 'Icp Modal Displayed' THEN event_count END), 0) AS icp_modal_displayed_count,
        COALESCE(MAX(CASE WHEN event_type = 'Displayed Popup' THEN event_count END), 0) AS displayed_popup_count
        FROM event_counts
        GROUP BY event_date
        ),

        event_ratios AS (
        SELECT
        *,
        CASE WHEN page_view_count != 0 THEN SAFE_DIVIDE(icp_modal_displayed_count, page_view_count) ELSE NULL END AS icp_modal_displayed_ratio,
        CASE WHEN page_view_count != 0 THEN SAFE_DIVIDE(displayed_popup_count, page_view_count) ELSE NULL END AS displayed_popup_ratio
        FROM pivoted_counts
        ),

        ratio_stats AS (
        SELECT
        r1.event_date,
        APPROX_QUANTILES(r2.icp_modal_displayed_ratio, 4)[OFFSET(1)] AS icp_modal_displayed_ratio_q1,
        APPROX_QUANTILES(r2.icp_modal_displayed_ratio, 4)[OFFSET(3)] AS icp_modal_displayed_ratio_q3,
        APPROX_QUANTILES(r2.displayed_popup_ratio, 4)[OFFSET(1)] AS displayed_popup_ratio_q1,
        APPROX_QUANTILES(r2.displayed_popup_ratio, 4)[OFFSET(3)] AS displayed_popup_ratio_q3
        FROM event_ratios r1
        JOIN event_ratios r2
        ON r2.event_date BETWEEN DATE_SUB(r1.event_date, INTERVAL 371 DAY) AND DATE_SUB(r1.event_date, INTERVAL 1 DAY)
        WHERE r2.icp_modal_displayed_ratio IS NOT NULL OR r2.displayed_popup_ratio IS NOT NULL
        GROUP BY r1.event_date
        ),

        count_stats AS (
        SELECT
        r1.event_date,
        APPROX_QUANTILES(r2.page_view_count, 4)[OFFSET(1)] AS page_view_count_q1,
        APPROX_QUANTILES(r2.page_view_count, 4)[OFFSET(3)] AS page_view_count_q3,
        APPROX_QUANTILES(r2.button_clicked_count, 4)[OFFSET(1)] AS button_clicked_count_q1,
        APPROX_QUANTILES(r2.button_clicked_count, 4)[OFFSET(3)] AS button_clicked_count_q3,
        APPROX_QUANTILES(r2.contact_us_count, 4)[OFFSET(1)] AS contact_us_count_q1,
        APPROX_QUANTILES(r2.contact_us_count, 4)[OFFSET(3)] AS contact_us_count_q3,
        APPROX_QUANTILES(r2.icp_modal_displayed_count, 4)[OFFSET(1)] AS icp_modal_displayed_count_q1,
        APPROX_QUANTILES(r2.icp_modal_displayed_count, 4)[OFFSET(3)] AS icp_modal_displayed_count_q3,
        APPROX_QUANTILES(r2.displayed_popup_count, 4)[OFFSET(1)] AS displayed_popup_count_q1,
        APPROX_QUANTILES(r2.displayed_popup_count, 4)[OFFSET(3)] AS displayed_popup_count_q3
        FROM pivoted_counts r1
        JOIN pivoted_counts r2
        ON r2.event_date BETWEEN DATE_SUB(r1.event_date, INTERVAL 371 DAY) AND DATE_SUB(r1.event_date, INTERVAL 1 DAY)
        GROUP BY r1.event_date
        )

        SELECT
        r.*,
        -- ICP Modal Displayed Ratio Anomaly Detection
        rs.icp_modal_displayed_ratio_q1,
        rs.icp_modal_displayed_ratio_q3,
        (rs.icp_modal_displayed_ratio_q3 - rs.icp_modal_displayed_ratio_q1) AS icp_modal_displayed_ratio_iqr,
        (rs.icp_modal_displayed_ratio_q1 - {% parameter lower_bound_multiplier %} * (rs.icp_modal_displayed_ratio_q3 - rs.icp_modal_displayed_ratio_q1)) AS icp_modal_displayed_ratio_lower_bound,
        (rs.icp_modal_displayed_ratio_q3 + {% parameter upper_bound_multiplier %} * (rs.icp_modal_displayed_ratio_q3 - rs.icp_modal_displayed_ratio_q1)) AS icp_modal_displayed_ratio_upper_bound,
        CASE WHEN r.icp_modal_displayed_ratio < (rs.icp_modal_displayed_ratio_q1 - {% parameter lower_bound_multiplier %} * (rs.icp_modal_displayed_ratio_q3 - rs.icp_modal_displayed_ratio_q1))
        OR r.icp_modal_displayed_ratio > (rs.icp_modal_displayed_ratio_q3 + {% parameter upper_bound_multiplier %} * (rs.icp_modal_displayed_ratio_q3 - rs.icp_modal_displayed_ratio_q1)) THEN TRUE ELSE FALSE END AS is_icp_modal_displayed_ratio_anomalous,

        -- Displayed Popup Ratio Anomaly Detection
        rs.displayed_popup_ratio_q1,
        rs.displayed_popup_ratio_q3,
        (rs.displayed_popup_ratio_q3 - rs.displayed_popup_ratio_q1) AS displayed_popup_ratio_iqr,
        (rs.displayed_popup_ratio_q1 - {% parameter lower_bound_multiplier %} * (rs.displayed_popup_ratio_q3 - rs.displayed_popup_ratio_q1)) AS displayed_popup_ratio_lower_bound,
        (rs.displayed_popup_ratio_q3 + {% parameter upper_bound_multiplier %} * (rs.displayed_popup_ratio_q3 - rs.displayed_popup_ratio_q1)) AS displayed_popup_ratio_upper_bound,
        CASE WHEN r.displayed_popup_ratio < (rs.displayed_popup_ratio_q1 - {% parameter lower_bound_multiplier %} * (rs.displayed_popup_ratio_q3 - rs.displayed_popup_ratio_q1))
        OR r.displayed_popup_ratio > (rs.displayed_popup_ratio_q3 + {% parameter upper_bound_multiplier %} * (rs.displayed_popup_ratio_q3 - rs.displayed_popup_ratio_q1)) THEN TRUE ELSE FALSE END AS is_displayed_popup_ratio_anomalous,

        -- Page View Count Anomaly Detection
        cs.page_view_count_q1,
        cs.page_view_count_q3,
        (cs.page_view_count_q3 - cs.page_view_count_q1) AS page_view_count_iqr,
        (cs.page_view_count_q1 - {% parameter lower_bound_multiplier %} * (cs.page_view_count_q3 - cs.page_view_count_q1)) AS page_view_count_lower_bound,
        (cs.page_view_count_q3 + {% parameter upper_bound_multiplier %} * (cs.page_view_count_q3 - cs.page_view_count_q1)) AS page_view_count_upper_bound,
        CASE WHEN r.page_view_count < (cs.page_view_count_q1 - {% parameter lower_bound_multiplier %} * (cs.page_view_count_q3 - cs.page_view_count_q1))
        OR r.page_view_count > (cs.page_view_count_q3 + {% parameter upper_bound_multiplier %} * (cs.page_view_count_q3 - cs.page_view_count_q1)) THEN TRUE ELSE FALSE END AS is_page_view_count_anomalous,

        -- Button Clicked Count Anomaly Detection
        cs.button_clicked_count_q1,
        cs.button_clicked_count_q3,
        (cs.button_clicked_count_q3 - cs.button_clicked_count_q1) AS button_clicked_count_iqr,
        (cs.button_clicked_count_q1 - {% parameter lower_bound_multiplier %} * (cs.button_clicked_count_q3 - cs.button_clicked_count_q1)) AS button_clicked_count_lower_bound,
        (cs.button_clicked_count_q3 + {% parameter upper_bound_multiplier %} * (cs.button_clicked_count_q3 - cs.button_clicked_count_q1)) AS button_clicked_count_upper_bound,
        CASE
        WHEN r.button_clicked_count < (cs.button_clicked_count_q1 - {% parameter lower_bound_multiplier %} * (cs.button_clicked_count_q3 - cs.button_clicked_count_q1))
        OR r.button_clicked_count > (cs.button_clicked_count_q3 + {% parameter upper_bound_multiplier %} * (cs.button_clicked_count_q3 - cs.button_clicked_count_q1))
        THEN TRUE ELSE FALSE
        END AS is_button_clicked_count_anomalous,

        -- Contact Us Count Anomaly Detection
        cs.contact_us_count_q1,
        cs.contact_us_count_q3,
        (cs.contact_us_count_q3 - cs.contact_us_count_q1) AS contact_us_count_iqr,
        (cs.contact_us_count_q1 - {% parameter lower_bound_multiplier %} * (cs.contact_us_count_q3 - cs.contact_us_count_q1)) AS contact_us_count_lower_bound,
        (cs.contact_us_count_q3 + {% parameter upper_bound_multiplier %} * (cs.contact_us_count_q3 - cs.contact_us_count_q1)) AS contact_us_count_upper_bound,
        CASE
        WHEN r.contact_us_count < (cs.contact_us_count_q1 - {% parameter lower_bound_multiplier %} * (cs.contact_us_count_q3 - cs.contact_us_count_q1))
        OR r.contact_us_count > (cs.contact_us_count_q3 + {% parameter upper_bound_multiplier %} * (cs.contact_us_count_q3 - cs.contact_us_count_q1))
        THEN TRUE ELSE FALSE
        END AS is_contact_us_count_anomalous,

        -- ICP Modal Displayed Count Anomaly Detection
        cs.icp_modal_displayed_count_q1,
        cs.icp_modal_displayed_count_q3,
        (cs.icp_modal_displayed_count_q3 - cs.icp_modal_displayed_count_q1) AS icp_modal_displayed_count_iqr,
        (cs.icp_modal_displayed_count_q1 - {% parameter lower_bound_multiplier %} * (cs.icp_modal_displayed_count_q3 - cs.icp_modal_displayed_count_q1)) AS icp_modal_displayed_count_lower_bound,
        (cs.icp_modal_displayed_count_q3 + {% parameter upper_bound_multiplier %} * (cs.icp_modal_displayed_count_q3 - cs.icp_modal_displayed_count_q1)) AS icp_modal_displayed_count_upper_bound,
        CASE
        WHEN r.icp_modal_displayed_count < (cs.icp_modal_displayed_count_q1 - {% parameter lower_bound_multiplier %} * (cs.icp_modal_displayed_count_q3 - cs.icp_modal_displayed_count_q1))
        OR r.icp_modal_displayed_count > (cs.icp_modal_displayed_count_q3 + {% parameter upper_bound_multiplier %} * (cs.icp_modal_displayed_count_q3 - cs.icp_modal_displayed_count_q1))
        THEN TRUE ELSE FALSE
        END AS is_icp_modal_displayed_count_anomalous,

        -- Displayed Popup Count Anomaly Detection
        cs.displayed_popup_count_q1,
        cs.displayed_popup_count_q3,
        (cs.displayed_popup_count_q3 - cs.displayed_popup_count_q1) AS displayed_popup_count_iqr,
        (cs.displayed_popup_count_q1 - {% parameter lower_bound_multiplier %} * (cs.displayed_popup_count_q3 - cs.displayed_popup_count_q1)) AS displayed_popup_count_lower_bound,
        (cs.displayed_popup_count_q3 + {% parameter upper_bound_multiplier %} * (cs.displayed_popup_count_q3 - cs.displayed_popup_count_q1)) AS displayed_popup_count_upper_bound,
        CASE
        WHEN r.displayed_popup_count < (cs.displayed_popup_count_q1 - {% parameter lower_bound_multiplier %} * (cs.displayed_popup_count_q3 - cs.displayed_popup_count_q1))
        OR r.displayed_popup_count > (cs.displayed_popup_count_q3 + {% parameter upper_bound_multiplier %} * (cs.displayed_popup_count_q3 - cs.displayed_popup_count_q1))
        THEN TRUE ELSE FALSE
        END AS is_displayed_popup_count_anomalous

        FROM event_ratios r
        LEFT JOIN ratio_stats rs ON r.event_date = rs.event_date
        LEFT JOIN count_stats cs ON r.event_date = cs.event_date
        WHERE r.event_date >= '2025-01-01';;
    }

#######################################################
    # Parameters
    #######################################################

    parameter: anomaly_metric {
      allowed_value: {label: "Page View Count" value: "PAGE_VIEW_COUNT"}
      allowed_value: {label: "Button Clicked Count" value: "BUTTON_CLICKED_COUNT"}
      allowed_value: {label: "Contact Us Count" value: "CONTACT_US_COUNT"}
      allowed_value: {label: "ICP Modal Displayed Count" value: "ICP_MODAL_DISPLAYED_COUNT"}
      allowed_value: {label: "Displayed Popup Count" value: "DISPLAYED_POPUP_COUNT"}
      allowed_value: {label: "ICP Modal Display Ratio" value: "ICP_MODAL_DISPLAYED_RATIO"}
      allowed_value: {label: "Displayed Popup Ratio" value: "DISPLAYED_POPUP_RATIO"}
      default_value: "PAGE_VIEW_COUNT"
      type: unquoted
      label: "Metric Selector"
      group_label: "Parameters"
      description: "Choose which metric (count or ratio) to evaluate for anomalies."
    }

    parameter: upper_bound_multiplier {
      allowed_value: {label: "1.0" value: "1.0"}
      allowed_value: {label: "1.5" value: "1.5"}
      allowed_value: {label: "2.0" value: "2.0"}
      allowed_value: {label: "2.5" value: "2.5"}
      default_value: "1.5"
      type: unquoted
      label: "Upper Bound Multiplier"
      group_label: "Parameters"
      description: "Multiplier applied to the IQR to calculate the upper threshold for anomaly detection."
    }

    parameter: lower_bound_multiplier {
      allowed_value: {label: "0.0" value: "0.0"}
      allowed_value: {label: "0.5" value: "0.5"}
      allowed_value: {label: "1.0" value: "1.0"}
      allowed_value: {label: "1.5" value: "1.5"}
      allowed_value: {label: "2.0" value: "2.0"}
      allowed_value: {label: "2.5" value: "2.5"}
      default_value: "1.5"
      type: unquoted
      label: "Lower Bound Multiplier"
      group_label: "Parameters"
      description: "Multiplier applied to the IQR to calculate the lower threshold for anomaly detection."
    }

    #######################################################
    # Anomaly Metrics
    #######################################################

    measure: metric {
      label_from_parameter: anomaly_metric
      description: "Total value of the selected metric used for anomaly detection."
      group_label: "Anomaly Metrics"
      type: sum
      sql: ${TABLE}.{% parameter anomaly_metric %} ;;
    }

    measure: metric_q1 {
      label: "Metric Q1"
      description: "Q1 value for the anomaly metric"
      group_label: "Anomaly Metrics"
      type: average
      sql: ${TABLE}.{% parameter anomaly_metric %}_Q1 ;;
    }

    measure: metric_q3 {
      label: "Metric Q3"
      description: "Q3 value for the anomaly metric"
      group_label: "Anomaly Metrics"
      type: average
      sql: ${TABLE}.{% parameter anomaly_metric %}_Q3 ;;
    }

    measure: metric_iqr {
      label: "Metric IQR"
      description: "IQR value for the anomaly metric"
      group_label: "Anomaly Metrics"
      type: average
      sql: ${TABLE}.{% parameter anomaly_metric %}_IQR ;;
    }

    measure: metric_lower_bound {
      label: "Metric Lower Bound"
      description: "Lower bound value for the anomaly metric"
      group_label: "Anomaly Metrics"
      type: average
      sql: ${TABLE}.{% parameter anomaly_metric %}_LOWER_BOUND ;;
    }

    measure: metric_upper_bound {
      label: "Metric Upper Bound"
      description: "Upper bound value for the anomaly metric"
      group_label: "Anomaly Metrics"
      type: average
      sql: ${TABLE}.{% parameter anomaly_metric %}_UPPER_BOUND ;;
    }

    dimension: is_metric_anomalous {
      label: "Is Anomalous?"
      description: "Flag indicating if the selected metric falls outside the calculated bounds."
      group_label: "Anomaly Metrics"
      type: yesno
      sql: ${TABLE}.IS_{% parameter anomaly_metric %}_ANOMALOUS ;;
    }

###########
# Hidden Primary Key
###########
    dimension: pk {
      label: "Record Key"
      description: "Unique identifier made from event date."
      primary_key: yes
      hidden: yes
      type: string
      sql: CAST(${TABLE}.EVENT_DATE AS STRING) ;;
    }

#######################################################
    # Primary Dimensions
#######################################################

    dimension_group: event {
      label: "Event Date"
      description: "The date (at day granularity) on which each event occurred."
      type: time
      datatype: date
      timeframes: [date, week, month, quarter, year]
      sql: ${TABLE}.EVENT_DATE ;;
      group_label: "Primary Dimensions"
    }

#######################################################
    # Event Count Measures
#######################################################

    measure: page_view_count {
      label: "Page View Count"
      description: "Total number of page view events"
      type: sum
      sql: ${TABLE}.page_view_count ;;
      group_label: "Event Counts"
    }

    measure: button_clicked_count {
      label: "Button Clicked Count"
      description: "Total number of button clicked events"
      type: sum
      sql: ${TABLE}.button_clicked_count ;;
      group_label: "Event Counts"
    }

    measure: contact_us_count {
      label: "Contact Us Count"
      description: "Total number of contact us events"
      type: sum
      sql: ${TABLE}.contact_us_count ;;
      group_label: "Event Counts"
    }

    measure: icp_modal_displayed_count {
      label: "ICP Modal Displayed Count"
      description: "Total number of ICP modal displayed events"
      type: sum
      sql: ${TABLE}.icp_modal_displayed_count ;;
      group_label: "Event Counts"
    }

    measure: displayed_popup_count {
      label: "Displayed Popup Count"
      description: "Total number of displayed popup events"
      type: sum
      sql: ${TABLE}.displayed_popup_count ;;
      group_label: "Event Counts"
    }

#######################################################
    # Event Ratio Measures
#######################################################

    measure: icp_modal_displayed_ratio {
      label: "ICP Modal Display Ratio"
      description: "Ratio of ICP modal displayed to page views"
      type: average
      sql: ${TABLE}.icp_modal_displayed_ratio ;;
      value_format_name: percent_2
      group_label: "Event Ratios"
    }

    measure: displayed_popup_ratio {
      label: "Displayed Popup Ratio"
      description: "Ratio of displayed popup to page views"
      type: average
      sql: ${TABLE}.displayed_popup_ratio ;;
      value_format_name: percent_2
      group_label: "Event Ratios"
    }

  }
