view: ad_campaign_performance_fact {
  sql_table_name: `{{ _user_attributes['dataset'] }}.ad_campaign_performance_fact`
    ;;

  measure: average_actual_cpc {
    value_format_name: gbp_0

    type: average
    sql: ${TABLE}.actual_cpc ;;
  }

  dimension: ad_campaign_fk {
    type: string
    sql: ${TABLE}.ad_campaign_fk;;
    primary_key: yes
    hidden: yes
  }

  measure: average_actual_ctr {
    value_format_name: percent_2
    type: average
    sql: ${TABLE}.actual_ctr ;;
  }

  measure: average_actual_vs_reported_clicks_pct {
    value_format_name: percent_2

    type: average
    sql: ${TABLE}.actual_vs_reported_clicks_pct ;;
  }

  measure: average_avg_reported_bounce_rate {
    value_format_name: percent_2

    type: average
    sql: ${TABLE}.avg_reported_bounce_rate ;;
  }

  measure: avg_reported_time_on_site {
    value_format_name: decimal_2

    type: average
    sql: ${TABLE}.avg_reported_time_on_site ;;
  }

  dimension_group: campaign {
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
    sql: ${TABLE}.campaign_date ;;
  }

  measure: average_reported_cpc {
    value_format_name: gbp_0
    type: average
    sql: ${TABLE}.reported_cpc ;;
  }

  measure: average_reported_cpm {
    value_format_name: gbp_0

    type: average
    sql: ${TABLE}.reported_cpm ;;
  }

  measure: average_reported_ctr {
    value_format_name: percent_2
    type: average
    sql: ${TABLE}.reported_ctr ;;
  }

  measure: total_clicks {
    value_format_name: decimal_0
    type: sum
    sql: ${TABLE}.total_clicks ;;
  }

  measure: total_session_page_views {
    value_format_name: decimal_0

    type: sum
    sql: ${TABLE}.total_session_page_views;;
  }

    measure: total_session_services_page_views {
    value_format_name: decimal_0

    type: sum
    sql: ${TABLE}.total_session_services_page_views;;
  }

      measure: total_session_marketing_page_views {
      value_format_name: decimal_0

      type: sum
      sql: ${TABLE}.total_session_marketing_page_views;;
    }

  measure: total_session_case_study_page_views {
    value_format_name: decimal_0

    type: sum
    sql: ${TABLE}.total_session_case_study_page_views;;
  }

  measure: total_session_goals_achieved {
    value_format_name: decimal_0

    type: sum
    sql: ${TABLE}.total_session_goals_achieved;;
  }

  measure: total_session_conversions {
    value_format_name: decimal_0

    type: sum
    sql: ${TABLE}.total_session_conversions;;
  }

  measure: total_unique_users {
    value_format_name: decimal_0

    type: sum
    sql: ${TABLE}.total_unique_users;;
  }

  measure: total_reported_clicks {
    value_format_name: decimal_0

    type: sum
    sql: ${TABLE}.total_reported_clicks ;;
  }

  measure: total_reported_cost {
    value_format_name: gbp_0

    type: sum
    sql: ${TABLE}.total_reported_cost ;;
  }



  measure: total_reported_impressions {
    value_format_name: decimal_0

    type: sum
    sql: ${TABLE}.total_reported_impressions ;;
  }

  measure: total_reported_invalid_clicks {
    value_format_name: decimal_0

    type: sum
    sql: ${TABLE}.total_reported_invalid_clicks ;;
  }



  measure: count {
    type: count
    drill_fields: []
  }
}
