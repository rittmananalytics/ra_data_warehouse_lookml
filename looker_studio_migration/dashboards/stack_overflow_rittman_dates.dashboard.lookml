- dashboard: stack_overflow_rittman_dates
  title: Stack Overflow - Rittman - Dates
  layout: newspaper
  preferred_viewer: dashboards-next
  description: Migrated from Looker Studio report Stack Overflow - Rittman (ls_to_lookml 0.1.0, experimental)
  elements:
  - name: simple_table_cd_zf2ukczand
    model: looker_studio_migration
    explore: day_of_week
    type: looker_grid
    fields:
    - day_of_week.day_of_week
    - day_of_week.total_unanswered_question_count
    sorts:
    - day_of_week.total_unanswered_question_count desc
    limit: 100
    row: 1
    col: 0
    width: 8
    height: 6
  - name: simple_linechart_cd_5h3qrsyand
    model: looker_studio_migration
    explore: hour_of_day
    type: looker_line
    fields:
    - hour_of_day.hour_of_day
    - hour_of_day.total_unanswered_question_count
    sorts:
    - hour_of_day.hour_of_day asc
    limit: 500
    row: 2
    col: 11
    width: 6
    height: 5
  - name: text_cd_or4cevapnd
    type: text
    body_text: 'TODO: Compare with ALL data. Split by tag.'
    row: 5
    col: 18
    width: 4
    height: 1
  - name: simple_table_cd_y26qv2yand
    model: looker_studio_migration
    explore: most_recent_questions
    type: looker_grid
    fields:
    - most_recent_questions.title
    - most_recent_questions.tags
    - most_recent_questions.total_view_count
    sorts:
    - most_recent_questions.total_view_count desc
    limit: 100
    row: 8
    col: 0
    width: 10
    height: 5
  - name: simple_table_cd_qgwtpnzand
    model: looker_studio_migration
    explore: avg_views_per_question
    type: looker_grid
    fields:
    - avg_views_per_question.tag
    - avg_views_per_question.question_count
    - avg_views_per_question.avg_views_per_question
    - avg_views_per_question.total_total_view_count
    sorts:
    - avg_views_per_question.total_total_view_count desc
    limit: 100
    row: 8
    col: 11
    width: 12
    height: 7
  - name: text_cd_jc2bbicqnd
    type: text
    body_text: 'TODO: Qualitative analysis. Or at least use Chatgpt.'
    row: 13
    col: 0
    width: 10
    height: 1
  - name: text_cd_eee7gzapnd
    type: text
    body_text: 'TODO:ML: What are the features that predict whether a qn is unanswered and popular? Tag, difficulty (?use text of ''hard''/''easy'' questions? ), user demographicHow do these qns compare with ones answered after a long/medium/short time.'
    row: 16
    col: 1
    width: 15
    height: 2
