view: deal_pipeline_history {
  derived_table: {
    sql: SELECT h.deal_id, h.deal_name, h.pipeline_stage, h.deal_stage_category, h.deal_amount_gbp, h.deal_month_ts, h.is_closing_events, h.total_closing_events,
             d.company_fk AS company_pk,
             CONCAT(CAST(h.deal_id AS STRING), '|', FORMAT_TIMESTAMP('%Y-%m', h.deal_month_ts), '|', CAST(ROW_NUMBER() OVER (PARTITION BY h.deal_id, h.deal_month_ts ORDER BY d.deal_pk) AS STRING)) AS pk
      FROM `ra-development.analytics.deal_pipeline_history_fact` h
      JOIN `ra-development.analytics.deals_fact` d ON h.deal_id = d.deal_id ;;
  }

  dimension: company_pk {
    hidden: yes
    sql: ${TABLE}.company_pk ;;
  }

  dimension: deal_amount_gbp {
    hidden: yes
    sql: ${TABLE}.deal_amount_gbp ;;
  }

  dimension: deal_id {
    hidden: yes
    sql: ${TABLE}.deal_id ;;
  }

  dimension: deal_name {
    sql: ${TABLE}.deal_name ;;
  }

  dimension: deal_stage {
    sql: ${TABLE}.pipeline_stage ;;
  }

  dimension: deal_stage_category {
    sql: ${TABLE}.deal_stage_category ;;
  }

  dimension: pipeline_stage {
    hidden: yes
    sql: ${TABLE}.pipeline_stage ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.pk ;;
  }

  dimension_group: deal_month_ts {
    type: time
    timeframes: [raw, date, month, quarter, year, month_num]
    label: "Deal Month"
    sql: ${TABLE}.deal_month_ts ;;
  }

  measure: count_deals {
    type: count_distinct
    sql: ${deal_id} ;;
  }

  measure: total_deal_amount_gbp {
    type: sum
    value_format_name: gbp_0
    sql: ${deal_amount_gbp} ;;
  }

  measure: total_weighted_amount_gbp {
    type: sum
    description: "Deal amount weighted by stage: 30% initial meeting, 45% needs analysis, 60% negotiation, 100% close (LookML measure)"
    value_format_name: gbp_0
    sql: case when ${deal_stage_category} = '1: Initial Meeting' then ${deal_amount_gbp} * .30
              when ${deal_stage_category} = '2: Needs analysis and proposal' then ${deal_amount_gbp} * .45
              when ${deal_stage_category} = '3: Negotiation and commitment' then ${deal_amount_gbp} * .60
              when ${deal_stage_category} = '4: Deal close' then ${deal_amount_gbp} else 0 end ;;
  }
}
