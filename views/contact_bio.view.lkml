view: contact_bio {
  derived_table: {
    sql:
      select
        contact_pk, contact_bio
      from
        (
        SELECT
        c.contact_pk,
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
        ) as contact_bio
      FROM
        `ra-development.analytics.contacts_dim` c
      left join
        `ra-development.analytics.contact_companies_fact` cc
      on
        c.contact_pk = cc.contact_fk
      and
        contact_next_created_date is null
      left join
        (SELECT
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
) as contact_conversations
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

      )
      where contact_name != contact_brief
      group by 1,2;;
  }

  dimension: contact_pk {
    type: string
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.contact_pk ;;
  }

  dimension: contact_bio {
    group_label: "      Contact Details"

    type: string
    sql: ${TABLE}.contact_bio ;;
  }
  }
