- dashboard: ethereum_blockchain_analytics
  title: Ethereum Blockchain Analytics
  layout: newspaper
  preferred_viewer: dashboards-next
  description: Hand-finished from the Wire conversion of Looker Studio report "Ethereum Dataset Demo" (titles, formats, layout, two measures the converter listed)
  filters:
  - name: Date range
    title: Date range
    type: field_filter
    default_value: after 2015/07/29   # ruling (needs_human date_range_default): the control's range at capture, 30 Jul 2015 to today
    allow_multiple_values: true
    required: false
    model: looker_studio_migration
    explore: blocks
    field: blocks.block_timestamp_as_date_date
  elements:
  - name: note
    type: text
    body_text: This dashboard uses data from the Blockchain Analytics Ethereum dataset (bigquery-public-data), migrated from Looker Studio by Wire.
    row: 0
    col: 0
    width: 24
    height: 1
  - name: transactions_kpi
    title: Transactions
    model: looker_studio_migration
    explore: blocks
    type: single_value
    fields: [blocks.total_transaction_count]
    custom_color_enabled: true
    custom_color: "#4285F4"
    value_format: '0.000,,,"bn"'
    row: 1
    col: 0
    width: 5
    height: 3
    listen:
      Date range: blocks.block_timestamp_as_date_date
  - name: tps_kpi
    title: TPS
    model: looker_studio_migration
    explore: blocks
    type: single_value
    fields: [blocks.tps]
    custom_color_enabled: true
    custom_color: "#EA4335"
    row: 1
    col: 5
    width: 5
    height: 3
    listen:
      Date range: blocks.block_timestamp_as_date_date
  - name: finalized_blocks_kpi
    title: Finalized Blocks
    model: looker_studio_migration
    explore: blocks
    type: single_value
    fields: [blocks.finalized_blocks]
    custom_color_enabled: true
    custom_color: "#34A853"
    value_format: '#,##0'
    row: 4
    col: 0
    width: 5
    height: 3
    listen:
      Date range: blocks.block_timestamp_as_date_date
  - name: med_base_fee_kpi
    title: Med Base Fee (in Gwei)
    model: looker_studio_migration
    explore: blocks
    type: single_value
    fields: [blocks.median_base_fee_in_gwei]
    custom_color_enabled: true
    custom_color: "#FBBC04"
    row: 4
    col: 5
    width: 5
    height: 3
    listen:
      Date range: blocks.block_timestamp_as_date_date
  - name: transaction_history
    title: Transaction History
    model: looker_studio_migration
    explore: blocks
    type: looker_line
    fields: [blocks.block_timestamp_date, blocks.total_transaction_count]
    sorts: [blocks.block_timestamp_date asc]
    limit: 5000
    show_view_names: false
    show_y_axis_labels: false
    show_x_axis_label: false
    legend_position: center
    series_colors:
      blocks.total_transaction_count: "#202124"
    row: 1
    col: 10
    width: 14
    height: 6
    listen:
      Date range: blocks.block_timestamp_as_date_date
  - name: finalized_blocks_table
    title: Finalized Blocks
    model: looker_studio_migration
    explore: blocks
    type: looker_grid
    fields: [blocks.block_number, blocks.block_timestamp_time, blocks.base_fee_in_gwei, blocks.gas_used, blocks.total_transaction_count]
    sorts: [blocks.block_number desc]
    limit: 50
    show_view_names: false
    show_row_numbers: false
    series_labels:
      blocks.total_transaction_count: Txns
    row: 7
    col: 0
    width: 12
    height: 9
    listen:
      Date range: blocks.block_timestamp_as_date_date
  - name: transactions_table
    title: Transactions
    model: looker_studio_migration
    explore: transactions
    type: looker_grid
    fields: [transactions.transaction_hash, transactions.from_address, transactions.to_address, transactions.block_number, transactions.transaction_index]
    sorts: [transactions.block_number desc]
    limit: 20
    show_view_names: false
    show_row_numbers: false
    row: 7
    col: 12
    width: 12
    height: 9
    listen:
      Date range: transactions.block_timestamp_as_date_date
