view: company_deal_value_attribute {
  derived_table: {
    sql: SELECT
          companies_dim.company_pk,
          COALESCE(SUM(case when deals_fact.deal_type = 'New Business' then deals_fact.deal_amount end ), 0) AS initial_deal_amount,
          COALESCE(SUM(case when deals_fact.deal_type = 'Existing Client' then deals_fact.deal_amount end), 0) AS expansion_deal_amount
      FROM `analytics.companies_dim` AS companies_dim
      FULL OUTER JOIN `analytics.deals_fact` AS deals_fact ON companies_dim.company_pk = deals_fact.company_fk
      WHERE (deals_fact.pipeline_stage_closed_won )
      GROUP BY
          1
         ORDER BY
          1 DESC
      LIMIT 500
       ;;
  }



  dimension: company_pk {
    type: string
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.company_pk ;;
  }

  dimension: initial_deal_amount {
    group_label: "           Company Details"
    hidden: yes
    type: number
    sql: ${TABLE}.initial_deal_amount ;;
  }

  dimension: expansion_deal_amount {
    group_label: "           Company Details"
    hidden: yes

    type: number
    sql: ${TABLE}.expansion_deal_amount ;;
  }

  measure:total_initial_deal_amount {
    group_label: "           Company Details"
    hidden: yes

    type: sum
    sql: ${TABLE}.initial_deal_amount ;;
  }

  measure: total_expansion_deal_amount {
    group_label: "           Company Details"
    hidden: yes

    type: sum
    sql: ${TABLE}.expansion_deal_amount ;;
  }

  set: detail {
    fields: [company_pk, initial_deal_amount, expansion_deal_amount]
  }
}