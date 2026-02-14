view: src_control_commits_fact {
  sql_table_name: `ra-development.analytics.src_control_commits_fact` ;;


  # Primary key
  dimension: src_control_commit_pk {
    primary_key: yes
    type: string
    hidden: yes
    description: "Surrogate primary key for the commit record."
    sql: ${TABLE}.src_control_commit_pk ;;
  }

  # Hidden technical fields
  dimension: _dbt_source_relation {
    type: string
    hidden: yes
    description: "dbt technical field identifying the upstream source relation."
    sql: ${TABLE}._dbt_source_relation ;;
  }

  # Hidden identifiers and foreign keys
  dimension: commit_id {
    type: string
    hidden: yes
    description: "Source system commit identifier or SHA."
    sql: ${TABLE}.commit_id ;;
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
    description: "Foreign key to contact, if commits are associated to CRM contacts."
    sql: ${TABLE}.contact_fk ;;
  }

  dimension: commit_author_user_id {
    type: string
    hidden: yes
    description: "Source system user identifier for the commit author."
    sql: ${TABLE}.commit_author_user_id ;;
  }

  # Repository context
  dimension: repo_name {
    group_label: "Repository"
    hidden: yes

    type: string
    description: "Repository name associated with the commit."
    sql: ${TABLE}.repo_name ;;
  }

  # Commit details
  dimension: commit_message {
    group_label: "Commit"
    type: string
    description: "Commit message text."
    sql: ${TABLE}.commit_message ;;
  }

  # Author details
  dimension: commit_author_name {
    group_label: "Author"
    type: string
    description: "Name of the commit author."
    sql: ${TABLE}.commit_author_name ;;
  }

  dimension: commit_author_email {
    group_label: "Author"
    type: string
    description: "Email address of the commit author."
    sql: ${TABLE}.commit_author_email ;;
  }

  # Committer details
  dimension: commit_committer_name {
    group_label: "Committer"
    type: string
    description: "Name of the committer (may differ from author)."
    sql: ${TABLE}.commit_committer_name ;;
  }

  dimension: commit_committer_email {
    group_label: "Committer"
    type: string
    description: "Email address of the committer."
    sql: ${TABLE}.commit_committer_email ;;
  }

  # Dates
  dimension_group: commit_author {
    group_label: "Dates"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    description: "Timestamp when the commit was authored."
    sql: ${TABLE}.commit_author_date ;;
  }

  dimension_group: commit_committer {
    group_label: "Dates"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    description: "Timestamp when the commit was committed."
    sql: ${TABLE}.commit_committer_date ;;
  }

  # Measures
  measure: count {
    group_label: "Measures"
    type: count
    description: "Count of commits."
    drill_fields: [repo_name, commit_author_name, commit_committer_name, commit_message]
  }

  measure: commits_by_author {
    group_label: "Measures"
    type: count
    description: "Count of commits by author."
    drill_fields: [commit_author_name, repo_name]
  }

  measure: distinct_authors {
    group_label: "Measures"
    type: count_distinct
    description: "Number of distinct commit authors."
    sql: ${commit_author_name} ;;
    value_format_name: decimal_0
  }

  measure: distinct_committers {
    group_label: "Measures"
    type: count_distinct
    description: "Number of distinct committers."
    sql: ${commit_committer_name} ;;
    value_format_name: decimal_0
  }

  measure: commits_with_messages {
    group_label: "Measures"
    type: count
    description: "Count of commits that include a non-empty commit message."
    filters: [commit_message: "-NULL"]
  }
}
