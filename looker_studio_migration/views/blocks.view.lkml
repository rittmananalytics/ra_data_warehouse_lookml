view: blocks {
  sql_table_name: `bigquery-public-data.goog_blockchain_ethereum_mainnet_us.blocks` ;;

  dimension: base_fee_per_gas {
    type: number
    label: "base_fee_per_gas"
    sql: ${TABLE}.base_fee_per_gas ;;
  }

  dimension: block_hash {
    type: string
    label: "block_hash"
    sql: ${TABLE}.block_hash ;;
  }

  dimension: block_number {
    type: number
    label: "Block Number"
    sql: ${TABLE}.block_number ;;
  }

  # Ruling (needs_human unknown_type): Looker Studio data type code 10 is Date & Time; block_timestamp is a TIMESTAMP.
  dimension_group: block_timestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    convert_tz: no
    label: "Timestamp (UTC)"
    sql: ${TABLE}.block_timestamp ;;
  }

  dimension: difficulty {
    type: string
    label: "difficulty"
    sql: ${TABLE}.difficulty ;;
  }

  dimension: extra_data {
    type: string
    label: "extra_data"
    sql: ${TABLE}.extra_data ;;
  }

  dimension: gas_limit {
    type: number
    label: "gas_limit"
    sql: ${TABLE}.gas_limit ;;
  }

  dimension: gas_used {
    type: number
    label: "Gas Used"
    sql: ${TABLE}.gas_used ;;
  }

  dimension: logs_bloom {
    type: string
    label: "logs_bloom"
    sql: ${TABLE}.logs_bloom ;;
  }

  dimension: miner {
    type: string
    label: "miner"
    sql: ${TABLE}.miner ;;
  }

  dimension: mix_hash {
    type: string
    label: "mix_hash"
    sql: ${TABLE}.mix_hash ;;
  }

  dimension: nonce {
    type: string
    label: "nonce"
    sql: ${TABLE}.nonce ;;
  }

  dimension: parent_hash {
    type: string
    label: "parent_hash"
    sql: ${TABLE}.parent_hash ;;
  }

  dimension: receipts_root {
    type: string
    label: "receipts_root"
    sql: ${TABLE}.receipts_root ;;
  }

  dimension: sha3_uncles {
    type: string
    label: "sha3_uncles"
    sql: ${TABLE}.sha3_uncles ;;
  }

  dimension: size {
    type: number
    label: "size"
    sql: ${TABLE}.size ;;
  }

  dimension: state_root {
    type: string
    label: "state_root"
    sql: ${TABLE}.state_root ;;
  }

  dimension: total_difficulty {
    type: string
    label: "total_difficulty"
    sql: ${TABLE}.total_difficulty ;;
  }

  dimension: transaction_count {
    type: number
    label: "transaction_count"
    sql: ${TABLE}.transaction_count ;;
  }

  dimension: transactions_root {
    type: string
    label: "transactions_root"
    sql: ${TABLE}.transactions_root ;;
  }

  dimension: withdrawals_root {
    type: string
    label: "withdrawals_root"
    sql: ${TABLE}.withdrawals_root ;;
  }

  dimension_group: block_timestamp_as_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    datatype: date
    convert_tz: no
    label: "block_timestamp (as date)"
    sql: DATE(SAFE_CAST(${TABLE}.block_timestamp AS TIMESTAMP)) ;;
  }

  measure: base_fee_in_gwei {
    type: sum
    label: "Base Fee (in Gwei)"
    sql: SAFE_DIVIDE(${base_fee_per_gas}, 1000000000) ;;
  }

  measure: finalized_blocks {
    type: number
    label: "Finalized Blocks"
    sql: COUNT(${block_number}) ;;
  }

  measure: total_transaction_count {
    type: sum
    label: "Transactions"
    sql: ${transaction_count} ;;
  }

  # Hand-finished measures for the two charts the converter listed (needs_human: MEDIAN, DATETIME_DIFF)
  measure: median_base_fee_in_gwei {
    type: median
    label: "Med Base Fee (in Gwei)"
    sql: SAFE_DIVIDE(${base_fee_per_gas}, 1000000000) ;;
    value_format_name: decimal_0
  }

  measure: tps {
    type: number
    label: "TPS"
    sql: SAFE_DIVIDE(SUM(${transaction_count}), TIMESTAMP_DIFF(MAX(${block_timestamp_raw}), MIN(${block_timestamp_raw}), SECOND)) ;;
    value_format_name: decimal_2
  }
}
