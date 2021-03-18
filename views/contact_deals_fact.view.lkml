view: contact_deals_fact {
  sql_table_name: `{{ _user_attributes['dataset'] }}.contact_deals_fact`
    ;;

  dimension: contact_deal_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_deal_pk ;;
  }

  dimension: contact_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.contact_pk ;;
  }

  dimension: deal_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.deal_pk ;;
  }


}
