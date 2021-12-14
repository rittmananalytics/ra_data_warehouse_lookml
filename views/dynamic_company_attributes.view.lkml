view: dynamic_company_attributes {
  derived_table: {
    sql: with metrics as (SELECT
          companies_dim.company_pk  AS company_pk,
          COALESCE(SUM(case when lower(projects_invoiced.invoice_status) in ('open','paid') then case when projects_invoiced.invoice_currency = 'USD' then projects_invoiced.invoice_local_total_revenue_amount * 0.73
          when projects_invoiced.invoice_currency = 'CAD' then projects_invoiced.invoice_local_total_revenue_amount * 0.57
          when projects_invoiced.invoice_currency = 'EUR' then projects_invoiced.invoice_local_total_revenue_amount * 0.85
          else projects_invoiced.invoice_local_total_revenue_amount   end end), 0) AS customer_ltv,
          COUNT(DISTINCT projects_delivered.timesheet_project_pk ) AS total_projects,
          COUNT(DISTINCT projects_invoiced.invoice_pk ) AS total_invoices,
          COUNT(DISTINCT ( FORMAT_TIMESTAMP('%Y-%m', projects_invoiced.invoice_issue_at_ts ) ) ) AS projects_invoiced_customer_total_active_months,
          MAX(projects_invoiced.months_since_first_invoice ) AS projects_invoiced_total_months_customer
      FROM `analytics.companies_dim` AS companies_dim
      LEFT JOIN `analytics.timesheet_projects_dim`
           AS projects_delivered ON companies_dim.company_pk = projects_delivered.company_pk
      LEFT JOIN `analytics.invoices_fact`
           AS projects_invoiced ON projects_delivered.timesheet_project_pk = projects_invoiced.timesheet_project_pk
      WHERE (projects_invoiced.invoice_status ) IN ('Open', 'Paid')
      and {% condition projects_invoiced.invoice_date %} projects_invoiced.invoice_sent_at_ts   {% endcondition %}
      GROUP BY
          1),
      pct_of_revenue as (
            SELECT
              *,
              round((row_number() over (order by customer_ltv)/count(distinct company_pk) over ())*100) as pct_of_customers,
              round((percent_rank() over (order by customer_ltv))*100) as pct_of_revenue,
              ntile(10) over (order by customer_ltv) as customer_ltv_decile,
              ntile(10) over (order by total_projects) as total_projects_decile,
              ntile(10) over (order by total_invoices) as total_invoices_decile
            FROM metrics
          )
     select *
     from pct_of_revenue;;
  }



  dimension: company_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension: customer_ltv {
    group_label: "    Company Metrics"

    type: number
    sql: ${TABLE}.customer_ltv ;;
  }

  dimension: customer_ltv_tier {
    group_label: "    Company Metrics"

    type: tier
    tiers: [5000,10000,20000,50000,100000]
    style: integer
    sql: ${TABLE}.customer_ltv ;;
  }

  dimension: total_projects {
    group_label: "    Company Metrics"

    type: number
    sql: ${TABLE}.total_projects ;;
  }

  dimension: total_paid_open_invoices {
    group_label: "    Company Metrics"

    type: number
    sql: ${TABLE}.total_invoices ;;
  }

  dimension: total_active_months {
    group_label: "    Company Metrics"

    type: number
    sql: ${TABLE}.projects_invoiced_customer_total_active_months ;;
  }

  dimension: total_months_customer {
    group_label: "    Company Metrics"

    type: number
    sql: ${TABLE}.projects_invoiced_total_months_customer ;;
  }

  dimension: customer_ltv_decile {
    type: number
    group_label: "    Company Metrics"
    sql: ${TABLE}.customer_ltv_decile ;;

  }

  dimension: total_invoices_decile {
    type: number
    group_label: "    Company Metrics"
    sql: ${TABLE}.total_invoices_decile ;;

  }

  dimension: total_projects_decile {
    type: number
    group_label: "    Company Metrics"
    sql: ${TABLE}.total_projects_decile ;;

  }

  dimension: pct_of_revenue {
    type: tier
    tiers:  [10,20,30,40,50,60,70,80,90,100]
    style: integer
    group_label: "    Company Metrics"
    sql: ${TABLE}.pct_of_revenue ;;
  }

  dimension: pct_of_customers {
    type: tier
    tiers: [10,20,30,40,50,60,70,80,90,100]
    style: integer
    group_label: "    Company Metrics"

    sql: ${TABLE}.pct_of_customers ;;
  }


}
