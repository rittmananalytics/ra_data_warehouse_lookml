view: actuals_v_targets {
  derived_table: {
    sql: with revenue as (
      SELECT
          date_trunc(date(projects_invoiced.invoice_created_at_ts),month)AS month,
          COALESCE(SUM(case when projects_invoiced.invoice_currency = 'USD' then projects_invoiced.invoice_local_total_revenue_amount * .75
                    when projects_invoiced.invoice_currency = 'CAD' then projects_invoiced.invoice_local_total_revenue_amount * .58
                    when projects_invoiced.invoice_currency = 'EUR' then projects_invoiced.invoice_local_total_revenue_amount * .90
                    else projects_invoiced.invoice_local_total_revenue_amount end), 0) AS revenue_actual
      FROM `analytics.companies_dim` AS companies_dim
      LEFT JOIN `analytics.timesheet_projects_dim`
           AS projects_delivered ON companies_dim.company_pk = projects_delivered.company_pk
      LEFT JOIN `analytics.invoices_fact`
           AS projects_invoiced ON projects_delivered.timesheet_project_pk = projects_invoiced.timesheet_project_pk
      WHERE ((( projects_invoiced.invoice_created_at_ts  ) >= ((TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR))) AND ( projects_invoiced.invoice_created_at_ts  ) < ((TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL 1 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING)))))))
      GROUP BY 1
      ),
      deals as (
      SELECT
          date_trunc(date(deals_fact.deal_created_ts ),month) AS month,
          COALESCE(SUM(deals_fact.deal_amount ), 0) AS total_deal_amount
      FROM `analytics.companies_dim` AS companies_dim
      FULL OUTER JOIN `analytics.deals_fact` AS deals_fact ON companies_dim.company_pk = deals_fact.company_pk
      WHERE ((( deals_fact.deal_created_ts  ) >= ((TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR))) AND ( deals_fact.deal_created_ts  ) < ((TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL 1 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING)))))))
      GROUP BY
          1
      ),
      won_deals as (
      SELECT
          date_trunc(date(deals_fact.deal_created_ts ),month) AS month,
          COALESCE(SUM(deals_fact.deal_amount ), 0) AS total_closed_deal_amount
      FROM `analytics.companies_dim` AS companies_dim
      FULL OUTER JOIN `analytics.deals_fact` AS deals_fact ON companies_dim.company_pk = deals_fact.company_pk
      WHERE ((( deals_fact.deal_created_ts  ) >= ((TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR))) AND ( deals_fact.deal_created_ts  ) < ((TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL 1 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))))))) AND (deals_fact.pipeline_stage_closed_won )
      GROUP BY
          1
      ),
      targets as (
       select parse_date('%d-%m-%Y',`month`) as `month`, revenue_target, deals_target, deals_closed_target from `analytics_seed.targets`
      )
      select t.`month`, t.revenue_target, r.revenue_actual, t.deals_target, d.total_deal_amount, t.deals_closed_target, w.total_closed_deal_amount
      from targets t
      join revenue r
      on t.month = r.month
      join deals d
      on t.month = d.month
      join won_deals w
      on t.month = w.month
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: month {
    type: time
    timeframes: [month,month_num,year]
    sql: timestamp(${TABLE}.month) ;;
  }

  measure: revenue_target {
    type: sum
    sql: ${TABLE}.revenue_target ;;
  }

  measure: revenue_actual {
    type: sum
    sql: ${TABLE}.revenue_actual ;;
  }

  measure: deals_target {
    type: sum
    sql: ${TABLE}.deals_target ;;
  }

  measure: total_deal_amount {
    type: sum
    sql: ${TABLE}.total_deal_amount ;;
  }

  measure: deals_closed_target {
    type: sum
    sql: ${TABLE}.deals_closed_target ;;
  }

  measure: total_closed_deal_amount {
    type: sum
    sql: ${TABLE}.total_closed_deal_amount ;;
  }

  set: detail {
    fields: [
      revenue_target,
      revenue_actual,
      deals_target,
      total_deal_amount,
      deals_closed_target,
      total_closed_deal_amount
    ]
  }
}
