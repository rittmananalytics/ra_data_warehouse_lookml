view: user_buckets {
  derived_table: {
    sql: WITH unanswered_questions AS (
          SELECT
              user_sk, 
              question_id
          FROM `ritman.stackoverflow_analysis.unanswered_questions_facts`
          WHERE answer_count = 0
      ),
      user_unanswered_counts AS (
          SELECT 
              uq.user_sk,
              COUNT(uq.question_id) AS unanswered_question_count
          FROM unanswered_questions uq
          GROUP BY uq.user_sk
      ),
      bucketed_users AS (
          SELECT 
              c.user_sk,
              CASE 
                  WHEN c.unanswered_question_count < 10 THEN '< 10'
                  WHEN c.unanswered_question_count BETWEEN 10 AND 19 THEN '10 to 19'
                  WHEN c.unanswered_question_count BETWEEN 20 AND 49 THEN '20 to 49'
                  WHEN c.unanswered_question_count BETWEEN 50 AND 99 THEN '50 to 99'
                  ELSE '100+'
              END AS bucket
          FROM user_unanswered_counts c
      )
      SELECT 
          bucket,
          COUNT(*) AS user_count
      FROM bucketed_users
      GROUP BY bucket
      ORDER BY 
          CASE 
              WHEN bucket = '100+' THEN 1
              WHEN bucket = '50 to 99' THEN 2
              WHEN bucket = '20 to 49' THEN 3
              WHEN bucket = '10 to 19' THEN 4
              WHEN bucket = '< 10' THEN 5
          END ;;
  }

  dimension: bucket {
    type: string
    label: "bucket"
    sql: ${TABLE}.bucket ;;
  }

  dimension: user_count {
    type: number
    label: "user_count"
    sql: ${TABLE}.user_count ;;
  }

  measure: total_user_count {
    type: sum
    label: "user_count (sum)"
    sql: ${user_count} ;;
  }
}
