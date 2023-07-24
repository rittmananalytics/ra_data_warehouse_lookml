view: customer_first_deal_cohorts {
  derived_table: {
    sql: with transactions as (SELECT
          deals_fact.deal_pk,
          first_value(deal_closed_ts) over (partition by company_fk order by deal_closed_ts) as first_deal_closed_ts,
          date_diff(date(deal_closed_ts),first_value(date(deal_closed_ts)) over (partition by company_fk order by deal_closed_ts),MONTH) as months_since_first_deal_closed,
          date_diff(date(deal_closed_ts),first_value(date(deal_closed_ts))over (partition by company_fk order by deal_closed_ts),QUARTER) as quarters_since_first_deal_closed,
          date_diff(date(deal_closed_ts),first_value(date(deal_closed_ts)) over (partition by company_fk order by deal_closed_ts),YEAR) as years_since_first_deal_closed
      FROM
        `analytics.deals_fact` AS deals_fact
      WHERE
        deals_fact.pipeline_stage_closed_won
      )
      SELECT
        *
      FROM
        transactions
       ;;
  }



  dimension: deal_pk {
    type: string
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.deal_pk ;;
  }

  dimension_group: first_deal_closed {
    type: time
    group_label: "First Deal Cohorts"
    timeframes: [month,quarter,year]
    sql: ${TABLE}.first_deal_closed_ts ;;
  }

  dimension: months_since_first_deal_closed {
    group_label: "First Deal Cohorts"

    type: number
    sql: ${TABLE}.months_since_first_deal_closed ;;
  }

  dimension: quarters_since_first_deal_closed {
    group_label: "First Deal Cohorts"

    type: number
    sql: ${TABLE}.quarters_since_first_deal_closed ;;
  }

  dimension: years_since_first_deal_closed {
    group_label: "First Deal Cohorts"

    type: number
    sql: ${TABLE}.years_since_first_deal_closed ;;
  }


}
