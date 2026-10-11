view: fa_costs_share_of_revenue {
  derived_table: {
    sql: WITH months AS (
        SELECT m AS period_month FROM UNNEST(GENERATE_DATE_ARRAY(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL -12 MONTH), DATE_ADD(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL -1 MONTH), INTERVAL 1 MONTH)) AS m),
      finance AS (
        SELECT DATE_TRUNC(p.date_month, MONTH) AS period_month,
          COALESCE(SUM(CASE WHEN p.account_report_category = 'Cost of Delivery' THEN p.net_amount END), 0) AS cost_of_delivery,
          COALESCE(SUM(CASE WHEN p.account_report_category = 'Dividends' THEN p.net_amount END), 0) AS dividends,
          COALESCE(SUM(CASE WHEN p.account_report_category = 'Overheads' THEN p.net_amount END), 0) AS overheads,
          COALESCE(SUM(CASE WHEN p.account_report_category = 'Revenue' THEN p.net_amount END), 0) AS revenue,
          COALESCE(SUM(CASE WHEN p.account_report_category = 'Taxation' THEN p.net_amount END), 0) AS taxation
        FROM `ra-development.analytics.chart_of_accounts_dim` c
        LEFT JOIN `ra-development.analytics.profit_and_loss_report_fact` p ON c.account_id = p.account_id
        WHERE p.date_month >= DATE_ADD(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL -12 MONTH) AND p.date_month < DATE_TRUNC(CURRENT_DATE(), MONTH) AND p.account_report_category IS NOT NULL
        GROUP BY 1),
      forecast AS (
        SELECT DATE_TRUNC(DATE(TIMESTAMP(r.month)), MONTH) AS period_month,
          COALESCE(SUM(CAST(r.booked_and_forecast AS NUMERIC)), 0) AS sum_of_booked_and_forecast_revenue,
          COALESCE(SUM(CAST(r.overheads AS NUMERIC)), 0) AS sum_of_overheads,
          COALESCE(SUM(CAST(SAFE_CAST(REPLACE(r.forecast_net_profit, ',', '') AS DECIMAL) AS NUMERIC)), 0) AS sum_of_forecast_net_profit,
          COALESCE(SUM(CAST(r.delivery_costs AS NUMERIC)), 0) AS sum_of_delivery_costs,
          COALESCE(SUM(CAST(r.dividends AS NUMERIC)), 0) AS sum_of_dividends,
          COALESCE(SUM(CAST(r.taxation AS NUMERIC)), 0) AS sum_of_forecast_taxation
        FROM `ra-development.analytics_seed.revenue_and_forecast` r
        WHERE TIMESTAMP(r.month) >= TIMESTAMP(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL -1 MONTH)) AND TIMESTAMP(r.month) < TIMESTAMP(DATE_TRUNC(CURRENT_DATE(), MONTH))
        GROUP BY 1),
      targets AS (
        SELECT DATE_TRUNC(DATE(PARSE_TIMESTAMP('%d-%m-%Y', t.month)), MONTH) AS period_month,
          COALESCE(SUM(t.retained_earnings), 0) AS total_retained_earnings_target
        FROM `ra-development.analytics_seed.targets` t
        GROUP BY 1),
      recognized AS (
        SELECT DATE_TRUNC(r.billing_month, MONTH) AS period_month,
          COALESCE(SUM(r.consultant_recognized_revenue_gbp), 0) AS total_recognized_revenue_gbp
        FROM `ra-development.analytics.companies_dim` cd
        LEFT JOIN `ra-development.analytics.timesheet_projects_dim` pd ON cd.company_pk = pd.company_fk
        LEFT JOIN `ra-development.analytics.recognized_revenue_fact` r ON pd.timesheet_project_pk = r.timesheet_project_pk
        GROUP BY 1),
      merged AS (
        SELECT m.period_month, f.cost_of_delivery, f.dividends, f.overheads, f.revenue, f.taxation,
          fc.sum_of_booked_and_forecast_revenue, fc.sum_of_overheads, fc.sum_of_forecast_net_profit, fc.sum_of_delivery_costs, fc.sum_of_dividends, fc.sum_of_forecast_taxation,
          t.total_retained_earnings_target, rr.total_recognized_revenue_gbp,
          (f.revenue + f.cost_of_delivery + f.overheads + f.dividends + f.taxation) AS actual_retained_earnings,
          CASE WHEN m.period_month = DATE_TRUNC(CURRENT_DATE(), MONTH) THEN fc.sum_of_delivery_costs * -1 ELSE f.cost_of_delivery END AS cost_of_delivery_1,
          CASE WHEN m.period_month = DATE_TRUNC(CURRENT_DATE(), MONTH) THEN fc.sum_of_booked_and_forecast_revenue ELSE f.revenue END AS revenue_1,
          CASE WHEN m.period_month = DATE_TRUNC(CURRENT_DATE(), MONTH) THEN fc.sum_of_overheads * -1 ELSE f.overheads END AS overheads_1,
          CASE WHEN m.period_month = DATE_TRUNC(CURRENT_DATE(), MONTH) THEN fc.sum_of_dividends * -1 ELSE f.dividends END AS dividends_1,
          CASE WHEN m.period_month = DATE_TRUNC(CURRENT_DATE(), MONTH) THEN fc.sum_of_forecast_taxation * -1 ELSE f.taxation END AS taxation_1,
          CASE WHEN m.period_month = DATE_TRUNC(CURRENT_DATE(), MONTH) THEN fc.sum_of_forecast_net_profit ELSE (f.revenue + f.cost_of_delivery + f.overheads + f.dividends + f.taxation) END AS retained_income,
          EXTRACT(DAY FROM CURRENT_DATE()) / EXTRACT(DAY FROM LAST_DAY(CURRENT_DATE())) AS of_month_elapsed,
          m.period_month = DATE_ADD(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL -1 MONTH) AS is_first_row
        FROM months m
        LEFT JOIN finance f ON f.period_month = m.period_month
        LEFT JOIN forecast fc ON fc.period_month = m.period_month
        LEFT JOIN targets t ON t.period_month = m.period_month
        LEFT JOIN recognized rr ON rr.period_month = m.period_month),
      calcs AS (
        SELECT *,
          ABS(SAFE_DIVIDE(cost_of_delivery_1, revenue_1)) AS cost_of_delivery_as_of_revenue,
          ABS(SAFE_DIVIDE(overheads_1 + dividends_1, revenue_1)) AS overheads_as_of_revenue,
          SAFE_DIVIDE(retained_income, revenue_1) AS retained_income_as_of_revenue,
          cost_of_delivery_1 * of_month_elapsed AS cost_of_delivery_mtd,
          overheads_1 * of_month_elapsed AS overheads_mtd
        FROM merged)
      -- Looker's merge calculations: row 1 (the latest month in the window) is treated month-to-date against recognised revenue
      SELECT *,
        CASE WHEN is_first_row THEN SAFE_DIVIDE(taxation_1 * of_month_elapsed, total_recognized_revenue_gbp) * -1 ELSE SAFE_DIVIDE(taxation * -1, revenue) END AS taxation_pct,
        SAFE_DIVIDE(ABS(dividends), revenue) AS dividends_pct,
        CASE WHEN is_first_row THEN SAFE_DIVIDE(overheads_mtd, total_recognized_revenue_gbp) * -1 ELSE overheads_as_of_revenue END AS overheads_pct,
        CASE WHEN is_first_row THEN SAFE_DIVIDE(cost_of_delivery_mtd, total_recognized_revenue_gbp) * -1 ELSE cost_of_delivery_as_of_revenue END AS cost_of_delivery_pct,
        CASE WHEN is_first_row THEN SAFE_DIVIDE(retained_income * of_month_elapsed, total_recognized_revenue_gbp) ELSE retained_income_as_of_revenue END AS retained_income_pct
      FROM calcs ;;
  }
  label: "Costs as Share of Revenue (tile 3851)"

  dimension: actual_retained_earnings {
    hidden: yes
    sql: ${TABLE}.actual_retained_earnings ;;
  }

  dimension: cost_of_delivery {
    hidden: yes
    sql: ${TABLE}.cost_of_delivery ;;
  }

  dimension: cost_of_delivery_1 {
    hidden: yes
    sql: ${TABLE}.cost_of_delivery_1 ;;
  }

  dimension: cost_of_delivery_as_of_revenue {
    hidden: yes
    sql: ${TABLE}.cost_of_delivery_as_of_revenue ;;
  }

  dimension: cost_of_delivery_mtd {
    hidden: yes
    sql: ${TABLE}.cost_of_delivery_mtd ;;
  }

  dimension: cost_of_delivery_pct {
    hidden: yes
    sql: ${TABLE}.cost_of_delivery_pct ;;
  }

  dimension: dividends {
    hidden: yes
    sql: ${TABLE}.dividends ;;
  }

  dimension: dividends_1 {
    hidden: yes
    sql: ${TABLE}.dividends_1 ;;
  }

  dimension: dividends_pct {
    hidden: yes
    sql: ${TABLE}.dividends_pct ;;
  }

  dimension: is_first_row {
    hidden: yes
    sql: ${TABLE}.is_first_row ;;
  }

  dimension: of_month_elapsed {
    hidden: yes
    sql: ${TABLE}.of_month_elapsed ;;
  }

  dimension: overheads {
    hidden: yes
    sql: ${TABLE}.overheads ;;
  }

  dimension: overheads_1 {
    hidden: yes
    sql: ${TABLE}.overheads_1 ;;
  }

  dimension: overheads_as_of_revenue {
    hidden: yes
    sql: ${TABLE}.overheads_as_of_revenue ;;
  }

  dimension: overheads_mtd {
    hidden: yes
    sql: ${TABLE}.overheads_mtd ;;
  }

  dimension: overheads_pct {
    hidden: yes
    sql: ${TABLE}.overheads_pct ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: CAST(${period_month_raw} AS STRING) ;;
  }

  dimension: retained_income {
    hidden: yes
    sql: ${TABLE}.retained_income ;;
  }

  dimension: retained_income_as_of_revenue {
    hidden: yes
    sql: ${TABLE}.retained_income_as_of_revenue ;;
  }

  dimension: retained_income_pct {
    hidden: yes
    sql: ${TABLE}.retained_income_pct ;;
  }

  dimension: revenue {
    hidden: yes
    sql: ${TABLE}.revenue ;;
  }

  dimension: revenue_1 {
    hidden: yes
    sql: ${TABLE}.revenue_1 ;;
  }

  dimension: sum_of_booked_and_forecast_revenue {
    hidden: yes
    sql: ${TABLE}.sum_of_booked_and_forecast_revenue ;;
  }

  dimension: sum_of_delivery_costs {
    hidden: yes
    sql: ${TABLE}.sum_of_delivery_costs ;;
  }

  dimension: sum_of_dividends {
    hidden: yes
    sql: ${TABLE}.sum_of_dividends ;;
  }

  dimension: sum_of_forecast_net_profit {
    hidden: yes
    sql: ${TABLE}.sum_of_forecast_net_profit ;;
  }

  dimension: sum_of_forecast_taxation {
    hidden: yes
    sql: ${TABLE}.sum_of_forecast_taxation ;;
  }

  dimension: sum_of_overheads {
    hidden: yes
    sql: ${TABLE}.sum_of_overheads ;;
  }

  dimension: taxation {
    hidden: yes
    sql: ${TABLE}.taxation ;;
  }

  dimension: taxation_1 {
    hidden: yes
    sql: ${TABLE}.taxation_1 ;;
  }

  dimension: taxation_pct {
    hidden: yes
    sql: ${TABLE}.taxation_pct ;;
  }

  dimension: total_recognized_revenue_gbp {
    hidden: yes
    sql: ${TABLE}.total_recognized_revenue_gbp ;;
  }

  dimension: total_retained_earnings_target {
    hidden: yes
    sql: ${TABLE}.total_retained_earnings_target ;;
  }

  dimension_group: period_month {
    type: time
    timeframes: [raw, date, month, quarter, year]
    label: "Period Month"
    sql: ${TABLE}.period_month ;;
  }

  measure: retained_earnings_target {
    type: number
    label: "Total Retained Earnings Target"
    value_format_name: gbp_0
    sql: CASE WHEN COUNT(${TABLE}.total_retained_earnings_target) = 0 THEN NULL ELSE SUM(${TABLE}.total_retained_earnings_target) END ;;
  }

  measure: total_cost_of_delivery {
    type: number
    label: "Cost of Delivery"
    value_format_name: gbp_0
    sql: CASE WHEN COUNT(${TABLE}.cost_of_delivery_1) = 0 THEN NULL ELSE SUM(${TABLE}.cost_of_delivery_1) END ;;
  }

  measure: total_cost_of_delivery_pct {
    type: number
    label: "Cost of Delivery %"
    value_format_name: percent_1
    sql: CASE WHEN COUNT(${TABLE}.cost_of_delivery_pct) = 0 THEN NULL ELSE SUM(${TABLE}.cost_of_delivery_pct) END ;;
  }

  measure: total_dividends {
    type: number
    label: "Dividends"
    value_format_name: gbp_0
    sql: CASE WHEN COUNT(${TABLE}.dividends_1) = 0 THEN NULL ELSE SUM(${TABLE}.dividends_1) END ;;
  }

  measure: total_dividends_pct {
    type: number
    label: "Dividends %"
    value_format_name: percent_1
    sql: CASE WHEN COUNT(${TABLE}.dividends_pct) = 0 THEN NULL ELSE SUM(${TABLE}.dividends_pct) END ;;
  }

  measure: total_overheads {
    type: number
    label: "Overheads"
    value_format_name: gbp_0
    sql: CASE WHEN COUNT(${TABLE}.overheads_1) = 0 THEN NULL ELSE SUM(${TABLE}.overheads_1) END ;;
  }

  measure: total_overheads_pct {
    type: number
    label: "Overheads %"
    value_format_name: percent_1
    sql: CASE WHEN COUNT(${TABLE}.overheads_pct) = 0 THEN NULL ELSE SUM(${TABLE}.overheads_pct) END ;;
  }

  measure: total_recognized_revenue {
    type: number
    label: "Total Recognized Revenue GBP"
    value_format_name: gbp_0
    sql: CASE WHEN COUNT(${TABLE}.total_recognized_revenue_gbp) = 0 THEN NULL ELSE SUM(${TABLE}.total_recognized_revenue_gbp) END ;;
  }

  measure: total_retained_income {
    type: number
    label: "Retained Income"
    value_format_name: gbp_0
    sql: CASE WHEN COUNT(${TABLE}.retained_income) = 0 THEN NULL ELSE SUM(${TABLE}.retained_income) END ;;
  }

  measure: total_retained_income_pct {
    type: number
    label: "Retained Income %"
    value_format_name: percent_1
    sql: CASE WHEN COUNT(${TABLE}.retained_income_pct) = 0 THEN NULL ELSE SUM(${TABLE}.retained_income_pct) END ;;
  }

  measure: total_revenue {
    type: number
    label: "Revenue"
    value_format_name: gbp_0
    sql: CASE WHEN COUNT(${TABLE}.revenue_1) = 0 THEN NULL ELSE SUM(${TABLE}.revenue_1) END ;;
  }

  measure: total_taxation {
    type: number
    label: "Taxation"
    value_format_name: gbp_0
    sql: CASE WHEN COUNT(${TABLE}.taxation_1) = 0 THEN NULL ELSE SUM(${TABLE}.taxation_1) END ;;
  }

  measure: total_taxation_pct {
    type: number
    label: "Taxation %"
    value_format_name: percent_1
    sql: CASE WHEN COUNT(${TABLE}.taxation_pct) = 0 THEN NULL ELSE SUM(${TABLE}.taxation_pct) END ;;
  }
}
