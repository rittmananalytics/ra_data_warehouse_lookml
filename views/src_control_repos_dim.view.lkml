
view: src_control_repos_dim {
  sql_table_name: `ra-development.analytics.src_control_repos_dim` ;;


  # Primary key
  dimension: src_control_repo_pk {
    primary_key: yes
    type: string
    hidden: yes
    description: "Surrogate primary key for the repository record."
    sql: ${TABLE}.src_control_repo_pk ;;
  }

  # Hidden technical fields
  dimension: _dbt_source_relation {
    type: string
    hidden: yes
    description: "dbt technical field identifying the upstream source relation."
    sql: ${TABLE}._dbt_source_relation ;;
  }

  # Identifiers (hidden)
  dimension: repo_id {
    type: string
    hidden: yes
    description: "Source system repository identifier."
    sql: ${TABLE}.repo_id ;;
  }

  dimension: repo_owner_fk {
    type: string
    hidden: yes
    description: "Foreign key to the repository owner record."
    sql: ${TABLE}.repo_owner_fk ;;
  }

  dimension: company_fk {
    type: string
    hidden: yes
    description: "Foreign key to the organization (company) record"
    sql: ${TABLE}.company_fk ;;
  }

  dimension: repo_owner_user_id {
    type: string
    hidden: yes
    description: "Source system user identifier for the repository owner."
    sql: ${TABLE}.repo_owner_user_id ;;
  }

  # Naming and descriptive fields
  dimension: repo_name {
    group_label: "           Repository"
    type: string
    description: "Full repository name."
    sql: ${TABLE}.repo_name ;;
  }

  dimension: repo_short_name {
    group_label: "           Repository"
    type: string
    description: "Short repository name, typically excluding any owner or namespace."
    sql: ${TABLE}.repo_short_name ;;
  }

  dimension: repo_description {
    group_label: "           Repository"
    type: string
    description: "Repository description from the source system."
    sql: ${TABLE}.repo_description ;;
  }

  dimension: repo_homepage {
    group_label: "           Repository"
    type: string
    description: "Repository homepage URL if provided."
    sql: ${TABLE}.repo_homepage ;;
  }

  dimension: repo_default_branch {
    group_label: "           Repository"
    type: string
    description: "Default branch name."
    sql: ${TABLE}.repo_default_branch ;;
  }

  # Dates
  dimension_group: repo_created {
    group_label: "Dates"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    description: "Timestamp when the repository was created."
    sql: ${TABLE}.repo_created_at ;;
  }

  # Classification
  dimension: repo_language {
    group_label: "          Classification"
    type: string
    description: "Primary language detected for the repository."
    sql: ${TABLE}.repo_language ;;
  }

  # Flags
  dimension: repo_is_private {
    group_label: "Flags"
    type: yesno
    description: "Yes if the repository is private."
    sql: ${TABLE}.repo_is_private ;;
  }

  dimension: repo_is_archived {
    group_label: "        Flags"
    type: yesno
    description: "Yes if the repository is archived."
    sql: ${TABLE}.repo_is_archived ;;
  }

  dimension: repo_is_fork {
    group_label: "        Flags"
    type: yesno
    description: "Yes if the repository is a fork."
    sql: ${TABLE}.repo_is_fork ;;
  }

  # Popularity source fields (hide because measures cover them)
  dimension: repo_stargazers_count {
    group_label: "Popularity"
    type: number
    hidden: yes
    description: "Number of stargazers. Hidden because a measure is provided."
    sql: ${TABLE}.repo_stargazers_count ;;
  }

  dimension: repo_watchers_count {
    group_label: "Popularity"
    type: number
    hidden: yes
    description: "Number of watchers. Hidden because a measure is provided."
    sql: ${TABLE}.repo_watchers_count ;;
  }

  dimension: repo_forks_count {
    group_label: "Popularity"
    type: number
    hidden: yes
    description: "Number of forks. Hidden because a measure is provided."
    sql: ${TABLE}.repo_forks_count ;;
  }

  # Measures
  measure: count {
    group_label: "          Repository Measures"
    type: count
    description: "Count of repositories."
    drill_fields: [repo_name, repo_short_name]
  }

  measure: total_stargazers {
    group_label: "          Repository Measures"
    type: sum
    description: "Total stargazers across repositories."
    sql: ${repo_stargazers_count} ;;
    value_format_name: decimal_0
  }

  measure: total_watchers {
    group_label: "          Repository Measures"
    type: sum
    description: "Total watchers across repositories."
    sql: ${repo_watchers_count} ;;
    value_format_name: decimal_0
  }

  measure: total_forks {
    group_label: "          Repository Measures"
    type: sum
    description: "Total forks across repositories."
    sql: ${repo_forks_count} ;;
    value_format_name: decimal_0
  }

  measure: avg_stargazers_per_repo {
    group_label: "          Repository Measures"
    type: average
    description: "Average stargazers per repository."
    sql: ${repo_stargazers_count} ;;
    value_format_name: decimal_1
  }

  measure: avg_watchers_per_repo {
    group_label: "          Repository Measures"
    type: average
    description: "Average watchers per repository."
    sql: ${repo_watchers_count} ;;
    value_format_name: decimal_1
  }

  measure: avg_forks_per_repo {
    group_label: "          Repository Measures"
    type: average
    description: "Average forks per repository."
    sql: ${repo_forks_count} ;;
    value_format_name: decimal_1
  }


}
