view: contacts_segments_xa {
  sql_table_name: `{{ _user_attributes['dataset'] }}.contacts_segments_xa`
    ;;

  dimension: buying_stage {
    group_label: "Contact Analytics"

    type: string
    sql: ${TABLE}.buying_stage ;;
  }

  dimension: contact_segment {
    group_label: "Contact Analytics"

    type: string
    sql: ${TABLE}.contact_segment ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: engagement_level {
    group_label: "Contact Analytics"

    type: string
    sql: ${TABLE}.engagement_level ;;
  }

  dimension: segment_name {
    group_label: "Contact Analytics"

    type: string
    sql: ${TABLE}.name ;;
  }


}
