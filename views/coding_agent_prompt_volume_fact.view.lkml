view: coding_agent_prompt_volume_fact {
  sql_table_name: `ra-development.analytics.coding_agent_prompt_volume_fact` ;;

  dimension: user_email {
    label: "User Email"
    group_label: "Identity"
    type: string
    sql: ${TABLE}.user_email ;;
  }

  dimension: consultant_name {
    label: "Consultant"
    group_label: "Identity"
    type: string
    sql: ${TABLE}.consultant_name ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${TABLE}.user_email, '|', CAST(${TABLE}.event_date AS STRING)) ;;
  }

  # Cast DATE → TIMESTAMP so Looker's date_filter emits TIMESTAMP >= TIMESTAMP,
  # which BigQuery accepts. Without the cast BigQuery rejects DATE >= TIMESTAMP.
  dimension_group: event {
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: CAST(${TABLE}.event_date AS TIMESTAMP) ;;
    label: "Event"
  }

  dimension: week_commencing {
    label: "Week Commencing"
    type: date
    sql: ${TABLE}.week_commencing ;;
  }

  dimension: prompt_count {
    label: "Prompts"
    type: number
    sql: ${TABLE}.prompt_count ;;
  }

  dimension: slash_command_count {
    label: "Slash Commands"
    type: number
    sql: ${TABLE}.slash_command_count ;;
  }

  dimension: free_form_prompt_count {
    label: "Free-Form Prompts"
    type: number
    sql: ${TABLE}.free_form_prompt_count ;;
  }

  dimension: agentic_framework_slash_command_count {
    label: "Wire Slash Commands"
    type: number
    sql: ${TABLE}.agentic_framework_slash_command_count ;;
  }

  dimension: avg_prompt_word_count {
    label: "Avg Word Count"
    type: number
    sql: ${TABLE}.avg_prompt_word_count ;;
    value_format_name: decimal_1
  }

  dimension: median_prompt_word_count {
    label: "Median Word Count"
    type: number
    sql: ${TABLE}.median_prompt_word_count ;;
  }

  dimension: p95_prompt_word_count {
    label: "P95 Word Count"
    type: number
    sql: ${TABLE}.p95_prompt_word_count ;;
  }

  measure: total_prompts {
    type: sum
    sql: ${prompt_count} ;;
    label: "Total Prompts"
  }

  measure: total_slash_commands {
    type: sum
    sql: ${slash_command_count} ;;
    label: "Total Slash Commands"
  }

  measure: total_free_form {
    type: sum
    sql: ${free_form_prompt_count} ;;
    label: "Total Free-Form Prompts"
  }

  measure: avg_daily_prompts {
    type: average
    sql: ${prompt_count} ;;
    label: "Avg Daily Prompts"
    value_format_name: decimal_1
  }

  measure: count {
    type: count
    label: "User-Day Records"
  }
}
