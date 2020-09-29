view: deals_fact {
  sql_table_name: `analytics.deals_fact`
    ;;

  dimension: company_pk {
    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension: deal_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.deal_amount ;;
  }

  measure: total_deal_amount {
    value_format_name: gbp

    type: sum
    sql: ${TABLE}.deal_amount ;;
  }

  dimension: deal_amount_local_currency {
    hidden: yes

    type: number
    sql: ${TABLE}.deal_amount_local_currency ;;
  }

  dimension_group: deal_closed {
    type: time
    timeframes: [
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.deal_closed_date ;;
  }

  dimension: deal_closed_lost_reason {
    type: string
    sql: ${TABLE}.deal_closed_lost_reason ;;
  }

  dimension_group: deal_created {
    type: time
    timeframes: [
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.deal_created_date ;;
  }

  dimension: deal_description {
    type: string
    sql: ${TABLE}.deal_description ;;
  }

  dimension: deal_id {
    hidden: yes

    type: number
    sql: ${TABLE}.deal_id ;;
  }

  dimension: deal_is_deleted {
    type: yesno
    sql: ${TABLE}.deal_is_deleted ;;
  }

  dimension_group: deal_last_modified {
    type: time
    timeframes: [
      time
    ]
    sql: ${TABLE}.deal_last_modified_date ;;
  }

  dimension: deal_name {
    type: string
    sql: ${TABLE}.deal_name ;;
  }

  dimension: deal_owner_id {
    hidden: yes

    type: string
    sql: ${TABLE}.deal_owner_id ;;
  }

  dimension: deal_pipeline_id {
    hidden: yes

    type: string
    sql: ${TABLE}.deal_pipeline_id ;;
  }

  dimension: deal_pipeline_stage_id {
    hidden: yes

    type: string
    sql: ${TABLE}.deal_pipeline_stage_id ;;
  }

  dimension_group: deal_pipeline_stage_ts {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.deal_pipeline_stage_ts ;;
  }

  dimension: deal_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.deal_pk ;;
  }

  dimension: deal_type {
    type: string
    sql: case when ${TABLE}.deal_type is null then 'existingbusiness' else ${TABLE}.deal_type end ;;
  }

  dimension: owner_email {
    type: string
    sql: ${TABLE}.owner_email ;;
  }

  dimension: owner_full_name {
    type: string
    sql: ${TABLE}.owner_full_name ;;
  }

  dimension: pipeline_display_order {
    type: number
    sql: ${TABLE}.pipeline_display_order ;;
  }

  dimension: pipeline_label {
    type: string
    sql: ${TABLE}.pipeline_label ;;
  }

  dimension: pipeline_stage_close_probability_pct {
    hidden: yes

    type: number
    sql: ${TABLE}.pipeline_stage_close_probability_pct ;;
  }

  dimension: weighted_deal_amount {
    type: number
    hidden: yes

    sql: ${TABLE}.deal_amount * ${TABLE}.pipeline_stage_close_probability_pct ;;
  }

  measure: total_weighted_deal_amount {
    type: sum
    value_format_name: gbp
    sql: ${weighted_deal_amount} ;;
  }

  dimension: pipeline_stage_closed_won {
    type: yesno
    sql: ${TABLE}.pipeline_stage_closed_won ;;
  }

  dimension: pipeline_stage_display_order {
    type: number
    sql: ${TABLE}.pipeline_stage_display_order ;;
  }

  dimension: pipeline_stage_label {
    type: string
    sql: ${TABLE}.pipeline_stage_label ;;
  }

  measure: count {
    type: count
    drill_fields: [owner_full_name, deal_name]
  }
}
