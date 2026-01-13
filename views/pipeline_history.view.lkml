view: pipeline_history {
  derived_table: {
    sql: WITH date_spine AS (
          SELECT DATE(spine_day) AS date
          FROM UNNEST(GENERATE_TIMESTAMP_ARRAY('2018-01-01', '2024-09-17', INTERVAL 1 DAY)) AS spine_day
      ),
      deals AS (
          SELECT
              deal_id,
              property_amount,
              -- Stage dates
              property_hs_date_entered_1164140,
              property_hs_date_exited_1164140,
              property_hs_date_entered_1031923,
              property_hs_date_entered_1031924,
              property_hs_date_entered_1164152,
              property_hs_date_exited_1164152,
              property_hs_date_entered_1357010,
              property_hs_date_exited_1357010,
              property_hs_date_entered_553_a_886_b_24_bc_4_ec_4_bca_3_b_1_b_7_fcd_9_e_1_c_7_1321074272,
              property_hs_date_exited_553_a_886_b_24_bc_4_ec_4_bca_3_b_1_b_7_fcd_9_e_1_c_7_1321074272,
              property_hs_date_entered_7_c_41062_e_06_c_6_4_a_4_a_87_eb_de_503061_b_23_c_975176047,
              property_hs_date_exited_7_c_41062_e_06_c_6_4_a_4_a_87_eb_de_503061_b_23_c_975176047,
              property_hs_date_entered_appointmentscheduled,
              property_hs_date_exited_appointmentscheduled,
              property_hs_date_entered_closedlost,
              property_hs_date_entered_presentationscheduled,
              property_hs_date_exited_presentationscheduled,
              property_hs_date_entered_qualifiedtobuy,
              property_hs_date_exited_qualifiedtobuy
          FROM `ra-development.fivetran_hubspot_euwest2.deal`
      ),
      deal_stages AS (
          SELECT
              deal_id,
              property_amount,
              s.stage,
              s.date_entered,
              s.date_exited
          FROM deals,
          UNNEST([
              STRUCT('PoC Underway' AS stage, property_hs_date_entered_1164140 AS date_entered, property_hs_date_exited_1164140 AS date_exited),
              STRUCT('Closed & Delivered' AS stage, property_hs_date_entered_1031923, NULL),
              STRUCT('Closed In Delivery' AS stage, property_hs_date_entered_1031924, NULL),
              STRUCT('Project Scoping' AS stage, property_hs_date_entered_1164152, property_hs_date_exited_1164152),
              STRUCT('Awaiting Proposal' AS stage, property_hs_date_entered_1357010, property_hs_date_exited_1357010),
              STRUCT('Deal Agreed & Awaiting Sign-off' AS stage, property_hs_date_entered_553_a_886_b_24_bc_4_ec_4_bca_3_b_1_b_7_fcd_9_e_1_c_7_1321074272, property_hs_date_exited_553_a_886_b_24_bc_4_ec_4_bca_3_b_1_b_7_fcd_9_e_1_c_7_1321074272),
              STRUCT('Verbally Won & Working at Risk' AS stage, property_hs_date_entered_7_c_41062_e_06_c_6_4_a_4_a_87_eb_de_503061_b_23_c_975176047, property_hs_date_exited_7_c_41062_e_06_c_6_4_a_4_a_87_eb_de_503061_b_23_c_975176047),
              STRUCT('Appointment Scheduled' AS stage, property_hs_date_entered_appointmentscheduled, property_hs_date_exited_appointmentscheduled),
              STRUCT('Closed Lost' AS stage, property_hs_date_entered_closedlost, NULL),
              STRUCT('Presentation Scheduled' AS stage, property_hs_date_entered_presentationscheduled, property_hs_date_exited_presentationscheduled),
              STRUCT('Qualified to Buy' AS stage, property_hs_date_entered_qualifiedtobuy, property_hs_date_exited_qualifiedtobuy)
          ]) AS s
          WHERE s.date_entered IS NOT NULL
      ),
      deal_stage_dates AS (
          SELECT
              ds.deal_id,
              ds.property_amount,
              ds.stage,
              d.date
          FROM deal_stages ds
          JOIN date_spine d
              ON DATE(ds.date_entered) <= d.date
              AND (ds.date_exited IS NULL OR d.date <= DATE(ds.date_exited))
      ),
      final_output AS (
          SELECT
              date,
              stage,
              deal_id,
              property_amount
          FROM deal_stage_dates
      )
      SELECT *
      FROM final_output
      ORDER BY date, stage, deal_id ;;
  }

  measure: count_deals {
    type: count_distinct
    sql: ${TABLE}.deal_id ;;
  }

  dimension_group: date {
    timeframes: [date,month,quarter,month_num,quarter_of_year,year]
    type: time
    datatype: timestamp
    sql: timestamp(${TABLE}.date) ;;
  }

  dimension: stage {
    type: string
    sql: ${TABLE}.stage ;;
  }

  dimension: deal_id {
    type: number
    sql: ${TABLE}.deal_id ;;
  }

  dimension: pk {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${deal_id};;
  }

  dimension: deal_amount {
    type: number
    sql: ${TABLE}.property_amount ;;
  }

  measure: total_deal_amount_gbp {
    type: sum_distinct
    sql: ${deal_amount} ;;
  }

  set: detail {
    fields: [
      date_date,
      stage,
      deal_id,
      deal_amount
    ]
  }
}
