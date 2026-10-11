view: bs_profit_this_month {
  derived_table: {
    sql: WITH months AS (
        SELECT m AS period_month FROM UNNEST(GENERATE_DATE_ARRAY(DATE_ADD(DATE_TRUNC(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL -3 MONTH), YEAR), INTERVAL 3 MONTH), DATE_ADD(DATE_ADD(DATE_TRUNC(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL -3 MONTH), YEAR), INTERVAL 3 MONTH), INTERVAL 11 MONTH), INTERVAL 1 MONTH)) AS m),
      finance AS (
        SELECT DATE_TRUNC(p.date_month, MONTH) AS period_month,
          COALESCE(SUM(CASE WHEN p.account_report_category = 'Cost of Delivery' THEN p.net_amount END), 0) AS cost_of_delivery,
          COALESCE(SUM(CASE WHEN p.account_report_category = 'Dividends' THEN p.net_amount END), 0) AS dividends,
          COALESCE(SUM(CASE WHEN p.account_report_category = 'Overheads' THEN p.net_amount END), 0) AS overheads,
          COALESCE(SUM(CASE WHEN p.account_report_category = 'Revenue' THEN p.net_amount END), 0) AS revenue,
          COALESCE(SUM(CASE WHEN p.account_report_category = 'Taxation' THEN p.net_amount END), 0) AS taxation
        FROM `ra-development.analytics.chart_of_accounts_dim` c
        LEFT JOIN `ra-development.analytics.profit_and_loss_report_fact` p ON c.account_id = p.account_id
        WHERE p.date_month >= DATE_ADD(DATE_TRUNC(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL -3 MONTH), YEAR), INTERVAL 3 MONTH) AND p.date_month < DATE_ADD(DATE_ADD(DATE_TRUNC(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL -3 MONTH), YEAR), INTERVAL 3 MONTH), INTERVAL 1 YEAR) AND p.account_report_category IS NOT NULL
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
        WHERE TIMESTAMP(r.month) >= TIMESTAMP(DATE_TRUNC(CURRENT_DATE(), MONTH)) AND TIMESTAMP(r.month) < TIMESTAMP(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL 1 MONTH))
        GROUP BY 1),
      targets AS (
        SELECT DATE_TRUNC(DATE(PARSE_TIMESTAMP('%d-%m-%Y', t.month)), MONTH) AS period_month,
          COALESCE(SUM(t.retained_earnings), 0) AS total_retained_earnings_target
        FROM `ra-development.analytics_seed.targets` t
        GROUP BY 1)
      SELECT m.period_month, f.cost_of_delivery, f.dividends, f.overheads, f.revenue, f.taxation,
          fc.sum_of_booked_and_forecast_revenue, fc.sum_of_overheads, fc.sum_of_forecast_net_profit, fc.sum_of_delivery_costs, fc.sum_of_dividends, fc.sum_of_forecast_taxation,
          t.total_retained_earnings_target,
          (f.revenue + f.cost_of_delivery + f.overheads + f.dividends + f.taxation) AS actual_retained_earnings,
          CASE WHEN m.period_month = DATE_TRUNC(CURRENT_DATE(), MONTH) THEN fc.sum_of_delivery_costs * -1 ELSE f.cost_of_delivery END AS cost_of_delivery_1,
          CASE WHEN m.period_month = DATE_TRUNC(CURRENT_DATE(), MONTH) THEN fc.sum_of_booked_and_forecast_revenue ELSE f.revenue END AS revenue_1,
          CASE WHEN m.period_month = DATE_TRUNC(CURRENT_DATE(), MONTH) THEN fc.sum_of_overheads * -1 ELSE f.overheads END AS overheads_1,
          CASE WHEN m.period_month = DATE_TRUNC(CURRENT_DATE(), MONTH) THEN fc.sum_of_dividends * -1 ELSE f.dividends END AS dividends_1,
          CASE WHEN m.period_month = DATE_TRUNC(CURRENT_DATE(), MONTH) THEN fc.sum_of_forecast_taxation * -1 ELSE f.taxation END AS taxation_1,
          CASE WHEN m.period_month = DATE_TRUNC(CURRENT_DATE(), MONTH) THEN fc.sum_of_forecast_net_profit ELSE (f.revenue + f.cost_of_delivery + f.overheads + f.dividends + f.taxation) END AS retained_income
      FROM months m
      LEFT JOIN finance f ON f.period_month = m.period_month
      LEFT JOIN forecast fc ON fc.period_month = m.period_month
      LEFT JOIN targets t ON t.period_month = m.period_month ;;
  }
  label: "Business Summary: Profit made and forecast this fiscal year (tile 2519)"

  dimension_group: period_month {
    type: time
    timeframes: [raw, date, month]
    convert_tz: no
    sql: ${TABLE}.period_month ;;
  }

  measure: actual_retained_earnings {
    type: number
    hidden: yes
    sql: CASE WHEN COUNT(${TABLE}.actual_retained_earnings) = 0 THEN NULL ELSE SUM(${TABLE}.actual_retained_earnings) END ;;
  }

  measure: cost_of_delivery {
    type: number
    hidden: yes
    sql: CASE WHEN COUNT(${TABLE}.cost_of_delivery) = 0 THEN NULL ELSE SUM(${TABLE}.cost_of_delivery) END ;;
  }

  measure: cost_of_delivery_1 {
    type: number
    hidden: yes
    sql: CASE WHEN COUNT(${TABLE}.cost_of_delivery_1) = 0 THEN NULL ELSE SUM(${TABLE}.cost_of_delivery_1) END ;;
  }

  measure: dividends {
    type: number
    hidden: yes
    sql: CASE WHEN COUNT(${TABLE}.dividends) = 0 THEN NULL ELSE SUM(${TABLE}.dividends) END ;;
  }

  measure: dividends_1 {
    type: number
    hidden: yes
    sql: CASE WHEN COUNT(${TABLE}.dividends_1) = 0 THEN NULL ELSE SUM(${TABLE}.dividends_1) END ;;
  }

  measure: overheads {
    type: number
    hidden: yes
    sql: CASE WHEN COUNT(${TABLE}.overheads) = 0 THEN NULL ELSE SUM(${TABLE}.overheads) END ;;
  }

  measure: overheads_1 {
    type: number
    hidden: yes
    sql: CASE WHEN COUNT(${TABLE}.overheads_1) = 0 THEN NULL ELSE SUM(${TABLE}.overheads_1) END ;;
  }

  measure: retained_income {
    type: number
    value_format_name: gbp_0
    sql: CASE WHEN COUNT(${TABLE}.retained_income) = 0 THEN NULL ELSE SUM(${TABLE}.retained_income) END ;;
  }

  measure: revenue {
    type: number
    hidden: yes
    sql: CASE WHEN COUNT(${TABLE}.revenue) = 0 THEN NULL ELSE SUM(${TABLE}.revenue) END ;;
  }

  measure: revenue_1 {
    type: number
    hidden: yes
    sql: CASE WHEN COUNT(${TABLE}.revenue_1) = 0 THEN NULL ELSE SUM(${TABLE}.revenue_1) END ;;
  }

  measure: sum_of_booked_and_forecast_revenue {
    type: number
    hidden: yes
    sql: CASE WHEN COUNT(${TABLE}.sum_of_booked_and_forecast_revenue) = 0 THEN NULL ELSE SUM(${TABLE}.sum_of_booked_and_forecast_revenue) END ;;
  }

  measure: sum_of_delivery_costs {
    type: number
    hidden: yes
    sql: CASE WHEN COUNT(${TABLE}.sum_of_delivery_costs) = 0 THEN NULL ELSE SUM(${TABLE}.sum_of_delivery_costs) END ;;
  }

  measure: sum_of_dividends {
    type: number
    hidden: yes
    sql: CASE WHEN COUNT(${TABLE}.sum_of_dividends) = 0 THEN NULL ELSE SUM(${TABLE}.sum_of_dividends) END ;;
  }

  measure: sum_of_forecast_net_profit {
    type: number
    hidden: yes
    sql: CASE WHEN COUNT(${TABLE}.sum_of_forecast_net_profit) = 0 THEN NULL ELSE SUM(${TABLE}.sum_of_forecast_net_profit) END ;;
  }

  measure: sum_of_forecast_taxation {
    type: number
    hidden: yes
    sql: CASE WHEN COUNT(${TABLE}.sum_of_forecast_taxation) = 0 THEN NULL ELSE SUM(${TABLE}.sum_of_forecast_taxation) END ;;
  }

  measure: sum_of_overheads {
    type: number
    hidden: yes
    sql: CASE WHEN COUNT(${TABLE}.sum_of_overheads) = 0 THEN NULL ELSE SUM(${TABLE}.sum_of_overheads) END ;;
  }

  measure: taxation {
    type: number
    hidden: yes
    sql: CASE WHEN COUNT(${TABLE}.taxation) = 0 THEN NULL ELSE SUM(${TABLE}.taxation) END ;;
  }

  measure: taxation_1 {
    type: number
    hidden: yes
    sql: CASE WHEN COUNT(${TABLE}.taxation_1) = 0 THEN NULL ELSE SUM(${TABLE}.taxation_1) END ;;
  }

  measure: total_retained_earnings_target {
    type: number
    value_format_name: gbp_0
    sql: CASE WHEN COUNT(${TABLE}.total_retained_earnings_target) = 0 THEN NULL ELSE SUM(${TABLE}.total_retained_earnings_target) END ;;
  }
}
