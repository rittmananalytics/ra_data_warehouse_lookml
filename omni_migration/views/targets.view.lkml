view: targets {
  sql_table_name: `ra-development.analytics_seed.targets` ;;

  dimension: ae_revenue_target {
    hidden: yes
    sql: ${TABLE}.ae_tgt ;;
  }

  dimension: ae_target_hourly_rate {
    hidden: yes
    sql: ${TABLE}.ae_tgt_rate ;;
  }

  dimension: ae_target_hours {
    hidden: yes
    sql: ${TABLE}.ae_tgt_hrs ;;
  }

  dimension: ceo_revenue_target {
    hidden: yes
    sql: ${TABLE}.ceo_tgt ;;
  }

  dimension: ceo_target_hourly_rate {
    hidden: yes
    sql: ${TABLE}.ceo_tgt_rate ;;
  }

  dimension: ceo_target_hours {
    hidden: yes
    sql: ${TABLE}.ceo_tgt_hrs ;;
  }

  dimension: con_revenue_target {
    hidden: yes
    sql: ${TABLE}.con_tgt ;;
  }

  dimension: con_target_hourly_rate {
    hidden: yes
    sql: ${TABLE}.con_tgt_rate ;;
  }

  dimension: con_target_hours {
    hidden: yes
    sql: ${TABLE}.con_tgt_hrs ;;
  }

  dimension: deals_closed_target {
    hidden: yes
    sql: ${TABLE}.deals_closed_target ;;
  }

  dimension: deals_target {
    hidden: yes
    sql: ${TABLE}.deals_target ;;
  }

  dimension: enps_target {
    hidden: yes
    sql: ${TABLE}.enps ;;
  }

  dimension: hr_survey_target {
    hidden: yes
    sql: ${TABLE}.hr_survey ;;
  }

  dimension: mqls_target {
    sql: ${TABLE}.mql ;;
  }

  dimension: new_deals_target {
    sql: ${TABLE}.new_deals ;;
  }

  dimension: pk {
    primary_key: yes
    sql: month ;;
  }

  dimension: prn__target_hourly_rate {
    hidden: yes
    sql: ${TABLE}.prn_tgt_rate ;;
  }

  dimension: prn_revenue_target {
    hidden: yes
    sql: ${TABLE}.prn_tgt ;;
  }

  dimension: prn_target_hours {
    hidden: yes
    sql: ${TABLE}.prn_tgt_hrs ;;
  }

  dimension: retained_earnings_target {
    hidden: yes
    sql: ${TABLE}.retained_earnings ;;
  }

  dimension: revenue_target {
    sql: ${TABLE}.revenue_target ;;
  }

  dimension: sae_revenue_target {
    hidden: yes
    sql: ${TABLE}.sae_tgt ;;
  }

  dimension: sae_target_hourly_rate {
    hidden: yes
    sql: ${TABLE}.sae_tgt_rate ;;
  }

  dimension: sae_target_hours {
    hidden: yes
    sql: ${TABLE}.sae_tgt_hrs ;;
  }

  dimension: sqls_target {
    sql: ${TABLE}.sql ;;
  }

  dimension: won_deals_target {
    sql: ${TABLE}.won_deals ;;
  }

  dimension_group: period {
    type: time
    timeframes: [raw, date, month, quarter, year]
    sql: parse_timestamp('%d-%m-%Y', month) ;;
  }

  measure: avg_ae_target_hourly_rate {
    type: average
    group_label: "Team Hourly Rate"
    sql: ${TABLE}.ae_tgt_rate ;;
  }

  measure: avg_ceo_target_hourly_rate {
    type: average
    group_label: "Team Hourly Rate"
    sql: ${TABLE}.ceo_tgt_rate ;;
  }

  measure: avg_con_target_hourly_rate {
    type: average
    group_label: "Team Hourly Rate"
    sql: ${TABLE}.con_tgt_rate ;;
  }

  measure: avg_enps_target {
    type: average
    value_format_name: decimal_2
    sql: ${enps_target} ;;
  }

  measure: avg_hr_survey_target {
    type: average
    value_format_name: decimal_2
    sql: ${hr_survey_target} ;;
  }

  measure: avg_prn_target_hourly_rate {
    type: average
    group_label: "Team Hourly Rate"
    sql: ${TABLE}.prn_tgt_rate ;;
  }

  measure: avg_sae_target_hourly_rate {
    type: average
    group_label: "Team Hourly Rate"
    sql: ${TABLE}.sae_tgt_rate ;;
  }

  measure: count {
    type: count
  }

  measure: total_ae_revenue_target {
    type: sum
    group_label: "Team Revenue"
    value_format_name: decimal_0
    sql: ${ae_revenue_target} ;;
  }

  measure: total_ae_target_hours {
    type: sum
    group_label: "Team Hours"
    sql: ${ae_target_hours} ;;
  }

  measure: total_ceo_revenue_target {
    type: sum
    group_label: "Team Revenue"
    value_format_name: decimal_0
    sql: ${ceo_revenue_target} ;;
  }

  measure: total_ceo_target_hours {
    type: sum
    group_label: "Team Hours"
    sql: ${ceo_target_hours} ;;
  }

  measure: total_con_revenue_target {
    type: sum
    group_label: "Team Revenue"
    value_format_name: decimal_0
    sql: ${con_revenue_target} ;;
  }

  measure: total_con_target_hours {
    type: sum
    group_label: "Team Hours"
    sql: ${con_target_hours} ;;
  }

  measure: total_deals_closed_revenue_target {
    type: sum
    value_format_name: gbp
    sql: ${deals_closed_target} ;;
  }

  measure: total_deals_revenue_target {
    type: sum
    value_format_name: gbp
    sql: ${deals_target} ;;
  }

  measure: total_deals_target {
    type: sum
    value_format_name: decimal_0
    sql: ${new_deals_target} ;;
  }

  measure: total_mql_target {
    type: sum
    value_format_name: decimal_0
    sql: ${mqls_target} ;;
  }

  measure: total_prn_revenue_target {
    type: sum
    group_label: "Team Revenue"
    value_format_name: decimal_0
    sql: ${prn_revenue_target} ;;
  }

  measure: total_prn_target_hours {
    type: sum
    group_label: "Team Hours"
    sql: ${prn_target_hours} ;;
  }

  measure: total_retained_earnings_target {
    type: sum
    hidden: yes
    sql: ${retained_earnings_target} ;;
  }

  measure: total_revenue_target {
    type: sum_distinct
    value_format_name: gbp
    sql: ${revenue_target} ;;
    sql_distinct_key: ${pk} ;;
  }

  measure: total_sae_revenue_target {
    type: sum
    group_label: "Team Revenue"
    value_format_name: decimal_0
    sql: ${sae_revenue_target} ;;
  }

  measure: total_sae_target_hours {
    type: sum
    group_label: "Team Hours"
    sql: ${sae_target_hours} ;;
  }

  measure: total_sql_target {
    type: sum
    value_format_name: decimal_0
    sql: ${sqls_target} ;;
  }

  measure: total_won_deals_target {
    type: sum
    value_format_name: decimal_0
    sql: ${won_deals_target} ;;
  }
}
