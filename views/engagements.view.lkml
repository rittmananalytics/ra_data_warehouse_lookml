view: engagements {
    derived_table: {
      sql: select * except(projects) from analytics.timesheet_project_engagements_dim,
        unnest(projects) as projects ;;
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
      type: string
      sql: ${TABLE}.engagement_code ;;
    }

    dimension: company_fk {
      hidden: yes
      type: string
      sql: ${TABLE}.company_fk ;;
    }

    dimension_group: engagement_start_ts {
      type: time
      timeframes: [date,month,quarter,year]
      sql: timestamp(${TABLE}.engagement_start_ts) ;;
    }

    dimension_group: engagement_end_ts {
      type: time
      timeframes: [date,month,quarter,year]
      sql: timestamp(${TABLE}.engagement_end_ts);;
    }

    dimension: deal_id {
      type: number
      sql: ${TABLE}.deal_id ;;
    }

    dimension: deal_amount {
      type: number
      hidden: yes
      sql: ${TABLE}.deal_amount ;;
    }

    dimension: deal_description {
      type: string
      sql: ${TABLE}.deal_description ;;
    }

    measure: total_engagement_deal_amount {
      type: sum
      sql: ${deal_amount} ;;
    }

    dimension: deal_name {
      type: string
      sql: ${TABLE}.deal_name ;;
    }

    dimension: deal_type {
      type: string
      sql: ${TABLE}.deal_type ;;
    }

    dimension: deal_days_to_close {
      type: number
      hidden: yes
      sql: ${TABLE}.deal_days_to_close ;;
    }

    measure: avg_days_to_close {
      type: average
      sql: ${deal_days_to_close} ;;
    }

    dimension_group: deal_created {
      type: time
      timeframes: [date]
      sql: ${TABLE}.deal_created_ts ;;
    }

    dimension_group: deal_closed {
      type: time
      timeframes: [date]
      sql: ${TABLE}.deal_closed_ts ;;
    }

    dimension: timesheet_project_pk {
      type: string
      hidden: yes
      sql: ${TABLE}.timesheet_project_pk ;;
    }

    dimension: project_name {
      type: string
      sql: ${TABLE}.project_name ;;
    }

    dimension_group: project_delivery_start {
      type: time
      timeframes: [date]
      sql: timestamp(${TABLE}.project_delivery_start_ts) ;;
    }

    dimension_group: project_delivery_end {
      type: time
      timeframes: [date]
      sql: timestamp(${TABLE}.project_delivery_end_ts);;
    }


  }
