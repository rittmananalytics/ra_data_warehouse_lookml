view: dates  {
    derived_table: {
      sql: SELECT day
              FROM UNNEST(
                  GENERATE_DATE_ARRAY(DATE('2017-01-01'), current_date(), INTERVAL 1 DAY)
              ) as day ;;
    }


    dimension: day {
      type: date
      primary_key:  yes
      hidden: yes
      datatype: date
      sql: ${TABLE}.day ;;
    }

    dimension_group: date {
      type: time

      datatype: timestamp
      timeframes: [raw,date,week,month,quarter,year]
      sql: timestamp(${TABLE}.day) ;;
    }

    set: detail {
      fields: [
        day
      ]
    }
  }
