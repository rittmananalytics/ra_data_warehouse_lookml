view: engagements {
  derived_table: {
    sql: select project_engagement_pk, engagement_code, company_fk, timestamp(engagement_start_ts) as engagement_start_ts, timestamp(engagement_end_ts) as engagement_end_ts, deal_id, deal_amount, deal_hourly_rate, deal_description, deal_name, deal_type, deal_partner_referral, deal_source, deal_days_to_close, last_billable_timesheet_date,deal_created_ts, dt_entered_3_sow_drafted, dt_entered_5_customer_agreed_sow, dt_entered_7_sow_customer_docusigned, deal_closed_ts, projects from analytics.timesheet_project_engagements_dim
              group by all ;;
  }

  dimension: company_fk {
    hidden: yes
    sql: ${TABLE}.company_fk ;;
  }

  dimension: deal_amount {
    label: "Engagement Deal Amount"
    group_label: "Engagement Details"
    sql: ${TABLE}.deal_amount ;;
  }

  dimension: deal_created_days_to_engagement_start {
    hidden: yes
    sql: DATE_DIFF(timestamp(${TABLE}.engagement_start_ts),timestamp(${TABLE}.deal_created_ts),DAY) ;;
  }

  dimension: deal_days_to_close {
    label: "Original Engagement Deal Closed"
    hidden: yes
    sql: ${TABLE}.deal_days_to_close ;;
  }

  dimension: deal_description {
    label: "Engagement Description"
    group_label: "Engagement Details"
    sql: ${TABLE}.deal_description ;;
  }

  dimension: deal_hourly_rate {
    type: number
    label: "Engagement Deal Amount"
    group_label: "Engagement Details"
    hidden: yes
    value_format_name: gbp_0
    sql: ${TABLE}.deal_hourly_rate ;;
  }

  dimension: deal_id {
    hidden: yes
    sql: ${TABLE}.deal_id ;;
  }

  dimension: deal_name {
    label: "Engagement Name"
    group_label: "Engagement Details"
    sql: ${TABLE}.deal_name ;;
  }

  dimension: deal_partner_referral {
    label: "Partner Source"
    group_label: "Engagement Details"
    sql: ${TABLE}.deal_partner_referral ;;
  }

  dimension: deal_source {
    label: "Engagement Source"
    group_label: "Engagement Details"
    sql: ${TABLE}.deal_source ;;
  }

  dimension: deal_type {
    label: "Engagement Type"
    group_label: "Engagement Details"
    sql: ${TABLE}.deal_type ;;
  }

  dimension: engagement_code {
    hidden: yes
    sql: ${TABLE}.engagement_code ;;
  }

  dimension: project_engagement_pk {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.project_engagement_pk ;;
  }

  dimension: projects {
    hidden: yes
    sql: ${TABLE}.projects ;;
  }

  dimension: sow_agreed_days_to_engagement_start {
    hidden: yes
    sql: DATE_DIFF(timestamp(${TABLE}.engagement_start_ts),timestamp(${TABLE}.dt_entered_5_customer_agreed_sow),DAY) ;;
  }

  dimension: sow_drafted_days_to_engagement_start {
    hidden: yes
    sql: DATE_DIFF(timestamp(${TABLE}.engagement_start_ts),timestamp(${TABLE}.dt_entered_3_sow_drafted),DAY) ;;
  }

  dimension: sow_signed_days_to_engagement_start {
    hidden: yes
    sql: DATE_DIFF(timestamp(${TABLE}.engagement_start_ts),timestamp(${TABLE}.dt_entered_7_sow_customer_docusigned),DAY) ;;
  }

  dimension_group: deal_closed {
    type: time
    timeframes: [raw, date]
    label: "Original Engagement Deal Closed"
    group_label: "Engagement Details"
    sql: ${TABLE}.deal_closed_ts ;;
  }

  dimension_group: deal_created {
    type: time
    timeframes: [raw, date]
    label: "Engagement Created"
    group_label: "Engagement Details"
    sql: ${TABLE}.deal_created_ts ;;
  }

  dimension_group: dt_entered_3_sow_drafted {
    type: time
    timeframes: [raw, date]
    label: "Engagement SoW Drafted"
    hidden: yes
    sql: ${TABLE}.dt_entered_3_sow_drafted ;;
  }

  dimension_group: dt_entered_5_customer_agreed_sow {
    type: time
    timeframes: [raw, date]
    label: "Engagement SoW Agreed"
    hidden: yes
    sql: timestamp(${TABLE}.dt_entered_5_customer_agreed_sow) ;;
  }

  dimension_group: dt_entered_7_sow_customer_docusigned {
    type: time
    timeframes: [raw, date]
    label: "Engagement SoW Signed"
    hidden: yes
    sql: ${TABLE}.dt_entered_7_sow_customer_docusigned ;;
  }

  dimension_group: engagement_end_ts {
    type: time
    timeframes: [raw, date, month, quarter, year]
    label: "Engagement End"
    sql: ${TABLE}.engagement_end_ts ;;
  }

  dimension_group: engagement_start_ts {
    type: time
    timeframes: [raw, date, month, quarter, year]
    label: "Engagement Start"
    sql: ${TABLE}.engagement_start_ts ;;
  }

  dimension_group: last_engagement_billable_timesheet {
    type: time
    timeframes: [raw, date]
    group_label: "Engagement Details"
    sql: ${TABLE}.last_billable_timesheet_date ;;
  }

  measure: avg_days_deal_created_to_start {
    type: average
    label: "Avg Days Deal Created to Start"
    group_label: "Engagement Details"
    sql: ${deal_created_days_to_engagement_start} ;;
  }

  measure: avg_days_sow_agreed_to_start {
    type: average
    label: "Avg Days SoW Agreed to Start"
    group_label: "Engagement Details"
    sql: ${sow_agreed_days_to_engagement_start} ;;
  }

  measure: avg_days_sow_drafted_to_start {
    type: average
    label: "Avg Days SoW Drafted to Start"
    group_label: "Engagement Details"
    sql: ${sow_drafted_days_to_engagement_start} ;;
  }

  measure: avg_days_sow_signed_to_start {
    type: average
    label: "Avg Days SoW Signed to Start"
    group_label: "Engagement Details"
    sql: ${sow_signed_days_to_engagement_start} ;;
  }

  measure: avg_days_to_close {
    type: average
    label: "Avg Days to Close"
    group_label: "Engagement Details"
    sql: ${deal_days_to_close} ;;
  }

  measure: avg_deal_amount {
    type: average
    label: "Average Original Deal Amount"
    group_label: "Engagement Details"
    sql: ${deal_amount} ;;
  }

  measure: avg_engagement_hourly_rate {
    type: average
    label: "Avg Engagement Hourly Rate"
    group_label: "Engagement Details"
    sql: ${deal_hourly_rate} ;;
  }

  measure: count {
    type: count
    label: "Total Engagements"
    group_label: "Engagement Details"
  }

  measure: total_engagement_deal_amount {
    type: sum
    label: "Total Engagement Amount"
    group_label: "Engagement Details"
    sql: ${deal_amount} ;;
  }
}
