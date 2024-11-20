view: monthly_resource_revenue_forecast_fact {
  view_label: "Monthly Forecast"
    derived_table: {
      sql: select * from ra-development.analytics.monthly_resource_planning_forecast_fact ;;
    }



    dimension: forecast_pk {
      hidden: yes
      primary_key: yes
      type: string
      sql: ${TABLE}.forecast_pk ;;
    }

    dimension: engagement_name {
      type: string
      sql: ${TABLE}.engagement_name ;;
    }

    dimension: deal_partner_referral {
      type: string
      sql: ${TABLE}.deal_partner_referral ;;
    }

    dimension: deal_source {
      type: string
      sql: ${TABLE}.deal_source ;;
    }

    dimension_group: forecast {
      type: time
      timeframes: [raw,month,quarter,year]
      datatype: timestamp
      sql: timestamp(${TABLE}.forecast_month) ;;
    }

    dimension: spend_agreed_with_buyer {
      type: yesno
      sql: ${TABLE}.spend_agreed_with_buyer ;;
    }

    dimension: forecast_type {
      type: string
      sql: ${TABLE}.forecast_type ;;
    }

    dimension: buyer_confirmed_budget_available {
      type: yesno
      sql: ${TABLE}.buyer_confirmed_budget_available ;;
    }

    dimension: forecasted_monthly_hours {
      type: number
      hidden: yes
      sql: ${TABLE}.forecasted_monthly_hours ;;
    }

    measure: total_forecast_monthly_hours {
      type: sum
      sql: ${forecasted_monthly_hours} ;;
    }

    dimension: forecast_monthly_deal_revenue_gbp {
      type: number
      hidden: yes

      sql: ${TABLE}.forecast_monthly_deal_revenue_gbp ;;
    }

    measure: total_forecast_revenue_gbp {
      type: sum
      value_format_name: gbp_0
      sql: ${forecast_monthly_deal_revenue_gbp} ;;
    }

    dimension: forecasted_sac_fte {
      type: number
      hidden: yes
      sql: ${TABLE}.forecasted_sac_fte ;;
    }

    measure: total_forecast_sac_fte {
      type: sum
      sql: ${forecasted_sac_fte} ;;
    }

    dimension: forecast_hourly_deal_rate {
      type: number
      hidden: yes
      sql: ${TABLE}.forecast_hourly_deal_rate ;;
    }

    measure: avg_forecast_hourly_rate {
      type: average
      sql: ${forecast_hourly_deal_rate} ;;
    }

    set: detail {
      fields: [
        forecast_pk,
        engagement_name,
        deal_partner_referral,
        deal_source,
        forecast_month,
        spend_agreed_with_buyer,
        forecast_type,
        buyer_confirmed_budget_available,
        forecasted_monthly_hours,
        forecast_monthly_deal_revenue_gbp,
        forecasted_sac_fte,
        forecast_hourly_deal_rate
      ]
    }
  }
