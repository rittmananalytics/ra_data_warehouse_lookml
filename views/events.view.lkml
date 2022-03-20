view: events {
  derived_table: {
    sql: select *
      from `markr-data-lake.historic_events.events_with_place_names`
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: event_type {
    group_label: "   Common Fields"
    label: "    Event Name"
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension_group: event_ts {
    group_label: "   Common Fields"
    label: "Event Time"
    type: time
    timeframes: [date,day_of_week,day_of_month,day_of_week_index,day_of_year,time,week,month,quarter,year]
    sql: timestamp(${TABLE}.event_ts) ;;
  }

  dimension: event_source {
    type: string
    sql: ${TABLE}.event_source ;;
  }

  dimension: event_target {


    type: string
    sql: ${TABLE}.event_target ;;
  }

  dimension: event_details {
    group_label: "   Common Fields"
    label: "  Event Details"
    type: string
    sql: ${TABLE}.event_details ;;
  }

  dimension: event_details_full {
    group_label: "   Common Fields"
    label: "  Event Details Full"
    type: string
    sql: ${TABLE}.event_details_full ;;
  }

  dimension: event_category {
    label: "Event Category"

    type: string
    sql: ${TABLE}.event_category ;;
  }

  dimension: event_duration_secs {
    type: number
    sql: ${TABLE}.event_duration_secs ;;
  }

  measure: avg_event_temp_c {
    type: average
    sql: ${TABLE}.event_temp_c ;;
  }

  dimension: event_distance_km {
    type: string
    sql: ${TABLE}.event_distance_km ;;
  }

  measure: avg_event_distance_km {
    type: average
    sql: ${TABLE}.event_distance_km ;;
  }

  measure: total_event_distance_km {
    type: sum
    sql: ${TABLE}.event_distance_km ;;
  }



  dimension: event_site_or_app {
    type: string
    sql: ${TABLE}.event_site_or_app ;;
  }

  dimension: event_heart_rate {
    type: number
    sql: ${TABLE}.event_heart_rate ;;
  }



  dimension: map_locations {
    type: location
    sql_latitude: round(case when cast(${TABLE}.event_lat as float64) > 100 or cast(${TABLE}.event_lat as float64) < 100 then cast(event_lat/10000000 as float64) else cast(${TABLE}.event_lat as float64) end,2);;
    sql_longitude: round(case when cast(${TABLE}.event_long as float64) > 100 or cast(${TABLE}.event_long as float64) < 100 then cast(${TABLE}.event_long/10000000 as float64) else cast(${TABLE}.event_long as float64) end,2) ;;
  }


  dimension: event_address {
    type: string
    sql: ${TABLE}.event_address ;;
  }

  dimension: event_location_name {
    type: string
    sql: ${TABLE}.event_location_name ;;
  }

  dimension: event_country {
    type: string
    sql: ${TABLE}.event_country ;;
  }

  dimension: event_end_lat {
    type: string
    sql: ${TABLE}.event_end_lat ;;
  }

  dimension: event_end_long {
    type: string
    sql: ${TABLE}.event_end_long ;;
  }

  dimension: event_end_address {
    type: string
    sql: ${TABLE}.event_end_address ;;
  }

  dimension: event_end_location_name {
    type: string
    sql: ${TABLE}.event_end_location_name ;;
  }

  dimension: event_end_country {
    type: string
    sql: ${TABLE}.event_end_country ;;
  }

  dimension: apple_music_artist_name {
    type: string
    sql: ${TABLE}.apple_music_artist_name ;;
  }

  dimension: apple_music_album_name {
    type: string
    sql: ${TABLE}.apple_music_album_name ;;
  }

  dimension: steps_count {
    type: string
    sql: ${TABLE}.steps_count ;;
  }

  measure: avg_steps_count {
    type: average
    sql: ${TABLE}.steps_count ;;
  }

  measure: total_steps_count {
    type: sum
    sql: ${TABLE}.steps_count ;;
  }

  dimension: calories_earned_count {
    type: string
    sql: ${TABLE}.calories_earned_count ;;
  }

  dimension: calories_passive_count {
    type: string
    sql: ${TABLE}.calories_passive_count ;;
  }

  dimension: event_spend {
    type: number
    sql: ${TABLE}.event_spend ;;
  }

  dimension: event_spend_currency {
    type: string
    sql: ${TABLE}.event_spend_currency ;;
  }

  dimension: cycling_activity_score {
    type: string
    sql: ${TABLE}.cycling_Activity_Score ;;
  }

  dimension: cycling_gear {
    type: string
    sql: ${TABLE}.cycling_Gear ;;
  }

  dimension: cycling_elv_m {
    type: string
    sql: ${TABLE}.cycling_Elv_m ;;
  }

  dimension: event_elapsed_duration_secs {
    type: number
    sql: ${TABLE}.event_elapsed_duration_secs ;;
  }

  dimension: event_speed_kph {
    type: string
    sql: ${TABLE}.event_speed_kph ;;
  }

  dimension: event_max_speed_kph {
    type: string
    sql: ${TABLE}.event_max_speed_kph ;;
  }

  dimension: cycling_pwr_w {
    type: string
    sql: ${TABLE}.cycling_Pwr_W ;;
  }

  dimension: cycling_max_pwr_w {
    type: string
    sql: ${TABLE}.cycling_Max_Pwr_W ;;
  }

  dimension: cycling_cad {
    type: string
    sql: ${TABLE}.cycling_Cad ;;
  }

  dimension: cycling_energy_kg {
    type: string
    sql: ${TABLE}.cycling_energy_kg ;;
  }

  dimension: cycling_segs {
    type: string
    sql: ${TABLE}.cycling_Segs ;;
  }

  dimension: cycling_prs {
    type: string
    sql: ${TABLE}.cycling_PRs ;;
  }

  dimension: cycling_kudos {
    type: string
    sql: ${TABLE}.cycling_Kudos ;;
  }

  dimension: cycling_intensity_pct {
    type: string
    sql: ${TABLE}.cycling_intensity_pct ;;
  }

  dimension: cycling_training_load {
    type: string
    sql: ${TABLE}.cycling_Training_Load ;;
  }

  dimension: cycling_relative_effort {
    type: string
    sql: ${TABLE}.cycling_Relative_Effort ;;
  }

  dimension: driving_score {
    type: string
    sql: ${TABLE}.driving_score ;;
  }

  dimension: weight_kg {
    type: string
    sql: ${TABLE}.weight_kg ;;
  }

  dimension: weight_chg_pct {
    type: string
    sql: ${TABLE}.weight_chg_pct ;;
  }

  dimension: weight_kg_chg {
    type: string
    sql: ${TABLE}.weight_kg_chg ;;
  }

  dimension: fat_mass_kg {
    type: string
    sql: ${TABLE}.fat_mass_kg ;;
  }

  dimension: body_fat_pct {
    type: string
    sql: ${TABLE}.body_fat_pct ;;
  }

  dimension: bone_mass_kg {
    type: string
    sql: ${TABLE}.bone_mass_kg ;;
  }

  dimension: muscle_mass_kg {
    type: string
    sql: ${TABLE}.muscle_mass_kg ;;
  }

  dimension: water_mass_kg {
    type: string
    sql: ${TABLE}.water_mass_kg ;;
  }

  dimension: locationsemantic_type {
    type: string
    sql: ${TABLE}.locationsemanticType ;;
  }

  dimension: locationplace_id {
    type: string
    sql: ${TABLE}.locationplaceId ;;
  }

  dimension: location_confidence {
    type: number
    sql: ${TABLE}.locationConfidence ;;
  }

  dimension: alternative_place_id {
    type: string
    sql: ${TABLE}.alternative_place_id ;;
  }

  dimension: place_visit_importance {
    type: string
    sql: ${TABLE}.placeVisitImportance ;;
  }

  dimension: place_visit_type {
    type: string
    sql: ${TABLE}.placeVisitType ;;
  }

  dimension: visit_confidence {
    type: number
    sql: ${TABLE}.visitConfidence ;;
  }

  set: detail {
    fields: [
      event_type,
      event_ts,
      event_source,
      event_target,
      event_details,
      event_details_full,
      event_category,
      event_duration_secs,
      event_temp_c,
      event_distance_km,
      event_site_or_app,
      event_heart_rate,
      event_lat,
      event_long,
      event_address,
      event_location_name,
      event_country,
      event_end_lat,
      event_end_long,
      event_end_address,
      event_end_location_name,
      event_end_country,
      apple_music_artist_name,
      apple_music_album_name,
      steps_count,
      calories_earned_count,
      calories_passive_count,
      event_spend,
      event_spend_currency,
      cycling_activity_score,
      cycling_gear,
      cycling_elv_m,
      event_elapsed_duration_secs,
      event_speed_kph,
      event_max_speed_kph,
      cycling_pwr_w,
      cycling_max_pwr_w,
      cycling_cad,
      cycling_energy_kg,
      cycling_segs,
      cycling_prs,
      cycling_kudos,
      cycling_intensity_pct,
      cycling_training_load,
      cycling_relative_effort,
      driving_score,
      weight_kg,
      weight_chg_pct,
      weight_kg_chg,
      fat_mass_kg,
      body_fat_pct,
      bone_mass_kg,
      muscle_mass_kg,
      water_mass_kg,
      locationsemantic_type,
      locationplace_id,
      location_confidence,
      alternative_place_id,
      place_visit_importance,
      place_visit_type,
      visit_confidence
    ]
  }
}
