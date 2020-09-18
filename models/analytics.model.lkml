connection: "ra_dw_prod"

# include all the views
include: "/views/**/*.view"

datagroup: analytics_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: analytics_default_datagroup



explore: web_sessions_fact {
  #sql_always_where: ${web_sessions_fact.site} = 'www.switcherstudio.com' ;;
  label: "Web Analytics"
  view_label: "  Sessions"

  join: web_events_fact {
    view_label: " Events"
    sql_on: ${web_sessions_fact.session_id} = ${web_events_fact.session_id} ;;
    type: left_outer
    relationship: one_to_many
  }

}
