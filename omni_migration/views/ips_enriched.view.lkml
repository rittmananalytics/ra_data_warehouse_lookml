view: ips_enriched {
  sql_table_name: `ra-development.analytics_seed.ips_enriched` ;;

  dimension: asn {
    hidden: yes
    sql: ${TABLE}.asn ;;
  }

  dimension: city {
    group_label: "IP Enrichment"
    sql: ${TABLE}.city ;;
  }

  dimension: company {
    group_label: "IP Enrichment"
    sql: ${TABLE}.company ;;
  }

  dimension: country {
    group_label: "IP Enrichment"
    sql: ${TABLE}.country ;;
  }

  dimension: domain {
    group_label: "IP Enrichment"
    sql: ${TABLE}.domain ;;
  }

  dimension: enrichment_error {
    group_label: "IP Enrichment"
    sql: ${TABLE}.enrichment_error ;;
  }

  dimension: enrichment_success {
    hidden: yes
    sql: ${TABLE}.enrichment_success ;;
  }

  dimension: ip {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.ip ;;
  }

  dimension: isp {
    group_label: "IP Enrichment"
    sql: ${TABLE}.isp ;;
  }

  dimension: isp_filtered {
    group_label: "IP Enrichment"
    sql: ${TABLE}.isp_filtered ;;
  }

  dimension: latitude {
    hidden: yes
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    hidden: yes
    sql: ${TABLE}.longitude ;;
  }

  dimension: region {
    group_label: "IP Enrichment"
    sql: ${TABLE}.region ;;
  }

  measure: count {
    type: count
  }
}
