view: consultant_revenue_attribution {
  derived_table: {
    sql: WITH
  contacts_dim AS (
  SELECT
    ct.*,
    hb.contact_id AS hubspot_contact_id,
    ce.contact_email AS contact_email,
    c.company_pk
  FROM (
    SELECT
      *
    FROM
      `analytics.contacts_dim`,
      UNNEST( all_contact_company_ids) AS company_id ) ct
  JOIN (
    SELECT
      *
    FROM
      `analytics.companies_dim` c,
      UNNEST (all_company_ids) AS company_id ) c
  ON
    ct.company_id = c.company_id
  LEFT JOIN (
    SELECT
      contact_pk,
      contact_id
    FROM
      `analytics.contacts_dim`,
      UNNEST( all_contact_ids) AS contact_id
    WHERE
      contact_id LIKE '%hubspot%' ) hb
  ON
    ct.contact_pk = hb.contact_pk
  LEFT JOIN (
    SELECT
      contact_pk,
      contact_email
    FROM
      `analytics.contacts_dim`,
      UNNEST( all_contact_emails ) AS contact_email ) ce
  ON
    ct.contact_pk = ce.contact_pk
  WHERE
    ct.company_id = c.company_id ),
timesheet_hours as (
SELECT
  (FORMAT_TIMESTAMP('%Y-%m', TIMESTAMP(project_timesheet_projects.project_delivery_start_ts) )) AS project_timesheet_projects_project_delivery_start_ts_month,
  project_timesheet_projects.project_code AS project_timesheet_projects_project_code,
  project_timesheet_users.contact_name AS project_timesheet_users_contact_name,
  ROUND(COALESCE(CAST( ( SUM(DISTINCT (CAST(ROUND(COALESCE( project_timesheets.timesheet_hours_billed,
                    0)*(1/1000*1.0), 9) AS NUMERIC) + (CAST(CAST(CONCAT('0x', SUBSTR(to_hex(md5(CAST( project_timesheets.timesheet_pk AS STRING))), 1, 15)) AS int64) AS numeric) * 4294967296 + CAST(CAST(CONCAT('0x', SUBSTR(to_hex(md5(CAST( project_timesheets.timesheet_pk AS STRING))), 16, 8)) AS int64) AS numeric)) * 0.000000001 )) - SUM(DISTINCT (CAST(CAST(CONCAT('0x', SUBSTR(to_hex(md5(CAST( project_timesheets.timesheet_pk AS STRING))), 1, 15)) AS int64) AS numeric) * 4294967296 + CAST(CAST(CONCAT('0x', SUBSTR(to_hex(md5(CAST( project_timesheets.timesheet_pk AS STRING))), 16, 8)) AS int64) AS numeric)) * 0.000000001) ) / (1/1000*1.0) AS FLOAT64),
      0), 6) AS project_timesheets_total_timesheet_hours_billed
FROM
  `analytics.companies_dim` AS companies_dim
LEFT JOIN
  `analytics.timesheet_projects_dim` AS projects_delivered
ON
  companies_dim.company_pk = projects_delivered.company_pk
LEFT JOIN
  `analytics.timesheets_fact` AS project_timesheets
ON
  projects_delivered.timesheet_project_pk = project_timesheets.timesheet_project_pk
LEFT JOIN
  `analytics.timesheet_projects_dim` AS project_timesheet_projects
ON
  project_timesheets.timesheet_project_pk = project_timesheet_projects.timesheet_project_pk
LEFT JOIN
  contacts_dim AS project_timesheet_users
ON
  project_timesheets.contact_pk = project_timesheet_users.contact_pk
GROUP BY
  1,
  2,
  3),
revenue as (
SELECT
    (FORMAT_TIMESTAMP('%Y-%m', projects_invoiced.invoice_created_at_ts )) AS projects_invoiced_invoice_month,
    project_timesheet_projects.project_code  AS project_timesheet_projects_project_code,
    ROUND(COALESCE(CAST( ( SUM(DISTINCT (CAST(ROUND(COALESCE( case when projects_invoiced.invoice_currency = 'USD' then projects_invoiced.invoice_local_total_revenue_amount * .75
              when projects_invoiced.invoice_currency = 'CAD' then projects_invoiced.invoice_local_total_revenue_amount * .58
              when projects_invoiced.invoice_currency = 'EUR' then projects_invoiced.invoice_local_total_revenue_amount * .90
              else projects_invoiced.invoice_local_total_revenue_amount end ,0)*(1/1000*1.0), 9) AS NUMERIC) + (cast(cast(concat('0x', substr(to_hex(md5(CAST( projects_invoiced.invoice_pk   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( projects_invoiced.invoice_pk   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001 )) - SUM(DISTINCT (cast(cast(concat('0x', substr(to_hex(md5(CAST( projects_invoiced.invoice_pk   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( projects_invoiced.invoice_pk   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001) )  / (1/1000*1.0) AS FLOAT64), 0), 6) AS projects_invoiced_invoice_gbp_revenue_amount,
    ROUND(COALESCE(CAST( ( SUM(DISTINCT (CAST(ROUND(COALESCE( project_invoice_timesheets.timesheet_hours_billed  ,0)*(1/1000*1.0), 9) AS NUMERIC) + (cast(cast(concat('0x', substr(to_hex(md5(CAST( project_invoice_timesheets.timesheet_pk   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( project_invoice_timesheets.timesheet_pk   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001 )) - SUM(DISTINCT (cast(cast(concat('0x', substr(to_hex(md5(CAST( project_invoice_timesheets.timesheet_pk   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( project_invoice_timesheets.timesheet_pk   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001) )  / (1/1000*1.0) AS FLOAT64), 0), 6) AS project_invoice_timesheets_total_timesheet_hours_billed
FROM `analytics.companies_dim` AS companies_dim
LEFT JOIN `analytics.timesheet_projects_dim`
     AS projects_delivered ON companies_dim.company_pk = projects_delivered.company_pk
LEFT JOIN `analytics.invoices_fact`
     AS projects_invoiced ON projects_delivered.timesheet_project_pk = projects_invoiced.timesheet_project_pk
LEFT JOIN `analytics.timesheets_fact`
     AS project_invoice_timesheets ON projects_delivered.timesheet_project_pk = project_invoice_timesheets.timesheet_project_pk
LEFT JOIN `analytics.timesheets_fact`
     AS project_timesheets ON projects_delivered.timesheet_project_pk = project_timesheets.timesheet_project_pk
LEFT JOIN `analytics.timesheet_projects_dim`
     AS project_timesheet_projects ON project_timesheets.timesheet_project_pk = project_timesheet_projects.timesheet_project_pk
WHERE (project_timesheet_projects.project_is_billable )
GROUP BY
    1,
    2
),
attributed_revenue_detail as (
select t.project_timesheet_projects_project_delivery_start_ts_month,
t.project_timesheet_projects_project_code,
t.project_timesheet_users_contact_name,
t.project_timesheets_total_timesheet_hours_billed,
r.project_invoice_timesheets_total_timesheet_hours_billed,
r.projects_invoiced_invoice_gbp_revenue_amount,
r.projects_invoiced_invoice_gbp_revenue_amount * (t.project_timesheets_total_timesheet_hours_billed / r.project_invoice_timesheets_total_timesheet_hours_billed ) as attributed_invoice_gbp_revenue
from timesheet_hours t
left join revenue r
on t.project_timesheet_projects_project_code = r.project_timesheet_projects_project_code
and t.project_timesheet_projects_project_delivery_start_ts_month = r.projects_invoiced_invoice_month),
consultant_attributed_revenue as (
select project_timesheet_users_contact_name as consultant_name,
       project_timesheet_projects_project_delivery_start_ts_month as billing_month,
       sum(attributed_invoice_gbp_revenue) as total_attributed_revenue
from attributed_revenue_detail
group by 1,2),
consultant_fully_loaded_cost as (
SELECT
    (FORMAT_TIMESTAMP('%Y-%m', CAST(scv.date  AS TIMESTAMP))) AS billing_month,
    scv.description  AS consultant_name,
    COALESCE(SUM(case when scv.account_code = '478' then scv.amount+3500
         when scv.account_code = '320' and scv.amount > 800 then (scv.amount * 1.11) + 109
         else scv.amount end ), 0) AS total_fully_loaded_cost
FROM `ra-development.xero_reports.scv`
     AS scv
GROUP BY
    1,
    2
)
select c.billing_month,
       c.consultant_name,
        coalesce(total_attributed_revenue,0) as total_attributed_revenue,
        coalesce(total_fully_loaded_cost,0) as total_fully_loaded_cost,
        coalesce(total_attributed_revenue,0) - coalesce(
            total_fully_loaded_cost,0)  as total_gross_margin_contribution,
safe_divide(coalesce(total_attributed_revenue,0),coalesce(
            total_fully_loaded_cost,0)) as consultant_margin
from consultant_fully_loaded_cost c
left join consultant_attributed_revenue r
on r.consultant_name = c.consultant_name
and r.billing_month = c.billing_month ;;
  }



  dimension: consultant_name {
    type: string
    sql: ${TABLE}.consultant_name ;;
  }

  dimension_group: billing_month {
    timeframes: [month,quarter]
    type: time
    sql: parse_timestamp('%Y-%m',${TABLE}.billing_month) ;;
  }

  measure: total_attributed_revenue {
    value_format_name: gbp
    type: sum
    sql: ${TABLE}.total_attributed_revenue ;;
  }

  measure: total_fully_loaded_cost {
    value_format_name: gbp

    type: sum
    sql: ${TABLE}.total_fully_loaded_cost ;;
  }

  measure: total_gross_margin_contribution {
    value_format_name: gbp

    type: average
    sql: ${TABLE}.total_gross_margin_contribution ;;
  }

  measure: consultant_margin {
    value_format_name: percent_0
    type: sum
    sql: ${TABLE}.consultant_margin ;;
  }

  set: detail {
    fields: [
      consultant_name,
      total_attributed_revenue,
      total_fully_loaded_cost,
      total_gross_margin_contribution,
      consultant_margin
    ]
  }
}
