view: branch_sku_day {
  sql_table_name:
    {% if branch_sku_day.sku._in_query and branch_sku_day.branch_number._in_query and branch_sku_day.date_date._in_query %}
          `ra-development.analytics_seed.branch_sku_day`
          {% elsif branch_sku_day.product_class._in_query and branch_sku_day.branch_number._in_query and branch_sku_day.date_date._in_query %}
          `ra-development.analytics_seed.branch_class_day`
          {% elsif branch_sku_day.product_class._in_query and branch_sku_day.region_number._in_query and branch_sku_day.date_date._in_query %}
          `ra-development.analytics_seed.region_class_day`
          {% elsif branch_sku_day.product_class._in_query and branch_sku_day.date_date._in_query %}
          `ra-development.analytics_seed.class_day`
          {% elsif branch_sku_day.product_class._in_query and branch_sku_day.region_number._in_queryand branch_sku_day.date_month._in_query %}
          `ra-development.analytics_seed.region_class_month`
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
    sql: ${TABLE}.budget_net_revenue;;
    drill_fields: [sku, product_class, branch_number, region_number,date_date,date_week,date_month,date_quarter,date_year]
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
    group_label: "Common Measures"

    hidden: yes
    type: number
    sql: ${TABLE}.tax ;;
    drill_fields: [sku, product_class, branch_number, region_number,date_date,date_week,date_month,date_quarter,date_year]
  }
  measure: total_discount {
    group_label: "Common Measures"

    type: sum
    sql: ${discount} ;;
    drill_fields: [sku, product_class, branch_number, region_number,date_date,date_week,date_month,date_quarter,date_year]
  }
  measure: total_net_revenue {
    group_label: "Common Measures"
    type: sum
    sql: ${net_revenue} ;;
    drill_fields: [sku, product_class, branch_number, region_number,date_date,date_week,date_month,date_quarter,date_year]
  }
  measure: total_gross_revenue {
    group_label: "Common Measures"

    type: sum
    sql: ${gross_revenue} ;;
    drill_fields: [sku, product_class, branch_number, region_number,date_date,date_week,date_month,date_quarter,date_year]
  }
  measure: total_budget_net_revenue {
    group_label: "Budget (Product Class+) Measures"

    type: number
    sql: sum(${budget_net_revenue}) ;;
    drill_fields: [sku, product_class, branch_number, region_number,date_date,date_week,date_month,date_quarter,date_year]
  }
}
