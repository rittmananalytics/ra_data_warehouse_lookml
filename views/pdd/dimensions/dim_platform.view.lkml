# =============================================================================
# DIM_PLATFORM - Communication Platforms
# For platform-level communication analysis
# Source: markr-data-lake.mark_dw_warehouse.dim_platform
# =============================================================================

view: dim_platform {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.dim_platform` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: platform_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.platform_pk ;;
    hidden: yes
    description: "Primary key"
  }

  # =============================================================================
  # PLATFORM DIMENSIONS
  # =============================================================================

  dimension: platform_name {
    type: string
    sql: ${TABLE}.platform_name ;;
    label: "Platform"
    description: "Platform name: iMessage, Slack, WhatsApp, Email, etc."
  }

  dimension: platform_type {
    type: string
    sql: ${TABLE}.platform_type ;;
    label: "Platform Type"
    description: "Platform type: Messaging, Email, Social"
  }

  # =============================================================================
  # PLATFORM FLAGS
  # =============================================================================

  dimension: is_work_platform {
    type: yesno
    sql: ${TABLE}.is_work_platform ;;
    label: "Is Work Platform"
    description: "TRUE if primarily work-related"
  }

  dimension: is_personal_platform {
    type: yesno
    sql: ${TABLE}.is_personal_platform ;;
    label: "Is Personal Platform"
    description: "TRUE if primarily personal"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Platform Count"
    drill_fields: [platform_name, platform_type]
  }
}
