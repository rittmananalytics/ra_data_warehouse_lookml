view: google_search_console_weekly_stats {
  derived_table: {
    sql: WITH
          page_keyword_performance AS (
          SELECT
            CASE
              WHEN page = 'https://rittmananalytics.com/' THEN 'home'
            ELSE
            COALESCE(LOWER(ARRAY_REVERSE( SPLIT(RTRIM(page,'/'),'/'))[SAFE_OFFSET(0)]),'home')
          END
            AS page_name,
            query AS search_keywords,
            DATE_TRUNC(date, WEEK) AS search_week,
            SUM(clicks) AS total_clicks,
            SUM(impressions) AS total_impressions,
            AVG(ctr) AS avg_ctr,
            AVG(position) AS avg_position
          FROM
            `ra-development.fivetran_google_search_console.keyword_page_report`
          GROUP BY
            1,
            2,
            3)
        SELECT
          *,
          ROW_NUMBER() OVER (PARTITION BY search_week ORDER BY total_clicks DESC) AS weekly_query_clicks_rank
        FROM
          page_keyword_performance;;
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
