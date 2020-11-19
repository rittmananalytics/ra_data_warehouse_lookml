view: orders_fact {
  sql_table_name: `ra-development.rob_training.wh_orders_fact`
    ;;

  dimension: order_id {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.order_id ;;
  }

  dimension: new_customer {
    description: "A Boolean whether the user created their first order within the selected time window."
    type: yesno
    sql: {% condition timeframe_a %} ${first_order_raw}  {% endcondition %} ;;
  }

  dimension: existing_customer {
    group_label: "Order Details"
    description: "A Boolean whether the user completed their first order outside of the selected time window."
    type: yesno
    sql: ${first_order_raw} < {% date_start timeframe_a %} ;;
  }

  dimension_group: first_order {
    description: "The date when each user first ordered, Also known as the Acquisition Date."
    type: time
    timeframes: [raw, date, week, month, year]
    sql: ${TABLE}.first_order_at ;;
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
  }

  dimension_group: order_approved {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.order_approved_at ;;
  }

  dimension_group: order_delivered_carrier {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.order_delivered_carrier_date ;;
  }

  dimension_group: order_delivered_customer {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.order_delivered_customer_date ;;
  }

  dimension_group: order_estimated_delivery {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.order_estimated_delivery_date ;;
  }


  dimension_group: order_purchase {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.order_purchase_timestamp ;;
  }

  dimension: date_order_purchase {
    type: date
    sql: DATE(${TABLE}.order_purchase_timestamp) ;;
  }

  dimension: order_status {
    type: string
    sql: ${TABLE}.order_status ;;
  }

  dimension: order_seq_num {
    type: number
    sql: ${TABLE}.order_seq_num ;;
  }

  measure: lifetime_orders {
    type: number
    sql: {TABLE}.lifetime_orders ;;
  }

  measure: average_order_value {
    type: number
    value_format_name: real_formatting
    sql: ${order_items_fact.revenue} / ${count_of_orders}  ;;
  }

  measure: average_revenue_per_paying_user{
    label: "ARPPU"
    type: number
    value_format_name: real_formatting
    sql: ${order_items_fact.revenue} / ${customers_dim.count_of_customers}  ;;
  }

  dimension_group: between_orders {
    type: duration
    sql_start: ${order_purchase_raw} ;;
    sql_end: ${next_order_at_raw} ;;
    intervals: [hour, day, week, month]
}

  measure: average_days_between_orders{
    type: average
    value_format: "0.00"
    sql: ${days_between_orders}  ;;
  }

  measure: average_hours_between_orders{
    type: average
    value_format: "0.00"
    sql: ${hours_between_orders}  ;;
  }

  measure: average_weeks_between_orders{
    type: average
    value_format: "0.00"
    sql: ${weeks_between_orders}  ;;
  }

  dimension_group: next_order_at {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.next_order_at ;;
  }

  dimension_group: until_next_order {
    group_label: "Dates"
    description: "Number of days between the creation of the order and the next order."
    type: duration
    intervals: [
      hour,
      day,
      week,
      month,
      quarter,
      year]
    sql_start: ${order_purchase_raw} ;;
    sql_end: ${next_order_at_raw}  ;;
  }


  measure: count_of_orders {
    type: count
    drill_fields: []
  }

#### DYNAMIC DATE GRANULARITY
  ## this block creates a parameter and date dimension which make it possible to dynamically change the date granularity for a visualisation without changing which date field is used.
  ## e.g when the parameter is set to 'day', no conversion is performed. when set to 'month', the date field is truncated to the month level.
  ## FYI this dynamic dimension also gets referenced in the timeframe selectors below.

  parameter: reporting_periods {
    label: "Created Date Dynamic Granularity"
    description: "This is a parameter which defines the available granularity of dates in the 'Period' dimension."
    allowed_value: {
      label: "Day"
      value: "day"
    }
    allowed_value: {
      label: "Week"
      value: "week"
    }
    allowed_value: {
      label: "Month"
      value: "month"
    }
    allowed_value: {
      label: "Fiscal Quarter"
      value: "fiscal_quarter"
    }
    allowed_value: {
      label: "Year"
      value: "year"
    }
    default_value: "day"
  }

  dimension: period {
    label: "Created Date Dynamic"
    description: "This is a dynamic field which truncates the date to the day, month, week, etc. Use the 'Created Date Dynamic Granularity' parameter to allow the user to make the selection. "
    label_from_parameter: reporting_periods
    group_label: "Dates"
    #sql: ${order_purchase_raw} ;;
    sql: DATE(CASE
      WHEN {% parameter reporting_periods %} = 'day'
        THEN ${order_purchase_raw}
      WHEN {% parameter reporting_periods %} = 'month'
        THEN TIMESTAMP_TRUNC( ${order_purchase_raw}, month)
      WHEN {% parameter reporting_periods %} = 'week'
        THEN TIMESTAMP_TRUNC( ${order_purchase_raw}, week)
      WHEN {% parameter reporting_periods %} = 'fiscal_quarter'
        THEN TIMESTAMP_TRUNC( ${order_purchase_raw}, quarter)
      WHEN {% parameter reporting_periods %} = 'year'
        THEN TIMESTAMP_TRUNC( ${order_purchase_raw}, year)
      ELSE ${order_purchase_raw}
    END) ;;
    skip_drill_filter: yes
  }


####

#### DYNAMIC TIMEFRAME ON TIMEFRAME ANALYSIS
  ## this block allows the user to select a timeframe to filter by, and then also provides a filter for the timeframe immediately prior,
  ## of equal length so that it becomes possible to do period-on-period analysis such as percentage change kpi's or YOY, MOM, WOW etc.
  ## Usage Instructions:
  #1. bring  timeframe_a filter into the view.
  #2. use group_a_yesno to filter for records within the selected window.
  #3. alternatively, use group_b_yesno to filter for records prior to the selected window.
  # making two views, one with each group_x_yesno filter and merging them can create percentage change KPI's.

## parameter determining whether timeframe is YOY, MOM, QOQ, POP.
  parameter: timeframe_type {
    description: "This is a parameter which defines whether the timeframe comparison uses the same window in the prior year, month, quarter or immediately prior period."
    type: unquoted
    allowed_value: {
      label: "Prior Period"
      value: "day"
    }
    allowed_value: {
      label: "Year On Year"
      value: "year"
    }
    allowed_value: {
      label: "Month On Month"
      value: "month"
    }
    allowed_value: {
      label: "Week On Week"
      value: "week"
    }
    default_value: "day"
  }

## filter determining time range for all "A" measures
  filter: timeframe_a {
    hidden: no
    type: date_time
    label: "Created Date Window"
    description: "Use this selector that operates on Created Date in conjunction with a 'Timeframe Selected' filter to create timeframe-on-timeframe analysis.  Using this filter creates two timeframe windows, 'current & prior', the latter being of the same duration as the filter but it is the period ending immediately before the filter starts."
    default_value: "7 days"
  }

  ## flag for "A" - whether the order is within the selected A (current) timeframe.
  dimension: group_a_yesno {
    hidden: yes
    label: "Timeframe Selected (Current)"
    description: "Use this dimension in conjunction with the Created Date Window filter. This dimension denotes when orders were created during the time window selected in the Created Date Window filter."
    group_label: "Dates"
    type: yesno
    sql: {% condition timeframe_a %} ${order_purchase_raw} {% endcondition %} ;;
  }

  ## duration field which calculates the number of integer days in timeframe A, in order to calculate start&end dates of timeframe B.
  dimension: timeframe_duration {
    hidden: yes
    type: number
    sql:
      CASE WHEN {% date_start timeframe_a %} is null then 7
      ELSE
      TIMESTAMP_DIFF( {% date_end timeframe_a %}, {% date_start timeframe_a %} , DAY)
      END;;
  }

## flags whether the event is in timeframe B (the timeframe immediately prior to timeframe A of equal length to A.)
## e.g if timeframe A is 8th-10th, then timeframe B would be 6th-8th of the month.
## e.g if timeframe A is 2019-01-01 - 2020-12-31 then timeframe B would be 2017-01-01 - 2018-12-31
  dimension: prior_group_b_yesno {
    hidden: yes
    label: "Timeframe Selected (Immediately Prior)"
    description: "Use this dimension in conjunction with the Created Date Window filter. This dimension denotes when orders were created in the time window prior to the one selected."
    group_label: "Dates"
    type: yesno
    sql:  CASE WHEN  TIMESTAMP_ADD(COALESCE({% date_start timeframe_a %},CURRENT_TIMESTAMP()), INTERVAL (-1 * ${timeframe_duration}) day ) <= ${order_purchase_raw}
          AND
          COALESCE({% date_start timeframe_a %},CURRENT_TIMESTAMP()) > ${order_purchase_raw}
          THEN TRUE ELSE FALSE END ;;
  }

  dimension: pop_group_b_yesno {
    hidden: yes
    label: "Timeframe Selected (YOY, MOM, QOQ)"
    description: "Use this dimension in conjunction with the Created Date Window filter. This dimension denotes when orders were created in the time window prior to the one selected."
    group_label: "Dates"
    type: yesno
    ## This SQL calculates booleans between:
    ### the start of the period = the timeframe_a start date minus the timeframe type (1 year, month quarter etc).
    ### the end of the period = the start of the period (as above), plus the number of days in the interval.
    sql:
    CASE WHEN  TIMESTAMP_ADD(COALESCE({% date_start timeframe_a %},CURRENT_TIMESTAMP()), INTERVAL  -1 {% parameter timeframe_type %} ) <= ${order_purchase_raw}
    AND
    TIMESTAMP_ADD(
      (TIMESTAMP_ADD(
      COALESCE({% date_start timeframe_a %},CURRENT_TIMESTAMP()),
      INTERVAL -1
        {% parameter timeframe_type %}
        )
      ), INTERVAL ${timeframe_duration} day
    )
    > ${order_purchase_raw}
    THEN TRUE ELSE FALSE END ;;
  }

  dimension: group_b_yesno {
    hidden: yes
    label: "Timeframe Selected (Prior)"
    description: "Use this dimension in conjunction with the Created Date Window filter. This dimension denotes when orders were created in the time window prior to the one selected, configurable by the timeframe type parameter."
    group_label: "Dates"
    type: yesno
    ## This field selects between the POP (period on period) or the prior timeframe calculations depending on the timeframe_type parameter
    sql:
    CASE WHEN '{% parameter timeframe_type %}' = 'day' THEN ${prior_group_b_yesno} ELSE  ${pop_group_b_yesno} END ;;
  }

  # Optional Dimensions to filter whole query for just records within the two periods
  dimension: is_in_comparison_windows {
    hidden: yes
    label: "Is in any selected timeframe (Current & Prior)"
    description: "Use this dimension (usually to filter) on whether orders are within the time window(s) specified by the 'Created Date Window' filter."
    group_label: "Dates"
    type: yesno
    sql:
      ${group_a_yesno} OR ${group_b_yesno}
      ;;
  }

  dimension: date_window {
    hidden: no
    label: "Date Window"
    description: "Use this dimension (usually to filter) on whether orders are within the time window(s) specified by the 'Created Date Window' filter."
    group_label: "Dates"
    type: string
    sql:
      CASE
        WHEN ${group_a_yesno} AND NOT ${group_b_yesno} THEN 'Current'
        WHEN ${group_b_yesno} AND NOT ${group_a_yesno} then 'Prior'
        WHEN ${group_b_yesno} AND ${group_a_yesno} then 'Both'
      ELSE NULL END
      ;;
  }
####


}
