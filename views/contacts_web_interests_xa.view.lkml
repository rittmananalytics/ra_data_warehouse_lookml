view: contacts_web_interests_xa {
  sql_table_name: `{{ _user_attributes['dataset'] }}.contacts_web_interests_xa`
    ;;

  measure: attribution_interest {
    group_label: "Contact Interests"
    type: sum
    sql: ${TABLE}.attribution_interest ;;
  }

  measure: bigquery_interest {
    group_label: "Contact Interests"

    type: sum
    sql: ${TABLE}.bigquery_interest ;;
  }

  measure: blog_views {
    group_label: "Contact Interests"

    type: sum
    sql: ${TABLE}.blog_views ;;
  }

  measure: casestudy_views {
    group_label: "Contact Interests"

    type: sum
    sql: ${TABLE}.casestudy_views ;;
  }

  dimension: contact_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.contact_pk ;;
  }

  measure: customer_journey_interest {
    group_label: "Contact Interests"

    type: sum
    sql: ${TABLE}.customer_journey_interest ;;
  }

  measure: data_centralisation_interest {
    group_label: "Contact Interests"

    type: sum
    sql: ${TABLE}.data_centralisation_interest ;;
  }

  measure: data_teams_interest {
    group_label: "Contact Interests"

    type: sum
    sql: ${TABLE}.data_teams_interest ;;
  }

  measure: dbt_interest {
    group_label: "Contact Interests"

    type: sum
    sql: ${TABLE}.dbt_interest ;;
  }

  dimension: last_page_title {
    group_label: "Contact Interests"

    type: string
    sql: ${TABLE}.last_page_title ;;
  }

  dimension_group: last_visit {
    group_label: "Contact Interests"

    type: time
    timeframes: [
      date
    ]
    sql: ${TABLE}.last_visit_ts ;;
  }

  measure: looker_interest {
    group_label: "Contact Interests"

    type: sum
    sql: ${TABLE}.looker_interest ;;
  }

  measure: marketing_analytics_interest {
    group_label: "Contact Interests"

    type: sum
    sql: ${TABLE}.marketing_analytics_interest ;;
  }

  measure: martech_interest {
    group_label: "Contact Interests"

    type: sum
    sql: ${TABLE}.martech_interest ;;
  }

  measure: modern_data_stack_interest {
    group_label: "Contact Interests"

    type: sum
    sql: ${TABLE}.modern_data_stack_interest ;;
  }

  measure: oawc_interest {
    group_label: "Contact Interests"

    type: sum
    sql: ${TABLE}.oawc_interest ;;
  }

  measure: personas_interest {
    group_label: "Contact Interests"

    type: sum
    sql: ${TABLE}.personas_interest ;;
  }

  measure: podcast_views {
    group_label: "Contact Interests"

    type: sum
    sql: ${TABLE}.podcast_views ;;
  }

  measure: pricing_views {
    group_label: "Contact Interests"

    type: sum
    sql: ${TABLE}.pricing_views ;;
  }

  measure: ra_warehouse_interest {
    group_label: "Contact Interests"

    type: sum
    sql: ${TABLE}.ra_warehouse_interest ;;
  }

  measure: segment_interest {
    group_label: "Contact Interests"

    type: sum
    sql: ${TABLE}.segment_interest ;;
  }

  measure: startup_interest {
    group_label: "Contact Interests"

    type: sum
    sql: ${TABLE}.startup_interest ;;
  }

  measure: visits_l90_days {
    group_label: "Contact Interests"

    type: sum
    sql: ${TABLE}.visits_l90_days ;;
  }


}