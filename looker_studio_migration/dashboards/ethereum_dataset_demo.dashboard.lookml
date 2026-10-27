- dashboard: ethereum_dataset_demo
  title: Ethereum Dataset Demo
  layout: newspaper
  preferred_viewer: dashboards-next
  description: Migrated from Looker Studio report Ethereum Dataset Demo (ls_to_lookml 0.1.0, experimental)
  filters:
  - name: Date range
    title: Date range
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: looker_studio_migration
    explore: blocks
    field: blocks.block_timestamp_as_date_date
  elements:
  - name: text_cd_i65iqa7d5c
    type: text
    body_text: Ethereum Blockchain Analytics
    row: 0
    col: 2
    width: 7
    height: 1
  - name: text_cd_p0y973817c
    type: text
    body_text: This dashboard uses data from the Blockchain Analytics Ethereum dataset
    row: 0
    col: 13
    width: 10
    height: 1
  - name: simple_linechart_cd_2d5iqa7d5c
    model: looker_studio_migration
    explore: blocks
    type: looker_line
    fields:
    - blocks.block_timestamp_date
    - blocks.total_transaction_count
    sorts:
    - blocks.block_timestamp_date asc
    limit: 5000
    row: 2
    col: 10
    width: 14
    height: 3
    listen:
      Date range: blocks.block_timestamp_as_date_date
  - name: text_cd_j65iqa7d5c
    type: text
    body_text: Transaction His​tory
    row: 2
    col: 10
    width: 5
    height: 1
  - name: kpi_metric_cd_8d5iqa7d5c
    model: looker_studio_migration
    explore: blocks
    type: single_value
    fields:
    - blocks.total_transaction_count
    limit: 500
    row: 3
    col: 1
    width: 4
    height: 1
    listen:
      Date range: blocks.block_timestamp_as_date_date
  - name: kpi_metric_cd_6d5iqa7d5c
    model: looker_studio_migration
    explore: blocks
    type: single_value
    fields:
    - blocks.finalized_blocks
    limit: 500
    row: 4
    col: 1
    width: 4
    height: 1
    listen:
      Date range: blocks.block_timestamp_as_date_date
  - name: text_cd_g65iqa7d5c
    type: text
    body_text: Finalized Blocks
    row: 6
    col: 1
    width: 4
    height: 1
  - name: text_cd_zd5iqa7d5c
    type: text
    body_text: Transactions
    row: 6
    col: 14
    width: 5
    height: 1
  - name: simple_table_cd_655iqa7d5c
    model: looker_studio_migration
    explore: blocks
    type: looker_grid
    fields:
    - blocks.block_number
    - blocks.block_timestamp_time
    - blocks.base_fee_in_gwei
    - blocks.gas_used
    - blocks.total_transaction_count
    sorts:
    - blocks.block_number desc
    limit: 50
    row: 7
    col: 1
    width: 12
    height: 8
    listen:
      Date range: blocks.block_timestamp_as_date_date
  - name: simple_table_cd_a65iqa7d5c
    model: looker_studio_migration
    explore: transactions
    type: looker_grid
    fields:
    - transactions.transaction_hash
    - transactions.from_address
    - transactions.to_address
    - transactions.block_number
    - transactions.transaction_index
    sorts:
    - transactions.block_number desc
    limit: 20
    row: 7
    col: 14
    width: 10
    height: 8
    listen:
      Date range: transactions.block_timestamp_as_date_date
