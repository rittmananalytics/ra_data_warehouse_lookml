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
              `ra-development.analytics.multi_cycle_attribution_fact` ;;
  }

  dimension: blended_user_id {
    hidden: yes
    sql: ${TABLE}.blended_user_id ;;
  }

  dimension: count_even_click_first_conversions {
    hidden: yes
    sql: ${TABLE}.count_even_click_first_conversions ;;
  }

  dimension: count_first_click_first_conversions {
    hidden: yes
    sql: ${TABLE}.count_first_click_first_conversions ;;
  }

  dimension: count_first_click_goals_achieved {
    hidden: yes
    sql: ${TABLE}.count_first_click_goals_achieved ;;
  }

  dimension: count_first_click_repeat_conversions {
    hidden: yes
    sql: ${TABLE}.count_first_click_repeat_conversions ;;
  }

  dimension: count_first_non_direct_click_first_conversions {
    hidden: yes
    sql: ${TABLE}.count_first_non_direct_click_first_conversions ;;
  }

  dimension: count_first_non_direct_click_goals_achieved {
    hidden: yes
    sql: ${TABLE}.count_first_non_direct_click_goals_achieved ;;
  }

  dimension: count_first_non_direct_click_repeat_conversions {
    hidden: yes
    sql: ${TABLE}.count_first_non_direct_click_repeat_conversions ;;
  }

  dimension: count_first_paid_click_first_conversions {
    hidden: yes
    sql: ${TABLE}.count_first_paid_click_first_conversions ;;
  }

  dimension: count_first_paid_click_goals_achieved {
    hidden: yes
    sql: ${TABLE}.count_first_paid_click_goals_achieved ;;
  }

  dimension: count_first_paid_click_repeat_conversions {
    hidden: yes
    sql: ${TABLE}.count_first_paid_click_repeat_conversions ;;
  }

  dimension: count_last_non_direct_click_first_conversions {
    hidden: yes
    sql: ${TABLE}.count_last_non_direct_click_first_conversions ;;
  }

  dimension: total_converter_first_order_revenue {
    type: number
    group_label: "Attribution"
    value_format_name: gbp_0
    sql: ${TABLE}.total_first_order_revenue ;;
  }

  dimension: total_converter_ltv_revenue {
    type: number
    group_label: "Attribution"
    value_format_name: gbp_0
    sql: ${TABLE}.total_ltv_revenue ;;
  }

  dimension: web_session_fk {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.web_session_fk ;;
  }

  dimension_group: converted_ts {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    hidden: yes
    sql: ${TABLE}.converted_ts ;;
  }

  measure: count {
    type: count
  }

  measure: even_click_first_conversions {
    type: sum
    group_label: "Attribution"
    sql: ${count_even_click_first_conversions} ;;
  }

  measure: first_click_first_conversions {
    type: sum
    group_label: "Attribution"
    sql: ${count_first_click_first_conversions} ;;
  }

  measure: first_click_goals_achieved {
    type: sum
    group_label: "Attribution"
    sql: ${count_first_click_goals_achieved} ;;
  }

  measure: first_click_repeat_conversions {
    type: sum
    group_label: "Attribution"
    sql: ${count_first_click_repeat_conversions} ;;
  }

  measure: first_non_direct_click_first_conversions {
    type: sum
    group_label: "Attribution"
    sql: ${count_first_non_direct_click_first_conversions} ;;
  }

  measure: first_non_direct_click_goals_achieved {
    type: sum
    group_label: "Attribution"
    sql: ${count_first_non_direct_click_goals_achieved} ;;
  }

  measure: first_non_direct_click_repeat_conversions {
    type: sum
    group_label: "Attribution"
    sql: ${count_first_non_direct_click_repeat_conversions} ;;
  }

  measure: first_paid_click_first_conversions {
    type: sum
    group_label: "Attribution"
    sql: ${count_first_paid_click_first_conversions} ;;
  }

  measure: first_paid_click_goals_achieved {
    type: sum
    group_label: "Attribution"
    sql: ${count_first_paid_click_goals_achieved} ;;
  }

  measure: first_paid_click_repeat_conversions {
    type: sum
    group_label: "Attribution"
    sql: ${count_first_paid_click_repeat_conversions} ;;
  }

  measure: last_non_direct_click_first_conversions {
    type: sum
    group_label: "Attribution"
    sql: ${count_last_non_direct_click_first_conversions} ;;
  }

  measure: session_first_conversion_rate {
    type: number
    label: "Session First Conversion Rate"
    value_format_name: percent_2
    sql: safe_divide(${first_click_first_conversions}, ${web_events_fact.total_sessions}) ;;
  }

  measure: session_first_goal_achieved_rate {
    type: number
    label: "Session First Goal Achieved Rate"
    description: "Same formula as the conversion rate, as the Looker tile 2375 table calculation defines it"
    value_format_name: percent_2
    sql: safe_divide(${first_click_first_conversions}, ${web_events_fact.total_sessions}) ;;
  }

  measure: sum_first_order_revenue {
    type: sum
    label: "First Conversion Revenue"
    value_format_name: gbp_0
    sql: ${total_converter_first_order_revenue} ;;
  }

  measure: sum_ltv_revenue {
    type: sum
    label: "First Conversion LTV"
    value_format_name: gbp_0
    sql: ${total_converter_ltv_revenue} ;;
  }

  measure: user_first_conversion_rate {
    type: number
    label: "User First Conversion Rate"
    value_format_name: percent_2
    sql: safe_divide(${first_click_first_conversions}, ${web_events_fact.total_blended_user_id}) ;;
  }

  measure: user_first_goal_achieved_rate {
    type: number
    label: "User First Goal Achieved Rate"
    value_format_name: percent_2
    sql: safe_divide(${first_click_goals_achieved}, ${web_events_fact.total_blended_user_id}) ;;
  }
}
