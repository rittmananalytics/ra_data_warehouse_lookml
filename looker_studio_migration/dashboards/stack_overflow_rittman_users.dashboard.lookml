- dashboard: stack_overflow_rittman_users
  title: Stack Overflow - Rittman - Users
  layout: newspaper
  preferred_viewer: dashboards-next
  description: Migrated from Looker Studio report Stack Overflow - Rittman (ls_to_lookml 0.1.0, experimental)
  elements:
  - name: kpi_metric_cd_86om6mvand
    model: looker_studio_migration
    explore: unanswered_questions_facts
    type: single_value
    fields:
    - unanswered_questions_facts.avg_view_count
    - unanswered_questions_facts.total_total_unanswered_questions
    sorts:
    - unanswered_questions_facts.avg_view_count asc
    limit: 500
    row: 1
    col: 1
    width: 4
    height: 2
  - name: kpi_metric_cd_s0fyc2vand
    model: looker_studio_migration
    explore: unanswered_questions_facts
    type: single_value
    fields:
    - unanswered_questions_facts.avg_view_count
    - unanswered_questions_facts.total_max_view_count
    sorts:
    - unanswered_questions_facts.avg_view_count asc
    limit: 500
    row: 1
    col: 5
    width: 4
    height: 2
  - name: kpi_metric_cd_jd50a3vand
    model: looker_studio_migration
    explore: unanswered_questions_facts
    type: single_value
    fields:
    - unanswered_questions_facts.avg_view_count
    - unanswered_questions_facts.total_min_view_count
    sorts:
    - unanswered_questions_facts.avg_view_count asc
    limit: 500
    row: 1
    col: 9
    width: 4
    height: 2
  - name: kpi_metric_cd_kzqkf4vand
    model: looker_studio_migration
    explore: unanswered_questions_facts
    type: single_value
    fields:
    - unanswered_questions_facts.total_avg_view_count
    limit: 500
    row: 1
    col: 13
    width: 4
    height: 2
  - name: text_cd_fsapurapnd
    type: text
    body_text: 'TODO: Compare with ALL data.'
    row: 2
    col: 18
    width: 4
    height: 1
  - name: text_cd_s3g48awand
    type: text
    body_text: ​What is console.log and how do I use it? - a MERGED question
    row: 3
    col: 1
    width: 9
    height: 1
  - name: simple_table_cd_999erkwand
    model: looker_studio_migration
    explore: top_10_tags
    type: looker_grid
    fields:
    - top_10_tags.tag
    - top_10_tags.total_unanswered_question_count
    sorts:
    - top_10_tags.total_unanswered_question_count desc
    limit: 100
    row: 5
    col: 1
    width: 8
    height: 7
  - name: text_cd_mrwz77vand
    type: text
    body_text: ''
    row: 5
    col: 2
    width: 8
    height: 3
  - name: simple_table_cd_6cg89axand
    model: looker_studio_migration
    explore: worst_users
    type: looker_grid
    fields:
    - worst_users.display_name
    - worst_users.total_unanswered_question_count
    sorts:
    - worst_users.total_unanswered_question_count desc
    limit: 15
    row: 5
    col: 9
    width: 7
    height: 7
  - name: simple_table_cd_5j0xslxand
    model: looker_studio_migration
    explore: user_buckets
    type: looker_grid
    fields:
    - user_buckets.bucket
    - user_buckets.total_user_count
    limit: 5
    row: 5
    col: 17
    width: 7
    height: 4
  - name: google_map_cd_s2c7zmyand
    model: looker_studio_migration
    explore: locations
    type: looker_grid
    fields:
    - locations.location
    sorts:
    - locations.location desc
    limit: 3500
    row: 9
    col: 17
    width: 7
    height: 6
  - name: text_cd_jw0xfsapnd
    type: text
    body_text: 'TODO: Compare with ALL data. Over time?'
    row: 12
    col: 1
    width: 4
    height: 1
  - name: text_cd_bkrovtapnd
    type: text
    body_text: 'TODO: Compare with ALL data. Over time? Other demographics?'
    row: 12
    col: 9
    width: 4
    height: 1
