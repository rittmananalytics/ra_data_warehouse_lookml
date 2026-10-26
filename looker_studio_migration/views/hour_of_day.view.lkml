view: hour_of_day {
  derived_table: {
    sql: WITH unanswered_questions AS (
          SELECT
              question_id,
              EXTRACT(HOUR FROM creation_date) AS hour_of_day,
              answer_count
          FROM `ritman.stackoverflow_analysis.unanswered_questions_facts`
          WHERE answer_count = 0
      ),
      hourly_counts AS (
          SELECT
              hour_of_day,
              COUNT(*) AS unanswered_question_count
          FROM unanswered_questions
          GROUP BY hour_of_day
      ),
      total_count AS (
          SELECT
              COUNT(*) AS total_unanswered_questions
          FROM unanswered_questions
      )
      SELECT
          h.hour_of_day,
          h.unanswered_question_count,
          ROUND(h.unanswered_question_count * 100.0 / t.total_unanswered_questions, 2) AS percentage_of_total
      FROM hourly_counts h
      CROSS JOIN total_count t
      ORDER BY h.unanswered_question_count DESC ;;
  }

  dimension: hour_of_day {
    type: number
    label: "hour_of_day"
    sql: ${TABLE}.hour_of_day ;;
  }

  dimension: percentage_of_total {
    type: number
    label: "percentage_of_total"
    sql: ${TABLE}.percentage_of_total ;;
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
