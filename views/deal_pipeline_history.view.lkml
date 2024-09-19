view: deal_pipeline_history {
    derived_table: {
      sql: WITH
  deals AS (
  SELECT
    dealid deal_id,
    property_createdate.value deal_created_ts,
    property_dealname.value deal_name,
    p.label pipeline_stage,
    p.display_order,
    CASE
      WHEN p.display_order <=2 THEN '1: Initial Meeting'
      WHEN p.display_order BETWEEN 2
    AND 3 THEN '2: Needs analysis and proposal'
      WHEN p.display_order BETWEEN 4 AND 7 THEN '3: Negotiation and commitment'
      WHEN p.display_order BETWEEN 8
    AND 9 THEN '4: Deal close'
      WHEN p.display_order = 10 THEN '0: Lost'
  END
    AS deal_stage_category,
    property_dealstage.timestamp entered_pipeline_stage_ts,
    COALESCE(property_amount.value,0) AS deal_amount_gbp
  FROM
    `ra-development.stitch_hubspot.deals` d
  LEFT JOIN
    `ra-development.fivetran_hubspot_euwest2.deal_pipeline_stage` p
  ON
    property_dealstage.value = p.stage_id
  GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8),
  deals_by_deal_stage_category AS (
  SELECT
    deal_id,
    deal_name,
    pipeline_stage,
    deal_stage_category,
    deal_amount_gbp,
    entered_pipeline_stage_ts,
    DATE_TRUNC(DATE(entered_pipeline_stage_ts),MONTH) AS month_name
  FROM
    deals
  GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7),
  deals_by_deal_stage_category_step_2 AS (
  SELECT
    * EXCEPT (deal_amount_gbp),
    LAST_VALUE(deal_amount_gbp) OVER (PARTITION BY deal_id, month_name ORDER BY entered_pipeline_stage_ts) AS deal_amount_gbp,
    MAX(deals_by_deal_stage_category.entered_pipeline_stage_ts) OVER (PARTITION BY deal_id, month_name) AS last_months_pipeline_stage_ts
  FROM
    deals_by_deal_stage_category),
deals_with_closing_events as (
SELECT
  deal_id,
  deal_name,
  pipeline_stage,
  deal_stage_category,
  deal_amount_gbp,
  timestamp(date_trunc(date(last_months_pipeline_stage_ts),MONTH)) as deal_month_ts,
  case when deal_stage_category in ('4: Deal close','0: Lost') then 1 else 0 end as is_closing_events
FROM
  deals_by_deal_stage_category_step_2
WHERE
  deals_by_deal_stage_category_step_2.entered_pipeline_stage_ts = last_months_pipeline_stage_ts
 -- AND deal_stage_category != '0: Lost'
GROUP BY
  1,
  2,
  3,
  4,
  5,
  6),
deals_with_total_closing_events as (

select *,
sum(is_closing_events) over (partition by deal_id order by deal_month_ts RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as total_closing_events
from deals_with_closing_events
order by 1,5,7)
select * from deals_with_total_closing_events
where total_closing_events <= 1





 ;;
    }

    measure: count_deals {
      type: count
      sql: ${deal_id} ;;

    }

    measure: total_deal_amount_gbp {
      type: sum
      sql: ${deal_amount_gbp} ;;
    }

  measure: total_weighted_amount_gbp {
    type: sum
    sql: case when ${deal_stage_category} = '1: Initial Meeting' then ${deal_amount_gbp} * .10
              when ${deal_stage_category} = '2: Needs analysis and proposal' then ${deal_amount_gbp} * .30
              when ${deal_stage_category} = '3: Negotiation and commitment' then ${deal_amount_gbp} * .60
              when ${deal_stage_category} = '4: Deal close' then ${deal_amount_gbp} else 0 end;;
  }

    dimension: deal_id {
      type: number
      sql: ${TABLE}.deal_id ;;
       hidden: yes
    }

    dimension: pk {
      type: string
      sql: concat(${deal_id},${deal_month_ts_month} ;;
      hidden: yes
    }

    dimension: deal_name {
      type: string
      sql: ${TABLE}.deal_name ;;
    }

    dimension: deal_stage_category {
      type: string
      sql: ${TABLE}.deal_stage_category ;;
    }

    dimension: deal_stage {
      type: string
      sql: ${TABLE}.pipeline_stage ;;
    }

    dimension: deal_amount_gbp {
      type: number
      sql: ${TABLE}.deal_amount_gbp ;;
      hidden: yes
    }



    dimension_group: deal_month_ts {
      type: time
      timeframes: [month,month_num,year]
      sql: ${TABLE}.deal_month_ts ;;
    }



  }
