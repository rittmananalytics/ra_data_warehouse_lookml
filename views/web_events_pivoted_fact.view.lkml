view: web_events_pivoted_fact {
  sql_table_name: `ra-development.analytics.web_events_pivoted_fact` ;;

  dimension: blended_user_id {
    hidden: yes

    type: string
    sql: ${TABLE}.blended_user_id ;;
  }


  dimension: event10_page_category {
    group_label: "Page View Sequence"
    type: string
    sql: ${TABLE}.event10_page_category ;;
  }
  dimension: event10_page_title {
    group_label: "Page View Sequence"

    type: string
    sql: ${TABLE}.event10_page_title ;;
  }

  dimension: event1_page_category {
    group_label: "Page View Sequence"

    type: string
    sql: ${TABLE}.event1_page_category ;;
  }
  dimension: event1_page_title {
    group_label: "Page View Sequence"

    type: string
    sql: ${TABLE}.event1_page_title ;;
  }

  dimension: event2_page_category {
    group_label: "Page View Sequence"

    type: string
    sql: ${TABLE}.event2_page_category ;;
  }
  dimension: event2_page_title {
    group_label: "Page View Sequence"

    type: string
    sql: ${TABLE}.event2_page_title ;;
  }

  dimension: event3_page_category {
    group_label: "Page View Sequence"

    type: string
    sql: ${TABLE}.event3_page_category ;;
  }
  dimension: event3_page_title {
    group_label: "Page View Sequence"

    type: string
    sql: ${TABLE}.event3_page_title ;;
  }

  dimension: event4_page_category {
    group_label: "Page View Sequence"

    type: string
    sql: ${TABLE}.event4_page_category ;;
  }
  dimension: event4_page_title {
    group_label: "Page View Sequence"

    type: string
    sql: ${TABLE}.event4_page_title ;;
  }

  dimension: event5_page_category {
    group_label: "Page View Sequence"

    type: string
    sql: ${TABLE}.event5_page_category ;;
  }
  dimension: event5_page_title {
    group_label: "Page View Sequence"

    type: string
    sql: ${TABLE}.event5_page_title ;;
  }

  dimension: event6_page_category {
    group_label: "Page View Sequence"

    type: string
    sql: ${TABLE}.event6_page_category ;;
  }
  dimension: event6_page_title {
    group_label: "Page View Sequence"

    type: string
    sql: ${TABLE}.event6_page_title ;;
  }

  dimension: event7_page_category {
    group_label: "Page View Sequence"

    type: string
    sql: ${TABLE}.event7_page_category ;;
  }
  dimension: event7_page_title {
    group_label: "Page View Sequence"

    type: string
    sql: ${TABLE}.event7_page_title ;;
  }

  dimension: event8_page_category {
    group_label: "Page View Sequence"

    type: string
    sql: ${TABLE}.event8_page_category ;;
  }
  dimension: event8_page_title {
    group_label: "Page View Sequence"

    type: string
    sql: ${TABLE}.event8_page_title ;;
  }

  dimension: event9_page_category {
    group_label: "Page View Sequence"

    type: string
    sql: ${TABLE}.event9_page_category ;;
  }
  dimension: event9_page_title {
    group_label: "Page View Sequence"

    type: string
    sql: ${TABLE}.event9_page_title ;;
  }


  dimension: web_sessions_pk {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.web_sessions_pk ;;
  }

}
