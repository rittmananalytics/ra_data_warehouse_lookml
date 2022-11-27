view: page_keyword_performance {
  derived_table: {
    sql: with published_pages as (SELECT p.post_title as Post_Title,
       case when p.post_type = 'case-study' then 'Marketing'  else 'Content' end as post_type,
       case when p.post_type = 'case-study' then 'case study' else t.name end as Category,
       p.post_date as Post_Date,
       p.post_name as Post_Name
FROM bitnami_wordpress.wp_posts p,
     bitnami_wordpress.wp_terms t,
     bitnami_wordpress.wp_term_relationships tr,
     bitnami_wordpress.wp_term_taxonomy tx
WHERE ((p.post_type  = 'post'
AND p.post_status = 'publish'
AND tx.taxonomy = 'category') or (p.post_type = 'case-study' and tx.taxonomy = 'case-study-category')

)
AND p.ID = tr.object_id
AND tr.term_taxonomy_id = t.term_id
AND tx.term_id = t.term_id
group by 1,2,3,4,5
union all
select p.post_title,
       'Marketing' as post_type,
       post_type as category,
       p.post_date,
       p.post_name
from bitnami_wordpress.wp_posts p
where p.post_type in ('page','technology','industry','offer','service') and p.post_status = 'publish'),
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
