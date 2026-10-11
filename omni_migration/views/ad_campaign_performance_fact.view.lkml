view: ad_campaign_performance_fact {
  sql_table_name: `ra-development.analytics.ad_campaign_performance_fact` ;;

  dimension: ad_campaign_fk {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.ad_campaign_fk ;;
  }

  dimension_group: campaign {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.campaign_date ;;
  }

  measure: actual_vs_reported_clicks {
    type: number
    label: "Actual / Reported Clicks"
    value_format_name: percent_1
    sql: safe_divide(${total_clicks}, ${total_reported_clicks}) ;;
  }

  measure: average_actual_cpc {
    type: average
    value_format_name: gbp_0
    sql: ${TABLE}.actual_cpc ;;
  }

  measure: average_actual_ctr {
    type: average
    value_format_name: percent_2
    sql: ${TABLE}.actual_ctr ;;
  }

  measure: average_actual_vs_reported_clicks_pct {
    type: average
    value_format_name: percent_2
    sql: ${TABLE}.actual_vs_reported_clicks_pct ;;
  }

  measure: average_reported_cpc {
    type: average
    value_format_name: gbp_0
    sql: ${TABLE}.reported_cpc ;;
  }

  measure: average_reported_cpm {
    type: average
    value_format_name: gbp_0
    sql: ${TABLE}.reported_cpm ;;
  }

  measure: average_reported_ctr {
    type: average
    value_format_name: percent_2
    sql: ${TABLE}.reported_ctr ;;
  }

  measure: commercial_page_view_share {
    type: number
    label: "Commercial / Total Page Views"
    value_format_name: percent_1
    sql: safe_divide(${total_session_marketing_page_views} + ${total_session_services_page_views}, ${total_session_page_views}) ;;
  }

  measure: count {
    type: count
  }

  measure: page_views_per_click {
    type: number
    label: "Page Views / Click"
    value_format_name: decimal_2
    sql: safe_divide(${total_session_page_views}, ${total_clicks}) ;;
  }

  measure: total_clicks {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.total_clicks ;;
  }

  measure: total_reported_clicks {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.total_reported_clicks ;;
  }

  measure: total_reported_cost {
    type: sum
    value_format_name: gbp_0
    sql: ${TABLE}.total_reported_cost ;;
  }

  measure: total_reported_impressions {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.total_reported_impressions ;;
  }

  measure: total_session_case_study_page_views {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.total_session_case_study_page_views ;;
  }

  measure: total_session_conversions {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.total_session_conversions ;;
  }

  measure: total_session_goals_achieved {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.total_session_goals_achieved ;;
  }

  measure: total_session_marketing_page_views {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.total_session_marketing_page_views ;;
  }

  measure: total_session_page_views {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.total_session_page_views ;;
  }

  measure: total_session_services_page_views {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.total_session_services_page_views ;;
  }

  measure: total_unique_users {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.total_unique_users ;;
  }
}
