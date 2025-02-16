# The name of this view in Looker is "Targets"
view: targets {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics_seed.targets`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Deals Closed Target" in Explore.

  dimension: deals_closed_target {
    hidden: yes
    type: number
    sql: ${TABLE}.deals_closed_target ;;
  }

  dimension: deals_target {
    hidden: yes

    type: number
    sql: ${TABLE}.deals_target ;;
  }

  dimension: enps_target {
    hidden: yes
    type: number
    sql: ${TABLE}.enps ;;
  }

  dimension: hr_survey_target {
    hidden: yes
    type: number
    sql: ${TABLE}.hr_survey ;;
  }

  dimension_group: period {
    type: time
    timeframes : [month,quarter,year]
    sql: parse_timestamp('%d-%m-%Y', ${TABLE}.month) ;;
  }

  dimension: revenue_target {
    hidden: no

    type: number
    sql: ${TABLE}.revenue_target ;;
  }

  dimension: retained_earnings_target {
    hidden: no

    type: number
    sql: ${TABLE}.retained_earnings ;;
  }

  dimension: mqls_target {
    hidden: no

    type: number
    sql: ${TABLE}.mql ;;
  }

  dimension: sqls_target {
    hidden: no

    type: number
    sql: ${TABLE}.sql ;;
  }

  dimension: new_deals_target {
    hidden: no

    type: number
    sql: ${TABLE}.new_deals ;;
  }

  dimension: won_deals_target {
    hidden: no

    type: number
    sql: ${TABLE}.won_deals ;;
  }

  dimension: sae_revenue_target {
    hidden: no

    type: number
    sql: ${TABLE}.sae_tgt ;;
  }

  dimension: prn_revenue_target {
    hidden: no

    type: number
    sql: ${TABLE}.prn_tgt ;;
  }

  dimension: ceo_revenue_target {
    hidden: no

    type: number
    sql: ${TABLE}.ceo_tgt ;;
  }

  dimension: con_revenue_target {
    hidden: no

    type: number
    sql: ${TABLE}.con_tgt ;;
  }

  dimension: ae_target_hours  {
    hidden: yes
    type: number
    sql: ${TABLE}.ae_tgt_hrs ;;
  }

  dimension: sae_target_hours  {
    hidden: yes
    type: number
    sql: ${TABLE}.sae_tgt_hrs ;;
  }

  dimension: prn_target_hours  {
    hidden: yes
    type: number
    sql: ${TABLE}.prn_tgt_hrs ;;
  }

  dimension: con_target_hours  {
    hidden: yes
    type: number
    sql: ${TABLE}.con_tgt_hrs ;;
  }

  dimension: ceo_target_hours  {
    hidden: yes
    type: number
    sql: ${TABLE}.ceo_tgt_hrs ;;
  }

  dimension: ae_target_hourly_rate  {
    hidden: yes
    type: number
    sql: ${TABLE}.ae_tgt_rate ;;
  }

  dimension: sae_target_hourly_rate  {
    hidden: yes
    type: number
    sql: ${TABLE}.sae_tgt_rate ;;
  }

  dimension: prn__target_hourly_rate  {
    hidden: yes
    type: number
    sql: ${TABLE}.prn_tgt_rate ;;
  }

  dimension: con_target_hourly_rate  {
    hidden: yes
    type: number
    sql: ${TABLE}.con_tgt_rate ;;
  }

  dimension: ceo_target_hourly_rate  {
    hidden: yes
    type: number
    sql: ${TABLE}.ceo_tgt_rate ;;
  }

  measure: avg_ae_target_hourly_rate  {
    type: average
    sql: ${TABLE}.ae_tgt_rate ;;
  }

  measure: avg_sae_target_hourly_rate  {
    type: average
    sql: ${TABLE}.sae_tgt_rate ;;
  }

  measure: avg_prn_target_hourly_rate  {
    type: average
    sql: ${TABLE}.prn_tgt_rate ;;
  }

  measure: avg_ceo_target_hourly_rate  {
    type: average
    sql: ${TABLE}.ceo_tgt_rate ;;
  }

  measure: avg_con_target_hourly_rate  {
    type: average
    sql: ${TABLE}.con_tgt_rate ;;
  }


  measure: total_ae_target_hours {
    type: sum
    sql: ${ae_target_hours} ;;
  }

  measure: total_sae_target_hours {
    type: sum
    sql: ${sae_target_hours} ;;
  }

  measure: total_prn_target_hours {
    type: sum
    sql: ${prn_target_hours} ;;
  }

  measure: total_ceo_target_hours {
    type: sum
    sql: ${ceo_target_hours} ;;
  }

  measure: total_con_target_hours {
    type: sum
    sql: ${con_target_hours} ;;
  }





  dimension: ae_revenue_target {
    hidden: no

    type: number
    sql: ${TABLE}.ae_tgt ;;
  }

  measure: total_retained_earnings_target {
    type: sum
    sql: ${retained_earnings_target} ;;
  }


  dimension: pk {
    type: string
    primary_key: yes
    sql: ${TABLE}.month ;;
  }


  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_revenue_target {
    hidden: no

    type: sum_distinct
    value_format_name: gbp

    sql: ${revenue_target} ;;
  }

  measure: total_deals_closed_revenue_target {
    hidden: no

    type: sum
    value_format_name: gbp

    sql: ${deals_closed_target} ;;
  }

  measure: total_deals_revenue_target {
    hidden: no

    type: sum
    value_format_name: gbp
    sql: ${deals_target} ;;
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

  measure: total_mql_target {
    type: sum
    value_format_name: decimal_0
    sql: ${mqls_target} ;;
  }

  measure: total_sql_target {
    type: sum
    value_format_name: decimal_0
    sql: ${sqls_target} ;;
  }

  measure: total_deals_target {
    type: sum
    value_format_name: decimal_0
    sql: ${new_deals_target} ;;
  }

  measure: total_won_deals_target {
    type: sum
    value_format_name: decimal_0
    sql: ${won_deals_target} ;;
  }

  measure: total_sae_revenue_target {
    type: sum
    value_format_name: decimal_0
    sql: ${sae_revenue_target} ;;
  }

  measure: total_ae_revenue_target {
    type: sum
    value_format_name: decimal_0
    sql: ${ae_revenue_target} ;;
  }

  measure: total_ceo_revenue_target {
    type: sum
    value_format_name: decimal_0
    sql: ${ceo_revenue_target} ;;
  }

  measure: total_con_revenue_target {
    type: sum
    value_format_name: decimal_0
    sql: ${con_revenue_target} ;;
  }

  measure: total_prn_revenue_target {
    type: sum
    value_format_name: decimal_0
    sql: ${prn_revenue_target} ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
