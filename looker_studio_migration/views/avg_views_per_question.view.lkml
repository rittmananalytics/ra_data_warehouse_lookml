view: avg_views_per_question {
  derived_table: {
    sql: WITH most_recent_date AS (
          SELECT MAX(creation_date) AS latest_date
          FROM `ritman.stackoverflow_analysis.unanswered_questions_facts`
      ),
      tag_stats AS (
          SELECT
              tag,
              COUNT(*) AS question_count,                  -- Total number of questions per tag
              SUM(view_count) AS total_view_count,         -- Total view count for the tag
              AVG(view_count) AS avg_views_per_question    -- Average views per question
          FROM `ritman.stackoverflow_analysis.unanswered_questions_facts`,
               UNNEST(SPLIT(tags, '|')) AS tag
          WHERE answer_count = 0
            AND creation_date >= TIMESTAMP_SUB((SELECT latest_date FROM most_recent_date), INTERVAL 7 DAY)
            AND creation_date <= (SELECT latest_date FROM most_recent_date)
          GROUP BY tag
          ORDER BY total_view_count DESC
          LIMIT 10 -- Get the top 10 tags
      )
      SELECT
          tag,
          question_count,
          total_view_count,
          avg_views_per_question
      FROM tag_stats
      ORDER BY avg_views_per_question DESC ;;
  }

  dimension: avg_views_per_question {
    type: number
    label: "avg_views_per_question"
    sql: ${TABLE}.avg_views_per_question ;;
  }

  dimension: question_count {
    type: number
    label: "question_count"
    sql: ${TABLE}.question_count ;;
  }

  dimension: tag {
    type: string
    label: "tag"
    sql: ${TABLE}.tag ;;
  }

  dimension: total_view_count {
    type: number
    label: "total_view_count"
    sql: ${TABLE}.total_view_count ;;
  }

  measure: total_total_view_count {
    type: sum
    label: "total_view_count (sum)"
    sql: ${total_view_count} ;;
  }
}
