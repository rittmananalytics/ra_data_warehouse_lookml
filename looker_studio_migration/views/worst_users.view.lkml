view: worst_users {
  derived_table: {
    sql: WITH unanswered_questions AS (
          SELECT
              user_sk, 
              question_id
          FROM `ritman.stackoverflow_analysis.unanswered_questions_facts`
          WHERE answer_count = 0
      )
      
      SELECT 
          u.display_name,
          u.location,
          uq.user_sk,
          COUNT(uq.question_id) AS unanswered_question_count
      FROM unanswered_questions uq
      JOIN `ritman.stackoverflow_analysis.users_dimension` u
          ON uq.user_sk = u.user_sk
      GROUP BY u.display_name, u.location, uq.user_sk
      ORDER BY unanswered_question_count DESC
      LIMIT 20 ;;
  }

  dimension: display_name {
    type: string
    label: "display_name"
    sql: ${TABLE}.display_name ;;
  }

  dimension: location {
    type: string
    label: "location"
    sql: ${TABLE}.location ;;
  }

  dimension: unanswered_question_count {
    type: number
    label: "unanswered_question_count"
    sql: ${TABLE}.unanswered_question_count ;;
  }

  dimension: user_sk {
    type: number
    label: "user_sk"
    sql: ${TABLE}.user_sk ;;
  }

  measure: total_unanswered_question_count {
    type: sum
    label: "unanswered_question_count (sum)"
    sql: ${unanswered_question_count} ;;
  }
}
