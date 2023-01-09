view: client_concentration {
  derived_table: {
    sql: SELECT
        *
      FROM (
        SELECT
          invoice_month,
          case when rank() over (partition by invoice_month order by invoice_gbp_revenue_amount) = 1 then safe_divide(invoice_gbp_revenue_amount,sum(invoice_gbp_revenue_amount) over (partition by invoice_month)) end as customer_concentration
        FROM (
          SELECT
          companies_dim.company_pk  AS company_pk,
              timestamp(DATE_TRUNC(date(projects_invoiced.invoice_sent_at_ts),MONTH)) AS invoice_month,
          COALESCE(SUM(case when lower(projects_invoiced.invoice_status) in ('open','paid') then case when projects_invoiced.invoice_currency = 'USD' then projects_invoiced.invoice_local_total_revenue_amount * 0.73
          when projects_invoiced.invoice_currency = 'CAD' then projects_invoiced.invoice_local_total_revenue_amount * 0.57
          when projects_invoiced.invoice_currency = 'EUR' then projects_invoiced.invoice_local_total_revenue_amount * 0.85
          else projects_invoiced.invoice_local_total_revenue_amount   end end), 0) AS invoice_gbp_revenue_amount,


      FROM `analytics.companies_dim` AS companies_dim
      LEFT JOIN `analytics.timesheet_projects_dim`
           AS projects_delivered ON companies_dim.company_pk = projects_delivered.company_pk
      LEFT JOIN `analytics.invoices_fact`
           AS projects_invoiced ON projects_delivered.timesheet_project_pk = projects_invoiced.timesheet_project_pk
      GROUP BY
          1,
          2))
      where customer_concentration is not null
       ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: [detail*]
  }

  dimension_group: invoice_month {
    hidden: yes

    type: time
    sql: ${TABLE}.invoice_month ;;
  }

  dimension: customer_concentration {
    hidden: yes

    type: number
    sql: ${TABLE}.customer_concentration ;;
  }

  set: detail {
    fields: [invoice_month_time, customer_concentration]
  }
}
