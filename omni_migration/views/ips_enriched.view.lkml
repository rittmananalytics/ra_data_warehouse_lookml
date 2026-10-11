view: ips_enriched {
  sql_table_name: `ra-development.analytics_seed.ips_enriched` ;;

  dimension: asn {
    type: string
    hidden: yes
    sql: ${TABLE}.asn ;;
  }

  dimension: city {
    type: string
    group_label: "IP Enrichment"
    sql: ${TABLE}.city ;;
  }

  dimension: company {
    type: string
    group_label: "IP Enrichment"
    sql: ${TABLE}.company ;;
  }

  dimension: country {
    type: string
    group_label: "IP Enrichment"
    sql: ${TABLE}.country ;;
  }

  dimension: domain {
    type: string
    group_label: "IP Enrichment"
    sql: ${TABLE}.domain ;;
  }

  dimension: enrichment_error {
    type: string
    group_label: "IP Enrichment"
    sql: ${TABLE}.enrichment_error ;;
  }

  dimension: enrichment_success {
    type: yesno
    hidden: yes
    sql: ${TABLE}.enrichment_success ;;
  }

  dimension: ip {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.ip ;;
  }

  dimension: isp {
    type: string
    group_label: "IP Enrichment"
    sql: ${TABLE}.isp ;;
  }

  dimension: isp_filtered {
    type: yesno
    group_label: "IP Enrichment"
    sql: ${TABLE}.isp_filtered ;;
  }

  dimension: latitude {
    type: number
    hidden: yes
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    hidden: yes
    sql: ${TABLE}.longitude ;;
  }

  dimension: region {
    type: string
    group_label: "IP Enrichment"
    sql: ${TABLE}.region ;;
  }

  measure: count {
    type: count
  }
}
