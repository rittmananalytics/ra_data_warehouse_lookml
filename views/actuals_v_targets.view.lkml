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
           AS projects_delivered ON companies_dim.company_pk = projects_delivered.company_fk
      LEFT JOIN `analytics.invoices_fact`
           AS projects_invoiced ON projects_delivered.timesheet_project_pk = projects_invoiced.timesheet_project_pk
      --WHERE ((( projects_invoiced.invoice_created_at_ts  ) >= ((TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR))) AND ( projects_invoiced.invoice_created_at_ts  ) < ((TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL 1 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING)))))))
      GROUP BY 1
      ),
      deals as (
      SELECT
          date_trunc(date(deals_fact.deal_created_ts ),month) AS month,
          COALESCE(SUM(deals_fact.deal_amount ), 0) AS total_deal_amount
      FROM `analytics.companies_dim` AS companies_dim
      FULL OUTER JOIN `analytics.deals_fact` AS deals_fact ON companies_dim.company_pk = deals_fact.company_pk
      --WHERE ((( deals_fact.deal_created_ts  ) >= ((TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR))) AND ( deals_fact.deal_created_ts  ) < ((TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL 1 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING)))))))
      GROUP BY
          1
      ),
      won_deals as (
      SELECT
          date_trunc(date(case when deals_fact.deal_closed_amount_value is not null and deals_fact.pipeline_stage_display_order >=8 and deals_fact.pipeline_display_order <=9 then deals_fact.deal_closed_ts end ),month) AS month,
          COALESCE(SUM(case when deals_fact.pipeline_stage_closed_won   then  deals_fact.deal_amount end), 0) AS total_closed_deal_amount
      FROM `analytics.companies_dim` AS companies_dim
      FULL OUTER JOIN `analytics.deals_fact` AS deals_fact ON companies_dim.company_pk = deals_fact.company_pk
     -- WHERE ((( deals_fact.deal_created_ts  ) >= ((TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR))) AND ( deals_fact.deal_created_ts  ) < ((TIMESTAMP(CONCAT(CAST(DATE_ADD(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS DATE), INTERVAL 1 YEAR) AS STRING), ' ', CAST(TIME(CAST(TIMESTAMP_TRUNC(CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY) AS TIMESTAMP), YEAR) AS TIMESTAMP)) AS STRING))))))) AND (deals_fact.pipeline_stage_closed_won )
      GROUP BY
          1
      ),
      targets as (
       select parse_date('%d-%m-%Y',`month`) as `month`, revenue_target, deals_target, deals_closed_target from `analytics_seed.targets`
      )
      select t.`month`, t.revenue_target, r.revenue_actual, t.deals_target, d.total_deal_amount, t.deals_closed_target, w.total_closed_deal_amount
      from targets t
      left join revenue r
      on t.month = r.month
      left join deals d
      on t.month = d.month
      left join won_deals w
      on t.month = w.month
       ;;
  }

  parameter: measure_group {
    type: unquoted
    allowed_value: {label:"Actual Revenue" value: "revenue"}
    allowed_value: {label:"Actual New Deals" value: "deals"}
    allowed_value: {label:"Actual Closed Won Deals" value: "closed_deals"}
    default_value: "revenue"
  }

  parameter: target_group {
    type: unquoted
    allowed_value: {label:"Target Revenue" value: "revenue"}
    allowed_value: {label:"Target New Deals" value: "deals"}
    allowed_value: {label:"Target Closed Won Deals" value: "closed_deals"}
    default_value: "revenue"
  }

  measure: actual {
    label_from_parameter: measure_group
  type: sum
    value_format_name: gbp
    sql:
    {% if measure_group._parameter_value == 'revenue' %}
      ${TABLE}.revenue_actual
    {% elsif measure_group._parameter_value == 'deals' %}
      ${TABLE}.total_deal_amount
    {% elsif measure_group._parameter_value == 'closed_deals' %}
      ${TABLE}.total_closed_deal_amount
    {% endif %} ;;
  }

  measure: target {
    label_from_parameter: target_group
    type: sum
    value_format_name: gbp
    sql:
    {% if target_group._parameter_value == 'revenue' %}
      ${TABLE}.revenue_target
    {% elsif target_group._parameter_value == 'deals' %}
      ${TABLE}.deals_target
    {% elsif target_group._parameter_value == 'closed_deals' %}
      ${TABLE}.deals_closed_target
    {% endif %} ;;
  }





  dimension_group: month {
    type: time
    timeframes: [month,month_num,year,fiscal_month_num,fiscal_quarter,fiscal_quarter_of_year,fiscal_year]
    sql: timestamp(${TABLE}.month) ;;
  }

  measure: revenue_target {
    hidden: yes
    type: sum
    sql: ${TABLE}.revenue_target ;;
  }

  measure: revenue_actual {
    hidden: yes

    type: sum
    sql: ${TABLE}.revenue_actual ;;
  }

  measure: deals_target {
    hidden: yes

    type: sum
    sql: ${TABLE}.deals_target ;;
  }

  measure: total_deal_amount {
    hidden: yes

    type: sum
    sql: ${TABLE}.total_deal_amount ;;
  }

  measure: deals_closed_target {
    hidden: yes

    type: sum
    sql: ${TABLE}.deals_closed_target ;;
  }

  measure: total_closed_deal_amount {
    hidden: yes

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