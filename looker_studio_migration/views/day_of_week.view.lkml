view: day_of_week {
  derived_table: {
    sql: WITH unanswered_questions AS (
          SELECT
              question_id,
              creation_date,
              answer_count
          FROM `ritman.stackoverflow_analysis.unanswered_questions_facts`
          WHERE answer_count = 0
      )
      
      SELECT
          FORMAT_TIMESTAMP('%A', creation_date) AS day_of_week,  -- Get the day of the week
          COUNT(*) AS unanswered_question_count
      FROM unanswered_questions
      GROUP BY day_of_week
      ORDER BY unanswered_question_count DESC
      
      /* need to count how many qns total per day t get meaningful */ ;;
  }

  dimension: day_of_week {
    type: string
    label: "day_of_week"
    sql: ${TABLE}.day_of_week ;;
  }

  dimension: unanswered_question_count {
    type: number
    label: "unanswered_question_count"
    sql: ${TABLE}.unanswered_question_count ;;
  }

  measure: total_unanswered_question_count {
    type: sum
    label: "unanswered_question_count (sum)"
    sql: ${unanswered_question_count} ;;
  }
}
