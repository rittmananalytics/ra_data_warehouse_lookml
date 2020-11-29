view: delivery_task_history {
  derived_table: {
    sql: with source as (select * from (
       select *,
      MAX(_sdc_sequence) OVER (PARTITION BY issueid ORDER BY _sdc_sequence RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS max_sdc_sequence
      from `ra-development.stitch_jira.issue_transitions`
    )
    where _sdc_sequence = max_sdc_sequence),
    issue_transition_history as (SELECT concat('jira-',issueid) as issue_id, t.name as from_status,
      t.to.name as to_status,
      _sdc_received_at as transition_ts
      FROM
      source t),
            issues as (select task_id, task_start_ts, task_status
                       from `ra-development.analytics_staging.stg_jira_projects_tasks`),
      issue_history_pivoted as (
      select task_id,
             task_start_ts as start_ts,
             last_value(i.task_status) over (partition by task_id order by transition_ts) as task_status,
             case when to_status = 'Design & Validation' then transition_ts end as design_ts,
             case when to_status = 'In Progress' then transition_ts end as in_progress_ts,
             case when to_status = 'Blocked' then transition_ts end as blocked_ts,
             case when to_status = 'In QA' then transition_ts end as in_qa_ts,
             case when to_status = 'Add to Looker' then transition_ts end as looker_ts,
             case when to_status = 'In Client QA' then transition_ts end as in_client_qa_ts,
             case when to_status = 'Done' then transition_ts end as done_ts
      from issue_transition_history h
      join issues i
      on h.issue_id = i.task_id
      ),
      task_latest_history_pivoted as (
      select task_id,
        task_status,
        max(start_ts) over (partition by task_id) as start_ts,
        max(design_ts) over (partition by task_id) as design_ts,
        max(in_progress_ts) over (partition by task_id) as in_progress_ts,
        max(blocked_ts) over (partition by task_id) as blocked_ts,
        max(in_qa_ts) over (partition by task_id) as in_qa_ts,
        max(looker_ts) over (partition by task_id) as looker_ts,
        max(in_client_qa_ts) over (partition by task_id) as in_client_qa_ts,
        max(done_ts) over (partition by task_id) as done_ts
      from issue_history_pivoted
      ),
      task_latest_history_pivoted_deduped as (
      select * from task_latest_history_pivoted
      group by 1,2,3,4,5,6,7,8,9,10
      )
      select *,
             timestamp_diff(design_ts,start_ts,HOUR)/24 as hours_from_start_to_design,
             case when task_status != 'Design & Validation' then greatest(timestamp_diff(in_progress_ts,start_ts,HOUR),timestamp_diff(design_ts,start_ts,HOUR))/24 end as hours_from_start_to_in_progress,
             case when task_status not in ('Design & Validation','In Progress','Blocked') then greatest(timestamp_diff(in_qa_ts,start_ts,HOUR),timestamp_diff(in_progress_ts,start_ts,HOUR),timestamp_diff(design_ts,start_ts,HOUR))/24 end as hours_from_start_to_in_qa,
             case when task_status not in ('Design & Validation','In Progress','Blocked','Add to Looker') then greatest(timestamp_diff(in_client_qa_ts,start_ts,HOUR),timestamp_diff(in_qa_ts,start_ts,HOUR),timestamp_diff(in_progress_ts,start_ts,HOUR))/24 end as hours_from_start_to_in_client_qa,
             case when task_status = 'Done' then greatest(timestamp_diff(in_client_qa_ts,start_ts,HOUR),timestamp_diff(in_qa_ts,start_ts,HOUR),timestamp_diff(in_progress_ts,start_ts,HOUR),timestamp_diff(looker_ts,start_ts,HOUR),timestamp_diff(done_ts,start_ts,HOUR))/24 end as hours_from_start_to_done,
             case when task_status not in ('Design & Validation','In Progress','Blocked','In QA') then greatest(timestamp_diff(in_client_qa_ts,start_ts,HOUR),timestamp_diff(in_qa_ts,start_ts,HOUR),timestamp_diff(in_progress_ts,start_ts,HOUR),timestamp_diff(looker_ts,start_ts,HOUR))/24 end as hours_from_start_to_looker,
             case when task_status not in ('Design & Validation','In Progress') then greatest(timestamp_diff(design_ts,start_ts,HOUR),timestamp_diff(in_progress_ts,start_ts,HOUR),timestamp_diff(design_ts,start_ts,HOUR),timestamp_diff(blocked_ts,start_ts,HOUR))/24 end as hours_from_start_to_blocked,
             timestamp_diff(in_progress_ts,design_ts,HOUR) as hours_from_design_to_in_progress,
             timestamp_diff(in_qa_ts,in_progress_ts,HOUR) as hours_from_in_progress_to_qa,
             timestamp_diff(looker_ts,in_qa_ts,HOUR) as hours_from_qa_to_looker,
             timestamp_diff(in_client_qa_ts,looker_ts,HOUR) as hours_from_looker_to_client_qa,
             timestamp_diff(done_ts,in_client_qa_ts,HOUR) as hours_from_client_qa_to_done,
             timestamp_diff(in_client_qa_ts,design_ts,HOUR) as hours_from_design_to_client_qa,

             timestamp_diff(design_ts,done_ts,HOUR) as hours_from_design_to_done
      from task_latest_history_pivoted_deduped
      group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24
       ;;
  }



  dimension: task_id {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.task_id ;;
  }

  dimension_group: start_ts {
    group_label: "Task Stages"
    timeframes: [time]

    type: time
    sql: ${TABLE}.start_ts ;;
  }

  dimension_group: design_ts {
    group_label: "Task Stages"
    timeframes: [time]

    type: time
    sql: ${TABLE}.design_ts ;;
  }

  dimension_group: in_progress_ts {
    group_label: "Task Stages"
    timeframes: [time]

    type: time
    sql: ${TABLE}.in_progress_ts ;;
  }

  dimension_group: blocked_ts {
    group_label: "Task Stages"
    timeframes: [time]

    type: time
    sql: ${TABLE}.blocked_ts ;;
  }

  dimension_group: in_qa_ts {
    group_label: "Task Stages"
    timeframes: [time]

    type: time
    sql: ${TABLE}.in_qa_ts ;;
  }

  dimension_group: looker_ts {
    group_label: "Task Stages"
    timeframes: [time]

    type: time
    sql: ${TABLE}.looker_ts ;;
  }

  dimension_group: in_client_qa_ts {
    group_label: "Task Stages"
    timeframes: [time]

    type: time
    sql: ${TABLE}.in_client_qa_ts ;;
  }

  dimension_group: done_ts {
    group_label: "Task Stages"
    timeframes: [time]
    type: time
    sql: ${TABLE}.done_ts ;;
  }

  measure: avg_days_from_start_to_design {
    group_label: "Task Metrics"
    label: "Days to Design"
    value_format_name: decimal_0
    type: average
    sql: ${TABLE}.hours_from_start_to_design ;;
  }

  measure: avg_days_from_start_to_in_progress {
    group_label: "Task Metrics"
    label: "Days to In Progress"
    value_format_name: decimal_0

    type: average
    sql: ${TABLE}.hours_from_start_to_in_progress ;;
  }

  measure: avg_days_from_start_to_in_qa {
    group_label: "Task Metrics"
    label: "Days to QA"
    value_format_name: decimal_0

    type: average
    sql: ${TABLE}.hours_from_start_to_in_qa ;;
  }

  measure: avg_days_from_start_to_in_client_qa {
    group_label: "Task Metrics"
    label: "Days to Client QA"
    value_format_name: decimal_0

    type: average
    sql: ${TABLE}.hours_from_start_to_in_client_qa ;;
  }

  measure: avg_days_from_start_to_looker {
    group_label: "Task Metrics"
    label: "Days to Looker"
    value_format_name: decimal_0

    type: average
    sql: ${TABLE}.hours_from_start_to_looker ;;
  }

  measure: avg_days_from_start_to_blocked {
    group_label: "Task Metrics"
    label: "Days to Blocked"
    value_format_name: decimal_0

    type: average
    sql: ${TABLE}.hours_from_start_to_blocked ;;
  }

  measure: avg_days_from_start_to_done {
    group_label: "Task Metrics"
    label: "Days to Done"
    value_format_name: decimal_0

    type: average
    sql: ${TABLE}.hours_from_start_to_done ;;
  }








}
