# =============================================================================
# DIM_BANK_ACCOUNT - Bank Accounts
# For multi-account financial analysis
# Source: markr-data-lake.mark_dw_warehouse.dim_bank_account
# =============================================================================

view: dim_bank_account {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.dim_bank_account` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: account_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.account_pk ;;
    hidden: yes
    description: "Primary key"
  }

  # =============================================================================
  # ACCOUNT DIMENSIONS
  # =============================================================================

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
    label: "Account"
    description: "Account name: Monzo, First Direct"
  }

  dimension: account_type {
    type: string
    sql: ${TABLE}.account_type ;;
    label: "Account Type"
    description: "Current, Savings, Credit"
  }

  # =============================================================================
  # ACCOUNT FLAGS
  # =============================================================================

  dimension: is_primary_account {
    type: yesno
    sql: ${TABLE}.is_primary_account ;;
    label: "Is Primary Account"
    description: "TRUE if primary spending account"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Account Count"
    drill_fields: [account_name, account_type]
  }
}
