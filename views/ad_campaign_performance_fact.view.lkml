view: ad_campaign_performance_fact {
  sql_table_name: `analytics.ad_campaign_performance_fact`
    ;;

  measure: average_actual_cpc {
    value_format_name: gbp_0

    type: average
    sql: ${TABLE}.actual_cpc ;;
  }

  dimension: ad_campaign_pk {
    type: string
    sql: ${TABLE}.ad_campaign_pk;;
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
    type: sum
    sql: ${TABLE}.total_clicks ;;
  }

  measure: total_reported_clicks {
    type: sum
    sql: ${TABLE}.total_reported_clicks ;;
  }

  measure: total_reported_cost {
    value_format_name: gbp_0

    type: sum
    sql: ${TABLE}.total_reported_cost ;;
  }



  measure: total_reported_impressions {
    type: sum
    sql: ${TABLE}.total_reported_impressions ;;
  }

  measure: total_reported_invalid_clicks {
    type: sum
    sql: ${TABLE}.total_reported_invalid_clicks ;;
  }



  measure: count {
    type: count
    drill_fields: []
  }
}
