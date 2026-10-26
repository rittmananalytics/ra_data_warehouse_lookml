view: most_recent_questions {
  derived_table: {
    sql: WITH most_recent_date AS (
          SELECT MAX(creation_date) AS latest_date
          FROM `ritman.stackoverflow_analysis.unanswered_questions_facts`
      ),
      last_week_unanswered AS (
          SELECT
              question_id,
              title,
              body,
              creation_date,
              view_count,
              tags
          FROM `ritman.stackoverflow_analysis.unanswered_questions_facts`,
               most_recent_date
          WHERE answer_count = 0
            AND creation_date >= TIMESTAMP_SUB(latest_date, INTERVAL 7 DAY)
            AND creation_date <= latest_date
      )
      SELECT
          question_id,
          title,
          body,
          creation_date,
          view_count,
          tags
      FROM last_week_unanswered
      ORDER BY view_count DESC
      LIMIT 10 ;;
  }

  dimension: body {
    type: string
    label: "body"
    sql: ${TABLE}.body ;;
  }

  dimension: creation_date {
    type: string
    label: "creation_date"
    sql: ${TABLE}.creation_date ;;
  }

  dimension: question_id {
    type: number
    label: "question_id"
    sql: ${TABLE}.question_id ;;
  }

  dimension: tags {
    type: string
    label: "tags"
    sql: ${TABLE}.tags ;;
  }

  dimension: title {
    type: string
    label: "title"
    sql: ${TABLE}.title ;;
  }

  dimension: view_count {
    type: number
    label: "view_count"
    sql: ${TABLE}.view_count ;;
  }

  dimension_group: creation_date_as_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    datatype: date
    convert_tz: no
    label: "creation_date (as date)"
    sql: DATE(SAFE_CAST(${TABLE}.creation_date AS TIMESTAMP)) ;;
  }

  measure: total_view_count {
    type: sum
    label: "view_count (sum)"
    sql: ${view_count} ;;
  }
}
