view: google_search_console_weekly_stats {
  derived_table: {
    sql: with page_keyword_performance as (
      SELECT
      case when page = 'https://rittmananalytics.com/' then 'home' else coalesce(lower(array_reverse(
      split(rtrim(page,'/'),'/'))[safe_offset(0)]),'home') end as page_name,
      query as search_keywords,
      date_trunc(date, WEEK) as search_week,
      sum(clicks) as total_clicks,
      sum(impressions) as total_impressions,
      avg(ctr) as avg_ctr,
      avg(position) as avg_position
      FROM
      `ra-development.fivetran_google_search_console.keyword_page_report`
      GROUP BY
      1,2,3)
select *,
       row_number() over (partition by search_week order by total_clicks desc) as weekly_query_clicks_rank
from page_keyword_performance
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: page_name {
    hidden: yes
    type: string
    sql: ${TABLE}.page_name ;;
  }

  dimension: search_keywords {
    type: string
    sql: ${TABLE}.search_keywords ;;
  }



  dimension_group: search {
    type: time
    timeframes: [raw,week,quarter,year]
    datatype: date
    sql: timestamp(${TABLE}.search_week) ;;
  }

  dimension: pk {
    type: string
    hidden: yes
    sql: concat(${page_name},${search_keywords},${search_raw}) ;;
  }

  dimension: clicks {
    type: number
    hidden: yes
    sql: ${TABLE}.total_clicks ;;
  }

  dimension: impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.total_impressions ;;
  }

  dimension: ctr {
    type: number
    hidden: yes
    sql: ${TABLE}.avg_ctr ;;
  }

  dimension: position {
    type: number
    hidden: yes
    sql: ${TABLE}.avg_position ;;
  }

  dimension: weekly_query_clicks_rank {
    type: number
    hidden: yes
    sql: ${TABLE}.weekly_query_clicks_rank ;;
  }

  measure: total_clicks {
    type: sum
    sql: ${clicks} ;;
    drill_fields: [detail*]
  }

  measure: total_impressions {
    type: sum
    sql: ${impressions} ;;
    drill_fields: [detail*]
  }

  measure: avg_ctr {
    type: average
    sql: ${ctr} ;;
  }

  measure: avg_position {
    type: average
    sql: ${position} ;;
  }

  set: detail {
    fields: [
      page_name,
      search_keywords,
      search_week,
      total_clicks,
      total_impressions,
      avg_ctr,
      avg_position,
      weekly_query_clicks_rank
    ]
  }
}
