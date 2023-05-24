view: customer_first_order_segments {
  derived_table: {
    sql: with deals as (SELECT
          companies_dim.company_pk  AS companies_dim_company_pk,
          first_value(case when deals_fact.deal_source is null and deals_fact.deal_type = 'Existing Client' then 'Repeat Customer'
                           else deals_fact.deal_source end) over (partition by companies_dim.company_pk order by deals_fact.deal_closed_ts)    AS first_deal_source,
          first_value(case when deals_fact.deal_type is null then 'Existing Client' else deals_fact.deal_type end) over (partition by companies_dim.company_pk order by deals_fact.deal_closed_ts)  AS first_deal_type,
          first_value(coalesce(deals_fact.deal_partner_referral,'Direct')) over (partition by companies_dim.company_pk order by deals_fact.deal_closed_ts)  AS first_partner_referral,
          first_value(deals_fact.deal_pricing_model) over (partition by companies_dim.company_pk order by deals_fact.deal_closed_ts)  AS first_pricing_model,
          first_value(case when deal_sprint_type like '%;%' then 'Multiple'
                           when deal_sprint_type is null then 'Data Analytics'
                           else deal_sprint_type end) over (partition by companies_dim.company_pk order by deals_fact.deal_closed_ts)  AS first_sprint_type,
          first_value(deals_fact.deal_number_of_sprints) over (partition by companies_dim.company_pk order by deals_fact.deal_closed_ts)  AS first_number_of_sprints,
          last_value(deals_fact.deal_number_of_sprints) over (partition by companies_dim.company_pk order by deals_fact.deal_closed_ts)  AS last_number_of_sprints,
          first_value(deals_fact.deal_currency_code) over (partition by companies_dim.company_pk order by deals_fact.deal_closed_ts)  AS first_currency_code,
          first_value(CASE WHEN deals_fact.is_license_referral_deal  THEN 'Yes' ELSE 'No' END) over (partition by companies_dim.company_pk order by deals_fact.deal_closed_ts)   AS is_first_deal_license_referral,
          first_value(CASE WHEN deals_fact.is_services_deal  THEN 'Yes' ELSE 'No' END) over (partition by companies_dim.company_pk order by deals_fact.deal_closed_ts) AS is_first_deal_services,
          first_value(CASE WHEN deals_fact.is_dbt_skill_requirement  THEN 'Yes' ELSE 'No' END) over (partition by companies_dim.company_pk order by deals_fact.deal_closed_ts) AS is_first_deal_dbt,
          first_value(CASE WHEN deals_fact.is_fivetran_skill_requirement  THEN 'Yes' ELSE 'No' END) over (partition by companies_dim.company_pk order by deals_fact.deal_closed_ts) AS is_first_deal_fivetran,
          first_value(CASE WHEN deals_fact.is_gcp_skill_requirement  THEN 'Yes' ELSE 'No' END) over (partition by companies_dim.company_pk order by deals_fact.deal_closed_ts) AS is_first_deal_gcp,
          first_value(CASE WHEN deals_fact.is_looker_skill_requirement  THEN 'Yes' ELSE 'No' END) over (partition by companies_dim.company_pk order by deals_fact.deal_closed_ts) AS is_first_deal_looker,
          first_value(CASE WHEN deals_fact.is_segment_skill_requirement  THEN 'Yes' ELSE 'No' END) over (partition by companies_dim.company_pk order by deals_fact.deal_closed_ts) AS is_first_deal_segment,
          first_value(CASE WHEN deals_fact.is_snowflake_skill_requirement  THEN 'Yes' ELSE 'No' END) over (partition by companies_dim.company_pk order by deals_fact.deal_closed_ts) AS is_first_deal_snowflake,
          first_value(CASE WHEN deals_fact.is_stitch_skill_requirement  THEN 'Yes' ELSE 'No' END) over (partition by companies_dim.company_pk order by deals_fact.deal_closed_ts) AS is_first_deal_stitch,
          first_value(CASE WHEN deals_fact.deal_amount < 4000 then '< 4000 GBP'
                           WHEN deals_fact.deal_amount between 4000 and 6000 then '4000 - 6000 GBP'
                           WHEN deals_fact.deal_amount between 6000 and 10000 then '6000 - 10000 GBP'
                           WHEN deals_fact.deal_amount between 10000 and 25000 then '10000 - 25000 GBP'
                           WHEN deals_fact.deal_amount between 25000 and 50000 then '25000 - 50000 GBP'
                           WHEN deals_fact.deal_amount between 50000 and 100000 then '50000 - 100000 GBP'
                           else '100000+ GBP' end) over (partition by companies_dim.company_pk order by deals_fact.deal_closed_ts) as first_deal_amount,
          last_value(CASE WHEN deals_fact.deal_amount < 4000 then '< 4000 GBP'
                           WHEN deals_fact.deal_amount between 4000 and 6000 then '4000 - 6000 GBP'
                           WHEN deals_fact.deal_amount between 6000 and 10000 then '6000 - 10000 GBP'
                           WHEN deals_fact.deal_amount between 10000 and 25000 then '10000 - 25000 GBP'
                           WHEN deals_fact.deal_amount between 25000 and 50000 then '25000 - 50000 GBP'
                           WHEN deals_fact.deal_amount between 50000 and 100000 then '50000 - 100000 GBP'
                           else '100000+ GBP' end) over (partition by companies_dim.company_pk order by deals_fact.deal_closed_ts) as last_deal_amount
      FROM
        `analytics.deals_fact` AS deals_fact
      JOIN
        `analytics.companies_dim` AS companies_dim  ON deals_fact.company_pk = companies_dim.company_pk
      WHERE
        deals_fact.pipeline_stage_closed_won
      )
      SELECT
        *
      FROM
        deals
      group by
        1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
       ;;
  }



  dimension: companies_dim_company_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.companies_dim_company_pk ;;
  }



  dimension: first_deal_source {
    group_label: "Segmentation"
    type: string
    sql: ${TABLE}.first_deal_source ;;
  }

  dimension: first_deal_type {
    group_label: "Segmentation"

    type: string
    sql: ${TABLE}.first_deal_type ;;
  }

  dimension: first_partner_referral {
    group_label: "Segmentation"

    type: string
    sql: ${TABLE}.first_partner_referral ;;
  }

  dimension: first_pricing_model {
    group_label: "Segmentation"

    type: string
    sql: ${TABLE}.first_pricing_model ;;
  }

  dimension: first_sprint_type {
    group_label: "Segmentation"

    type: string
    sql: ${TABLE}.first_sprint_type ;;
  }

  dimension: first_number_of_sprints {
    group_label: "Segmentation"

    type: number
    sql: ${TABLE}.first_number_of_sprints ;;
  }

  dimension: last_number_of_sprints {
    group_label: "Segmentation"

    type: number
    sql: ${TABLE}.last_number_of_sprints ;;
  }

  dimension: first_currency_code {
    group_label: "Segmentation"

    type: string
    sql: ${TABLE}.first_currency_code ;;
  }

  dimension: is_first_deal_license_referral {
    group_label: "Segmentation"

    type: string
    sql: ${TABLE}.is_first_deal_license_referral ;;
  }

  dimension: is_first_deal_services {
    group_label: "Segmentation"

    type: string
    sql: ${TABLE}.is_first_deal_services ;;
  }

  dimension: is_first_deal_dbt {
    group_label: "Segmentation"

    type: string
    sql: ${TABLE}.is_first_deal_dbt ;;
  }

  dimension: is_first_deal_fivetran {
    group_label: "Segmentation"

    type: string
    sql: ${TABLE}.is_first_deal_fivetran ;;
  }

  dimension: is_first_deal_gcp {
    group_label: "Segmentation"

    type: string
    sql: ${TABLE}.is_first_deal_gcp ;;
  }

  dimension: is_first_deal_looker {
    group_label: "Segmentation"

    type: string
    sql: ${TABLE}.is_first_deal_looker ;;
  }

  dimension: is_first_deal_segment {
    group_label: "Segmentation"

    type: string
    sql: ${TABLE}.is_first_deal_segment ;;
  }

  dimension: is_first_deal_snowflake {
    group_label: "Segmentation"

    type: string
    sql: ${TABLE}.is_first_deal_snowflake ;;
  }

  dimension: is_first_deal_stitch {
    group_label: "Segmentation"

    type: string
    sql: ${TABLE}.is_first_deal_stitch ;;
  }

  dimension: first_deal_amount {
    group_label: "Segmentation"

    type: string
    sql: ${TABLE}.first_deal_amount ;;
  }

  dimension: last_deal_amount {
    group_label: "Segmentation"

    type: string
    sql: ${TABLE}.last_deal_amount ;;
  }

  set: detail {
    fields: [
      companies_dim_company_pk,
      first_deal_source,
      first_deal_type,
      first_partner_referral,
      first_pricing_model,
      first_sprint_type,
      first_number_of_sprints,
      first_currency_code,
      is_first_deal_license_referral,
      is_first_deal_services,
      is_first_deal_dbt,
      is_first_deal_fivetran,
      is_first_deal_gcp,
      is_first_deal_looker,
      is_first_deal_segment,
      is_first_deal_snowflake,
      is_first_deal_stitch,
      first_deal_amount
    ]
  }
}