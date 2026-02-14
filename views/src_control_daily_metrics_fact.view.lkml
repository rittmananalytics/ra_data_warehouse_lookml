view: src_control_daily_metrics_fact {
  sql_table_name: `ra-development.analytics.src_control_daily_metrics_fact` ;;


  # Primary key
  dimension: src_control_daily_metric_pk {
    primary_key: yes
    type: string
    hidden: yes
    description: "Surrogate primary key for the daily metrics record."
    sql: ${TABLE}.src_control_daily_metric_pk ;;
  }

  # Hidden foreign keys and technical fields
  dimension: src_control_repo_fk {
    type: string
    hidden: yes
    description: "Foreign key to the repository dimension."
    sql: ${TABLE}.src_control_repo_fk ;;
  }

  dimension: source_relation {
    type: string
    hidden: yes
    description: "Technical field identifying the upstream source relation."
    sql: ${TABLE}.source_relation ;;
  }

  # Repository context
  dimension: repository {
    group_label: "Repository"
    type: string
    description: "Repository name associated with the daily metrics."
    hidden: yes
    sql: ${TABLE}.repository ;;
  }

  # Dates
  dimension_group: day {
    group_label: "Dates"
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    description: "Day the activity metrics were recorded."
    sql: ${TABLE}.day ;;
  }

  # Source fields for measures (hidden)
  dimension: number_issues_opened {
    group_label: "Issues"
    type: number
    hidden: yes
    description: "Number of issues opened on this day. Hidden because measures are provided."
    sql: ${TABLE}.number_issues_opened ;;
  }

  dimension: number_issues_closed {
    group_label: "Issues"
    type: number
    hidden: yes
    description: "Number of issues closed on this day. Hidden because measures are provided."
    sql: ${TABLE}.number_issues_closed ;;
  }

  dimension: number_prs_opened {
    group_label: "Pull Requests"
    type: number
    hidden: yes
    description: "Number of pull requests opened on this day. Hidden because measures are provided."
    sql: ${TABLE}.number_prs_opened ;;
  }

  dimension: number_prs_merged {
    group_label: "Pull Requests"
    type: number
    hidden: yes
    description: "Number of pull requests merged on this day. Hidden because measures are provided."
    sql: ${TABLE}.number_prs_merged ;;
  }

  dimension: number_prs_closed_without_merge {
    group_label: "Pull Requests"
    type: number
    hidden: yes
    description: "Number of pull requests closed without merge on this day. Hidden because measures are provided."
    sql: ${TABLE}.number_prs_closed_without_merge ;;
  }

  dimension: sum_days_issue_open {
    group_label: "Timing"
    type: number
    hidden: yes
    description: "Total days issues remained open, summed across issues closed. Hidden because measures are provided."
    sql: ${TABLE}.sum_days_issue_open ;;
  }

  dimension: sum_days_pr_open {
    group_label: "Timing"
    type: number
    hidden: yes
    description: "Total days pull requests remained open, summed across PRs closed. Hidden because measures are provided."
    sql: ${TABLE}.sum_days_pr_open ;;
  }

  dimension: longest_days_issue_open {
    group_label: "Timing"
    type: number
    hidden: yes
    description: "Longest number of days an issue remained open for issues closed that day. Hidden because measures are provided."
    sql: ${TABLE}.longest_days_issue_open ;;
  }

  dimension: longest_days_pr_open {
    group_label: "Timing"
    type: number
    hidden: yes
    description: "Longest number of days a pull request remained open for PRs closed that day. Hidden because measures are provided."
    sql: ${TABLE}.longest_days_pr_open ;;
  }

  # Measures
  measure: count {
    group_label: "Measures"
    type: count
    description: "Count of daily metric rows."
  }

  measure: total_issues_opened {
    group_label: "Measures"
    type: sum
    description: "Total issues opened."
    sql: ${number_issues_opened} ;;
    value_format_name: decimal_0
  }

  measure: total_issues_closed {
    group_label: "Measures"
    type: sum
    description: "Total issues closed."
    sql: ${number_issues_closed} ;;
    value_format_name: decimal_0
  }

  measure: total_prs_opened {
    group_label: "Measures"
    type: sum
    description: "Total pull requests opened."
    sql: ${number_prs_opened} ;;
    value_format_name: decimal_0
  }

  measure: total_prs_merged {
    group_label: "Measures"
    type: sum
    description: "Total pull requests merged."
    sql: ${number_prs_merged} ;;
    value_format_name: decimal_0
  }

  measure: total_prs_closed_without_merge {
    group_label: "Measures"
    type: sum
    description: "Total pull requests closed without merge."
    sql: ${number_prs_closed_without_merge} ;;
    value_format_name: decimal_0
  }

  measure: avg_days_issue_open {
    group_label: "Measures"
    type: number
    description: "Average days issues stayed open, calculated from summed days divided by issues closed."
    sql: SAFE_DIVIDE(${sum_days_issue_open}, NULLIF(${number_issues_closed}, 0)) ;;
    value_format_name: decimal_1
  }

  measure: avg_days_pr_open {
    group_label: "Measures"
    type: number
    description: "Average days pull requests stayed open, calculated from summed days divided by PRs closed."
    sql: SAFE_DIVIDE(${sum_days_pr_open}, NULLIF(${number_prs_merged} + ${number_prs_closed_without_merge}, 0)) ;;
    value_format_name: decimal_1
  }

  measure: max_days_issue_open {
    group_label: "Measures"
    type: max
    description: "Maximum days an issue stayed open on a given day."
    sql: ${longest_days_issue_open} ;;
    value_format_name: decimal_0
  }

  measure: max_days_pr_open {
    group_label: "Measures"
    type: max
    description: "Maximum days a pull request stayed open on a given day."
    sql: ${longest_days_pr_open} ;;
    value_format_name: decimal_0
  }
}
