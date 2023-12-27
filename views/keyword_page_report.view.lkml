view: keyword_page_report {
  derived_table: {
    sql: SELECT * FROM `ra-development.fivetran_google_search_console.keyword_page_report`
      ;;
  }
  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }
  dimension_group: search {
    type: time
    timeframes: [date,month,quarter,year,week]
    sql: timestamp(${TABLE}.date) ;;
  }
  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
  }
  dimension: query {
    type: string
    sql: ${TABLE}.query ;;
  }
  dimension: page {
    type: string
    sql: rtrim(${TABLE}.page,"/") ;;
  }
  dimension: search_type {
    type: string
    sql: ${TABLE}.search_type ;;
  }
  dimension: site {
    type: string
    sql: ${TABLE}.site ;;
  }
  measure: clicks {
    type: sum
    sql: ${TABLE}.clicks ;;
  }
  measure: ctr {
    type: average
    value_format_name: percent_2
    sql: ${TABLE}.ctr ;;
  }
  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
  }
  measure: position {
    type: average
    sql: ${TABLE}.position ;;
  }
  set: detail {
    fields: [
      country,
      date_time,
      device,
      keyword,
      page,
      search_type,
      site,
      _fivetran_synced_time,
      clicks,
      ctr,
      impressions,
      position
    ]
  }
}
