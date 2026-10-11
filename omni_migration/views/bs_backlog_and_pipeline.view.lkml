view: bs_backlog_and_pipeline {
  derived_table: {
    sql: WITH months AS (
        SELECT m AS period_month FROM UNNEST(GENERATE_DATE_ARRAY(DATE_ADD(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL -17 MONTH), DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL 1 MONTH)) AS m),
      booked AS (
        SELECT DATE_TRUNC(pe.month_start, MONTH) AS booking_month,
          COALESCE(SUM(pe.total_engagement_revenue_remaining), 0) AS booked_revenue
        FROM `ra-development.analytics.timesheet_project_engagements_monthly_revenue_fact` pe
        WHERE pe.month_start >= DATE_ADD(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL -17 MONTH) AND pe.month_start < DATE_ADD(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL 1 MONTH)
        GROUP BY 1),
      pipeline AS (
        SELECT DATE_TRUNC(DATE(h.deal_month_ts), MONTH) AS deal_month,
          COALESCE(SUM(CASE WHEN h.deal_stage_category = '1: Initial Meeting' THEN h.deal_amount_gbp * .30
                            WHEN h.deal_stage_category = '2: Needs analysis and proposal' THEN h.deal_amount_gbp * .45
                            WHEN h.deal_stage_category = '3: Negotiation and commitment' THEN h.deal_amount_gbp * .60
                            WHEN h.deal_stage_category = '4: Deal close' THEN h.deal_amount_gbp ELSE 0 END), 0) AS total_weighted_amount_gbp
        FROM `ra-development.analytics.companies_dim` cd
        LEFT JOIN `ra-development.analytics.deals_fact` d ON d.company_fk = cd.company_pk
        INNER JOIN `ra-development.analytics.deal_pipeline_history_fact` h ON d.deal_id = h.deal_id
        GROUP BY 1)
      SELECT m.period_month AS booking_month, b.booked_revenue, p.deal_month, p.total_weighted_amount_gbp
      FROM months m
      LEFT JOIN booked b ON b.booking_month = m.period_month
      LEFT JOIN pipeline p ON DATE_ADD(p.deal_month, INTERVAL 1 MONTH) = m.period_month ;;
  }
  label: "Business Summary: Booked backlog and weighted pipeline (tile 2805)"

  dimension_group: booking_month {
    type: time
    timeframes: [raw, date, month]
    convert_tz: no
    sql: ${TABLE}.booking_month ;;
  }

  dimension_group: deal_month {
    type: time
    timeframes: [raw, date, month]
    convert_tz: no
    sql: ${TABLE}.deal_month ;;
  }

  measure: booked_revenue {
    type: number
    value_format_name: gbp_0
    sql: CASE WHEN COUNT(${TABLE}.booked_revenue) = 0 THEN NULL ELSE SUM(${TABLE}.booked_revenue) END ;;
  }

  measure: total_weighted_amount_gbp {
    type: number
    value_format_name: gbp_0
    sql: CASE WHEN COUNT(${TABLE}.total_weighted_amount_gbp) = 0 THEN NULL ELSE SUM(${TABLE}.total_weighted_amount_gbp) END ;;
  }
}
