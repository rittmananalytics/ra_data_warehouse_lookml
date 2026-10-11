view: engagement_projects {
  derived_table: {
    sql: WITH ep AS (
        SELECT DISTINCT e.project_engagement_pk, e.engagement_code, e.company_fk, e.deal_id, e.deal_name,
               TIMESTAMP(e.engagement_start_ts) AS engagement_start_ts, TIMESTAMP(e.engagement_end_ts) AS engagement_end_ts,
               p.timesheet_project_pk
        FROM `ra-development.analytics.timesheet_project_engagements_dim` e, UNNEST(e.projects) AS p
      ),
      fin AS (
        SELECT timesheet_project_pk,
               SUM(consultant_hours_billed) AS hours_billed,
               SUM(consultant_recognized_revenue_gbp) AS recognized_revenue_gbp,
               SUM(consultant_delivery_labour_cost_gbp) AS delivery_labour_cost_gbp
        FROM `ra-development.analytics.recognized_revenue_fact`
        GROUP BY 1
      ),
      exp AS (
        -- expenses are spread per project month and repeated on every consultant row: counted once per project month (LookML sum_distinct)
        SELECT timesheet_project_pk, SUM(total_expense_cost_gbp) AS expense_cost_gbp
        FROM (SELECT DISTINCT timesheet_project_pk, billing_month, total_expense_cost_gbp FROM `ra-development.analytics.recognized_revenue_fact`)
        GROUP BY 1
      ),
      ontime_rows AS (
      SELECT
                --companies_dim_company_name,
                projects_delivered_timesheet_project_pk,
                --projects_delivered_project_name,
                --projects_delivered_project_delivery_start_ts_date,
                --projects_delivered_project_delivery_end_ts_date,
                --projects_delivered_project_delivery_end_ts_month,
                --projects_invoiced_invoice_date,
                    --(DATE(mf0b5f3c7bbfa__project_timesheets_last_timesheet_billing_date)) AS project_timesheets_last_timesheet_billing_date,
                date_diff(date(mf0b5f3c7bbfa__project_timesheets_last_timesheet_billing_date),projects_delivered_project_delivery_end_ts_date,DAY) <= 0 as is_ontime_project
            FROM
                (SELECT
                        projects_delivered.timesheet_project_pk  AS projects_delivered_timesheet_project_pk,
                            (DATE(timestamp(projects_delivered.project_delivery_end_ts) )) AS projects_delivered_project_delivery_end_ts_date,
                            (FORMAT_TIMESTAMP('%Y-%m', timestamp(projects_delivered.project_delivery_end_ts) )) AS projects_delivered_project_delivery_end_ts_month,
                            (DATE(timestamp(projects_delivered.project_delivery_start_ts) )) AS projects_delivered_project_delivery_start_ts_date,
                        projects_delivered.project_name  AS projects_delivered_project_name,
                        case when companies_dim.company_name = 'indexlabs.co.uk' then 'Football Index' else companies_dim.company_name end AS companies_dim_company_name,
                            (DATE(projects_invoiced.invoice_sent_at_ts )) AS projects_invoiced_invoice_date,
                        MAX(project_timesheets.timesheet_billing_date ) AS mf0b5f3c7bbfa__project_timesheets_last_timesheet_billing_date,
                        COUNT(DISTINCT companies_dim.company_pk ) AS companies_dim_count,
                        ROUND(COALESCE(CAST( ( SUM(DISTINCT (CAST(ROUND(COALESCE( coalesce(project_timesheets.timesheet_hours_billed,0)  ,0)*(1/1000*1.0), 9) AS NUMERIC) + (cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheets.timesheet_pk   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheets.timesheet_pk   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001 )) - SUM(DISTINCT (cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheets.timesheet_pk   AS STRING))), 1, 15)) as int64) as numeric) * 4294967296 + cast(cast(concat('0x', substr(to_hex(md5(CAST( project_timesheets.timesheet_pk   AS STRING))), 16, 8)) as int64) as numeric)) * 0.000000001) )  / (1/1000*1.0) AS FLOAT64), 0), 6) AS project_timesheets_total_timesheet_hours_billed
                    FROM `ra-development.analytics.timesheet_projects_dim`
                 AS projects_delivered
            LEFT JOIN `ra-development.analytics.timesheets_fact`
                 AS project_timesheets ON projects_delivered.timesheet_project_pk = project_timesheets.timesheet_project_fk
            LEFT JOIN `ra-development.analytics.companies_dim` AS companies_dim ON projects_delivered.company_fk = companies_dim.company_pk
            LEFT JOIN `ra-development.analytics.invoices_fact`
                 AS projects_invoiced ON projects_delivered.timesheet_project_pk = projects_invoiced.timesheet_project_fk
      
            GROUP BY
            1,
            2,
            3,
            4,
            5,
            6,
            7
            HAVING project_timesheets_total_timesheet_hours_billed > 0) AS t3
      ),
      ontime AS (
        -- the Looker derived table keeps one row per project and invoice date; one flag per project here
        SELECT projects_delivered_timesheet_project_pk, LOGICAL_AND(is_ontime_project) AS is_ontime_project
        FROM ontime_rows GROUP BY 1
      )
      SELECT ep.*,
             CONCAT(ep.project_engagement_pk, '|', ep.timesheet_project_pk) AS pk,
             tp.project_name,
             TIMESTAMP(tp.project_delivery_start_ts) AS project_delivery_start_ts,
             TIMESTAMP(tp.project_delivery_end_ts) AS project_delivery_end_ts,
             tp.project_budget_amount AS project_hours_budget_amount,
             tp.project_fee_amount,
             COALESCE(ontime.is_ontime_project, FALSE) AS is_ontime_project,
             fin.hours_billed, fin.recognized_revenue_gbp, fin.delivery_labour_cost_gbp, exp.expense_cost_gbp,
             LEAST(1, SAFE_DIVIDE(DATE_DIFF(CURRENT_DATE(), DATE(ep.engagement_start_ts), DAY), DATE_DIFF(DATE(ep.engagement_end_ts), DATE(ep.engagement_start_ts), DAY))) AS duration_elapsed_pct
      FROM ep
      LEFT JOIN `ra-development.analytics.timesheet_projects_dim` tp ON tp.timesheet_project_pk = ep.timesheet_project_pk
      LEFT JOIN fin ON fin.timesheet_project_pk = ep.timesheet_project_pk
      LEFT JOIN exp ON exp.timesheet_project_pk = ep.timesheet_project_pk
      LEFT JOIN ontime ON ontime.projects_delivered_timesheet_project_pk = ep.timesheet_project_pk ;;
  }
  label: "Engagement Projects"

  dimension: company_fk {
    hidden: yes
    sql: ${TABLE}.company_fk ;;
  }

  dimension: deal_id {
    hidden: yes
    sql: ${TABLE}.deal_id ;;
  }

  dimension: deal_name {
    hidden: yes
    sql: ${TABLE}.deal_name ;;
  }

  dimension: delivery_labour_cost_gbp {
    hidden: yes
    sql: ${TABLE}.delivery_labour_cost_gbp ;;
  }

  dimension: duration_elapsed_pct {
    type: number
    label: "% Duration Elapsed"
    group_label: "Engagement Details"
    description: "Days from engagement start to today over days from start to end, capped at 100% (Looker tile calculation duration_elapsed)"
    value_format_name: percent_0
    sql: ${TABLE}.duration_elapsed_pct ;;
  }

  dimension: engagement_code {
    group_label: "Engagement Details"
    sql: ${TABLE}.engagement_code ;;
  }

  dimension: expense_cost_gbp {
    hidden: yes
    sql: ${TABLE}.expense_cost_gbp ;;
  }

  dimension: hours_billed {
    hidden: yes
    sql: ${TABLE}.hours_billed ;;
  }

  dimension: is_ontime_project {
    type: yesno
    label: "Is Ontime Project"
    group_label: "Project Details"
    description: "Last timesheet billed on or before the project's delivery end date (projects_delivered_is_ontime); a project with no timesheets is No, as Looker's yesno renders null"
    sql: ${TABLE}.is_ontime_project ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.pk ;;
  }

  dimension: project_engagement_pk {
    hidden: yes
    sql: ${TABLE}.project_engagement_pk ;;
  }

  dimension: project_fee_amount {
    hidden: yes
    sql: ${TABLE}.project_fee_amount ;;
  }

  dimension: project_hours_budget_amount {
    hidden: yes
    sql: ${TABLE}.project_hours_budget_amount ;;
  }

  dimension: project_name {
    label: "Project Name"
    group_label: "Project Details"
    sql: ${TABLE}.project_name ;;
  }

  dimension: recognized_revenue_gbp {
    hidden: yes
    sql: ${TABLE}.recognized_revenue_gbp ;;
  }

  dimension: timesheet_project_pk {
    hidden: yes
    sql: ${TABLE}.timesheet_project_pk ;;
  }

  dimension_group: engagement_end_ts {
    type: time
    timeframes: [raw, date, month, year]
    hidden: yes
    sql: ${TABLE}.engagement_end_ts ;;
  }

  dimension_group: engagement_start_ts {
    type: time
    timeframes: [raw, date, month, year]
    hidden: yes
    sql: ${TABLE}.engagement_start_ts ;;
  }

  dimension_group: project_delivery_end_ts {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    label: "Project End"
    group_label: "Project Details"
    sql: ${TABLE}.project_delivery_end_ts ;;
  }

  dimension_group: project_delivery_start_ts {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    label: "Project Start"
    group_label: "Project Details"
    sql: ${TABLE}.project_delivery_start_ts ;;
  }

  measure: count_ontime_projects {
    type: count_distinct
    label: "Total Ontime Project Deliveries"
    group_label: "Project Details"
    sql: ${timesheet_project_pk} ;;
    filters: [is_ontime_project: "Yes"]
  }

  measure: count_projects {
    type: count_distinct
    label: "Count of Project Name"
    group_label: "Project Details"
    sql: ${project_name} ;;
  }

  measure: hourly_rate_to_date {
    type: number
    label: "Hourly Rate To-Date"
    description: "Recognised revenue per hour billed (Looker tile calculation hourly_rate_to_date)"
    value_format_name: gbp_0
    sql: safe_divide(${total_recognized_revenue_gbp}, ${total_hours_billed}) ;;
  }

  measure: hourly_rate_vs_budget_pct {
    type: number
    label: "Hourly Rate / Budget %"
    description: "Hourly rate over the 176 GBP budget rate fixed in the Looker tile calculation hourly_rate_budget"
    value_format_name: percent_0
    sql: ${hourly_rate_to_date} / 176 ;;
  }

  measure: hours_budget_to_date {
    type: number
    label: "Hours Budget To-Date"
    description: "Project hours budget x % duration elapsed (Looker tile calculation hours_budget_to_date)"
    value_format_name: decimal_0
    sql: SUM(${project_hours_budget_amount} * ${duration_elapsed_pct}) ;;
  }

  measure: hours_vs_budget_pct {
    type: number
    label: "Hours / Budget %"
    description: "Hours billed over the hours budget to date (Looker tile calculation hours_budget)"
    value_format_name: percent_0
    sql: safe_divide(${total_hours_billed}, ${hours_budget_to_date}) ;;
  }

  measure: project_hours_budget {
    type: sum
    label: "Project Hours Budget"
    group_label: "Project Commercials"
    value_format_name: decimal_0
    sql: ${project_hours_budget_amount} ;;
  }

  measure: project_margin_pct {
    type: number
    label: "Project Margin %"
    description: "(recognised revenue - delivery cost) / recognised revenue (Looker tile calculation project_margin)"
    value_format_name: percent_1
    sql: safe_divide(${total_recognized_revenue_gbp} - ${total_delivery_cost_gbp}, ${total_recognized_revenue_gbp}) ;;
  }

  measure: recognized_margin_gbp {
    type: number
    label: "Recognized Margin GBP"
    group_label: "Recognised Revenue"
    value_format_name: gbp_0
    sql: coalesce(${total_recognized_revenue_gbp},0) - ${total_delivery_cost_gbp} ;;
  }

  measure: revenue_per_budget_hour {
    type: number
    label: "Avg. Hourly Rate (per budget hour)"
    description: "Recognised revenue over the hours budget to date, as the Looker KPI tile 3897 computes it"
    value_format_name: gbp_0
    sql: safe_divide(${total_recognized_revenue_gbp}, ${hours_budget_to_date}) ;;
  }

  measure: total_delivery_cost_gbp {
    type: number
    label: "Total Delivery Cost GBP"
    group_label: "Recognised Revenue"
    value_format_name: gbp_0
    sql: coalesce(${total_delivery_labour_cost_gbp},0) + coalesce(${total_expense_cost_gbp},0) ;;
  }

  measure: total_delivery_labour_cost_gbp {
    type: sum
    label: "Total Delivery Labour Cost GBP"
    group_label: "Recognised Revenue"
    value_format_name: gbp_0
    sql: ${delivery_labour_cost_gbp} ;;
  }

  measure: total_expense_cost_gbp {
    type: sum
    label: "Total Expense Cost GBP"
    group_label: "Recognised Revenue"
    value_format_name: gbp_0
    sql: ${expense_cost_gbp} ;;
  }

  measure: total_hours_billed {
    type: sum
    label: "Total Hours Billed"
    group_label: "Recognised Revenue"
    value_format_name: decimal_0
    sql: ${hours_billed} ;;
  }

  measure: total_project_fee_amount {
    type: sum
    label: "Total Project Fee Amount GBP"
    group_label: "Project Commercials"
    value_format_name: gbp_0
    sql: ${project_fee_amount} ;;
  }

  measure: total_recognized_revenue_gbp {
    type: sum
    label: "Total Recognized Revenue GBP"
    group_label: "Recognised Revenue"
    value_format_name: gbp_0
    sql: ${recognized_revenue_gbp} ;;
  }
}
