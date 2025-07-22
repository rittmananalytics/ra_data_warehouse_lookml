connection: "ra_dw_prod"


# include all the views
include: "/views/ecommerce_demo/**/*.view"
include: "/dashboards/*.dashboard"



# Order Items Explore - Line item detail analysis
explore: order_items {
  from: fact_order_items
  label: "Order Items Analysis"
  description: "Detailed order line item analysis with product, customer, and channel dimensions"

  # Date dimension
  join: order_date {
    from: dim_date
    type: left_outer
    sql_on: ${order_items.order_date_key} = ${order_date.date_key} ;;
    relationship: many_to_one
  }

  # Customer dimension
  join: customers {
    from: dim_customers
    type: left_outer
    sql_on: ${order_items.customer_key} = ${customers.customer_key} ;;
    relationship: many_to_one
  }

  # Product dimension
  join: products {
    from: dim_products
    type: left_outer
    sql_on: ${order_items.product_key} = ${products.product_key} ;;
    relationship: many_to_one
  }

  # Channel dimension
  join: channels {
    from: dim_channels
    type: left_outer
    sql_on: ${order_items.channel_key} = ${channels.channel_key} ;;
    relationship: many_to_one
  }

  # Order header
  join: orders {
    from: fact_orders
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.order_id} ;;
    relationship: many_to_one
  }
}

# Sessions Explore - Web analytics focus
explore: sessions {
  from: fact_sessions
  label: "Web Sessions & Events"
  description: "Website behavior analysis including sessions, events, and conversions"

  # Date dimension
  join: session_date {
    from: dim_date
    type: left_outer
    sql_on: ${sessions.session_date_key} = ${session_date.date_key} ;;
    relationship: many_to_one
  }

  # Channel dimension
  join: channels {
    from: dim_channels
    type: left_outer
    sql_on: ${sessions.channel_key} = ${channels.channel_key} ;;
    relationship: many_to_one
  }

  # Events
  join: events {
    from: fact_events
    type: left_outer
    sql_on: ${sessions.session_id} = ${events.session_id} ;;
    relationship: one_to_many
  }
}

# Marketing Performance Explore
explore: marketing_performance {
  from: fact_marketing_performance
  label: "Marketing Performance"
  description: "Unified marketing campaign performance across all platforms"

  # Date dimension
  join: activity_date {
    from: dim_date
    type: left_outer
    sql_on: ${marketing_performance.activity_date_key} = ${activity_date.date_key} ;;
    relationship: many_to_one
  }
}

# Customer Journey Explore
explore: customer_journey {
  from: fact_customer_journey
  label: "Customer Journey"
  description: "Multi-touch attribution and customer path analysis"

  # Date dimension
  join: session_date {
    from: dim_date
    type: left_outer
    sql_on: ${customer_journey.session_date_key} = ${session_date.date_key} ;;
    relationship: many_to_one
  }

  join: order_date {
    from: dim_date
    type: left_outer
    sql_on: ${customer_journey.order_date_key} = ${order_date.date_key} ;;
    relationship: many_to_one
  }

  # Customer dimension
  join: customers {
    from: dim_customers
    type: left_outer
    sql_on: ${customer_journey.customer_key} = ${customers.customer_key} ;;
    relationship: many_to_one
  }

  # Order dimension
  join: orders {
    from: fact_orders
    type: left_outer
    sql_on: ${customer_journey.order_key} = ${orders.order_key} ;;
    relationship: many_to_one
  }

  # Session dimension
  join: sessions {
    from: fact_sessions
    type: left_outer
    sql_on: ${customer_journey.session_key} = ${sessions.session_key} ;;
    relationship: many_to_one
  }
}

# Inventory Explore
explore: inventory {
  from: fact_inventory
  label: "Inventory Management"
  description: "Product inventory levels and stock management"

  # Product dimension
  join: products {
    from: dim_products
    type: left_outer
    sql_on: ${inventory.product_id} = ${products.product_id} ;;
    relationship: many_to_one
  }
}

# Main Orders Explore - Central hub for order analysis
explore: orders {
  from: fact_orders
  label: "Orders & Sales Analysis"
  description: "Comprehensive order and sales analysis with customer, product, and date dimensions"

  # Date dimension
  join: order_date {
    from: dim_date
    type: left_outer
    sql_on: ${orders.order_date_key} = ${order_date.date_key} ;;
    relationship: many_to_one
    fields: [order_date.calendar_date, order_date.calendar_week, order_date.calendar_month,
      order_date.calendar_quarter, order_date.calendar_year, order_date.day_of_week,
      order_date.day_of_month, order_date.is_weekend]
  }

  # Customer dimension
  join: customers {
    from: dim_customers
    type: left_outer
    sql_on: ${orders.customer_key} = ${customers.customer_key} ;;
    relationship: many_to_one
  }

  # Channel dimension
  join: channels {
    from: dim_channels
    type: left_outer
    sql_on: ${orders.channel_key} = ${channels.channel_key} ;;
    relationship: many_to_one
  }
}

# Data Quality Explore
explore: data_quality {
  from: fact_data_quality
  label: "Data Quality Monitoring"
  description: "Monitor pipeline health and data quality metrics"
}

# Executive Overview Explore - Combines key metrics
explore: executive_overview {
  from: fact_orders
  label: "Executive Overview"
  description: "High-level business performance overview"

  # Date dimension
  join: exec_order_date {
    from: dim_date
    type: left_outer
    sql_on: ${executive_overview.order_date_key} = ${exec_order_date.date_key} ;;
    relationship: many_to_one

  }

  # Customer dimension
  join: exec_customers {
    from: dim_customers
    type: left_outer
    sql_on: ${executive_overview.customer_key} = ${exec_customers.customer_key} ;;
    relationship: many_to_one
  }

  # Channel dimension
  join: exec_channels {
    from: dim_channels
    type: left_outer
    sql_on: ${executive_overview.channel_key} = ${exec_channels.channel_key} ;;
    relationship: many_to_one
  }

  # Marketing performance
  join: exec_marketing {
    from: fact_marketing_performance
    type: left_outer
    sql_on: ${executive_overview.order_date_key} = ${exec_marketing.activity_date_key} ;;
    relationship: many_to_many
  }

  # Sessions
  join: exec_sessions {
    from: fact_sessions
    type: left_outer
    sql_on: ${executive_overview.order_date_key} = ${exec_sessions.session_date_key} ;;
    relationship: many_to_many
  }
}
