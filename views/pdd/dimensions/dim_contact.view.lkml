# =============================================================================
# DIM_CONTACT - Communication Contacts
# For email and messaging analysis
# Source: ra-development.pdd_analytics.contact_dim
# =============================================================================

view: dim_contact {
  sql_table_name: `ra-development.pdd_analytics.contact_dim` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: contact_key {
    primary_key: yes
    type: string
    sql: ${TABLE}.contact_key ;;
    hidden: yes
    description: "Primary key (contact ID)"
  }

  # =============================================================================
  # CONTACT DIMENSIONS
  # =============================================================================

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
    label: "First Name"
    description: "Contact first name"
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
    label: "Last Name"
    description: "Contact last name"
  }

  dimension: full_name {
    type: string
    sql: ${TABLE}.full_name ;;
    label: "Full Name"
    description: "Contact full name"
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
    label: "Email"
    description: "Email address"
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
    label: "Phone"
    description: "Phone number"
  }

  dimension: company_name {
    type: string
    sql: ${TABLE}.company_name ;;
    label: "Company"
    description: "Company name"
  }

  # =============================================================================
  # CONTACT FLAGS
  # =============================================================================

  dimension: is_multi_source {
    type: yesno
    sql: ${TABLE}.is_multi_source ;;
    label: "Is Multi-Source"
    description: "TRUE if contact appears in multiple source systems"
  }

  dimension: was_merged {
    type: yesno
    sql: ${TABLE}.was_merged ;;
    label: "Was Merged"
    description: "TRUE if contact was merged from duplicates"
  }

  dimension: has_email {
    type: yesno
    sql: ${TABLE}.has_email ;;
    label: "Has Email"
    description: "TRUE if email address exists"
  }

  dimension: has_phone {
    type: yesno
    sql: ${TABLE}.has_phone ;;
    label: "Has Phone"
    description: "TRUE if phone number exists"
  }

  # =============================================================================
  # METADATA
  # =============================================================================

  dimension_group: first_seen {
    type: time
    timeframes: [raw, date, week, month, year]
    datatype: timestamp
    sql: ${TABLE}.first_seen_at ;;
    label: "First Seen"
    description: "When contact was first seen"
  }

  dimension_group: last_seen {
    type: time
    timeframes: [raw, date, week, month, year]
    datatype: timestamp
    sql: ${TABLE}.last_seen_at ;;
    label: "Last Seen"
    description: "When contact was last seen"
  }

  dimension: source_count {
    type: number
    sql: ${TABLE}.source_count ;;
    label: "Source Count"
    description: "Number of source systems"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Contact Count"
    drill_fields: [full_name, email, company_name]
  }
}
