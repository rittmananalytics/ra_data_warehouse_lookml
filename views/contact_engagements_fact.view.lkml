view: contact_engagements_fact {
  sql_table_name: `ra-development.analytics.contact_engagements_fact`
    ;;

  dimension: deal_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.deal_pk ;;
  }



  dimension: engagement_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.engagement_pk ;;
  }

  dimension: engagement_title {
    group_label: "        Contact Engagements"

    type: string
    sql: ${TABLE}.engagement_title ;;
  }

  dimension_group: engagement_ts {
    label: "Engagement"
    group_label: "        Contact Engagements"

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
    sql: ${TABLE}.engagement_ts ;;
  }

  dimension: engagment_type {
    group_label: "        Contact Engagements"

    type: string
    sql: ${TABLE}.engagment_type ;;
  }

  dimension: from_contact_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.from_contact_pk ;;
  }

  dimension: to_contact_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.to_contact_pk ;;
  }

  measure: count_engagements {
    group_label: "        Contact Engagements"

    type: count_distinct
    sql: ${TABLE}.engagement_pk;;
    drill_fields: []
  }

  measure: count_meetings {
    group_label: "        Contact Engagements"

    type: count_distinct
    sql: ${TABLE}.engagement_pk;;
    filters: [engagment_type : "MEETING"]
    drill_fields: []
  }


}
