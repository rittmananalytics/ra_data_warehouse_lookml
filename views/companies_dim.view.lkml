view: companies_dim {
  sql_table_name: `{{ _user_attributes['dataset'] }}.companies_dim`;;

  dimension_group: company_created {
    group_label: "     {{ _view._name| replace: '_', ' ' |
        replace: 'dim', '' | capitalize}}  Company"

    timeframes: [date,month,quarter]
    type: time
    sql: ${TABLE}.company_created_date ;;
  }

  dimension: company_currency_code {
    hidden: yes
    type: string
    sql: ${TABLE}.company_currency_code ;;
  }

  dimension: company_description {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Company"

    type: string
    sql: ${TABLE}.company_description ;;
  }



  dimension: company_finance_status {
    hidden: yes

    type: string
    sql: ${TABLE}.company_finance_status ;;
  }

  dimension: company_industry {
    hidden: no
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Company"

    type: string
    sql: ${TABLE}.company_industry ;;
  }

  dimension_group: company_last_modified {
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
    sql: ${TABLE}.company_last_modified_date ;;
  }

  dimension: company_linkedin_bio {
    hidden: no
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Company"

    type: string
    sql: ${TABLE}.company_linkedin_bio ;;
  }

  dimension: company_linkedin_company_page {
    hidden: no
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Company"

    type: string
    sql: ${TABLE}.company_linkedin_company_page ;;
  }

  dimension: company_name {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Company"

    label: "Company"
    type: string
    sql: case when ${TABLE}.company_name = 'indexlabs.co.uk' then 'Football Index' else ${TABLE}.company_name end;;
}





  dimension: company_phone {
    hidden: yes

    type: string
    sql: ${TABLE}.company_phone ;;
  }

  dimension: company_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.company_pk ;;
  }

  dimension: company_twitterhandle {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Company"

    hidden: no

    type: string
    sql: ${TABLE}.company_twitterhandle ;;
  }

  dimension: company_website {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Company"

    hidden: no

    type: string
    sql: ${TABLE}.company_website ;;
  }

  measure: count {
    group_label: "     {{ _view._name| replace: '_', ' ' | replace: 'dim', '' | capitalize}}  Company"

    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [

      company_name
    ]
  }
}
