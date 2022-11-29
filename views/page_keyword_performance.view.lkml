view: page_keyword_performance {
  derived_table: {
    persist_for: "24 hours"
    sql: with published_pages as (WITH
  posts AS (
  SELECT
    p.post_title AS Post_Title,
    'Content' AS post_type,
    t.name AS Category,
    p.post_date AS Post_Date,
    p.post_name AS Post_Name,
    p.comment_count AS post_comments,
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
SELECT
  *
FROM
  posts
GROUP BY
  1,
  2,
  3,
  4,
  5,
  6,
  7),
daily_performance as (
select p.post_title,
       p.post_date,
       p.post_type,
       p.category,
       date_trunc(g.date, WEEK) as week,
       g.query,
       sum(g.clicks) as clicks,
       sum(g.impressions) as impressions,
       avg(g.ctr) as ctr,
       avg(g.position) as position
from published_pages p
left join `ra-development.fivetran_google_search_console.keyword_page_report` g
on (case when g.page ='https://rittmananalytics.com/' then 'home' else g.page end) like concat('%',p.post_name,'%')
group by 1,2,3,4,5,6
)
select * from daily_performance
order by post_title, week
 ;;
  }



  dimension_group: week {
    type: time
    timeframes: [week,month,year]
    sql: timestamp(${TABLE}.week) ;;
  }

  dimension: post_title {
    type: string
    sql: ${TABLE}.post_title ;;
  }

  dimension: post_date {
    type: string
    sql: ${TABLE}.post_date ;;
  }

  dimension: weeks_since_post_date {
    type: number
    sql: ${TABLE}.weeks_since_post_date ;;
  }

  dimension: query {
    type: string
    sql: ${TABLE}.query ;;
  }

  dimension: post_category {
    type: string
    sql: initcap(${TABLE}.category) ;;
  }

  dimension: post_type {
    type: string
    sql: ${TABLE}.post_type ;;
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

  dimension: weekly_click_rank {
    type: number
    sql: ${TABLE}.weekly_click_rank ;;
  }

  dimension: weekly_impressions_rank {
    type: number
    sql: ${TABLE}.weekly_impressions_rank ;;
  }

  dimension: weekly_position_rank {
    type: number
    sql: ${TABLE}.weekly_position_rank ;;
  }

  dimension: weekly_ctr_rank {
    type: number
    sql: ${TABLE}.weekly_ctr_rank ;;
  }


}
