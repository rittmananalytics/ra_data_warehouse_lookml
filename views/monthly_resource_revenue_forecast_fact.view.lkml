view: monthly_resource_revenue_forecast_fact {
  view_label: "Monthly Forecast"
    derived_table: {
      sql: select * from ra-development.analytics.monthly_resource_planning_forecast_fact ;;
    }

  parameter: selected_measure {
    type: unquoted
    allowed_value: {
      label: "Total Forecast Revenue (GBP)"
      value: "total_forecast_revenue_gbp"
    }
    allowed_value: {
      label: "Total Forecast Monthly Hours"
      value: "total_forecast_monthly_hours"
    }
    allowed_value: {
      label: "Total Weighted Forecast Monthly Hours"
      value: "total_weighted_forecast_monthly_hours"
    }
    allowed_value: {
      label: "Total Forecast SAC FTE"
      value: "total_forecast_sac_fte"
    }
    allowed_value: {
      label: "Total Forecast Weighted SAC FTE"
      value: "total_forecast_weighted_sac_fte"
    }
    allowed_value: {
      label: "Average Forecast Hourly Rate"
      value: "avg_forecast_hourly_rate"
    }
  }

  # Parameter to allow user to select a dimension to split the measure by
  parameter: selected_split {
    type: unquoted
    allowed_value: {
      label: "Forecast Type"
      value: "forecast_type"
    }
    allowed_value: {
      label: "Engagement Name"
      value: "engagement_name"
    }
    allowed_value: {
      label: "Deal Partner Referral"
      value: "deal_partner_referral"
    }
    allowed_value: {
      label: "Deal Source"
      value: "deal_source"
    }
  }

  # Dynamic measure that changes based on the 'selected_measure' parameter
  measure: dynamic_measure {
    label: "Selected Measure"
    type: number
    sql:
        {% if selected_measure._parameter_value == 'total_forecast_revenue_gbp' %}
          ${total_forecast_revenue_gbp}
        {% elsif selected_measure._parameter_value == 'total_forecast_monthly_hours' %}
          ${total_forecast_monthly_hours}
        {% elsif selected_measure._parameter_value == 'total_weighted_forecast_monthly_hours' %}
          ${total_weighted_forecast_monthly_hours}
        {% elsif selected_measure._parameter_value == 'total_forecast_sac_fte' %}
          ${total_forecast_sac_fte}
        {% elsif selected_measure._parameter_value == 'total_forecast_weighted_sac_fte' %}
          ${total_forecast_weighted_sac_fte}
        {% elsif selected_measure._parameter_value == 'avg_forecast_hourly_rate' %}
          ${avg_forecast_hourly_rate}
        {% else %}
          NULL
        {% endif %} ;;
    value_format_name: decimal_2
  }

  # Dynamic dimension that changes based on the 'selected_split' parameter
  dimension: dynamic_split {
    label: "Selected Split"
    sql:
        {% if selected_split._parameter_value == 'forecast_type' %}
          ${forecast_type}
        {% elsif selected_split._parameter_value == 'engagement_name' %}
          ${engagement_name}
        {% elsif selected_split._parameter_value == 'deal_partner_referral' %}
          ${deal_partner_referral}
        {% elsif selected_split._parameter_value == 'deal_source' %}
          ${deal_source}
        {% else %}
          ''
        {% endif %} ;;
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
      timeframes: [raw,month,quarter,year,month_num]
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

  dimension: forecasted_weighted_monthly_hours {
    type: number
    hidden: yes
    sql: ${TABLE}.forecasted_weighted_monthly_hours ;;
  }



    measure: total_forecast_monthly_hours {
      type: sum
      sql: ${forecasted_monthly_hours} ;;
    }

  measure: total_weighted_forecast_monthly_hours {
    type: sum
    value_format_name: decimal_0
    sql: ${forecasted_weighted_monthly_hours} ;;
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
      value_format_name: decimal_1
      sql: ${forecasted_sac_fte} ;;
    }

  dimension: forecasted_weighted_sac_fte {
    type: number
    hidden: yes
    sql: ${TABLE}.forecasted_weighted_sac_fte ;;
  }

  measure: total_forecast_weighted_sac_fte {
    type: sum
    value_format_name: decimal_1

    sql: ${forecasted_weighted_sac_fte} ;;
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
