view: fact_inventory {
  sql_table_name: `ra-development.analytics_ecommerce_ecommerce.fact_inventory` ;;

  # Primary Key
  dimension: inventory_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.inventory_key ;;
    description: "Inventory surrogate key"
  }

  # Foreign Keys
  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
    description: "Product business key"
  }

  dimension: product_key {
    type: number
    sql: ${TABLE}.product_key ;;
    description: "Product surrogate key"
    hidden: yes
  }

  dimension: snapshot_date_key {
    type: number
    sql: ${TABLE}.snapshot_date_key ;;
    description: "Inventory snapshot date key (YYYYMMDD)"
    hidden: yes
  }

  # Inventory Metrics
  dimension: current_stock {
    type: number
    sql: ${TABLE}.current_stock ;;
    description: "Current stock on hand"
  }

  dimension: units_on_order {
    type: number
    sql: ${TABLE}.units_on_order ;;
    description: "Units currently on order"
  }

  dimension: reorder_point {
    type: number
    sql: ${TABLE}.reorder_point ;;
    description: "Inventory reorder point"
  }

  dimension: reorder_quantity {
    type: number
    sql: ${TABLE}.reorder_quantity ;;
    description: "Standard reorder quantity"
  }

  dimension: total_inventory_value {
    type: number
    sql: ${TABLE}.total_inventory_value ;;
    value_format_name: usd
    description: "Total value of inventory on hand"
  }

  dimension: days_of_supply {
    type: number
    sql: ${TABLE}.days_of_supply ;;
    description: "Estimated days of supply remaining"
  }

  dimension: stock_status {
    type: string
    sql: ${TABLE}.stock_status ;;
    description: "Stock status (In Stock, Low Stock, Out of Stock)"
  }

  dimension: is_below_reorder_point {
    type: yesno
    sql: ${current_stock} < ${reorder_point} ;;
    description: "Whether stock is below reorder point"
  }

  # Calculated Dimensions
  dimension: stock_level_tier {
    type: string
    case: {
      when: {
        sql: ${stock_status} = 'Out of Stock' ;;
        label: "Out of Stock"
      }
      when: {
        sql: ${days_of_supply} <= 7 ;;
        label: "Critical (≤7 days)"
      }
      when: {
        sql: ${days_of_supply} <= 14 ;;
        label: "Low (8-14 days)"
      }
      when: {
        sql: ${days_of_supply} <= 30 ;;
        label: "Medium (15-30 days)"
      }
      else: "High (>30 days)"
    }
    description: "Stock level categorization"
  }

  # Measures
  measure: total_products {
    type: count_distinct
    sql: ${product_id} ;;
    description: "Number of unique products"
  }

  measure: total_stock_on_hand {
    type: sum
    sql: ${current_stock} ;;
    description: "Total units in stock"
  }

  measure: total_on_order {
    type: sum
    sql: ${units_on_order} ;;
    description: "Total units on order"
  }

  measure: inventory_value {
    type: sum
    sql: ${total_inventory_value} ;;
    value_format_name: usd
    description: "Total inventory value"
  }

  measure: out_of_stock_count {
    type: count_distinct
    sql: ${product_id} ;;
    filters: [stock_status: "Out of Stock"]
    description: "Number of out of stock products"
  }

  measure: low_stock_count {
    type: count_distinct
    sql: ${product_id} ;;
    filters: [stock_status: "Low Stock"]
    description: "Number of low stock products"
  }

  measure: below_reorder_count {
    type: count_distinct
    sql: ${product_id} ;;
    filters: [is_below_reorder_point: "yes"]
    description: "Products below reorder point"
  }

  measure: avg_days_of_supply {
    type: average
    sql: ${days_of_supply} ;;
    value_format_name: decimal_1
    description: "Average days of supply"
  }

  measure: stock_turnover_ratio {
    type: number
    sql: 365.0 / NULLIF(${avg_days_of_supply},0) ;;
    value_format_name: decimal_1
    description: "Annual stock turnover ratio"
  }
}
