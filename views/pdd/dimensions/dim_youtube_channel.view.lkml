# =============================================================================
# DIM_YOUTUBE_CHANNEL - YouTube Channels
# For YouTube viewing analysis
# Source: markr-data-lake.mark_dw_warehouse.dim_youtube_channel
# =============================================================================

view: dim_youtube_channel {
  sql_table_name: `markr-data-lake.mark_dw_warehouse.dim_youtube_channel` ;;

  # =============================================================================
  # PRIMARY KEY
  # =============================================================================

  dimension: channel_pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.channel_pk ;;
    hidden: yes
    description: "Primary key (hash of channel name)"
  }

  # =============================================================================
  # CHANNEL DIMENSIONS
  # =============================================================================

  dimension: channel_name {
    type: string
    sql: ${TABLE}.channel_name ;;
    label: "Channel"
    description: "YouTube channel/creator name"
  }

  dimension: channel_category {
    type: string
    sql: ${TABLE}.channel_category ;;
    label: "Category"
    description: "Content category"
  }

  # =============================================================================
  # CHANNEL FLAGS
  # =============================================================================

  dimension: is_subscribed {
    type: yesno
    sql: ${TABLE}.is_subscribed ;;
    label: "Is Subscribed"
    description: "TRUE if subscribed channel"
  }

  # =============================================================================
  # MEASURES
  # =============================================================================

  measure: count {
    type: count
    label: "Channel Count"
    drill_fields: [channel_name, channel_category]
  }

  measure: subscribed_channel_count {
    type: count
    label: "Subscribed Channel Count"
    filters: [is_subscribed: "yes"]
  }
}
