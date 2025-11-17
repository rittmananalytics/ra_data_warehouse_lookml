view: delivery_project_cycle_times {
derived_table: {
  sql: WITH base AS (
  SELECT
    issue_key,
    issue_id,
    assignee_name,
    sprint_id,
    sprint_name,
    date_day,
    status,
    story_points,
    story_point_estimate,
    issue_created_at
  FROM `ra-development.fivetran_jira_jira.jira__daily_sprint_issue_history`

),

-- latest row per issue
latest_status AS (
  SELECT
    issue_key,
    issue_id,
    assignee_name,
    sprint_id,
    sprint_name,
    issue_created_at
  FROM (
    SELECT
      b.*,
      ROW_NUMBER() OVER (
        PARTITION BY issue_id
        ORDER BY date_day DESC
      ) AS rn
    FROM base b
  )
  WHERE rn = 1
),

-- first non Open status per issue (cycle start)
cycle_start AS (
  SELECT
    issue_id,
    date_day AS cycle_start_day,
    status AS cycle_start_status,
    story_points AS story_points_cycle_start,
    story_point_estimate AS story_point_estimate_cycle_start
  FROM (
    SELECT
      b.*,
      ROW_NUMBER() OVER (
        PARTITION BY issue_id
        ORDER BY date_day
      ) AS rn
    FROM base b
    WHERE status not in ('Open','To Do')
  )
  WHERE rn = 1
),

-- first Done status per issue (cycle complete)
cycle_complete AS (
  SELECT
    issue_id,
    date_day AS cycle_complete_day,
    status AS cycle_complete_status
  FROM (
    SELECT
      b.*,
      ROW_NUMBER() OVER (
        PARTITION BY issue_id
        ORDER BY date_day
      ) AS rn
    FROM base b
    WHERE status in ('Done','Resolved','Complete')
  )
  WHERE rn = 1
),

-- first status at creation for each issue (do NOT exclude Open, and do NOT filter by assignee)
first_status AS (
  SELECT
    issue_id,
    status AS first_issue_status
  FROM (
    SELECT
      d.issue_id,
      d.status,
      ROW_NUMBER() OVER (
        PARTITION BY d.issue_id
        ORDER BY d.date_day
      ) AS rn
    FROM `ra-development.fivetran_jira_jira.jira__daily_sprint_issue_history` d

  )
  WHERE rn = 1
),

issue_meta AS (
  SELECT
    ie.issue_id,
    pe.project_name,
    ie.assignee_email
  FROM `ra-development.fivetran_jira_jira.jira__issue_enhanced` ie
  LEFT JOIN `ra-development.fivetran_jira_jira.jira__project_enhanced` pe
    ON ie.project_id = pe.project_id
)

SELECT
  l.issue_key,
  l.issue_id,
  l.assignee_name,
  im.assignee_email,
  l.sprint_id,
  l.sprint_name,
  im.project_name,
  l.issue_created_at,
  fs.first_issue_status,
  cs.story_points_cycle_start,
  cs.story_point_estimate_cycle_start,
  cs.cycle_start_day,
  cs.cycle_start_status,
  cc.cycle_complete_day,
  cc.cycle_complete_status,
  CASE
    WHEN cc.cycle_complete_day IS NULL THEN NULL
    ELSE DATE_DIFF(cc.cycle_complete_day, cs.cycle_start_day, DAY)
  END AS total_cycle_days,
  safe_divide(CASE
    WHEN cc.cycle_complete_day IS NULL THEN NULL
    ELSE DATE_DIFF(cc.cycle_complete_day, cs.cycle_start_day, DAY)
  END,story_points_cycle_start) as cycle_days_per_story_point,
  CASE WHEN story_points_cycle_start is null then 1 else 0 end as is_unpointed_issue,
  CASE WHEN cycle_start_day is null then 1 else 0 end as is_notstarted_issue,
  CASE WHEN cycle_start_day is not null and cycle_complete_day is null then 1 else 0 end as is_incomplete_issue,
FROM latest_status l
LEFT JOIN cycle_start cs
  ON l.issue_id = cs.issue_id
LEFT JOIN cycle_complete cc
  ON l.issue_id = cc.issue_id
LEFT JOIN issue_meta im
  ON l.issue_id = im.issue_id
LEFT JOIN first_status fs
  ON l.issue_id = fs.issue_id
ORDER BY im.project_name, l.issue_key;

    ;;
}

measure: count {
  type: count
  drill_fields: [detail*]
}

dimension: issue_key {
  type: string
  primary_key: yes
  sql: ${TABLE}.issue_key ;;
}

dimension: issue_id {
  type: number
  sql: ${TABLE}.issue_id ;;
}

dimension: client_name {
  type: string
  sql: ${project_name} ;;
}

dimension: assignee_name {
  type: string
  sql: ${TABLE}.assignee_name ;;
}

dimension: sprint_id {
  type: string
  sql: ${TABLE}.sprint_id ;;
}

dimension: sprint_name {
  type: string
  sql: ${TABLE}.sprint_name ;;
}

dimension: project_name {
  type: string
  sql: ${TABLE}.project_name ;;
}

dimension_group: issue_created_at {
  type: time
  sql: ${TABLE}.issue_created_at ;;
}

dimension: first_issue_status {
  type: string
  sql: ${TABLE}.first_issue_status ;;
}

dimension: story_points_cycle_start {
  type: number
  sql: ${TABLE}.story_points_cycle_start ;;
}

dimension: story_point_estimate_cycle_start {
  type: number
  sql: ${TABLE}.story_point_estimate_cycle_start ;;
}

dimension_group: cycle_start_day {
  type: time
  datatype: timestamp
  sql: timestamp(${TABLE}.cycle_start_day) ;;
}

dimension: cycle_start_status {
  type: string
  sql: ${TABLE}.cycle_start_status ;;
}

dimension: cycle_complete_day {
  type: date
  datatype: date
  sql: ${TABLE}.cycle_complete_day ;;
}

dimension: cycle_complete_status {
  type: string
  sql: ${TABLE}.cycle_complete_status ;;
}

dimension: total_cycle_days {
  type: number
  hidden: yes

  sql: ${TABLE}.total_cycle_days ;;
}

measure: avg_cycle_days {
  type: average
  value_format_name: decimal_1

  sql: ${total_cycle_days} ;;
}

dimension: cycle_days_per_story_point {
  type: number
  hidden: yes

  sql: ${TABLE}.cycle_days_per_story_point ;;
}

measure: avg_cycle_days_per_story_point {
  type: average
  value_format_name: decimal_1
  sql: ${cycle_days_per_story_point} ;;
}

dimension: is_unpointed_issue {
  type: number
  hidden: yes

  sql: ${TABLE}.is_unpointed_issue ;;
}

measure: total_unpointed_issues {
  type: sum
  sql: ${is_unpointed_issue} ;;
}

dimension: is_notstarted_issue {
  type: number
  hidden: yes
  sql: ${TABLE}.is_notstarted_issue ;;
}

measure: total_assigned_not_started_issues {
  type: sum
  sql: ${is_notstarted_issue} ;;
}

dimension: is_incomplete_issue {
  type: number
  hidden: yes
  sql: ${TABLE}.is_incomplete_issue ;;
}

measure: total_started_incomplete_issues {
  type: sum
  sql: ${is_incomplete_issue} ;;
}

dimension: is_complete_issue {
  type: number
  hidden: yes
  sql: ${TABLE}.is_complete_issue ;;
}

measure: total_started_complete_issues {
  type: sum
  sql: ${is_complete_issue} ;;
}

measure: total_issues {
  type: count_distinct
  sql: ${issue_key} ;;
}



set: detail {
  fields: [
    issue_key,
    issue_id,
    assignee_name,
    sprint_id,
    sprint_name,
    project_name,
    issue_created_at_time,
    first_issue_status,
    story_points_cycle_start,
    story_point_estimate_cycle_start,
    cycle_start_status,
    cycle_complete_day,
    cycle_complete_status,
    total_cycle_days,
    cycle_days_per_story_point,
    is_unpointed_issue,
    is_notstarted_issue,
    is_incomplete_issue
  ]
}
}
