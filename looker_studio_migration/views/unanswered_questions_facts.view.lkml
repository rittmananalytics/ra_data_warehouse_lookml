view: unanswered_questions_facts {
  derived_table: {
    sql: WITH base AS (
          SELECT
              view_count
          FROM `ritman.stackoverflow_analysis.unanswered_questions_facts`
          WHERE answer_count = 0
      )
      
      SELECT 
          COUNT(*) AS total_unanswered_questions,  -- Total unanswered questions
          AVG(view_count) AS avg_view_count,      -- Average views on unanswered questions
          MAX(view_count) AS max_view_count,      -- Max views on unanswered questions
          MIN(view_count) AS min_view_count       -- Min views on unanswered questions
      FROM base ;;
  }

  dimension: avg_view_count {
    type: number
    label: "avg_view_count"
    sql: ${TABLE}.avg_view_count ;;
  }

  dimension: max_view_count {
    type: number
    label: "max_view_count"
    sql: ${TABLE}.max_view_count ;;
  }

  dimension: min_view_count {
    type: number
    label: "min_view_count"
    sql: ${TABLE}.min_view_count ;;
  }

  dimension: total_unanswered_questions {
    type: number
    label: "total_unanswered_questions"
    sql: ${TABLE}.total_unanswered_questions ;;
  }

  measure: total_avg_view_count {
    type: sum
    label: "avg_view_count (sum)"
    sql: ${avg_view_count} ;;
  }

  measure: total_max_view_count {
    type: sum
    label: "max_view_count (sum)"
    sql: ${max_view_count} ;;
  }

  measure: total_min_view_count {
    type: sum
    label: "min_view_count (sum)"
    sql: ${min_view_count} ;;
  }

  measure: total_total_unanswered_questions {
    type: sum
    label: "total_unanswered_questions (sum)"
    sql: ${total_unanswered_questions} ;;
  }
}
