# The name of this view in Looker is "Podcast Transcriptions"
view: podcast_transcriptions {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics_seed.podcast_transcriptions` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Audio URL" in Explore.

  dimension: audio_url {
    type: string
    sql: ${TABLE}.audio_url ;;
  }

  dimension: classification {
    type: string
    sql: ${TABLE}.classification ;;
  }

  dimension: primary_classification{
    type: string
    sql: REGEXP_EXTRACT(${TABLE}.classification, r'Primary Tag: (?:\d+\.)*\d+\.\s*(.*?)\s*(?:Secondary Tags:|$)');;
  }



  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: link {
    type: string
    sql: ${TABLE}.link ;;
  }

  dimension: published {
    type: string
    sql: ${TABLE}.published ;;
  }

  dimension: summary_and_insights {
    type: string
    sql: ${TABLE}.summary_and_insights ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: transcript {
    type: string
    sql: ${TABLE}.transcript ;;
  }
  measure: count {
    type: count
  }
}
