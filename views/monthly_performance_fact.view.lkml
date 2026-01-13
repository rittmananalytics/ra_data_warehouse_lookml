# The name of this view in Looker is "Monthly Performance Fact"
view: monthly_performance_fact {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics.monthly_performance_fact` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Average Average Nps Survey Score" in Explore.

  dimension: average_average_nps_survey_score {
    type: number
    sql: ${TABLE}.average_average_nps_survey_score ;;
  }

  dimension: date_spine_dim_date_month {
    type: string
    sql: ${TABLE}.date_spine_dim_date_month ;;
  }

  dimension: pct_blog_page_views_of_all_page_views {
    type: number
    sql: ${TABLE}.pct_blog_page_views_of_all_page_views ;;
  }

  dimension: pct_cost_of_delivery {
    type: number
    sql: ${TABLE}.pct_cost_of_delivery ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_pct_cost_of_delivery {
    type: sum
    sql: ${pct_cost_of_delivery} ;;  }
  measure: average_pct_cost_of_delivery {
    type: average
    sql: ${pct_cost_of_delivery} ;;  }

  dimension: pct_cost_of_overheads {
    type: number
    sql: ${TABLE}.pct_cost_of_overheads ;;
  }

  dimension: pct_delivery_team_utilization {
    type: number
    sql: ${TABLE}.pct_delivery_team_utilization ;;
  }

  dimension: pct_marketing_page_views_of_all_page_views {
    type: number
    sql: ${TABLE}.pct_marketing_page_views_of_all_page_views ;;
  }

  dimension: pct_new_sales_leads_to_target {
    type: number
    sql: ${TABLE}.pct_new_sales_leads_to_target ;;
  }

  dimension: pct_profit_to_target {
    type: number
    sql: ${TABLE}.pct_profit_to_target ;;
  }

  dimension: pct_revenue_to_target {
    type: number
    sql: ${TABLE}.pct_revenue_to_target ;;
  }

  dimension: pct_services_page_views_of_all_page_views {
    type: number
    sql: ${TABLE}.pct_services_page_views_of_all_page_views ;;
  }

  dimension: pct_won_deal_amount_to_target {
    type: number
    sql: ${TABLE}.pct_won_deal_amount_to_target ;;
  }

  dimension: total_closed_opportunities_revenue_gbp_target {
    type: number
    sql: ${TABLE}.total_closed_opportunities_revenue_gbp_target ;;
  }

  dimension: total_cost_of_delivery_gbp {
    type: number
    sql: ${TABLE}.total_cost_of_delivery_gbp ;;
  }

  dimension: total_cost_of_overheads_gbp {
    type: number
    sql: ${TABLE}.total_cost_of_overheads_gbp ;;
  }

  dimension: total_delivery_tickets {
    type: number
    sql: ${TABLE}.total_delivery_tickets ;;
  }

  dimension: total_delivery_tickets_completed {
    type: number
    sql: ${TABLE}.total_delivery_tickets_completed ;;
  }

  dimension: total_delivery_tickets_in_progress {
    type: number
    sql: ${TABLE}.total_delivery_tickets_in_progress ;;
  }

  dimension: total_delivery_tickets_not_yet_started {
    type: number
    sql: ${TABLE}.total_delivery_tickets_not_yet_started ;;
  }

  dimension: total_lost_opportunity_amount_gbp {
    type: number
    sql: ${TABLE}.total_lost_opportunity_amount_gbp ;;
  }

  dimension: total_lost_oppportunities {
    type: number
    sql: ${TABLE}.total_lost_oppportunities ;;
  }

  dimension: total_net_profit_gbp {
    type: number
    sql: ${TABLE}.total_net_profit_gbp ;;
  }

  dimension: total_new_cdp_nsales_leads {
    type: number
    sql: ${TABLE}.total_new_cdp_nsales_leads ;;
  }

  dimension: total_new_data_centralization_sales_leads {
    type: number
    sql: ${TABLE}.total_new_data_centralization_sales_leads ;;
  }

  dimension: total_new_marketing_analytics_sales_leads {
    type: number
    sql: ${TABLE}.total_new_marketing_analytics_sales_leads ;;
  }

  dimension: total_nps_survey_results_received {
    type: number
    sql: ${TABLE}.total_nps_survey_results_received ;;
  }

  dimension: total_opportunities {
    type: number
    sql: ${TABLE}.total_opportunities ;;
  }

  dimension: total_opportunities_revenue_gbp_target {
    type: number
    sql: ${TABLE}.total_opportunities_revenue_gbp_target ;;
  }

  dimension: total_opportunity_amount_gbp {
    type: number
    sql: ${TABLE}.total_opportunity_amount_gbp ;;
  }

  dimension: total_other_new_sales_leads {
    type: number
    sql: ${TABLE}.total_other_new_sales_leads ;;
  }

  dimension: total_profit_gbp_target {
    type: number
    sql: ${TABLE}.total_profit_gbp_target ;;
  }

  dimension: total_revenue_gbp {
    type: number
    sql: ${TABLE}.total_revenue_gbp ;;
  }

  dimension: total_revenue_gbp_target {
    type: number
    sql: ${TABLE}.total_revenue_gbp_target ;;
  }

  dimension: total_sales_leads_target {
    type: number
    sql: ${TABLE}.total_sales_leads_target ;;
  }

  dimension: total_timesheet_billable_hours_billed {
    type: number
    sql: ${TABLE}.total_timesheet_billable_hours_billed ;;
  }

  dimension: total_timesheet_cost_amount_gbp {
    type: number
    sql: ${TABLE}.total_timesheet_cost_amount_gbp ;;
  }

  dimension: total_timesheet_hours_billed {
    type: number
    sql: ${TABLE}.total_timesheet_hours_billed ;;
  }

  dimension: total_timesheet_nonbillable_hours_billed {
    type: number
    sql: ${TABLE}.total_timesheet_nonbillable_hours_billed ;;
  }

  dimension: total_unique_website_users {
    type: number
    sql: ${TABLE}.total_unique_website_users ;;
  }

  dimension: total_website_blog_page_views {
    type: number
    sql: ${TABLE}.total_website_blog_page_views ;;
  }

  dimension: total_website_case_study_page_views {
    type: number
    sql: ${TABLE}.total_website_case_study_page_views ;;
  }

  dimension: total_website_marketing_page_views {
    type: number
    sql: ${TABLE}.total_website_marketing_page_views ;;
  }

  dimension: total_website_meeting_bookings {
    type: number
    sql: ${TABLE}.total_website_meeting_bookings ;;
  }

  dimension: total_website_page_views {
    type: number
    sql: ${TABLE}.total_website_page_views ;;
  }

  dimension: total_website_services_page_views {
    type: number
    sql: ${TABLE}.total_website_services_page_views ;;
  }

  dimension: total_website_sessions {
    type: number
    sql: ${TABLE}.total_website_sessions ;;
  }

  dimension: total_weighted_opportunity_pipeline_amount_gbp {
    type: number
    sql: ${TABLE}.total_weighted_opportunity_pipeline_amount_gbp ;;
  }

  dimension: total_won_opportunity_amount_gbp {
    type: number
    sql: ${TABLE}.total_won_opportunity_amount_gbp ;;
  }

  dimension: total_won_oppportunities {
    type: number
    sql: ${TABLE}.total_won_oppportunities ;;
  }
  measure: count {
    type: count
  }
}
