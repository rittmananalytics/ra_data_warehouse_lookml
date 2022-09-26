# The name of this view in ooker is "Events"
view: events {
  derived_table: {
    sql:
        SELECT * FROM `markr-data-lake.event_history2.events_clean`
        WHERE {% condition add_search %}

        {% if search._in_query  %} where search (events,

              {% else %} base.date_window

              {% endif %}

            {% endcondition %}
    ;;



  }
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Alternative Place ID" in Explore.

  parameter: search {
    suggestable: no
    type: string
  }

  dimension: alternative_place_id {
    hidden: yes
    type: string
    sql: ${TABLE}.alternative_place_id ;;
  }

  dimension: apple_music_album_name {
    group_label: "Music"
    type: string
    sql: ${TABLE}.apple_music_album_name ;;
  }

  dimension: apple_music_artist_name {
    group_label: "Music"

    type: string
    sql: ${TABLE}.apple_music_artist_name ;;
  }

  dimension: body_fat_pct {
    group_label: "Health"

    type: string
    sql: ${TABLE}.body_fat_pct ;;
  }

  dimension: bone_mass_kg {
    group_label: "Health"

    type: string
    sql: ${TABLE}.bone_mass_kg ;;
  }

  dimension: calories_earned_count {
    group_label: "Health"

    type: string
    sql: ${TABLE}.calories_earned_count ;;
  }

  dimension: calories_passive_count {
    group_label: "Health"

    type: string
    sql: ${TABLE}.calories_passive_count ;;
  }

  dimension: cycling_activity_score {
    group_label: "Cycling"

    type: string
    sql: ${TABLE}.cycling_Activity_Score ;;
  }

  dimension: cycling_cad {
    group_label: "Cycling"

    type: string
    sql: ${TABLE}.cycling_Cad ;;
  }

  dimension: cycling_elv_m {
    group_label: "Cycling"

    type: string
    sql: ${TABLE}.cycling_Elv_m ;;
  }

  dimension: cycling_energy_kg {
    group_label: "Cycling"

    type: string
    sql: ${TABLE}.cycling_energy_kg ;;
  }

  dimension: cycling_gear {
    group_label: "Cycling"

    type: string
    sql: ${TABLE}.cycling_Gear ;;
  }

  dimension: cycling_intensity_pct {
    group_label: "Cycling"

    type: string
    sql: ${TABLE}.cycling_intensity_pct ;;
  }

  dimension: cycling_kudos {
    group_label: "Cycling"

    type: string
    sql: ${TABLE}.cycling_Kudos ;;
  }

  dimension: cycling_max_pwr_w {
    group_label: "Cycling"

    type: string
    sql: ${TABLE}.cycling_Max_Pwr_W ;;
  }

  dimension: cycling_prs {
    group_label: "Cycling"

    type: string
    sql: ${TABLE}.cycling_PRs ;;
  }

  dimension: cycling_pwr_w {
    group_label: "Cycling"

    type: string
    sql: ${TABLE}.cycling_Pwr_W ;;
  }

  dimension: cycling_relative_effort {
    group_label: "Cycling"

    type: string
    sql: ${TABLE}.cycling_Relative_Effort ;;
  }

  dimension: cycling_segs {
    group_label: "Cycling"

    type: string
    sql: ${TABLE}.cycling_Segs ;;
  }

  dimension: cycling_training_load {
    group_label: "Cycling"

    type: string
    sql: ${TABLE}.cycling_Training_Load ;;
  }

  dimension: driving_score {
    group_label: "Driving"

    type: string
    sql: ${TABLE}.driving_score ;;
  }

  dimension: event_address {
    group_label: "Location"

    type: string
    sql: ${TABLE}.event_address ;;
  }

  dimension: event_category {
    group_label: "    Event"

    type: string
    sql: ${TABLE}.event_category ;;
  }

  dimension: event_country {
    group_label: "Location"

    type: string
    sql: ${TABLE}.event_country ;;
  }

  dimension: event_details {
    group_label: "    Event"

    type: string
    sql: ${TABLE}.event_details ;;
  }

  dimension: event_details_full {
    group_label: "    Event"

    type: string
    sql: ${TABLE}.event_details_full ;;
  }

  dimension: event_distance_km {
    group_label: "Travel"

    type: string
    sql: ${TABLE}.event_distance_km ;;
  }

  dimension: event_duration_secs {
    group_label: "Travel"

    type: number
    sql: ${TABLE}.event_duration_secs ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_event_duration_secs {
    group_label: "    Event"

    type: sum
    sql: ${event_duration_secs} ;;
  }

  measure: average_event_duration_secs {
    group_label: "    Event"

    type: average
    sql: ${event_duration_secs} ;;
  }

  dimension: event_elapsed_duration_secs {
    group_label: "    Event"

    type: number
    sql: ${TABLE}.event_elapsed_duration_secs ;;
  }

  dimension: event_end_address {
    group_label: "Location"

    type: string
    sql: ${TABLE}.event_end_address ;;
  }

  dimension: event_end_country {
    group_label: "Location"

    type: string
    sql: ${TABLE}.event_end_country ;;
  }

  dimension: event_end_lat {
    group_label: "Location"

    type: string
    sql: ${TABLE}.event_end_lat ;;
  }

  dimension: event_end_location_name {
    group_label: "Location"

    type: string
    sql: ${TABLE}.event_end_location_name ;;
  }

  dimension: event_end_long {
    group_label: "Location"

    type: string
    sql: ${TABLE}.event_end_long ;;
  }

  dimension: event_heart_rate {
    group_label: "Health"

    type: number
    sql: ${TABLE}.event_heart_rate ;;
  }

  dimension: event_lat {
    group_label: "Location"

    type: number
    sql: ${TABLE}.event_lat ;;
  }

  dimension: event_location_name {
    group_label: "Location"

    type: string
    sql: ${TABLE}.event_location_name ;;
  }

  dimension: event_long {
    group_label: "Location"

    type: number
    sql: ${TABLE}.event_long ;;
  }

  dimension: event_max_speed_kph {
    group_label: "Travel"

    type: string
    sql: ${TABLE}.event_max_speed_kph ;;
  }

  dimension: event_site_or_app {
    group_label: "    Event"

    type: string
    sql: ${TABLE}.event_site_or_app ;;
  }

  dimension: event_source {
    group_label: "    Event"

    type: string
    sql: ${TABLE}.event_source ;;
  }

  dimension: event_speed_kph {
    group_label: "Travel"

    type: string
    sql: ${TABLE}.event_speed_kph ;;
  }

  dimension: event_spend {
    group_label: "Finance"

    type: number
    sql: ${TABLE}.event_spend ;;
  }

  dimension: event_spend_currency {
    group_label: "Finance"

    type: string
    sql: ${TABLE}.event_spend_currency ;;
  }

  dimension: event_target {
    group_label: "    Event"

    type: string
    sql: ${TABLE}.event_target ;;
  }

  dimension: event_temp_c {
    group_label: "Location"

    type: string
    sql: ${TABLE}.event_temp_c ;;
  }

  dimension_group: event_ts {
    group_label: "    Event"
    timeframes: [year, month, month_name, date, day_of_week, time]
    type: time
    sql: cast(${TABLE}.event_ts as timestamp) ;;
  }

  dimension: event_type {
    group_label: "    Event"

    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: fat_mass_kg {
    group_label: "Health"

    type: string
    sql: ${TABLE}.fat_mass_kg ;;
  }

  dimension: location_confidence {
    group_label: "Location"

    type: number
    sql: ${TABLE}.locationConfidence ;;
  }

  dimension: locationplace_id {
    hidden: yes

    type: string
    sql: ${TABLE}.locationplaceId ;;
  }

  dimension: locationsemantic_type {
    hidden: yes
    type: string
    sql: ${TABLE}.locationsemanticType ;;
  }

  dimension: muscle_mass_kg {
    group_label: "Health"

    type: string
    sql: ${TABLE}.muscle_mass_kg ;;
  }

  dimension: place_visit_importance {
    group_label: "Location"

    type: string
    sql: ${TABLE}.placeVisitImportance ;;
  }

  dimension: place_visit_type {
    group_label: "Location"

    type: string
    sql: ${TABLE}.placeVisitType ;;
  }

  dimension: steps_count {
    group_label: "Health"

    type: string
    sql: ${TABLE}.steps_count ;;
  }

  dimension: visit_confidence {
    group_label: "Location"

    type: number
    sql: ${TABLE}.visitConfidence ;;
  }

  dimension: water_mass_kg {
    group_label: "Health"

    type: string
    sql: ${TABLE}.water_mass_kg ;;
  }

  dimension: weight_chg_pct {
    group_label: "Health"

    type: string
    sql: ${TABLE}.weight_chg_pct ;;
  }

  dimension: weight_kg {
    group_label: "Health"

    type: string
    sql: ${TABLE}.weight_kg ;;
  }

  dimension: weight_kg_chg {
    group_label: "Health"

    type: string
    sql: ${TABLE}.weight_kg_chg ;;
  }

  measure: count {
    type: count
    drill_fields: [event_end_location_name, event_location_name, apple_music_artist_name, apple_music_album_name]
  }
}
