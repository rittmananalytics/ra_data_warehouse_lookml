# =============================================================================
# DIM_MERCHANT - Financial Merchants
# For transaction and spending analysis
# Source: markr-data-lake.mark_dw_warehouse.dim_merchant
# =============================================================================

view: dim_merchant {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.dim_merchant` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: merchant_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.merchant_pk ;;
    hidden: yes
    description: "Primary key (hash of merchant name)"
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

  dimension: merchant_category {
    type: string
    sql: ${TABLE}.merchant_category ;;
    label: "Category"
    description: "Spending category"
  }

  # =============================================================================
  # MERCHANT FLAGS
  # =============================================================================

  dimension: is_subscription {
    type: yesno
    sql: ${TABLE}.is_subscription ;;
    label: "Is Subscription"
    description: "TRUE if recurring subscription"
  }

  dimension: is_amazon {
    type: yesno
    sql: ${TABLE}.is_amazon ;;
    label: "Is Amazon"
    description: "TRUE if Amazon purchase"
  }

  dimension: is_uber {
    type: yesno
    sql: ${TABLE}.is_uber ;;
    label: "Is Uber"
    description: "TRUE if Uber/transport"
  }

  dimension: is_grocery {
    type: yesno
    sql: ${TABLE}.is_grocery ;;
    label: "Is Grocery"
    description: "TRUE if grocery store"
  }

  dimension: is_restaurant {
    type: yesno
    sql: ${TABLE}.is_restaurant ;;
    label: "Is Restaurant"
    description: "TRUE if restaurant/food"
  }

  dimension: is_entertainment {
    type: yesno
    sql: ${TABLE}.is_entertainment ;;
    label: "Is Entertainment"
    description: "TRUE if entertainment"
  }

  dimension: is_utility {
    type: yesno
    sql: ${TABLE}.is_utility ;;
    label: "Is Utility"
    description: "TRUE if utility/bill"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Merchant Count"
    drill_fields: [merchant_name, merchant_category]
  }
}
