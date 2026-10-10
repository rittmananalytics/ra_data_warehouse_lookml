connection: "ra_dw_prod"

include: "/looker_studio_migration/views/*.view.lkml"
include: "/looker_studio_migration/dashboards/*.dashboard.lookml"

explore: bigquery_custom_sql {
  label: "BigQuery Custom SQL"
}

explore: delivery_kpis {
  label: "delivery_kpis"
}
