view: recruiting_job_applications_fact {
  sql_table_name: `ra-development.analytics.recruiting_job_applications_fact` ;;

  dimension: application_stage_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.application_stage_fk ;;
  }
  dimension: candidate_match_to_requirements {
    type: string
    sql: coalesce(${TABLE}.candidate_match_to_requirements,'Low') ;;
  }
  dimension: candidate_pitch {
    hidden: yes

    type: string
    sql: ${TABLE}.candidate_pitch ;;
  }
  dimension: contact_fk {
    hidden: yes

    type: string
    sql: ${TABLE}.contact_fk ;;
  }
  dimension: contact_linkedin_url {
    hidden: yes

    type: string
    sql: ${TABLE}.contact_linkedin_url ;;
  }
  dimension: contact_original_resume {
    hidden: yes

    type: string
    sql: ${TABLE}.contact_original_resume ;;
  }
  dimension: contact_referred {
    hidden: yes

    type: yesno
    sql: ${TABLE}.contact_referred ;;
  }
  dimension: contact_referring_site {
    hidden: yes

    type: string
    sql: ${TABLE}.contact_referring_site ;;
  }
  dimension: contact_resume {
    hidden: yes

    type: string
    sql: ${TABLE}.contact_resume ;;
  }
  dimension: contact_sourced {
    hidden: yes

    type: yesno
    sql: ${TABLE}.contact_sourced ;;
  }
  dimension: contact_tags {
    hidden: yes

    type: string
    sql: ${TABLE}.contact_tags ;;
  }
  dimension: job_application_cover_letter {
    type: string
    sql: ${TABLE}.job_application_cover_letter ;;
  }
  dimension_group: job_application_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.job_application_created_date ;;
  }
  dimension: job_application_id {
    hidden: yes

    type: string
    sql: ${TABLE}.job_application_id ;;
  }
  dimension_group: job_application_latest_review {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.job_application_latest_review_date ;;
  }
  dimension: job_application_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.job_application_pk ;;
  }
  dimension: job_application_questions {
    hidden: yes

    type: string
    sql: ${TABLE}.job_application_questions ;;
  }
  dimension: job_application_referring_site {
    type: string
    sql: ${TABLE}.job_application_referring_site ;;
  }
  dimension: job_application_referring_url {
    type: string
    sql: ${TABLE}.job_application_referring_url ;;
  }
  dimension_group: job_application_rejected {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.job_application_rejected_date ;;
  }
  dimension: job_application_sourced {
    type: yesno
    sql: ${TABLE}.job_application_sourced ;;
  }
  dimension: job_fk {
    hidden: yes

    type: string
    sql: ${TABLE}.job_fk ;;
  }
  dimension: job_pitch {
    hidden: yes

    type: string
    sql: ${TABLE}.job_pitch ;;
  }
  dimension: job_resume_requirement {
    hidden: yes

    type: string
    sql: ${TABLE}.job_resume_requirement ;;
  }

  dimension: prompt {
    hidden: yes

    type: string
    sql: ${TABLE}.prompt ;;
  }
  dimension: rejection_by_company {
    type: yesno
    sql: ${TABLE}.rejection_by_company ;;
  }
  dimension: rejection_reason {
    type: string
    sql: ${TABLE}.rejection_reason ;;
  }
  measure: application_count {
    type: count_distinct
    sql: ${job_application_pk} ;;

  }
}
