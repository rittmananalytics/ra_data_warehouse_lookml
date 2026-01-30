view: site_report_by_page {
  sql_table_name: `ra-development.fivetran_google_search_console.site_report_by_page` ;;

  dimension_group: _fivetran_synced {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}._fivetran_synced ;;
  }
  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
  }
  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }
  dimension: ctr {
    type: number
    sql: ${TABLE}.ctr ;;
  }
  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }
  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
  }
  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }
  dimension: position {
    type: number
    sql: ${TABLE}.position ;;
  }
  dimension: search_type {
    type: string
    sql: ${TABLE}.search_type ;;
  }
  dimension: site {
    type: string
    sql: ${TABLE}.site ;;
  }
  measure: count {
    type: count
  }
}
