# =============================================================================
# DIM_SPENDING_CATEGORY - Spending Categories
# For category-level spending analysis
# Source: markr-data-lake.mark_dw_warehouse.dim_spending_category
# =============================================================================

view: dim_spending_category {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.dim_spending_category` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: category_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.category_pk ;;
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

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Category Count"
    drill_fields: [category_name, category_group]
  }
}
