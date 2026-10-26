view: monthly_performance_fact {
  sql_table_name: `ra-development.analytics.monthly_performance_fact` ;;

  dimension: average_average_nps_survey_score {
    type: number
    label: "average_average_nps_survey_score"
    sql: ${TABLE}.average_average_nps_survey_score ;;
  }

  dimension: date_spine_dim_date_month {
    type: string
    label: "date_spine_dim_date_month"
    sql: ${TABLE}.date_spine_dim_date_month ;;
  }

  dimension: month {
    type: string
    label: "Month"
    sql: CAST(CONCAT(${date_spine_dim_date_month}, '-01') AS DATE) ;;
  }

  dimension: pct_blog_page_views_of_all_page_views {
    type: number
    label: "pct_blog_page_views_of_all_page_views"
    sql: ${TABLE}.pct_blog_page_views_of_all_page_views ;;
  }

  dimension: pct_cost_of_delivery {
    type: number
    label: "pct_cost_of_delivery"
    sql: ${TABLE}.pct_cost_of_delivery ;;
  }

  dimension: pct_cost_of_overheads {
    type: number
    label: "pct_cost_of_overheads"
    sql: ${TABLE}.pct_cost_of_overheads ;;
  }

  dimension: pct_delivery_team_utilization {
    type: number
    label: "pct_delivery_team_utilization"
    sql: ${TABLE}.pct_delivery_team_utilization ;;
  }

  dimension: pct_marketing_page_views_of_all_page_views {
    type: number
    label: "pct_marketing_page_views_of_all_page_views"
    sql: ${TABLE}.pct_marketing_page_views_of_all_page_views ;;
  }

  dimension: pct_new_sales_leads_to_target {
    type: number
    label: "pct_new_sales_leads_to_target"
    sql: ${TABLE}.pct_new_sales_leads_to_target ;;
  }

  dimension: pct_profit_to_target {
    type: number
    label: "pct_profit_to_target"
    sql: ${TABLE}.pct_profit_to_target ;;
  }

  dimension: pct_revenue_to_target {
    type: number
    label: "pct_revenue_to_target"
    sql: ${TABLE}.pct_revenue_to_target ;;
  }

  dimension: pct_services_page_views_of_all_page_views {
    type: number
    label: "pct_services_page_views_of_all_page_views"
    sql: ${TABLE}.pct_services_page_views_of_all_page_views ;;
  }

  dimension: pct_won_deal_amount_to_target {
    type: number
    label: "pct_won_deal_amount_to_target"
    sql: ${TABLE}.pct_won_deal_amount_to_target ;;
  }

  dimension: total_closed_opportunities_revenue_gbp_target {
    type: number
    label: "total_closed_opportunities_revenue_gbp_target"
    sql: ${TABLE}.total_closed_opportunities_revenue_gbp_target ;;
  }

  dimension: total_cost_of_delivery_gbp {
    type: number
    label: "total_cost_of_delivery_gbp"
    sql: ${TABLE}.total_cost_of_delivery_gbp ;;
  }

  dimension: total_cost_of_overheads_gbp {
    type: number
    label: "total_cost_of_overheads_gbp"
    sql: ${TABLE}.total_cost_of_overheads_gbp ;;
  }

  dimension: total_delivery_tickets {
    type: number
    label: "total_delivery_tickets"
    sql: ${TABLE}.total_delivery_tickets ;;
  }

  dimension: total_delivery_tickets_completed {
    type: number
    label: "total_delivery_tickets_completed"
    sql: ${TABLE}.total_delivery_tickets_completed ;;
  }

  dimension: total_delivery_tickets_in_progress {
    type: number
    label: "total_delivery_tickets_in_progress"
    sql: ${TABLE}.total_delivery_tickets_in_progress ;;
  }

  dimension: total_delivery_tickets_not_yet_started {
    type: number
    label: "total_delivery_tickets_not_yet_started"
    sql: ${TABLE}.total_delivery_tickets_not_yet_started ;;
  }

  dimension: total_lost_opportunity_amount_gbp {
    type: number
    label: "total_lost_opportunity_amount_gbp"
    sql: ${TABLE}.total_lost_opportunity_amount_gbp ;;
  }

  dimension: total_lost_oppportunities {
    type: number
    label: "total_lost_oppportunities"
    sql: ${TABLE}.total_lost_oppportunities ;;
  }

  dimension: total_net_profit_gbp {
    type: number
    label: "total_net_profit_gbp"
    sql: ${TABLE}.total_net_profit_gbp ;;
  }

  dimension: total_new_cdp_nsales_leads {
    type: number
    label: "total_new_cdp_nsales_leads"
    sql: ${TABLE}.total_new_cdp_nsales_leads ;;
  }

  dimension: total_new_data_centralization_sales_leads {
    type: number
    label: "total_new_data_centralization_sales_leads"
    sql: ${TABLE}.total_new_data_centralization_sales_leads ;;
  }

  dimension: total_new_marketing_analytics_sales_leads {
    type: number
    label: "total_new_marketing_analytics_sales_leads"
    sql: ${TABLE}.total_new_marketing_analytics_sales_leads ;;
  }

  dimension: total_nps_survey_results_received {
    type: number
    label: "total_nps_survey_results_received"
    sql: ${TABLE}.total_nps_survey_results_received ;;
  }

  dimension: total_opportunities {
    type: number
    label: "total_opportunities"
    sql: ${TABLE}.total_opportunities ;;
  }

  dimension: total_opportunities_revenue_gbp_target {
    type: number
    label: "total_opportunities_revenue_gbp_target"
    sql: ${TABLE}.total_opportunities_revenue_gbp_target ;;
  }

  dimension: total_opportunity_amount_gbp {
    type: number
    label: "total_opportunity_amount_gbp"
    sql: ${TABLE}.total_opportunity_amount_gbp ;;
  }

  dimension: total_other_new_sales_leads {
    type: number
    label: "total_other_new_sales_leads"
    sql: ${TABLE}.total_other_new_sales_leads ;;
  }

  dimension: total_profit_gbp_target {
    type: number
    label: "total_profit_gbp_target"
    sql: ${TABLE}.total_profit_gbp_target ;;
  }

  dimension: total_revenue_gbp {
    type: number
    label: "total_revenue_gbp"
    sql: ${TABLE}.total_revenue_gbp ;;
  }

  dimension: total_revenue_gbp_target {
    type: number
    label: "total_revenue_gbp_target"
    sql: ${TABLE}.total_revenue_gbp_target ;;
  }

  dimension: total_sales_leads_target {
    type: number
    label: "total_sales_leads_target"
    sql: ${TABLE}.total_sales_leads_target ;;
  }

  dimension: total_timesheet_billable_hours_billed {
    type: number
    label: "total_timesheet_billable_hours_billed"
    sql: ${TABLE}.total_timesheet_billable_hours_billed ;;
  }

  dimension: total_timesheet_cost_amount_gbp {
    type: number
    label: "total_timesheet_cost_amount_gbp"
    sql: ${TABLE}.total_timesheet_cost_amount_gbp ;;
  }

  dimension: total_timesheet_hours_billed {
    type: number
    label: "total_timesheet_hours_billed"
    sql: ${TABLE}.total_timesheet_hours_billed ;;
  }

  dimension: total_timesheet_nonbillable_hours_billed {
    type: number
    label: "total_timesheet_nonbillable_hours_billed"
    sql: ${TABLE}.total_timesheet_nonbillable_hours_billed ;;
  }

  dimension: total_unique_website_users {
    type: number
    label: "total_unique_website_users"
    sql: ${TABLE}.total_unique_website_users ;;
  }

  dimension: total_website_blog_page_views {
    type: number
    label: "total_website_blog_page_views"
    sql: ${TABLE}.total_website_blog_page_views ;;
  }

  dimension: total_website_case_study_page_views {
    type: number
    label: "total_website_case_study_page_views"
    sql: ${TABLE}.total_website_case_study_page_views ;;
  }

  dimension: total_website_marketing_page_views {
    type: number
    label: "total_website_marketing_page_views"
    sql: ${TABLE}.total_website_marketing_page_views ;;
  }

  dimension: total_website_meeting_bookings {
    type: number
    label: "total_website_meeting_bookings"
    sql: ${TABLE}.total_website_meeting_bookings ;;
  }

  dimension: total_website_page_views {
    type: number
    label: "total_website_page_views"
    sql: ${TABLE}.total_website_page_views ;;
  }

  dimension: total_website_services_page_views {
    type: number
    label: "total_website_services_page_views"
    sql: ${TABLE}.total_website_services_page_views ;;
  }

  dimension: total_website_sessions {
    type: number
    label: "total_website_sessions"
    sql: ${TABLE}.total_website_sessions ;;
  }

  dimension: total_weighted_opportunity_pipeline_amount_gbp {
    type: number
    label: "total_weighted_opportunity_pipeline_amount_gbp"
    sql: ${TABLE}.total_weighted_opportunity_pipeline_amount_gbp ;;
  }

  dimension: total_won_opportunity_amount_gbp {
    type: number
    label: "total_won_opportunity_amount_gbp"
    sql: ${TABLE}.total_won_opportunity_amount_gbp ;;
  }

  dimension: total_won_oppportunities {
    type: number
    label: "total_won_oppportunities"
    sql: ${TABLE}.total_won_oppportunities ;;
  }

  dimension_group: month_as_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    datatype: date
    convert_tz: no
    label: "Month (as date)"
    sql: DATE(SAFE_CAST(${TABLE}.Month AS TIMESTAMP)) ;;
  }

  measure: total_total_won_opportunity_amount_gbp {
    type: sum
    label: "total_won_opportunity_amount_gbp (sum)"
    sql: ${total_won_opportunity_amount_gbp} ;;
  }
}
