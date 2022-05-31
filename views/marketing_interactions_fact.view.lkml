# The name of this view in Looker is "Marketing Interactions Fact"
view: marketing_interactions_fact {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics.marketing_interactions_fact`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Contact ID" in Explore.

  dimension: contact_id {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_id ;;
  }

  dimension: contact_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.contact_pk ;;
  }

  dimension: interaction_content_id {
    hidden: yes

    type: string
    sql: ${TABLE}.interaction_content_id ;;
  }

  dimension: interaction_event_details {
    type: string
    sql: ${TABLE}.interaction_event_details ;;
  }

  dimension: interaction_event_name {
    type: string
    sql: ${TABLE}.interaction_event_name ;;
  }

  measure: total_likes {
    type: count_distinct
    sql: ${marketing_interaction_pk} ;;
    filters: [interaction_event_name: "like"]
  }

  measure: total_comments {
    type: count_distinct
    sql: ${marketing_interaction_pk} ;;
    filters: [interaction_event_name: "comment"]
  }

  measure: total_follows {
    type: count_distinct
    sql: ${marketing_interaction_pk} ;;
    filters: [interaction_event_name: "follow"]
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: interaction_event_ts {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.interaction_event_ts ;;
  }

  dimension: platform_name {
    type: string
    sql: ${TABLE}.interaction_content_platform ;;
  }

  dimension: marketing_content_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.marketing_content_pk ;;
  }

  dimension: marketing_interaction_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.marketing_interaction_pk ;;
  }

  measure: count_interactions {
    hidden: no


    type: count_distinct
    sql: ${marketing_interaction_pk} ;;
    drill_fields: [interaction_event_name]
  }
}
