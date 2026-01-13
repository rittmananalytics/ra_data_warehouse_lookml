view: bank_account_details {
  derived_table: {
    sql: with bank_accounts as (SELECT
          bank_transactions_fact.bank_account_id  AS bank_account_id
      FROM `ra-development.analytics.chart_of_accounts_dim`
           AS chart_of_accounts_dim
      LEFT JOIN `ra-development.analytics.bank_transactions_fact`
           AS bank_transactions_fact ON chart_of_accounts_dim.account_id = bank_transactions_fact.account_id
      GROUP BY
          1)
      select b.bank_account_id, a.account_name, a.account_currency_code, a.account_status
      from   bank_accounts b
      join  analytics.chart_of_accounts_dim a
      on     b.bank_account_id = a.account_id
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: bank_account_id {
    hidden: yes
    type: string
    sql: ${TABLE}.bank_account_id ;;
  }

  dimension: account_name {
    label: "Bank Account Name"
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: account_currency_code {
    label: "Bank Account Currency Code"

    type: string
    sql: ${TABLE}.account_currency_code ;;
  }

  dimension: account_status {
    label: "Bank Account Status"

    type: string
    sql: ${TABLE}.account_status ;;
  }

  set: detail {
    fields: [bank_account_id, account_name, account_currency_code, account_status]
  }
}
