view: src_control_pull_requests_fact {
  sql_table_name: `ra-development.analytics.src_control_pull_requests_fact` ;;


  # Primary key
  dimension: src_control_pr_pk {
    primary_key: yes
    type: string
    hidden: yes
    description: "Surrogate primary key for the pull request record."
    sql: ${TABLE}.src_control_pr_pk ;;
  }

  # Hidden technical fields
  dimension: _dbt_source_relation {
    type: string
    hidden: yes
    description: "dbt technical field identifying the upstream source relation."
    sql: ${TABLE}._dbt_source_relation ;;
  }

  # Hidden identifiers and foreign keys
  dimension: pr_id {
    type: string
    hidden: yes
    description: "Source system pull request identifier."
    sql: ${TABLE}.pr_id ;;
  }

  dimension: repo_id {
    type: string
    hidden: yes
    description: "Source system repository identifier."
    sql: ${TABLE}.repo_id ;;
  }

  dimension: src_control_repo_fk {
    type: string
    hidden: yes
    description: "Foreign key to the repository dimension."
    sql: ${TABLE}.src_control_repo_fk ;;
  }

  dimension: contact_fk {
    type: string
    hidden: yes
    description: "Foreign key to PR author person, if pull requests are associated to CRM contacts."
    sql: ${TABLE}.contact_fk ;;
  }

  dimension: reviewer_contact_fk {
    type: string
    hidden: yes
    description: "Foreign key to PR reviewer person, if pull requests are associated to CRM contacts."
    sql: ${TABLE}.reviewer_contact_fk ;;
  }

  dimension: pr_creator_user_id {
    type: string
    hidden: yes
    description: "Source system user identifier for the PR creator."
    sql: ${TABLE}.pr_creator_user_id ;;
  }

  # Repository context
  dimension: repo_name {
    group_label: "Repository"
    type: string
    description: "Repository name."
    hidden: yes
    sql: ${TABLE}.repo_name ;;
  }

  # Pull request descriptors
  dimension: pr_number {
    group_label: "       Pull Request"
    type: number
    description: "Pull request number within the repository."
    sql: ${TABLE}.pr_number ;;
  }

  dimension: pr_title {
    group_label: "       Pull Request"
    type: string
    description: "Pull request title."
    sql: ${TABLE}.pr_title ;;
  }

  dimension: pr_body {
    group_label: "       Pull Request"
    type: string
    description: "Pull request body text."
    sql: ${TABLE}.pr_body ;;
  }

  dimension: pr_url {
    group_label: "       Pull Request"
    type: string
    description: "Pull request URL."
    sql: ${TABLE}.pr_url ;;
  }

  dimension: pr_state {
    group_label: "       Pull Request"
    type: string
    description: "Pull request state, for example open, closed, merged."
    sql: ${TABLE}.pr_state ;;
  }

  dimension: pr_is_merged {
    group_label: "       Pull Request"
    type: yesno
    description: "Yes if the pull request was merged."
    sql: ${TABLE}.pr_is_merged ;;
  }

  dimension: pr_labels {
    group_label: "       Pull Request"
    type: string
    description: "Labels applied to the pull request."
    sql: ${TABLE}.pr_labels ;;
  }

  dimension: pr_requested_reviewers {
    group_label: "       Pull Request"
    type: string
    description: "Requested reviewers for the pull request."
    sql: ${TABLE}.pr_requested_reviewers ;;
  }

  dimension: pr_reviewers {
    group_label: "       Pull Request"
    type: string
    description: "Reviewers who reviewed the pull request."
    sql: ${TABLE}.pr_reviewers ;;
  }

  # Creator fields
  dimension: pr_creator_login_name {
    group_label: "       Pull Request"
    type: string
    description: "Login name of the pull request creator."
    sql: ${TABLE}.pr_creator_login_name ;;
  }

  dimension: pr_creator_name {
    group_label: "       Pull Request"
    type: string
    description: "Display name of the pull request creator."
    sql: ${TABLE}.pr_creator_name ;;
  }

  # Dates
  dimension_group: pr_created {
    group_label: "       Pull Request"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    description: "Timestamp when the pull request was created."
    sql: ${TABLE}.pr_created_at ;;
  }

  dimension_group: pr_updated {
    group_label: "       Pull Request"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    description: "Timestamp when the pull request was last updated."
    sql: ${TABLE}.pr_updated_at ;;
  }

  dimension_group: pr_closed {
    group_label: "       Pull Request"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    description: "Timestamp when the pull request was closed."
    sql: ${TABLE}.pr_closed_at ;;
  }

  dimension_group: pr_merged {
    group_label: "       Pull Request"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    description: "Timestamp when the pull request was merged."
    sql: ${TABLE}.pr_merged_at ;;
  }

  # Source fields for measures (hidden)
  dimension: pr_number_of_comments {
    group_label: "Review"
    type: number
    hidden: yes
    description: "Number of comments on the pull request. Hidden because measures are provided."
    sql: ${TABLE}.pr_number_of_comments ;;
  }

  dimension: pr_number_of_reviews {
    group_label: "Review"
    type: number
    hidden: yes
    description: "Number of reviews on the pull request. Hidden because measures are provided."
    sql: ${TABLE}.pr_number_of_reviews ;;
  }

  dimension: pr_days_open {
    group_label: "Timing"
    type: number
    hidden: yes
    description: "Days the pull request remained open. Hidden because measures are provided."
    sql: ${TABLE}.pr_days_open ;;
  }

  dimension: pr_hours_to_first_action {
    group_label: "Timing"
    type: number
    hidden: yes
    description: "Hours from creation to first action. Hidden because measures are provided."
    sql: ${TABLE}.pr_hours_to_first_action ;;
  }

  dimension: pr_hours_to_first_review {
    group_label: "Timing"
    type: number
    hidden: yes
    description: "Hours from creation to first review. Hidden because measures are provided."
    sql: ${TABLE}.pr_hours_to_first_review ;;
  }

  dimension: pr_hours_to_merge {
    group_label: "Timing"
    type: number
    hidden: yes
    description: "Hours from creation to merge. Hidden because measures are provided."
    sql: ${TABLE}.pr_hours_to_merge ;;
  }

  # Measures
  measure: count {
    group_label: "       Pull Request Measures"
    type: count
    description: "Count of pull requests."
    drill_fields: [repo_name, pr_number, pr_title, pr_creator_login_name, pr_creator_name, pr_url]
  }

  measure: merged_pull_requests {
    group_label: "       Pull Request Measures"
    type: count
    description: "Count of merged pull requests."
    filters: [pr_is_merged: "yes"]
  }

  measure: open_pull_requests {
    group_label: "       Pull Request Measures"
    type: count
    description: "Count of open pull requests."
    filters: [pr_state: "open"]
  }

  measure: closed_pull_requests {
    group_label: "       Pull Request Measures"
    type: count
    description: "Count of closed pull requests."
    filters: [pr_state: "closed"]
  }

  measure: total_comments {
    group_label: "       Pull Request Measures"
    type: sum
    description: "Total number of pull request comments."
    sql: ${pr_number_of_comments} ;;
    value_format_name: decimal_0
  }

  measure: avg_comments_per_pr {
    group_label: "       Pull Request Measures"
    type: average
    description: "Average comments per pull request."
    sql: ${pr_number_of_comments} ;;
    value_format_name: decimal_1
  }

  measure: total_reviews {
    group_label: "       Pull Request Measures"
    type: sum
    description: "Total number of pull request reviews."
    sql: ${pr_number_of_reviews} ;;
    value_format_name: decimal_0
  }

  measure: avg_reviews_per_pr {
    group_label: "       Pull Request Measures"
    type: average
    description: "Average reviews per pull request."
    sql: ${pr_number_of_reviews} ;;
    value_format_name: decimal_1
  }

  measure: avg_days_open {
    group_label: "       Pull Request Measures"
    type: average
    description: "Average number of days pull requests remain open."
    sql: ${pr_days_open} ;;
    value_format_name: decimal_1
  }

  measure: median_days_open {
    group_label: "       Pull Request Measures"
    type: median
    description: "Median number of days pull requests remain open."
    sql: ${pr_days_open} ;;
    value_format_name: decimal_1
  }

  measure: avg_hours_to_first_action {
    group_label: "       Pull Request Measures"
    type: average
    description: "Average hours from creation to first action."
    sql: ${pr_hours_to_first_action} ;;
    value_format_name: decimal_1
  }

  measure: median_hours_to_first_action {
    group_label: "       Pull Request Measures"
    type: median
    description: "Median hours from creation to first action."
    sql: ${pr_hours_to_first_action} ;;
    value_format_name: decimal_1
  }

  measure: avg_hours_to_first_review {
    group_label: "       Pull Request Measures"
    type: average
    description: "Average hours from creation to first review."
    sql: ${pr_hours_to_first_review} ;;
    value_format_name: decimal_1
  }

  measure: median_hours_to_first_review {
    group_label: "       Pull Request Measures"
    type: median
    description: "Median hours from creation to first review."
    sql: ${pr_hours_to_first_review} ;;
    value_format_name: decimal_1
  }

  measure: avg_hours_to_merge {
    group_label: "       Pull Request Measures"
    type: average
    description: "Average hours from creation to merge."
    sql: ${pr_hours_to_merge} ;;
    value_format_name: decimal_1
  }

  measure: median_hours_to_merge {
    group_label: "       Pull Request Measures"
    type: median
    description: "Median hours from creation to merge."
    sql: ${pr_hours_to_merge} ;;
    value_format_name: decimal_1
  }

  measure: max_hours_to_merge {
    group_label: "       Pull Request Measures"
    type: max
    description: "Maximum hours from creation to merge."
    sql: ${pr_hours_to_merge} ;;
    value_format_name: decimal_0
  }

  measure: min_hours_to_merge {
    group_label: "       Pull Request Measures"
    type: min
    description: "Minimum hours from creation to merge."
    sql: ${pr_hours_to_merge} ;;
    value_format_name: decimal_0
  }
}
