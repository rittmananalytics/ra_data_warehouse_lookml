view: icp_lookalike_audience_uk_ie_eu_only {
  sql_table_name: `ra-development.analytics_seed.icp_lookalike_audience_uk_ie_eu_only` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }
  dimension: company {
    type: string
    sql: ${TABLE}.Company ;;
  }
  dimension: data_rich {
    type: string
    sql: ${TABLE}.Data_Rich ;;
  }
  dimension: digitally_native {
    type: string
    sql: ${TABLE}.Digitally_Native ;;
  }
  dimension: domain_name {
    type: string
    sql: ${TABLE}.Domain_Name ;;
  }
  dimension: est_size {
    type: string
    sql: ${TABLE}.Est_Size ;;
  }
  dimension: industry {
    type: string
    sql: ${TABLE}.Industry ;;
  }
  dimension: notes {
    type: string
    sql: ${TABLE}.Notes ;;
  }
  dimension: primary_engagement_strategy {
    type: string
    sql: ${TABLE}.Primary_Engagement_Strategy ;;
  }
  dimension: project_sponsor {
    type: string
    sql: ${TABLE}.Project_Sponsor ;;
  }
  dimension: region {
    type: string
    sql: ${TABLE}.Region ;;
  }
  dimension: sponsor_title {
    type: string
    sql: ${TABLE}.Sponsor_Title ;;
  }
  measure: count {
    type: count
    drill_fields: [id, domain_name]
  }
}
