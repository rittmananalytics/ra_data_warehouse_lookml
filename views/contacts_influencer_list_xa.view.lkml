view: contacts_influencer_list_xa {
  sql_table_name: `{{ _user_attributes['dataset'] }}.contacts_influencer_list_xa`
    ;;

  dimension: contact_influencer_score {
    group_label: "Contact Analytics"

    type: number
    sql: ${TABLE}.contact_influencer_score ;;
  }

  dimension: contact_name {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_name ;;
  }

  dimension: hubspot_contact_id {
    type: string
    hidden: yes
    sql: ${TABLE}.hubspot_contact_id ;;
  }


  dimension: influencer_status {
    group_label: "Contact Analytics"

    type: string
    sql: ${TABLE}.influencer_status ;;
  }


}
