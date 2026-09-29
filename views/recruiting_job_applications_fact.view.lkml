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

  dimension: application_source {
    group_label: "Recruitment"
    description: "Where the application came from, grouped from Teamtailor's referring site. 'Added by recruiter' is a candidate sourced into Teamtailor rather than an application. 'Direct or unknown' has no referring site: typed-in visits, shared links and some careers-site applications."
    type: string
    sql: case when ${TABLE}.job_application_sourced then 'Added by recruiter'
      when ${TABLE}.job_application_referring_site = 'LinkedIn' then 'LinkedIn'
      when lower(${TABLE}.job_application_referring_site) like 'indeed%' then 'Indeed'
      when lower(${TABLE}.job_application_referring_site) like 'google%' then 'Google'
      when lower(${TABLE}.job_application_referring_site) in ('rittmananalytics.com','www.rittmananalytics.com') then 'Company website'
      when lower(${TABLE}.job_application_referring_site) = 'new_job' then 'Job alert email'
      when regexp_contains(lower(${TABLE}.job_application_referring_site), r'studentcircus|jobradars|jooble') then 'Other job boards'
      when ${TABLE}.job_application_referring_site is null then 'Direct or unknown'
      else 'Other' end ;;
  }

  dimension: is_candidate_application {
    group_label: "Recruitment"
    description: "Yes if the candidate applied themselves; No if a recruiter added them to Teamtailor."
    type: yesno
    sql: not coalesce(${TABLE}.job_application_sourced, false) ;;
  }

  measure: total_applications {
    group_label: "Recruitment"
    description: "Applications made by candidates, from Teamtailor. Excludes candidates added by a recruiter."
    type: count_distinct
    value_format_name: decimal_0
    sql: ${job_application_pk} ;;
    filters: [is_candidate_application: "Yes"]
  }

  measure: total_recruiter_added_candidates {
    group_label: "Recruitment"
    description: "Candidates added to a job in Teamtailor by a recruiter, rather than applying."
    type: count_distinct
    value_format_name: decimal_0
    sql: ${job_application_pk} ;;
    filters: [is_candidate_application: "No"]
  }
}
