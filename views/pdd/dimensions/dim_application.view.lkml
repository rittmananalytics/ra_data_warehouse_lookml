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

  dimension: application_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.application_pk ;;
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

  dimension: application_category {
    type: string
    sql: ${TABLE}.application_category ;;
    label: "Category"
    description: "RescueTime category"
  }

  dimension: productivity_score {
    type: number
    sql: ${TABLE}.productivity_score ;;
    label: "Productivity Score"
    description: "Productivity score (-2 to +2)"
  }

  dimension: productivity_label {
    type: string
    sql: ${TABLE}.productivity_label ;;
    label: "Productivity Level"
    description: "Very Distracting, Distracting, Neutral, Productive, Very Productive"
  }

  # =============================================================================
  # APPLICATION FLAGS
  # =============================================================================

  dimension: is_productive {
    type: yesno
    sql: ${TABLE}.is_productive ;;
    label: "Is Productive"
    description: "TRUE if productivity_score > 0"
  }

  dimension: is_distracting {
    type: yesno
    sql: ${TABLE}.is_distracting ;;
    label: "Is Distracting"
    description: "TRUE if productivity_score < 0"
  }

  dimension: is_communication {
    type: yesno
    sql: ${TABLE}.is_communication ;;
    label: "Is Communication App"
    description: "TRUE if email/messaging/video app"
  }

  dimension: is_development {
    type: yesno
    sql: ${TABLE}.is_development ;;
    label: "Is Development Tool"
    description: "TRUE if coding/development tool"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Application Count"
    drill_fields: [application_name, application_category, productivity_label]
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
