
view: wh_sessions_attribution {
  derived_table: {
    sql: SELECT
        web_session_fk,blended_user_id,converted_ts,
        user_registration_first_click_attrib_conversions count_first_click_goals_achieved,
        user_registration_first_non_direct_click_attrib_conversions count_first_non_direct_click_goals_achieved,
        user_registration_first_paid_click_attrib_conversions count_first_paid_click_goals_achieved,
        first_order_first_click_attrib_conversions count_first_click_first_conversions,
        first_order_first_non_direct_click_attrib_conversions count_first_non_direct_click_first_conversions,
        first_order_last_non_direct_click_attrib_conversions count_last_non_direct_click_first_conversions,
        first_order_even_click_attrib_conversions count_even_click_first_conversions,
        first_order_first_paid_click_attrib_conversions count_first_paid_click_first_conversions,
        repeat_order_first_click_attrib_conversions count_first_click_repeat_conversions,
        repeat_order_first_non_direct_click_attrib_conversions count_first_non_direct_click_repeat_conversions,
        repeat_order_first_paid_click_attrib_conversions count_first_paid_click_repeat_conversions,
        first_order_revenue total_first_order_revenue,
        ltv_revenue total_ltv_revenue
      FROM
        `ra-development.analytics.multi_cycle_attribution_fact`
       ;;
  }

  measure: count {
    type: count
  }

  dimension: web_session_fk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.web_session_fk ;;
  }

  dimension: blended_user_id {
    hidden: yes
    type: string
    sql: ${TABLE}.blended_user_id ;;
  }

  dimension: total_converter_ltv_revenue {
    group_label: "Attribution"

    hidden: no
    type: number
    value_format_name: gbp_0

    sql: ${TABLE}.total_ltv_revenue ;;
  }

  dimension: total_converter_first_order_revenue {
    group_label: "Attribution"

    hidden: no
    type: number
    value_format_name: gbp_0
    sql: ${TABLE}.total_first_order_revenue ;;
  }

  dimension_group: converted_ts {
    hidden: yes
    type: time
    timeframes: [date,week,month,quarter,year]
    sql: ${TABLE}.converted_ts ;;
  }

  dimension: count_first_click_goals_achieved {
    hidden: yes

    type: number
    sql: ${TABLE}.count_first_click_goals_achieved ;;
  }

  measure: first_click_goals_achieved {
    type: sum
    group_label: "Attribution"
    sql: ${count_first_click_goals_achieved} ;;
  }

  measure: first_non_direct_click_goals_achieved {
    type: sum
    group_label: "Attribution"
    sql: ${count_first_non_direct_click_goals_achieved} ;;
  }

  measure: first_paid_click_goals_achieved {
    type: sum
    group_label: "Attribution"
    sql: ${count_first_paid_click_goals_achieved} ;;
  }


  dimension: count_first_non_direct_click_goals_achieved {
    hidden: yes

    type: number
    sql: ${TABLE}.count_first_non_direct_click_goals_achieved ;;
  }

  dimension: count_first_paid_click_goals_achieved {
    hidden: yes

    type: number
    sql: ${TABLE}.count_first_paid_click_goals_achieved ;;
  }

  dimension: count_first_click_first_conversions {
    hidden: yes

    type: number
    sql: ${TABLE}.count_first_click_first_conversions ;;
  }

  dimension: count_first_non_direct_click_first_conversions {
    hidden: yes

    type: number
    sql: ${TABLE}.count_first_non_direct_click_first_conversions ;;
  }

  dimension: count_last_non_direct_click_first_conversions {
    hidden: yes

    type: number
    sql: ${TABLE}.count_last_non_direct_click_first_conversions ;;
  }

  dimension: count_even_click_first_conversions {
    hidden: yes

    type: number
    sql: ${TABLE}.count_even_click_first_conversions ;;
  }

  dimension: count_first_paid_click_first_conversions {
    hidden: yes

    type: number
    sql: ${TABLE}.count_first_paid_click_first_conversions ;;
  }

  dimension: count_first_click_repeat_conversions {
    hidden: yes

    type: number
    sql: ${TABLE}.count_first_click_repeat_conversions ;;
  }

  dimension: count_first_non_direct_click_repeat_conversions {
    hidden: yes

    type: number
    sql: ${TABLE}.count_first_non_direct_click_repeat_conversions ;;
  }

  dimension: count_first_paid_click_repeat_conversions {
    hidden: yes

    type: number
    sql: ${TABLE}.count_first_paid_click_repeat_conversions ;;
  }

  measure: first_click_first_conversions {
    type: sum
    group_label: "Attribution"
    sql: ${count_first_click_first_conversions} ;;
  }

  measure: last_non_direct_click_first_conversions {
    type: sum
    group_label: "Attribution"
    sql: ${count_last_non_direct_click_first_conversions} ;;
  }

  measure: even_click_first_conversions {
    type: sum
    group_label: "Attribution"
    sql: ${count_even_click_first_conversions} ;;
  }

  measure: first_non_direct_click_first_conversions {
    type: sum
    group_label: "Attribution"
    sql: ${count_first_non_direct_click_first_conversions} ;;
  }

  measure: first_paid_click_first_conversions {
    type: sum
    group_label: "Attribution"
    sql: ${count_first_paid_click_first_conversions} ;;
  }

  measure: first_click_repeat_conversions {
    type: sum
    group_label: "Attribution"
    sql: ${count_first_click_repeat_conversions} ;;
  }

  measure: first_non_direct_click_repeat_conversions {
    type: sum
    group_label: "Attribution"
    sql: ${count_first_non_direct_click_repeat_conversions} ;;
  }

  measure: first_paid_click_repeat_conversions {
    type: sum
    group_label: "Attribution"
    sql: ${count_first_paid_click_repeat_conversions} ;;
  }

}
