view: geolocation_fact {
  sql_table_name: `ra-development.rob_training.wh_geolocation_fact`
    ;;

  dimension: geolocation_city {
    type: string
    sql: ${TABLE}.geolocation_city ;;
  }

  dimension: geolocation {
    type: location
    sql_latitude:${geolocation_lat} ;;
    sql_longitude:${geolocation_lng} ;;
  }

  dimension: geolocation_id {
    type: string
    sql: ${TABLE}.geolocation_id ;;
  }

  dimension: geolocation_lat {
    type: number
    sql: ${TABLE}.geolocation_lat ;;
  }

  dimension: geolocation_lng {
    type: number
    sql: ${TABLE}.geolocation_lng ;;
  }

  dimension: geolocation_state {
    type: string
    sql: ${TABLE}.geolocation_state ;;
  }

  dimension: geolocation_zip_code_prefix {
    type: number
    sql: ${TABLE}.geolocation_zip_code_prefix ;;
  }

}
