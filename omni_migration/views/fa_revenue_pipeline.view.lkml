view: fa_revenue_pipeline {
  derived_table: {
    sql: WITH booked AS (
        SELECT DATE_TRUNC(pe.month_start, MONTH) AS booking_month,
          COALESCE(SUM(pe.total_engagement_revenue_remaining), 0) AS booked_revenue
        FROM `ra-development.analytics.timesheet_project_engagements_monthly_revenue_fact` pe
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
      -- Looker's merge: the booked-revenue query is primary; the pipeline joins on the month after its snapshot month
      SELECT b.booking_month, b.booked_revenue, p.deal_month, p.total_weighted_amount_gbp
      FROM booked b
      LEFT JOIN pipeline p ON DATE_ADD(p.deal_month, INTERVAL 1 MONTH) = b.booking_month ;;
  }
  label: "Revenue Pipeline (tile 3855)"

  dimension: booked_revenue {
    hidden: yes
    sql: ${TABLE}.booked_revenue ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: CAST(${booking_month_raw} AS STRING) ;;
  }

  dimension: total_weighted_amount_gbp {
    hidden: yes
    sql: ${TABLE}.total_weighted_amount_gbp ;;
  }

  dimension_group: booking_month {
    type: time
    timeframes: [raw, date, month, quarter, year]
    label: "Booking Month"
    sql: ${TABLE}.booking_month ;;
  }

  dimension_group: deal_month {
    type: time
    timeframes: [raw, date, month]
    label: "Pipeline Snapshot Month"
    hidden: yes
    sql: ${TABLE}.deal_month ;;
  }

  measure: total_booked_revenue {
    type: number
    label: "Booked Revenue"
    value_format_name: gbp_0
    sql: CASE WHEN COUNT(${TABLE}.booked_revenue) = 0 THEN NULL ELSE SUM(${TABLE}.booked_revenue) END ;;
  }

  measure: total_weighted_pipeline_gbp {
    type: number
    label: "Total Weighted Amount GBP"
    value_format_name: gbp_0
    sql: CASE WHEN COUNT(${TABLE}.total_weighted_amount_gbp) = 0 THEN NULL ELSE SUM(${TABLE}.total_weighted_amount_gbp) END ;;
  }
}
