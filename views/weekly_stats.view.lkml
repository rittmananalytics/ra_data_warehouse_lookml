view: weekly_stats {
  sql_table_name: `{{ _user_attributes['dbt_dataset'] }}.daily_activity.weekly_stats`
    ;;

  dimension: avg_event_value {
    type: number
    hidden: yes
    sql: ${TABLE}.avg_event_value ;;
  }

  dimension: event_type {
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: sum_event_value {
    type: number
    hidden: yes
    sql: ${TABLE}.sum_event_value ;;
  }

  dimension: pk {
    type: string
    hidden: yes
    sql: concat(${TABLE}.week,${TABLE}.event_type) ;;
  }

  dimension_group: week {
    type: time
    timeframes: [

      week_of_year,
      month_num,
      quarter_of_year,
      quarter,
      week,
      month,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.week ;;
  }

  dimension: pandemic_week_number {
    type: number
    sql: ${week_week_of_year} - 9;;
  }

  dimension: pandemic_year_number {
    type: number
    sql: ${week_year} - 2020 ;;
  }

  measure: avg_deep_sleep_pct {
    type: average
    sql: ${avg_event_value} ;;
    filters: [ event_type: "deep_sleep_pct"]
    value_format_name: percent_0
    drill_fields: []
  }

  measure: sum_steps {
    type: sum
    sql: ${sum_event_value} ;;
    filters: [ event_type: "steps"]
    drill_fields: []
  }

  measure: avg_walking_distance_km {
    type: average
    sql: ${avg_event_value} ;;
    filters: [ event_type: "distance km"]
    drill_fields: []
  }

  measure: sum_cycling_distance_KM {
    type: sum
    sql: ${sum_event_value} ;;
    filters: [ event_type: "cycling distance KM"]
    drill_fields: []
  }

  measure: sum_cycling_kj {
    type: sum
    sql: ${sum_event_value} ;;
    filters: [ event_type: "cycling kJ"]
    drill_fields: []
  }

  measure: avg_weight_kg {
    type: average
    sql: ${avg_event_value} ;;
    filters: [ event_type: "weight"]
    drill_fields: []
  }

  measure: total_sleep_hours {
    type: sum
    sql: ${sum_event_value} ;;
    filters: [ event_type: "sleep"]
    drill_fields: []
  }

  measure: avg_sleep_hours {
    type: average
    sql: ${avg_event_value} ;;
    filters: [ event_type: "sleep"]
    drill_fields: []
  }
}