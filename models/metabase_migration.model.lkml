connection: "ra_dw_prod"

include: "/metabase_migration/views/*.view.lkml"
include: "/metabase_migration/dashboards/*.dashboard.lookml"

explore: bounced_session_rate_by_channel {
  label: "Bounced Session Rate by Channel"
}

explore: sessions_by_month {
  label: "Sessions by Month"
}

explore: web_sessions_fact {
  label: "Web Sessions Fact"
}
