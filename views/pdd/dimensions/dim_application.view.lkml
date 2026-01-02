# =============================================================================
# DIM_APPLICATION - Productivity Applications
# For RescueTime application/website tracking
# Source: ra-development.pdd_analytics.application_dim
# =============================================================================

view: dim_application {
  sql_table_name: `ra-development.pdd_analytics.application_dim` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: application_key {
    primary_key: yes
    type: string
    sql: ${TABLE}.application_key ;;
    hidden: yes
    description: "Primary key (hash of application name)"
  }

  # =============================================================================
  # APPLICATION DIMENSIONS
  # =============================================================================

  dimension: application_name {
    type: string
    sql: ${TABLE}.application_name ;;
    label: "Application"
    description: "Application or website name"
  }

  dimension: productivity_category {
    type: string
    sql: ${TABLE}.productivity_category ;;
    label: "Productivity Category"
    description: "RescueTime productivity category"
  }

  dimension: productivity_score {
    type: number
    sql: ${TABLE}.productivity_score ;;
    label: "Productivity Score"
    value_format_name: decimal_2
    description: "Productivity score (0-1)"
  }

  dimension: productivity_level {
    type: string
    sql: ${TABLE}.productivity_level ;;
    label: "Productivity Level"
    description: "High, Medium, Low"
  }

  # =============================================================================
  # APPLICATION FLAGS
  # =============================================================================

  dimension: is_development_app {
    type: yesno
    sql: ${TABLE}.is_development_app ;;
    label: "Is Development App"
    description: "TRUE if development/coding tool"
  }

  dimension: is_communication_app {
    type: yesno
    sql: ${TABLE}.is_communication_app ;;
    label: "Is Communication App"
    description: "TRUE if email/messaging/video app"
  }

  dimension: is_writing_app {
    type: yesno
    sql: ${TABLE}.is_writing_app ;;
    label: "Is Writing App"
    description: "TRUE if writing/documentation app"
  }

  dimension: is_entertainment_app {
    type: yesno
    sql: ${TABLE}.is_entertainment_app ;;
    label: "Is Entertainment App"
    description: "TRUE if entertainment app"
  }

  dimension: is_social_media_app {
    type: yesno
    sql: ${TABLE}.is_social_media_app ;;
    label: "Is Social Media App"
    description: "TRUE if social media app"
  }

  dimension: is_productive {
    type: yesno
    sql: ${TABLE}.is_productive ;;
    label: "Is Productive"
    description: "TRUE if productivity_score >= 0.7"
  }

  dimension: is_distracting {
    type: yesno
    sql: ${TABLE}.is_distracting ;;
    label: "Is Distracting"
    description: "TRUE if productivity_score < 0.3"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Application Count"
    drill_fields: [application_name, productivity_category, productivity_level]
  }

  measure: productive_app_count {
    type: count
    label: "Productive App Count"
    filters: [is_productive: "yes"]
  }

  measure: distracting_app_count {
    type: count
    label: "Distracting App Count"
    filters: [is_distracting: "yes"]
  }
}
