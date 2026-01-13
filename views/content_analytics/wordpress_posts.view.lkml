view: wordpress_posts {
  derived_table: {
    sql: SELECT * FROM
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
        7
      UNION ALL
      select p.post_title,
             'Marketing' as post_type,
             initcap(post_type) as category,
             p.post_date,
             p.post_name,
             p.comment_count,
             p.post_excerpt
      from bitnami_wordpress.wp_posts p
      where p.post_type in ('page','technology','industry','offer','service') and p.post_status = 'publish'
      group by 1,2,3,4,5,6,7
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: page_title {
    type: string
    sql: ${TABLE}.Post_Title ;;
  }

  dimension: page_type {
    type: string
    sql: ${TABLE}.post_type ;;
  }

  dimension: page_category {
    type: string
    sql: ${TABLE}.Category ;;
  }

  dimension_group: publish {
    type: time
    timeframes: [date,week,month,quarter,year]
    sql: cast(${TABLE}.Post_Date as timestamp) ;;
  }

  dimension: page_name {
    type: string
    sql: ${TABLE}.Post_Name ;;
  }

  dimension: pk {
    type: string
    sql: concat(${page_type},${page_category},${page_name}) ;;
  }

  dimension: comment_count {
    hidden: yes
    type: number
    sql: ${TABLE}.comment_count ;;
  }

  measure: total_comments {
    type: sum
    sql: ${comment_count} ;;
    drill_fields: [detail*]
  }

  dimension: post_excerpt {
    type: string
    sql: ${TABLE}.post_excerpt ;;
  }

  set: detail {
    fields: [
      page_title,
      page_type,
      page_category,
      publish_week,
      publish_month,
      publish_quarter,
      publish_year,
      page_name,
      comment_count,
      post_excerpt
    ]
  }
}
