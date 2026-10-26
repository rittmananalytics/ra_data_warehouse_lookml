view: locations {
  derived_table: {
    sql: WITH unanswered_questions AS (
          SELECT
              `ritman.stackoverflow_analysis.unanswered_questions_facts`.user_sk, 
              location, 
              question_id
          FROM `ritman.stackoverflow_analysis.unanswered_questions_facts`
          JOIN `ritman.stackoverflow_analysis.users_dimension` u
              ON `ritman.stackoverflow_analysis.unanswered_questions_facts`.user_sk = u.user_sk
          WHERE answer_count = 0
      )
      
      SELECT 
          location,
          COUNT(question_id) AS unanswered_question_count
      FROM unanswered_questions
      GROUP BY location
      ORDER BY unanswered_question_count DESC
      LIMIT 20 ;;
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
}
