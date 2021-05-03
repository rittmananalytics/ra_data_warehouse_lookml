connection: "ra_dw_prod"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project


fiscal_month_offset: -3





explore: actuals_vs_budget {
  label: "Finance"
  hidden: no

}

explore: consultant_revenue_attribution {}



explore: actuals_v_targets {
  hidden: no

}
