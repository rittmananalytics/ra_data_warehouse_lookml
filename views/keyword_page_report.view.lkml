view: keyword_page_report {
    derived_table: {
      sql: SELECT date, query, device, country, search_type, site, page, clicks, ctr, impressions, position FROM `ra-development.fivetran_google_search_console.keyword_page_report`  ;;
    }



    dimension_group: day {
      timeframes: [date,week,month,quarter,year, month_num]
      type: time
      datatype: timestamp
      sql: timestamp(${TABLE}.date) ;;
    }

    dimension: pk {
      type: string
      sql: concat(${day_date},${site},${country},${search_type},${device},${page},${query}) ;;
      hidden: yes
      primary_key: yes
    }

    dimension: query {
      type: string
      sql: ${TABLE}.query ;;
    }

    dimension: device {
      type: string
      sql: ${TABLE}.device ;;
    }

    dimension: country {
      type: string
      sql: ${TABLE}.country ;;
    }

    dimension: search_type {
      type: string
      sql: ${TABLE}.search_type ;;
    }

    dimension: site {
      type: string
      sql: ${TABLE}.site ;;
    }

    dimension: page {
      type: string
      sql: ${TABLE}.page ;;
    }

    dimension: clicks {
      hidden: yes

      type: number
      sql: ${TABLE}.clicks ;;
    }

    dimension: ctr {
      hidden: yes
      type: number
      sql: ${TABLE}.ctr ;;
    }

    dimension: impressions {
      hidden: yes

      type: number
      sql: ${TABLE}.impressions ;;
    }

    measure: total_impressions {
      type: sum
      sql: ${impressions} ;;
    }

    measure: avg_ctr {
      type: average
      sql: ${ctr} ;;
    }

    measure: total_clicks {
      type: sum
      sql: ${clicks} ;;
    }

    measure: avg_position {
      type: average
      sql: ${position} ;;
    }

    dimension: position {
      hidden: yes

      type: number
      sql: ${TABLE}.position ;;
    }

    set: detail {
      fields: [
        day_date,
        query,
        device,
        country,
        search_type,
        site,
        page,
        clicks,
        ctr,
        impressions,
        position
      ]
    }
  }
