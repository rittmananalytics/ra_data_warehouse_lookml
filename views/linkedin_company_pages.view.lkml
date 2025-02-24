
view: linkedin_company_pages {
  derived_table: {
    sql: with posts as (SELECT ugc_post_id, post_author, post_url, created_timestamp, lifecycle_state, commentary, organization_id, post_title, post_type, organization_name, click_count, comment_count, impression_count, like_count, share_count FROM `ra-development.fivetran_linkedin_company_pages_linkedin_pages.linkedin_pages__posts` )
      select * from posts ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: ugc_post_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.ugc_post_id ;;
  }

  dimension: post_author {
    type: string
    sql: ${TABLE}.post_author ;;
  }

  dimension: post_url {
    type: string
    sql: ${TABLE}.post_url ;;
  }

  dimension_group: created_timestamp {
    type: time
    sql: ${TABLE}.created_timestamp ;;
  }

  dimension: lifecycle_state {
    type: string
    sql: ${TABLE}.lifecycle_state ;;
  }

  dimension: commentary {
    type: string
    sql: ${TABLE}.commentary ;;
  }

  dimension: organization_id {
    type: number
    sql: ${TABLE}.organization_id ;;
  }

  dimension: post_title {
    type: string
    sql: ${TABLE}.post_title ;;
  }

  dimension: post_type {
    type: string
    sql: ${TABLE}.post_type ;;
  }

  dimension: organization_name {
    type: string
    sql: ${TABLE}.organization_name ;;
  }

  measure: click_count {
    type: sum
    sql: ${TABLE}.click_count ;;
  }

  measure: comment_count {
    type: sum
    sql: ${TABLE}.comment_count ;;
  }

  measure: impression_count {
    type: sum
    sql: ${TABLE}.impression_count ;;
  }

  measure: like_count {
    type: sum
    sql: ${TABLE}.like_count ;;
  }

  measure: share_count {
    type: sum
    sql: ${TABLE}.share_count ;;
  }

  set: detail {
    fields: [
      ugc_post_id,
      post_author,
      post_url,
      created_timestamp_time,
      lifecycle_state,
      commentary,
      organization_id,
      post_title,
      post_type,
      organization_name,
      click_count,
      comment_count,
      impression_count,
      like_count,
      share_count
    ]
  }
}
