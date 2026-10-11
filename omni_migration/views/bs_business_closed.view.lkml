view: bs_business_closed {
  derived_table: {
    sql: WITH months AS (
        SELECT m AS period_month FROM UNNEST(GENERATE_DATE_ARRAY(DATE_TRUNC(CURRENT_DATE(), YEAR), DATE_ADD(DATE_TRUNC(CURRENT_DATE(), YEAR), INTERVAL 11 MONTH), INTERVAL 1 MONTH)) AS m),
      closed AS (
        SELECT DATE_TRUNC(DATE(d.deal_closed_ts), MONTH) AS deal_closed_month,
          COALESCE(SUM(CASE WHEN d.deal_pipeline_stage_id IN ('1031924', '1031923') THEN
              CASE WHEN d.deal_currency_code = 'USD' THEN d.deal_amount * .78
                   WHEN d.deal_currency_code = 'CAD' THEN d.deal_amount * .59
                   WHEN d.deal_currency_code = 'EUR' THEN d.deal_amount * 0.87
                   ELSE d.deal_amount END ELSE 0 END), 0) AS total_closed_won_deal_amount_gbp
        FROM `ra-development.analytics.companies_dim` cd
        LEFT JOIN `ra-development.analytics.deals_fact` d ON d.company_fk = cd.company_pk
        WHERE d.deal_closed_ts >= TIMESTAMP(DATE_TRUNC(CURRENT_DATE(), YEAR)) AND d.deal_closed_ts < TIMESTAMP(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), YEAR), INTERVAL 1 YEAR))
        GROUP BY 1),
      targets AS (
        SELECT DATE_TRUNC(DATE(PARSE_TIMESTAMP('%d-%m-%Y', t.month)), MONTH) AS period_month,
          COALESCE(SUM(t.deals_closed_target), 0) AS total_deals_closed_revenue_target
        FROM `ra-development.analytics_seed.targets` t
        GROUP BY 1)
      SELECT m.period_month AS deal_closed_month, c.total_closed_won_deal_amount_gbp, t.total_deals_closed_revenue_target
      FROM months m
      LEFT JOIN closed c ON c.deal_closed_month = m.period_month
      LEFT JOIN targets t ON t.period_month = m.period_month ;;
  }
  label: "Business Summary: Business closed this year (tile 2898)"

  dimension_group: deal_closed_month {
    type: time
    timeframes: [raw, date, month]
    convert_tz: no
    sql: ${TABLE}.deal_closed_month ;;
  }

  measure: total_closed_won_deal_amount_gbp {
    type: number
    value_format_name: gbp_0
    sql: CASE WHEN COUNT(${TABLE}.total_closed_won_deal_amount_gbp) = 0 THEN NULL ELSE SUM(${TABLE}.total_closed_won_deal_amount_gbp) END ;;
  }

  measure: total_deals_closed_revenue_target {
    type: number
    value_format_name: gbp_0
    sql: CASE WHEN COUNT(${TABLE}.total_deals_closed_revenue_target) = 0 THEN NULL ELSE SUM(${TABLE}.total_deals_closed_revenue_target) END ;;
  }
}
