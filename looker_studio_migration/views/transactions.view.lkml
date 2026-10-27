view: transactions {
  sql_table_name: `bigquery-public-data.goog_blockchain_ethereum_mainnet_us.transactions` ;;

  dimension: block_hash {
    type: string
    label: "block_hash"
    sql: ${TABLE}.block_hash ;;
  }

  dimension: block_number {
    type: number
    label: "block_number"
    sql: ${TABLE}.block_number ;;
  }

  dimension: block_timestamp {
    type: string
    label: "block_timestamp"
    sql: ${TABLE}.block_timestamp ;;
  }

  dimension: chain_id {
    type: number
    label: "chain_id"
    sql: ${TABLE}.chain_id ;;
  }

  dimension: from_address {
    type: string
    label: "from_address"
    sql: ${TABLE}.from_address ;;
  }

  dimension: gas {
    type: number
    label: "gas"
    sql: ${TABLE}.gas ;;
  }

  dimension: gas_price {
    type: number
    label: "gas_price"
    sql: ${TABLE}.gas_price ;;
  }

  dimension: input {
    type: string
    label: "input"
    sql: ${TABLE}.input ;;
  }

  dimension: max_fee_per_gas {
    type: number
    label: "max_fee_per_gas"
    sql: ${TABLE}.max_fee_per_gas ;;
  }

  dimension: max_priority_fee_per_gas {
    type: number
    label: "max_priority_fee_per_gas"
    sql: ${TABLE}.max_priority_fee_per_gas ;;
  }

  dimension: nonce {
    type: number
    label: "nonce"
    sql: ${TABLE}.nonce ;;
  }

  dimension: r {
    type: string
    label: "r"
    sql: ${TABLE}.r ;;
  }

  dimension: s {
    type: string
    label: "s"
    sql: ${TABLE}.s ;;
  }

  dimension: to_address {
    type: string
    label: "to_address"
    sql: ${TABLE}.to_address ;;
  }

  dimension: transaction_hash {
    type: string
    label: "transaction_hash"
    sql: ${TABLE}.transaction_hash ;;
  }

  dimension: transaction_index {
    type: number
    label: "transaction_index"
    sql: ${TABLE}.transaction_index ;;
  }

  dimension: transaction_type {
    type: number
    label: "transaction_type"
    sql: ${TABLE}.transaction_type ;;
  }

  dimension: v {
    type: string
    label: "v"
    sql: ${TABLE}.v ;;
  }

  dimension: value {
    type: string
    label: "value"
    sql: ${TABLE}.value ;;
  }

  dimension: value_lossless {
    type: string
    label: "value_lossless"
    sql: ${TABLE}.value_lossless ;;
  }

  dimension: y_parity {
    type: string
    label: "y_parity"
    sql: ${TABLE}.y_parity ;;
  }

  dimension_group: block_timestamp_as_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    datatype: date
    convert_tz: no
    label: "block_timestamp (as date)"
    sql: DATE(SAFE_CAST(${TABLE}.block_timestamp AS TIMESTAMP)) ;;
  }
}
