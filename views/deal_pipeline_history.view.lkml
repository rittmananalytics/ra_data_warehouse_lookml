view: deal_pipeline_history {
    sql_table_name: analytics.deal_pipeline_history_fact ;;


    measure: count_deals {
      type: count


    }

    measure: total_deal_amount_gbp {
      type: sum
      sql: ${deal_amount_gbp} ;;
    }

  measure: total_weighted_amount_gbp {
    type: sum
    sql: case when ${deal_stage_category} = '1: Initial Meeting' then ${deal_amount_gbp} * .30
              when ${deal_stage_category} = '2: Needs analysis and proposal' then ${deal_amount_gbp} * .45
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
      primary_key: yes
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
