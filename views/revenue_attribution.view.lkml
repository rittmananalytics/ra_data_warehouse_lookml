view: revenue_attribution {
  derived_table: {
    sql: WITH contacts_dim AS (SELECT
  ct.*,
  hb.contact_id as hubspot_contact_id,
  ce.contact_email as contact_email,

  c.company_pk
FROM (
  SELECT
    *
  FROM
    `analytics.contacts_dim`,
    UNNEST( all_contact_company_ids) AS company_id  ) ct
JOIN (
  SELECT
    *
  FROM
    `analytics.companies_dim` c,
    UNNEST (all_company_ids) AS company_id ) c
ON
  ct.company_id = c.company_id
LEFT JOIN
  (SELECT
    contact_pk,
    contact_id
   FROM `analytics.contacts_dim`,
   UNNEST( all_contact_ids) as contact_id
   WHERE
    contact_id like '%hubspot%' ) hb
ON ct.contact_pk = hb.contact_pk
LEFT JOIN
  (SELECT
    contact_pk,
    contact_email
   FROM `analytics.contacts_dim`,
   UNNEST( all_contact_emails ) as contact_email
    ) ce
ON ct.contact_pk = ce.contact_pk
WHERE
  ct.company_id = c.company_id ),
basic_numbers as (
SELECT
    projects_delivered_project_code as project_code,
    projects_invoiced_invoice_month as invoice_month,
    project_timesheet_users_contact_name as consultant_name,
    projects_invoiced_invoice_gbp_revenue_amount as revenue,
    project_timesheets_total_timesheet_hours_billed as hours_billed,
    project_timesheets_total_timesheet_cost_amount as cost_amount
FROM
    (SELECT
            case projects_delivered.project_code
              when 'LOOKREF5' then 'KAP002'
              when 'LOOKREF2' then 'SWITCH03'
              when 'LOOKREF3' then 'BIL001'
              when 'LOOKREF4' then 'LIK001'
              when 'LOOKREF1' then 'YXPV-001'
              when 'KAPFIVETRAN' then 'KAP001'
              when 'LICKFIVETRAN' then 'LIK001'
              else projects_delivered.project_code end
            AS projects_delivered_project_code,
                (FORMAT_TIMESTAMP('%Y-%m', projects_invoiced.invoice_created_at_ts )) AS projects_invoiced_invoice_month,
            project_timesheet_users.contact_name  AS project_timesheet_users_contact_name,
            ROUND(COALESCE(CAST( ( SUM(DISTINCT (CAST(ROUND(COALESCE( case when projects_invoiced.invoice_currency = 'USD' then projects_invoiced.invoice_local_total_revenue_amount * .75
              when projects_invoiced.invoice_currency = 'CAD' then projects_invoiced.invoice_local_total_revenue_amount * .58
              when projects_invoiced.invoice_currency = 'EUR' then projects_invoiced.invoice_local_total_revenue_amount * .90
              else projects_invoiced.invoice_local_total_revenue_amount end ,0)*(1/1000*1.0), 9) AS NUMERIC) + (cast(cast(concat('0x', substr(to_hex(md5(CAST( projects_invoiced.invoice_pk   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( projects_invoiced.invoice_pk   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001 )) - SUM(DISTINCT (cast(cast(concat('0x', substr(to_hex(md5(CAST( projects_invoiced.invoice_pk   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( projects_invoiced.invoice_pk   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001) )  / (1/1000*1.0) AS FLOAT64), 0), 6) AS projects_invoiced_invoice_gbp_revenue_amount,
            ROUND(COALESCE(CAST( ( SUM(DISTINCT (CAST(ROUND(COALESCE( project_timesheets.timesheet_hours_billed  ,0)*(1/1000*1.0), 9) AS NUMERIC) + (cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheets.timesheet_pk   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheets.timesheet_pk   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001 )) - SUM(DISTINCT (cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheets.timesheet_pk   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheets.timesheet_pk   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001) )  / (1/1000*1.0) AS FLOAT64), 0), 6) AS project_timesheets_total_timesheet_hours_billed,
            ROUND(COALESCE(CAST( ( SUM(DISTINCT (CAST(ROUND(COALESCE( case when  project_timesheet_projects.project_fee_amount   = 7000 then 5000
              when  project_timesheet_projects.project_fee_amount   = 5500 then 4000
              when  project_timesheet_projects.project_fee_amount   = 5800 then 5000
              when  project_timesheet_projects.project_fee_amount   = 13620 then 9900
              when  project_timesheet_projects.project_fee_amount   = 9625 then 7000
              else  project_timesheet_projects.project_fee_amount   end ,0)*(1/1000*1.0), 9) AS NUMERIC) + (cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheet_projects.timesheet_project_pk   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheet_projects.timesheet_project_pk   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001 )) - SUM(DISTINCT (cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheet_projects.timesheet_project_pk   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheet_projects.timesheet_project_pk   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001) )  / (1/1000*1.0) AS FLOAT64), 0), 6) AS project_timesheet_projects_total_project_fee_amount,
               ROUND(COALESCE(CAST( ( SUM(DISTINCT (CAST(ROUND(COALESCE( project_timesheets.timesheet_hours_billed * coalesce(case when project_timesheets.timesheet_billable_hourly_cost_amount > 60 then 32 else project_timesheets.timesheet_billable_hourly_cost_amount end,25)  ,0)*(1/1000*1.0), 9) AS NUMERIC) + (cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheets.timesheet_pk   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheets.timesheet_pk   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001 )) - SUM(DISTINCT (cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheets.timesheet_pk   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheets.timesheet_pk   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001) )  / (1/1000*1.0) AS FLOAT64), 0), 6) AS project_timesheets_total_timesheet_cost_amount
        FROM `analytics.companies_dim` AS companies_dim
LEFT JOIN `analytics.timesheet_projects_dim`
     AS projects_delivered ON companies_dim.company_pk = projects_delivered.company_pk
LEFT JOIN `analytics.invoices_fact`
     AS projects_invoiced ON projects_delivered.timesheet_project_pk = projects_invoiced.timesheet_project_pk
LEFT JOIN `analytics.timesheets_fact`
     AS project_timesheets ON projects_delivered.timesheet_project_pk = project_timesheets.timesheet_project_pk
                           AND date_trunc(projects_invoiced.invoice_created_at_ts,MONTH) = date_trunc(project_timesheets.timesheet_billing_date,MONTH)
LEFT JOIN `analytics.timesheet_projects_dim`
     AS project_timesheet_projects ON project_timesheets.timesheet_project_pk = project_timesheet_projects.timesheet_project_pk
LEFT JOIN contacts_dim AS project_timesheet_users ON project_timesheets.contact_pk  = project_timesheet_users.contact_pk
        where projects_delivered.project_code is not null
        GROUP BY
            1,
            2,
            3
        HAVING NOT (( project_timesheet_projects_total_project_fee_amount ) IS NULL)) AS t3),
project_attributed_revenue as (
select * except (revenue),
       sum(distinct revenue) over (partition by project_code) as total_project_revenue,

       sum(hours_billed) over (partition by project_code) as project_hours_billed,
       safe_divide(hours_billed,sum(hours_billed) over (partition by project_code)) as consultant_pct_project_hours_billed,
       sum(distinct revenue) over (partition by project_code) * safe_divide(hours_billed,sum(hours_billed) over (partition by project_code)) as consultant_attributed_revenue,
from basic_numbers
where revenue >0),
monthly_project_totals as (
select invoice_month, project_code, consultant_name,  sum(consultant_attributed_revenue) as attributed_revenue
from project_attributed_revenue
where consultant_name is not null
group by 1,2,3),
consultant_monthly_totals as (
select invoice_month, consultant_name, sum(attributed_revenue) as attributed_revenue
from monthly_project_totals
group by 1,2
order by 1,2)
select * from monthly_project_totals ;;
  }
dimension: invoice_month {}
dimension: project_code {}
dimension: consultant_name {}
measure: attributed_revenue {
  type: sum
}
}
