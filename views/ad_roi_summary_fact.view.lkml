view: ad_roi_summary_fact {
  sql_table_name: `{{ _user_attributes['dataset'] }}.ad_roi_summary_fact`
    ;;

  dimension: actual_cpc {
    hidden: yes

    type: number
    sql: ${TABLE}.actual_cpc ;;
  }

  parameter: attribution_model {
    type: string
    allowed_value: {label: "First Click" value: "First Click"}
    allowed_value: {label: "Last Click" value: "Last Click"}
    allowed_value: {label: "Even Click" value: "Even Click"}
    allowed_value: {label: "Time Decay" value: "Time Decay"}
    default_value: "Last Click"
  }

  measure: predicted_ltv {
    label: "Predicted LTV"
    group_label: "Attribution"
    value_format_name: usd
    type: sum
    sql:
    {% if attribution_model._parameter_value == "'First Click'" %}
      round(${TABLE}.total_first_click_baremetrics_predicted_ltv,2)

    {% elsif attribution_model._parameter_value == "'Last Click'" %}
      round(${TABLE}.total_last_click_baremetrics_predicted_ltv,2)
    {% elsif attribution_model._parameter_value == "'Even Click'" %}
      round(${TABLE}.total_even_click_baremetrics_predicted_ltv,2)
    {% elsif attribution_model._parameter_value == "'Time Decay'" %}
     round(${TABLE}.total_time_decay_baremetrics_predicted_ltv,2)
    {% else %}
      NULL
    {% endif %} ;;
  }

  measure: first_plan {
    label: "First Plan"
    group_label: "Attribution"
    value_format_name: usd
    type: sum

    sql:
    {% if attribution_model._parameter_value == "'First Click'" %}
      round(${TABLE}.total_first_click_attrib_first_plan,2)
    {% elsif attribution_model._parameter_value == "'Last Click'" %}
      round(${TABLE}.total_last_click_attrib_first_plan,2)
    {% elsif attribution_model._parameter_value == "'Even Click'" %}
      round(${TABLE}.total_even_click_attrib_first_plan,2)
    {% elsif attribution_model._parameter_value == "'Time Decay'" %}
     round(${TABLE}.total_time_decay_attrib_first_plan,2)
    {% else %}
      NULL
    {% endif %} ;;
  }

  measure: conversions {
    label: "Conversions"
    group_label: "Attribution"
    type: sum

    sql:
    {% if attribution_model._parameter_value == "'First Click'" %}
      round(${TABLE}.total_first_click_attrib_pct,2)
    {% elsif attribution_model._parameter_value == "'Last Click'" %}
      round(${TABLE}.total_last_click_attrib_pct,2)
    {% elsif attribution_model._parameter_value == "'Even Click'" %}
      round(${TABLE}.total_even_click_attrib_pct,2)
    {% elsif attribution_model._parameter_value == "'Time Decay'" %}
      round(${TABLE}.total_time_decay_attrib_pct,2)
    {% else %}
      NULL
    {% endif %} ;;
  }

  measure: new_trials {
    label: "New Trials"
    group_label: "Attribution"
    type: sum

    sql:
    {% if attribution_model._parameter_value == "'First Click'" %}
      round(${TABLE}.total_first_click_attrib_new_trials,2)
    {% elsif attribution_model._parameter_value == "'Last Click'" %}
      round(${TABLE}.total_last_click_attrib_new_trials,2)
    {% elsif attribution_model._parameter_value == "'Even Click'" %}
      round(${TABLE}.total_even_click_attrib_new_trials,2)
    {% elsif attribution_model._parameter_value == "'Time Decay'" %}
      round(${TABLE}.total_time_decay_attrib_new_trials,2)
    {% else %}
      NULL
    {% endif %} ;;
  }


  parameter: ad_metric {
    allowed_value: {value: "total_clicks" label: "Actual Clicks"}
    allowed_value: {value: "total_reported_clicks" label: "Reported Clicks"}
    allowed_value: {value: "total_reported_cost" label: "Reported Cost"}
    allowed_value: {value: "total_reported_impressions" label: "Reported Impressions"}
    allowed_value: {value: "total_reported_invalid_clicks" label: "Reported Invalid Clicks"}
    allowed_value: {value: "avg_reported_cpc" label: "Reported CPC"}
    allowed_value: {value: "avg_reported_cpm" label: "Reported CPM"}
    allowed_value: {value: "total_first_click_attrib_first_plan" label: "First Plan Revenue (First Click)"}
    allowed_value: {value: "total_last_click_attrib_first_plan" label: "First Plan Revenue (Last Click)"}
    allowed_value: {value: "total_even_click_attrib_first_plan" label: "First Plan Revenue (Even Click)"}
    allowed_value: {value: "total_time_decay_attrib_first_plan" label: "First Plan Revenue (Time Decay)"}
    allowed_value: {value: "total_first_click_baremetrics_predicted_ltv" label: "Predicted LTV (First Click)"}
    allowed_value: {value: "total_last_click_baremetrics_predicted_ltv" label: "Predicted LTV (Last Click)"}
    allowed_value: {value: "total_even_click_baremetrics_predicted_ltv" label: "Predicted LTV (Even Click)"}
    allowed_value: {value: "total_time_decay_baremetrics_predicted_ltv" label: "Predicted LTV (Time Decay)"}
    allowed_value: {value: "total_first_click_attrib_pct" label: "Conversions (First Click)"}
    allowed_value: {value: "total_last_click_attrib_pct" label: "Conversions (Last Click)"}
    allowed_value: {value: "total_even_click_attrib_pct" label: "Conversions (Even Click)"}
    allowed_value: {value: "total_time_decay_attrib_pct" label: "Conversions (Time Decay)"}
    default_value: "total_reported_clicks"
  }

  parameter: ad_metric_2 {
    allowed_value: {value: "total_clicks" label: "Actual Clicks"}
    allowed_value: {value: "total_reported_clicks" label: "Reported Clicks"}
    allowed_value: {value: "total_reported_cost" label: "Reported Cost"}
    allowed_value: {value: "total_reported_impressions" label: "Reported Impressions"}
    allowed_value: {value: "total_reported_invalid_clicks" label: "Reported Invalid Clicks"}
    allowed_value: {value: "avg_reported_cpc" label: "Reported CPC"}
    allowed_value: {value: "avg_reported_cpm" label: "Reported CPM"}
    allowed_value: {value: "total_first_click_attrib_first_plan" label: "First Plan Revenue (First Click)"}
    allowed_value: {value: "total_last_click_attrib_first_plan" label: "First Plan Revenue (Last Click)"}
    allowed_value: {value: "total_even_click_attrib_first_plan" label: "First Plan Revenue (Even Click)"}
    allowed_value: {value: "total_time_decay_attrib_first_plan" label: "First Plan Revenue (Time Decay)"}
    allowed_value: {value: "total_first_click_baremetrics_predicted_ltv" label: "Predicted LTV (First Click)"}
    allowed_value: {value: "total_last_click_baremetrics_predicted_ltv" label: "Predicted LTV (Last Click)"}
    allowed_value: {value: "total_even_click_baremetrics_predicted_ltv" label: "Predicted LTV (Even Click)"}
    allowed_value: {value: "total_time_decay_baremetrics_predicted_ltv" label: "Predicted LTV (Time Decay)"}
    allowed_value: {value: "total_first_click_attrib_pct" label: "Conversions (First Click)"}
    allowed_value: {value: "total_last_click_attrib_pct" label: "Conversions (Last Click)"}
    allowed_value: {value: "total_even_click_attrib_pct" label: "Conversions (Even Click)"}
    allowed_value: {value: "total_time_decay_attrib_pct" label: "Conversions (Time Decay)"}
    default_value: "total_reported_clicks"
  }

  measure: ad_metric_choice {
    label_from_parameter: ad_metric
    group_label: "Parameter Metrics"
    type: number
    sql:
    {% if ad_metric._parameter_value == "'total_clicks'" %}
      ${total_clicks}
    {% elsif ad_metric._parameter_value == "'total_reported_clicks'" %}
      ${total_reported_clicks}
    {% elsif ad_metric._parameter_value == "'total_reported_cost'" %}
      ${total_reported_cost}
    {% elsif ad_metric._parameter_value == "'total_reported_impressions'" %}
     ${total_reported_impressions}
    {% elsif ad_metric._parameter_value == "'total_reported_invalid_clicks'" %}
     ${total_reported_invalid_clicks}
    {% elsif ad_metric._parameter_value == "'actual_ctr'" %}
     ${avg_actual_ctr}
   {% elsif ad_metric._parameter_value == "'reported_cpm'" %}
     ${avg_reported_cpm}
   {% elsif ad_metric._parameter_value == "'total_first_click_attrib_first_plan'" %}
     ${total_first_click_attrib_first_plan}
   {% elsif ad_metric._parameter_value == "'total_last_click_attrib_first_plan'" %}
     ${total_last_click_attrib_first_plan}
   {% elsif ad_metric._parameter_value == "'total_even_click_attrib_first_plan'" %}
     ${total_even_click_attrib_first_plan}
   {% elsif ad_metric._parameter_value == "'total_time_decay_attrib_first_plan'" %}
     ${total_time_decay_attrib_first_plan}
   {% elsif ad_metric._parameter_value == "'total_first_click_baremetrics_predicted_ltv'" %}
     ${total_first_click_baremetrics_predicted_ltv}
   {% elsif ad_metric._parameter_value == "'total_last_click_baremetrics_predicted_ltv'" %}
     ${total_last_click_baremetrics_predicted_ltv}
   {% elsif ad_metric._parameter_value == "'total_even_click_baremetrics_predicted_ltv'" %}
     ${total_even_click_baremetrics_predicted_ltv}
   {% elsif ad_metric._parameter_value == "'total_time_decay_baremetrics_predicted_ltv'" %}
     ${total_time_decay_baremetrics_predicted_ltv}
  {% elsif ad_metric._parameter_value == "'total_first_click_attrib_conversions'" %}
     ${total_first_click_baremetrics_predicted_ltv}
   {% elsif ad_metric._parameter_value == "'total_last_click_attrib_conversions'" %}
     ${total_last_click_baremetrics_predicted_ltv}
   {% elsif ad_metric._parameter_value == "'total_even_click_attrib_conversions'" %}
     ${total_even_click_baremetrics_predicted_ltv}
   {% elsif ad_metric._parameter_value == "'total_time_decay_attrib_conversions'" %}
     ${total_time_decay_baremetrics_predicted_ltv}
    {% else %}
      NULL
    {% endif %} ;;
  }

  measure: ad_metric_choice_2 {
    label_from_parameter: ad_metric_2
    group_label: "Parameter Metrics"

    type: number
    sql:
    {% if ad_metric_2._parameter_value == "'total_clicks'" %}
      ${total_clicks}
    {% elsif ad_metric_2._parameter_value == "'total_reported_clicks'" %}
      ${total_reported_clicks}
    {% elsif ad_metric_2._parameter_value == "'total_reported_cost'" %}
      ${total_reported_cost}
    {% elsif ad_metric_2._parameter_value == "'total_reported_impressions'" %}
     ${total_reported_impressions}
    {% elsif ad_metric_2._parameter_value == "'total_reported_invalid_clicks'" %}
     ${total_reported_invalid_clicks}
    {% elsif ad_metric_2._parameter_value == "'actual_ctr'" %}
     ${avg_actual_ctr}
   {% elsif ad_metric_2._parameter_value == "'reported_cpm'" %}
     ${avg_reported_cpm}
   {% elsif ad_metric_2._parameter_value == "'total_first_click_attrib_first_plan'" %}
     ${total_first_click_attrib_first_plan}
   {% elsif ad_metric_2._parameter_value == "'total_last_click_attrib_first_plan'" %}
     ${total_last_click_attrib_first_plan}
   {% elsif ad_metric_2._parameter_value == "'total_even_click_attrib_first_plan'" %}
     ${total_even_click_attrib_first_plan}
   {% elsif ad_metric_2._parameter_value == "'total_time_decay_attrib_first_plan'" %}
     ${total_time_decay_attrib_first_plan}
   {% elsif ad_metric_2._parameter_value == "'total_first_click_baremetrics_predicted_ltv'" %}
     ${total_first_click_baremetrics_predicted_ltv}
   {% elsif ad_metric_2._parameter_value == "'total_last_click_baremetrics_predicted_ltv'" %}
     ${total_last_click_baremetrics_predicted_ltv}
   {% elsif ad_metric_2._parameter_value == "'total_even_click_baremetrics_predicted_ltv'" %}
     ${total_even_click_baremetrics_predicted_ltv}
   {% elsif ad_metric_2._parameter_value == "'total_time_decay_baremetrics_predicted_ltv'" %}
     ${total_time_decay_baremetrics_predicted_ltv}
  {% elsif ad_metric._parameter_value == "'total_first_click_attrib_conversions'" %}
     ${total_first_click_baremetrics_predicted_ltv}
   {% elsif ad_metric._parameter_value == "'total_last_click_attrib_conversions'" %}
     ${total_last_click_baremetrics_predicted_ltv}
   {% elsif ad_metric._parameter_value == "'total_even_click_attrib_conversions'" %}
     ${total_even_click_baremetrics_predicted_ltv}
   {% elsif ad_metric._parameter_value == "'total_time_decay_attrib_conversions'" %}
     ${total_time_decay_baremetrics_predicted_ltv}
    {% else %}
      NULL
    {% endif %} ;;
  }


  measure: avg_actual_cpc {
    group_label: "Campaign Cost Metrics"
    value_format_name: usd

    type: average
    sql: ${TABLE}.actual_cpc ;;
  }

  measure: unique_users {
    group_label: "Session Metrics"


    type: sum
    sql: ${TABLE}.total_unique_users ;;
  }



  measure: total_paid_social_entrances {
    group_label: "Session Metrics"


    type: sum
    sql: ${TABLE}.total_paid_social_clicks ;;
  }

  measure: total_facebook_entrances {
    group_label: "Session Metrics"


    type: sum
    sql: ${TABLE}.total_facebook_clicks ;;
  }

  measure: total_adwords_entrances {
    group_label: "Session Metrics"


    type: sum
    sql: ${TABLE}.total_adwords_clicks ;;
  }



  dimension: actual_ctr {
    hidden: yes

    type: number
    sql: ${TABLE}.actual_ctr ;;
  }

  measure: avg_actual_ctr {
    group_label: "Campaign Performance Metrics"
    value_format_name: percent_2

    type: average
    sql: ${TABLE}.actual_ctr ;;
  }

  dimension: actual_vs_reported_clicks_pct {
    hidden: yes

    type: number
    sql: ${TABLE}.actual_vs_reported_clicks_pct ;;
  }

  measure: avg_actual_vs_reported_clicks_pct {
    group_label: "Campaign Performance Metrics"
    value_format_name: percent_2

    type: average
    sql: ${TABLE}.actual_vs_reported_clicks_pct ;;
  }

  dimension: ad_campaign_id {
    hidden: yes
    type: string
    sql: ${TABLE}.ad_campaign_id ;;
  }

  dimension: ad_campaign_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.ad_campaign_fk ;;
  }

  dimension: dim_avg_reported_bounce_rate {
    hidden: yes

    type: number
    sql: ${TABLE}.avg_reported_bounce_rate ;;
  }

  measure: avg_reported_bounce_rate {
    group_label: "Campaign Performance Metrics"
    value_format_name: percent_2
    hidden: yes
    type: average
    sql: ${TABLE}.avg_reported_bounce_rate ;;
  }

  dimension: dim_avg_reported_time_on_site {
    hidden: yes

    type: number
    sql: ${TABLE}.avg_reported_time_on_site ;;
  }

  measure: avg_reported_time_on_site {
    group_label: "Campaign Performance Metrics"
    value_format_name: decimal_2

    type: average
    sql: ${TABLE}.avg_reported_time_on_site ;;
  }

  dimension_group: campaign {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: timestamp(${TABLE}.campaign_date) ;;
  }

  dimension_group: campaign_start_ts {
    label: "Campaign Start"
    hidden: yes
    type: time
    timeframes: [
      raw,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.campaign_start_ts ;;
  }

  dimension: reported_cpc {
    hidden: yes
    type: number
    sql: ${TABLE}.reported_cpc ;;
  }

  measure: avg_reported_cpc {
    group_label: "Campaign Cost Metrics"
    value_format_name: usd

    type: average
    sql: ${TABLE}.reported_cpc ;;
  }

  measure: avg_reported_cpm {
    group_label: "Campaign Cost Metrics"
    value_format_name: usd

    type: average
    sql: ${TABLE}.reported_cpm ;;
  }

  dimension: reported_ctr {
    hidden: yes

    type: number
    sql: ${TABLE}.reported_ctr ;;
  }

  measure: avg_reported_ctr {
    group_label: "Campaign Performance Metrics"
    value_format_name: percent_2

    type: average
    sql: ${TABLE}.reported_ctr ;;
  }

  dimension: dim_total_clicks {
    hidden: yes

    type: number
    sql: ${TABLE}.total_clicks ;;
  }

  measure: total_clicks {
    group_label: "Campaign Performance Metrics"
    value_format_name: decimal_0

    type: sum
    sql: ${TABLE}.total_clicks ;;
  }

  dimension: dim_total_reported_clicks {
    hidden: yes

    type: number
    sql: ${TABLE}.total_reported_clicks ;;
  }

  measure: total_reported_clicks {
    group_label: "Campaign Performance Metrics"
    value_format_name: decimal_0

    type: sum
    sql: ${TABLE}.total_reported_clicks ;;
  }

  dimension: dim_total_reported_cost {
    hidden: yes

    type: number
    sql: ${TABLE}.total_reported_cost ;;
  }

  measure: total_reported_cost {
    group_label: "Campaign Cost Metrics"
    value_format_name: usd

    type: sum
    sql: ${TABLE}.total_reported_cost ;;
  }

  dimension: dim_total_reported_impressions {
    hidden: yes

    type: number
    sql: ${TABLE}.total_reported_impressions ;;
  }

  measure: total_reported_impressions {
    group_label: "Campaign Performance Metrics"
    value_format_name: decimal_0

    type: sum
    sql: ${TABLE}.total_reported_impressions ;;
  }

  dimension: dim_total_reported_invalid_clicks {
    hidden: yes

    type: number
    sql: ${TABLE}.total_reported_invalid_clicks ;;
  }

  measure: total_reported_invalid_clicks {
    group_label: "Campaign Performance Metrics"
    value_format_name: decimal_0

    type: sum
    sql: ${TABLE}.total_reported_invalid_clicks ;;
  }

  dimension: weeks_since_campaign_start {
    hidden: yes

    type: number
    sql: ${TABLE}.weeks_since_campaign_start ;;
  }





  measure: total_even_click_attrib_first_plan {
    group_label: "Campaign Revenue Metrics"
    value_format_name: usd

    type: sum
    sql: ${TABLE}.total_even_click_attrib_first_plan ;;
  }

  measure: total_even_click_baremetrics_predicted_ltv {
    group_label: "Campaign Revenue Metrics"
    value_format_name: usd

    type: sum
    sql: ${TABLE}.total_even_click_baremetrics_predicted_ltv ;;
  }

  measure: total_first_click_attrib_first_plan {
    group_label: "Campaign Revenue Metrics"
    value_format_name: usd

    type: sum
    sql: ${TABLE}.total_first_click_attrib_first_plan ;;
  }

  measure: total_first_click_baremetrics_predicted_ltv {
    group_label: "Campaign Revenue Metrics"
    value_format_name: usd

    type: sum
    sql: ${TABLE}.total_first_click_baremetrics_predicted_ltv ;;
  }

  measure: total_last_click_attrib_first_plan {
    group_label: "Campaign Revenue Metrics"
    value_format_name: usd

    type: sum
    sql: ${TABLE}.total_last_click_attrib_first_plan ;;
  }

  measure: total_last_click_baremetrics_predicted_ltv {
    group_label: "Campaign Revenue Metrics"
    value_format_name: usd
    type: sum
    sql: ${TABLE}.total_last_click_baremetrics_predicted_ltv ;;
  }



  measure: total_time_decay_attrib_first_plan {
    group_label: "Campaign Revenue Metrics"
    value_format_name: usd

    type: sum
    sql: ${TABLE}.total_time_decay_attrib_first_plan ;;
  }

  measure: total_time_decay_baremetrics_predicted_ltv {
    group_label: "Campaign Revenue Metrics"
    value_format_name: usd

    type: sum
    sql: ${TABLE}.total_time_decay_baremetrics_predicted_ltv ;;
  }

  measure: total_first_click_attrib_conversions {
    value_format_name: percent_2
    group_label: "Campaign Revenue Metrics"
    label: "Total First Click Attribution Conversions"

    type: sum
    sql: ${TABLE}.total_first_click_attrib_conversions ;;
  }

  measure: total_even_click_attrib_conversions {
    value_format_name: percent_2
    group_label: "Campaign Revenue Metrics"
    label: "Total Even Click Attribution Conversions"

    type: sum
    sql: ${TABLE}.total_even_click_attrib_conversions ;;
  }

  measure: total_last_click_attrib_conversions {
    value_format_name: percent_2
    group_label: "Campaign Revenue Metrics"
    label: "Total Last Click Attribution Conversions"

    type: sum
    sql: ${TABLE}.total_last_click_attrib_conversions ;;
  }

  measure: total_time_decay_attrib_conversions {
    group_label: "Campaign Revenue Metrics"
    label: "Total Time Decay Attribution Conversions"
    value_format_name: percent_2


    type: sum
    sql: ${TABLE}.total_time_decay_attrib_conversions ;;
  }

  measure: total_first_click_attrib_new_trials {
    value_format_name: percent_2
    group_label: "New Trial Metrics"
    label: "Total First Click Attribution New Trials"

    type: sum
    sql: ${TABLE}.total_first_click_attrib_new_trials ;;
  }

  measure: total_last_click_attrib_new_trials {
    value_format_name: percent_2
    group_label: "New Trial Metrics"
    label: "Total Last Click Attribution New Trials"

    type: sum
    sql: ${TABLE}.total_last_click_attrib_new_trials ;;
  }

  measure: total_even_click_attrib_new_trials {
    value_format_name: percent_2
    group_label: "New Trial Metrics"
    label: "Total Even Click Attribution New Trials"

    type: sum
    sql: ${TABLE}.total_even_click_attrib_new_trials ;;
  }

  measure: total_time_decay_attrib_new_trials {
    value_format_name: percent_2
    group_label: "New Trial Metrics"
    label: "Total Time Decay Attribution New Trials"

    type: sum
    sql: ${TABLE}.total_time_decay_attrib_new_trials ;;
  }

####DYNAMIC TIMEFRAME ON TIMEFRAME ANALYSIS

## filter determining time range for all "A" measures

  filter: timeframe_a {
    hidden: no
    type: date_time
    label: "Campaign Date"
    description: "Use this filter on Campaign Date to configure timeframe-on-timeframe analysis in conjunction with a ${group_a_yesno} filter. Using this filter creates two timeframe windows, 'current & prior', the latter being of the same duration as the filter but it is the period ending immediately before the filter starts."
    default_value: "7 days"
  }

  ## flag for "A" measures to only include appropriate time range

  dimension: group_a_yesno {
    hidden: no
    label: "Timeframe Selected (Current)"
    type: yesno
    sql: {% condition timeframe_a %} ${campaign_raw} {% endcondition %} ;;
  }

  ## filter determining time range for all "B" measures

  #filter: timeframe_b {
  #  type: date_time
  #}

  ## flag for "B" measures to only include appropriate time range

  dimension: timeframe_duration {
    hidden: yes
    type: number
    sql:
      CASE WHEN {% date_start timeframe_a %} is null then 7
      ELSE TIMESTAMP_DIFF({% date_end timeframe_a %},{% date_start timeframe_a %}, DAY)
      END;;
  }

## flags whether the event is in timeframe B (the timeframe immediately prior to timeframe A of equal length to A.)
## e.g if timeframe A is 8th-10th, then timeframe B would be 6th-8th of the month.
  dimension: group_b_yesno {
    hidden: no
    label: "Timeframe Selected (Prior)"
    type: yesno
    sql:
    CASE WHEN  TIMESTAMP_SUB(IFNULL({% date_start timeframe_a %},CURRENT_TIMESTAMP()),INTERVAL ${timeframe_duration} DAY ) < ${campaign_raw}
    AND
    IFNULL({% date_start timeframe_a %},CURRENT_TIMESTAMP()) > ${campaign_raw}
    THEN TRUE ELSE FALSE END ;;
  }

  # Dimensions to filter whole query for just records within the two periods
  dimension: is_in_time_a_or_b {
    hidden: yes
    label: "Is in any selected timeframe (Current & Prior)"
    group_label: "Time Comparison Filters"
    type: yesno
    sql:
      CASE WHEN ${group_a_yesno} IS TRUE OR ${group_b_yesno} IS TRUE THEN TRUE ELSE FALSE END ;;
  }
####





}
