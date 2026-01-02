# =============================================================================
# DIM_SPENDING_CATEGORY - Spending Categories
# For category-level spending analysis
# Source: ra-development.pdd_analytics.spending_category_dim
# =============================================================================

view: dim_spending_category {
  sql_table_name: `ra-development.pdd_analytics.spending_category_dim` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: category_key {
    primary_key: yes
    type: string
    sql: ${TABLE}.category_key ;;
    hidden: yes
    description: "Primary key (hash of category name)"
  }

  # =============================================================================
  # CATEGORY DIMENSIONS
  # =============================================================================

  dimension: category_name {
    type: string
    sql: ${TABLE}.category_name ;;
    label: "Category"
    description: "Category name"
  }

  dimension: category_group {
    type: string
    sql: ${TABLE}.category_group ;;
    label: "Category Group"
    description: "High-level category group"
  }

  # =============================================================================
  # CATEGORY FLAGS
  # =============================================================================

  dimension: is_essential {
    type: yesno
    sql: ${TABLE}.is_essential ;;
    label: "Is Essential"
    description: "TRUE if essential spending"
  }

  dimension: is_discretionary {
    type: yesno
    sql: ${TABLE}.is_discretionary ;;
    label: "Is Discretionary"
    description: "TRUE if discretionary spending"
  }

  dimension: is_transfer {
    type: yesno
    sql: ${TABLE}.is_transfer ;;
    label: "Is Transfer"
    description: "TRUE if transfer between accounts"
  }

  dimension: is_food_drink {
    type: yesno
    sql: ${TABLE}.is_food_drink ;;
    label: "Is Food & Drink"
    description: "TRUE if Food & Drink category"
  }

  dimension: is_transport {
    type: yesno
    sql: ${TABLE}.is_transport ;;
    label: "Is Transport"
    description: "TRUE if Transport category"
  }

  dimension: is_shopping {
    type: yesno
    sql: ${TABLE}.is_shopping ;;
    label: "Is Shopping"
    description: "TRUE if Shopping category"
  }

  dimension: is_entertainment {
    type: yesno
    sql: ${TABLE}.is_entertainment ;;
    label: "Is Entertainment"
    description: "TRUE if Entertainment category"
  }

  dimension: is_bills {
    type: yesno
    sql: ${TABLE}.is_bills ;;
    label: "Is Bills"
    description: "TRUE if Bills & Utilities category"
  }

  dimension: is_housing {
    type: yesno
    sql: ${TABLE}.is_housing ;;
    label: "Is Housing"
    description: "TRUE if Housing category"
  }

  dimension: is_health {
    type: yesno
    sql: ${TABLE}.is_health ;;
    label: "Is Health"
    description: "TRUE if Health & Fitness category"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Category Count"
    drill_fields: [category_name, category_group]
  }
}
