connection: "ra_dw_prod"

# include all the views
include: "/views/**/*.view"

datagroup: analytics_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: analytics_default_datagroup


explore: payment_summary {
  #sql_always_where: ${web_sessions_fact.site} = 'www.switcherstudio.com' ;;
  label: "Student Loans"

  join: debt_and_payments {
    sql_on: ${payment_summary.scenario_id} = ${debt_and_payments.scenario_id};;
    type: left_outer
    relationship: one_to_many
  }

}
