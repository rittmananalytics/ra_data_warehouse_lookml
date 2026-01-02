# =============================================================================
# DIM_CONTACT - Communication Contacts
# For email and messaging analysis
# Source: markr-data-lake.mark_dw_warehouse.dim_contact
# =============================================================================

view: dim_contact {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.dim_contact` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: contact_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.contact_pk ;;
    hidden: yes
    description: "Primary key (hash of email/identifier)"
  }

  # =============================================================================
  # CONTACT DIMENSIONS
  # =============================================================================

  dimension: contact_name {
    type: string
    sql: ${TABLE}.contact_name ;;
    label: "Contact Name"
    description: "Contact display name"
  }

  dimension: contact_email {
    type: string
    sql: ${TABLE}.contact_email ;;
    label: "Email"
    description: "Email address"
  }

  dimension: contact_identifier {
    type: string
    sql: ${TABLE}.contact_identifier ;;
    label: "Identifier"
    description: "Identifier (phone, username)"
  }

  dimension: primary_platform {
    type: string
    sql: ${TABLE}.primary_platform ;;
    label: "Primary Platform"
    description: "Primary communication platform"
  }

  # =============================================================================
  # CONTACT FLAGS
  # =============================================================================

  dimension: is_work_contact {
    type: yesno
    sql: ${TABLE}.is_work_contact ;;
    label: "Is Work Contact"
    description: "TRUE if work-related contact"
  }

  dimension: is_personal_contact {
    type: yesno
    sql: ${TABLE}.is_personal_contact ;;
    label: "Is Personal Contact"
    description: "TRUE if personal contact"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Contact Count"
    drill_fields: [contact_name, contact_email, primary_platform]
  }
}
