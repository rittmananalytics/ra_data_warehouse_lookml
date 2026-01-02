# =============================================================================
# DIM_MERCHANT - Financial Merchants
# For transaction and spending analysis
# Source: ra-development.pdd_analytics.merchant_dim
# =============================================================================

view: dim_merchant {
  sql_table_name: `ra-development.pdd_analytics.merchant_dim` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: merchant_key {
    primary_key: yes
    type: string
    sql: ${TABLE}.merchant_key ;;
    hidden: yes
    description: "Primary key (merchant ID)"
  }

  # =============================================================================
  # MERCHANT DIMENSIONS
  # =============================================================================

  dimension: merchant_name {
    type: string
    sql: ${TABLE}.merchant_name ;;
    label: "Merchant"
    description: "Merchant or payee name"
  }

  dimension: normalized_name {
    type: string
    sql: ${TABLE}.normalized_name ;;
    label: "Normalized Name"
    description: "Cleaned/normalized merchant name"
  }

  dimension: merchant_category {
    type: string
    sql: ${TABLE}.merchant_category ;;
    label: "Category"
    description: "Spending category"
  }

  dimension: merchant_city {
    type: string
    sql: ${TABLE}.merchant_city ;;
    label: "City"
    description: "Merchant city"
  }

  dimension: merchant_country {
    type: string
    sql: ${TABLE}.merchant_country ;;
    label: "Country"
    description: "Merchant country"
  }

  # =============================================================================
  # MERCHANT FLAGS
  # =============================================================================

  dimension: is_multi_source {
    type: yesno
    sql: ${TABLE}.is_multi_source ;;
    label: "Is Multi-Source"
    description: "TRUE if merchant appears in multiple source systems"
  }

  dimension: was_merged {
    type: yesno
    sql: ${TABLE}.was_merged ;;
    label: "Was Merged"
    description: "TRUE if merchant was merged from duplicates"
  }

  dimension: is_uk_merchant {
    type: yesno
    sql: ${TABLE}.is_uk_merchant ;;
    label: "Is UK Merchant"
    description: "TRUE if UK-based merchant"
  }

  # =============================================================================
  # METADATA
  # =============================================================================

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
    label: "Merchant Count"
    drill_fields: [merchant_name, merchant_category, merchant_city]
  }
}
