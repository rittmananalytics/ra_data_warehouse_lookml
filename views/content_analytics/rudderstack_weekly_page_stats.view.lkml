view: rudderstack_weekly_page_stats {
  derived_table: {
    sql: SELECT
        title,
        CASE
          WHEN path = '/' THEN 'home'
        ELSE
        COALESCE(LOWER(ARRAY_REVERSE( SPLIT(RTRIM(path,'/'),'/'))[SAFE_OFFSET(0)]),'home')
      END
        AS page_name,
        DATE_TRUNC(DATE(timestamp),week) AS traffic_week,
        COUNT(DISTINCT anonymous_id) total_unique_visitors,
        COUNT(*) AS total_page_views,
        SUM(CASE
            WHEN referring_domain IS NOT NULL AND referring_domain NOT LIKE '%rittmananalytics.com%' THEN 1
          ELSE
          0
        END
          ) AS referral_page_views
      FROM
        `ra-development.rudderstack_ra_website.pages`
      GROUP BY
        1,
        2,
        3
       ;;
  }



  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: page_name {
    hidden: yes
    type: string
    sql: ${TABLE}.page_name ;;
  }

  dimension_group: traffic {
    type: time
    timeframes: [raw,week,quarter,year]
    datatype: timestamp
    sql: timestamp(${TABLE}.traffic_week) ;;
  }

  dimension: pk {
    type: string
    sql: concat(${page_name},${traffic_raw}) ;;
  }

  dimension: unique_visitors {
    hidden: yes
    type: number
    sql: ${TABLE}.total_unique_visitors ;;
  }

  dimension: page_views {
    hidden: yes
    type: number
    sql: ${TABLE}.total_page_views ;;
  }

  dimension: referral_page_views {
    hidden: yes
    type: number
    sql: ${TABLE}.referral_page_views ;;
  }

  measure: total_page_views  {
    type: sum
    sql: ${page_views} ;;
  }

  measure: total_unique_visitors {
    type: sum
    sql: ${unique_visitors} ;;
  }

  measure: total_referral_page_views {
    type: sum
    sql: ${referral_page_views} ;;
  }

  set: detail {
    fields: [
      title,
      page_name,
      traffic_week,
      total_unique_visitors,
      total_page_views,
      referral_page_views
    ]
  }
}
