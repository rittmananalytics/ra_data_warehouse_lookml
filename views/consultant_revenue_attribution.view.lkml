
view: consultant_revenue_attribution {
  derived_table: {
    sql: WITH staff_dim AS (SELECT contact_pk, contact_name, contact_is_contractor, contact_is_staff, contact_weekly_capacity, contact_default_hourly_rate, contact_cost_rate, contact_is_active, contact_created_date FROM `ra-development.analytics.contacts_dim`
            where contact_is_staff or contact_name = 'Rob Bramwell'
             ),
      staff_level as (
      SELECT
          t7.`__f1` AS timesheet_project_pk,
          t7.`__f7` AS timesheet_billing_ts,
          t7.`__f13` AS contact_pk,
          t7.`__f99` as contact_name,
          COALESCE(SUM(CASE WHEN CASE WHEN t7.groupingVal IN (0, 1, 2) THEN 0 ELSE 128 END + CASE WHEN t7.groupingVal IN (0, 1, 2) THEN 0 ELSE 64 END + CASE WHEN t7.groupingVal IN (0, 1, 2) THEN 0 ELSE 32 END + CASE WHEN t7.groupingVal IN (0, 1, 2) THEN 0 ELSE 16 END + CASE WHEN t7.groupingVal IN (0, 1, 2) THEN 0 ELSE 8 END + CASE WHEN t7.groupingVal = 0 THEN 0 ELSE 4 END + CASE WHEN t7.groupingVal = 1 THEN 0 ELSE 2 END + CASE WHEN t7.groupingVal = 2 THEN 0 ELSE 1 END = 3 AND t7.`__f10` > 0 THEN t7.`__f9` ELSE NULL END), 0) AS projects_delivered_total_project_fee_amount,
          COALESCE(SUM(CASE WHEN CASE WHEN t7.groupingVal IN (0, 1, 2) THEN 0 ELSE 128 END + CASE WHEN t7.groupingVal IN (0, 1, 2) THEN 0 ELSE 64 END + CASE WHEN t7.groupingVal IN (0, 1, 2) THEN 0 ELSE 32 END + CASE WHEN t7.groupingVal IN (0, 1, 2) THEN 0 ELSE 16 END + CASE WHEN t7.groupingVal IN (0, 1, 2) THEN 0 ELSE 8 END + CASE WHEN t7.groupingVal = 0 THEN 0 ELSE 4 END + CASE WHEN t7.groupingVal = 1 THEN 0 ELSE 2 END + CASE WHEN t7.groupingVal = 2 THEN 0 ELSE 1 END = 5 AND t7.`__f12` > 0 THEN t7.`__f11` ELSE NULL END), 0) AS project_timesheets_total_timesheet_billable_hours_billed,
          COALESCE(SUM(CASE WHEN CASE WHEN t7.groupingVal IN (0, 1, 2) THEN 0 ELSE 128 END + CASE WHEN t7.groupingVal IN (0, 1, 2) THEN 0 ELSE 64 END + CASE WHEN t7.groupingVal IN (0, 1, 2) THEN 0 ELSE 32 END + CASE WHEN t7.groupingVal IN (0, 1, 2) THEN 0 ELSE 16 END + CASE WHEN t7.groupingVal IN (0, 1, 2) THEN 0 ELSE 8 END + CASE WHEN t7.groupingVal = 0 THEN 0 ELSE 4 END + CASE WHEN t7.groupingVal = 1 THEN 0 ELSE 2 END + CASE WHEN t7.groupingVal = 2 THEN 0 ELSE 1 END = 5 AND t7.`__f14` > 0 THEN t7.`__f13_0` ELSE NULL END), 0) AS project_timesheets_total_timesheet_nonbillable_hours_billed,
          COALESCE(SUM(CASE WHEN CASE WHEN t7.groupingVal IN (0, 1, 2) THEN 0 ELSE 128 END + CASE WHEN t7.groupingVal IN (0, 1, 2) THEN 0 ELSE 64 END + CASE WHEN t7.groupingVal IN (0, 1, 2) THEN 0 ELSE 32 END + CASE WHEN t7.groupingVal IN (0, 1, 2) THEN 0 ELSE 16 END + CASE WHEN t7.groupingVal IN (0, 1, 2) THEN 0 ELSE 8 END + CASE WHEN t7.groupingVal = 0 THEN 0 ELSE 4 END + CASE WHEN t7.groupingVal = 1 THEN 0 ELSE 2 END + CASE WHEN t7.groupingVal = 2 THEN 0 ELSE 1 END = 5 AND t7.`__f16` > 0 THEN t7.`__f15` ELSE NULL END), 0) AS project_timesheets_total_timesheet_cost_amount_gbp,
          COALESCE(SUM(CASE WHEN CASE WHEN t7.groupingVal IN (0, 1, 2) THEN 0 ELSE 128 END + CASE WHEN t7.groupingVal IN (0, 1, 2) THEN 0 ELSE 64 END + CASE WHEN t7.groupingVal IN (0, 1, 2) THEN 0 ELSE 32 END + CASE WHEN t7.groupingVal IN (0, 1, 2) THEN 0 ELSE 16 END + CASE WHEN t7.groupingVal IN (0, 1, 2) THEN 0 ELSE 8 END + CASE WHEN t7.groupingVal = 0 THEN 0 ELSE 4 END + CASE WHEN t7.groupingVal = 1 THEN 0 ELSE 2 END + CASE WHEN t7.groupingVal = 2 THEN 0 ELSE 1 END = 6 AND t7.`__f18` > 0 THEN t7.`__f17` ELSE NULL END), 0) AS timesheet_project_costs_fact_total_cost_gbp
      FROM
          (SELECT
                  CASE WHEN t5.groupingVal IN (0, 1, 2) THEN t1.projects_delivered_project_pk ELSE NULL END AS `__f1`,
                      CASE WHEN t5.groupingVal IN (0, 1, 2) THEN t1.projects_delivered_project_delivery_start_ts_month ELSE NULL END AS `__f3`,
                      CASE WHEN t5.groupingVal IN (0, 1, 2) THEN t1.projects_delivered_project_name ELSE NULL END AS `__f5`,
                      CASE WHEN t5.groupingVal IN (0, 1, 2) THEN t1.project_timesheets_timesheet_billing_month ELSE NULL END AS `__f7`,
                      CASE WHEN t5.groupingVal IN (0, 1, 2) THEN t1.project_timesheet_users_contact_pk ELSE NULL END AS `__f13`,
                      CASE WHEN t5.groupingVal IN (0, 1, 2) THEN t1.project_timesheet_users_contact_name ELSE NULL END AS `__f99`,
                      CASE WHEN t5.groupingVal = 0 THEN t1.`__f24` ELSE NULL END AS `__f24`,
                      CASE WHEN t5.groupingVal = 1 THEN t1.`__f27` ELSE NULL END AS `__f27`,
                      CASE WHEN t5.groupingVal = 2 THEN t1.`__f33` ELSE NULL END AS `__f33`,
                  t5.groupingVal,
                  MIN(CASE WHEN t1.`__f23` THEN t1.projects_delivered_project_fee_amount ELSE NULL END) AS `__f9`,
                  COUNT(CASE WHEN t1.`__f23` THEN 1 ELSE NULL END) AS `__f10`,
                  MIN(CASE WHEN t1.`__f26` THEN t1.`__f25` ELSE NULL END) AS `__f11`,
                  COUNT(CASE WHEN t1.`__f26` THEN 1 ELSE NULL END) AS `__f12`,
                  MIN(CASE WHEN t1.`__f28` THEN t1.`__f25` ELSE NULL END) AS `__f13_0`,
                  COUNT(CASE WHEN t1.`__f28` THEN 1 ELSE NULL END) AS `__f14`,
                  MIN(CASE WHEN t1.`__f30` THEN t1.`__f29` ELSE NULL END) AS `__f15`,
                  COUNT(CASE WHEN t1.`__f30` THEN 1 ELSE NULL END) AS `__f16`,
                  MIN(CASE WHEN t1.`__f32` THEN t1.`__f31` ELSE NULL END) AS `__f17`,
                  COUNT(CASE WHEN t1.`__f32` THEN 1 ELSE NULL END) AS `__f18`
              FROM
                  (SELECT
                          projects_delivered.timesheet_project_pk  AS projects_delivered_project_pk,
                              timestamp(date_trunc(date(projects_delivered.project_delivery_start_ts),MONTH)) AS projects_delivered_project_delivery_start_ts_month,
                          projects_delivered.project_fee_amount  AS projects_delivered_project_fee_amount,
                          projects_delivered.project_name  AS projects_delivered_project_name,
                              (FORMAT_TIMESTAMP('%Y-%m', project_timesheets.timesheet_billing_date )) AS project_timesheets_timesheet_billing_month,
                          project_timesheets.contact_fk  AS project_timesheet_users_contact_pk,
                          contacts_dim.contact_name  AS project_timesheet_users_contact_name,
                              (projects_delivered.timesheet_project_pk ) IS NOT NULL AS `__f23`,
                          projects_delivered.timesheet_project_pk  AS `__f24`,
                          coalesce(project_timesheets.timesheet_hours_billed,0)  AS `__f25`,
                              CASE WHEN project_timesheets.timesheet_is_billable  THEN TRUE ELSE FALSE END AS `__f26`,
                          project_timesheets.timesheet_pk  AS `__f27`,
                              CASE WHEN NOT COALESCE( project_timesheets.timesheet_is_billable, FALSE) THEN TRUE ELSE FALSE END AS `__f28`,
                          coalesce(project_timesheets.timesheet_hours_billed * project_timesheets.timesheet_billable_hourly_cost_amount,0)  AS `__f29`,
                              (project_timesheets.timesheet_pk ) IS NOT NULL AS `__f30`,
                          coalesce(( timesheet_project_costs_fact.expense_amount_local / expenses_exchange_rates.CURRENCY_RATE ),0)  AS `__f31`,
                              (timesheet_project_costs_fact.expense_pk ) IS NOT NULL AS `__f32`,
                          timesheet_project_costs_fact.expense_pk  AS `__f33`
                      FROM `analytics.timesheet_projects_dim`
           AS projects_delivered
      LEFT JOIN `analytics.timesheets_fact`
           AS project_timesheets ON projects_delivered.timesheet_project_pk = project_timesheets.timesheet_project_fk
      LEFT JOIN  `analytics.contacts_dim`
           AS contacts_dim ON project_timesheets.contact_fk = contacts_dim.contact_pk
      LEFT JOIN `ra-development.analytics.timesheet_project_costs_fact`
           AS timesheet_project_costs_fact ON projects_delivered.timesheet_project_pk = timesheet_project_costs_fact.timesheet_project_fk
      LEFT JOIN `ra-development.analytics_seed.exchange_rates`
           AS expenses_exchange_rates ON timesheet_project_costs_fact.expense_currency_code = expenses_exchange_rates.CURRENCY_CODE
                      ) AS t1,
                      (SELECT
                              0 AS groupingVal
                          UNION ALL
                          SELECT
                              1 AS groupingVal
                          UNION ALL
                          SELECT
                              2 AS groupingVal) AS t5
              GROUP BY
                  CASE WHEN t5.groupingVal IN (0, 1, 2) THEN t1.projects_delivered_project_pk ELSE NULL END,
                  CASE WHEN t5.groupingVal IN (0, 1, 2) THEN t1.projects_delivered_project_delivery_start_ts_month ELSE NULL END,
                  CASE WHEN t5.groupingVal IN (0, 1, 2) THEN t1.projects_delivered_project_name ELSE NULL END,
                  CASE WHEN t5.groupingVal IN (0, 1, 2) THEN t1.project_timesheets_timesheet_billing_month ELSE NULL END,
                  CASE WHEN t5.groupingVal IN (0, 1, 2) THEN t1.project_timesheet_users_contact_pk ELSE NULL END,
                  CASE WHEN t5.groupingVal IN (0, 1, 2) THEN t1.project_timesheet_users_contact_name ELSE NULL END,
                  CASE WHEN t5.groupingVal = 0 THEN t1.`__f24` ELSE NULL END,
                  CASE WHEN t5.groupingVal = 1 THEN t1.`__f27` ELSE NULL END,
                  CASE WHEN t5.groupingVal = 2 THEN t1.`__f33` ELSE NULL END,
                  t5.groupingVal) AS t7
      GROUP BY
          1,
          2,
          3,
          4)
      SELECT * ,
        sum(case when contact_name like '%Lydia%' then project_timesheets_total_timesheet_billable_hours_billed * .56
                 when contact_name like '%Jordan%' then project_timesheets_total_timesheet_billable_hours_billed * .56
                 when contact_name like '%Amir%' then project_timesheets_total_timesheet_billable_hours_billed * .89
                 when contact_name like '%Abanoub%' then project_timesheets_total_timesheet_billable_hours_billed * .25
                 when contact_name like '%Jack%' then project_timesheets_total_timesheet_billable_hours_billed * .25
                 else project_timesheets_total_timesheet_billable_hours_billed end)
        over (partition by timesheet_project_pk) as total_project_timesheet_billable_hours_billed,
        case when contact_name like '%Lydia%' then project_timesheets_total_timesheet_billable_hours_billed * .56
                 when contact_name like '%Jordan%' then project_timesheets_total_timesheet_billable_hours_billed * .56
                 when contact_name like '%Amir%' then project_timesheets_total_timesheet_billable_hours_billed * .89
                when contact_name like '%Abanoub%' then project_timesheets_total_timesheet_billable_hours_billed * .25
                 when contact_name like '%Jack%' then project_timesheets_total_timesheet_billable_hours_billed * .25
                 else project_timesheets_total_timesheet_billable_hours_billed end/if(sum(case when contact_name like '%Lydia%' then project_timesheets_total_timesheet_billable_hours_billed * .56
                 when contact_name like '%Jordan%' then project_timesheets_total_timesheet_billable_hours_billed * .56
                 when contact_name like '%Amir%' then project_timesheets_total_timesheet_billable_hours_billed * .89
                when contact_name like '%Abanoub%' then project_timesheets_total_timesheet_billable_hours_billed * .25
                 when contact_name like '%Jack%' then project_timesheets_total_timesheet_billable_hours_billed * .25
                 else project_timesheets_total_timesheet_billable_hours_billed end) over (partition by timesheet_project_pk)=0,null,sum(case when contact_name like '%Lydia%' then project_timesheets_total_timesheet_billable_hours_billed * .56
                 when contact_name like '%Jordan%' then project_timesheets_total_timesheet_billable_hours_billed * .56
                 when contact_name like '%Amir%' then project_timesheets_total_timesheet_billable_hours_billed * .89
                when contact_name like '%Abanoub%' then project_timesheets_total_timesheet_billable_hours_billed * .25
                 when contact_name like '%Jack%' then project_timesheets_total_timesheet_billable_hours_billed * .25
                 else project_timesheets_total_timesheet_billable_hours_billed end) over (partition by timesheet_project_pk)) as pct_of_total_project_timesheet_billable_hours_billed,
        round(projects_delivered_total_project_fee_amount*(case when contact_name like '%Lydia%' then project_timesheets_total_timesheet_billable_hours_billed * .56
                 when contact_name like '%Jordan%' then project_timesheets_total_timesheet_billable_hours_billed * .56
                 when contact_name like '%Amir%' then project_timesheets_total_timesheet_billable_hours_billed * .89
                when contact_name like '%Abanoub%' then project_timesheets_total_timesheet_billable_hours_billed * .25
                 when contact_name like '%Jack%' then project_timesheets_total_timesheet_billable_hours_billed * .25
                 else project_timesheets_total_timesheet_billable_hours_billed end)/if(sum(case when contact_name like '%Lydia%' then project_timesheets_total_timesheet_billable_hours_billed * .56
                 when contact_name like '%Jordan%' then project_timesheets_total_timesheet_billable_hours_billed * .56
                 when contact_name like '%Amir%' then project_timesheets_total_timesheet_billable_hours_billed * .89
                when contact_name like '%Abanoub%' then project_timesheets_total_timesheet_billable_hours_billed * .25
                 when contact_name like '%Jack%' then project_timesheets_total_timesheet_billable_hours_billed * .25
                 else project_timesheets_total_timesheet_billable_hours_billed end) over (partition by timesheet_project_pk)=0,null,sum(case when contact_name like '%Lydia%' then project_timesheets_total_timesheet_billable_hours_billed * .56
                 when contact_name like '%Jordan%' then project_timesheets_total_timesheet_billable_hours_billed * .56
                 when contact_name like '%Amir%' then project_timesheets_total_timesheet_billable_hours_billed * .89
                when contact_name like '%Abanoub%' then project_timesheets_total_timesheet_billable_hours_billed * .25
                 when contact_name like '%Jack%' then project_timesheets_total_timesheet_billable_hours_billed * .25
                 else project_timesheets_total_timesheet_billable_hours_billed end) over (partition by timesheet_project_pk)),2) as total_project_revenue_attribution_gbp,
        round(case when project_timesheets_total_timesheet_cost_amount_gbp = 0 then timesheet_project_costs_fact_total_cost_gbp else project_timesheets_total_timesheet_cost_amount_gbp end,2)  as total_project_timesheet_billable_cost_gbp
      FROM
      staff_level
      WHERE
      project_timesheets_total_timesheet_billable_hours_billed > 0 ;;
  }



  dimension: timesheet_project_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.timesheet_project_pk ;;
  }

  dimension_group: timesheet {
    type: time
    timeframes: [month,week,week_of_year,month_num,quarter,quarter_of_year,year]
    sql: parse_timestamp('%Y-%m',(${TABLE}.timesheet_billing_ts)) ;;
  }

  dimension: pk {
    type: string
    sql: concat(${TABLE}.timesheet_project_pk,${TABLE}.contact_pk,${TABLE}.timesheet_billing_ts) ;;
    primary_key: yes
    hidden: yes
  }

  dimension: contact_pk {
    type: string
    hidden: yes

    sql: ${TABLE}.contact_pk ;;
  }

  dimension: total_project_fee_amount {
    hidden: yes

    type: number
    sql: ${TABLE}.projects_delivered_total_project_fee_amount ;;
  }

  dimension: total_timesheet_billable_hours_billed {
    hidden: yes

    type: number
    sql: ${TABLE}.project_timesheets_total_timesheet_billable_hours_billed ;;
  }

  dimension: total_timesheet_nonbillable_hours_billed {
    hidden: yes

    type: number
    sql: ${TABLE}.project_timesheets_total_timesheet_nonbillable_hours_billed ;;
  }

  dimension: total_timesheet_cost_amount_gbp {
    hidden: yes

    type: number
    sql: ${TABLE}.project_timesheets_total_timesheet_cost_amount_gbp ;;
  }

  dimension: total_other_project_costs {
    hidden: yes

    type: number
    sql: ${TABLE}.timesheet_project_costs_fact_total_cost_gbp ;;
  }

  dimension: total_project_timesheet_billable_hours_billed {
    hidden: yes

    type: number
    sql: ${TABLE}.total_project_timesheet_billable_hours_billed ;;
  }

  dimension: pct_of__billable_hours_billed {
    type: number
    value_format_name: percent_2
    sql: ${TABLE}.pct_of_total_project_timesheet_billable_hours_billed ;;
  }

  dimension: total_project_revenue_attribution_gbp {
    hidden: yes
    type: number
    sql: ${TABLE}.total_project_revenue_attribution_gbp ;;
  }

  measure: attributed_project_revenue_gbp {
    type: sum
    value_format_name: gbp

    sql: ${total_project_revenue_attribution_gbp};;
  }

  measure: attributed_project_cost_gbp {
    type: sum
    value_format_name: gbp
    sql: ${total_project_timesheet_billable_cost_gbp} ;;
  }

  dimension: total_project_timesheet_billable_cost_gbp {
    type: number
    hidden: yes

    sql: ${TABLE}.total_project_timesheet_billable_cost_gbp ;;
  }


}
