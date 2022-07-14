view: kpi_scorecard {
  derived_table: {
    sql: with delivery_kpi_1 as (
      (
        SELECT
          timestamp(date_trunc(contact_utilization_fact.forecast_week,MONTH)) as kpi_month,
          'Utilization' as kpi_name,
          max(0.5) as category_weighting_pct,
          COALESCE(SUM(contact_utilization_fact.actual_billable_hours ),
            0) / COALESCE(SUM(contact_utilization_fact.target_billable_capacity ),
            0) AS actual_pct,
          COALESCE(SUM(contact_utilization_fact.target_billable_capacity ),
            0) / COALESCE(SUM(contact_utilization_fact.total_capacity ),
            0) AS target_pct
        FROM
          `ra-development.analytics.contact_utilization_fact` AS contact_utilization_fact
        INNER JOIN (
          SELECT
            contact_pk,
            contact_name,
            contact_is_contractor,
            contact_is_staff,
            contact_weekly_capacity,
            contact_default_hourly_rate,
            contact_cost_rate,
            contact_is_active,
            contact_created_date
          FROM
            `ra-development.analytics.contacts_dim`
          WHERE
            contact_is_staff ) staff_dim
        ON
          contact_utilization_fact.contact_pk = staff_dim.contact_pk
        WHERE
          ((( contact_utilization_fact.forecast_week ) >= ((TIMESTAMP(DATETIME_ADD(DATETIME(TIMESTAMP_TRUNC(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), MONTH)),
                      INTERVAL -12 MONTH))))
              AND ( contact_utilization_fact.forecast_week ) < ((TIMESTAMP(DATETIME_ADD(DATETIME(TIMESTAMP(DATETIME_ADD(DATETIME(TIMESTAMP_TRUNC(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), MONTH)),
                            INTERVAL -12 MONTH))),
                      INTERVAL 12 MONTH))))))
          AND ((staff_dim.contact_name ) <> 'Toby Sexton'
            OR (staff_dim.contact_name ) IS NULL)
          AND (NOT (staff_dim.contact_is_contractor )
            OR (staff_dim.contact_is_contractor ) IS NULL)
        GROUP BY
          1)
      ),
      delivery_kpi_2 as (
      SELECT
        timestamp(date_trunc(date(projects_delivered.project_delivery_end_ts),MONTH)) as kpi_month,
        'Ontime Project Delivery' AS kpi_name,
            max(0.5) as category_weighting_pct,

      COUNT(DISTINCT
      CASE
      WHEN projects_delivered_is_ontime.is_ontime_project THEN projects_delivered_is_ontime.projects_delivered_timesheet_project_pk
      ELSE
      NULL
      END
      ) / COUNT(DISTINCT projects_delivered.timesheet_project_pk ) AS actual_pct,
      0.9 AS target_pct
      FROM
      `analytics.timesheet_projects_dim` AS projects_delivered
      LEFT JOIN (
      SELECT
      projects_delivered_timesheet_project_pk,
      DATE_DIFF(DATE(mf0b5f3c7bbfa__project_timesheets_last_timesheet_billing_date),projects_delivered_project_delivery_end_ts_date,DAY) <= 0 AS is_ontime_project
      FROM (
      SELECT
      projects_delivered.timesheet_project_pk AS projects_delivered_timesheet_project_pk,
      (DATE(TIMESTAMP(projects_delivered.project_delivery_end_ts) )) AS projects_delivered_project_delivery_end_ts_date,
      (FORMAT_TIMESTAMP('%Y-%m', TIMESTAMP(projects_delivered.project_delivery_end_ts) )) AS projects_delivered_project_delivery_end_ts_month,
      (DATE(TIMESTAMP(projects_delivered.project_delivery_start_ts) )) AS projects_delivered_project_delivery_start_ts_date,
      projects_delivered.project_name AS projects_delivered_project_name,
      CASE
      WHEN companies_dim.company_name = 'indexlabs.co.uk' THEN 'Football Index'
      ELSE
      companies_dim.company_name
      END
      AS companies_dim_company_name,
      (DATE(projects_invoiced.invoice_sent_at_ts )) AS projects_invoiced_invoice_date,
      MAX(project_timesheets.timesheet_billing_date ) AS mf0b5f3c7bbfa__project_timesheets_last_timesheet_billing_date,
      COUNT(DISTINCT companies_dim.company_pk ) AS companies_dim_count,
      ROUND(COALESCE(CAST( ( SUM(DISTINCT (CAST(ROUND(COALESCE( coalesce(project_timesheets.timesheet_hours_billed,
      0),
      0)*(1/1000*1.0), 9) AS NUMERIC) + (CAST(CAST(CONCAT('0x', SUBSTR(to_hex(md5(CAST( project_timesheets.timesheet_pk AS STRING))), 1, 15)) AS int64) AS numeric) * 4294967296 + CAST(CAST(CONCAT('0x', SUBSTR(to_hex(md5(CAST( project_timesheets.timesheet_pk AS STRING))), 16, 8)) AS int64) AS numeric)) * 0.000000001 )) - SUM(DISTINCT (CAST(CAST(CONCAT('0x', SUBSTR(to_hex(md5(CAST( project_timesheets.timesheet_pk AS STRING))), 1, 15)) AS int64) AS numeric) * 4294967296 + CAST(CAST(CONCAT('0x', SUBSTR(to_hex(md5(CAST( project_timesheets.timesheet_pk AS STRING))), 16, 8)) AS int64) AS numeric)) * 0.000000001) ) / (1/1000*1.0) AS FLOAT64),
      0), 6) AS project_timesheets_total_timesheet_hours_billed
      FROM
      `analytics.timesheet_projects_dim` AS projects_delivered
      LEFT JOIN
      `analytics.timesheets_fact` AS project_timesheets
      ON
      projects_delivered.timesheet_project_pk = project_timesheets.timesheet_project_pk
      LEFT JOIN
      `analytics.companies_dim` AS companies_dim
      ON
      projects_delivered.company_pk = companies_dim.company_pk
      LEFT JOIN
      `analytics.invoices_fact` AS projects_invoiced
      ON
      projects_delivered.timesheet_project_pk = projects_invoiced.timesheet_project_pk
      GROUP BY
      1,
      2,
      3,
      4,
      5,
      6,
      7
      HAVING
      project_timesheets_total_timesheet_hours_billed > 0) AS t3 ) projects_delivered_is_ontime
      ON
      projects_delivered.timesheet_project_pk = projects_delivered_is_ontime.projects_delivered_timesheet_project_pk
      WHERE
      (projects_delivered.project_is_billable )
      GROUP BY
      1
      ),
      finance_kpi_1 as (
      SELECT
      timestamp(date_trunc(projects_invoiced.invoice_sent_at_ts,MONTH)) AS kpi_month,
      'Revenue' as kpi_name,
      max(0.5) as category_weighting_pct,

      COALESCE(SUM(( case when projects_invoiced.total_gbp_amount is null then projects_invoiced.total_local_amount / exchange_rates.CURRENCY_RATE else projects_invoiced.total_gbp_amount end ) - coalesce(( (case when projects_invoiced.total_gbp_amount is null then projects_invoiced.total_local_amount / exchange_rates.CURRENCY_RATE else projects_invoiced.total_gbp_amount end) * (safe_cast(projects_invoiced.invoice_tax_rate_pct as float64) / 100)  ),0)), 0) / max(targets.targets_total_revenue_target) AS actual_pct,
      max(1) as target_pct

      FROM `analytics.timesheet_projects_dim`
      AS projects_delivered
      LEFT JOIN `analytics.invoices_fact`
      AS projects_invoiced ON projects_delivered.timesheet_project_pk = projects_invoiced.timesheet_project_pk
      LEFT JOIN `ra-development.analytics_seed.exchange_rates`
      AS exchange_rates ON projects_invoiced.invoice_currency = exchange_rates.CURRENCY_CODE
      JOIN
      (SELECT
      (FORMAT_TIMESTAMP('%Y-%m', parse_timestamp('%d-%m-%Y', targets.month) )) AS targets_period_month,
      COALESCE(SUM(targets.revenue_target ), 0) AS targets_total_revenue_target
      FROM `ra-development.analytics_seed.targets`
      AS targets
      GROUP BY
      1) targets
      on (FORMAT_TIMESTAMP('%Y-%m', projects_invoiced.invoice_sent_at_ts )) = targets.targets_period_month

      GROUP BY
      1,2
      ),
      finance_kpi_2 as (
      SELECT
      timestamp(date_trunc(deals_fact.deal_created_ts,MONTH)) AS kpi_month,
      'Closed Business' as kpi_name,
      max(0.5) as category_weighting_pct,

      COALESCE(SUM(CASE
      when deals_fact.deal_currency_code = 'USD' then deals_fact.deal_amount * .75
      when deals_fact.deal_currency_code = 'CAD' then deals_fact.deal_amount * .58
      when deals_fact.deal_currency_code = 'EUR' then deals_fact.deal_amount * 0.90
      else deals_fact.deal_amount end ), 0) / max(targets_total_deals_closed_target) as actual_pct,
      max(1) as target_pct
      FROM `analytics.companies_dim` AS companies_dim
      FULL OUTER JOIN `analytics.deals_fact` AS deals_fact ON companies_dim.company_pk = deals_fact.company_pk
      JOIN (SELECT
      (FORMAT_TIMESTAMP('%Y-%m', parse_timestamp('%d-%m-%Y', targets.month) )) AS targets_period_month,
      COALESCE(SUM(targets.deals_closed_target ), 0) AS targets_total_deals_closed_target
      FROM `ra-development.analytics_seed.targets`
      AS targets
      GROUP BY
      1) targets

      on (FORMAT_TIMESTAMP('%Y-%m', deals_fact.deal_created_ts )) = targets.targets_period_month
      WHERE (deals_fact.pipeline_stage_closed_won )

      GROUP BY
      1
      ),
      team_kpi_1 as (
      SELECT
      timestamp(date_trunc( timestamp(hr_survey_results_fact.survey_ts),MONTH)) AS kpi_month,
      'eNPS' as kpi_name,
      max(0.5) as category_weighting_pct,

      AVG(hr_survey_results_fact.e_nps )  / max(targets_avg_enps_target) as actual_pct,
      max(1) as target_pct
      FROM
      `ra-development.analytics.hr_survey_results_fact` AS hr_survey_results_fact
      join
      (SELECT
      (FORMAT_TIMESTAMP('%Y-%m', parse_timestamp('%d-%m-%Y', targets.month) )) AS targets_period_month,
      AVG(targets.enps ) AS targets_avg_enps_target
      FROM `ra-development.analytics_seed.targets`
      AS targets
      GROUP BY
      1) targets
      on (FORMAT_TIMESTAMP('%Y-%m', timestamp(hr_survey_results_fact.survey_ts) )) = targets.targets_period_month

      GROUP BY
      1,2
      ),
      team_kpi_2 as (
      SELECT
      timestamp(date_trunc(date(parse_timestamp('%b-%Y',certification_progress.month)),MONTH) ) AS kpi_month,
      'Certification' as kpi_name,
      max(0.5) as category_weighting_pct,


      COALESCE(SUM(certification_progress.score ), 0) AS actual_pct,
      AVG(certification_progress.target ) AS target_pct
      FROM `ra-development.analytics_seed.certification_progress`
      AS certification_progress
      GROUP BY
      1,2
      ),
      individual_kpis as (
      select f1.kpi_month,f1.kpi_name as f1_kpi_name,coalesce(f1.actual_pct/f1.target_pct,0) as f1_actual_to_target_pct,case when f2.category_weighting_pct is null and f1.category_weighting_pct is not null then 1 when f1.category_weighting_pct is null and f1.category_weighting_pct is not null then 0 else coalesce(f1.category_weighting_pct,0) end as f1_weighting_pct,
      f2.kpi_name as f2_kpi_name,coalesce(f2.actual_pct/f2.target_pct,0) as f2_actual_to_target_pct,case when f1.category_weighting_pct is null  and f2.category_weighting_pct is not null then 1 when f2.category_weighting_pct is null then 0 else coalesce(f2.category_weighting_pct,0) end as f2_weighting_pct,
      d1.kpi_name as d1_kpi_name,coalesce(d1.actual_pct/d1.target_pct,0) as d1_actual_to_target_pct,case when d2.category_weighting_pct is null and d1.category_weighting_pct is not null then 1 when d1.category_weighting_pct is null then 0 else coalesce(d1.category_weighting_pct,0) end as d1_weighting_pct,
      d2.kpi_name as d2_kpi_name,coalesce(d2.actual_pct/d2.target_pct,0) as d2_actual_to_target_pct,case when d1.category_weighting_pct is null and d2.category_weighting_pct is not null then 1 when d2.category_weighting_pct is null then 0 else coalesce(d2.category_weighting_pct,0) end as d2_weighting_pct,
      t1.kpi_name as t1_kpi_name,coalesce(t1.actual_pct/t1.target_pct,0) as t1_actual_to_target_pct,case when t2.category_weighting_pct is null and t1.category_weighting_pct is not null then 1 when t1.category_weighting_pct is null then 0 else coalesce(t1.category_weighting_pct,0) end as t1_weighting_pct,
      t2.kpi_name as t2_kpi_name,coalesce(t2.actual_pct/d2.target_pct,0) as t2_actual_to_target_pct,case when t1.category_weighting_pct is null and t2.category_weighting_pct is not null then 1 when t2.category_weighting_pct is null then 0 else coalesce(t2.category_weighting_pct,0) end as t2_weighting_pct
      from finance_kpi_1 f1
      left join finance_kpi_2 f2
      on f1.kpi_month = f2.kpi_month
      left join delivery_kpi_1 d1
      on f1.kpi_month = d1.kpi_month
      left join delivery_kpi_2 d2
      on f1.kpi_month = d2.kpi_month
      left join team_kpi_1 t1
      on f1.kpi_month = t1.kpi_month
      left join team_kpi_2 t2
      on f1.kpi_month = t2.kpi_month
      where date(f1.kpi_month) between date_sub(current_date, interval 365 day) and current_date),
      perspective_kpis as (
      select
      individual_kpis.kpi_month as kpi_month,
      'Finance' as perspective_name,
      round(f1_actual_to_target_pct*f1_weighting_pct + f2_actual_to_target_pct*f2_weighting_pct,2) as finance_perspective_weighted_kpi_score,
      0.5 as finance_perspective_weighting,
      round(d1_actual_to_target_pct*d1_weighting_pct + d2_actual_to_target_pct*d2_weighting_pct,2) as delivery_perspective_weighted_kpi_score,
      0.3 as delivery_perspective_weighting,
      round(t1_actual_to_target_pct*f1_weighting_pct + t2_actual_to_target_pct*t2_weighting_pct,2) as team_perspective_weighted_kpi_score,
      0.2 as team_perspective_weighting
      from individual_kpis
      ),
      overall_kpis as (
      select kpi_month,
      round((coalesce(finance_perspective_weighted_kpi_score,0) * finance_perspective_weighting) +
      (coalesce(delivery_perspective_weighted_kpi_score,0) * delivery_perspective_weighting) +
      (coalesce(team_perspective_weighted_kpi_score,0) * team_perspective_weighting),2) as overall_actual_pct,
      1 as overall_target_pct
      from perspective_kpis

      ),
      all_kpis as (
      select i.kpi_month,
      max(f1_kpi_name) over () as f1_kpi_name,
      f1_actual_to_target_pct,
      f1_weighting_pct,
      max(f2_kpi_name) over () as f2_kpi_name,
      f2_actual_to_target_pct,
      f2_weighting_pct,
      max(d1_kpi_name) over () as d1_kpi_name,
      d1_actual_to_target_pct,
      d1_weighting_pct,
      max(d2_kpi_name) over () as d2_kpi_name,
      d2_actual_to_target_pct,
      d2_weighting_pct,
      max(t1_kpi_name) over () as t1_kpi_name,
      t1_actual_to_target_pct,
      t1_weighting_pct,
      max(t2_kpi_name) over () as t1_kpi_name,
      t2_actual_to_target_pct,
      t2_weighting_pct,
      p.* except (kpi_month),
      o.* except (kpi_month)
      from individual_kpis i
      left join perspective_kpis p
      on i.kpi_month = p.kpi_month
      left join overall_kpis o
      on i.kpi_month = o.kpi_month

      )
      select * from all_kpis
      ;;
  }



  dimension_group: kpi_month {
    type: time
    timeframes: [month,quarter,year]
    sql: ${TABLE}.kpi_month ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: no
    sql: ${TABLE}.kpi_month ;;
  }

  dimension: f1_kpi_name {
    label: "Financial KPI #1 Name"
    type: string
    sql: ${TABLE}.f1_kpi_name ;;
  }

  dimension: f1_actual_to_target_pct {
    hidden: yes

    type: number
    sql: ${TABLE}.f1_actual_to_target_pct ;;
  }

  dimension: f1_weighting_pct {
    type: number
    sql: ${TABLE}.f1_weighting_pct ;;
  }

  dimension: f2_kpi_name {
    label: "Financial KPI #2 Name"
    type: string
    sql: ${TABLE}.f2_kpi_name ;;
  }

  dimension: f2_actual_to_target_pct {
    hidden: yes

    type: number
    sql: ${TABLE}.f2_actual_to_target_pct ;;
  }

  dimension: f2_weighting_pct {
    type: number
    sql: ${TABLE}.f2_weighting_pct ;;
  }

  dimension: d1_kpi_name {
    label: "Delivery KPI #1 Name"
    type: string
    sql: ${TABLE}.d1_kpi_name ;;
  }

  dimension: d1_actual_to_target_pct {
    hidden: yes

    type: number
    sql: ${TABLE}.d1_actual_to_target_pct ;;
  }

  dimension: d1_weighting_pct {
    type: number
    sql: ${TABLE}.d1_weighting_pct ;;
  }

  dimension: d2_kpi_name {
    label: "Delivery KPI #2 Name"

    type: string
    sql: ${TABLE}.d2_kpi_name ;;
  }

  dimension: d2_actual_to_target_pct {
    hidden: yes

    type: number
    sql: ${TABLE}.d2_actual_to_target_pct ;;
  }

  dimension: d2_weighting_pct {
    type: number

    sql: ${TABLE}.d2_weighting_pct ;;
  }

  dimension: t1_kpi_name {
    label: "Team KPI #1 Name"

    type: string
    sql: ${TABLE}.t1_kpi_name ;;
  }

  dimension: t1_actual_to_target_pct {
    type: number
    hidden: yes
    sql: ${TABLE}.t1_actual_to_target_pct ;;
  }

  dimension: t1_weighting_pct {
    type: number
    sql: ${TABLE}.t1_weighting_pct ;;
  }

  dimension: t1_kpi_name_1 {
    type: string
    sql: ${TABLE}.t1_kpi_name_1 ;;
  }

  dimension: t2_actual_to_target_pct {
    type: number
    hidden: yes

    sql: ${TABLE}.t2_actual_to_target_pct ;;
  }

  dimension: t2_weighting_pct {
    type: number
    sql: ${TABLE}.t2_weighting_pct ;;
  }

  dimension: perspective_name {
    type: string
    sql: ${TABLE}.perspective_name ;;
  }

  dimension: finance_perspective_weighted_kpi_score {
    hidden: yes

    type: number
    sql: ${TABLE}.finance_perspective_weighted_kpi_score ;;
  }

  dimension: finance_perspective_weighting {
    type: number
    sql: ${TABLE}.finance_perspective_weighting ;;
  }

  dimension: delivery_perspective_weighted_kpi_score {
    hidden: yes

    type: number
    sql: ${TABLE}.delivery_perspective_weighted_kpi_score ;;
  }

  dimension: delivery_perspective_weighting {
    type: number
    sql: ${TABLE}.delivery_perspective_weighting ;;
  }

  dimension: team_perspective_weighted_kpi_score {
    hidden: yes

    type: number
    sql: ${TABLE}.team_perspective_weighted_kpi_score ;;
  }

  dimension: team_perspective_weighting {
    type: number
    sql: ${TABLE}.team_perspective_weighting ;;
  }

  dimension: overall_actual_pct {
    hidden: yes

    type: number
    sql: ${TABLE}.overall_actual_pct ;;
  }

  dimension: overall_target_pct {
    hidden: yes

    type: number
    sql: ${TABLE}.overall_target_pct ;;
  }

  measure: avg_f1_actual_to_target_pct {
    hidden: no

    type: average
    sql: ${TABLE}.f1_actual_to_target_pct ;;
  }

  measure: avg_f2_actual_to_target_pct {
    hidden: no

    type: average
    sql: ${TABLE}.f1_actual_to_target_pct ;;
  }

  measure: avg_d1_actual_to_target_pct {
    hidden: no

    type: average
    sql: ${TABLE}.f1_actual_to_target_pct ;;
  }

  measure: avg_d2_actual_to_target_pct {
    hidden: no

    type: average
    sql: ${TABLE}.f1_actual_to_target_pct ;;
  }

  measure: avg_t1_actual_to_target_pct {
    hidden: no

    type: average
    sql: ${TABLE}.f1_actual_to_target_pct ;;
  }

  measure: avg_t2_actual_to_target_pct {
    hidden: no

    type: average
    sql: ${TABLE}.f1_actual_to_target_pct ;;
  }
}
