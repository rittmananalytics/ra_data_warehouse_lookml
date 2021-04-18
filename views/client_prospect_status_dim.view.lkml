view: client_prospect_status_dim {
  derived_table: {
    sql: with company_metrics as (SELECT
          companies_dim.company_pk  AS company_pk,
          companies_dim.company_name,
          COUNT(DISTINCT projects_delivered.timesheet_project_pk ) AS count_timesheet_projects,
          COUNT(DISTINCT deals_fact.deal_pk ) AS count_deals,
          COUNT(DISTINCT case when deals_fact.pipeline_stage_display_order = 10  then  deals_fact.deal_pk end) AS closed_lost_deals,
          COUNT(DISTINCT case when deals_fact.pipeline_stage_closed_won  then deals_fact.deal_pk end) AS closed_won_deals
      FROM `analytics.companies_dim` AS companies_dim
      LEFT JOIN `analytics.timesheet_projects_dim`
           AS projects_delivered ON companies_dim.company_pk = projects_delivered.company_pk
      LEFT JOIN `analytics.timesheets_fact`
           AS project_timesheets ON projects_delivered.timesheet_project_pk = project_timesheets.timesheet_project_pk
      LEFT JOIN `analytics.timesheet_projects_dim`
           AS project_timesheet_projects ON project_timesheets.timesheet_project_pk = project_timesheet_projects.timesheet_project_pk
      FULL OUTER JOIN `analytics.deals_fact` AS deals_fact ON companies_dim.company_pk = deals_fact.company_pk
      GROUP BY
          1,2)
      select company_pk,
             case when count_timesheet_projects = 1 or closed_won_deals = 1 and company_name not like '%Looker%' and company_name not like '%Segment%' then 'New Client'
                  when count_timesheet_projects > 2 and closed_won_deals > 1 and company_name not like '%Looker%' and company_name not like '%Segment%' then 'Repeat Client'
                  when count_timesheet_projects = 0 and count_deals > closed_lost_deals then 'Prospect'
                  when count_timesheet_projects = 0 and count_deals > 0 and count_deals <= closed_lost_deals then 'Lost Prospect'
                  else 'None'
             end as client_status,
             case when count_timesheet_projects = 1 or closed_won_deals = 1 and company_name not like '%Looker%' and company_name not like '%Segment%' then true
                  when count_timesheet_projects > 2 and closed_won_deals > 1 and company_name not like '%Looker%' and company_name not like '%Segment%' then true
                  when count_timesheet_projects = 0 and count_deals > closed_lost_deals then false
                  when count_timesheet_projects = 0 and count_deals > 0 and count_deals <= closed_lost_deals then false
                  else false
             end as is_client,
             case when count_timesheet_projects = 1 or closed_won_deals = 1 and company_name not like '%Looker%' and company_name not like '%Segment%' then false
                  when count_timesheet_projects > 2 and closed_won_deals > 1 and company_name not like '%Looker%' and company_name not like '%Segment%' then false
                  when count_timesheet_projects = 0 and count_deals > closed_lost_deals then true
                  when count_timesheet_projects = 0 and count_deals > 0 and count_deals <= closed_lost_deals then true
                  else false
             end as is_prospect
      from company_metrics
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: company_pk {
    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension: client_status {
    type: string
    sql: ${TABLE}.client_status ;;
  }

  dimension: is_client {
    type: yesno
    sql: ${TABLE}.is_client ;;
  }

  dimension: is_prospect {
    type: yesno
    sql: ${TABLE}.is_prospect ;;
  }

  set: detail {
    fields: [company_pk, client_status, is_client, is_prospect]
  }
}
