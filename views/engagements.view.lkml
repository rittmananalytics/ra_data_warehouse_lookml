view: engagements {
    derived_table: {
      sql: select project_engagement_pk, engagement_code, company_fk, engagement_start_ts, engagement_end_ts, deal_id, deal_amount, deal_description, deal_name, deal_type, deal_partner_referral, deal_source, deal_days_to_close, deal_created_ts, dt_entered_3_sow_drafted, dt_entered_5_customer_agreed_sow, dt_entered_7_sow_customer_docusigned, deal_closed_ts from analytics.timesheet_project_engagements_dim
        group by all ;;
    }

    measure: count {
      type: count

    }

    dimension: project_engagement_pk {
      type: string
      hidden: yes
      primary_key: yes
      sql: ${TABLE}.project_engagement_pk ;;
    }

    dimension: engagement_code {
      hidden: yes

      type: string
      sql: ${TABLE}.engagement_code ;;
    }

    dimension: company_fk {
      hidden: yes
      type: string
      sql: ${TABLE}.company_fk ;;
    }

  dimension_group: dt_entered_3_sow_drafted {

    label: "Engagement SoW Drafted"
    type: time
    timeframes: [date]
    sql: ${TABLE}.dt_entered_3_sow_drafted ;;
  }

  dimension: sow_drafted_days_to_engagement_start {
    hidden: yes

    type: number
    sql: DATE_DIFF(timestamp(${TABLE}.engagement_start_ts),timestamp(${TABLE}.dt_entered_3_sow_drafted),DAY) ;;
  }

  dimension_group: dt_entered_5_customer_agreed_sow {

    label: "Engagement SoW Agreed"
    type: time
    timeframes: [date]
    sql: timestamp(${TABLE}.dt_entered_5_customer_agreed_sow) ;;
  }

  dimension: sow_agreed_days_to_engagement_start {
    hidden: yes

    type: number
    sql: DATE_DIFF(timestamp(${TABLE}.engagement_start_ts),timestamp(${TABLE}.dt_entered_5_customer_agreed_sow),DAY) ;;
  }

  dimension_group: dt_entered_7_sow_customer_docusigned {

    label: "Engagement SoW Signed"
    hidden: yes

    type: time
    timeframes: [date]
    sql: ${TABLE}.dt_entered_7_sow_customer_docusigned ;;
  }

  dimension: sow_signed_days_to_engagement_start {
    hidden: yes
    type: number
    sql: DATE_DIFF(timestamp(${TABLE}.engagement_start_ts),timestamp(${TABLE}.dt_entered_7_sow_customer_docusigned),DAY) ;;
  }

  dimension: deal_created_days_to_engagement_start {
    hidden: yes

    type: number
    sql: DATE_DIFF(timestamp(${TABLE}.engagement_start_ts),timestamp(${TABLE}.deal_created_ts),DAY) ;;
  }


    dimension_group: engagement_start_ts {
      label: "Engagement Start"
      type: time
      timeframes: [date,month,quarter,year]
      sql: timestamp(${TABLE}.engagement_start_ts) ;;
    }

    dimension_group: engagement_end_ts {
      label: "Engagement End"

      type: time
      timeframes: [date,month,quarter,year]
      sql: timestamp(${TABLE}.engagement_end_ts);;
    }

    dimension: deal_id {
      hidden: yes

      type: number
      sql: ${TABLE}.deal_id ;;
    }

    dimension: deal_amount {
      label: "Original Engagement Deal Amount"
      hidden: yes
      type: number
      hidden: yes
      sql: ${TABLE}.deal_amount ;;
    }

    dimension: deal_description {
      label: "Engagement Description"
      type: string
      sql: ${TABLE}.deal_description ;;
    }

    measure: total_engagement_deal_amount {
      type: sum
      sql: ${deal_amount} ;;
    }

    dimension: deal_name {
      label: "Engagement Name"

      type: string
      sql: ${TABLE}.deal_name ;;
    }

    dimension: deal_type {
      label: "Original Engagement Deal Type"

      type: string
      sql: ${TABLE}.deal_type ;;
    }

    dimension: deal_days_to_close {
      label: "Original Engagement Deal Closed"

      type: number
      hidden: yes
      sql: ${TABLE}.deal_days_to_close ;;
    }

    measure: avg_days_to_close {
      label: "Original Engagement Deal Avg Days to Close"

      type: average
      sql: ${deal_days_to_close} ;;
    }

    measure: avg_days_sow_drafted_to_start {
      label: "Original Engagement Deal Avg Days SoW Drafted to Start"

      type: average
      sql: ${sow_drafted_days_to_engagement_start} ;;
    }

  measure: avg_days_sow_agreed_to_start {
    label: "Original Engagement Deal Avg Days SoW Agreed to Start"

    type: average
    sql: ${sow_agreed_days_to_engagement_start} ;;
  }

  measure: avg_days_sow_signed_to_start {
    label: "Original Engagement Deal Avg Days SoW Signed to Start"

    type: average
    sql: ${sow_signed_days_to_engagement_start} ;;
  }

  measure: avg_days_deal_created_to_start {
    label: "Original Engagement Deal Avg Days Deal Created to Start"

    type: average
    sql: ${deal_created_days_to_engagement_start} ;;
  }

    dimension_group: deal_created {
      label: "Original Engagement Deal Created"

      type: time
      timeframes: [date]
      sql: ${TABLE}.deal_created_ts ;;
    }

    dimension_group: deal_closed {
      label: "Original Engagement Deal Closed"

      type: time
      timeframes: [date]
      sql: ${TABLE}.deal_closed_ts ;;
    }

  dimension: deal_source {
    label: "Original Engagement Deal Source"

    type: string
    sql: ${TABLE}.deal_source ;;
  }

  dimension: deal_partner_referral {
    label: "Original Engagement Deal Partner"

    type: string
    sql: ${TABLE}.deal_partner_referral ;;
  }




  }
