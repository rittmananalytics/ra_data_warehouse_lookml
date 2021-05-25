view: contacts_segments_xa {
  sql_table_name: `{{ _user_attributes['dataset'] }}.contacts_segments_xa`
    ;;

  dimension: buying_stage {
    type: string
    sql: ${TABLE}.buying_stage ;;
  }

  dimension: contact_segment {
    type: string
    sql: ${TABLE}.contact_segment ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: engagement_level {
    type: string
    sql: ${TABLE}.engagement_level ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}