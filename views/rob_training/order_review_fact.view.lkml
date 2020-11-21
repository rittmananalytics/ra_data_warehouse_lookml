view: order_review_fact {
  sql_table_name: `ra-development.rob_training.wh_order_review_fact`
    ;;

  dimension: order_id {
    type: string
    sql: ${TABLE}.order_id ;;
  }

  dimension: order_review_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.order_review_pk ;;
  }

  dimension_group: review_answer_timestamp {
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
    sql: ${TABLE}.review_answer_timestamp ;;
  }

  dimension: review_comment_message {
    type: string
    sql: ${TABLE}.review_comment_message ;;
  }

  dimension: review_comment_title {
    type: string
    sql: ${TABLE}.review_comment_title ;;
  }

  dimension_group: review_creation {
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
    sql: ${TABLE}.review_creation_date ;;
  }

  dimension: review_id {
    type: string
    sql: ${TABLE}.review_id ;;
  }

  dimension: review_score {
    type: number
    sql: ${TABLE}.review_score ;;
  }

  measure: count_of_reviews {
    type: count
    drill_fields: []
  }

  measure: average_review_score {
    type: average
    sql: ${TABLE}.review_score ;;
  }
}
