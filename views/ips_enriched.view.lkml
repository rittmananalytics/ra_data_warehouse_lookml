view: ips_enriched {
  sql_table_name: `ra-development.analytics_seed.ips_enriched` ;;

  dimension: ip {
    hidden: yes
    type: string
    sql: ${TABLE}._Events_IP ;;
  }
  dimension: asn {
    hidden: yes

    type: string
    sql: ${TABLE}.asn ;;
  }
  dimension: city {
    group_label: "IP Enrichment"
    type: string
    sql: ${TABLE}.city ;;
  }
  dimension: company {
    group_label: "IP Enrichment"

    type: string
    sql: ${TABLE}.company ;;
  }
  dimension: country {
    group_label: "IP Enrichment"
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }
  dimension: domain {
    group_label: "IP Enrichment"

    type: string
    sql: ${TABLE}.domain ;;
  }
  dimension: enrichment_error {
    group_label: "IP Enrichment"

    type: string
    sql: ${TABLE}.enrichment_error ;;
  }
  dimension: enrichment_success {
    hidden: yes
    type: yesno
    sql: ${TABLE}.enrichment_success ;;
  }
  dimension: isp {
    group_label: "IP Enrichment"

    type: string
    sql: ${TABLE}.isp ;;
  }
  dimension: isp_filtered {
    group_label: "IP Enrichment"

    type: yesno
    sql: ${TABLE}.isp_filtered ;;
  }
  dimension: ip_location {
    group_label: "IP Enrichment"

    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }
  dimension: latitude {
    hidden: yes
    type: number
    sql: ${TABLE}.latitude ;;
  }
  dimension: longitude {
    hidden: yes

    type: number
    sql: ${TABLE}.longitude ;;
  }
  dimension: region {
    group_label: "IP Enrichment"
    type: string
    sql: ${TABLE}.region ;;
  }
  measure: count {}

}
