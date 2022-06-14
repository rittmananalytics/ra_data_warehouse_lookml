- dashboard: analytics
  title: Finance
  layout: newspaper
  preferred_viewer: dashboards-next
  preferred_slug: eZjLQdP4UMCub7jrccdzz5
  elements:
  - title: Profit & Loss Report
    name: Profit & Loss Report
    model: analytics
    explore: chart_of_accounts_dim
    type: marketplace_viz_report_table::report_table-marketplace
    fields: [chart_of_accounts_dim.account_report_category, chart_of_accounts_dim.account_report_sub_category,
      chart_of_accounts_dim.account_report_group, chart_of_accounts_dim.account_name,
      chart_of_accounts_dim.account_code, general_ledger_fact.net_amount, general_ledger_fact.journal_month]
    pivots: [general_ledger_fact.journal_month]
    fill_fields: [general_ledger_fact.journal_month]
    filters:
      general_ledger_fact.journal_month: 1 fiscal years
      chart_of_accounts_dim.account_report_group: "-NULL"
    sorts: [chart_of_accounts_dim.account_name 0, general_ledger_fact.journal_month
        desc]
    limit: 500
    column_limit: 50
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    theme: traditional
    layout: auto
    minWidthForIndexColumns: true
    headerFontSize: 14
    bodyFontSize: 12
    showTooltip: true
    columnOrder: {}
    rowSubtotals: true
    colSubtotals: true
    spanRows: true
    spanCols: true
    sortColumnsBy: pivots
    useHeadings: false
    indexColumn: false
    hide|chart_of_accounts_dim.account_report_category: true
    hide|chart_of_accounts_dim.account_report_sub_category: true
    hide|chart_of_accounts_dim.account_report_group: true
    label|chart_of_accounts_dim.account_name: Account
    hide|chart_of_accounts_dim.account_name: false
    label|chart_of_accounts_dim.account_code: Code
    subtotalDepth: '2'
    style|general_ledger_fact.net_amount: normal
    reportIn|general_ledger_fact.net_amount: '1'
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 0
    series_types: {}
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    column_order: ["$$$_row_numbers_$$$", chart_of_accounts_dim.account_report_category,
      chart_of_accounts_dim.account_code, chart_of_accounts_dim.account_name, 2020-10_general_ledger_fact.net_amount,
      2020-11_general_ledger_fact.net_amount, 2020-12_general_ledger_fact.net_amount,
      2021-01_general_ledger_fact.net_amount, 2021-02_general_ledger_fact.net_amount,
      2021-03_general_ledger_fact.net_amount, 2021-04_general_ledger_fact.net_amount,
      2021-05_general_ledger_fact.net_amount, 2021-06_general_ledger_fact.net_amount,
      2021-07_general_ledger_fact.net_amount, 2021-08_general_ledger_fact.net_amount,
      2021-09_general_ledger_fact.net_amount]
    row: 0
    col: 0
    width: 24
    height: 23
