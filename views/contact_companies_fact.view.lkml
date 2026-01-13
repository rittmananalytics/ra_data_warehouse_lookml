view: contact_companies_fact {
  sql_table_name: `{{ _user_attributes['dataset'] }}.contact_companies_fact`
    ;;

  dimension: company_fk {
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

  dimension: contact_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_fk ;;
  }

  dimension_group: company_contact_from_ts {
    group_label: "      Contact Details"

    label: "Company Contact From"
    hidden: no
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.company_contact_from_ts ;;
  }

  dimension_group: company_contact_to_ts {
    group_label: "      Contact Details"

    label: "Company Contact To"
    hidden: no
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.company_contact_to_ts ;;
  }


}
