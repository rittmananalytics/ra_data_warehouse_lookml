view: content_performance {
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
      order by post_type, category, post_title, traffic_week
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

  dimension: post_date {
    type: string
    sql: ${TABLE}.post_date ;;
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
