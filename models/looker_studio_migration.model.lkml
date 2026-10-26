connection: "ra_dw_prod"

include: "/looker_studio_migration/views/*.view.lkml"
include: "/looker_studio_migration/dashboards/*.dashboard.lookml"

explore: bigquery_custom_sql {
  label: "BigQuery Custom SQL"
}

explore: delivery_kpis {
  label: "delivery_kpis"
}

# Added by the live capture of "Monthly Performance Report" (Wire looker_studio_to_looker, 26 Oct 2026)
explore: monthly_performance_fact {
  label: "monthly_performance_fact"
}

explore: performance_narrative_fact {
  label: "performance_narrative_fact"
}
