# engagement_context_attribution.view.lkml
# Exposes the wh_engagement_context_attribution dbt model (alias: engagement_context_attribution)
# Table: ra-development.analytics.engagement_context_attribution
# Partitioned by item_date (MONTH), clustered by company_name + engagement_code
#
# One row per context item per engagement it was attributed to. Meetings, Slack messages,
# Confluence pages and Jira issues carry no engagement key of their own, so this model
# assigns one and records how. Used for drill-through from the client tiles, and for
# auditing attribution quality.

view: engagement_context_attribution {
  sql_table_name: `ra-development.analytics.engagement_context_attribution` ;;

  dimension: engagement_context_pk {
    primary_key: yes
    hidden:      yes
    type:        string
    sql:         ${TABLE}.engagement_context_pk ;;
  }

  dimension: engagement_fk { hidden: yes type: string sql: ${TABLE}.engagement_fk ;; }

  dimension: engagement_code {
    label:       "Engagement Code"
    description: "Blank where the item could not be tied to one engagement."
    type:        string
    sql:         ${TABLE}.engagement_code ;;
  }

  dimension: company_name {
    label:       "Company Name"
    description: "The engagement's client."
    type:        string
    sql:         ${TABLE}.company_name ;;
  }

  dimension: item_company_name {
    label:       "Filed Against Company"
    description: "The company the item is filed against, which is not always the engagement's client. The Project Quattro Confluence space is held against a company of that name."
    type:        string
    sql:         ${TABLE}.item_company_name ;;
  }

  dimension: engagement_name {
    label: "Engagement Name"
    type:  string
    sql:   ${TABLE}.engagement_name ;;
  }

  dimension: source_system {
    label:       "Source"
    description: "fathom for meetings, slack, confluence or jira."
    type:        string
    sql:         ${TABLE}.source_system ;;
  }

  dimension_group: item {
    label:      "Item"
    type:       time
    timeframes: [date, week, month, quarter, year]
    datatype:   date
    convert_tz: no
    sql:        ${TABLE}.item_date ;;
  }

  dimension: item_title {
    label: "Title"
    type:  string
    sql:   ${TABLE}.item_title ;;
  }

  dimension: item_source_name {
    label:       "Channel Or Space"
    description: "Slack channel, Confluence space, or Jira project the item came from."
    type:        string
    sql:         ${TABLE}.item_source_name ;;
  }

  dimension: item_text {
    label:       "Text"
    description: "Meeting summary and contributions, message text, page summary, or task description. Capped at 2,000 characters."
    type:        string
    sql:         ${TABLE}.item_text ;;
  }

  dimension: attribution_level {
    label:       "Attribution Level"
    description: "engagement where the item belongs to one engagement, client where it is shared across the client's live engagements."
    type:        string
    sql:         ${TABLE}.attribution_level ;;
  }

  dimension: attribution_method {
    label:       "Attribution Method"
    description: "exact_key from a seed row naming the channel, space or Jira project. text_match from a word or phrase. sole_live_engagement where only one engagement was live. client_meeting_fanout for a generic client meeting counted against every live engagement. unattributed where none applied."
    type:        string
    sql:         ${TABLE}.attribution_method ;;
  }

  dimension: attribution_evidence {
    label:       "Attribution Evidence"
    description: "Which rule matched, and on what."
    type:        string
    sql:         ${TABLE}.attribution_evidence ;;
  }

  dimension: avg_sentiment_score {
    label:       "Meeting Sentiment"
    description: "Meetings only, from -1 to 1."
    type:        number
    value_format_name: decimal_2
    sql:         ${TABLE}.avg_sentiment_score ;;
  }

  dimension: avg_engagement_level {
    label: "Meeting Engagement Level"
    type:  number
    value_format_name: decimal_2
    sql:   ${TABLE}.avg_engagement_level ;;
  }

  measure: item_count {
    label: "Context Items"
    type:  count_distinct
    sql:   ${TABLE}.item_id ;;
    drill_fields: [item_date, source_system, item_title, attribution_method, attribution_evidence]
  }

  measure: engagement_attributed_items {
    label:   "Engagement Attributed"
    type:    count_distinct
    sql:     ${TABLE}.item_id ;;
    filters: [attribution_level: "engagement"]
  }

  measure: client_level_items {
    label:   "Client Level"
    type:    count_distinct
    sql:     ${TABLE}.item_id ;;
    filters: [attribution_level: "client"]
  }

  measure: average_sentiment {
    label: "Average Sentiment"
    type:  average
    value_format_name: decimal_2
    sql:   ${TABLE}.avg_sentiment_score ;;
  }
}
