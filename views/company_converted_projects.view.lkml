view: company_converted_projects {
  derived_table: {
    sql: with project_counts as (SELECT
          companies_dim.company_pk  AS company_pk,
          COUNT(DISTINCT CASE WHEN ( projects_delivered.project_name like '%Discovery%') THEN projects_delivered.timesheet_project_pk  ELSE NULL END) AS count_discovery_projects,
          COUNT(DISTINCT CASE WHEN ( projects_delivered.project_name like '%Jumpstart%' or projects_delivered.project_name like '%Quickstart%' or projects_delivered.project_name like '%Jump Start%' or projects_delivered.project_name like '%- Looker Consulting%' or projects_delivered.project_name like '%- Looker Embed%') THEN projects_delivered.timesheet_project_pk  ELSE NULL END) AS count_jumpstart_projects,
          COUNT(DISTINCT CASE WHEN (NOT COALESCE(( projects_delivered.project_name like '%Discovery%' ), FALSE)) AND (NOT COALESCE(( projects_delivered.project_name like '%Jumpstart%' or projects_delivered.project_name like '%Jump Start%' or projects_delivered.project_name like '%- Looker Consulting%' or projects_delivered.project_name like '%- Looker Embed%' or projects_delivered.project_name like '%Quickstart%' ), FALSE)) THEN projects_delivered.timesheet_project_pk  ELSE NULL END) AS count_implementation_projects,

      FROM `analytics.companies_dim`  AS companies_dim
      LEFT JOIN `analytics.timesheet_projects_dim`
           AS projects_delivered ON companies_dim.company_pk = projects_delivered.company_fk
      LEFT JOIN `analytics.invoices_fact`
           AS projects_invoiced ON projects_delivered.timesheet_project_pk = projects_invoiced.timesheet_project_fk
      WHERE ((( projects_invoiced.first_invoice_month  ) IS NOT NULL))
      GROUP BY
          1)
      select *,
      case when count_discovery_projects>0 AND count_implementation_projects>0 then 'Discovery Converted'
      when count_jumpstart_projects>0 AND count_implementation_projects>0 then 'Jumpstart Converted'
      when count_discovery_projects>0 AND count_implementation_projects=0 then 'Discovery Unconverted'
      when count_jumpstart_projects>0 AND count_implementation_projects=0 then 'Jumpstart Unconverted'
      when count_implementation_projects > 0 then 'Implementation Only'
      else null end as conversion_status
      from project_counts ;;
  }



  dimension: company_pk {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.company_pk ;;
  }

  measure: count_project_clients {
    type: count_distinct
    hidden: yes
  }

  measure: count_discovery_conversions {
    type: count_distinct
    sql: ${company_pk} ;;
    filters: [conversion_status: "Discovery Converted"]
  }

  measure: count_jumpstart_conversions {
    type: count_distinct
    sql: ${company_pk} ;;
    filters: [conversion_status: "Jumpstart Converted"]
  }

  measure: count_potential_discovery_conversions {
    type: count_distinct
    sql: ${company_pk} ;;
    filters: [conversion_status: "Discovery Converted,Discovery Unconverted"]
  }

  measure: count_potential_jumpstart_conversions {
    type: count_distinct
    sql: ${company_pk} ;;
    filters: [conversion_status: "Jumpstart Converted,Jumpstart Unconverted"]
  }


  dimension: conversion_status {
    type: string
    sql: ${TABLE}.conversion_status ;;
  }


}
