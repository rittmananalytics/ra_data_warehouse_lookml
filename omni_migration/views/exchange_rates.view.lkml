view: exchange_rates {
  sql_table_name: `ra-development.analytics_seed.exchange_rates` ;;

  dimension: currency_code {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.CURRENCY_CODE ;;
  }

  dimension: currency_rate {
    type: number
    hidden: yes
    sql: ${TABLE}.CURRENCY_RATE ;;
  }
}
