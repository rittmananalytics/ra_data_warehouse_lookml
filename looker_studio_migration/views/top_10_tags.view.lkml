view: top_10_tags {
  derived_table: {
    sql: WITH exploded_tags AS (
          -- Split the tags into individual rows
          SELECT
              question_id,
              title,
              tags,
              user_sk,
              -- Split the tags by '|' and explode into multiple rows
              tag
          FROM `ritman.stackoverflow_analysis.unanswered_questions_facts`,
          UNNEST(SPLIT(tags, '|')) AS tag
      )
      
      -- Count unanswered questions per tag
      SELECT
          tag,
          COUNT(*) AS unanswered_question_count
      FROM exploded_tags
      -- Ensure the condition is applied from the correct table column for unanswered questions
      WHERE EXISTS (
          SELECT 1
          FROM `ritman.stackoverflow_analysis.unanswered_questions_facts` f
          WHERE f.question_id = exploded_tags.question_id
            AND f.answer_count = 0
      )
      GROUP BY tag
      ORDER BY unanswered_question_count DESC
      LIMIT 10 ;;
  }

  dimension: tag {
    type: string
    label: "tag"
    sql: ${TABLE}.tag ;;
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
