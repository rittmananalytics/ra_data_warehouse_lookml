view: branch_sku_day {
  sql_table_name:
    {% if branch_sku_day.sku._in_query and branch_sku_day.branch_number._in_query and branch_sku_day.date_day._in_query %}
          `ra-development.analytics_seed.branch_sku_day`
          {% elsif branch_sku_day.product_class._in_query and branch_sku_day.branch_number._in_query and branch_sku_day.date_day._in_query %}
          `ra-development.analytics_seed.branch_class_day`
          {% elsif branch_sku_day.product_class._in_query and branch_sku_day.region_number._in_query and branch_sku_day.date_day._in_query %}
          `ra-development.analytics_seed.region_class_day`
          {% elsif branch_sku_day.product_class._in_query and branch_sku_day.date_day._in_query %}
          `ra-development.analytics_seed.class_day`
          {% else %}
          `ra-development.analytics_seed.branch_sku_day`
          {% endif %}
   ;;

  dimension: branch_number {
    type: number
    sql: ${TABLE}.branch_number ;;
  }
  dimension: budget_net_revenue {
    type: number
    sql: case when ${TABLE}.budget_net_revenue = 0 then null end;;
  }
  dimension_group: date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.date ;;
  }
  dimension: pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: concat(${branch_number},${date_date},${sku}) ;;
  }
  dimension: discount {
    hidden: yes
    type: number
    sql: ${TABLE}.discount ;;
  }
  dimension: gross_revenue {
    hidden: yes
    type: number
    sql: ${TABLE}.gross_revenue ;;
  }
  dimension: net_revenue {
    hidden: yes
    type: number
    sql: ${TABLE}.net_revenue ;;
  }
  dimension: product_class {
    type: string
    sql: ${TABLE}.product_class ;;
  }
  dimension: region_number {
    type: number
    sql: ${TABLE}.region_number ;;
  }
  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }
  dimension: tax {
    hidden: yes
    type: number
    sql: ${TABLE}.tax ;;
  }
  measure: total_discount {
    type: sum
    sql: ${discount} ;;
  }
  measure: total_net_revenue {
    type: sum
    sql: ${net_revenue} ;;
  }
  measure: total_gross_revenue {
    type: sum
    sql: ${gross_revenue} ;;
  }
  measure: total_budget_net_revenue {
    type: sum
    sql: ${budget_net_revenue} ;;
  }
}
