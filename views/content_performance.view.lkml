view: content_performance {
  derived_table: {
    sql: WITH
  published_pages AS (
  SELECT * FROM
    (
  SELECT
    p.post_title AS Post_Title,
    'Content' AS post_type,
    t.name AS Category,
    p.post_date AS Post_Date,
    p.post_name AS Post_Name,
    p.comment_count AS comment_count,
    p.post_excerpt
  FROM (
    SELECT
      id,
      post_title,
      Post_Date,
      Post_Name,
      post_type,
      post_status,
      post_excerpt,
      comment_count
    FROM (
      SELECT
        *,
        post_modified = MAX(post_modified) OVER (PARTITION BY CAST(p.id AS int64) ROWS BETWEEN UNBOUNDED PRECEDING
          AND UNBOUNDED FOLLOWING) AS is_last_modified_ts
      FROM
        bitnami_wordpress.wp_posts p )
    WHERE
      is_last_modified_ts
    GROUP BY
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8) p
  JOIN
    bitnami_wordpress.wp_term_relationships tr
  ON
    p.ID = tr.object_id
  JOIN
    bitnami_wordpress.wp_terms t
  ON
    tr.term_taxonomy_id = t.term_id
  JOIN
    bitnami_wordpress.wp_term_taxonomy tx
  ON
    tx.term_id = t.term_id
  WHERE
    p.post_type = 'post'
    AND p.post_status = 'publish'
    AND tx.taxonomy = 'category' )
GROUP BY
  1,
  2,
  3,
  4,
  5,
  6,
  7),
      traffic as (
      SELECT
      case when path = '/' then 'home' else coalesce(lower(array_reverse(
      split(rtrim(path,'/'),'/'))[safe_offset(0)]),'home') end as page_name,
      date_trunc(date(timestamp),week) as traffic_week,
      count(distinct anonymous_id) total_unique_visitors,
      count(*) as total_page_views,
      sum(case when referring_domain is not null and referring_domain not like '%rittmananalytics.com%' then 1 else 0 end) as referral_page_views
      FROM
      `ra-development.rudderstack_ra_website.pages`
      GROUP BY 1,2
      ),
      search as (
      SELECT
      case when page = 'https://rittmananalytics.com/' then 'home' else coalesce(lower(array_reverse(
      split(rtrim(page,'/'),'/'))[safe_offset(0)]),'home') end as page_name,
      date_trunc(date, WEEK) as search_week,
      sum(clicks) as clicks,
      sum(impressions) as impressions,
      avg(ctr) as ctr,
      avg(position) as position
      FROM
      `ra-development.fivetran_google_search_console.keyword_page_report`
      GROUP BY
      1,2
      )
      select post_title,
      post_type,
      category,
      post_date,
      traffic_week,
      date_diff(traffic_week,date(cast(post_date as timestamp)),week) as weeks_since_post_date,
      post_excerpt,
      comment_count,
      total_unique_visitors,
      total_page_views,
      referral_page_views,
      clicks,
      impressions,
      ctr,
      position
      from traffic t
      left join published_pages p
      on t.page_name = p.post_name
      left join search s
      on t.page_name = s.page_name
      and t.traffic_week = s.search_week
      where category in ('Blog','Podcast')

      ;;
  }


  dimension: post_title {
    type: string
    sql: ${TABLE}.post_title ;;
  }

  dimension: post_type {
    type: string
    sql: ${TABLE}.post_type ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension_group: post {
    type: time
    timeframes: [date,week,month,quarter,year]
    sql: timestamp(${TABLE}.post_date) ;;
  }

  dimension: weeks_since_post_date {
    type: number
    sql: ${TABLE}.weeks_since_post_date ;;
  }



  dimension_group: traffic {
    type: time
    timeframes: [week,year]
    sql: timestamp(${TABLE}.traffic_week);;
  }

  dimension: unique_visitors {
    type: number
    sql: ${TABLE}.total_unique_visitors ;;
  }

  dimension: page_views {
    type: number
    sql: ${TABLE}.total_page_views ;;
  }

  dimension: referral_page_views {
    type: number
    sql: ${TABLE}.referral_page_views ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
  }

  measure: total_clicks {
    type: sum
    sql: ${clicks} ;;
  }

  measure: total_impressions {
    type: sum
    sql: ${impressions} ;;
  }

  measure: avg_ctr {
    type: average
    sql: ${ctr};;
  }

  measure: avg_position {
    type: average
    sql: ${position} ;;

  }

  measure: total_page_views {
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

  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }

  dimension: ctr {
    type: number
    sql: ${TABLE}.ctr ;;
  }

  dimension: position {
    type: number
    sql: ${TABLE}.position ;;
  }


}
