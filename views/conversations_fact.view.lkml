view: conversations_fact {
  sql_table_name: `{{ _user_attributes['dataset'] }}.conversations_fact`
    ;;

  dimension: company_id {
    hidden: yes
    type: string
    sql: ${TABLE}.company_id ;;
  }

  dimension_group: contact_last_modified {
    hidden: yes

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
    sql: ${TABLE}.contact_last_modified_date ;;
  }

  dimension: contact_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.contact_pk ;;
  }

  dimension: conversation_assignee_state {
    hidden: yes

    type: string
    sql: ${TABLE}.conversation_assignee_state ;;
  }

  dimension: conversation_author_type {
    hidden: yes

    type: string
    sql: ${TABLE}.conversation_author_type ;;
  }

  dimension: conversation_body {
    label: "Engagement Body"
    group_label: "Engagements"
    type: string
    sql: ${TABLE}.conversation_body ;;
  }

  dimension: conversation_excerpt {
    label: "Engagement Excerpt"
    group_label: "Engagements"
    type: string
    sql: substr(${TABLE}.conversation_body,1,100) ;;
  }

dimension: cs_conversation {
  label: "Is Customer Success Engagement"
  group_label: "Engagements"
  type:  string
  sql: CASE when
       ${TABLE}.conversation_subject like '%1-2-1%' OR ${TABLE}.conversation_body like '%Agenda to Follow%'
      then 'Yes'
      else 'No' end;;
}

  dimension_group: conversation_created {
    label: "Engagement"
    group_label: "Engagements"

    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.conversation_created_date ;;
  }

  dimension: conversation_id {
    hidden: yes

    type: string
    sql: ${TABLE}.conversation_id ;;
  }

  dimension: conversation_message_id {
    hidden: yes

    type: string
    sql: ${TABLE}.conversation_message_id ;;
  }

  dimension: conversation_message_type {
    label: "Engagement Type"
    group_label: "Engagements"
    type: string
    sql: replace(initcap(${TABLE}.conversation_message_type),'_',' ') ;;
  }

  measure: count_incoming_messages {
    group_label: "Engagements"
    type: count_distinct
    sql: ${conversation_pk} ;;
    filters: [conversation_message_type: "Incoming Email"]
  }

  measure: count_outgoing_messages {
    group_label: "Engagements"
    type: count_distinct
    sql: ${conversation_pk} ;;
    filters: [conversation_message_type: "Email"]
  }

  dimension: conversation_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.conversation_pk ;;
  }

  dimension: conversation_subject {
    group_label: "Engagements"
    label: "Engagement Subject"
    type: string
    sql: ${TABLE}.conversation_subject ;;
  }

  dimension: conversation_user_type {
    hidden: yes

    type: string
    sql: ${TABLE}.conversation_user_type ;;
  }

  dimension: deal_id {
    hidden: yes

    type: number
    sql: ${TABLE}.deal_id ;;
  }

  dimension: is_conversation_open {
    hidden: yes

    type: yesno
    sql: ${TABLE}.is_conversation_open ;;
  }

  dimension: is_conversation_read {
    hidden: yes

    type: yesno
    sql: ${TABLE}.is_conversation_read ;;
  }


}
