view: bonus_quarterly_fact {
  sql_table_name: `{{ _user_attributes['dataset'] }}.bonus_quarterly_fact` ;;

  dimension: bonus_quarterly_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.bonus_quarterly_pk ;;
  }

  dimension: contact_name {
    label: "Team Member"
    type: string
    sql: ${TABLE}.contact_name ;;
  }

  dimension: quarter {
    description: "Calendar quarter, e.g. 2026-Q3."
    type: string
    sql: ${TABLE}.quarter ;;
  }

  dimension_group: quarter_start {
    type: time
    timeframes: [date, quarter, year]
    datatype: date
    convert_tz: no
    sql: ${TABLE}.quarter_start_date ;;
  }

  dimension_group: join {
    group_label: "Employment"
    type: time
    timeframes: [date]
    datatype: date
    convert_tz: no
    sql: ${TABLE}.join_date ;;
  }

  dimension_group: leave {
    group_label: "Employment"
    type: time
    timeframes: [date]
    datatype: date
    convert_tz: no
    sql: ${TABLE}.leave_date ;;
  }

  dimension: days_employed_in_quarter {
    group_label: "Employment"
    type: number
    sql: ${TABLE}.days_employed_in_quarter ;;
  }

  dimension: days_in_quarter {
    group_label: "Employment"
    type: number
    sql: ${TABLE}.days_in_quarter ;;
  }

  dimension: is_revenue_target_met {
    group_label: "Conditions"
    description: "Yes if total attributed revenue is above the (pro-rated) quarterly target."
    type: yesno
    sql: ${TABLE}.is_revenue_target_met ;;
  }

  dimension: nps_condition_status {
    group_label: "Conditions"
    description: "Client NPS condition: Met (average 9 or more), Not met, or No responses."
    type: string
    sql: ${TABLE}.nps_condition_status ;;
  }

  dimension: nps_responses {
    group_label: "Conditions"
    type: number
    sql: ${TABLE}.nps_responses ;;
  }

  dimension: nps_average_score {
    group_label: "Conditions"
    type: number
    value_format_name: decimal_1
    sql: ${TABLE}.nps_average_score ;;
  }

  dimension: waive_revenue_target {
    group_label: "Directors' Decisions"
    type: yesno
    sql: ${TABLE}.waive_revenue_target ;;
  }

  dimension: waive_nps_condition {
    group_label: "Directors' Decisions"
    type: yesno
    sql: ${TABLE}.waive_nps_condition ;;
  }

  dimension: director_decision_reason {
    group_label: "Directors' Decisions"
    type: string
    sql: ${TABLE}.director_decision_reason ;;
  }

  dimension: is_revenue_condition_satisfied {
    group_label: "Conditions"
    description: "Revenue target met or waived by directors."
    type: yesno
    sql: ${TABLE}.is_revenue_condition_satisfied ;;
  }

  dimension: is_nps_condition_satisfied {
    group_label: "Conditions"
    description: "Client NPS condition met or waived by directors."
    type: yesno
    sql: ${TABLE}.is_nps_condition_satisfied ;;
  }

  measure: own_hours_billed {
    group_label: "Hours"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.own_hours_billed ;;
  }

  measure: supervised_hours_billed {
    group_label: "Hours"
    description: "Contractor hours credited through supervision."
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.supervised_hours_billed ;;
  }

  measure: own_attributed_revenue_gbp {
    group_label: "Revenue"
    type: sum
    value_format_name: gbp_0
    sql: ${TABLE}.own_attributed_revenue_gbp ;;
  }

  measure: supervision_credit_gbp {
    group_label: "Revenue"
    description: "Contractor revenue credited through supervision."
    type: sum
    value_format_name: gbp_0
    sql: ${TABLE}.supervision_credit_gbp ;;
  }

  measure: total_attributed_revenue_gbp {
    group_label: "Revenue"
    type: sum
    value_format_name: gbp_0
    sql: ${TABLE}.total_attributed_revenue_gbp ;;
  }

  measure: full_quarter_target_gbp {
    group_label: "Targets"
    description: "Sum of the quarter's three monthly revenue targets, before pro-rating."
    type: sum
    value_format_name: gbp_0
    sql: ${TABLE}.full_quarter_target_gbp ;;
  }

  measure: target_gbp {
    group_label: "Targets"
    label: "Target (pro-rated)"
    description: "Quarterly target pro-rated by the calendar days employed in the quarter."
    type: sum
    value_format_name: gbp_0
    sql: ${TABLE}.target_gbp ;;
  }

  measure: standard_rules_bonus_gbp {
    group_label: "Bonus"
    description: "Bonus under the standard rules, before directors' decisions."
    type: sum
    value_format_name: gbp_0
    sql: ${TABLE}.standard_rules_bonus_gbp ;;
  }

  measure: bonus_adjustment_gbp {
    group_label: "Bonus"
    type: sum
    value_format_name: gbp_0
    sql: ${TABLE}.bonus_adjustment_gbp ;;
  }

  measure: bonus_payable_gbp {
    group_label: "Bonus"
    description: "Bonus payable after directors' decisions: 3% of total attributed revenue where the revenue and NPS conditions are met or waived, plus any adjustment."
    type: sum
    value_format_name: gbp_0
    sql: ${TABLE}.bonus_payable_gbp ;;
  }
}
