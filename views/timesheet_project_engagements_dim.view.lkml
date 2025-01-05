# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
explore: timesheet_project_engagements_dim {
  hidden: yes
    join: timesheet_project_engagements_dim__projects {
      view_label: "Timesheet Project Engagements Dim: Projects"
      sql: LEFT JOIN UNNEST(${timesheet_project_engagements_dim.projects}) as timesheet_project_engagements_dim__projects ;;
      relationship: one_to_many
    }
}
view: timesheet_project_engagements_dim {
  sql_table_name: `ra-development.analytics.timesheet_project_engagements_dim` ;;

  dimension: company_fk {
    type: string
    sql: ${TABLE}.company_fk ;;
  }
  dimension: deal_amount {
    type: number
    sql: ${TABLE}.deal_amount ;;
  }
  dimension_group: deal_closed_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.deal_closed_ts ;;
  }
  dimension_group: deal_created_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.deal_created_ts ;;
  }
  dimension: deal_days_to_close {
    type: number
    sql: ${TABLE}.deal_days_to_close ;;
  }
  dimension: deal_description {
    type: string
    sql: ${TABLE}.deal_description ;;
  }
  dimension: deal_id {
    type: number
    sql: ${TABLE}.deal_id ;;
  }
  dimension: deal_name {
    type: string
    sql: ${TABLE}.deal_name ;;
  }
  dimension: deal_partner_referral {
    type: string
    sql: ${TABLE}.deal_partner_referral ;;
  }
  dimension: deal_source {
    type: string
    sql: ${TABLE}.deal_source ;;
  }
  dimension: deal_type {
    type: string
    sql: ${TABLE}.deal_type ;;
  }
  dimension_group: dt_entered_3_sow_drafted {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.dt_entered_3_sow_drafted ;;
  }
  dimension_group: dt_entered_5_customer_agreed_sow {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.dt_entered_5_customer_agreed_sow ;;
  }
  dimension_group: dt_entered_7_sow_customer_docusigned {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.dt_entered_7_sow_customer_docusigned ;;
  }
  dimension: engagement_code {
    type: string
    sql: ${TABLE}.engagement_code ;;
  }
  dimension: engagement_end_ts {
    type: string
    sql: ${TABLE}.engagement_end_ts ;;
  }
  dimension: engagement_start_ts {
    type: string
    sql: ${TABLE}.engagement_start_ts ;;
  }
  dimension: project_engagement_pk {
    type: string
    sql: ${TABLE}.project_engagement_pk ;;
  }
  dimension: projects {
    hidden: yes
    sql: ${TABLE}.projects ;;
  }
  measure: count {
    type: count
    drill_fields: [deal_name]
  }
}

view: timesheet_project_engagements_dim__projects {
  drill_fields: [timesheet_project_pk]

  dimension: timesheet_project_pk {
    primary_key: yes
    type: string
    sql: timesheet_project_pk ;;
  }
  dimension: project_delivery_end_ts {
    type: string
    sql: project_delivery_end_ts ;;
  }
  dimension: project_delivery_start_ts {
    type: string
    sql: project_delivery_start_ts ;;
  }
  dimension: project_name {
    type: string
    sql: project_name ;;
  }
  dimension: timesheet_project_engagements_dim__projects {
    type: string
    hidden: yes
    sql: timesheet_project_engagements_dim__projects ;;
  }
}
