view: contact_companies_fact {
  sql_table_name: `{{ _user_attributes['dataset'] }}.contact_companies_fact`
    ;;

  dimension: company_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.company_fk ;;
  }

  dimension: contact_company_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_company_pk ;;
  }

  dimension: contact_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_fk ;;
  }


}
