view: project_attribution {
  derived_table: {
    sql: WITH staff_dim AS (SELECT contact_pk, contact_name, contact_is_contractor, contact_is_staff, contact_weekly_capacity, contact_default_hourly_rate, contact_cost_rate, contact_is_active, contact_created_date FROM `ra-development.analytics.contacts_dim`
      where contact_is_staff or contact_name = 'Rob Bramwell'
       ),
project_hours as (
SELECT
    t6.`__f2` AS timesheet_project_pk,
    t6.`__f8` AS invoice_month,
    t6.`__f6` AS contact_pk,
    t6.`__f1` AS pct_elapsed,
    t6.`__f7` AS hourly_rate,
        CASE WHEN COUNT(CASE WHEN CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 128 END + CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 64 END + CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 32 END + CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 16 END + CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 8 END + CASE WHEN t6.groupingVal = 0 THEN 0 ELSE 4 END + CASE WHEN t6.groupingVal = 1 THEN 0 ELSE 2 END + CASE WHEN t6.groupingVal = 2 THEN 0 ELSE 1 END = 3 THEN t6.`__f9` ELSE NULL END) = 0 THEN NULL ELSE COALESCE(SUM(CASE WHEN CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 128 END + CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 64 END + CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 32 END + CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 16 END + CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 8 END + CASE WHEN t6.groupingVal = 0 THEN 0 ELSE 4 END + CASE WHEN t6.groupingVal = 1 THEN 0 ELSE 2 END + CASE WHEN t6.groupingVal = 2 THEN 0 ELSE 1 END = 3 THEN t6.`__f9` ELSE NULL END), 0) END AS total_net_amount_gbp,
        CASE WHEN COUNT(CASE WHEN CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 128 END + CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 64 END + CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 32 END + CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 16 END + CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 8 END + CASE WHEN t6.groupingVal = 0 THEN 0 ELSE 4 END + CASE WHEN t6.groupingVal = 1 THEN 0 ELSE 2 END + CASE WHEN t6.groupingVal = 2 THEN 0 ELSE 1 END = 5 THEN t6.`__f10` ELSE NULL END) = 0 THEN NULL ELSE COALESCE(SUM(CASE WHEN CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 128 END + CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 64 END + CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 32 END + CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 16 END + CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 8 END + CASE WHEN t6.groupingVal = 0 THEN 0 ELSE 4 END + CASE WHEN t6.groupingVal = 1 THEN 0 ELSE 2 END + CASE WHEN t6.groupingVal = 2 THEN 0 ELSE 1 END = 5 THEN t6.`__f10` ELSE NULL END), 0) END AS hours_billed,
        CASE WHEN COUNT(CASE WHEN CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 128 END + CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 64 END + CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 32 END + CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 16 END + CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 8 END + CASE WHEN t6.groupingVal = 0 THEN 0 ELSE 4 END + CASE WHEN t6.groupingVal = 1 THEN 0 ELSE 2 END + CASE WHEN t6.groupingVal = 2 THEN 0 ELSE 1 END = 6 THEN t6.`__f11` ELSE NULL END) = 0 THEN NULL ELSE COALESCE(SUM(CASE WHEN CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 128 END + CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 64 END + CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 32 END + CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 16 END + CASE WHEN t6.groupingVal IN (0, 1, 2) THEN 0 ELSE 8 END + CASE WHEN t6.groupingVal = 0 THEN 0 ELSE 4 END + CASE WHEN t6.groupingVal = 1 THEN 0 ELSE 2 END + CASE WHEN t6.groupingVal = 2 THEN 0 ELSE 1 END = 6 THEN t6.`__f11` ELSE NULL END), 0) END AS project_fee_amount
FROM
    (SELECT
            CASE WHEN t4.groupingVal IN (0, 1, 2) THEN t0.projects_delivered_total_business_days_pct_elapsed ELSE NULL END AS `__f1`,
                CASE WHEN t4.groupingVal IN (0, 1, 2) THEN t0.projects_delivered_timesheet_project_pk ELSE NULL END AS `__f2`,
                CASE WHEN t4.groupingVal IN (0, 1, 2) THEN t0.project_timesheet_users_contact_pk ELSE NULL END AS `__f6`,
                CASE WHEN t4.groupingVal IN (0, 1, 2) THEN t0.project_timesheet_users_contact_default_hourly_rate ELSE NULL END AS `__f7`,
                CASE WHEN t4.groupingVal IN (0, 1, 2) THEN t0.projects_invoiced_invoice_month ELSE NULL END AS `__f8`,
                CASE WHEN t4.groupingVal = 0 THEN t0.`__f18` ELSE NULL END AS `__f18`,
                CASE WHEN t4.groupingVal = 1 THEN t0.`__f20` ELSE NULL END AS `__f20`,
                CASE WHEN t4.groupingVal = 2 THEN t0.`__f21` ELSE NULL END AS `__f21`,
            t4.groupingVal,
            MIN(t0.`__f17`) AS `__f9`,
            MIN(t0.`__f19`) AS `__f10`,
            MIN(t0.projects_delivered_project_fee_amount) AS `__f11`
        FROM
            (SELECT
                    projects_delivered.project_fee_amount  AS projects_delivered_project_fee_amount,
                    1- projects_delivered.total_business_days_pct_left  AS projects_delivered_total_business_days_pct_elapsed,
                    projects_delivered.timesheet_project_pk  AS projects_delivered_timesheet_project_pk,
                    project_timesheet_users.contact_pk  AS project_timesheet_users_contact_pk,
                    project_timesheet_users.contact_cost_rate  AS project_timesheet_users_contact_default_hourly_rate,
                        (FORMAT_TIMESTAMP('%Y-%m', projects_invoiced.invoice_sent_at_ts )) AS projects_invoiced_invoice_month,
                    ( case when projects_invoiced.total_gbp_amount is null then projects_invoiced.total_local_amount / exchange_rates.CURRENCY_RATE else projects_invoiced.total_gbp_amount end ) - coalesce(( (case when projects_invoiced.total_gbp_amount is null then projects_invoiced.total_local_amount / exchange_rates.CURRENCY_RATE else projects_invoiced.total_gbp_amount end) * (safe_cast(projects_invoiced.invoice_tax_rate_pct as float64) / 100)  ),0) AS `__f17`,
                    projects_invoiced.invoice_pk  AS `__f18`,
                    coalesce(project_timesheets.timesheet_hours_billed,0)  AS `__f19`,
                    project_timesheets.timesheet_pk  AS `__f20`,
                    projects_delivered.timesheet_project_pk  AS `__f21`
                FROM `analytics.timesheet_projects_dim`
     AS projects_delivered
LEFT JOIN `analytics.timesheets_fact`
     AS project_timesheets ON projects_delivered.timesheet_project_pk = project_timesheets.timesheet_project_fk
LEFT JOIN staff_dim AS project_timesheet_users ON project_timesheets.contact_fk  = project_timesheet_users.contact_pk
LEFT JOIN `analytics.invoices_fact`
     AS projects_invoiced ON projects_delivered.timesheet_project_pk = projects_invoiced.timesheet_project_fk
LEFT JOIN `ra-development.analytics_seed.exchange_rates`
     AS exchange_rates ON projects_invoiced.invoice_currency = exchange_rates.CURRENCY_CODE ) AS t0,
                (SELECT
                        0 AS groupingVal
                    UNION ALL
                    SELECT
                        1 AS groupingVal
                    UNION ALL
                    SELECT
                        2 AS groupingVal) AS t4
        GROUP BY
            CASE WHEN t4.groupingVal IN (0, 1, 2) THEN t0.projects_delivered_total_business_days_pct_elapsed ELSE NULL END,
            CASE WHEN t4.groupingVal IN (0, 1, 2) THEN t0.projects_delivered_timesheet_project_pk ELSE NULL END,
            CASE WHEN t4.groupingVal IN (0, 1, 2) THEN t0.project_timesheet_users_contact_pk ELSE NULL END,
            CASE WHEN t4.groupingVal IN (0, 1, 2) THEN t0.project_timesheet_users_contact_default_hourly_rate ELSE NULL END,
            CASE WHEN t4.groupingVal IN (0, 1, 2) THEN t0.projects_invoiced_invoice_month ELSE NULL END,
            CASE WHEN t4.groupingVal = 0 THEN t0.`__f18` ELSE NULL END,
            CASE WHEN t4.groupingVal = 1 THEN t0.`__f20` ELSE NULL END,
            CASE WHEN t4.groupingVal = 2 THEN t0.`__f21` ELSE NULL END,
            t4.groupingVal) AS t6
GROUP BY
    1,
    2,
    3,
    4,
    5)
select
  * except(project_fee_amount),
  sum(hours_billed) over (partition by timesheet_project_pk) as project_hours_billed,
  safe_divide(hours_billed,sum(hours_billed) over (partition by timesheet_project_pk)) pct_of_project_hours_billed,
  round((total_net_amount_gbp*(safe_divide(hours_billed,sum(hours_billed) over (partition by timesheet_project_pk))))*pct_elapsed) as total_revenue_gbp,
  round(hours_billed * hourly_rate) as total_cost_gbp,
  round(((total_net_amount_gbp*(safe_divide(hours_billed,sum(hours_billed) over (partition by timesheet_project_pk))))*pct_elapsed) - (hours_billed * hourly_rate)) as total_contribution
from
  project_hours
where timesheet_project_pk is not null
  and invoice_month is not null
order by
  1,2,3
 ;;
  }

  measure: count {
    hidden: yes

    type: count
    drill_fields: [detail*]
  }

  dimension: timesheet_project_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.timesheet_project_pk ;;
  }
  dimension: pk {
    hidden: yes
    primary_key: yes
    sql: concat(${timesheet_project_pk},${contact_pk},${invoice_month}) ;;
  }

  dimension: invoice_month {
    type: string
    hidden: yes
    sql: ${TABLE}.invoice_month ;;
  }

  dimension_group: billing {
    type: time
    datatype: timestamp
    timeframes: [month,quarter,year]
    sql: parse_timestamp('%Y-%m',invoice_month) ;;
  }

  dimension: contact_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.contact_pk ;;
  }

  dimension: pct_elapsed {
    hidden: yes
    type: number
    sql: ${TABLE}.pct_elapsed ;;
  }

  dimension: hourly_rate {
    hidden: yes
    type: number
    sql: ${TABLE}.hourly_rate ;;
  }

  dimension: total_net_amount_gbp {
    type: number
    hidden: yes

    sql: ${TABLE}.total_net_amount_gbp ;;
  }

  dimension: hours_billed {
    type: number
    hidden: yes
    sql: ${TABLE}.hours_billed ;;
  }

  dimension: project_hours_billed {
    type: number
    hidden: yes

    sql: ${TABLE}.project_hours_billed ;;
  }

  dimension: pct_of_project_hours_billed {
    type: number
    hidden: yes

    sql: ${TABLE}.pct_of_project_hours_billed ;;
  }

  dimension: total_revenue_gbp {
    type: number
    hidden: yes

    sql: ${TABLE}.total_revenue_gbp ;;
  }

  dimension: total_cost_gbp {
    type: number
    hidden: yes

    sql: ${TABLE}.total_cost_gbp ;;
  }

  dimension: total_contribution_gbp {
    type: number
    hidden: yes

    sql: ${TABLE}.total_contribution ;;
  }

  measure: attributed_revenue_gbp {
    type: sum
    hidden: no

    sql: ${TABLE}.total_revenue_gbp ;;
  }

  measure: attributed_cost_gbp {
    type: sum
    hidden: yes

    sql: ${TABLE}.total_cost_gbp ;;
  }

  measure: attributed_contribution_gbp {
    type: sum
    hidden: yes

    sql: ${TABLE}.total_contribution ;;
  }

  set: detail {
    fields: [
      timesheet_project_pk,
      invoice_month,
      contact_pk,
      pct_elapsed,
      hourly_rate,
      total_net_amount_gbp,
      hours_billed,
      project_hours_billed,
      pct_of_project_hours_billed,
      total_revenue_gbp,
      total_cost_gbp,
      total_contribution_gbp
    ]
  }
}
