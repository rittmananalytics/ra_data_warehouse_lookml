- dashboard: marketing_attribution
  title: Marketing Attribution
  layout: newspaper
  preferred_viewer: dashboards-next
  description: Migrated from Omni document Marketing Attribution (omni_to_lookml 0.1.0, experimental)
  filters:
  - name: attribution_model
    title: Attribution Model
    type: field_filter
    default_value: Last Click
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: omni_migration
    explore: attribution
    field: attribution.attribution_model
  - name: session_date
    title: Session Date
    type: field_filter
    default_value: 2020-11-01 to 2021-02-01
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: omni_migration
    explore: attribution
    field: attribution.session_date
  elements:
  - name: marketing_attribution_1
    title: Marketing Attribution
    model: omni_migration
    explore: attribution
    type: single_value
    fields:
    - attribution.total_user_registration_conversions
    - attribution.total_first_order_conversions
    - attribution.total_first_order_revenue
    - attribution.total_repeat_order_conversions
    - attribution.total_repeat_order_revenue
    sorts:
    - attribution.total_first_order_revenue
    limit: 500
    row: 0
    col: 0
    width: 24
    height: 3
    listen:
      attribution_model: attribution.attribution_model
      session_date: attribution.session_date
  - name: text_ti_text_3238
    type: text
    body_text: '![alt text](https://rittmananalytics.com/s/ga4_marketing_attribution_ra.png)'
    row: 3
    col: 0
    width: 5
    height: 3
  - name: repeat_purchase_value_11
    title: Repeat Purchase Value
    model: omni_migration
    explore: attribution
    type: looker_area
    fields:
    - attribution.session_date
    - attribution.total_repeat_order_revenue
    - attribution.utm_campaign
    pivots:
    - attribution.utm_campaign
    sorts:
    - attribution.utm_campaign
    - attribution.session_date desc
    limit: 500
    row: 3
    col: 12
    width: 12
    height: 7
    listen:
      attribution_model: attribution.attribution_model
      session_date: attribution.session_date
  - name: first_purchase_value_10
    title: First Purchase Value
    model: omni_migration
    explore: attribution
    type: looker_area
    fields:
    - attribution.session_date
    - attribution.total_first_order_revenue
    - attribution.utm_campaign
    pivots:
    - attribution.utm_campaign
    sorts:
    - attribution.utm_campaign
    - attribution.session_date desc
    limit: 500
    row: 7
    col: 0
    width: 12
    height: 7
    listen:
      attribution_model: attribution.attribution_model
      session_date: attribution.session_date
  - name: repeat_purchases_3
    title: Repeat Purchases
    model: omni_migration
    explore: attribution
    type: looker_pie
    fields:
    - attribution.total_repeat_order_conversions
    - attribution.utm_campaign
    sorts:
    - attribution.utm_campaign
    limit: 500
    row: 10
    col: 12
    width: 6
    height: 6
    listen:
      attribution_model: attribution.attribution_model
      session_date: attribution.session_date
  - name: purchase_revenue_7
    title: Purchase Revenue
    model: omni_migration
    explore: attribution
    type: looker_pie
    fields:
    - attribution.total_repeat_order_revenue
    - attribution.total_first_order_revenue
    - attribution.utm_campaign
    - attribution.total_purchase_value
    sorts:
    - attribution.total_repeat_order_revenue desc
    limit: 500
    row: 10
    col: 18
    width: 6
    height: 6
    listen:
      attribution_model: attribution.attribution_model
      session_date: attribution.session_date
  - name: added_payment_details_4
    title: Added Payment Details
    model: omni_migration
    explore: attribution
    type: looker_pie
    fields:
    - attribution.total_user_registration_conversions
    - attribution.utm_campaign
    sorts:
    - attribution.total_user_registration_conversions
    limit: 500
    row: 13
    col: 0
    width: 6
    height: 6
    listen:
      attribution_model: attribution.attribution_model
      session_date: attribution.session_date
  - name: first_purchases_6
    title: First Purchases
    model: omni_migration
    explore: attribution
    type: looker_pie
    fields:
    - attribution.utm_campaign
    - attribution.total_first_order_conversions
    sorts:
    - attribution.total_first_order_conversions
    limit: 500
    row: 13
    col: 6
    width: 6
    height: 6
    listen:
      attribution_model: attribution.attribution_model
      session_date: attribution.session_date
  - name: added_payment_details_8
    title: Added Payment Details
    model: omni_migration
    explore: attribution
    type: looker_grid
    fields:
    - attribution.total_repeat_order_conversions
    - attribution.utm_campaign
    sorts:
    - attribution.total_repeat_order_conversions
    limit: 500
    row: 16
    col: 12
    width: 6
    height: 3
    listen:
      attribution_model: attribution.attribution_model
      session_date: attribution.session_date
  - name: purchase_revenue_9
    title: Purchase Revenue
    model: omni_migration
    explore: attribution
    type: looker_grid
    fields:
    - attribution.total_repeat_order_revenue
    - attribution.total_first_order_revenue
    - attribution.utm_campaign
    - attribution.total_purchase_value
    sorts:
    - attribution.total_repeat_order_revenue
    limit: 500
    row: 16
    col: 18
    width: 6
    height: 3
    listen:
      attribution_model: attribution.attribution_model
      session_date: attribution.session_date
  - name: added_payment_details_by_campaign_2
    title: Added Payment Details by Campaign
    model: omni_migration
    explore: attribution
    type: looker_grid
    fields:
    - attribution.total_user_registration_conversions
    - attribution.utm_campaign
    sorts:
    - attribution.total_user_registration_conversions
    limit: 500
    row: 19
    col: 0
    width: 6
    height: 3
    listen:
      attribution_model: attribution.attribution_model
      session_date: attribution.session_date
  - name: first_purchase_by_campaign_5
    title: First Purchase by Campaign
    model: omni_migration
    explore: attribution
    type: looker_grid
    fields:
    - attribution.total_first_order_conversions
    - attribution.utm_campaign
    sorts:
    - attribution.total_first_order_conversions
    limit: 500
    row: 19
    col: 6
    width: 6
    height: 3
    listen:
      attribution_model: attribution.attribution_model
      session_date: attribution.session_date
  - name: purchases_by_attribution_model_12
    title: Purchases by Attribution Model
    model: omni_migration
    explore: attribution
    type: looker_column
    fields:
    - attribution.utm_campaign
    - attribution.total_purchases
    - attribution.attribution_model
    pivots:
    - attribution.attribution_model
    sorts:
    - attribution.attribution_model
    limit: 500
    row: 19
    col: 12
    width: 12
    height: 7
    listen:
      session_date: attribution.session_date
  - name: repeat_purchases_13
    title: Repeat Purchases
    model: omni_migration
    explore: attribution
    type: looker_column
    fields:
    - attribution.user_conversion_cycle
    - attribution.total_purchases
    - attribution.utm_campaign
    pivots:
    - attribution.utm_campaign
    sorts:
    - attribution.utm_campaign
    - attribution.user_conversion_cycle
    limit: 500
    stacking: normal
    row: 22
    col: 0
    width: 12
    height: 7
    listen:
      attribution_model: attribution.attribution_model
      session_date: attribution.session_date
