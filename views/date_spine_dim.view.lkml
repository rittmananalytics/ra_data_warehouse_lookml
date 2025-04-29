view: date_spine_dim {
  derived_table: {
    sql: SELECT timestamp(day) date_spine_day
      FROM UNNEST(
          GENERATE_DATE_ARRAY(DATE('2020-06-01'), CURRENT_DATE(), INTERVAL 1 DAY)
      ) AS day
       ;;
  }



  dimension_group: date {
    type: time
    timeframes: [raw,date, day_of_week, day_of_week_index, day_of_month,week,week_of_year,month,month_num,month_name,quarter,quarter_of_year,year]
    sql: ${TABLE}.date_spine_day ;;
  }


}
