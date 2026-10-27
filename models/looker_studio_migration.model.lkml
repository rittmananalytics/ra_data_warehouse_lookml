connection: "ra_dw_prod"

include: "/looker_studio_migration/views/*.view.lkml"
include: "/looker_studio_migration/dashboards/*.dashboard.lookml"

explore: bigquery_custom_sql {
  label: "BigQuery Custom SQL"
}

explore: delivery_kpis {
  label: "delivery_kpis"
}

# Added from the live capture of "Stack Overflow - Rittman" (Wire looker_studio_to_looker, 26 Oct 2026)
explore: avg_views_per_question {
  label: "avg_views_per_question"
}

explore: day_of_week {
  label: "day_of_week"
}

explore: hour_of_day {
  label: "hour_of_day"
}

explore: locations {
  label: "locations"
}

explore: most_recent_questions {
  label: "most_recent_questions"
}

explore: top_10_tags {
  label: "top_10_tags"
}

explore: unanswered_questions_facts {
  label: "unanswered_questions_facts"
}

explore: user_buckets {
  label: "user_buckets"
}

explore: worst_users {
  label: "worst_users"
}

# Added from the live capture of "Ethereum Dataset Demo" (Wire looker_studio_to_looker, 27 Oct 2026)
explore: blocks {
  label: "blocks"
}

explore: transactions {
  label: "transactions"
}
