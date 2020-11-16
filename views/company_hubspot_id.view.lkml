view: company_hubspot_id {
  view_label: "Companies Dim"
  derived_table: {
    sql: select company_pk, company_ids as hubspot_company_id from ra-development.analytics.companies_dim,
      unnest (all_company_ids) as company_ids
      where company_ids like '%hubspot-%'
       ;;
  }



  dimension: company_pk {
    type: string
    hidden: yes
    sql: ${TABLE}.company_pk ;;
  }

  dimension: hubspot_company_id {
    type: string
    hidden: yes

    tags: ["hubspot_company_id"]
    sql: ${TABLE}.hubspot_company_id ;;
  }


}
