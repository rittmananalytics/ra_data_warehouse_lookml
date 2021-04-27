connection: "ra_dw_prod"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
test: monthly_deal_target_within_range {
  explore_source: actuals_v_targets {
    column: deals_target {}
    column: revenue_target {}
    column: month_month {}
    sorts: [month_month: asc]
    limit: 1
  }
  assert: deal_2x_revenue {
    expression: ${actuals_v_targets.deals_target}/${actuals_v_targets.revenue_target} <= 2 ;;
  }
}

fiscal_month_offset: -3





explore: actuals_vs_budget {
  label: "Finance"
  hidden: no

}

explore: consultant_revenue_attribution {}



explore: actuals_v_targets {
  hidden: no

}
