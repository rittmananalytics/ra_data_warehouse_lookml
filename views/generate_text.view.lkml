view: patent_summary {
  derived_table: {
    sql:
      with contact_conversations as (
          SELECT
            *
          FROM
            (SELECT
            conversation_from_contact_name as contact_name,
            substr(string_agg(distinct s.conversation_subject),1,500) as contact_conversation_subjects
          FROM
            `ra-development.analytics.conversations_fact` s


          GROUP BY 1
          )
        GROUP BY
        1,2
      ),
      contact_profile as (SELECT
        c.contact_pk,
        c.contact_name,
        d.company_name,
        d.company_lifecycle_stage,
        d.ideal_customer_group,
        concat(c.contact_name,
        coalesce(case when contact_bio is not null then concat(' who is a ', contact_bio ) end, '')   ,
        coalesce(case when d.company_name is not null then concat(' who works at ', d.company_name ) end, ''),
        coalesce(case when d.company_linkedin_bio is not null then concat(' described as "',d.company_linkedin_bio,'"') end, ''),
        coalesce(case when d.company_lifecycle_stage  is not null then concat(' whose company sales lifecycle stage with us is "',d.company_lifecycle_stage ,'"') end, ''),

        coalesce(case when d.ideal_customer_group is not null then concat(' in the ICP segment "',d.ideal_customer_group,'"') end, ''),
        coalesce(case when d.company_industry is not null then concat(' whose company vertical market is "',d.company_industry,'"') end, ''),

        coalesce(case when d.original_buyer_role is not null then concat(' and had the job role of "',d.original_buyer_role,'"') end, ''),
      coalesce(case when d.original_service is not null then concat(' and enquired about our "',d.original_service,'" consulting service package') end, ''),
        coalesce(case when d.original_buyer_requirement is not null then concat(' with the initial challenge of "',d.original_buyer_requirement,'"') end, ''),
        coalesce(case when count(distinct f.contract_pk) over (partition by f.contact_fk) >0 then concat(' has signed ', count(distinct f.contract_pk) over (partition by f.contact_fk), ' contracts including "',max(f.contract_name) over (partition by f.contact_fk),'"' ) end, ''),
        coalesce(case when contact_conversion_event_name is not null then concat(' arrived via  ', contact_conversion_event_name) end, ''),
        coalesce(case when (all_job_titles)[safe_offset(0)] is not null then concat(' has the job title ', (all_job_titles)[safe_offset(0)]) end, ''),
        coalesce(case when contact_crm_lifecycle_stage is not null and contact_crm_lifecycle_stage != 'other' then concat(' has the CRM lifecycle stage of ', contact_crm_lifecycle_stage) end, ''),
        coalesce(case when contact_first_url is not null then concat(' discovered us by reading ', contact_first_url) end, '') ,
        coalesce(case when contact_first_referrer is not null then concat(' first visited our website via ', contact_first_referrer) end, ''),
        coalesce(case when is_dbt_slack_member  then concat(' subscribes to the dbt slack channels ', replace(array_to_string(all_dbt_slack_channels,', '),'#','')) end,'') ,
        coalesce(case when is_project_interactor then ' is part of the client project team ' end,''),
        coalesce(case when s.contact_conversation_subjects is not null then concat(' has contacted us about "',substr(s.contact_conversation_subjects,1,50)) end,''),
        coalesce(case when contact_calendly_answer_2 is not null then concat(' is interested in ', contact_calendly_answer_2) end, ''),

        coalesce(case when contact_zoom_webinar_attendance_average_duration is not null then concat(' and attended one of our webinars for total minutes of ', contact_zoom_webinar_attendance_average_duration) end, ''),
        coalesce(case when contact_zoom_webinar_attendance_count is not null then concat(' and attended ', contact_zoom_webinar_attendance_count, ' webinars') end, ''),
        coalesce(case when sum(contact_recent_deal_amount) over (partition by contact_pk) >0 then concat(' has been associated with ', sum(contact_recent_deal_amount) over (partition by contact_pk),' of sales opportunities ') end , ''),

        coalesce(case when contact_last_nps_follow_up is not null then concat(' and gave us the client feedback of ', contact_last_nps_follow_up) end, ''),
        coalesce(case when contact_calendly_answer_1 is not null then concat(' and gave his brief as  ', contact_calendly_answer_1) end, '') ,
        coalesce(case when contact_last_url is not null then concat(' and was last reading ', contact_last_url) end, '')
        ) as contact_brief
      FROM
        `ra-development.analytics.contacts_dim` c
      left join
        `ra-development.analytics.contact_companies_fact` cc
      on
        c.contact_pk = cc.contact_fk
      and
        contact_next_created_date is null
      left join
        contact_conversations s
      on
        c.contact_name = s.contact_name
      left join
        `ra-development.analytics.companies_dim` d
      on
        cc.company_fk = d.company_pk
      left  join
        `ra-development.analytics.contracts_fact` f
      on
        c.contact_name = f.contact_name
        and  f.contract_status = 'Completed'

      ),
        contact_profiles_deduped as (
      select
        contact_pk, contact_name,   company_lifecycle_stage,
      contact_brief, company_name, ideal_customer_group
      from
        contact_profile
      where contact_name != contact_brief

      group by 1,2,3,4,5,6),
      predictions as (
      SELECT
        contact_pk,
        contact_name,
        contact_brief,
        company_name,
        ideal_customer_group,
        ml_generate_text_result['predictions'][0]['content'] AS predicted_decision_maker_type,
        ml_generate_text_status as prediction_status,
      FROM
        ML.GENERATE_TEXT(
          MODEL `analytics_ai.bison_model`,
          (
            SELECT
              CONCAT('Classify this person as either High, Medium or Low probability of being a budget-holding decision maker (with the person having given us details of the project they would like us to deliver or the person having signed previous contracts being an indicator of High, whilst evidence of subscribing to dbt slack channels or participation in a project indicating Low. Also predict their categories of consulting services interest from the list "Operational Reporting", "Marketing Analytics", "Data Centralization", "Product Analytics", "Marketing Attribution" or "Unknown", separating multiple categories if predicted for a contact using commas, and then predict the category of organization or company that the person works for from Startup, SMB, Mid-Market, Enterprise. Give me the rationale your categorisations ensuring any PII is obfuscated in that rationale and do not return any words or comments apart from these three sets of categorisations and rationale. Your response should be in the form of a single line of text that separates each categorisation for the person using a colon, for example: High:Marketing Analytics,Product Analytics:SMB:Signed statement of work contracts before and has contacted about operational reporting related topics. Text:',contact_name,'"',contact_brief,'"') AS prompt,
              *
            FROM
              contact_profiles_deduped
            order by
              length(contact_brief) desc
            limit 25
          ),
          STRUCT(
            0.4 AS temperature,
            1000 AS max_output_tokens))
      )
      select
        contact_pk,
        contact_name,
        contact_brief,
        split(string(predictions.predicted_decision_maker_type),':')[safe_offset(0)] as decision_maker_rating,
        split(string(predictions.predicted_decision_maker_type),':')[safe_offset(1)] as predicted_interest,
        split(string(predictions.predicted_decision_maker_type),':')[safe_offset(2)] as predicted_company_size,
        split(string(predictions.predicted_decision_maker_type),':')[safe_offset(3)] as rationale,
        coalesce(trim(prediction_status),'OK') as prediction_status
      from predictions




    SELECT
      publication_number
      , abstract_text
      , ml_generate_text_result
    FROM ML.GENERATE_TEXT(
        MODEL `@{big_query_model_name}`,
        ( SELECT
            publication_number
            , abstract_localized[SAFE_OFFSET(0)].text AS abstract_text
            , CONCAT(
              {% parameter prompt_input %}
              , '"""'
              , 'Abtract Text: '
              , abstract_localized[SAFE_OFFSET(0)].text
              , '"""'
              ,'Summary: '
              ) AS prompt
          FROM `patents-public-data.patents.publications` TABLESAMPLE SYSTEM (0.5 PERCENT)
          WHERE country_code = 'US'
          AND abstract_localized[SAFE_OFFSET(0)].text IS NOT NULL
          AND publication_date > 20230101
        ),
        STRUCT(
          65 AS max_output_tokens -- 1.3 average tokens per word, therefore summary will be approximately 50 words max
          , 0.5 AS temperature
          , 15 AS top_k
          , 0.9 AS top_p
        )
    )
    ;;
    datagroup_trigger: patent_publications_no_update
  }

  # update prompt here to change generate text output results
  parameter: prompt_input {
    hidden: yes
    default_value: "Please create a summary using simple terms for this patent information based on the following Abstract Text:"
  }

  dimension: publication_number {
    type: string
    description: "Patent publication number (DOCDB compatible), eg: 'US-7650331-B1'"
    sql: ${TABLE}.publication_number ;;
    hidden: yes
  }

  dimension: abstract_text {
    type: string
    sql:  ${TABLE}.abstract_localized[SAFE_OFFSET(0)].text ;;
    html:<div style="white-space:pre">{{value}}</div>;;
    group_label: "Text"
    hidden: yes
  }

  dimension: claims_text {
    type: string
    sql:  ${TABLE}.claims_localized[SAFE_OFFSET(0)].text ;;
    html:<div style="white-space:pre">{{value}}</div>;;
    group_label: "Text"
    hidden: yes
  }

  dimension:  text_result {
    type: string
    sql:  JSON_VALUE(${TABLE}.ml_generate_text_result, '$.predictions[0].content') ;;
    html:<div style="white-space:pre">{{value}}</div>;;
    label: "Generate Text Result"
    view_label: "Publications"
    group_label: "Text"
  }

  dimension:  blocked {
    type: string
    sql:  JSON_VALUE(${TABLE}.ml_generate_text_result, '$.predictions[0].safetyAttributes.blocked') ;;
    html:<div style="white-space:pre">{{value}}</div>;;
    view_label: "Publications"
    group_label: "Generate Text"
    hidden: yes
  }

  dimension:  categories {
    type: string
    sql:  ARRAY_TO_STRING(JSON_VALUE_ARRAY(${TABLE}.ml_generate_text_result, '$.predictions[0].safetyAttributes.categories'), ', ') ;;
    html:<div style="white-space:pre">{{value}}</div>;;
    view_label: "Publications"
    group_label: "Generate Text"
    hidden: yes
  }

  dimension:  scores {
    type: string
    sql:  ARRAY_TO_STRING(JSON_VALUE_ARRAY(${TABLE}.ml_generate_text_result, '$.predictions[0].safetyAttributes.scores'), ', ') ;;
    html:<div style="white-space:pre">{{value}}</div>;;
    view_label: "Publications"
    group_label: "Generate Text"
    hidden: yes
  }
}
